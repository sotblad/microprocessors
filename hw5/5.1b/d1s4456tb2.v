module d1s4456tb2();

//input registers to our instantiated module
reg tb_a;
reg tb_b;
reg tb_c;
reg d_correct;

//bus for writing data to the inputs
wire [2:0] tb_dut_inputs;

//wire for reading the output of the instantiated module
wire tb_d;

//this is the instantiated module d1s4456tb2.
//the name of the instance is dut
d1s4456 dut(tb_a, tb_b, tb_c, tb_d);

//now we create the bus that consists of three input registers values
assign tb_dut_inputs={tb_a, tb_b, tb_c};

 //this block is running only at the beginning of the simulation
initial begin 
 {tb_a, tb_b, tb_c}=3'b000;
 
 //the following line runs forever every 5 time units
 forever #5 {tb_a, tb_b, tb_c}=tb_dut_inputs+1;

end //initial begin
integer flag;

initial begin
    forever begin
     #1 if (((tb_a == 1) && (tb_b == 1) && (tb_c == 0)))
            flag <= 1;
        else
            flag <= 0;
        end
    end

initial begin
    forever begin
     #2 if (flag == tb_d)
            d_correct <= 1;
        else
            d_correct <= 0;
        end
    end

endmodule