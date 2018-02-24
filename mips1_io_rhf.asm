# MIPS I/O
# Coursera HW1_1
# by Hanfei on 18/02/21

	.data 
upper_dic:	.asciiz	# output of upper char
		"Alpha","Bravo","China","Delta","Echo","Foxtrot","Golf","Hotel","India","Juliet","Kilo","Lima","Mary","November","Oscar","Paper","Quebec","Research","Sierra","Tango","Uniform","Victor","Whisky","X-Ray","Yankee","Zulu"
	
lower_dic:	.asciiz	# output of lower char
		"alpha","bravo","china","delta","echo","foxtrot","golf","hotel","india","juliet","kilo","lima","mary","november","oscar","paper","quebec","research","sierra","tango","uniform","victor","whisky","x-ray","yankee","zulu"

char_addr:	.word	# address offset of words ('\0' counts)
		0,6,12,18,24,29,37,42,48,54,61,66,71,76,85,91,97,104,113,120,126,134,141,148,154,161
		
num_dic:	.asciiz	# output of num
		"zero","First","Second","Third","Fourth","Fifth","Sixth","Seventh","Eighth","Ninth"

num_addr:	.word	# address offset of nums
		0,5,11,18,24,31,37,43,51,58

	
	.text
	.globl main
main:	li $v0,12	# 12 is the service number of character reading
	syscall
	
	move $t0,$v0
	li $t1,'?'
	beq $t0,$t1,exit	# exit if '?'
	
	sltiu $t1,$t0,65	# A-Z(65-90) if input < 65, $t1 = 1
	bnez $t1,case_num	# input < 65
	sltiu $t1,$t0,91	# if input < 91, $t1 = 1
	beqz $t1,case_lower	# input >= 91
	
	j case_upper		# A-Z
	

case_upper:	li $a0,'\n'		# print '\n'
		li $v0,11
		syscall
		sub $t1,$t0,65
		sll $t1,$t1,2		# multiply 4 (word: 4 bytes)
		la $s0,char_addr	# start address of char offsets
		add $s0,$s0,$t1		# offset
		lw $s1,($s0)		# save the offset in $s1
		la $a0,upper_dic	# start address of upper dic
		add $a0,$a0,$s1		# address of the target word
		li $v0,4
		syscall
		li $a0,'\n'		# print '\n'
		li $v0,11
		syscall
		
		j main
		

case_lower:	sltiu $t1,$t0,97	# a-z(97-122) if input < 97, $t1 = 1
		bnez   $t1,other	# 91 <= input < 97
		sltiu $t1,$t0,123	# if input < 123, $t1 = 1
		beqz $t1,other	# input >= 123
		
		li $a0,'\n'		# print '\n'
		li $v0,11
		syscall
		sub $t1,$t0,97
		sll $t1,$t1,2		# multiply 4 (word: 4 bytes)
		la $s0,char_addr	# start address of char offsets
		add $s0,$s0,$t1		# offset
		lw $s1,($s0)		# save the offset in $s1
		la $a0,lower_dic	# start address of lower dic
		add $a0,$a0,$s1		# address of the target word
		li $v0,4
		syscall
		li $a0,'\n'		# print '\n'
		li $v0,11
		syscall
		
		j main
		

case_num:	sltiu $t1,$t0,48	# 0-9(48-57) if input < 48, $t1 = 1
		bnez   $t1,other	# input < 48
		sltiu $t1,$t0,58	# if input < 58, $t1 = 1
		beqz $t1,other		# 59 <= input < 65
		
		li $a0,'\n'		# print '\n'
		li $v0,11
		syscall
		sub $t1,$t0,48
		sll $t1,$t1,2		# multiply 4 (word: 4 bytes)
		la $s0,num_addr		# start address of num offsets
		add $s0,$s0,$t1		# offset
		lw $s1,($s0)		# save the offset in $s1
		la $a0,num_dic		# start address of num dic
		add $a0,$a0,$s1		# address of the target word
		li $v0,4
		syscall
		li $a0,'\n'		# print '\n'
		li $v0,11
		syscall
		
		j main
		
		
other:	li $a0,'\n'		# print '\n'
	li $v0,11
	syscall
	li $a0,'*'	# no match, print '*'
	li $v0,11	# print string
	syscall
	li $a0,'\n'		# print '\n'
	li $v0,11
	syscall
	j main


exit:	li $v0,10	# 10 is the service number of exit
	syscall

# End of program, leave a blank line afterwards to make MIPS happy 
