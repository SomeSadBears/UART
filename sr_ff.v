`timescale 1ns / 1ps
//****************************************************************//
//  File name: sr_ff.v                                             //
//                                                                //
//  Created by       juan saavedra on february 18.                //
//  Copyright © 2020 juan saavedra. All rights reserved.          //
//                                                                //
//                                                                //
//  In submitting this file for class work at CSULB               //
//  I am confirming that this is my work and the work             //
//  of no one else. In submitting this code I acknowledge that    //
//  plagiarism in student project work is subject to dismissal.   // 
//  from the class                                                //
//****************************************************************//

/***************************************************************************
 * Purpose: Implements an SR flip-flop using a 4-1 mux with two select inputs
 * and a D-flip flop. The mux selects output the following values:
 *      {s,r}   nq
 *       0 0    q
 *       0 1    0
 *       1 0    1
 *       1 1    1
 *
***************************************************************************/
module sr_ff
    (
    input           clk ,
                    rst ,
                    s   ,
                    r   ,
    output  reg     q   
    );
    
//    always@(posedge clk or posedge rst)
//        if(rst || r)
//            q <= 1'b0;
//        else if(s)
//            q <= 1'b1;
//        else 
//            q <= q;
    
    always@(posedge clk or posedge rst)
        if(rst)
            q   <=  1'b0;
        else
        begin
            case ({s,r})
                2'b00:  q  <=   q   ;
                2'b01:  q  <=   1'b0;
                2'b10:  q  <=   1'b1;
                2'b11:  q  <=   1'b1;
            endcase
        end
            
endmodule
