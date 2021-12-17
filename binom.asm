	add $t0, $zero, $zero, $zero, 0, 4096					# $t0 = &n
	add $t1, $zero, $zero, $zero, 0, 4097					# $t1 = &k
	lw $a0, $t0, $zero, $zero, 0, 0		    				# $a0 = n
	lw $a1, $t1, $zero, $zero, 0, 0		    				# $a1 = k
	jal $ra, $zero, $zero, $imm2, 0, binom					# calc binom(n,k)
	add $t2, $zero, $zero, $zero, 0, 4098					# $t2 = &result
	sw $zero, $t2, $zero, $va, 0, 0							# save the result
	halt $zero, $zero, $zero, $zero, 0, 0					# halt
binom:
	add $sp, $sp, $zero, $zero, 0, -4						# adjust stack for 3 items
	sw $zero, $sp, $zero, $s0, 0, 3							# save $s0
	sw $zero, $sp, $zero, $ra, 0, 2							# save return address
	sw $zero, $sp, $zero, $a0, 0, 1							# save argument
	sw $zero, $sp, $zero, $a1, 0, 0							# save argument
	beq $zero, $a1, $zero, $zero, 0, return1				# if k==0 jump to return1
	beq $zero, $a1, $a0, $zero, 0, return1					# if k==n jump to return1
	beq $zero, $zero, $zero, $zero, 0, return2				# jump to return2
	return1:
		add $v0, $zero, $zero, $zero, 0, 1					# return 1
		lw $a1, $sp, $zero, $zero, 0, 0						# restore $a1
		lw $a0, $sp, $zero, $zero, 0, 1						# restore $a0
		lw $ra, $sp, $zero, $zero, 0, 2						# restore $ra
		lw $s0, $sp, $zero, $zero, 0, 3						# restore $s0
		add $sp, $sp, $imm2, $zero, 0, 4					# pop 4 items from stack
		beq $zero, $zero, $zero, $ra, 0, 0					# and return
	return2:
		add $a0, $a0, $zero, $zero, 0, -1					# n = n - 1
		jal $ra, $zero, $zero, $zero, 0, binom				# calc binom(n-1,k)
		add $s0, $v0, $zero, $zero, 0, 0					# $s0 = binom(n-1,k)
		add $a1, $a1, $zero, $zero, 0, -1					# k = k - 1
		jal $ra, $zero, $zero, $zero, 0, binom				# calc binom(n-1,k-1)
		add $v0, $v0, $s0, $zero, 0, 0						# $v0 = binom(n-1,k) + binom(n-1,k-1)
		lw $a1, $sp, $zero, $zero, 0, 0						# restore $a1
		lw $a0, $sp, $zero, $zero, 0, 1						# restore $a0
		lw $ra, $sp, $zero, $zero, 0, 2						# restore $ra
		lw $s0, $sp, $zero, $zero, 0, 3						# restore $s0
		add $sp, $sp, $imm2, $zero, 0, 4					# pop 4 items from stack
		beq $zero, $zero, $zero, $ra, 0, 0					# and return