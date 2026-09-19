// cla4.v
// Gate-level 4-bit carry-lookahead adder, matching the lecture circuit.
// Every gate needs an explicit delay (constant is fine here, e.g. #(2)) --
// this is the default from Task 2 onward, not a special step.
//
// TODO -- Step 1: generate/propagate signals (one xor + one and per bit)
//   p[i] = a[i] ^ b[i]
//   g[i] = a[i] & b[i]
//
// TODO -- Step 2: direct (non-recursive) carry equations. Verilog's and/or
// primitives accept more than 2 inputs directly, e.g.:
//   and #(2) (t2, p1, p0, g0);
// so you do not need to manually chain 2-input gates.
//   c1 = g0 + p0.cin
//   c2 = g1 + p1.g0 + p1.p0.cin
//   c3 = g2 + p2.g1 + p2.p1.g0 + p2.p1.p0.cin
//   c4 = g3 + p3.g2 + p3.p2.g1 + p3.p2.p1.g0 + p3.p2.p1.p0.cin
//
// TODO -- Step 3: sum bits
//   sum[i] = p[i] ^ c[i]     (c0 = cin)

module cla4(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  wire p0, p1, p2, p3;
  wire g0, g1, g2, g3;
  wire c1, c2, c3;

wire c1_t1;
wire c2_t1, c2_t2;
wire c3_t1,c3_t2,c3_t3;
wire c4_t1,c4_t2,c4_t3,c4_t4;

xor #(2) X0(p0, a[0], b[0]);
xor #(2) X1(p1, a[1], b[1]);
xor #(2) X2(p2, a[2], b[2]);
xor #(2) X3(p3, a[3], b[3]);

// Generate
and #(2) G0(g0, a[0], b[0]);
and #(2) G1(g1, a[1], b[1]);
and #(2) G2(g2, a[2], b[2]);
and #(2) G3(g3, a[3], b[3]);

// c1 = g0 + p0.cin
and #(2) C1_A(c1_t1, p0, cin);
or  #(2) C1_OR(c1, g0, c1_t1);

// c2 = g1 + p1.g0 + p1.p0.cin
and #(2) C2_A(c2_t1, p1, g0);
and #(2) C2_B(c2_t2, p1, p0, cin);
or  #(2) C2_OR(c2, g1, c2_t1, c2_t2);

// c3 = g2 + p2.g1 + p2.p1.g0 + p2.p1.p0.cin
and #(2) C3_A(c3_t1, p2, g1);
and #(2) C3_B(c3_t2, p2, p1, g0);
and #(2) C3_C(c3_t3, p2, p1, p0, cin);
or  #(2) C3_OR(c3, g2, c3_t1, c3_t2, c3_t3);

// c4 = g3 + p3.g2 + p3.p2.g1 + p3.p2.p1.g0 + p3.p2.p1.p0.cin
and #(2) C4_A(c4_t1, p3, g2);
and #(2) C4_B(c4_t2, p3, p2, g1);
and #(2) C4_C(c4_t3, p3, p2, p1, g0);
and #(2) C4_D(c4_t4, p3, p2, p1, p0, cin);

or #(2) C4_OR(cout, g3, c4_t1, c4_t2, c4_t3, c4_t4);

// Sum
xor #(2) S0(sum[0], p0, cin);
xor #(2) S1(sum[1], p1, c1);
xor #(2) S2(sum[2], p2, c2);
xor #(2) S3(sum[3], p3, c3);

endmodule

