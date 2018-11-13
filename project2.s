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

  li $v0, 10
  syscall
