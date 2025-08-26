`timescale 1ns/1ns
module tb_syn_fifo;
//parameter,input,output declaration
parameter width=8, depth=16;
reg clk=0;
  reg rst, wr_en, rd_en;
reg [width-1:0]din;
  wire [width-1:0] dout;
wire full, empty;
//instantiating dut
  fifo_syn #(width,depth) dut (.clk(clk),.rst(rst),.wr_en(wr_en),.rd_en(rd_en),           .din(din),.dout(dout),.full(full),.empty(empty));
  // clk generation
  
  always #5 clk= ~clk;     //timeperiod is 10ns.   
 
 // task to reset fifo
 task rst_fifo;
 begin
 $display("....fifo has been reset...");
 rst=1;
 #10 rst=0;
 end
 endtask
 
 // task to write data
 task simple_write(input integer count);
 integer i; 
 begin
 $display("... doing writing operation in fifo...");
 for( i=0; i<count; i=i+1)
 begin 
 @(posedge clk);
  if(!full) begin
  
  din=i;
    wr_en=1;
    $display(" write:%0d", din);
 
  end end
  @(posedge clk);
  wr_en=0;
 end 
 endtask
 
 //task to read simply
  task simple_read (input integer a);
 integer i; 
 begin
   for(i=0; i<a; i= i+1)
 begin 
  @(posedge clk);
   if(!empty) begin    
     rd_en=1; end
  @(posedge clk);//wait for dout update
  // if(!empty)begin
 rd_en=0;
     $display("read:%0d",dout);
   end
 end
 endtask
  ////

 
 //task to do write when fifo is full
 task write_in_full_fifo(input integer a) ;
 
 begin
 @(posedge clk);
 if(full)begin
 wr_en=1;
 din=a;
 $display("not permissible");
 end
// @(posedge clk);
// wr_en=0;
 end
 endtask
 
 //task to read when fifo is empty
 task read_in_empty_fifo;
 
 begin
 @(posedge clk);
 if(empty)begin
 rd_en=1;
 $display("not permissible");
 end
@(posedge clk);
 rd_en=0;
 end
 endtask

//task to do simultaneous write and read operation
task rd_wr_simultaneous (input integer count );
integer i;
begin
//write data
din=8'h00;
for(i=0;i<count;i=i+1)
begin 
@(posedge clk);
if(!full) begin wr_en=1;
din=din+1;
$display("write: %0d", din);
end
else  begin
wr_en=0;
$display("fifo full");
end
end
//read now
if(!empty) begin 
rd_en=1;
  $display("read: %0h", dout);
end else begin
rd_en=0;
end

// deassigning control over loops
wr_en=0;
rd_en=0;
end
endtask


//real test
initial 
begin 
  
//   $monitor("[%0t] [FIFO] wr_en=%0b | din=0x%0h| rd_en=%0b| dout=0x%0h| empty=%0b| full=%0b  ",
//             $time, wr_en, din, rd_en, dout, empty, full);
  
//clk=0;rst=0; wr_en=0; rd_en=0; din=0;
//#5 rst_fifo;
//read_in_empty_fifo;
  //wr_en = 1; rd_en=0;
  simple_write(depth);
  #10;
  //simple_read(5);
  #10;
  //simple_write(4);
// //write_in_full_fifo(15);
//   wr_en = 0;rd_en=1;
//  simple_read(depth);
$display("test complete");
  #20 $finish;
end
  
  
  
initial begin
  $dumpfile("dump.vcd"); 
   $dumpvars;
 end
endmodule
