module intel8254(
    input [7:0] data,
    input clk0,
    input clk1,
    input clk2,
    input gate0,
    input gate1,
    input gate2,
    output out0,
    output out1,
    output out2,
    input A0,
    input A1,
    input RD,
    input CS, //Remem4ber this is CS bar.
    input WR //Remember this is also WR bar.
);

wire [3:0] enable; // enable[0] for counter 0 , enable[1] for counter 1, enable[2] for counter 2, and enable[3] for control
wire [5:0] control0_old, control0, control1_old, control1, control2_old, control2;

//Instantiate read write module
RW RW(CS, A0, A1, enable);

// Instantiate Control Register.
ControlRegister CW(data, enable[3], control0_old, control1_old, control2_old, control0, control1, control25);


// Instantiate 3 counters
countInt c0 (clk0, control0, gate0, data, enable[0], out0);
countInt c1 (clk1, control1, gate1, data, enable[1], out1);
countInt c2 (clk2, control2, gate2, data, enable[2], out2); 

// Assign the control word register old values to the new values.
assign control0_old = control0;
assign control1_old = control1;
assign control2_old = control2;


endmodule