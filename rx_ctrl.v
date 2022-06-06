`timescale 1ns / 1ps

module rx_ctrl
    (
        input           clk     ,
                        rst     ,
                        rx      ,
                        eight   ,
                        pen     ,
        input   [3:0]   baud_val,
        output          btu     ,
                        start   ,
                        done    
    );
    
    wire            doit;
    
    wire    [18:0]  k   ,
                    k2  ,
                    k_mux;
    
    reg     [3:0]   bits;
    
    
    rx_fsm rx_fsm
        (
        .clk        (   clk         ),
        .rst        (   rst         ),
        .rx         (   rx          ),
        .btu        (   btu         ),
        .done       (   done        ),
        .start      (   start       ),
        .doit       (   doit        )    
        );
    
    
    baud_decode rx_baud_dec
        (
        .baud_val   (   baud_val    ),
        .k          (   k           )
        );
    
    assign k_mux = (start) ? (k >> 1) : k;
    
    btu_counter rx_btu_count
        (
        .clk        (   clk         ),
        .rst        (   rst         ),
        .doit       (   doit        ),
        .k          (   k_mux       ),
        .btu        (   btu         )
        );
        
    always@(*)
        case({eight, pen})
            2'b00  : bits = 4'd9;
            2'b11  : bits = 4'd11;
            default: bits = 4'd10;
        endcase
        
     bit_counter rx_bit_count
       (
       .clk         (   clk         ),
       .rst         (   rst         ),
       .btu         (   btu         ),
       .doit        (   doit        ),
       .bits        (   bits        ),
       .done        (   done        )
       );
    
endmodule
