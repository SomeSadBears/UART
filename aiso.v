`timescale 1ns / 1ps

//****************************************************************//
//  File name: aiso.v                                             //
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
 * Purpose: Implements two D flip-flops to generate an Asynchronous In 
 * Synchronous Out circuit. Takes an asynchronous reset as an input and 
 * outputs a synchronous reset (rst_s). 
 *
***************************************************************************/

module aiso
    (
    input   clk     , 
            rst     ,
    output  rst_s
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
            q1 <= 1'b1  ;
            q2 <= q1    ;
        end
    
    assign rst_s = ~q2;
    
endmodule
