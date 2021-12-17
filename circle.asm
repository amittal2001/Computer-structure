	add $t0, $zero, $zero, $zero, 0, 4096					# $t0 = &radios
	lw $s0, $t0, $zero, $zero, 0, 0		    				# $s0 = radios
	mac $s0, $s0, $s0, $zero, 0, 0							# $s0 = radios^2
	add $a0, $zero, $zero, $zero, 0, 255					# i = 255
	add $a1, $zero, $zero, $zero, 0, 255					# j = 255
LOOP1:
	add $a1, $zero, $zero, $zero, 0, 255					# j = 255
	LOOP2:
		mac $t0, $a1, $a1, $zero, 0, 0						# $t0 = i^2
		mac $t1, $a0, $a0, $zero, 0, 0						# $t1 = j^2
		add $s1, $t0, $t1, $zero, 0, 0						# $s1 = i^2 + j^2 
		blt $zero, $s1, $s0, $zero, 0, print				# jump to print if i^2 + j^2 < radios^2
		add $a1, $a1, $zero, $zero, 0, -1					# j--
		bne $zero, $a1, $zero, $zero, 0, LOOP2				# jump to LOOP2
	add $a0, $a0, $zero, $zero, 0, -1						# i--
	bne $zero, $a0, $zero, $zero, 0, LOOP1					# jump to LOOP1
	halt $zero, $zero, $zero, $zero, 0, 0					# halt
	
print:
	add $sp, $sp, $zero, $zero, 0, -4						# adjust stack for 3 items
	sw $zero, $sp, $zero, $s0, 0, 3							# save $s0
	sw $zero, $sp, $zero, $s1, 0, 2							# save $s0
	sw $zero, $sp, $zero, $a0, 0, 1							# save argument
	sw $zero, $sp, $zero, $a1, 0, 0							# save argument
	add $t1, $zero, $zero, $zero, 0, 255					# $t1 = 255
	mac $t0, $a0, $t1, $zero, 0, 0							# $t0 = 255*i
	add $t0, $a0, $a1, $zero, 0, 0							# $t0 = 255*i+j
	add $t1, $zero, $zero, $zero, 0, 255					# $t1 = 255
	add $t2, $zero, $zero, $zero, 0, 1						# $t2 = 1
	out $zero, $zero, $zero, $t0, 0, 20						# monitoraddr = 255*i+j
	out $zero, $zero, $zero, $t1, 0, 21						# monitordata = 255
	out $zero, $zero, $zero, $t2, 0, 22						# monitorcmd = 1
	lw $a1, $sp, $zero, $zero, 0, 0							# restore $a1
	lw $a0, $sp, $zero, $zero, 0, 1							# restore $a0
	lw $s1, $sp, $zero, $zero, 0, 2							# restore $s1
	lw $s0, $sp, $zero, $zero, 0, 3							# restore $s0
	add $sp, $sp, $imm2, $zero, 0, 4						# pop 4 items from stack
	beq $zero, $zero, $zero, $ra, 0, 0						# and return