import os
# A dictionary to store tags and their corresponding addresses
label_dict=dict()
def label_tag(lines,label_dict):
    for position in range(len(lines)-1,-1,-1): # delete all the empty lines.
        if lines[position].rstrip().replace("\t","").replace("\n","").replace(" ","")=="":
            del lines[position]
    for position in range(0,len(lines)):
        line=lines[position]
        new_line=line.rstrip().replace("\t","").replace(","," ").replace("\n","") # delete space, tab and enter in each line
        lines[position]=new_line
        if "#" in line: # delete comments
            p1=new_line.index("#")
            new_line=new_line[:p1]
        if ":" in line: # pick up tags and store them and their address in the label dictionary
            p2=new_line.index(":")
            label_dict[new_line[:p2]]=position
            new_line=new_line[p2+1:]
        new_line_list=new_line.split(" ")
        for i in range(len(new_line_list)-1,-1,-1): #delete space again
            if  new_line_list[i] =='':
                del new_line_list[i]
        lines[position]=new_line_list

# A dictionary stores all the R type operations as keys and their corresponding function codes as values.
R_functions={
    "sll":"000000","srl":"000010","sra":"000011","sllv":"000100",
    "srlv":"000110","srav":"000111","jr":"001000","jalr":"001001",
    "syscall":"001100","break":"001101","mfhi":"010000","mthi":"010001",
    "mflo":"010010","mtlo":"010011","mult":"011000","multu":"011001",
    "div":"011010","divu":"011011","add":"100000","addu":"100001",
    "sub":"100010","subu":"100011","and":"100100","or":"100101",
    "xor":"100110","nor":"100111","slt":"101010","sltu":"101011"
}

# A dictionary stores all I type operations as keys and their corresponding opcodes as values.
I_opcodes={
    "bltz":"000001","bgez":"000001","beq":"000100","bne":"000101",
    "blez":"000110","bgtz":"000111","addi":"001000","addiu":"001001",
    "slti":"001010","sltiu":"001011","andi":"001100","ori":"001101",
    "xori":"001110","lui":"001111","lb":"100000","lh":"100001",
    "lw":"100011","lbu":"100100","lhu":"100101","sb":"101000",
    "sh":"101001","sw":"101011","lwc1":"110001","swc1":"111001"
}

# A dictionary stores all J type operations as keys and their corresponding opcodes as values.
J_opcodes={
    "j":"000010", "jal":"000011"
}

# A dictionary stores all coprocessor type operations as keys and their corresponding format and function codes as values.
Coprocessor_instructons={
    "add.s":["10000","000000"],"cvt.s.w":["10100","100000"],"cvt.w.s":["10000","100100"],
    "div.s":["10000","000011"],"mfc1":["00000","000000"],"mov.s":["10000","000110"],
    "mtc1":["00100","000000"],"mul.s":["10000","000010"],"sub.s":["10000","000001"]
}

# A dictionary stores all MIPS registers’ names as keys and their corresponding addressing codes as values.
MIPS_Register={
    "$zero":"00000","$at":"00001","$v0":"00010","v1":"00011",
    "$a0":"00100","$a1":"00101","$a2":"00110","$a3":"00111",
    "$t0":"01000","$t1":"01001","$t2":"01010","$t3":"01011",
    "$t4":"01100","$t5":"01101","$t6":"01110","$t7":"01111",
    "$s0":"10000","$s1":"10001","$s2":"10010","$s3":"10011",
    "$s4":"10100","$s5":"10101","$s6":"10110","$s7":"10111",
    "$t8":"11000","$t9":"11001","$k0":"11010","$k1":"11011",
    "$gp":"11100","$sp":"11101","$fp":"11110","$ra":"11111"
}

# Lists classify the operations by their instruction structures.
rd_rt_sa_list=["sll","srl","sra"]
rd_rt_rs_list=["sllv","srlv","srav"]
rd_rs_rt_list=["add","addu","sub","subu","and","or","xor","nor","slt","sltu"]
rs_rt_list=["mult","multu","div","divu"]
rs_list=["jr","mthi","mtlo"]
rd_list=["mfhi","mflo"]
rs_label_list=["bltz","bgez","blez","bgtz"]
rs_rt_label_list=["beq","bne"]
rt_rs_im_list=["addi","addiu","slti","sltiu","andi","ori","xori"]
rt_imrs_list=["lb","lh","lw","lbu","lhu","sb","sh","sw","lwcl","swcl"]
fd_fs_ft_list=["add.s","div.s","mul.s","sub.s"]
fd_fs_list=["cvt.s.w","cvt.w.s","mov.s"]
# This list contains the operations which have to deal with the immediate number as unsigned number.
unsighed_list=["addiu","lbu","sltiu"]

