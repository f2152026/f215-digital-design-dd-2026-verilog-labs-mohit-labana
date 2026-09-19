// tb.v
// Testbench for LUT

module tb;

  // Inputs and outputs
  reg [1:0] sel;
  wire [7:0] dout;

  // Instantiate LUT
  lut U1 (
    .sel(sel),
    .dout(dout)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, U1);
    end
  end

  initial begin
    sel = 2'b00;
    #5 sel = 2'b01;
    #5 sel = 2'b10;
    #5 sel = 2'b11;
    #5 $finish;
  end

  initial
    $monitor($time, " sel=%b | dout=%d", sel, dout);

endmodule