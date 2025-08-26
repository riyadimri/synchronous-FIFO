 # Synchronous FIFO Design and Verification
This project is about **designing and verification of Synchronous FIFO** (width=8, depth=16).
FIFO- First In First Out. A synchronous FIFO is a type of data buffer, used to store and retrieve data in the order it was received. It prevents data loss and corruption.
**Synchronous** refers to the fact that data is written and read operation are controlled using the same clock signal. 
## Parameters:
- **width=8**
- **depth=16**
---
## Ports: 
### Input ports:-
- **clk** : positive-edge triggering.
- **rst**: active high reset.
- **din [width-1:0]** : input data to be written in FIFO.
- **wr_en**: write enable signal.
- **rd_en**: read enable signal.
### output ports:- 
- **dout[width-1:0]**: output data to be read from the FIFO.
- **full**: high, when FIFO is full.
- **empty**: empty, when FIFO is empty.
---  
## Internal registers:- 
- **mem**: array to store FIFO data.
- **wr_ptr[3:0]**: write pointer.
- **rd_ptr[3:0]**: read pointer.
---
## Testcases Covered:
- simple write
- simple read
- multiple write
- multiple read
- FIFO full condition
- FIFO empty condition
- reset functionality
- wrap-around condition
---
## Demo Video
- click below to watch the demo:
- [![Watch the video](https://img.youtube.com/vi/bPtL3ZmerzE/0.jpg)](https://youtu.be/bPtL3ZmerzE) 