# This function aims to transform an integer into sighed or not sighed binary format.
def tobinary(number,length): #sighed=0 represents unsighed, =1 represents sighed
    try: #the input could be string or integer
        decimal=int(number)
    except:
        decimal=number
    if "-" in str(decimal): #deal with minus integer
        binary=str(bin(decimal))[3:]
    else:
        binary=str(bin(decimal))[2:] #get correct binary string
    real_length=len(binary) 
    if real_length<length: # to increase the length of the binary string to the expected
        difference=length-real_length
        i=0
        while i<difference:
            binary="0"+binary
            i+=1
    if not "-" in str(decimal): #if the input is positive or unsighed, return value
        return binary
    else: #do the 2's complement for sighed negative number
        i=length-1
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

#open the test file and store the content in a list.
test_file=input("Input file name:")
output_file=input("Output file name:")
with open(test_file) as file_object:
    lines=file_object.readlines()
open(output_file,"w")
#revise the content in the list and pick up tags to store in dictionary.
label_tag(lines,label_dict)

# using for loop to get the machine code of each line and store in output file.
for line in lines:
    if line[0] in R_functions.keys(): #judge whether R type
        opcode="000000"
        function_code=R_functions[line[0]]
        sa="00000"
        if line[0] in rd_rt_sa_list: # judge institution code structure
            rd=MIPS_Register[line[1]]
            rt=MIPS_Register[line[2]]
            sa=tobinary(line[3],5)
            rs="00000"
        elif line[0] in rd_rt_rs_list:
            rd=MIPS_Register[line[1]]
            rt=MIPS_Register[line[2]]
            rs=MIPS_Register[line[3]]
        elif line[0] in rd_rs_rt_list:
            rd=MIPS_Register[line[1]]
            rs=MIPS_Register[line[2]]
            rt=MIPS_Register[line[3]]
        elif line[0] in rs_rt_list:
            rs=MIPS_Register[line[1]]
            rt=MIPS_Register[line[2]]
            rd="00000"
        elif line[0] in rs_list:
            rs=MIPS_Register[line[1]]
            rd=rt="00000"
        elif line[0] in rd_list:
            rd=MIPS_Register[line[1]]
            rs=rt="00000"
        elif line[0] == "jalr":
            rd=MIPS_Register[line[1]]
            rs=MIPS_Register[line[2]]
            rt="00000"
        else:
            rd=rs=rt="00000"
        machine_code=opcode+rs+rt+rd+sa+function_code #get machine code
    elif line[0] in I_opcodes.keys(): #judge whether I type
        if line[0] in unsighed_list:
            sighed=0
        else:
            sighed=1
        opcode=I_opcodes[line[0]]
        if line[0] == "lui":
            rt=MIPS_Register[line[1]]
            im=tobinary(line[2],16) #transform the address to binary format
            rs="00000"
        elif line[0] in rt_rs_im_list:
            rt=MIPS_Register[line[1]]
            rs=MIPS_Register[line[2]]
            im=tobinary(line[3],16)
        elif line[0] in rt_imrs_list:
            rt=MIPS_Register[line[1]]
            p1=line[2].index("(")
            p2=line[2].index(")")
            try:
                im=tobinary(line[2][:p1],16) 
            except:
                im=tobinary(0,16)
            rs=MIPS_Register[line[2][p1+1:p2]]
        elif line[0] in rs_label_list:
            rs=MIPS_Register[line[1]]
            im=tobinary(label_dict[line[2]],16)
            if line[0] == "bgez":
                rt="00001"
            else:
                rt="00000"
        elif line[0] in rs_rt_label_list:
            rs=MIPS_Register[line[1]]
            rt=MIPS_Register[line[2]]
            im=tobinary(label_dict[line[3]],16)
        machine_code=opcode+rs+rt+im 
    elif line[0] in J_opcodes.keys():
        opcode=J_opcodes[line[0]]
        if line[1].isdigit():
            target=tobinary(line[1],26)
        else:
            target=tobinary(label_dict[line[1]],26)
        machine_code=opcode+target #get machine code
    elif line[0] in Coprocessor_instructons.keys():
        opcode="010001"
        format_code=Coprocessor_instructons[line[0]][0]
        function_code=Coprocessor_instructons[line[0]][1]
        if line[0] in fd_fs_ft_list:
            fd=MIPS_Register[line[1]]
            fs=MIPS_Register[line[2]]
            ft=MIPS_Register[line[3]]
        elif line[0] in fd_fs_list:
            fd=MIPS_Register[line[1]]
            fs=MIPS_Register[line[2]]
            ft="00000"
        elif line[0] == "mfc1":
            rd=fd=MIPS_Register[line[1]]
            fs=MIPS_Register[line[2]]
            ft="00000"
        elif line[0] == "mtc1":
            rs=fs=MIPS_Register[line[1]]
            fd=MIPS_Register[line[2]]
            ft="00000"
        machine_code=opcode+format_code+ft+fs+fd+function_code #get machine code
    # write the machine code to the output file
    with open(output_file,'a') as file_object:
        file_object.write(machine_code+"\n")