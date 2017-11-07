#0の準備
XOR	r0,	r0,	r0
#1項めの計算
ADDI	r8,	r0,	1
ADD	r9,	r0,	r8
#2項めの計算（以下繰り返し）
ADDI	r8,	r8,	1
ADD	r9,	r8,	r9
ADDI	r8,	r8,	1
ADD	r9,	r8,	r9
ADDI	r8,	r8,	1
ADD	r9,	r8,	r9
ADDI	r8,	r8,	1
ADD	r9,	r8,	r9
ADDI	r8,	r8,	1
ADD	r9,	r8,	r9
ADDI	r8,	r8,	1
ADD	r9,	r8,	r9
ADDI	r8,	r8,	1
ADD	r9,	r8,	r9
ADDI	r8,	r8,	1
ADD	r9,	r8,	r9
#10項めの計算
ADDI	r8,	r8,	1
ADD	r9,	r8,	r9
HALT
