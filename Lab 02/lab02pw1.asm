#Emre Karatas - 22001641
.data
stringInput: .space 5
size: .word 3
labPrompt: .asciiz "----Convert Hexadecimal to Decimal----"
labQuestion: .asciiz "Enter hexadecimal value( for letters, use capital one ): "
labResult: .asciiz "Decimal equivalent is : "
newLine: .asciiz "\n"
errorPrompt: .asciiz "You have entered invalid value"

.text

operation:
	#first prompt
	la $a0,labPrompt
	li $v0,4
	syscall

	#newline character
	la $a0,newLine
	li $v0,4
	syscall

	#asking hexadecimal value
	la $a0,labQuestion
	li $v0,4
	syscall

	#asking user the string
	li $v0,8
	la $a0,stringInput
	li $a1,5
	sw $a0,stringInput
	move $t0,$a0
	syscall

	# size = 3
	addi $s4,$zero,3
	
	#load bytes
	lbu $s0,0($t0)
	lbu $s1,1($t0)
	lbu $s2,2($t0)
	lbu $s3,3($t0)
	beq $s0,$zero,add1
	beq $s1,$zero,add2
	beq $s2,$zero,add3
	beq $s3,$zero,add4
	jal convert

add1:
	li $s0,0
	jal convert
add2:
	li $s1,0
	jal convert
add3:
	li $s2,0
	jal convert
add4:
	li $s3,0
	jal convert
	

exit:
	#end
	li $v0,10
	syscall

convert:
	#boundary checking
	li $t1,0x30
	li $t2,0x39
	
	#checking character
	blt $s0,$t1,errorMsg
	bgt $s0,$t2,letter
	subiu $s0,$s0,0x30
	
	#checking character
	blt $s1,$t1,errorMsg
	bgt $s1,$t2,letter
	subiu $s1,$s1,0x30
	
	#checking character
	blt $s2,$t1,errorMsg
	bgt $s2,$t2,letter
	subiu $s2,$s2,0x30
	
	#checking character
	blt $s3,$t1,errorMsg
	bgt $s3,$t2,letter
	subiu $s3,$s3,0x30
	
	#next step
	jal calculation
	jr $ra
errorMsg:
	#newline
	li $v0,4
	la $a0,newLine
	syscall
	
	#error prompt
	li $v0,4
	la $a0,errorPrompt
	syscall
	
	#newline
	li $v0,4
	la $a0,newLine
	syscall
	
	#done
	jal exit


letter:
	
	#boundary checkings
	li $t3,0x41
	li $t4,0x46
	
	#checking char 1
	subi $s0,$s0,0x37
	
	#checking char 2
	subi $s1,$s1,0x37
	
	#checking char 3
	subi $s2,$s2,0x37
	
	#checking char 4
	subi $s3,$s3,0x37
	
	
calculation:
	#constants
	addi $t0,$zero,1
	addi $t1,$zero,16
	addi $t3,$zero,0
	addi $t4,$zero,0
	addi $t6,$zero,3
	addi $t7,$zero,2
	addi $t8,$zero,1
	addi $t9,$zero,0
	
	
	move $t4,$s4
	#for 0 value operation
	bne $t4,$t9,loop
	slt $t1,$t4,$t8
	loop:
		mult $t0,$t1
		mflo $t2
		move $t0,$t2
		subi $t4,$t4,1
		bgt $t4,$zero,loop
	temp:
	#branching
	beq $s4,$t6,done0
	beq $s4,$t7,done1
	beq $s4,$t8,done2
	beq $s4,$t9,done3
		done0:
			mult $s0,$t0
			mflo $t5
			move $s0,$t5
			subi $s4,$s4,1
			bgez $s4,calculation
			jr $ra
		done1:
			mult $s1,$t0
			mflo $t6
			move $s1,$t6
			subi $s4,$s4,1
			bgez $s4,calculation
			jr $ra
		done2:
			mult $s2,$t0
			mflo $t7
			move $s2,$t7
			subi $s4,$s4,1
			bgez $s4,calculation
			jr $ra
		done3:
			mult $s3,$t0
			mflo $t8
			move $s3,$t8	
			subi $s4,$s4,1
			bge $s4,$zero,calculation
			la $a0,newLine
			li $v0,4
			syscall
			jal addition
			jr $ra
addition:
	addi $t0,$zero,0
	add $t0,$t0,$s0
	add $t0,$t0,$s1
	add $t0,$t0,$s2
	add $t0,$t0,$s3
	
	addi $t0,$t0,1911
	
	
	la $a0,labResult
	li $v0,4
	syscall
	
	move $a0,$t0
	li $v0,1
	syscall
	
	la $a0,newLine
	li $v0,4
	syscall
	
	jal operation
		
	

	
	
	


	
	
	

