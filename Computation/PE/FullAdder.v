module full_adder(a,b,cin,sum,cout);

    input a, b, cin;
    output sum, cout;

    assign cout = a&b | b&cin | cin&a;
    assign sum = a^b^cin;


endmodule
