#ゼロレジスタの用意
XOR	r0, r0,	r0

#変数iの用意
ADDI	r8,	r0,	0

#要素を100個持つ配列変数flagを用意
#配列変数flagのアドレスを初期化
ADDI	r10,	r0,	512

#配列変数flagの要素を初期化する定数
ADDI	r14,	r0,	1

#i = 0の変換
ADDI	r8,	r0,	0
#iの上限となる定数
ADDI	r24,	r0,	400

#flagの全要素を1（true）に初期化
FOR0S:					#for (i = 0; i < 100; i++)
#i < 100（100 <= i）の変換
BLE	r24,	r8,	FOR0E

#forブロック内
ADD	r15,	r8,	r10
SW	r14,	0(r15)

#i++の変換
ADDI	r8,	r8,	4
J	FOR0S

FOR0E:
#flag[0]とflag[1]に0を代入
SW	r0,	0(r10)
SW	r0,	4(r10)

#判定用の変数divを用意して1ずつ加算、flag[divのi（ > 1）倍]に0を代入
#div = 2の変換
ADDI	r9,	r0,	2
#divの上限となる定数
ADDI	r25,	r0,	51

FOR1S:					#for (div = 2; div < 51; div++)
#divが50を超えた場合は判定終了
#div < 51（51 <= div）の変換
BLE	r25,	r9,	FOR1E

#divのforブロック内
#シフト演算で4倍
SLL	r14,	r9,	2
ADD	r15,	r10,	r14
LW	r11,	0(r15)
BNE	r0,	r11,	IF0E	#if (flag[div] == 0)

#ifブロック内
ADDI	r9,	r9,	1
J	FOR1S

IF0E:
#i = div * 2の変換（アドレスのためさらに4倍）
SLL	r14,	r9,	3
ADD	r8,	r0,	r14
#iの上限となる定数
ADDI	r24,	r0,	400

FOR2S:					#for (i = div * 2; i < 100; i = i + div)
#i < 100（100 <= i）の変換
BLE	r24,	r8,	FOR2E

#forブロック内
ADD	r15,	r8,	r10
SW	r0,	0(r15)

#i = i + divの変換（アドレスのため4倍）
SLL	r14,	r9,	2
ADD	r8,	r8,	r14
J	FOR2S

FOR2E:
#div++の変換
ADDI	r9,	r9,	1
J	FOR1S

FOR1E:
#素数をメモリに保存
#i = 0の変換
ADDI	r8,	r0,	8
#iの上限となる定数
ADDI	r24,	r0,	400

FOR3S:					#for (i = 2; i < 100; i++)
#i < 100（100 <= i）の変換
BLE	r24,	r8,	FOR3E

#iのforブロック内
ADD	r15,	r8,	r10
LW	r11,	0(r15)
BEQ	r0,	r11,	IF1E	#if (flag[div] != 0)

#ifブロック内
#シフト演算で1/4
SRA	r14,	r8,	2
ADD	r15,	r8,	r10
SW	r14,	0(r15)

IF1E:

#i++の変換
ADDI	r8,	r8,	4
J	FOR3S

FOR3E:
HALT
