#ゼロレジスタの用意
XOR	r0, r0,	r0
#変数mの初期化
ADDI	r10,	r0,	0
#スタックポインタの初期化
ADDI	r29,	r0,	1024

#32bit定数の用意
ADDI	r15,	r0,	512
#static x
LUI		r14,	1883
ORI	r14,	r14,	52501
SW	r14,	0(r15)
#static y
LUI		r14,	5530
ORI	r14,	r14,	21989
SW	r14,	4(r15)
#static z
LUI		r14,	7954
ORI	r14,	r14,	15285
SW	r14,	8(r15)
#static w
LUI		r14,	1353
ORI	r14,	r14,	4915
SW	r14,	12(r15)
#static mul16(0x7fff)
LUI		r14,	16383
ORI	r14,	r14,	1
SW	r14,	16(r15)

#i = 0の変換
ADDI	r8,	r0,	0
#iの上限となる定数
ADDI	r24,	r0,	400

FOR0S:						#for (i = 0; i < 400; i++)
#i < 400（400 <= i）の変換
BLE	r24,	r8,	FOR0E

#forブロック内
#Xorshiftと呼ばれる方法を、関数xor128として使い、乱数を生成
JAL	_xor128
ADD	r16,	r0,	r2
SRL	r14,	r16,	16
ANDI	r17,	r14,	65535
ANDI	r18,	r16,	65535

#オーバーフロー防止のため2でわる
SRL	r17,	r17,	1
SRL	r18,	r18,	1

#2乗を関数powで計算
#pow(x)
ADD	r4,	r0,	r17
SW	r8,	0(r29)
#スタックポインタの引き算（定数ではビットが足りないことに注意）
ADDI	r14,	r0,	4
SUB	r29,	r29,	r14
JAL	_pow
ADDI	r29,	r29,	4
LW	r8,	0(r29)
ADD	r17,	r0,	r2

#pow(y)
ADD	r4,	r0,	r18
SW	r8,	0(r29)
ADDI	r14,	r0,	4
SUB	r29,	r29,	r14
JAL	_pow
ADDI	r29,	r29,	4
LW	r8,	0(r29)
ADD	r17,	r2,	r17

#mul16(0x7fff)のロード
ADDI	r15,	r0,	528
LW	r18,	0(r15)
BLE	r18,	r17,	IF0E		#if (mul16(x) + mul16(y) <= mul16(0x7fff))

#ifブロック内
ADDI	r10,	r10,	1

IF0E:
#i++の変換
ADDI	r8,	r8,	1
J	FOR0S

FOR0E:
#変数xの再利用
ADDI	r17,	r0,	0

#iを負の数として扱えないので、アセンブリではすべて1を加算して扱うものとする
#i = 7[+1]の変換
ADDI	r8,	r0,	8
#iの下限となる定数
ADDI	r24,	r0,	0

#mを16進数で表現する10進数として出力
FOR1S:						#(i = 7[+1]; i[+1] >= 0; i--)
#i[+1] >= 0（i <= 0）の変換
BLE	r8,	r0,	FOR1E

#forブロック内
#変数yの再利用
ADDI	r18,	r0,	1

#j = 0の変換
ADDI	r9,	r0,	0

FOR2S:						#for (j = 0; j < i[+1]; j++)
#j < i[+1]（i <= (j + 1)）の変換
ADDI	r14,	r9,	1
BLE	r8,	r14,	FOR2E

#forブロック内
SLL	r14,	r18,	3
SLL	r18,	r18,	1
ADD	r18,	r14,	r18

#j++の変換
ADDI	r9,	r9,	1
J	FOR2S

FOR2E:
SLL	r17,	r17,	4

WHILE0S:					#while (m >= y)
#m >= y（m < y）の変換
BLT	r10,	r18,	WHILE0E

#whileブロック内
SUB	r10,	r10,	r18
ADDI	r17,	r17,	1

J	WHILE0S

WHILE0E:
#i[+1]--の変換
ADDI	r14,	r0,	1
SUB	r8,	r8,	r14
J	FOR1S

FOR1E:
#return x（mul16(0x7fff)の隣に書き込み）
ADDI	r15,	r0,	528
SW	r17,	4(r15)
J	END

_pow:						#int pow(int a)
#変数sumの初期化
ADDI,	r2,	r0,	0
#bit = 0x8000の変換
ORI	r8,	r0,	32768

FORPS:						#for (bit = 0x8000; bit; bit = bit >> 1)
#bit（bit != 0）の変換
BEQ	r0,	r8,	FORPE

#forブロック内
SLL	r2,	r2,	1

AND	r14,	r4,	r8
BEQ	r0,	r14,	IFPE		#if (a16 & bit)

#ifブロック内
ADD	r2,	r2,	r4

IFPE:
#bit = bit >> 1の変換
SRL	r8,	r8,	1
J	FORPS

FORPE:
#return sum
JR	r31

_xor128:					#int xor128()
#_xの読みこみ
ADDI	r15,	r0,	512
LW	r14,	0(r15)
#x ^ (x << 11)の計算
SLL	r11,	r14,	11
XOR	r11,	r11,	r14
#_yの読み込み、_xへの書き込み（_xの次の行であることに注意、以下定数以外繰り返し）
LW	r14,	4(r15)
SW	r14,	0(r15)
LW	r14,	8(r15)
SW	r14,	4(r15)
LW	r14,	12(r15)
SW	r14,	8(r15)

#(w ^ (w >> 19))の計算
SRL	r2,	r14,	19
XOR	r14,	r2,	r14
#(t ^ (t >> 8))
SRL	r2,	r11,	8
XOR	r11,	r11,	r2
XOR r2,	r11,	r14
SW	r2,	12(r15)

#return w
JR	r31

END:
HALT
