import os
import random

#The following three lists are used for instruction classification
R_opcodes=["000000"]
J_opcodes=["000010","000011"]
Coprocessor_opcodes=["010000","010001","010010","010011"]

#The following list is a data structure modifying the real registers
register_list=["00000000000000000000000000000000","","","","","","","","","","","","",
              "","","","","","","","","","","","","","","","","","",""]

#Two special register for mult and div operations
Lo=Hi=""

#PC counter, which is used for stepping in and jumping during program execution
PC=0

#The following codes define a analog memory data structure, the size is 1MB,
#and the size for storing instructions is 4KB
instruction_length=2**12
memory_size=2**20
memory=[]
for i in range(0,memory_size):
    memory.append("")

#This function returns the 2's complement of the given binary string
def twos_complement(binary):
    i=len(binary)-1
    while i>0:
        if binary[i]=="1":
            break
        else:
            i-=1
    if i!=0:
        trans_binary=binary[:i]
        untrans_binary=binary[i:]
        trans_binary_list=list(trans_binary)
        for i in range(0,len(trans_binary_list)):
            if trans_binary_list[i]=="0":
                trans_binary_list[i]="1"
            else:
                trans_binary_list[i]="0"
        trans_binary="".join(trans_binary_list)
        binary=trans_binary+untrans_binary
    return binary

#This function transform the binary to decimal
#The last parameter decides whether to a signed integer or not signed
def binaryToInt(binary,signed=0):
    sum=0
    if not signed:
        for i in range(0,len(binary)):
            sum+=2**(len(binary)-i-1)*int(binary[i])
    else:
        for i in range(0,len(binary)):
            if i==0:
                sum-=2**(len(binary)-i-1)*int(binary[i])
            else:
                sum+=2**(len(binary)-i-1)*int(binary[i])
    return sum

#This function transform the decimal to binary
def intToBinary(number,length): 
    try: 
        decimal=int(number)
    except:
        decimal=number
    if "-" in str(decimal): 
        binary=str(bin(decimal))[3:]
    else:
        binary=str(bin(decimal))[2:] 
    real_length=len(binary) 
    if real_length<=length: 
        difference=length-real_length
        i=0
        while i<difference:
            binary="0"+binary
            i+=1
    else:
        print("Overflow error occurs!")
        os._exit(0)
    if not "-" in str(decimal): 
        return binary
    else: 
        return twos_complement(binary)

#This function can extend the binary to the expected length
#The last parameter dicides whether the extension is signed or unsigned
def extend(binary,length,signed):
    if len(binary)<length:
        if signed:
            return intToBinary(binaryToInt(binary,1),length)
        elif not signed:
            difference=length-len(binary)
            binary="0"*difference+binary
            return binary

#This function can directly do the adding between two binary strings
#The third parameter decides whether there's an overflow check
#The last parameter dicides whether need to do signed completion
def binary_add(adder1,adder2,overflow_check,signed_completion=1):
    if len(adder1)<len(adder2):
        adder1=extend(adder1,len(adder2),signed_completion)
    if len(adder1)>len(adder2):
        adder2=extend(adder2,len(adder1),signed_completion)
    sum=""
    carry="0"
    for i in range(len(adder1)-1,-1,-1):
        add_list=[adder1[i],adder2[i],carry]
        if add_list.count("1")==0:
            carry="0"
            sum="0"+sum
        if add_list.count("1")==1:
            carry="0"
            sum="1"+sum
        if add_list.count("1")==2:
            carry="1"
            sum="0"+sum
        if add_list.count("1")==3:
            carry="1"
            sum="1"+sum
    if overflow_check:
        if adder1[0]==adder2[0] and sum[0]!=adder1[0]:
            print("Overflow error occurs!")
            os._exit(0)
        else:
            return sum
    else:
        return sum

#The following functions do the corresponding MIPS operations
#They mainly modify the data stored in memory and register list
#For those jumping or linking functions, PC will go the specified
#address, and PC will increase 4 in other functions
def MIPS_add(rd,rs,rt):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rs)
    reg_3=binaryToInt(rt)
    adder1=register_list[reg_2]
    adder2=register_list[reg_3]
    register_list[reg_1]=binary_add(adder1,adder2,1)
    PC+=4

