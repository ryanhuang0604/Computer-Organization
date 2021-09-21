.data
msg1:	.asciiz "0513353 Lab1c, Enter the number n = "
msg2:	.asciiz " is a prime"
msg3:	.asciiz " is not a prime, the nearest prime is "
blank:	.asciiz  " "

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
  	move $a0, $v0      			# store input in $a0 
  	move $a2, $a0
  	jal Loop1
	
# prime 	
Loop1:		move $a1, $a0
		li $t0, 2
		li $t3, 2
		jal L1
		
L1:		slt $t1, $t0, $a1		# for i = 2 ~ n
		beq $t1, $zero, L3
		div $a1, $t0
		mfhi $t2			# t2: remainder of a1 / t0
		addi $t0, $t0, 1
		beq $t2, $zero, L2
		jal L1

L2:		li $t3, 0			# not prime
		jal Loop2
		
L3:		li $t3, 1			# is prime
		jal Loop2

Loop2:		beq $t3, $zero, L4		# is prime;    not prime: L4
		li $v0, 1				# call system call: print integer
		syscall	
		li $v0, 4				# call system call: print string
		la $a0, msg2				# load address of string into $a0
		syscall
		li $v0, 10				# call system call: exit
  		syscall					
  		  		
L4:		li $v0, 1				# call system call: print integer
		syscall	
		li $v0, 4				# call system call: print string
		la $a0, msg3				# load address of string into $a0
		syscall
		jal L
		
L:		li $s6, -1
		li $s7, 1
		jal L5
		
L5:		add $t3, $a2, $s6			# t3 prime?
		add $t4, $a2, $s7			# t4 prime?
		jal Loop3
		
# prime		
Loop3:		li $t0, 2
		li $t5, 2
		jal L6
		
L6:		slt $t1, $t0, $t3		# for i = 2 ~ n
		beq $t1, $zero, L8
		div $t3, $t0
		mfhi $t2			# t2: remainder of a1 / t0
		addi $t0, $t0, 1
		beq $t2, $zero, L7
		jal L6

L7:		li $t5, 0			# not prime
		jal Loop4
		
L8:		li $t5, 1			# is prime		
		jal Loop4
# prime	
Loop4:		li $t0, 2
		li $t6, 2
		jal L9
		
L9:		slt $t1, $t0, $t4		# for i = 2 ~ n
		beq $t1, $zero, L11
		div $t4, $t0
		mfhi $t2			# t2: remainder of a1 / t0
		addi $t0, $t0, 1
		beq $t2, $zero, L10
		jal L9

L10:		li $t6, 0			# not prime
		jal Loop5
		
L11:		li $t6, 1			# is prime		
		jal Loop5

# print		
Loop5:		beq $t5, $zero, L12
		move $a0, $t3
		li $v0, 1				# call system call: print integer
		syscall
		li $v0, 4				# call system call: print string
		la $a0, blank				# load address of string into $a0
		syscall
		jal L12
L12:		beq $t6, $zero, L13
		move $a0, $t4
		li $v0, 1				# call system call: print integer
		syscall
		jal L13
L13:		beq $t5, $t6, L14			# one prime, one not prime
		li $v0, 10				# call system call: exit
  		syscall
L14:		beq $t5, $zero, L15			# two prime
		li $v0, 10				# call system call: exit
  		syscall
 L15:		addi $s6, $s6, -1			# no prime
 		addi $s7, $s7, 1
 		jal L5
