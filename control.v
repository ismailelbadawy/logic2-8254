module ControlRegister(
    input [7:0] data,
    input enable,
    input [5:0] counter0old,
    input [5:0] counter1old,
    input [5:0] counter2old,
    output [5:0] counter0Control,
    output [5:0] counter1Control,
    output [5:0] counter2Control
);

reg [7:0] controlWord;

always @(posedge enable, data) begin
  if (enable == 1) begin
    controlWord = data;
  end
end

// Chip select is in the two most significant bits.
wire [1:0] SC;
assign SC = {controlWord[7], controlWord[6]};

assign counter0Control = (SC == 0 ? controlWord[5:0] : counter0old);
assign counter1Control = (SC == 1 ? controlWord[5:0] : counter1old);
assign counter2Control = (SC == 2 ? controlWord[5:0] : counter2old);

endmodule