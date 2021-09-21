.data
msg1:	.asciiz "0513353 Lab1a, Enter the number n = "

.text
.globl main
#------------------------- main -----------------------------
main:
# print msg1 on the console interface
	li $v0, 4				# call system call: print string
	la $a0, msg1				# load address of string into $a0
	syscall                 		# run the syscall
 
# read the input integer in $v0
 	li $v0, 5	          		# call system call: read integer
  	syscall                 		# run the syscall
  	move $a0, $v0      			# store input in $a0 (set arugument of procedure fibonacci)

# jump to procedure fibonacci
  	jal fibonacci

# print the result of procedure factorial on the console interface
	move $a0, $v0			
	li $v0, 1				# call system call: print integer
	syscall 				# run the syscall

	li $v0, 10				# call system call: exit
  	syscall					# run the syscall

#------------------------- procedure fibonacci -----------------------------
# load argument n in a0, return value in v0. 
.text
fibonacci:		addi $sp, $sp, -8		# adiust stack for 2 items
		sw $ra, 4($sp)			# save the return address
		sw $a0, 0($sp)			# save the argument n
		slti $t0, $a0, 2		# test for n > 1
		beq $t0, $zero, L1		# if n > 1, go to L1
		beq $a0, $zero, L2		# if n = 0 , go to L2		
		addi $v0, $zero, 1		# return 1
		addi $sp, $sp, 8		# pop 2 items off stack
		jr $ra				# return to caller
L1:		
		addi $a0, $a0, -1		# if n > 1, argument gets (n-1)
		jal fibonacci			# call factorial with (n-1)
		addi $sp, $sp, -4
		sw $v0, 0($sp)			#store v0
		
		lw $a0, 4($sp)			#pop n
		addi $a0, $a0, -2		# if n > 1, argument gets (n-2)
		jal fibonacci			# call factorial with (n-2)
		lw $t1, 0($sp)
		add $v0, $v0, $t1
		lw $ra, 8($sp)			# restore the return address
		addi $sp, $sp, 12		# adjust stack pointer to pop 2 items
		
		jr $ra				# return to the caller
L2:
		addi $v0, $zero, 0		# return 0
		addi $sp, $sp, 8		# pop 2 items off stack
		jr $ra				# return to caller
