`timescale 1ns / 1ps

module uart_top
    (
        input           clk     ,
                        rst     ,
                        rx      ,
                        eight   ,
                        pen     ,
                        ohel    ,
                        writes0 ,
                        writes6 ,
        input   [1:0]   reads10 ,
        input   [3:0]   baud_val,
        input   [7:0]   in_port ,
        output          uart_int,
                        tx      ,
        output reg [7:0]uart_ds   
    );
    
                
    wire        ovf     ,
                ferr    ,
                perr    ,
                txrdy   ,
                rxrdy   ,
                txint   ,
                rxint   ;

    
    wire [7:0]  uart_rdata  ,
                status      ;
                
    assign  status =    {3'b0, ovf, ferr, perr, txrdy, rxrdy};
    
    assign  uart_int    =   rxint  ||  txint;
    
    always@(*)
        case(reads10)
            2'b00:  uart_ds = 8'b0;
            2'b01:  uart_ds = uart_rdata;
            2'b10:  uart_ds = status;
            2'b11:  uart_ds = 8'b0;
            default:uart_ds = 8'b0;
        endcase
    
    tx_eng  tx_top
        (
        .clk        (   clk         ),
        .rst        (   rst         ),
        .writes0    (   writes0     ),
        .eight      (   eight       ),
        .pen        (   pen         ),  
        .ohel       (   ohel        ),
        .baud_val   (   baud_val    ),
        .tb_in      (   in_port     ),
        .tx         (   tx          ),
        .tx_rdy     (   txrdy       )
        );
    
    rx_eng rx_eng
        (
        .clk        (   clk         ),
        .rst        (   rst         ),
        .eight      (   eight       ),
        .pen        (   pen         ),
        .ohel       (   ohel        ),
        .rx         (   rx          ),
        .reads0     (   reads10[0]  ),
        .baud_val   (   baud_val    ),
        .ovf        (   ovf         ),
        .ferr       (   ferr        ),
        .perr       (   perr        ),
        .rxrdy      (   rxrdy       ),
        .tb_out     (   uart_rdata  )  
        );
    
    
    ped rxrdy_ped
        (
        .clk        (   clk         ), 
        .rst        (   rst         ), 
        .db         (   rxrdy       ), 
        .ped        (   rxint       )
       );
       
   ped txrdy_ped
       (
       .clk        (   clk         ), 
       .rst        (   rst         ), 
       .db         (   txrdy       ), 
       .ped        (   txint        )
      );
      
endmodule
