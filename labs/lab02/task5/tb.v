module tb;

  reg [3:0] a;
  reg [3:0] b;
  reg op;

  wire [3:0] result;

  alu uut (
    .a(a),
    .b(b),
    .op(op),
    .result(result)
  );

  task check;
    input [3:0] expected;
    begin
      #1;
      if (result !== expected)
        $display("FAIL: a=%d b=%d op=%b result=%d expected=%d",
                 a, b, op, result, expected);
      else
        $display("PASS: a=%d b=%d op=%b result=%d",
                 a, b, op, result);
    end
  endtask

  initial begin

    // Addition
    a = 4; b = 3; op = 0;
    check(7);

    // Change ONLY op.
    // This should change result from 7 to 1.
    // Catches the sensitivity-list bug.
    op = 1;
    check(1);

    // Change input while subtracting.
    // This exercises the subtract path.
    a = 5; b = 3; op = 1;
    check(2);

    a = 8; b = 3; op = 1;
    check(5);

    a = 7; b = 2; op = 1;
    check(5);

    // More addition tests
    a = 5; b = 6; op = 0;
    check(11);

    a = 9; b = 4; op = 0;
    check(13);

    // More subtraction tests
    a = 9; b = 4; op = 1;
    check(5);

    a = 3; b = 7; op = 1;
    check(12);

    $display("Testbench completed.");
    $finish;

  end

endmodule