def MIPS_addu(rd,rs,rt):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rs)
    reg_3=binaryToInt(rt)
    adder1=register_list[reg_2]
    adder2=register_list[reg_3]
    register_list[reg_1]=binary_add(adder1,adder2,0)
    PC+=4

def MIPS_sub(rd,rs,rt):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rs)
    reg_3=binaryToInt(rt)
    minuend=register_list[reg_2]
    subtrahend=register_list[reg_3]
    register_list[reg_1]=binary_add(minuend,twos_complement(subtrahend),1)
    PC+=4

def MIPS_subu(rd,rs,rt):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rs)
    reg_3=binaryToInt(rt)
    minuend=register_list[reg_2]
    subtrahend=register_list[reg_3]
    register_list[reg_1]=binary_add(minuend,twos_complement(subtrahend),0)
    PC+=4

def MIPS_mult(rs,rt):
    global Hi, Lo, PC
    reg_2=binaryToInt(rs)
    reg_3=binaryToInt(rt)
    int2=binaryToInt(register_list[reg_2],1)
    int3=binaryToInt(register_list[reg_3],1)
    int1=int2*int3
    Hi=intToBinary(int1,64)[0:32]
    Lo=intToBinary(int1,64)[32:64]
    PC+=4

def MIPS_multu(rs,rt):
    global Hi, Lo, PC
    reg_2=binaryToInt(rs)
    reg_3=binaryToInt(rt)
    int2=binaryToInt(register_list[reg_2],0)
    int3=binaryToInt(register_list[reg_3],0)
    int1=int2*int3
    Hi=intToBinary(int1,64)[0:32]
    Lo=intToBinary(int1,64)[32:64]
    PC+=4

def MIPS_div(rs,rt):
    global Hi, Lo, PC
    reg_2=binaryToInt(rs)
    reg_3=binaryToInt(rt)
    divident=binaryToInt(register_list[reg_2],1)
    divisor=binaryToInt(register_list[reg_3],1)
    if divisor==0:
        print("The machine code is wrong!")
        os._exit(0)
    if (divident>0 and divisor>0) or (divident<0 and divisor<0):
        quotient=divident//divisor
    if divident>0 and divisor<0:
        quotient=-(divident//(-divisor))
    if divident<0 and divisor>0:
        quotient=-((-divident)//divisor)
    if divident==0:
        quotient=0
    remainder=divident-divisor*quotient
    Lo=intToBinary(quotient,32)
    Hi=intToBinary(remainder,32)
    PC+=4
    
def MIPS_divu(rs,rt):
    global Hi, Lo, PC
    reg_2=binaryToInt(rs)
    reg_3=binaryToInt(rt)
    divident=binaryToInt(register_list[reg_2],0)
    divisor=binaryToInt(register_list[reg_3],0)
    quotient=divident//divisor
    remainder=divident%divisor
    Lo=intToBinary(quotient,32)
    Hi=intToBinary(remainder,32)
    PC+=4

def MIPS_mflo(rd):
    global PC
    reg_1=binaryToInt(rd)
    register_list[reg_1]=Lo
    PC+=4

def MIPS_mfhi(rd):
    global PC
    reg_1=binaryToInt(rd)
    register_list[reg_1]=Hi
    PC+=4

def MIPS_mtlo(rs):
    global Lo, PC
    reg_2=binaryToInt(rs)
    Lo=register_list[reg_2]
    PC+=4

def MIPS_mthi(rs):
    global Hi, PC
    reg_2=binaryToInt(rs)
    Hi=register_list[reg_2]
    PC+=4

def MIPS_and(rd,rs,rt):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rs)
    reg_3=binaryToInt(rt)
    binary1=""
    binary2=register_list[reg_2]
    binary3=register_list[reg_3]
    for i in range(0,len(binary2)):
        if binary2[i]=="0" or binary3[i]=="0":
            binary1+="0"
        else:
            binary1+="1"
    register_list[reg_1]=binary1
    PC+=4

def MIPS_or(rd,rs,rt):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rs)
    reg_3=binaryToInt(rt)
    binary1=""
    binary2=register_list[reg_2]
    binary3=register_list[reg_3]
    for i in range(0,len(binary2)):
        if binary2[i]=="0" and binary3[i]=="0":
            binary1+="0"
        else:
            binary1+="1"
    register_list[reg_1]=binary1
    PC+=4

