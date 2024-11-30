# verilog-fifo
A synchronous Verilog implementation of a circular buffer FIFO
# Verilog FIFO Implementation

This repository contains a **synchronous FIFO (First-In-First-Out)** buffer implemented in Verilog. The design uses a circular buffer approach to efficiently store and retrieve data in a queue-like manner.

## Features
- **4-entry circular buffer** for data storage.
- **Push and pop operations** for adding and retrieving data.
- Flags for **full** and **empty** status.
- Synchronous operation using a single clock signal (`clk`).
- Reset functionality to clear the FIFO state.

## Module Details
### **Inputs**
- `clk`: Clock signal for synchronous operation.
- `reset`: Resets the FIFO, clearing all data and pointers.
- `push_i`: Control signal to push data into the FIFO.
- `pop_i`: Control signal to pop data from the FIFO.
- `data_in`: 8-bit input data to be written into the FIFO.

### **Outputs**
- `data_out`: 8-bit output data retrieved from the FIFO.
- Internal flags (`full` and `empty`) for indicating the FIFO status.

### **Internal Logic**
The FIFO uses a circular buffer mechanism with:
- **Write pointer (`wr_ptr`)**: Tracks where new data is written.
- **Read pointer (`rd_ptr`)**: Tracks where data is read.
- The pointers wrap around using modulo logic (`% 4`) to manage the 4-entry buffer.

## Operation
1. **Push Operation**:
   - Adds `data_in` to the FIFO at the current write pointer (`wr_ptr`).
   - Increments `wr_ptr` (with wrap-around).

2. **Pop Operation**:
   - Outputs `data_out` from the current read pointer (`rd_ptr`).
   - Clears the read location and increments `rd_ptr` (with wrap-around).

3. **Full and Empty Flags**:
   - **Full**: Set when the FIFO cannot accept new data (`wr_ptr + 1 == rd_ptr`).
   - **Empty**: Set when the FIFO has no data to read (`wr_ptr == rd_ptr`).

## File Structure
- `fifo.v`: The Verilog module implementing the FIFO.
- `README.md`: Documentation for the project (this file).

## Usage
1. Include the `fifo.v` file in your Verilog project.
2. Instantiate the module in your design:
   ```verilog
   fifo fifo_inst (
       .clk(clk),
       .reset(reset),
       .push_i(push_i),
       .pop_i(pop_i),
       .data_in(data_in),
       .data_out(data_out)
   );
