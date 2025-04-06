class wr_driver extends uvm_driver#(wr_xtn);
  `uvm_component_utils(wr_driver)
  
  virtual en_if.wr_drv vif;
  wr_cfg wcfg;

  function new(string name = "wr_driver" , uvm_component parent);
		super.new(name,parent);
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
    forever begin
	//$display("d1 out");
      seq_item_port.get_next_item(req);
	//$display("d1");
      send_to_dut(req);
      seq_item_port.item_done();
    end
  endtask

  task send_to_dut(wr_xtn xtn);
     `uvm_info(get_type_name(),"Driver data",UVM_LOW);
    xtn.print();
    vif.a=xtn.a;
  endtask
endclass
