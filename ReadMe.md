# 16-bit MIPS module

## Memory information
data memory 16 8-bit data
regester memory 16 8-bit data
instruction memory 256 16-bit data

## Basic sturcture 

| Instruction type | 4-bits          | 4-bits      | 4-bits      | 4-bits      |
| ---------------- | -----------     | ----------- | ----------- | ----------- |
| R-type           | opcode+fun code | Rs          | Rt          | Rd          |
| I-type           | opcode          | Rs          | Rt          | Rd          |
| j-type           | opcode          |  XXXX     | &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;---------- address ---------- |

** opcode 0000 makes processor stop pc donot increment

## Insturctions Sturcture
| Instruction      | formulae        | opcode      |
| ---------------- | -----------     | ----------- |
| add rs rt rd     |M\[rd\]=M\[rs\] +M\[rt\]     | 1000 | op+rs+rt+rd     |
| sub rs rt rd     |M\[rd\]=M\[rs\] -M\[rt\]     | 1001 | op+rs+rt+rd     |
| and rs rt rd     |M\[rd\]=M\[rs\] &&M\[rt\]     | 1010 | op+rs+rt+rd     |
| or rs rt rd      |M\[rd\]=M\[rs\] ||M\[rt\]     | 1011 | op+rs+rt+rd     |
| less rs rt rd    |M\[rd\]=M\[rs\] < M\[rt\] (0/1)     | 1100 | op+rs+rt+rd     |
| eql rs rt rd     |M\[rd\]=M\[rs\] = M\[rt\]   (0/1)  | 1101 | op+rs+rt+rd     |
| addi rs rt rd     |M\[rd\]=M\[rs\] +rt     | 0001 | op+rs+rt+rd     |
| subi rs rt rd     |M\[rd\]=M\[rs\] -rt     | 0010 | op+rs+rt+rd     |
| lw    |M\[rd\]=D\[M\[rt\] +rt\]     | 0011 | op+rs+rt+rd     |
| sw     |D\[M\[rt\] +rt\] =M\[rd\]     | 0100 | op+rs+rt+rd     |
| ji   |pc=addr     | 0101 | op+rs+rt+rd     |
| Beq     |if(M\[rs\] =M\[rt\] ) pc=pc_prev+1+addr   | 0110 | op+rs+rt+rd     |


## example code
<pre>
0 addi 0 1  2
1 addi 0 1  3
2 addi 0 11 4
3 add  2 3  3
4 Beq  2 4  6
5 Ji      3
6 0
</pre>


## reference
[https://www.fpga4student.com/2017/01/verilog-code-for-single-cycle-MIPS-processor.html?m=1](https://www.fpga4student.com/2017/01/verilog-code-for-single-cycle-MIPS-processor.html?m=1)  

[https://www.youtube.com/watch?v=nSgN93Zu-1g&list=PL1C2GgOjAF-JSlKHoSDOYVoF0lyCd76DD](https://www.youtube.com/watch?v=nSgN93Zu-1g&list=PL1C2GgOjAF-JSlKHoSDOYVoF0lyCd76DD)