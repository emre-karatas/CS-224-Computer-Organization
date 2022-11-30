#Emre Karatas - 22001641
.data
questionPrompt: .asciiz "Enter the number in decimal: "
hexPrompt: .asciiz "Hexadecimal representation is : "
integer: .word 0
newLine: .asciiz "\n"
reversePrompt: .asciiz "Reverse order of hexadecimal is: "


.text
main:
	#question prompting
	la $a0,questionPrompt
	li $v0,4
	syscall
	
	#save value
	li $v0,5
	syscall
	sw $v0,integer
	
	#hex prompt 
	la $a0,hexPrompt
	li $v0,4
	syscall
	
convertToHex:
	#loading number
	lw $a0,integer
	#constant
	addi $t0,$zero,16
	move $t1,$a0
	
	loop:
		#divide until division 0
		div $t1,$t0
		mfhi $t2
		mflo $t3
		sw $t2,($sp)
		subi $sp,$sp,4
		move $t1,$t3
		bgt $t3,$zero,loop
		jal done
	done:
		#printing in hex
		lw $t2,($sp)
		li $v0,34
		syscall
		
invertBytes:
	#load
	move $t0,$a0
	
	#newline
	la $a0,newLine
	li $v0,4
	syscall
	
	#reverse line prompt
	la $a0,reversePrompt
	li $v0,4
	syscall
	
	#rotate right 
	ror $t1,$t0,16
	
	# andi operation
	and $t1,$t0,0x00
	
	#printing out
	move $a0,$t1
	li $v0,34
	syscall
	
	#newLine
	la $a0,newLine
	li $v0,4
	syscall
	
	#jump
	jal main

	
	
	
