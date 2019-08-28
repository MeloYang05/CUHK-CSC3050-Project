def tobinary(number,length,sighed=0):
    try:
        decimal=int(number)
    except:
        decimal=number
    if "-" in str(decimal):
        binary=str(bin(decimal))[3:]
    else:
        binary=str(bin(decimal))[2:]
    real_length=len(binary)
    if real_length<length:
        difference=length-real_length
        i=0
        while i<difference:
            binary="0"+binary
            i+=1
    if not sighed or not "-" in str(decimal):
        return binary
    else:
        i=length-1
        while i>0:
            if binary[i]=="1":
                break
            else:
                i-=1
        if i==0:
            return binary
        else:
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

print(tobinary(-1,16))
