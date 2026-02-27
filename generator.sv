class generator;
  base pkt;
  mailbox gen2drv;
   bit [7:0] plr, ulr, llr, ccr;
  function new(mailbox gen2drv);
    this.gen2drv=gen2drv;
  endfunction
  
  task gen_run();
    pkt=new();                              //rst1
    if(pkt.randomize() with {ncs==1; nwr==1; nrd==1; rst==1; a==0; din==0; start==0;});
    gen2drv.put(pkt);
    $display("rst0 passed");
    pkt=new();                               //rst0
    if(pkt.randomize() with {ncs==1; nwr==1; nrd==1; rst==0; a==0; din==0; start==0;});
    gen2drv.put(pkt);
    $display("rst1 passed");
    pkt=new();                               //load
    if(pkt.randomize()with {ncs==0; nwr==0; nrd==1; rst==0; a[1]==0; a[0]==0; din==plr; start==0;});
    gen2drv.put(pkt);
    $display("load00 passed");
    pkt=new();
    if(pkt.randomize()with {ncs==0; nwr==0; nrd==1; rst==0; a[1]==0; a[0]==1; din==ulr; start==0;});
    gen2drv.put(pkt);
    $display("load01 passed");
    pkt=new();
    if(pkt.randomize()with {ncs==0; nwr==0; nrd==1; rst==0; a[1]==1; a[0]==0; din==llr;       start==0;});
    gen2drv.put(pkt);
    $display("load10 passed");
    pkt=new();
    if(pkt.randomize()with {ncs==0; nwr==0; nrd==1; rst==0; a[1]==1; a[0]==1; din==ccr; start==0;});
    gen2drv.put(pkt);
    $display("load11 passed");
    
    pkt=new();                               //wr
    if(pkt.randomize()with {ncs==0; nwr==0; nrd==1; rst==0; a[1]==0; a[0]==0; din==5; start==0;});
    gen2drv.put(pkt);
    $display("wr00 passed");
    pkt=new();
    if(pkt.randomize()with {ncs==0; nwr==0; nrd==1; rst==0; a[1]==0; a[0]==1; din==8; start==0;});
    gen2drv.put(pkt);
    $display("wr01 passed");
    pkt=new();
    if(pkt.randomize()with {ncs==0; nwr==0; nrd==1; rst==0; a[1]==1; a[0]==0; din==2;       start==0;});
    gen2drv.put(pkt);
    $display("wr10 passed");
    pkt=new();
    if(pkt.randomize()with {ncs==0; nwr==0; nrd==1; rst==0; a[1]==1; a[0]==1; din==4; start==0;});
    gen2drv.put(pkt);
    $display("wr11 passed");
    pkt=new();
    if(pkt.randomize()with {ncs==0; nwr==1; nrd==0; rst==0; a[1]==0; a[0]==0; start==0;});
    gen2drv.put(pkt);
    $display("rd00 passed");
    pkt=new();
    if(pkt.randomize()with {ncs==0; nwr==1; nrd==0; rst==0; a[1]==0; a[0]==1; start==0;});
    gen2drv.put(pkt);
    $display("rd01 passed");
    pkt=new();
    if(pkt.randomize()with {ncs==0; nwr==1; nrd==0; rst==0; a[1]==1; a[0]==0; start==0;});
    gen2drv.put(pkt);
    $display("rd10 passed");
    pkt=new();
    if(pkt.randomize()with {ncs==0; nwr==1; nrd==0; rst==0; a[1]==1; a[0]==1; start==0;});
    gen2drv.put(pkt);
    $display("rd11 passed");
    pkt=new();                     //start1
    if(pkt.randomize()with {ncs==0; nwr==1; nrd==1; rst==0; start==1;});
    gen2drv.put(pkt);
    $display("start1 passed");
    pkt=new();                    //start0
    if(pkt.randomize()with {ncs==0; nwr==1; nrd==1; rst==0; start==0;});
    gen2drv.put(pkt);
        $display("start1 passed");
    $display("generator passed");
    endtask
 // $display("generator passed");
  endclass

