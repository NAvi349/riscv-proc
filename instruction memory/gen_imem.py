"""
        This Script will format the HEX Decimal Instruction

        Output: Instruction in Byte Addressable format
        See Output in imem.txt
        Copy that into the imem.sv
"""


import string

text_file = open('testfile.txt')

mem = text_file.read().split()

imem_file = open('imem.txt', 'w')

new_mem = [word[0:2] for word in mem]

for i in range(0,len(mem)):
    j = i * 4;
    imem_file.write(str('// Instruction: ' + mem[i]))
    imem_file.write('\n')
    imem_file.write(str('RAM['+str(j+0)+'] = 8\'h'+mem[i][6:8]+';'));
    imem_file.write('\n')
    imem_file.write(str('RAM['+str(j+1)+'] = 8\'h'+mem[i][4:6]+';'));
    imem_file.write('\n')
    imem_file.write(str('RAM['+str(j+2)+'] = 8\'h'+mem[i][2:4]+';'));
    imem_file.write('\n')
    imem_file.write(str('RAM['+str(j+3)+'] = 8\'h'+mem[i][0:2]+';\n'));

