#Emre Karatas - 22001641
.data

	questionValueA : .asciiz "Enter A value: "
	questionValueB: .asciiz "Enter B value: "
	questionValueC: .asciiz "Enter C value: "
	a: .word 0
	b: .word 0
	c: .word 0
	divisionResult: .word 0
	mod: .word
	remainder: .word 0
	result: .asciiz "x =  " 
	prompt : .asciiz "Solution of x = (2*a*b)/c )*(a-c) \n"
	constant: .word 2
	errorMsg : .asciiz "C value cannot be 0. Division by 0 error. Enter C value again: "
	newLine: .asciiz "\n"
	
.text

process:
	#prompt 
	li $v0,4
	la $a0,prompt
	syscall
	
	#getting user input A
	li $v0,4
	la $a0,questionValueA
	syscall
	li $v0,5
	syscall
	sw $v0,a
	
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
	lw $t2,c
	
	#error part 
	beq $t2,$zero,error
	
	#newline
	li $v0,4
	la $a0,newLine
	syscall
	
	j operation
	
	operation:
	#load values
	lw $t0,a
	lw $t1,b
	lw $t2,c
	lw $t3,constant
	
	 
	#multiplication process ( 2* a)
	mult $t3,$t0
	mflo $t4
	
	#multiplication process #2 ( 2*a*b)
	mult $t4,$t1
	mflo $t5
	
	#division by c 
	div $t5,$t2
	mflo $t6
	
	#subtraction (a-c)
	sub $t7,$t0,$t2
	
	#final multiplication
	mult $t7,$t6
	mflo $t8
	
	
	#outputting prompt of result
	li $v0,4
	la $a0,result
	syscall
	
	#move to the a0 register
	move $a0,$t8
	
	#outputting the result
	li $v0,1
	syscall
	
	#exit
	li $v0,10
	syscall
error :
	#error message
	li $v0,4
	la $a0,errorMsg
	syscall
	
	#input getting
	li $v0,5
	syscall
	sw $v0,c
	
	jal operation
	
	
