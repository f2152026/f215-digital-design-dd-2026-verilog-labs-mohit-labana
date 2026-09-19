module DUT (
  input I0,
  input I1,
  input S,
  output Y
);

  assign Y = (~S & I0) | (S & I1);

endmodule
