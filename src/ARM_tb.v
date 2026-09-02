module ARM_tb();

    reg clk, rst, f_en;


   ARM uut (
    .clk(clk),
    .rst(rst),
    .forwading_en(f_en)
    );


    initial begin 
        clk=0;
        rst=0;
    end


    always #5 clk=~clk;


    initial begin
        f_en=0;
        #10 
        rst=1;
        #10
        rst=0;
        #3100
        #10 
        f_en=1;
        #10 
        rst=1;
        #10
        rst=0;
        #3100
        $stop;

    end

endmodule