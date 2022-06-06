`timescale 1ns / 1ps

module rx_data_path
    (
    input           clk     ,
                    rst     ,
                    btu     ,
                    start   ,
                    eight   ,
                    ohel    ,
                    pen     ,
                    rx      ,
                    reads0  ,
                    done    ,
    output          rxrdy   ,
                    perr    ,
                    ferr    ,
                    ovf     ,
    output [7:0]    uart_data
    );
    
    wire            shift   ,
                    gen_mux ,
                    rec_mux ,
                    gen_xor_mux,
                    gen_rec_xor;
                    
    reg             stop_bit;
                    
    wire [9:0]      u_data  ;
    wire [9:0]      q       ;
    
    
    assign  gen_mux = eight ? (u_data[7]) : 1'b0        ;
    assign  rec_mux = eight ? (u_data[8]) : (u_data[7]) ;
    
    assign  gen_xor_mux = ohel ?    (~{gen_mux ^ u_data[6:0]}) : 
                                    ({gen_mux ^ u_data[6:0]})  ;
    
    assign  gen_rec_xor = gen_xor_mux ^ rec_mux;
    
    assign  shift   =   btu && ~start;
    
    assign  uart_data = u_data[7:0];
    
    shift_reg_10bit rx_shift_reg10
        (
        .clk        (   clk         ),
        .rst        (   rst         ),
        .shift      (   shift       ),
        .sdi        (   rx          ),
        .q          (   q           )
        );
    
    right_justify rj
        (
        .eight      (   eight       ),
        .pen        (   pen         ),
        .q          (   q           ),
        .q_out      (   u_data      )
        );
    
    
    always@(*)
        case({eight, pen})
            2'b00   : stop_bit = ~u_data[7];
            2'b01   : stop_bit = ~u_data[8];
            2'b10   : stop_bit = ~u_data[8];
            2'b11   : stop_bit = ~u_data[9];
        endcase
    
    sr_ff   sr_rxrdy
        (
        .clk        (   clk         ),
        .rst        (   rst         ),
        .s          (   done        ),
        .r          (   reads0      ),
        .q          (   rxrdy       )
        );
        
    sr_ff   sr_perr
        (
        .clk        (   clk         ),
        .rst        (   rst         ),
        .s          (pen && gen_rec_xor && done),
        .r          (   reads0      ),
        .q          (   perr        )
        );
    
    sr_ff   sr_ferr
        (
        .clk        (   clk         ),
        .rst        (   rst         ),
        .s          (done && stop_bit),
        .r          (   reads0      ),
        .q          (   ferr        )
        );
    
    sr_ff   sr_ovf
        (
        .clk        (   clk         ),
        .rst        (   rst         ),
        .s          (done && rxrdy  ),
        .r          (   reads0      ),
        .q          (   ovf         )
        );
    
endmodule
