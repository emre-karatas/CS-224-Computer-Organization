#Emre Karatas -22001641
.data
	array : .space 80
	array2: .space 80
	question: .asciiz "\nEnter array size: (max 20) "
	arraySize: .word 0
	seperator: .asciiz " " 
	exp: .asciiz "\nafter reversing: " 
	arrayExp: .asciiz "Array is: "
	opening: .asciiz "----Array Swapper ----"
.text
main:
	#opening message
	li $v0,4
	la $a0,opening
	syscall	
	
	#array loading
	la $t0,array
	#counter = 0
	addi $t1,$zero,0 
	
	#printing
	li $v0,4
	la $a0,question
	syscall	
	
	#getting the input from user
	li $v0, 5
	syscall
	sw $v0,arraySize
	
	#starting loop
	bgt $v0,$zero,loop
	
loop: 
	#getting array inputs
	lw $t2,arraySize
	li $v0,5
	syscall
	sw $v0,0($t0)
	addi $t0,$t0,4
	addi $t1,$t1,1
	
	#loop condition
	blt $t1,$t2,loop
	
	#next instruction
	jal printingArray
	jr $ra
	
printingArray:
	la $t0,array
	lw $t2,arraySize
	# counter equal to 0
	addi $t1,$zero,0
	#array message
	li $v0,4
	la $a0,arrayExp
	syscall	
	
	#printing the array
	continue:
		lw $a0,0($t0)
		addi $t0,$t0,4
		li $v0,1
		syscall
		la $a0,seperator
		li $v0,4
		syscall
	
	#counter
	addi $t1,$t1,1
	blt $t1,$t2,continue
	addi $t0,$t0,4
	
	#next step
	jal reversing
	jr $ra
reversing:
	la $a0,0($t0)
	la $t4,array
	
	#matching t0 and t4 elements by temp values(t5,t6)
	swapping:
		lw $t5,0($t0)
		lw $t6,0($t4)
		
		sw $t5,0($t4)
		sw $t6,0($t0)
		
		#increase and decrease the address
		addi $t4,$t4,4
		addi $t0,$t0,-4
		
		#loop condition
		bgt $t0,$t4,swapping
	#loading array size
	la $a0,0($t2)
	addi $t1,$zero,0
	
	#explanation
	li $v0,4
	la $a0,exp
	syscall	
	
	#printing reverse array
	while:
		lw $a0,0($t4)
		addi $t4,$t4,4
		
		#message
		li $v0,1
		syscall
		
		la $a0,seperator
		li $v0,4
		syscall
		
		addi $t1,$t1,1
		#loop condition
		blt $t1,$t2,while
	#exiting
	li $v0,10
	syscall
	jr $ra

