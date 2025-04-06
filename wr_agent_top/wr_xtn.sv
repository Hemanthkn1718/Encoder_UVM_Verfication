class wr_xtn extends uvm_sequence_item;
    `uvm_object_utils(wr_xtn)
    function new(string name="wr_xtn");
        super.new(name);
    endfunction 
    rand bit[7:0] a;
         bit[2:0] y;
    constraint one_hot_a {$onehot(a); }
    /*constraint a_constraints {
        a inside {8'b00000001, 8'b00000010, 8'b00000100, 8'b00001000,
                  8'b00010000, 8'b00100000, 8'b01000000, 8'b10000000}; 
    }*/

    function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("a",this.a,8,UVM_BIN);
        printer.print_field("y",this.y,3,UVM_BIN);
    endfunction
endclass
