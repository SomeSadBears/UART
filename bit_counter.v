`timescale 1ns / 1ps

module bit_counter
    (
        input               clk ,
                            rst ,
                            btu ,
                            doit,
        input   [3:0]       bits,
        output              done
    );
    
    reg [3:0]   count   ,
                n_count ;
    
    assign done = (count == bits);
    
    always@(posedge clk or posedge rst)
        if(rst || done)
            count   <=  4'b0;
        else
            count   <=  n_count;
    
    always@(*)
    begin
        case({doit, btu})
            2'b00:  n_count =   4'b0    ;
            2'b01:  n_count =   4'b0    ;
            2'b10:  n_count =   count   ;
            2'b11:  n_count =   count + 4'b1;
            default:n_count =   count   ;
        endcase
    end
    
endmodule