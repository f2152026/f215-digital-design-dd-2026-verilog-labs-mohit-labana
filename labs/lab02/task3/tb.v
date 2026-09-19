module tb;

  reg [1:0] A;
  reg [1:0] B;

  wire GT;
  wire LT;
  wire EQ;

  comp2 uut (
    .A(A),
    .B(B),
    .GT(GT),
    .LT(LT),
    .EQ(EQ)
  );

  initial begin

    A = 2'b00; B = 2'b00; #1;
    if (GT !== 0 || LT !== 0 || EQ !== 1)
      $display("FAIL: A=%b B=%b", A, B);

    A = 2'b00; B = 2'b01; #1;
    if (GT !== 0 || LT !== 1 || EQ !== 0)
      $display("FAIL: A=%b B=%b", A, B);

    A = 2'b01; B = 2'b00; #1;
    if (GT !== 1 || LT !== 0 || EQ !== 0)
      $display("FAIL: A=%b B=%b", A, B);

    A = 2'b01; B = 2'b01; #1;
    if (GT !== 0 || LT !== 0 || EQ !== 1)
      $display("FAIL: A=%b B=%b", A, B);

    A = 2'b10; B = 2'b11; #1;
    if (GT !== 0 || LT !== 1 || EQ !== 0)
      $display("FAIL: A=%b B=%b", A, B);

    A = 2'b11; B = 2'b10; #1;
    if (GT !== 1 || LT !== 0 || EQ !== 0)
      $display("FAIL: A=%b B=%b", A, B);

    A = 2'b10; B = 2'b10; #1;
    if (GT !== 0 || LT !== 0 || EQ !== 1)
      $display("FAIL: A=%b B=%b", A, B);

    A = 2'b11; B = 2'b11; #1;
    if (GT !== 0 || LT !== 0 || EQ !== 1)
      $display("FAIL: A=%b B=%b", A, B);

    $display("Testbench completed.");
    $finish;

  end

endmodule