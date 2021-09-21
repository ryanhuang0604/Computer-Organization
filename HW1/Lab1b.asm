.data
msg1:	.asciiz "0513353 Lab1b, Enter the number n = "
star:	.asciiz "*"
blank:	.asciiz " "
nextline:	.asciiz "\n"

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
	move $s0, $a0
	
# jump to procedure Loop
  	jal Loop1
  	
 .text 	
#------------------------- procedure Loop -----------------------------
#Loop1
Loop1:		li $t0, 0
		li $t1, 0
		addi $t2, $a0, -1		
		addi $t3, $a0, -1
		addi $t4, $a0, 0
		jal Loop2
		
Loop2:		slt $t7, $t0, $t2
		beq $t7, $zero, Loop3
		addi $t0, $t0, 1
		li $t1, 0
		jal L1
#印空白
L1:		slt $t7, $t1, $t3
		beq $t7, $zero, L2
		addi $t1, $t1, 1
		li $v0, 4			
		la $a0, blank			
		syscall  
		jal L1
# 印星星		
L2:		addi $t3, $t3, -1
		li $t1, 0
		jal L3

L3:		slt $t7, $t1, $t4
		beq $t7, $zero, L4
		addi $t1, $t1, 1
		li $v0, 4		
		la $a0, star			
		syscall  
		jal L3
		
L4:		addi $t4, $t4, 2
		li $v0, 4			
		la $a0, nextline		
		syscall  		
		jal Loop2

#Loop2
Loop3:		li $t0, 0
		li $t1, 0
		addi $t2, $s0, 0		
		li $t3, 0
		addi $t4, $s0, 0
		add $t4, $t4, $s0
		add $t4, $t4, $s0
		addi $t4, $t4, -2
		jal Loop4
			
Loop4:		slt $t7, $t0, $t2
		beq $t7, $zero, Loop5
		addi $t0, $t0, 1
		li $t1, 0
		jal L5
#印空白
L5:		slt $t7, $t1, $t3
		beq $t7, $zero, L6
		addi $t1, $t1, 1
		li $v0, 4		
		la $a0, blank			
		syscall  
		jal L5
		
L6:		addi $t3, $t3, 1
		li $t1, 0
		jal L7
#印星星
L7:		slt $t7, $t1, $t4
		beq $t7, $zero, L8
		addi $t1, $t1, 1
		li $v0, 4		
		la $a0, star		
		syscall  
		jal L7
		
L8:		addi $t4, $t4, -2
		li $v0, 4		
		la $a0, nextline		
		syscall  		
		jal Loop4

#END
Loop5:		li $v0, 4			
		la $a0, nextline		
		syscall  
		li $v0, 10			
  		syscall	
