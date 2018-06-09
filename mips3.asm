.data
	n: .word -1
	divisor: .word 2
	no: .asciiz "No\n"
	yes: .asciiz "Yes\n"
.text
	lw $s0, n
	lw $s1, divisor
	
	
	isPrime:
	
	li $v0, 5
	syscall
	move $t0, $v0			#taking n
	beq $t0, $s0, QUIT		#checking n = -1
	li $v0, 4
	beq $t0, 1, Print_no
	li $t1, 1			#set i = 1
	div $t0, $s1
	mflo $s2			#s2 = n/2
	
	
	loop:
		add $t1, $t1, 1
		slt $t2, $s2, $t1	#checking i < n/2
		beq $t2, 1, Print_yes
		rem $t3, $t0, $t1
		
		beq $t3, $zero, Print_no
		j loop
		
		
		Print_yes:
		la $a0, yes
		syscall
		jal isPrime
		
		Print_no:
		la $a0, no
		syscall
		jal isPrime
		
		
	
	QUIT:
	li $v0, 10
	syscall
