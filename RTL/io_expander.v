/*
@author : Ashutosh Singh Parmar
@brief : This file contains design for 32 line, SPI input-output expander module
*/
`inlcude "spi_module.v"
`include "port.v"
`include "address_generator.v"
`include "address_decoder.v"

module SPI_IO_EXPANDER(
    input mosi,
    output miso,
    input clk,
    input en,
    input rst,
    input addrSel,
    inout [31:0] pin
);

wire [7:0] dataBus;
wire [7:0] addressBus;
wire internalEnable;

wire internalRW;

wire [15:0] selectLine;

SPI_MODULE S0( .mosi(mosi), .miso(miso), .clk(clk), .en(en), .enOut(internalEnable), .rw(internalRW), .rst(rst), .dataBus(dataBus) );

ADDRESS_GENERATOR AG0( .addrSel(addrSel), .en(internalEnable), .rst(rst), .dataBus(dataBus), .addressBus(addressBus), .rw(internalRW) );

ADDRESS_DECODER AD0( .addrBus(addressBus[2:0]), .selectLine(selectLine), .addrSel(addrSel) );

PORT P0( .pin(pin[7:0]), .regSel(selectLine[3:0]), .dataBus(.dataBus), .rst(rst), .en(internalEnable), .rw(internalRW) );
PORT P1( .pin(pin[15:8]), .regSel(selectLine[7:4]), .dataBus(.dataBus), .rst(rst), .en(internalEnable), .rw(internalRW) );
PORT P2( .pin(pin[23:16]), .regSel(selectLine[11:8]), .dataBus(.dataBus), .rst(rst), .en(internalEnable), .rw(internalRW) );
PORT P3( .pin(pin[31:24]), .regSel(selectLine[15:12]), .dataBus(.dataBus), .rst(rst), .en(internalEnable), .rw(internalRW) );

endmodule