/*
@author : Ashutosh Singh Parmar
@brief : This file contains design for 3-8 address decoder unit
*/

module ADDRESS_DECODER(
    input [3:0] addrBus,
    input addrSel,
    output reg [16:0] selectLine
);

always @ ( addrBus )
begin
    case( {addrBus, addrSel} )
        5'b00001: line <= 16'b1111111111111110;
        5'b00011: line <= 16'b1111111111111101;
        5'b00101: line <= 16'b1111111111111011;
        5'b00111: line <= 16'b1111111111110111;
        5'b01001: line <= 16'b1111111111101111;
        5'b01011: line <= 16'b1111111111011111;
        5'b01101: line <= 16'b1111111110111111;
        5'b01111: line <= 16'b1111111101111111;
        5'b10001: line <= 16'b1111111011111111;
        5'b10011: line <= 16'b1111110111111111;
        5'b10101: line <= 16'b1111101111111111;
        5'b10111: line <= 16'b1111011111111111;
        5'b11001: line <= 16'b1110111111111111;
        5'b11011: line <= 16'b1101111111111111;
        5'b11101: line <= 16'b1011111111111111;
        5'b11111: line <= 16'b0111111111111111;
        default:  line <= 16'b1111111111111111;
    endcase
end

endmodule