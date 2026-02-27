class monitor2;
  base pkt;
  mailbox mon22sb;
  virtual intf vif;
  function new(mailbox mon22sb,virtual intf vif);
    this.mon22sb=mon22sb;
    this.vif=vif;
  endfunction
  task mon2_run();
    pkt=new();
    forever begin@(vif.cb_monitor)
      pkt.rst=vif.cb_monitor.rst;
      pkt.start=vif.cb_monitor.start;
      pkt.a=vif.cb_monitor.a;
      pkt.nwr=vif.cb_monitor.nwr;
      pkt.nrd=vif.cb_monitor.nrd;
      pkt.ncs=vif.cb_monitor.ncs;
      pkt.din=vif.cb_monitor.din;
      pkt.dout=vif.cb_monitor.dout;
      pkt.err=vif.cb_monitor.err;
      pkt.ec=vif.cb_monitor.ec;
      pkt.dir=vif.cb_monitor.dir;
      pkt.count=vif.cb_monitor.count;
      mon22sb.put(pkt);
      $display("monitor2 passed");
     end
  endtask 
endclass