module benchmark();


reg reset, clk, ready;


MCPU cpuinst (clk, reset);


initial begin
  reset=1;
  #10  reset=0;
end

always begin
  #5 clk=0; 
  #5 clk=1; 
end


/********OUR ASSEMBLER*****/

integer iscorrect, i;
reg[cpuinst.WORD_SIZE-1:0] memi;
parameter  [cpuinst.OPERAND_SIZE-1:0]  R0  = 0; //4'b0000
parameter  [cpuinst.OPERAND_SIZE-1:0]  R1  = 1; //4'b0001
parameter  [cpuinst.OPERAND_SIZE-1:0]  R2  = 2; //4'b0010
parameter  [cpuinst.OPERAND_SIZE-1:0]  R3  = 3; //4'b0011
parameter  [cpuinst.OPERAND_SIZE-1:0]  R4  = 4; //4'b0100
parameter  [cpuinst.OPERAND_SIZE-1:0]  R5  = 5; //4'b0101
parameter  [cpuinst.OPERAND_SIZE-1:0]  R6  = 6; //4'b0110
parameter  [cpuinst.OPERAND_SIZE-1:0]  R7  = 7; //4'b0111
parameter  [cpuinst.OPERAND_SIZE-1:0]  R8  = 8; //4'b1000
parameter  [cpuinst.OPERAND_SIZE-1:0]  R9  = 9; //4'b1001
parameter  [cpuinst.OPERAND_SIZE-1:0]  R10  = 10; //4'b1010
parameter  [cpuinst.OPERAND_SIZE-1:0]  R11  = 11; //4'b1011
parameter  [cpuinst.OPERAND_SIZE-1:0]  R12  = 12; //4'b1100
parameter  [cpuinst.OPERAND_SIZE-1:0]  R13  = 13; //4'b1101
parameter  [cpuinst.OPERAND_SIZE-1:0]  R14  = 14; //4'b1110
parameter  [cpuinst.OPERAND_SIZE-1:0]  R15  = 15; //4'b1111


initial begin
    for(i=0;i<256;i=i+1)
      begin
        cpuinst.raminst.mem[i]=0;
      end

    for(i=0;i<16;i=i+1)
      begin
        cpuinst.regfileinst.R[i]=0;
      end     
    

                                                                               //memory address: instruction
    i=0;  cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R0, 8'b00101100};   //0: R0=44;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R1, 8'b00111000};   //1: R1=56;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_STORE_TO_MEM, R0, 8'd100};        //3: mem[100]=R0;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_STORE_TO_MEM, R1, 8'd101};        //4: mem[101]=R1;

    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LOAD_FROM_MEM, R2, 8'd100};       //  5:R2=mem[100];
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LOAD_FROM_MEM, R3, 8'd101};       //  6:R3=mem[101];

    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R4, R2, R3};                 //  7: R4=R2+R3;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_XOR, R5, R2, R3};                 //  8: R5=R2xorR3;


    i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R6, 8'b00101100}; //9: R6=44;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R7, 8'b00111000};   //10: R7=56;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_STORE_TO_MEM, R6, 8'd102};        //11: mem[102]=R6;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_STORE_TO_MEM, R7, 8'd103};        //12: mem[103]=R7;

    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LOAD_FROM_MEM, R8, 8'd102};       //  13:R8=mem[102];
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LOAD_FROM_MEM, R9, 8'd103};       //  14:R9=mem[103];

    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_AND, R10, R8, R9};                //  15: R10=R8&R9;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_OR, R11, R8, R9};                 //  16: R11=R8|R9;

    #500
    ready = 1;
end


always @ (ready)
begin
 iscorrect = (cpuinst.regfileinst.R[0] == 8'b00101100) && (cpuinst.regfileinst.R[1] == 8'b00111000) && (cpuinst.raminst.mem[100] == cpuinst.regfileinst.R[0]) && (cpuinst.raminst.mem[101] == cpuinst.regfileinst.R[1]) && (cpuinst.regfileinst.R[2] == cpuinst.raminst.mem[100]) && (cpuinst.regfileinst.R[3] == cpuinst.raminst.mem[101]) && (cpuinst.regfileinst.R[4] == (cpuinst.regfileinst.R[2]+cpuinst.regfileinst.R[3])) && (cpuinst.regfileinst.R[5] == (cpuinst.regfileinst.R[2]^cpuinst.regfileinst.R[3])) && (cpuinst.regfileinst.R[6] == 8'b00101100) && (cpuinst.regfileinst.R[7] == 8'b00111000) && (cpuinst.raminst.mem[102] == cpuinst.regfileinst.R[6]) && (cpuinst.raminst.mem[103] == cpuinst.regfileinst.R[7]) && (cpuinst.regfileinst.R[8] == cpuinst.raminst.mem[102]) && (cpuinst.regfileinst.R[9] == cpuinst.raminst.mem[103]) && (cpuinst.regfileinst.R[10] == (cpuinst.regfileinst.R[8]&cpuinst.regfileinst.R[9])) && (cpuinst.regfileinst.R[11] == (cpuinst.regfileinst.R[8]|cpuinst.regfileinst.R[9]));
end

endmodule