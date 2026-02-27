// Code your design here
module udcount(
   input clk,
   input rst,
   input start,
   input [1:0] a,
   input nwr,
   input nrd,
   input ncs,
   input [7:0] din,
   output reg [7:0] dout,
   output reg err,
   output reg ec,
   output reg dir,
   output reg [7:0] count
);

reg [7:0] plr, ulr, llr, ccr;
reg [7:0] cycle_done;
reg run;

  always @(posedge clk) begin             //rst
   if (rst) begin
      plr <= 0;
      ulr <= 8'hFF;
      llr <= 0;
      ccr <= 0;
   end
    else if (!ncs && !nwr) begin              //write
      case(a)
         2'b00: plr <= din;
         2'b01: ulr <= din;
         2'b10: llr <= din;
         2'b11: ccr <= din;
      endcase
   end
end

  always @(*) begin                              //read
   if (!ncs && !nrd) begin
      case(a)
         2'b00: dout = plr;
         2'b01: dout = ulr;
         2'b10: dout = llr;
         2'b11: dout = ccr;
      endcase
   end
   else
      dout = 0;
end

  always @(posedge clk)                                 //error
   err <= (plr < llr) || (plr > ulr);

  always @(posedge clk) begin                          //counting
   if (rst) begin
      count <= 0;
      dir   <= 0;
      run   <= 0;
      ec    <= 0;
      cycle_done <= 0;
   end

    else if (start) begin                              
      count <= plr;
      dir   <= 1;
      run   <= 1;
      ec    <= 0;
      cycle_done <= 0;
   end

   else if (run) begin

      if (dir) begin
        if (count == ulr)
            dir <= 0;
         else
            count <= count + 1;
      end
 
      else begin
         if (count == llr) 
            dir <= 1;
         else
            count <= count - 1;
         end
     
     if (dir==1 && count==plr)begin
            cycle_done <= cycle_done + 1;

       if (cycle_done == ccr) begin                                
               run <= 0;
               ec  <= 1;
            end
      end
   end
end

endmodule
