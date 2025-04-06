class wr_agent extends uvm_agent;
  `uvm_component_utils(wr_agent)
  wr_driver drvh;
  wr_monitor monh;
  wr_sequencer seqh;
  wr_cfg wcfg;
  function new(string name = "wr_agent" , uvm_component parent);
		super.new(name,parent);
	endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(wr_cfg)::get(this,"","wr_cfg",wcfg))
			`uvm_fatal(get_type_name(),"get error in wr_agent")
    monh=wr_monitor::type_id::create("monh",this);
    if(wcfg.is_active==UVM_ACTIVE)
    begin
      drvh=wr_driver::type_id::create("drvh",this);
      seqh=wr_sequencer::type_id::create("seqh",this);
    end
  endfunction
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(wcfg.is_active==UVM_ACTIVE)
      drvh.seq_item_port.connect(seqh.seq_item_export);
  endfunction
endclass
