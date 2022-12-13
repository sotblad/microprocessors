module heilstone();

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


    // 4456 = 00010001 01101000
                                                                               //memory address: instruction
    i=0;  cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R0, 8'b00010001};   //0: R0=44;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R1, 8'b01101000};   //1: R1=56;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R15, 8'b00000001};   //2: R15=1;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_STORE_TO_MEM, R0, 8'd100};        //3: mem[100]=R0;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_STORE_TO_MEM, R1, 8'd101};        //4: mem[101]=R1;

    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LOAD_FROM_MEM, R0, 8'd100};       //  5:R0=mem[100];
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LOAD_FROM_MEM, R1, 8'd101};       //  6:R1=mem[101];

    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_OR, R2, R0, R1}; 				   // 7: n=R2
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LSR, R3, R2, R15}; 			   // 8: if n = 1 -> R3 = 0

    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R3, 8'd11};       		   //  9: n != 1 -> go to if (n is odd)
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R0, 8'd17}; // 10: program end

    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_AND, R4, R2, R15}; // 11: R4=n mod 2

    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LSL, R5, R2, R15}; // 12: R5=2n
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R6, R5, R2}; // 13: R6=3n
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R7, R6, R15}; // 14: R7=3n+1
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R4, 8'd17};  // 15: R4=1 -> odd -> continue to n=n/2;

    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LSR, R8, R2, R15}; // 16: R8=n/2

	i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_BNZ, R15, 8'd8};



    #800
    ready = 1;
end

always @ (ready)
begin  
 iscorrect = (cpuinst.regfileinst.R[0] == 8'b00010001) && (cpuinst.regfileinst.R[1] == 8'b01101000) && (cpuinst.raminst.mem[100] == cpuinst.regfileinst.R[0]) && (cpuinst.raminst.mem[101] == cpuinst.regfileinst.R[1]);
end

endmodule