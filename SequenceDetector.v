module Q2_verilog(input reset, sequence_in, clock, output detector_out);
    parameter Zero = 3'b000,
            One = 3'b001,
            OneZero = 3'b011,
            OneOne = 3'b010,
            OneZeroOne = 3'b110,
            OneOneZero = 3'b111;

    reg [2:0] current_state, next_state;

    always @(posedge clock, posedge reset)
        begin
        if(reset)
            current_state <= Zero;
        else
            current_state <= next_state;
        end 

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
    always @(current_state)
        begin 
        case(current_state) 
            Zero:   detector_out = 0;
            One:   detector_out = 0;
            OneZero:  detector_out = 0;
            OneOne:  detector_out = 0;
            OneZeroOne:  detector_out = 1;
            OneOneZero:  detector_out = 1;
            default:  detector_out = 0;
        endcase
    end 
endmodule