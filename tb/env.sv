class env extends uvm_env;
`uvm_component_utils(env)
	env_config cfg;
	wr_agent_top wtop;
	rd_agent_top rtop;
	scoreboard sbh;
    function new(string name = "env" , uvm_component parent);
		super.new(name,parent);
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(env_config)::get(this,"","env_config",cfg))
			`uvm_fatal(get_type_name(),"get error in env")
		if(cfg.has_wagent)
			wtop=wr_agent_top::type_id::create("wtop",this);
		if(cfg.has_ragent)
			rtop=rd_agent_top::type_id::create("rtop",this);
		if(cfg.has_scoreboard)
			sbh=scoreboard::type_id::create("sbh",this);
	endfunction
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		wtop.wagent.monh.wr_mp.connect(sbh.wr_fifo.analysis_export);
		rtop.ragent.monh.rd_mp.connect(sbh.rd_fifo.analysis_export);
	endfunction
endclass
