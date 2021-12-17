	add $s0, $zero, $zero, $zero, 0, 7								# $s0 = 7
	add $s1, $zero, $zero, $zero, 0, 8								# $s1 = 8
read:
	in $t0, $zero, $zero, $zero, 0, 17								# read diskstatus into $t0
	bne $zero, $t0, $zero, $zero, 0, read							# jump to read if the disk is busy
	beq $zero, $s0, $zero, $zero, 0, stop							# jump to stop if finish
	out $zero, $zero, $zero, $s0, 0, 15								# set disksector to $s0
	out $zero, $zero, $zero, $sp, 0, 16								# set diskbuffer to &$sp
	add $sp, $sp, $zero, $zero, 0, -512								# adjust stack for 512 items
	out $zero, $zero, $imm2, $imm1, 1, 14							# set diskcmd to read
	add $s0, $s0, $zero, $zero, 0, -1								# $s0--
	beq $zero, $zero, $zero, $zero, 0, write						# jump to write
write:
	in $t0, $zero, $zero, $zero, 0, 17								# read diskstatus into $t0
	bne $zero, $t0, $zero, $zero, 0, write							# jump to write if the disk is busy
	out $zero, $zero, $zero, $s1, 0, 15								# set disksector to $s1
	out $zero, $zero, $zero, $sp, 0, 16								# set diskbuffer to &$sp
	out $zero, $zero, $imm2, $imm1, 2, 14							# set diskcmd to write
	add $sp, $sp, $zero, $zero, 0, 512								# pop 512 items from stack
	add $s1, $s1, $zero, $zero, 0, -1								# $s1--
	beq $zero, $zero, $zero, $zero, 0, read							# jump to read
stop:
	halt $zero, $zero, $zero, $zero, 0, 0							# halt
	