main:	lw $a0, 0($t0)			
begin:	addi $t0, $zero, 0		# beginning
	addi $t1, $zero, 1
loop:	slt $t2, $a0, $t1		# top of loop
	bne $t2, $zero, finish
	add $t0, $t0, $t1
	addi $t1, $t1, 2
	j loop				# bottom of loop
finish:	add $v0, $t0, $zero
