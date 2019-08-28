       addi  $s0, $zero, 55
       addi  $t1, $zero, 0     # $t1 = 0;
       addi  $t2, $zero, 1     # $t2 = 1;
       addi  $t3, $zero, 0     # $t3 = sum 
while: beq $t1, $s0, Exit  #if t1 == 55 exit the program
       add $t3, $t1, $t2
       addi $t1, $t2, 0
       addi $t2, $t3, 0
       j while
Exit: sw $t3, ($a0)