`timescale 1ns / 1ps

module shift_reg_10bit
    (
    input           clk     ,
                    rst     ,
                    shift   ,
                    sdi     ,
    output reg [9:0] q
    );
    
    always@(posedge clk or posedge rst)
        if(rst)
            q   <=  10'b0;
        else if(shift)
            q   <=  {sdi, q[9:1]};
        else
            q   <=  q;
            
endmodule
