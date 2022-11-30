#Emre Karatas -22001641
.data
	array : .space 400
	question: .asciiz "\nEnter array size: (max 100) "
	arraySize: .word 0
	opening: .asciiz "----Simple Menu Involves Loop----"
	menu: .asciiz "Select one of options: \n 1-Summation of numbers greater than entered input \n 2-Finding Summation of odd and even numbers and displaying \n 3-Display number of occurences of the array elements divisible by certain input number \n 4-Quit \n"
	optionPrompt: .asciiz "Enter your option: "
	directive: .asciiz "Enter the values one by one: "
	option: .word 0
	newLine: .asciiz "\n"
	option1Prompt: .asciiz "Enter the value : "
	sum1Option: .word 0
	opt1Result: .asciiz "Sum is: "
	opt2SumOdd: .asciiz "Sum of odd array elements is: "
	opt2SumEven: .asciiz "Sum of even array elements is: "
	opt3Prompt: .asciiz "Number of occurences of numbers divisible by "
	opt3Result: .asciiz " is: " 
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
	
	#directive input
	li $v0,4
	la $a0,directive
	syscall
	
	#newLine character
	li $v0,4
	la $a0,newLine
	syscall
	
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
	beq $t1,$t2,menuDisplaying
	jr $ra
menuDisplaying:
	
	#menu prompt
	li $v0,4
	la $a0,menu
	syscall
	
	#option selection prompt
	li $v0,4
	la $a0,optionPrompt
	syscall
	
	#option getting
	li $v0,5
	syscall
	sw $v0,option
	
	#move to register
	move $t3,$v0
	
	#selections
	beq $t3,1,option1
	beq $t3,2,option2
	beq $t3,3,option3
	beq $t3,4,exit
	
	li $v0,10
	syscall
	jr $ra
	
option1:
	# counter = 0
	addi $t1,$zero,0
	#sum = 0
	addi $t4,$zero,0
	
	#loading array
	la $s0,array
	#loading array size
	lw $t2, arraySize
	
	#prompt outputting
	li $v0,4
	la $a0,option1Prompt
	syscall
	
	#option outputting
	li $v0,5
	syscall
	sw $v0,sum1Option
	
	#move 
	move $t6,$v0
	
	opt1Loop:
		#load array index calues
		lw $sp,0($s0)
		move $t5,$sp
		
		#increment the pointer	
		addi $s0,$s0,4
		
		#if element is bigger add it
		bgt $t5,$t6,addition
		#else skip
		ble $t5,$t6,skip
		addition:
			# t4 = sum
			add $t4,$t4,$t5
			#add counter
			addi $t1,$t1,1
			#add pointer 4 bytes
			addi $t5,$t5,4
			#loop statements
			beq $t1,$t2,done
			bne $t1,$t2,opt1Loop
		skip:
			#add pointer 4 bytes
			addi $t5,$t5,4
			#add counter 1
			addi $t1,$t1,1
			#loop conditions
			bne $t1,$t2,opt1Loop
			beq $t1,$t2,done
			jr $ra
	done:	
		#sum prompt
		li $v0,4
		la $a0,opt1Result
		syscall
		#move
		move $a0,$t4
		#print the sum
		li $v0,1
		syscall
		
		#print new line
		li $v0,4
		la $a0,newLine
		syscall
		
		jal menuSelection
		
	
	

option2:
	#even 
	addi $t3,$zero,0
	#odd 
	addi $t4,$zero,1
	#odd negative
	addi $s2,$zero,-1
	
	#2 constant
	addi $t9,$zero,2
	
	#odd sum 
	addi $t7,$zero,0
	
	#even sum
	addi $t8,$zero,0
	
	#counter
	addi $t1,$zero,0
	
	#loading array
	la $s0,array
	#loading array size
	lw $t2, arraySize
	opt2Loop:
		#load the array
		lw $sp,0($s0)
		move $t5,$sp
		
		#move to next register
		addi $s0,$s0,4
		
		#division
		div $t5,$t9
		#remainder
		mfhi $t6
		
		#go to even 
		beq $t6,$t3,even
		#go to odd
		beq $t6,$t4,odd
		beq $t6,$s2,odd
	even:
		#increment count
		addi $t1,$t1,1
		#sum
		add $t8,$t8,$t5
		#loop condition
		beq $t1,$t2,print
		bne $t1,$t2,opt2Loop
		
	odd:
		#increment count
		addi $t1,$t1,1
		#sum 
		add $t7,$t7,$t5
		#loop condition
		beq $t1,$t2,print
		bne $t1,$t2,opt2Loop
	print:
	
	#odd sum prompt
	li $v0,4
	la $a0,opt2SumOdd
	syscall
	
	#sum printing
	move $a0,$t7
	li $v0,1 
	syscall
	
	#newline 
	li $v0,4
	la $a0,newLine
	syscall
	
	#even prompt sum
	li $v0,4
	la $a0,opt2SumEven
	syscall
	
	#even sum
	move $a0,$t8
	li $v0,1
	syscall
	
	li $v0,4
	la $a0,newLine
	syscall
	
	#option selection prompt
	jal menuSelection
	
	

option3:
	#loading array
	la $s0,array
	
	#remainder setting zero
	addi $t5,$zero,0
	
	#occurence counter = 0
	addi $t7,$zero,0
	
	#loop counter
	addi $t8,$zero,0
	
	#input prompt
	li $v0,4
	la $a0, option1Prompt
	syscall
	
	#getting input from user
	li $v0,5
	syscall
	move $t4,$v0
	
	#loading arraySize
	lw $t2,arraySize
	
	opt3Loop:
		#load the array
		lw $sp,0($s0)
		move $t5,$sp
		
		#move to next register
		addi $s0,$s0,4
		
		#division
		div $t5,$t4
		
		#remainder
		mfhi $t6
		
		#counter
		addi $t8,$t8,1
		
		#loop conditions
		beq $t6,$zero,occured
		beq $t8,$t2,done3
		bne $t6,$zero,opt3Loop
	
	occured:
		#counting occurences
		addi $t7,$t7,1
		bne $t8,$t2,opt3Loop
		beq $t8,$t2,done3
		
	done3:
	#prompt
	li $v0,4
	la $a0,opt3Prompt
	syscall
	
	#entered number
	move $a0,$t4
	li $v0,1
	syscall
	
	#prompt #2
	li $v0,4
	la $a0,opt3Result
	syscall
	
	#result
	move $a0,$t7
	li $v0,1
	syscall
	
	#newline
	li $v0,4
	la $a0,newLine
	syscall
	
	
	jal menuSelection
	

menuSelection:
	#option selection prompt
	li $v0,4
	la $a0,optionPrompt
	syscall
	
	#option outputting
	li $v0,5
	syscall
	sw $v0,sum1Option
	#move 
	move $t3,$v0
	#selections
	beq $t3,1,option1
	beq $t3,2,option2
	beq $t3,3,option3
	beq $t3,4,exit
		
exit:
	li $v0,10
	syscall
	jr $ra


	
