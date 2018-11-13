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

  li $t0, $zero
get_str_len:
  lb $t1, $t0
  beq $t1, $zero, end
  j get_str_len


  li $v0, 10
  syscall
