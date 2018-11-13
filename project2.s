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

exit:
  li $v0, 10
  syscall
