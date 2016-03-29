/* verilog shift register : a very brief and inexhaustive test bench 
*/

module test_logic;

reg CLK, MR, OE1, OE2, DS0, DS3, S0, S1;
wire [3:0] Q;
wire [3:0] BIDIR;

integer idx;


shiftReg testShiftReg ( .q(Q), .bidir(BIDIR), .clk(CLK), .mr(MR), .oe1(OE1), .oe2(OE2), .ds0(DS0), .ds3(DS3), .s0(S0), .s1(S1) );
 
initial
  begin
  

  #10 MR = 1'b1;
  
  for ( idx = 0; idx < 64; idx = idx + 1 )
    #10 { S0, S1, DS0, DS3, OE1, OE2 } = idx; 

  for ( idx = 0; idx < 64; idx = idx + 1 )
    #10 { OE1, OE2, S0, S1, DS0, DS3 } = idx; 
    
  #10 MR = 1'b0;
  
   for ( idx = 0; idx < 64; idx = idx + 1 )
    #10 { S0, S1, DS0, DS3, OE1, OE2 } = idx;
    
  
  #10 MR = 1'b0;
  
  for ( idx = 0; idx < 64; idx = idx + 1 )
    #10 { S0, S1, DS0, DS3, OE1, OE2 } = idx;  
    
  #10 MR = 1'b1;
  
   for ( idx = 0; idx < 64; idx = idx + 1 )
    #10 { S0, S1, DS0, DS3, OE1, OE2 } = idx;


   
  #20 $finish;
  
 end // initial
 

 always 
   begin
   CLK = 1;
   #10;
   CLK = 0;
   #10;
   end 
 // always #100 CLK = !CLK;
 
 endmodule
 
 

 
  
  



