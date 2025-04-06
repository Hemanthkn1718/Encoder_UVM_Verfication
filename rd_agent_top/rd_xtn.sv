class rd_xtn extends uvm_sequence_item;
    `uvm_object_utils(rd_xtn)
    function new(string name="rd_xtn");
        super.new(name);
    endfunction 
    bit[2:0]y;
    function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("y",this.y,3,UVM_BIN);
    endfunction
endclass