def MIPS_nor(rd,rs,rt):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rs)
    reg_3=binaryToInt(rt)
    binary1=""
    binary2=register_list[reg_2]
    binary3=register_list[reg_3]
    for i in range(0,len(binary2)):
        if binary2[i]=="0" and binary3[i]=="0":
            binary1+="1"
        else:
            binary1+="0"
    register_list[reg_1]=binary1
    PC+=4

def MIPS_xor(rd,rs,rt):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rs)
    reg_3=binaryToInt(rt)
    binary1=""
    binary2=register_list[reg_2]
    binary3=register_list[reg_3]
    for i in range(0,len(binary2)):
        if binary2[i]==binary3[i]:
            binary1+="0"
        else:
            binary1+="1"
    register_list[reg_1]=binary1
    PC+=4

def MIPS_sll(rd,rt,sa):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rt)
    position=binaryToInt(sa,0)
    binary=register_list[reg_2]
    count=0
    while count<position:
        binary=binary[1:]+"0"
        count+=1
    register_list[reg_1]=binary
    PC+=4

def MIPS_srl(rd,rt,sa):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rt)
    position=binaryToInt(sa,0)
    binary=register_list[reg_2]
    count=0
    while count<position:
        binary="0"+binary[0:-1]
        count+=1
    register_list[reg_1]=binary
    PC+=4

def MIPS_sra(rd,rt,sa):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rt)
    position=binaryToInt(sa,0)
    binary=register_list[reg_2]
    count=0
    while count<position:
        binary=binary[0]+binary[0:-1]
        count+=1
    register_list[reg_1]=binary
    PC+=4

def MIPS_sllv(rd,rt,rs):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rt)
    reg_3=binaryToInt(rs)
    position=binaryToInt(register_list[reg_3],0)
    binary=register_list[reg_2]
    count=0
    while count<position:
        binary=binary[1:]+"0"
        count+=1
    register_list[reg_1]=binary
    PC+=4

def MIPS_srlv(rd,rt,rs):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rt)
    reg_3=binaryToInt(rs)
    position=binaryToInt(register_list[reg_3],0)
    binary=register_list[reg_2]
    count=0
    while count<position:
        binary="0"+binary[0:-1]
        count+=1
    register_list[reg_1]=binary
    PC+=4

def MIPS_srav(rd,rt,rs):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rt)
    reg_3=binaryToInt(rs)
    position=binaryToInt(register_list[reg_3],0)
    binary=register_list[reg_2]
    count=0
    while count<position:
        binary=binary[0]+binary[0:-1]
        count+=1
    register_list[reg_1]=binary
    PC+=4

def MIPS_slt(rd,rs,rt):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rs)
    reg_3=binaryToInt(rt)
    int2=binaryToInt(register_list[reg_2],1)
    int3=binaryToInt(register_list[reg_3],1)
    if int2<int3:
        register_list[reg_1]=intToBinary(1,32)
    else:
        register_list[reg_1]=intToBinary(0,32)
    PC+=4

def MIPS_sltu(rd,rs,rt):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rs)
    reg_3=binaryToInt(rt)
    int2=binaryToInt(register_list[reg_2],0)
    int3=binaryToInt(register_list[reg_3],0)
    if int2<int3:
        register_list[reg_1]=intToBinary(1,32)
    else:
        register_list[reg_1]=intToBinary(0,32)
    PC+=4

def MIPS_addi(rt,rs,im):
    global PC
    reg_1=binaryToInt(rt)
    reg_2=binaryToInt(rs)
    binary_im=extend(im,32,1)
    binary2=register_list[reg_2]
    register_list[reg_1]=binary_add(binary2,binary_im,1)
    PC+=4

