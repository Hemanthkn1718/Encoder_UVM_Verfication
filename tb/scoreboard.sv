class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  // Analysis FIFOs for input and output transactions
  uvm_tlm_analysis_fifo#(wr_xtn) wr_fifo;
  uvm_tlm_analysis_fifo#(rd_xtn) rd_fifo;

  wr_xtn wr;  
  rd_xtn rd;

  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    wr_fifo = new("wr_fifo", this);
    rd_fifo = new("rd_fifo", this);
    cg_encoder=new();
  endfunction

  task run_phase(uvm_phase phase);

    forever begin
      wr_fifo.get(wr);
      //wr.print();
      rd_fifo.get(rd);
      //rd.print();
      // Reference model for 8:3 encoder (MSB priority)
      case (wr.a)
        8'b10000000: wr.y = 3'b111;
        8'b01000000: wr.y = 3'b110;
        8'b00100000: wr.y = 3'b101;
        8'b00010000: wr.y = 3'b100;
        8'b00001000: wr.y = 3'b011;
        8'b00000100: wr.y = 3'b010;
        8'b00000010: wr.y = 3'b001;
        8'b00000001: wr.y = 3'b000;
        default:     wr.y = 3'bzzz;
      endcase

      cg_encoder.sample();

      if (rd.y === wr.y)
        `uvm_info(get_type_name(), $sformatf("PASS: a=%b -> y=%b", wr.a, rd.y), UVM_LOW)
      else
        `uvm_error(get_type_name(), $sformatf("FAIL: a=%b | Expected y=%b | Got y=%b", wr.a, wr.y, rd.y));
    end
  endtask

  // Covergroup for functional coverage
  covergroup cg_encoder;
    input_cov : coverpoint wr.a {
      bins one_hot_bins[] = {
        8'b00000001,
        8'b00000010,
        8'b00000100,
        8'b00001000,
        8'b00010000,
        8'b00100000,
        8'b01000000,
        8'b10000000
      };
    }

    output_cov : coverpoint rd.y {
      bins y_bins[] = {[0:7]};
    }

    // Cross coverage to ensure input-output mapping is verified
    input_output_cross : cross input_cov, output_cov;

  endgroup


endclass
