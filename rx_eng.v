`timescale 1ns / 1ps

module rx_eng
    (
    input           clk     ,
                    rst     ,
                    eight   ,
                    pen     ,
                    ohel    ,
                    rx      ,
                    reads0  ,
    input [3:0]     baud_val,
    output          ovf     ,
                    ferr    ,
                    perr    ,
                    rxrdy   ,
    output [7:0]    tb_out  
    );
    
    wire        btu     ,
                start   ,
                done    ;
    
    rx_ctrl rx_ct
        (
        .clk        (   clk         ),
        .rst        (   rst         ),
        .rx         (   rx          ),
        .eight      (   eight       ),
        .pen        (   pen         ),
        .baud_val   (   baud_val    ),
        .btu        (   btu         ),
        .start      (   start       ),
        .done       (   done        )
        );
        
    rx_data_path rx_dp
        (
        .clk        (   clk         ),
        .rst        (   rst         ),
        .btu        (   btu         ),
        .start      (   start       ),
        .eight      (   eight       ),
        .ohel       (   ohel        ),
        .pen        (   pen         ),
        .rx         (   rx          ),
        .reads0     (   reads0      ),
        .done       (   done        ),
        .rxrdy      (   rxrdy       ),
        .perr       (   perr        ),
        .ferr       (   ferr        ),
        .ovf        (   ovf         ),
        .uart_data  (   tb_out      )
        );
        
endmodule
