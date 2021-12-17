	add $s0, $zero, $zero, $zero, 0, 3						# k = 3
	add $s1, $zero, $zero, $zero, 0, 3						# l = 3
	add $s2, $zero, $zero, $zero, 0, 4608					# $s2 = 4608
	add $a0, $zero, $zero, $zero, 0, 4096					# i = 4096
	add $a1, $zero, $zero, $zero, 0, 4352					# j = 4352
LOOP1:
	add $s1, $zero, $zero, $zero, 0, 3						# l = 3
	add $a1, $zero, $zero, $zero, 0, 4352					# j = 4352
	LOOP2:
		jal $ra, $zero, $zero, $zero, 0, calcIndex			# calc calcIndex(i,j)
		add $s1, $s1, $zero, $zero, 0, -1					# l--
		add $a1, $a1, $zero, $zero, 0, 1					# j++
		sw $zero, $s2, $zero, $va, 0, 0						# save the result
		add $s2, $s2, $zero, $zero, 0, 1					# $s2 = $s2 + 1
		bne $zero, $s1, $zero, $zero, 0, LOOP2				# jump to LOOP2
	add $s0, $s0, $zero, $zero, 0, -1						# k--
	add $a0, $a0, $zero, $zero, 0, 4						# i++
	bne $zero, $s0, $zero, $zero, 0, LOOP1					# jump to LOOP1
	halt $zero, $zero, $zero, $zero, 0, 0					# halt


calcIndex:													# calc Aij
	add $sp, $sp, $zero, $zero, 0, -1						# pop 1 items from stack
	sw $zero, $sp, $zero, $s0, 0, 0							# save $s0
	add $t0, $zero, $zero, $zero, 0, 3						# k = 3
	add $s0, $zero, $zero, $zero, 0, 12						# k2 = 12
	add $v0, $zero, $zero, $zero, 0, 0						# $v0 = 0
	LOOP:
		lw $t1, $a0, $t0, $zero, 0, 0		    			# get Ai(k+1)
		lw $t2, $a1, $s0, $zero, 0, 0		    			# get A(k+1)j
		mac $t2, $t2, $t1, $zero, 0, 0						# $t2 = Ai(k+1) * A(k+1)j
		add $v0, $v0, $t2, $zero, 0, 0		    			# $v0 = $v0 + Ai(k+1) * A(k+1)j
		add $t0, $t0, $zero, $zero, 0, -1					# k--
		add $s0, $s0, $zero, $zero, 0, -4					# k2 = k2 - 4
		bne $zero, $t0, $zero, $zero, 0, LOOP				# jump to LOOP
	lw $s0, $sp, $zero, $zero, 0, 0							# restore $s0
	add $sp, $sp, $zero, $zero, 0, 1						# pop 1 items from stack
	beq $zero, $zero, $zero, $ra, 0, 0						# and return