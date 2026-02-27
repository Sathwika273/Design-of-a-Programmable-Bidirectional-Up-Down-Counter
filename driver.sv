class driver;
  base pkt;
  mailbox gen2drv;
  virtual intf vif;
  function new(mailbox gen2drv,virtual intf vif);
    this.gen2drv=gen2drv;
    this.vif=vif;
  endfunction
  task drv_run();
    pkt=new();
    forever begin @(vif.cb_driver);
    gen2drv.get(pkt);
      vif.cb_driver.rst<=pkt.rst;
      vif.cb_driver.start<=pkt.start;
      vif.cb_driver.a<=pkt.a;
      vif.cb_driver.nwr<=pkt.nwr;
      vif.cb_driver.nrd<=pkt.nrd;
      vif.cb_driver.ncs<=pkt.ncs;
      vif.cb_driver.din<=pkt.din;
      $display("driver passed");
    end
  endtask
endclass