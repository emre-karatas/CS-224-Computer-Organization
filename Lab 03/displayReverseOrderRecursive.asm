#Emre Karatas - 22001641

.text
main:
	#welcome prompt
	la $a0,welcomePrompt
	li $v0,4
	syscall
	
	la $a0,newLine
	li $v0,4
	syscall
	
	#size of L1 prompt
	la $a0,size1Prompt
	li $v0,4
	syscall

	#getting size of Linked list
	li $v0,5
	syscall
	
	move $a0,$v0
	move $s6,$v0
	#L1 creating
	jal createLinkedList
	move $a0, $v0	# Pass the linked list address in $a0
	move $s5,$v0     #head pointer of L1
	jal printLinkedList
	
	#new line 
	la $a0,newLine
	li $v0,4
	syscall
	
	
	move $a0, $s5	# Pass the linked list address in $a0L1
	move $a1, $s6	#size 
	jal displayReverseOrderRecursively
	
	li $v0,10
	syscall
	
createLinkedList:
	# $a0: No. of nodes to be created ($a0 >= 1)
	# $v0: returns list head
	# Node 1 contains 4 in the data field, node i contains the value 4*i in the data field.
	# By 4*i inserting a data value like this
	# when we print linked list we can differentiate the node content from the node sequence no (1, 2, ...).
	addi	$sp, $sp, -24
	sw	$s0, 20($sp)
	sw	$s1, 16($sp)
	sw	$s2, 12($sp)
	sw	$s3, 8($sp)
	sw	$s4, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram
	
	move	$s0, $a0	# $s0: no. of nodes to be created.
	li	$s1, 1		# $s1: Node counter
	# Create the first node: header.
	# Each node is 8 bytes: link field then data field.
	li	$a0, 8
	li	$v0, 9
	syscall
	# OK now we have the list head. Save list head pointer 
	move	$s2, $v0	# $s2 points to the first and last node of the linked list.
	move	$s3, $v0	# $s3 now points to the list head.
	#sll	$s4, $s1, 2
	li $v0,5
	syscall
	move $s4,$v0
	# sll: So that node 1 data value will be 4, node i data value will be 4*i
	sw	$s4, 4($s2)	# Store the data value.
	addNode:
		# Are we done?
		# No. of nodes created compared with the number of nodes to be created.
		beq	$s1, $s0, allDone
		addi	$s1, $s1, 1	# Increment node counter.
		li	$a0, 8 		# Remember: Node size is 8 bytes.
		li	$v0, 9
		syscall
		# Connect the this node to the lst node pointed by $s2.
		sw	$v0, 0($s2)
		# Now make $s2 pointing to the newly created node.
		move	$s2, $v0	# $s2 now points to the new node.
		li $v0,5
		syscall
		move $s4,$v0
	# sll: So that node 1 data value will be 4, node i data value will be 4*i
		sw	$s4, 4($s2)	# Store the data value.
		j	addNode
	allDone:
	# Make sure that the link field of the last node cotains 0.
	# The last node is pointed by $s2.
		sw	$zero, 0($s2)
		move	$v0, $s3	# Now $v0 points to the list head ($s3).
		move    $v1,$s2
	
	# Restore the register values
		lw	$ra, 0($sp)
		lw	$s4, 4($sp)
		lw	$s3, 8($sp)
		lw	$s2, 12($sp)
		lw	$s1, 16($sp)
		lw	$s0, 20($sp)
		addi	$sp, $sp, 24
		jr	$ra
#=========================================================
printLinkedList:
# Print linked list nodes in the following format
# --------------------------------------
# Node No: xxxx (dec)
# Address of Current Node: xxxx (hex)
# Address of Next Node: xxxx (hex)
# Data Value of Current Node: xxx (dec)
# --------------------------------------

	# Save $s registers used
	addi	$sp, $sp, -20
	sw	$s0, 16($sp)
	sw	$s1, 12($sp)
	sw	$s2, 8($sp)
	sw	$s3, 4($sp)
	sw	$ra, 0($sp) 	# Save $ra just in case we may want to call a subprogram
	

	# $a0: points to the linked list.
	# $s0: Address of current
	# s1: Address of next
	# $2: Data of current
	# $s3: Node counter: 1, 2, ...
	move $s0, $a0	# $s0: points to the current node.
	li   $s3, 0
	la $a0,elementsPrompt
	li $v0,4
	syscall
	printNextNode:
		beq	$s0, $zero, printedAll
		# $s0: Address of current node
		lw	$s1, 0($s0)	# $s1: Address of  next node
		lw	$s2, 4($s0)	# $s2: Data of current node
		addi	$s3, $s3, 1

		
		move	$a0, $s2	# $s2: Data of current node
		li	$v0, 1		
		syscall	
		
		la $a0,seperator
		li $v0,4
		syscall
		

	# Now consider next node.
		move $s0, $s1	# Consider next node.
		j printNextNode
	printedAll:
		# Restore the register values
		move $v0, $s4
		lw	$ra, 0($sp)
		lw	$s3, 4($sp)
		lw	$s2, 8($sp)
		lw	$s1, 12($sp)
		lw	$s0, 16($sp)
		addi	$sp, $sp, 20
		jr	$ra
displayReverseOrderRecursively:
	#a0 is the adress of L1 head
	move $s0,$a0
	#a1 is the size
	move $s1,$a1
	#printing prompt
	la $a0, reversePrompt
	li $v0, 4
	syscall
	#set counter to 1
	addi $s2,$zero,1
	printReverseRecursively:
		beq $sp,$zero,done
		#decrease sp
		subi $sp, $sp, 8
		sw $s0, 0($sp)
		sw $ra, 4($sp)
		#beq $s0,$zero,done
		bne $s0, $zero, printingWorksHere
		addi $sp, $sp, 8
		jr $ra
	printingWorksHere:
		lw $s0, 0($s0)	
		jal printReverseRecursively
		lw $ra, 4($sp)
		lw $s0, 0($sp)
		addi $sp, $sp, 8
		# displaying number
		lw $a0, 4($s0)
		li $v0, 1
		syscall	
	
		# seperator 
		la $a0, seperator
		li $v0, 4
		syscall
	
		#increment counter by 1
		#addi $s2,$s2,1
	
		#exit conditions from loop
		beq $s2,$s1,done
	
		# return back
		#li $v0, 0	
		jr $ra	
	beq $s0,$zero,done
done:
	# exit
	li $v0,10
	syscall	
	
		
.data
welcomePrompt: .asciiz "----Display Reverse Order Recursive----"
size1Prompt: .asciiz "Enter the size of linked list: "

seperator: .asciiz " "
elementsPrompt: .asciiz "Linked list elements: "
newLine: .asciiz "\n"
reversePrompt: .asciiz "Linked List elements in reverse order: " 
