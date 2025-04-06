class env_config extends uvm_object;
    `uvm_object_utils(env_config)
    int has_wagent;
    int has_ragent;
    int has_scoreboard;
    wr_cfg wcfg;
    rd_cfg rcfg;

    function new(string name="env_config");
        super.new(name);
    endfunction
endclass
