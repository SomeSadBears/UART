`timescale 1ns / 1ps

module addr_dec
    (
    input               write_strobe, 
                        read_strobe ,
    input      [15:0]   pid         ,
    output reg [15:0]   writes      , 
                        reads
    );
    always@(*)
    begin
        writes[15:8]  <= 8'b0;
        reads[15:8]   <= 8'b0;
        if(~pid[15])
        begin
            writes[0] <= (write_strobe & ~pid[2] & ~pid[1] & ~pid[0]);
            writes[1] <= (write_strobe & ~pid[2] & ~pid[1] &  pid[0]);
            writes[2] <= (write_strobe & ~pid[2] &  pid[1] & ~pid[0]);
            writes[3] <= (write_strobe & ~pid[2] &  pid[1] &  pid[0]); 
            writes[4] <= (write_strobe &  pid[2] & ~pid[1] & ~pid[0]);
            writes[5] <= (write_strobe &  pid[2] & ~pid[1] &  pid[0]);
            writes[6] <= (write_strobe &  pid[2] &  pid[1] & ~pid[0]);
            writes[7] <= (write_strobe &  pid[2] &  pid[1] &  pid[0]);
            
            reads[0] <= (read_strobe & ~pid[2] & ~pid[1] & ~pid[0]);
            reads[1] <= (read_strobe & ~pid[2] & ~pid[1] &  pid[0]);
            reads[2] <= (read_strobe & ~pid[2] &  pid[1] & ~pid[0]);
            reads[3] <= (read_strobe & ~pid[2] &  pid[1] &  pid[0]); 
            reads[4] <= (read_strobe &  pid[2] & ~pid[1] & ~pid[0]);
            reads[5] <= (read_strobe &  pid[2] & ~pid[1] &  pid[0]);
            reads[6] <= (read_strobe &  pid[2] &  pid[1] & ~pid[0]);
            reads[7] <= (read_strobe &  pid[2] &  pid[1] &  pid[0]);
        end
    end
endmodule 