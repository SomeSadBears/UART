`timescale 1ns / 1ps

//****************************************************************//
//  File name: ped.v                                              //
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
 * Purpose: Utilizes two D flip-flops to implement the logic for a positive 
 * edge detector. Outputs a pulse "ped" when the positive edge of the input
 * "db" is detected.
 * 
 * Notes:  
***************************************************************************/


module ped
    (
    input   clk , 
            rst , 
            db  , 
    output  ped
    );
    
    reg q1, q2;
    
    always @ (posedge clk, posedge rst)
        if (rst)
        begin
            q1 <= 1'b0  ;
            q2 <= 1'b0  ;
        end
        
        else
        begin
            q1 <= db    ;
            q2 <= q1    ;    
        end
        
    assign ped = q1 & ~q2;
endmodule
