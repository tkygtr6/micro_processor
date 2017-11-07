#0の準備
XOR	r0,	r0,	r0
#n[0]のアドレスを初期化
ADDI	r11,	r0,	512
#n[0],n[1]の準備と保存
ADDI	r8,	r0,	0
SW	r8,	0(r11)
ADDI	r9,	r0,	1
SW	r9,	4(r11)
#n[2]の計算と保存
ADD	r10,	r8,	r9
SW	r10,	8(r11)

#n[3]の計算と保存（以下定数以外繰り返し）
#n[i+1],n[i]の準備
LW	r8,	4(r11)
LW	r9,	8(r11)
#n[i+2]の計算と保存
ADD	r10,	r8,	r9
SW	r10,	12(r11)
LW	r8,	8(r11)
LW	r9,	12(r11)
ADD	r10,	r8,	r9
SW	r10,	16(r11)
LW	r8,	12(r11)
LW	r9,	16(r11)
ADD	r10,	r8,	r9
SW	r10,	20(r11)
LW	r8,	16(r11)
LW	r9,	20(r11)
ADD	r10,	r8,	r9
SW	r10,	24(r11)
LW	r8,	20(r11)
LW	r9,	24(r11)
ADD	r10,	r8,	r9
SW	r10,	28(r11)
LW	r8,	24(r11)
LW	r9,	28(r11)
ADD	r10,	r8,	r9
SW	r10,	32(r11)
LW	r8,	28(r11)
LW	r9,	32(r11)
ADD	r10,	r8,	r9
SW	r10,	36(r11)
LW	r8,	32(r11)
LW	r9,	36(r11)
ADD	r10,	r8,	r9
SW	r10,	40(r11)
LW	r8,	36(r11)
LW	r9,	40(r11)
ADD	r10,	r8,	r9
SW	r10,	44(r11)
LW	r8,	40(r11)
LW	r9,	44(r11)
ADD	r10,	r8,	r9
SW	r10,	48(r11)
LW	r8,	44(r11)
LW	r9,	48(r11)
ADD	r10,	r8,	r9
SW	r10,	52(r11)
LW	r8,	48(r11)
LW	r9,	52(r11)
ADD	r10,	r8,	r9
SW	r10,	56(r11)
LW	r8,	52(r11)
LW	r9,	56(r11)
ADD	r10,	r8,	r9
SW	r10,	60(r11)
#n[16]の計算と保存
LW	r8,	56(r11)
LW	r9,	60(r11)
ADD	r10,	r8,	r9
SW	r10,	64(r11)
HALT