def MIPS_addiu(rt,rs,im):
    global PC
    reg_1=binaryToInt(rt)
    reg_2=binaryToInt(rs)
    binary_im=extend(im,32,1)
    binary2=register_list[reg_2]
    register_list[reg_1]=binary_add(binary2,binary_im,0)
    PC+=4

def MIPS_andi(rt,rs,im):
    global PC
    reg_1=binaryToInt(rt)
    reg_2=binaryToInt(rs)
    binary_im=extend(im,32,0)
    binary1=""
    binary2=register_list[reg_2]
    for i in range(0,len(binary2)):
        if binary_im[i]=="0" or binary2[i]=="0":
            binary1+="0"
        else:
            binary1+="1"
    register_list[reg_1]=binary1
    PC+=4

def MIPS_ori(rt,rs,im):
    global PC
    reg_1=binaryToInt(rt)
    reg_2=binaryToInt(rs)
    binary_im=extend(im,32,0)
    binary1=""
    binary2=register_list[reg_2]
    for i in range(0,len(binary2)):
        if binary_im[i]=="0" and binary2[i]=="0":
            binary1+="0"
        else:
            binary1+="1"
    register_list[reg_1]=binary1
    PC+=4

def MIPS_xori(rt,rs,im):
    global PC
    reg_1=binaryToInt(rt)
    reg_2=binaryToInt(rs)
    binary_im=extend(im,32,0)
    binary1=""
    binary2=register_list[reg_2]
    for i in range(0,len(binary2)):
        if binary_im[i]==binary2[i]:
            binary1+="0"
        else:
            binary1+="1"
    register_list[reg_1]=binary1
    PC+=4

def MIPS_slti(rt,rs,im):
    global PC
    reg_1=binaryToInt(rt)
    reg_2=binaryToInt(rs)
    binary2=register_list[reg_2]
    int2=binaryToInt(binary2,1)
    int_im=binaryToInt(im,1)
    if int2<int_im:
        register_list[reg_1]=intToBinary(1,32)
    else:
        register_list[reg_1]=intToBinary(0,32)
    PC+=4

def MIPS_sltiu(rt,rs,im):
    global PC
    reg_1=binaryToInt(rt)
    reg_2=binaryToInt(rs)
    binary2=register_list[reg_2]
    int2=binaryToInt(binary2,0)
    int_im=binaryToInt(extend(im,32,1),0)
    if int2<int_im:
        register_list[reg_1]=intToBinary(1,32)
    else:
        register_list[reg_1]=intToBinary(0,32)
    PC+=4

def MIPS_lw(rt,rs,im):
    global PC
    reg_1=binaryToInt(rt)
    reg_2=binaryToInt(rs)
    binary2=register_list[reg_2]
    int2=binaryToInt(binary2,1)
    int_im=binaryToInt(im,1)
    address=int2+int_im
    register_list[reg_1]=memory[address]+memory[address+1]+memory[address+2]+memory[address+3]
    PC+=4

def MIPS_lh(rt,rs,im):
    global PC
    reg_1=binaryToInt(rt)
    reg_2=binaryToInt(rs)
    binary2=register_list[reg_2]
    int2=binaryToInt(binary2,1)
    int_im=binaryToInt(im,1)
    address=int2+int_im
    binary=memory[address]+memory[address+1]
    register_list[reg_1]=extend(binary,32,1)
    PC+=4

def MIPS_lb(rt,rs,im):
    global PC
    reg_1=binaryToInt(rt)
    reg_2=binaryToInt(rs)
    binary2=register_list[reg_2]
    int2=binaryToInt(binary2,1)
    int_im=binaryToInt(im,1)
    address=int2+int_im
    binary=memory[address]
    register_list[reg_1]=extend(binary,32,1)
    PC+=4

def MIPS_lhu(rt,rs,im):
    global PC
    reg_1=binaryToInt(rt)
    reg_2=binaryToInt(rs)
    binary2=register_list[reg_2]
    int2=binaryToInt(binary2,1)
    int_im=binaryToInt(im,1)
    address=int2+int_im
    binary=memory[address]+memory[address+1]
    register_list[reg_1]=extend(binary,32,0)
    PC+=4

