module top;
    import uvm_pkg::*;
    import en_pkg::*;
    
    en_if in0();
    en_if in1();
    encoder DUT(.a(in0.a),.y(in1.y));

    initial begin
        uvm_config_db#(virtual en_if)::set(null,"*","en_if0",in0);
        uvm_config_db#(virtual en_if)::set(null,"*","en_if1",in1);
        run_test();
    end
endmodule
