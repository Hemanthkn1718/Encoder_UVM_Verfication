class rd_agent extends uvm_agent;
  `uvm_component_utils(rd_agent)
  rd_driver drvh;
  rd_monitor monh;
  rd_sequencer seqh;
  rd_cfg rcfg;
  function new(string name = "rd_agent" , uvm_component parent);
		super.new(name,parent);
	endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(rd_cfg)::get(this,"","rd_cfg",rcfg))
			`uvm_fatal(get_type_name(),"get error in rd_agent")
    monh=rd_monitor::type_id::create("monh",this);
    if(rcfg.is_active==UVM_ACTIVE)
    begin
      drvh=rd_driver::type_id::create("drvh",this);
      seqh=rd_sequencer::type_id::create("seqh",this);
    end
  endfunction
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(rcfg.is_active==UVM_ACTIVE)
      drvh.seq_item_port.connect(seqh.seq_item_export);
  endfunction
endclass