def MIPS_lbu(rt,rs,im):
    global PC
    reg_1=binaryToInt(rt)
    reg_2=binaryToInt(rs)
    binary2=register_list[reg_2]
    int2=binaryToInt(binary2,1)
    int_im=binaryToInt(im,1)
    address=int2+int_im
    binary=memory[address]
    register_list[reg_1]=extend(binary,32,0)
    PC+=4

def MIPS_lui(rt,im):
    global PC
    reg_1=binaryToInt(rt)
    register_list[reg_1]=im+"0"*16
    PC+=4

def MIPS_sw(rt,rs,im):
    global PC
    reg_1=binaryToInt(rt)
    reg_2=binaryToInt(rs)
    binary2=register_list[reg_2]
    int2=binaryToInt(binary2,1)
    int_im=binaryToInt(im,1)
    address=int2+int_im
    memory[address]=register_list[reg_1][0:8]
    memory[address+1]=register_list[reg_1][8:16]
    memory[address+2]=register_list[reg_1][16:24]
    memory[address+3]=register_list[reg_1][24:32]
    PC+=4

def MIPS_sh(rt,rs,im):
    global PC
    reg_1=binaryToInt(rt)
    reg_2=binaryToInt(rs)
    binary2=register_list[reg_2]
    int2=binaryToInt(binary2,1)
    int_im=binaryToInt(im,1)
    address=int2+int_im
    memory[address]=register_list[reg_1][16:24]
    memory[address+1]=register_list[reg_1][24:32]
    PC+=4

def MIPS_sb(rt,rs,im):
    global PC
    reg_1=binaryToInt(rt)
    reg_2=binaryToInt(rs)
    binary2=register_list[reg_2]
    int2=binaryToInt(binary2,1)
    int_im=binaryToInt(im,1)
    address=int2+int_im
    memory[address]=register_list[reg_1][24:32]
    PC+=4

def MIPS_beq(rs,rt,im):
    global PC
    reg_1=binaryToInt(rs)
    reg_2=binaryToInt(rt)
    if register_list[reg_1]==register_list[reg_2]:
        PC=binaryToInt(im,0)*4
    else:
        PC+=4

def MIPS_bne(rs,rt,im):
    global PC
    reg_1=binaryToInt(rs)
    reg_2=binaryToInt(rt)
    if register_list[reg_1]!=register_list[reg_2]:
        PC=binaryToInt(im,0)*4
    else:
        PC+=4

def MIPS_bltz(rs,im):
    global PC
    reg_1=binaryToInt(rs)
    if binaryToInt(register_list[reg_1],1)<0:
        PC=binaryToInt(im,0)*4
    else:
        PC+=4

def MIPS_blez(rs,im):
    global PC
    reg_1=binaryToInt(rs)
    if binaryToInt(register_list[reg_1],1)<=0:
        PC=binaryToInt(im,0)*4
    else:
        PC+=4

def MIPS_bgtz(rs,im):
    global PC
    reg_1=binaryToInt(rs)
    if binaryToInt(register_list[reg_1],1)>0:
        PC=binaryToInt(im,0)*4
    else:
        PC+=4

def MIPS_bgez(rs,im):
    global PC
    reg_1=binaryToInt(rs)
    if binaryToInt(register_list[reg_1],1)>=0:
        PC=binaryToInt(im,0)*4
    else:
        PC+=4

def MIPS_j(label):
    global PC
    PC=binaryToInt(label,0)*4

def MIPS_jal(label):
    global PC
    register_list[31]=intToBinary(PC+4,32)
    PC=binaryToInt(label,0)*4

def MIPS_jr(rs):
    global PC
    reg_1=binaryToInt(rs)
    PC=binaryToInt(register_list[reg_1],0)*4

def MIPS_jalr(rd,rs):
    global PC
    reg_1=binaryToInt(rd)
    reg_2=binaryToInt(rs)
    register_list[reg_1]=intToBinary(PC+4,32)
    PC=binaryToInt(register_list[reg_2],0)*4


