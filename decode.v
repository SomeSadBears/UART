`timescale 1ns / 1ps

module decode
    (
        input           eight   ,
                        pen     ,
                        ohel    ,
        input   [7:0]   d       ,
        output  reg     d9      ,
                        d10           
    );
    
    always@(*)
    begin
        case({eight, pen, ohel})
            3'b000: {d10,d9} = 2'b11;
            3'b001: {d10,d9} = 2'b11;
            3'b010: {d10,d9} = {1'b1, ^d[6:0]};
            3'b011: {d10,d9} = {1'b1, ~^d[6:0]};
            3'b100: {d10,d9} = {1'b1,d[7]};
            3'b101: {d10,d9} = {1'b1,d[7]};
            3'b110: {d10,d9} = {^d[7:0],  d[7]};
            3'b111: {d10,d9} = {~^d[7:0],  d[7]};
            default:{d10,d9} = 2'b11;
        endcase
    end
    
endmodule