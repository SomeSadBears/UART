`timescale 1ns / 1ps

module tx_eng
    (
    input           clk     ,
                    rst     ,
                    writes0 ,
                    eight   ,
                    pen     ,
                    ohel    ,
    input   [3:0]   baud_val,
    input   [7:0]   tb_in   ,
    output          tx      ,
    output reg      tx_rdy
    );
    
    wire            doit    ,
                    done    ,
                    btu     ,
                    d9      ,
                    d10     ,
                    tx_buf  ;
                    
    wire    [18:0]  k       ;
    
    reg             ld      ;
                    //tx_buf  ;
                    
    reg     [7:0]   ld_data ;
    
    assign  tx = tx_buf     ;
    
    always@(posedge clk or posedge rst)
        if(rst)
            ld_data <=  8'b0;
        else if(writes0)
            ld_data <=  tb_in;
        else
            ld_data <=  ld_data;
            
    always@(posedge clk or posedge rst)
        if(rst)
            ld      <=  1'b0;
        else
            ld      <=  writes0;
    
//    sr_ff   sr_tx_rdy
//        (
//        .clk    (   clk         ),
//        .rst    (   rst         ),
//        .s      (   done        ),  
//        .r      (   writes0     ),
//        .q      (   tx_rdy      )
//        );
        
    always@(posedge clk or posedge rst)
        if(rst)
            tx_rdy   <=  1'b1;
        else
        begin
            case ({done,writes0})
                2'b00:  tx_rdy  <=   tx_rdy   ;
                2'b01:  tx_rdy  <=   1'b0;
                2'b10:  tx_rdy  <=   1'b1;
                2'b11:  tx_rdy  <=   1'b1;
            endcase
        end
        
    sr_ff   sr_tx_doit
        (
        .clk    (   clk         ),
        .rst    (   rst         ),
        .s      (   writes0     ),
        .r      (   done        ),
        .q      (   doit        )
        );
    
    decode  tx_dec
        (
        .eight  (   eight       ),
        .pen    (   pen         ),
        .ohel   (   ohel        ),
        .d      (   ld_data     ),
        .d9     (   d9          ),
        .d10    (   d10         )           
        );
    
    shift_reg   tx_s_reg
        (
        .clk    (   clk         ),
        .rst    (   rst         ),
        .ld     (   ld          ),
        .sh     (   btu         ),
        .sdi    (   1'b1        ),
        .din    ({d10,d9,ld_data[6:0],2'b01}),
        .sd0    (   tx_buf      )
        );
    
    baud_decode tx_baud_dec
       (
       .baud_val(   baud_val    ),
       .k       (   k           )
       );
    
    btu_counter tx_btu_count
        (
        .clk    (   clk         ),
        .rst    (   rst         ),
        .doit   (   doit        ),
        .k      (   k           ),
        .btu    (   btu         )
        );
    
    bit_counter tx_bit_count
        (
        .clk    (   clk         ),
        .rst    (   rst         ),
        .btu    (   btu         ),
        .doit   (   doit        ),
        .bits   (   4'd11       ),
        .done   (   done        )
        );
    
endmodule
