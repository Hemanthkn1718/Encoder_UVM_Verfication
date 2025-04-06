interface en_if;
	logic [7:0]a;
	logic [2:0]y;

modport wr_drv(output a);
modport wr_mon(input a);
modport rd_mon(input y);

endinterface