def MIPS_break():
    global PC
    PC=instruction_length

#This program supports 1,4,5,8,9,10,11,12 syscalls
def MIPS_syscall():
    global PC
    v0=binaryToInt(register_list[2])
    a0=register_list[4]
    a1=register_list[5]
    #print integer stored in a0 register
    if v0==1:
        print(binaryToInt(a0,1))
    #print integer stored in memory, the memory address was stored in a0 register,
    #and until the terminated character
    if v0==4:
        string=""
        address=binaryToInt(a0,0)
        count=0
        while not binaryToInt(memory[address+count],0)==10:
            string=string+chr(binaryToInt(memory[address+count],0))
            count+=1
        print(string)
    #get the input integer from user, and then read and store it in v0 register
    if v0==5:
        integer=input("Please enter an integer:")
        while not integer.replace("-","").isdigit():
            integer=input("Your input is wrong, please enter again!")
        register_list[2]=intToBinary(integer,32)
    #get the input string from user, from a1 regiter get the maximum number of character
    #to read, then store the characters to the memory, and then store the memory address
    #to a0 register
    if v0==8:
        string=input("Please enter a string:")
        length=binaryToInt(a1,0)
        address=binaryToInt(a0,0)
        for i in range(0,length):
            if i<length-1:
                if i<len(string):
                    memory[address+i]=intToBinary(ord(string[i]),8)
                else:
                    memory[address+i]=intToBinary(10,8)
            elif i==length-1:
                memory[address+i]=intToBinary(10,8)
    #allocate memory, the size is decided by a0 register,
    #and the address is stored in v0 register
    if v0==9:
        allocate_size=binaryToInt(a0,0)
        allocate_memory=[1]
        check_list=[0]
        while check_list!=allocate_memory:
            allocate_memory=[]
            check_list=[]
            address=random.randint(instruction_length,memory_size-allocate_size)
            for i in range(0,allocate_size):
                check_list.append("")
                allocate_memory.append(memory[address+i])
        register_list[2]=intToBinary(address,32)
    #terminate the program
    if v0==10:
        os._exit(0)
    #print the character stored in a0 register
    if v0==11:
        asc=binaryToInt(a0,1)
        character=chr(asc)
        print(character)
    #get the charater from user, and store it in v0 register
    if v0==12:
        character=input("please enter a character:")
        while not len(character)==1:
            character=input("Your input is wrong, please enter a character:")
        asc=ord(character)
        register_list[2]=intToBinary(asc,32)
    PC+=4

#get the machinecode file name from user, and open it
input_file_name=input("Please enter the machinecode file name:")
while not os.path.exists(input_file_name):
    input_file_name=input("Please enter correct name:")
input_file=open(input_file_name,"r")

#Modify and examine the input file
#if there's no problem, write the instructions into memory
#for further execution
count=0
for line in input_file:
    line=line.replace("\n","").replace("\t","").replace(" ","")
    if (not line.isdigit() or len(line)!=32) and line!="":
        print("The input file is wrong.")
        os._exit(0)
    if not line=="":
        memory[count]=line[0:8]
        memory[count+1]=line[8:16]
        memory[count+2]=line[16:24]
        memory[count+3]=line[24:32]
    count+=4

