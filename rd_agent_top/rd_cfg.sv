class rd_cfg extends uvm_object;
    `uvm_object_utils(rd_cfg)
    virtual en_if vif;
    uvm_active_passive_enum is_active;
    function new(string name="rd_cfg");
        super.new(name);
    endfunction
endclass
