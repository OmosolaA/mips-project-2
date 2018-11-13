.data
  emptyInput:   .asciiz "Input is empty."
  invalidInput: .asciiz "Invalid base-33 number."
  longInput:    .asciiz "Input is too long."
  userInput:    .space  512

.text
err_empty_input:
  la $a0, emptyInput
  li $v0, 4
  syscall
  j exit

err_invalid_input:
  la $a0, invalidInput
  li $v0, 4
  syscall
  j exit

err_long_input:
  la $a0, longInput
  li $v0, 4
  syscall
  j exit

main:
  li $v0, 8
  la $a0, userInput
  li $a1, 100
  syscall

delete_left_pad:
	li $t8, 32 # space
	lb $t9, 0($a0)
	beq $t8, $t9, delete_first_char
	move $t9, $a0
	j input_len

delete_first_char:
	addi $a0, $a0, 1
	j delete_left_pad

input_len:
	addi $t0, $t0, 0
	addi $t1, $t1, 10
	add $t4, $t4, $a0

len_iteration:
	lb $t2, 0($a0)
	beqz $t2, after_len_found
	beq $t2, $t1, after_len_found
	addi $a0, $a0, 1
	addi $t0, $t0, 1
	j len_iteration

after_len_found:
	beqz $t0, err_empty_input
	slti $t3, $t0, 5
	beqz $t3, err_long_input
	move $a0, $t4
	j check_str

check_str:
	lb $t5, 0($a0)
	beqz $t5, prepare_for_conversion
	beq $t5, $t1, prepare_for_conversion
	slti $t6, $t5, 48                 # if char < ascii(48),  input invalid,   ascii(48) = 0
	bne $t6, $zero, err_invalid_input
	slti $t6, $t5, 58                 # if char < ascii(58),  input is valid,  ascii(58) = 9
	bne $t6, $zero, step_char_forward
	slti $t6, $t5, 65                 # if char < ascii(65),  input invalid,   ascii(97) = A
	bne $t6, $zero, err_invalid_input
	slti $t6, $t5, 88                 # if char < ascii(88),  input is valid,  ascii(88) = X
	bne $t6, $zero, step_char_forward
	slti $t6, $t5, 97                 # if char < ascii(97),  input invalid,   ascii(97) = a
	bne $t6, $zero, err_invalid_input
	slti $t6, $t5, 120                # if char < ascii(120), input is valid, ascii(120) = x
	bne $t6, $zero, step_char_forward
	bgt $t5, 119, err_invalid_input   # if char > ascii(119), input invalid,  ascii(119) = w

step_char_forward: # step one character ahead
	addi $a0, $a0, 1
	j check_str

prepare_for_conversion:
	move $a0, $t4
	addi $t7, $t7, 0
	add $s0, $s0, $t0
	addi $s0, $s0, -1	
	li $s3, 3
	li $s2, 2
	li $s1, 1
	li $s5, 0

exit:
  li $v0, 10
  syscall
