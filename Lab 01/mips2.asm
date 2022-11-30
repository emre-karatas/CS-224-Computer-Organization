#Emre Karatas - 22001641
.data

	questionValueB : .asciiz "Enter B value: "
	questionValueC: .asciiz "Enter C value: "
	questionValueD: .asciiz "Enter D value: "
	b: .word 0
	c: .word 0
	d: .word 0
	divisionResult: .word 0
	mod: .word
	remainder: .word 0
	result: .asciiz "A =  " 
	prompt : .asciiz "Solution of A = (B/C+D*B-C) MOD B \n"


.text
	#prompt 
	li $v0,4
	la $a0,prompt
	syscall
	
	#getting user input B
	li $v0,4
	la $a0,questionValueB
	syscall
	li $v0,5
	syscall
	sw $v0,b
	
	#getting user input C
	li $v0,4
	la $a0,questionValueC
	syscall
	li $v0,5
	syscall
	sw $v0,c
	
	#getting user input D
	li $v0,4
	la $a0,questionValueD
	syscall
	li $v0,5
	syscall
	sw $v0,d
	
	#loading values
	lw $t0,b
	lw $t1,c
	lw $t2,d
	
	#division operation
	jal division
	move $a0,$t3
	
	#load b again
	lw $t0,b
	
	#operations
	sub $t5,$v0,$t1
	mul $t6,$t2,$t0
	add $t7,$t6,$t5
	
	
	#setting values for 2nd division
	move $t1,$t0
	move $t0,$t7
	jal division
	
	#displaying result
	jal display
	
	#result printing
	move $a0,$t4
	li $v0,1
	syscall
	
	#exiting
	li $v0,10
	syscall

division:
	#initializing values
	add $t3,$zero,1
	addi $t4,$zero,0
	loop:
		sub $t0,$t0,$t1
		sub $t4,$t0,$t1
		#division counter
		add $t3,$t3,1
		
		#loop conditions
		blt $t4,$zero,done
		beq $t4,$zero,done
		bgt $t4,$zero,loop
	done:
	#getting the last value before 0
	add $t4,$t4,$t1	
	
	#saving values
	sw $t3,divisionResult
	sw $t4,remainder
	jr $ra
display:
	#result prompt
	li $v0,4
	la $a0,result
	syscall
	jr $ra
	

		
		
	
	
	
