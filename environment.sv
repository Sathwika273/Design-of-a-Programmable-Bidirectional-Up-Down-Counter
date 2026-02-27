class environment;
  mailbox gen2drv,mon12sb,mon22sb;
  generator gen;
  driver drv;
  monitor1 mon1;
  monitor2 mon2;
  scoreboard sb;
  virtual intf vif;
  function new(virtual intf vif);
    this.vif=vif;
    gen2drv=new();
    mon12sb=new();
    mon22sb=new();
    gen=new(gen2drv);
    drv=new(gen2drv,vif);
    mon1=new(mon12sb,vif);
    mon2=new(mon22sb,vif);
    sb=new(mon12sb,mon22sb);
  endfunction
  task env_run();
    begin
      fork
        gen.gen_run();
        drv.drv_run();
       // mon1.mon1_run();
       // mon1.data();
        mon1.mon1_run();
      /*  mon1.wr_run():
        mon1.rd_run();
        mon1.err_run();
        mon1.con_run();*/
        mon2.mon2_run();
        sb.sb_run();
      join
    end
  endtask
endclass