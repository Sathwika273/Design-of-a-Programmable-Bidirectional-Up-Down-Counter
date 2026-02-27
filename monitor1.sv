class monitor1;
  base pkt;
  mailbox mon12sb;
  virtual intf vif;
  bit [7:0] plr, ulr, llr, ccr;
  bit run;
  bit [7:0] cycle_done;
  bit [7:0] count_ref;
   bit dir_ref;
   bit ec_ref;
  function new(mailbox mon12sb,virtual intf vif);
    this.mon12sb=mon12sb;
    this.vif=vif;
  endfunction

  task data();
  begin
    pkt.rst=vif.cb_monitor.rst;
    pkt.start=vif.cb_monitor.start;
    pkt.a=vif.cb_monitor.a;
    pkt.nwr=vif.cb_monitor.nwr;
    pkt.nrd=vif.cb_monitor.nrd;
    pkt.ncs=vif.cb_monitor.ncs;
    pkt.din=vif.cb_monitor.din;
  end
endtask
  task mon1_run();

    forever begin@(vif.cb_monitor)
      pkt=new();
      data();
        if(pkt.rst)begin
          plr=0;
          ulr=8'hff;
          llr=0;
          ccr=0;
          pkt.count=0;
          pkt.dir=0;
          run= 0;
          pkt.ec= 0;
          cycle_done = 0;
        end
      else begin
 
        wr_run();
        rd_run();
        err_run();

        con_run();
   
      
      end
     
        mon12sb.put(pkt);
        $display("monitor1 passed");
    end
      endtask
      
   task wr_run();
      if(!pkt.ncs && !pkt.nwr)begin
          case(pkt.a)
            2'b00:plr=pkt.din;
            2'b01:ulr=pkt.din;
            2'b10:llr=pkt.din;
            2'b11:ccr=pkt.din;
          endcase
         end
    endtask
      task rd_run();
        if(!pkt.ncs && !pkt.nrd)begin
            case(pkt.a)
              2'b00:pkt.dout=plr;
              2'b01:pkt.dout=ulr;
              2'b10:pkt.dout=llr;
              2'b11:pkt.dout=ccr;
            endcase
          end
          else
            pkt.dout=0;
      endtask
  
        task err_run();
          pkt.err=(plr < llr) || (plr > ulr);
        endtask
  
  task con_run();
begin
  if (pkt.start && !run) begin
    count_ref = plr;
    dir_ref   = 1;
    run       = 1;
    ec_ref    = 0;
    cycle_done = 0;
  end

  else if(run) begin

    if(dir_ref) begin
      if(count_ref == ulr)
        dir_ref = 0;
      else
        count_ref = count_ref + 1;
    end
    else begin
      if(count_ref == llr)
        dir_ref = 1;
      else
        count_ref = count_ref - 1;
    end

    if (dir_ref==1 && count_ref==plr) begin
      cycle_done = cycle_done + 1;
      if (cycle_done == ccr) begin
        run = 0;
        ec_ref = 1;
      end
    end
  end
  pkt.count = count_ref;
  pkt.dir   = dir_ref;
  pkt.ec    = ec_ref;

end
endtask
endclass:monitor1