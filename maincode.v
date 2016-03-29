/* verilog shift register (bi directional) Amanda Falke 2015 */

module shiftReg(q, bidir, clk, mr, oe1, oe2, ds0, ds3, s0, s1);

input clk, mr, oe1, oe2, ds0, ds3, s0, s1;

output [3:0] q; // gwd
reg [3:0] q; // gwd
inout [3:0] bidir;
 

assign bidir = ( !oe1 || !oe2 ) ? q :4'bZ; // if oe asserted. inout = Q's. else, HiZ.aka INPUT.
//assign bidir = ( oe1 || oe2 ) ? 4'bZ :q; // if oe asserted. inout = Q's. else, HiZ.aka INPUT.


always @ ( posedge clk )
begin

 if ( !mr ) // mode 1/4: master reset
  q <= q;
 else  
 begin

  case ( { s0, s1 } )
   2'b00: q <= q; // hold
 
   2'b01: begin q <= q << 1; q[0] <= ds0; end   // mode 2/4: shift left into LSB
         
   2'b10: begin q <= q >> 1;  q[3] <= ds3; end  // mode 3/4: shift right into MSB
     
   2'b11: q <= bidir; //begin inp[0] <= q[0]; inp[1] <= q[1]; inp[2] <= q[2]; inp[3] <= q[3]; end  // mode 4/4: parallel load 
 
  endcase

 end //if master reset

end // always @ posedge clock : end of sequential non-blocking

endmodule



 
/* Notes:

Note1  : for entire table "register operating modes,
 use a case statement. Recall that Casex AND Casez are both synthesizable.
 Also recall that you should concatenate { s0, s1 } and then you can cover
 ALL cases. Hence, a synthesizer fullcase directive is unnecessary. 

Note2: for the second table "3 state i/o port" bidirectional,
 you should use a one-line conditional statement :
 if OE asserted, then inout = Q's
 ELSE, inout = HiZ's
 
 recall that HiZ's are associated with INPUT on these pins.

Note3: as long as you use the bit vector for Q, 
 then this code will work:
 // ENTIRE CODE FOR SHIFT RIGHT:
 Q = Q >> 1; 
 Q[0] = DS0; 
 
 // ENTIRE CODE FOR SHIFT LEFT:
 Q = Q << 1;
 Q[3] = DS3; 
 
 */