#Use PC as the pointer to get the corresponding instructions stored
#in memory and do the execute function according to the instruction
#if PC points to a empty memory or over the instruction size, the 
#program will stop
while not (memory[PC]=="" or PC>=instruction_length):
    #get corresponding instruction
    instruction=memory[PC]+memory[PC+1]+memory[PC+2]+memory[PC+3]
    opcode=instruction[0:6]
    #classify the instruction according to the opcode
    if opcode in R_opcodes:
        rs=instruction[6:11]
        rt=instruction[11:16]
        rd=instruction[16:21]
        sa=instruction[21:26]
        function_code=instruction[26:32]
        #Do the corresponding operation according to function code
        if function_code=="000000":
            MIPS_sll(rd,rt,sa)
        elif function_code=="000010":
            MIPS_srl(rd,rt,sa)
        elif function_code=="000011":
            MIPS_sra(rd,rt,sa)
        elif function_code=="000100":
            MIPS_sllv(rd,rt,rs)
        elif function_code=="000110":
            MIPS_srlv(rd,rt,rs)
        elif function_code=="000111":
            MIPS_srav(rd,rt,rs)
        elif function_code=="001000":
            MIPS_jr(rs)
        elif function_code=="001001":
            MIPS_jalr(rd,rs)
        elif function_code=="001100":
            MIPS_syscall()
        elif function_code=="001101":
            MIPS_break()
        elif function_code=="010000":
            MIPS_mfhi(rd)
        elif function_code=="010001":
            MIPS_mthi(rs)
        elif function_code=="010010":
            MIPS_mflo(rd)
        elif function_code=="010011":
            MIPS_mtlo(rs)
        elif function_code=="011000":
            MIPS_mult(rs,rt)
        elif function_code=="011001":
            MIPS_multu(rs,rt)
        elif function_code=="011010":
            MIPS_div(rs,rt)
        elif function_code=="011011":
            MIPS_divu(rs,rt)
        elif function_code=="100000":
            MIPS_add(rd,rs,rt)
        elif function_code=="100001":
            MIPS_addu(rd,rs,rt)
        elif function_code=="100010":
            MIPS_sub(rd,rs,rt)
        elif function_code=="100011":
            MIPS_subu(rd,rs,rt)
        elif function_code=="100100":
            MIPS_and(rd,rs,rt)
        elif function_code=="100101":
            MIPS_or(rd,rs,rt)
        elif function_code=="100110":
            MIPS_xor(rd,rs,rt)
        elif function_code=="100111":
            MIPS_nor(rd,rs,rt)
        elif function_code=="101010":
            MIPS_slt(rd,rs,rt)
        elif function_code=="101011":
            MIPS_sltu(rd,rs,rt)
    #classify the instruction according to the opcode
    elif (not opcode in R_opcodes) and (not opcode in J_opcodes) and (not opcode in Coprocessor_opcodes):
        rs=instruction[6:11]
        rt=instruction[11:16]
        im=instruction[16:32]
        #Do the corresponding operation according to opcode
        if opcode=="000001" and rt=="00000":
            MIPS_bltz(rs,im)
        elif opcode=="000001" and rt=="00001":
            MIPS_bgez(rs,im)
        elif opcode=="000100":
            MIPS_beq(rs,rt,im)
        elif opcode=="000101":
            MIPS_bne(rs,rt,im)
        elif opcode=="000110":
            MIPS_blez(rs,im)
        elif opcode=="000111":
            MIPS_bgtz(rs,im)
        elif opcode=="001000":
            MIPS_addi(rt,rs,im)
        elif opcode=="001001":
            MIPS_addi(rt,rs,im)
        elif opcode=="001010":
            MIPS_slti(rt,rs,im)
        elif opcode=="001011":
            MIPS_sltiu(rt,rs,im)
        elif opcode=="001100":
            MIPS_andi(rt,rs,im)
        elif opcode=="001101":
            MIPS_ori(rt,rs,im)
        elif opcode=="001110":
            MIPS_xori(rt,rs,im)
        elif opcode=="001111":
            MIPS_lui(rt,im)
        elif opcode=="100000":
            MIPS_lb(rt,rs,im)
        elif opcode=="100001":
            MIPS_lh(rt,rs,im)
        elif opcode=="100011":
            MIPS_lw(rt,rs,im)
        elif opcode=="100100":
            MIPS_lbu(rt,rs,im)
        elif opcode=="100101":
            MIPS_lhu(rt,rs,im)
        elif opcode=="101000":
            MIPS_sb(rt,rs,im)
        elif opcode=="101001":
            MIPS_sh(rt,rs,im)
        elif opcode=="101011":
            MIPS_sw(rt,rs,im)
    #classify the instruction according to the opcode
    elif opcode in J_opcodes:
        label=instruction[6:32]
        #Do the corresponding operation according to opcode
        if opcode=="000010":
            MIPS_j(label)
        elif opcode=="000011":
            MIPS_jal(label)