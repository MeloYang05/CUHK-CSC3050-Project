import os
def binary_add(adder1,adder2,overflow_check):
    if len(adder1)<len(adder2):
        difference=len(adder2)-len(adder1)
        adder1="0"*difference+adder1
    if len(adder1)>len(adder2):
        difference=len(adder1)-len(adder2)
        adder2="0"*difference+adder2
    sum=""
    carry="0"
    for i in range(len(adder1)-1,-1,-1):
        print(i)
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

print(binary_add("001","010",0))
a="1"
b="a"
a=a+b
print(a+b)