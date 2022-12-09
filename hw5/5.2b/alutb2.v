module MCPU_Alutb2();

parameter CMD_SIZE=2;
parameter WORD_SIZE=8;
parameter  [CMD_SIZE-1:0]  CMD_AND  = 0; //2'b00
parameter  [CMD_SIZE-1:0]  CMD_OR   = 1; //2'b01
parameter  [CMD_SIZE-1:0]  CMD_XOR   = 2; //2'b10
parameter  [CMD_SIZE-1:0]  CMD_ADD   = 3; //2'b11

reg iscorrect;
reg [WORD_SIZE-1:0] tmp;

reg [CMD_SIZE-1:0] opcode;
reg [WORD_SIZE-1:0] r1;
reg [WORD_SIZE-1:0] r2;
wire [WORD_SIZE*2-1:0] out;
wire OVERFLOW;

MCPU_Alu #(.CMD_SIZE(CMD_SIZE), .WORD_SIZE(WORD_SIZE)) aluinst (opcode, r1, r2, out, OVERFLOW);

// Testbench code goes here
always 
begin
#3 r1 = 4; #3 r1 = 4; #3 r1 = 5; #3 r1 = 6;
end
always 
begin 
#3 r2 = 4; #3 r2 = 4; #3 r2 = 5; #3 r2 = 6;
end

always #2 opcode[0] = $random;
always #2 opcode[1] = $random;

always @ (opcode or r1 or r2)
  case(opcode)
    CMD_AND : begin
                 tmp = r1&r2; 
              end
    CMD_OR :  begin
                tmp = r1|r2;
              end
    CMD_XOR : begin
                tmp = r1^r2;
              end
    default : begin
                tmp = r1+r2;
              end
  endcase

always @ (opcode or r1 or r2)
  if ((tmp[0] == out[0]) && (tmp[1] == out[1])) 
    begin
      iscorrect = 1;
    end
  else
    begin
      iscorrect = 0;
    end

initial begin
  $display("@%0dns default is selected, opcode %b",$time,opcode);
end

endmodule
