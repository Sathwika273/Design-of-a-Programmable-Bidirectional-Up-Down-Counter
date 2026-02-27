class base;
  rand bit rst;
  rand bit start;
  rand bit [1:0]a;
  rand bit nwr;
  rand bit nrd;
  rand bit ncs;
  rand bit [7:0]din;
  bit [7:0]dout;
  bit err;
  bit ec;
  bit dir;
  bit [7:0] count;
 /* bit [7:0] plr,ulr,llr,ccr;
  bit [7:0] cycle_done;
  bit run;*/
endclass