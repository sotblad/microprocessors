module MCPU_RAMControllertb2();

parameter WORD_SIZE=8;
parameter ADDR_WIDTH=8;
parameter RAM_SIZE=1<<ADDR_WIDTH;

reg we, re;

reg [WORD_SIZE-1:0] datawr;

reg [ADDR_WIDTH-1:0] addr;
reg [ADDR_WIDTH-1:0] instraddr;

wire [WORD_SIZE-1:0] datard;
wire [WORD_SIZE-1:0] instrrd;

reg [WORD_SIZE-1:0] mem[RAM_SIZE-1:0];

reg data_write_iscorrect;
reg data_read_iscorrect;
reg cmd_read_iscorrect;
integer i;
integer flag;

MCPU_RAMController raminst (we, datawr, re, addr, datard, instraddr, instrrd);

initial begin
  {data_write_iscorrect, data_read_iscorrect, cmd_read_iscorrect, i, flag, we, re, addr, instraddr} = 0;

  for(i=0; i <RAM_SIZE; i=i+1)
    begin
      addr = i;
      if(i % 2 == 0)
        datawr = 44;
      else
        datawr = 56;
      #1 we <= 1;
      mem[i] = datawr;
      if(mem[i] == raminst.mem[i])
        data_write_iscorrect = 1;
      else
        data_write_iscorrect = 0;
      #1 we <= 0;
  end
  flag = 1;
end

always begin
  #1 re <= 0;
  if (flag)
    begin
      if (addr >= RAM_SIZE)
        addr = 0;
      else
        addr = addr + 1;

      if (instraddr >= RAM_SIZE)
        instraddr = 0;
      else
        instraddr = instraddr + 1;

      #1 re <= 1;

      if(datard == mem[addr])
        data_read_iscorrect = 1;
      else
        data_read_iscorrect = 0;

      if(instrrd == mem[instraddr])
        cmd_read_iscorrect = 1;
      else
        cmd_read_iscorrect = 0;
    end
  end
endmodule