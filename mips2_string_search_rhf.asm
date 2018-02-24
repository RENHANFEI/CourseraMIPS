# MIPS String Search
# Coursera HW1_2
# by Hanfei on 18/02/23

	.data
success_note:	.asciiz	"\nSuccess! Location: "

fail_note:	.asciiz	"\nFail!\n"

string_input:	.space 100	# max size of string

char_to_search:	.byte

location:	.word


	.text
	.globl main
main:	la $a0,string_input	# get the string address
	li $a1,100	# string max size
	li $v0,8	# 8 is the service number of string reading
	syscall
	
	j search
	
	
search:	li $v0,12
	syscall
	move $t0,$v0	# char to search
	
	li $t1,'?'
	beq $t0,$t1,exit	# exit if '?'
	
	li $t2,0	# record the start location
	j loop
	
	
loop:	lb $t3,string_input($t2)	# get current address
	beq $t3,'\n',search
	beq $t3,'\0',fail
	beq $t0,$t3,succ
	addi $t2,$t2,1
	j loop
	

fail:	li $v0,4	# print string
	la $a0,fail_note
	syscall
	
	j search


succ:	li $v0,4	# print string
	la $a0,success_note
	syscall
	
	li $v0,1	# print integer
	move $a0,$t2
	syscall
	
	li $a0,'\n'	# print '\n'
	li $v0,11
	syscall
	
	j search
	


exit:	li $v0,10	# 10 is the service number of exit
	syscall


# End of program, leave a blank line afterwards to make MIPS happy 
