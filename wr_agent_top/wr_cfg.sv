class wr_cfg extends uvm_object;
    `uvm_object_utils(wr_cfg)
    virtual en_if vif;
    uvm_active_passive_enum is_active;
    function new(string name="wr_cfg");
        super.new(name);
    endfunction
endclass
