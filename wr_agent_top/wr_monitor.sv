class wr_monitor extends uvm_monitor;
  `uvm_component_utils(wr_monitor)
  
  virtual en_if.wr_mon vif;
  wr_cfg wcfg;
  wr_xtn xtn;
  uvm_analysis_port#(wr_xtn) wr_mp;

  function new(string name = "wr_monitor" , uvm_component parent);
		super.new(name,parent);
    wr_mp=new("wr_mp",this);
	endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(wr_cfg)::get(this,"","wr_cfg",wcfg))
      `uvm_fatal(get_type_name(),"get error in wr_driver")
  endfunction

  function void connect_phase(uvm_phase phase);
    vif=wcfg.vif;
  endfunction

  task run_phase(uvm_phase phase); 
    forever
      collect_data;
  endtask

  task collect_data();
    wr_xtn xtn=wr_xtn::type_id::create("xtn");
    @(vif.a);
    xtn.a=vif.a;
    `uvm_info(get_type_name(),"wr monitor data",UVM_LOW);
    xtn.print();
    wr_mp.write(xtn);
  endtask
  
endclass
