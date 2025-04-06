class wr_agent_top extends uvm_env;
  `uvm_component_utils(wr_agent_top)
  wr_agent wagent;
  wr_cfg wcfg;
  env_config cfg;
  function new(string name = "wr_agent_top" , uvm_component parent);
	  super.new(name,parent);
	endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(env_config)::get(this,"","env_config",cfg))
			`uvm_fatal(get_type_name(),"get error in wr_agent_top")
    wcfg=wr_cfg::type_id::create("wcfg");
    wcfg=cfg.wcfg;
    wagent=wr_agent::type_id::create("wagent",this);
    uvm_config_db#(wr_cfg)::set(this,"*","wr_cfg",wcfg);
  endfunction
endclass
