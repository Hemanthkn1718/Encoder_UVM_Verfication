class rd_monitor extends uvm_monitor;
  `uvm_component_utils(rd_monitor)

  virtual en_if.rd_mon vif;
  rd_cfg rcfg;
  rd_xtn xtn;
  uvm_analysis_port#(rd_xtn) rd_mp;

  function new(string name = "rd_monitor" , uvm_component parent);
		super.new(name,parent);
    rd_mp=new("rd_mp",this);
	endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(rd_cfg)::get(this,"","rd_cfg",rcfg))
      `uvm_fatal(get_type_name(),"get error in rd_monitor")
  endfunction

  function void connect_phase(uvm_phase phase);
    vif=rcfg.vif;
  endfunction

  task run_phase(uvm_phase phase);
    forever
      collect_data;
  endtask

  task collect_data();
    xtn=rd_xtn::type_id::create("xtn");
    @(vif.y)
    xtn.y=vif.y;
        `uvm_info(get_type_name(),"rd monitor data",UVM_LOW);
    xtn.print();
    rd_mp.write(xtn);
  endtask
endclass
