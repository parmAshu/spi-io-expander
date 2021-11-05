/*
@author : Ashutosh Singh Parmar
@brief : This file contains design for address generator
*/

module ADDRESS_GENERATOR(
    input addrSel,
    input en,
    input rst,
    inout [7:0] dataBus,
    output reg [3:0] addressBus
);

/* RESET OPERATION ---*/

always @ ( negedge rst )
begin
    addressBus <= 4'b0000;
end

/*--------------------*/


/* READ NEW ADDRESS FROM DATA BUS */

always @ ( posedge en )
begin
    if ( addrSel == 1'b0 && rst == 1'b1 )
    begin
        addressBus <= dataBus;     
    end
end

/* -------------------------------*/


endmodule