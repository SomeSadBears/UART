`timescale 1ns / 1ps

module right_justify
    (
    input           eight   ,
                    pen     ,
    input      [9:0] q       ,
    output reg [9:0] q_out   
    );
    
    always@(*)
        case({eight, pen})
            2'b00   :   q_out = {2'b0, q[9:2]};
            2'b01   :   q_out = {1'b0, q[9:1]};
            2'b10   :   q_out = {1'b0, q[9:1]};
            default :   q_out = q;
        endcase
        
endmodule
