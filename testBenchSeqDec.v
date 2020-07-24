// output detector_out is correct version but I needed
// to synthetize the module using iverilog so that's the reason
module Sequence_decoder(input reset, sequence_in, clock, output reg detector_out);
    // Parametrizing all the steps
    parameter Zero = 3'b000,
            One = 3'b001,
            OneZero = 3'b011,
            OneOne = 3'b010,
            OneZeroOne = 3'b110,
            OneOneZero = 3'b111;
    
    // decraling state registers
    reg [2:0] current_state, next_state;

    // catching changes of clock n reset
    always @(posedge clock, posedge reset)
        begin
        // resets the sequence decoder
            if(reset)
                current_state <= Zero;
            else
                current_state <= next_state;
        end
        
        // current state and sequence state changes
        // the rest is about jumping from one state to the next
        always @(current_state, sequence_in)
            begin
            case(current_state) 
                Zero: begin
                if(sequence_in)
                    next_state = One;
                else
                    next_state = Zero;
                end

                One: begin
                if(sequence_in)
                    next_state = OneOne;
                else
                    next_state = OneZero;
                end

                OneZero: begin
                if(sequence_in)
                    next_state = OneZeroOne;
                else
                    next_state = Zero;
                end

                OneOne: begin
                if(sequence_in)
                    next_state = OneOne;
                else
                    next_state = OneOneZero;
                end

                OneZeroOne: begin
                if(sequence_in)
                    next_state = OneOne;
                else
                    next_state = OneZero;
                end

                OneOneZero: begin
                if(sequence_in)
                    next_state = OneZeroOne;
                else
                    next_state = Zero;
                end
                
                default:next_state = Zero;
            endcase
        end
    
    // output from the input sequence
    always @(current_state)
        begin 
        case(current_state) 
            Zero: detector_out = 0;
            One: detector_out = 0;
            OneZero: detector_out = 0;
            OneOne: detector_out = 0;
            OneZeroOne: detector_out = 1;
            OneOneZero: detector_out = 1;
            default: detector_out = 0;
        endcase
    end 
endmodule

module tb;
  reg clk, in, rstn;
  wire out;
  integer l_dly;

  always #10 clk = ~clk;

  Sequence_decoder something ( .reset(rstn), .sequence_in(in), .clock(clk), .detector_out(out) );

  initial begin
  	clk <= 0;
    rstn <= 0;
    in <= 0;

    repeat (5) @ (posedge clk);
    rstn <= 1;

    @(posedge clk) in <= 1;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 0;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 0;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 0;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 0;
    @(posedge clk) in <= 1;
    #100 $finish;
  end
endmodule