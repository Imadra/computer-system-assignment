.data
array: .word 7 -10 1 -5
size: .word 4

.text
la $a0, array
lw $a1, size

jal negate

addi $t7, $s0, -16

lw $t6, 0($t7) 
addi $a0, $t6, 0 
li $v0, 1
syscall

lw $t6, 4($t7) 
addi $a0, $t6, 0 
li $v0, 1
syscall

lw $t6, 8($t7) 
addi $a0, $t6, 0 
li $v0, 1
syscall

lw $t6, 12($t7) 
addi $a0, $t6, 0 
li $v0, 1
syscall

li $v0, 10
syscall

negate:
	add $s0, $a0, $zero
	add $s1, $a1, $zero
	li $t0, 0
	li $t3, 0
	loop:
		lw $t1, 0($s0)
		slt $t5, $t1, $zero
		beq $t5, $zero, goNext
		sub $t1, $zero, $t1
		sw  $t1, 0($s0)			
		goNext: 
		addi $s0, $s0, 4
		addi $t0, $t0, 1
		
		beq $t0, $s1, exitLoop
		j loop		
exitLoop:

	jr $ra			#go to the address stored in register $ra
			
		

