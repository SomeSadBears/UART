`timescale 1ns / 1ps

module shift_reg
    (
        input           clk     ,
                        rst     ,
                        ld      ,
                        sh      ,
                        sdi     ,
        input   [10:0]  din     ,
        output          sd0
    );
    
    reg [10:0]  q;
    
    assign sd0 = q[0];
    
    always@(posedge clk, posedge rst)
        if(rst)
            q   <=  11'h7_FF;
        else if(ld)
            q   <=  din     ;
        else if(sh)
            q   <=  {sdi, q[10:1]};
        else
            q   <=  q       ;
endmodule