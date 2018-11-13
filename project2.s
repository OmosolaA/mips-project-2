.data
  emptyInput:   .asciiz "Input is empty."
  invalidInput: .asciiz "Invalid base-33 number."
  longInput:    .asciiz "Input is too long"
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
  li $a1, 16
  syscall

  la $t0, userInput
get_str_len:
  lb $t1, 0($t0)
  beq $t1, $zero, after_get_str_len
  addi $t0, $t0, 1
  j get_str_len
after_get_str_len:
  la $t1, userInput
  sub $t2, $t0, $t1
  addi $s0, $t2, -1 # s0 has input len (without null term)

beq $s0, $zero, err_empty_input 

delete_left_pad:
  li $t8, 32      #Save space character to t8
  lb $t9, 0($a0)
  beq $t8, $t9, remove_first_char
  move $t9, $a0
  j print_str_char

remove_first_char:
  addi $a0, $a0, 1
  j delete_left_pad

addi $t0, $s0, 0
print_str_char:
  la $a1, userInput
  sub $t1, $s0, $t0
  addu $a1, $a1, $t1
  lbu $a0, ($a1) # a0 has character at index t1
  li $v0, 11
  syscall
  sub $t0, $t0, 1
  beq $t0, $zero, exit
  j print_str_char

exit:
  li $v0, 10
  syscall
