
module mult_tb();
	reg [31:0] a,b,sol;
	wire [31:0] mult;

	initial begin 
		a = 32'h40200000; b = 32'h40400000; sol = 32'h40f00000;  // 2.5* 3.0
		#1 a = 32'h3f4f245a; b = 32'h3f34c34a; sol = 32'h3f124394;  // 0.80914843*0.7061049
		#1 a = 32'h3f03ffe8; b = 32'h3ea40f69; sol = 32'h3e292fc6;  // 0.51562357*0.32043007
		#1 a = 32'h3f3ff224; b = 32'h3e76fe41; sol = 32'h3e393151;  // 0.7497885*0.24120428
		#1 a = 32'h49742400; b = 32'h4cead734; sol = 32'h56dff624;  // 1000000.0*123124128.0
		#1 a = 32'h40400000; b = 32'h00000000; sol = 32'h00000000;  // 3.0 * 0.0
		#1 a = 32'hbf8ccccd; b = 32'h40a00000; sol = 32'hc0b00000;  // -1.1 * 5.0
		#1 a = 32'h7f800000; b = 32'h00000000; sol = 32'h00000000;  // infinity * 0 = 0x00000000
		#1 a = 32'h00000000; b = 32'h7f800000; sol = 32'h00000000;  // 0 * infinity = 0x00000000
		#1 a = 32'hbf800000; b = 32'h7f800000; sol = 32'hff800000;  // -1 * infinity = 0xff800000
		#1 a = 32'h3f800000; b = 32'hff800000; sol = 32'hff800000;  // 1 * -infinity = 0xff800000
		#1 a = 32'hbf800000; b = 32'hff800000; sol = 32'h7f800000;  // -1 * -infinity = 0x7f800000
		#1 a = 32'h00000001; b = 32'h40000000; sol = 32'h00000002;  // 1.4E-45 * 2 = 2.8e-45
		#1 a = 32'h00000001; b = 32'h3f000000; sol = 32'h00000000;  // 1.4E-45 * 0.5 = 7e-46 (0)
		#1 a = 32'h00000001; b = 32'h7f7fffff; sol = 32'h34ffc345;  // 1.4E-45 * 3.4028235E38 = 4.7639529e-7
		#1 a = 32'h7f7fffff; b = 32'h00000001; sol = 32'h34ffc345;  // 3.4028235E38 * 1.4E-45 = 4.7639529e-7
		#1 a = 32'h7f7fffff; b = 32'h3f000000; sol = 32'h7effffff;  // 3.4028235E38 * 0.5 = 1.7014117e38
		#1 a = 32'h7f7fffff; b = 32'h40000000; sol = 32'h7f800000;  // 3.4028235E38 * 2 = 6.805647e38 (infinite)
		#1 a = 32'h0d80380f; b = 32'h747958b2; sol = 32'h4279c5e7;  // 7.902105E-31 * 7.902105E31 = 62.443263431
		#1 a = 32'h00800000; b = 32'h3f000000; sol = 32'h00400000;  // 1.17549435E-38 * 0.5 = 5.877472E-39

		#3 $stop;
	end

	mult_f32 mf(.a(a), .b(b), .m(mult));

    initial
        $monitor("At time %t, a(%h) * b(%h) = (?0x%h?) mult(0x%h)",
                $time, a, b, sol, mult);

endmodule 