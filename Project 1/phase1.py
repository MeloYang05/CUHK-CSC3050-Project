# Revise the list content from the test file
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


