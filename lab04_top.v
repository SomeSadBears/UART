`timescale 1ns / 1ps

module lab04_top
    (
    input               clk     ,
                        rst     ,
                        rx      ,
    input   [7:0]       SW      ,
    output              tx      ,
    output  [15:0]      LED    
    );
    
    wire        uart_int    ,
                rst_s       ,
                read_strobe ,
                write_strobe,
                int_ack     ;
    
    wire [7:0]  uart_ds     ;
    
    wire [15:0] reads       ,
                writes      ,
                port_id     ,
                out_port    ;
                
    assign LED = ((port_id == 16'd2) && write_strobe) ? out_port : LED;
    
    aiso aiso
        (
        .clk        (   clk         ), 
        .rst        (   rst         ),
        .rst_s      (   rst_s       )
        );
    
    uart_top UART
        (
        .clk        (   clk         ),
        .rst        (   rst_s       ),
        .rx         (   rx          ),
        .eight      (   SW[3]       ),
        .pen        (   SW[2]       ),
        .ohel       (   SW[1]       ),
        .writes0    (   writes[0]   ),
        .writes6    (   writes[6]   ),
        .reads10    (   reads[1:0]  ),
        .in_port    (  out_port[7:0]),
        .baud_val   (   SW[7:4]     ),
        .uart_int   (   uart_int    ),
        .tx         (   tx          ),
        .uart_ds    (   uart_ds     )   
        );
    
    addr_dec addr_dec
        (
        .write_strobe(  write_strobe),
        .read_strobe(   read_strobe ),
        .pid        (   port_id     ),
        .writes     (   writes      ), 
        .reads      (   reads       )
        );
        
    tramelblaze_top tb_top
        (
        .CLK        (   clk         ),
        .RESET      (   rst_s       ),
        .IN_PORT    ({8'b0, uart_ds}),
        .INTERRUPT  (   uart_int    ),
        .OUT_PORT   (   out_port    ),
        .PORT_ID    (   port_id     ),
        .READ_STROBE(   read_strobe ),
        .WRITE_STROBE(  write_strobe),
        .INTERRUPT_ACK( int_ack     )
        );
        
endmodule
