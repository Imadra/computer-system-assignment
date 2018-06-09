.data
arr:     .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
message:  .asciiz "\nValue:\n"
end: .word 9
start: .word 0
minVal: .word 1
maxVal: .word 10

.text
main:   	

    # print message
    li $v0, 4
    la $a0, message
    syscall

    # read the value
    li $v0, 5
    syscall
    beq $v0, -1, endProgramm
    lw $s0, minVal
    lw $s2, maxVal
    blt $v0, $s0, notFound
    bgt $v0, $s2, notFound
    la $a0, arr
    lw $a1, start
    lw $a2, end
    add $a3, $v0, $zero
    
    jal BinSearch
    move $a0, $v0
    li $v0, 1
    syscall
    j main 


BinSearch:
    add $t1, $a1, $zero
    add $t2, $a2, $zero
    add $t5, $a3, $zero
    loop:
    # t0 = (t1 + t2 ) / 2
    add $t0, $t1, $t2  # $t0 = start + end
    div  $t0, $t0, 2   # $t0 /= 2

    blt $t2, $t0, notFound2
    add $t3, $a0, $zero
    mul $t7, $t0, 4
    add $t3, $t3, $t7
    lw  $t6, ($t3)                  # $t6 = a[t0]
    
    beq $t6, $t5, found          # if (a[t0] == value)

    blt $t5, $t6, first       # if (value < a[t0])

    bgt $t5, $t6, second        # if (value > a[t0])  
    
    found:
       move $v0, $t0                    # return
       jr $ra 

    notFound2:
       li $v0, -1
       jr $ra    
           
    first:
           move $t4, $t0                # t4 = t0     
           addi $t4, $t4, -1            # t4 --
           move $t2, $t4                # t2 = t4
           j loop
       jr $ra

    second:                             
       move $t4, $t0                    # t4 = t0
       addi $t4, $t4, 1                 # t4++
       move $t1, $t4                    # t1 = t4
       j loop
       jr $ra 
    
notFound:
li $a0,-1
li $v0, 1
syscall
j main

endProgramm:
li $v0, 10
syscall