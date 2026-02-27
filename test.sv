class test;
  environment env;
  virtual intf vif;
  function new(virtual intf vif);
    this.vif=vif;
    env=new(vif);
  endfunction
  task test_run();
    env.env_run();
  endtask
endclass