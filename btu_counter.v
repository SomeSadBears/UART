`timescale 1ns / 1ps

module btu_counter
    (
        input               clk ,
                            rst ,
                            doit,
        input       [18:0]  k   ,
        output              btu
    );
    
    reg [18:0]  count   ,
                n_count ;
    
    assign btu = (count == k);
    
    always@(posedge clk or posedge rst)
        if(rst)
            count   <=  19'b0;
        else
            count   <=  n_count;
    
    always@(*)
    begin
        case({doit, btu})
            2'b00:  n_count = 19'b0;
            2'b01:  n_count = 19'b0;
            2'b10:  n_count = count + 19'b1;
            2'b11:  n_count = 19'b0;
            default:n_count = count;
        endcase
    end
             
endmodule