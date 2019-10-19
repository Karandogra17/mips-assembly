  .data
    endl:    .asciiz  "\n"   # used for cout << endl;
    sumlbl:    .asciiz  "Sum: " # label for sum
    revlbl:    .asciiz  "Reversed Number: " # label for rev
    pallbl:    .asciiz  "Is Palindrome: " # label for isPalindrome
    sumarr:    .word 1
               .word 3
               .word 44
               .word 66
               .word 88
               .word 90
               .word 9
               .word 232
               .word 4325
               .word 2321
    arr:       .word 1
               .word 2
               .word 3
               .word 4
               .word 5
               .word 4
               .word 3
               .word 2
               .word 1

.text

# sum               --> $s0
# address of sumarr --> $s1
# rev               --> $s2
# num               --> $s3
# isPalindrome      --> $s4
# address of arr    --> $s5
# i                 --> $t0
# beg               --> $s6
# end               --> $s7
# d                 --> $t1
# 10                --> $t2
# 100               --> $t3
main:
 la $s1, sumarr                       # puts address of summarr in $s1
 la $s5, arr                          # puts address of arr in $s5
 
 addi $t2, $0, 10                     # $t2 = 10
 addi $t3, $0, 100                    # $t3 = 100
 add $s0, $0, $0                      # sum = 0
 add $t0, $0, $0                      # i = 0
 
for_loop:
 beq $t0, $t2, end_for_loop           # i < 10 go to next line
 lw $t4, 0($s1)                       # x = sumarr[0]
 addi $s1, $s1, 4                     # summarr = sumarr + 1
 add $s0, $s0, $t4                    # sum = sum + sumarr[i]
 addi $t0, $t0, 1                     # i = i + 1
 j for_loop

end_for_loop:
 addi $s3, $0, 45689                  # num = 45689
 addi $s2, $0, 0                      # rev  = 0
 addi $t1, $0, -1                     # d = -1 

first_while_loop:
 beq $s3, $0, end_first_while_loop    # num == 0 go to end of while loop
 div $s3, $t2                         # num / 10
 mfhi $t1                             # d = num % 10
 mul $t5, $s2, $t2                    # y = rev * 10
 add $s2, $t5, $t1                    # rev = y + d
 div $s3, $t2
 mflo $s3                             # num = num /10
 j first_while_loop

end_first_while_loop:
 addi $s6, $s6, 0                     # beg = 0
 addi $s7, $s7, 8                     # end = 8
 addi $s4, $s4, 1                     # isPalindrome = 1
 
second_while_loop:
 beq $s6, $s7, exit                   # beg == end go to exit
 
 mul $t4, $s6, 4                      # x = beg * 4
 add $t5, $s5, $t4                    # y = address of arr + x 
 lw $t6 , 0($t5)                      # z = arr[beg]
 
 mul $t7, $s7, 4                      # a = end * 4
 add $t8, $s5, $t7                    # b = address of arr + a
 lw $t9 , 0($t5)                      # c = arr[end]
 
 bne $t6, $t9, inside_if              # arr[beg] != arr[end]                
 addi $s6, $s6, 1                     # beg++
 addi $s7, $s7, -1                    # end--
 j second_while_loop                  # jumps to second while loop
  
 inside_if:
 addi $s4, $0, -1                     # isPalindrome = -1
 j exit


exit:
  la   $a0, sumlbl    # puts sumlbl into arg0 (a0 register) for cout
  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing a string
  syscall             # make a syscall to system

  move $a0, $s0       # puts sum into arg0 (a0 register) for cout
  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int
  syscall             # make a syscall to system

  la   $a0, endl      # puts the address of the string endl into a0
  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string
  syscall

  la   $a0, revlbl    # puts revlbl into arg0 (a0 register) for cout
  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing an string
  syscall             # make a syscall to system

  move $a0, $s2       # puts rev into arg0 (a0 register) for cout
  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int
  syscall             # make a syscall to system

  la   $a0, endl      # puts the address of the string endl into a0
  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string
  syscall

  la   $a0, pallbl    # puts pallbl into arg0 (a0 register) for cout
  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing a string
  syscall             # make a syscall to system

  move $a0, $s4       # puts isPalindrome into arg0 (a0 register) for cout
  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int
  syscall             # make a syscall to system

  la   $a0, endl      # puts the address of the string endl into a0
  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string
  syscall


  addi $v0,$0, 10
  syscall
