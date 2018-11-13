.data
  emptyInput:   .asciiz "Input is empty."
  invalidInput: .asciiz "Invalid base-33 number."
  longInput:    .asciiz "Input is too long"
  userInput:    .space  512

.text
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
  addi $a0, $t2, -1
  li $v0, 1
  syscall

  li $v0, 10
  syscall
