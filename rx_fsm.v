`timescale 1ns / 1ps

module rx_fsm
    (
        input           clk     ,
                        rst     ,
                        rx      ,
                        btu     ,
                        done    ,
        output reg      start   ,
                        doit    
    );
    
    reg [1:0]       state   ,
                    nstate  ;
                    
    reg             nstart  ,
                    ndoit   ;
                    
    always@(posedge clk or posedge rst)
        if(rst) 
            {state, start, doit} <= 4'b00_0_0;
        else      
            {state, start, doit} <= {nstate, nstart, ndoit};
          
   always@(*)
      case(state)
         2'b00  : {nstate, nstart, ndoit} = (rx)   ? 4'b00_0_0 : 4'b01_1_1 ;
         2'b01  : {nstate, nstart, ndoit} = (rx)   ? 4'b00_0_0 :
                                            (btu)  ? 4'b10_0_1 : 4'b01_1_1 ;
         2'b10  : {nstate, nstart, ndoit} = (done) ? 4'b00_0_0 : 4'b10_0_1 ;
         default: {nstate, nstart, ndoit} =          4'b00_0_0 ;
      endcase
    
endmodule
