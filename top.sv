module top;
  
  bit clk=0;
  always #5 clk=~clk;
   

  intf vif(clk);
  udcount dut(.clk(vif.clk),.rst(vif.rst),.start(vif.start),.a(vif.a),.nwr(vif.nwr),.nrd(vif.nrd),.ncs(vif.ncs),.din(vif.din),.dout(vif.dout),.err(vif.err),.ec(vif.ec),.dir(vif.dir),.count(vif.count));
  test tb;

  initial begin
    tb=new(vif);
    tb.test_run();
  end
    initial begin
    #1200 $finish;
  end
 /* initial begin
    $dumpfile("udcount.vcd");
    $dumpvars(0,top);
  end*/
endmodule