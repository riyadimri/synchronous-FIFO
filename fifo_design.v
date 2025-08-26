// Code your design here
module fifo_syn #(parameter width=8, depth=16)
 (input clk,
 input rst,
 input wr_en,
 input rd_en,
 input [width-1:0] din,
  output reg [width-1:0] dout,
 output wire full,
 output wire empty);
  
 reg [width-1:0] mem [0: depth-1];
 reg [3:0] wr_ptr;
 reg [3:0]rd_ptr;
 reg [4:0] count;
  
  always @( posedge clk or posedge rst) begin
  if(rst) begin
  wr_ptr<=0;
  rd_ptr<=0;
  count<=0;
    dout<=0;
  end
  //write operation
  else begin 
    if(wr_en && !full)
  begin
  mem[wr_ptr]<= din;
  wr_ptr <= wr_ptr+1;   // 
  count <= count+1;   ///
  end
  //read operation
   if(rd_en && !empty)
  begin
  dout<= mem[rd_ptr];
  rd_ptr<= rd_ptr+1;
  count<= count-1;
  end
  end
  end

  // flag update
  assign full= (count== depth);
  assign empty= (count==0);  
endmodule
