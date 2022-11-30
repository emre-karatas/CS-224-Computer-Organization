#Emre Karatas -22001641
.text

main:
	la $a0,welcomePrompt
	li $v0,4
	syscall
	
	la $a0,newLine
	li $v0,4
	syscall
	
	la $a0,questionPrompt
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	
	move $s0,$v0
	
	la $a0,newLine
	li $v0,4
	syscall
	
	li $t0,31
	
	bgt $s0,$t0,finish
	blez $s0,finish
	
	la $a0,subProgramStart
	la $a1,subProgramEnd
	move $a2,$s0
	jal registerCount
	j main
finish:
	li $v0,10
	syscall
	
	
registerCount:
	addi	$sp, $sp, -32
	sw	$s0, 28($sp)
	sw	$s1, 24($sp)
	sw	$s2, 20($sp)
	sw	$s3, 16($sp)
	sw	$s4, 12($sp)
	sw	$s5, 8($sp)
	sw	$s6, 4($sp)
	sw	$s6, 0($sp)
	
	move	$s0, $a0			
	move 	$s1, $a1			
	move 	$s2, $a2
	
	
	
	addi $s3,$zero,0
	while:
		bgt $s0,$s1,done
		lw $s4, 0($s0)			
		srl $s5,$s4,21
		srl $s6,$s4,11
		srl $s7,$s4,16
		beq $s5,$s2,increment
		mult $s2,$s2
		mflo $s2
		beq $s6,$s2,increment
		mult $s2,$s2
		mflo $s2
		beq $s7,$s2,increment
		j iterate
	
	increment:
		addi $s3,$s3,1
		j iterate
	iterate:
		addi $s0,$s0,4
		j while
	done:
		la $a0,result
		li $v0,4
		syscall
		li $v0,1
		move $a0,$s3
		syscall
		la $a0,newLine
		li $v0,4
		syscall
		
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$s3, 12($sp)
	lw	$s4, 16($sp)
	lw	$s5, 20($sp)
	lw	$s6, 24($sp)
	lw	$s6, 28($sp)
	addi	$sp, $sp, 28
	
	jr $ra
	
subProgramStart:
	add  $t0, $t0, $t1	
subProgramEnd:
	

.data
welcomePrompt: .asciiz "----Register Counter----"
questionPrompt: .asciiz "Enter the register number: "
result: .asciiz "Result is: "
newLine: .asciiz "\n"
