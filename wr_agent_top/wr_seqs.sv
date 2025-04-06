class base_seqs extends uvm_sequence#(wr_xtn);
    `uvm_object_utils(base_seqs)
    function new(string name="base_seqs");
        super.new(name);
    endfunction 
endclass

class first_packet extends base_seqs;
    `uvm_object_utils(first_packet)
    function new(string name="first_packet");
        super.new(name);
    endfunction 
    task body();
        repeat(50) begin
        req=wr_xtn::type_id::create("req");
        start_item(req);
        assert(req.randomize());
	    //`uvm_info(get_type_name(),"Sequence data",UVM_LOW);
	    // req.print();
        finish_item(req);
        end
    endtask
endclass
