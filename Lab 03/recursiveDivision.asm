#Emre Karatas - 22001641

.text
main: 
	#dividend prompt and getting value
	la $a0,dividendPrompt
	li $v0,4
	syscall

	li $v0,5
	syscall
	
	#saving
	sw $v0,dividend
	move $s3,$v0
	#exit loop condition
	beq $s3,$zero,exit
	
	#divisor prompt and getting value
	la $a0,divisorPrompt
	li $v0,4
	syscall

	li $v0,5
	syscall

	#saving
	sw $v0,divisor
	
	#counter
	li $s2,0
	jal recursiveDivision
	
exit:
	li $v0,10
	syscall

recursiveDivision:
	addi $sp,$sp,-12
	sw $s0,0($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	
	move $s0,$a0
	#load values
	lw $s0,dividend
	lw $s1,divisor
	
	#substract
	sub $s0,$s0,$s1
	# base case 1
	blt $s0,$zero,done
	beq $s1,$zero,error
	#add counter
	addi $s2,$s2,1
	
	#save value
	sw $s0,dividend
	
	#base case 2
	beq $s0,$zero,done
	#recursive part
	move $a0,$s0
	jal recursiveDivision
	
	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	addi $sp,$sp,12
	


done:
	#print result
	la $a0,result
	li $v0,4
	syscall
	
	move $a0,$s2
	li $v0,1
	syscall
	
	#newl›ne
	la $a0,newLine
	li $v0,4
	syscall
	
	#return to main
	j main
error: 
	#newl›ne
	la $a0,newLine
	li $v0,4
	syscall
	
	#print result
	la $a0,errormsg
	li $v0,4
	syscall
	
	#newl›ne
	la $a0,newLine
	li $v0,4
	syscall
	
	j main
	
	
	
	
.data
dividendPrompt: .asciiz "Enter the dividend: (0 to stop) "
dividend : .word 0
divisorPrompt: .asciiz "Enter the divisor: "
divisor : .word 0
result : .asciiz "Division quotient is: "
newLine: .asciiz "\n"
errormsg: .asciiz "Division by 0 error"

