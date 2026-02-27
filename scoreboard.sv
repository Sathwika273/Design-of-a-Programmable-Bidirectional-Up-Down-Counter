class scoreboard;
  base pkt1,pkt2;
  mailbox mon12sb,mon22sb;
  function new(mailbox mon12sb,mon22sb);
    this.mon12sb=mon12sb;
    this.mon22sb=mon22sb;
  endfunction
  task sb_run();
      pkt1=new();
      pkt2=new();
    forever begin
      mon12sb.get(pkt1);
      mon22sb.get(pkt2);
      
      if(pkt1.count==pkt2.count)
        $display("matched pkt1.count=%b pkt1.err=%b pkt1.ec=%b pkt1.dir=%b pkt2.count=%b pkt2.err=%b pkt2.ec=%b pkt2.dir=%b",pkt1.count,pkt1.err,pkt1.ec,pkt1.dir,pkt2.count,pkt2.err,pkt2.ec,pkt2.dir);
      else
         $display("matched pkt1.count=%b pkt1.err=%b pkt1.ec=%b pkt1.dir=%b pkt2.count=%b pkt2.err=%b pkt2.ec=%b pkt2.dir=%b",pkt1.count,pkt1.err,pkt1.ec,pkt1.dir,pkt2.count,pkt2.err,pkt2.ec,pkt2.dir);
    end
  endtask
endclass
      