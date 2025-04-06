class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  int has_wagent=1;
  int has_ragent=1;
  int has_scoreboard=1;
  wr_cfg wcfg;
  rd_cfg rcfg;

  env_config cfg;
  env envh;
  function new(string name = "base_test" , uvm_component parent);
		super.new(name,parent);
	endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg=env_config::type_id::create("cfg");
    if(has_wagent)
    begin
      wcfg=wr_cfg::type_id::create("wcfg");
      if(!uvm_config_db#(virtual en_if)::get(this,"","en_if0",wcfg.vif))
        `uvm_fatal(get_type_name(),"get failed in test wagent")
      wcfg.is_active=UVM_ACTIVE;
      cfg.wcfg=wcfg;
    end
    if(has_ragent)
    begin
      rcfg=rd_cfg::type_id::create("rcfg");
      if(!uvm_config_db#(virtual en_if)::get(this,"","en_if1",rcfg.vif))
        `uvm_fatal(get_type_name(),"get failed in test ragent")
      rcfg.is_active=UVM_PASSIVE;
      cfg.rcfg=rcfg;
    end
    cfg.has_wagent=has_wagent;
    cfg.has_ragent=has_ragent;
    cfg.has_scoreboard=has_scoreboard;
    uvm_config_db#(env_config)::set(this,"*","env_config",cfg);
    envh=env::type_id::create("envh",this);
  endfunction
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology;
  endfunction
endclass

class first_test extends base_test;
  `uvm_component_utils(first_test)
  function new(string name ="first_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  first_packet first;;
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
     first=first_packet::type_id::create("first");
     first.start(envh.wtop.wagent.seqh);
    phase.drop_objection(this);
  endtask
endclass
