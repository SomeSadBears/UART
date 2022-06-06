`timescale 1ns / 1ps

module baud_decode
    (
        input       [3:0]   baud_val,
        output  reg [18:0]  k
    );
    
    
    always@(*)
        case (baud_val)
            4'b0000:    k = 19'd333_333;
            4'b0001:    k = 19'd083_333;
            4'b0010:    k = 19'd041_667;
            4'b0011:    k = 19'd020_833;
            4'b0100:    k = 19'd010_417;
            4'b0101:    k = 19'd005_208;
            4'b0110:    k = 19'd002_604;
            4'b0111:    k = 19'd001_736;
            4'b1000:    k = 19'd000_868;
            4'b1001:    k = 19'd000_434;
            4'b1010:    k = 19'd000_217;
            4'b1011:    k = 19'd000_109;
            default:    k = 19'd333_333;
        endcase
endmodule
