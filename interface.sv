interface intf(input logic clk);
  logic rst,start,nwr,nrd,ncs,err,dir,ec;
  logic [1:0]a;
  logic [7:0]din;
  logic [7:0]dout;
  logic [7:0]count;
  clocking cb_driver @(posedge clk);
    input dout,err,dir,ec,count;
    output rst,start,nwr,nrd,ncs,a,din;
  endclocking
  clocking cb_monitor @(posedge clk);
    input dout,err,dir,ec,count,rst,start,nwr,nrd,ncs,a,din;
  endclocking 
endinterface