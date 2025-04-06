class rd_agent_top extends uvm_env;
  `uvm_component_utils(rd_agent_top)
  rd_agent ragent;
  rd_cfg rcfg;
  env_config cfg;
  function new(string name = "rd_agent_top" , uvm_component parent);
		super.new(name,parent);
	endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(env_config)::get(this,"","env_config",cfg))
			`uvm_fatal(get_type_name(),"get error in rd_agent_top")
    rcfg=rd_cfg::type_id::create("rcfg");
    rcfg=cfg.rcfg;
    ragent=rd_agent::type_id::create("ragent",this);
    uvm_config_db#(rd_cfg)::set(this,"*","rd_cfg",rcfg);
  endfunction
endclass
