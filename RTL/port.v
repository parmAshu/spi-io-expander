/*
@author : Ashutosh Singh Parmar
@brief : This file contains design for 8-line port with SPI interface
@description :
    Behavioral modelling has been used for this design
*/

/*
REGISTER ADDRESSES
*/
`define LINE_ADDRESS 4'b1110
`define PULLUP_REGISTER_ADDRESS 4'b1101
`define MODE_REGISTER_ADDRESS 4'b1011
`define OUTPUT_REGISTER_ADDRESS 4'b0111

module PORT(
    input en,
    input rw,
    input rst,
    inout [7:0] pin,
    inout [7:0] dataBus,
    input [3:0] regSel
);

/* LINE INPUT --------------*/

wire readLine;
wire [7:0] readLineBuff;
assign readLine <= rw && ( regSel == LINE_ADDRESS );

// connecting line to databus through an array of transmission gates

buff B00( readLineBuff[0], pin[0] );
tranif1 T00( readLineBuff[0], dataBus[0], readLine );

buff B01( readLineBuff[1], pin[1] );
tranif1 T01( readLineBuff[1], dataBus[1], readLine );

buff B02( readLineBuff[2], pin[2] );
tranif1 T02( readLineBuff[2], dataBus[2], readLine );

buff B03( readLineBuff[3], pin[3] );
tranif1 T03( readLineBuff[3], dataBus[3], readLine );

buff B00( readLineBuff[4], pin[4] );
tranif1 T00( readLineBuff[4], dataBus[4], readLine );

buff B00( readLineBuff[5], pin[5] );
tranif1 T00( readLineBuff[5], dataBus[5], readLine );

buff B00( readLineBuff[6], pin[6] );
tranif1 T00( readLineBuff[6], dataBus[6], readLine );

buff B00( readLineBuff[7], pin[7] );
tranif1 T00( readLineBuff[7], dataBus[7], readLine );

/*--------------------------*/


/* MODE REGISTER -----------*/

reg [7:0] mode;

// read value from the data bus
always @ ( posedge en )
begin
    if ( regSel == MODE_REGISTER_ADDRESS && rw == 1'b0 && rst == 1'b1 )
    begin
        mode <= dataBus;
    end
end

wire readMode;
assign readMode <= rw && ( regSel == MODE_REGISTER_ADDRESS );

// connecting line to databus through an array of transmission gates
tranif1 T10( mode[0], dataBus[0], readMode );
tranif1 T11( mode[1], dataBus[1], readMode );
tranif1 T12( mode[2], dataBus[2], readMode );
tranif1 T13( mode[3], dataBus[3], readMode );
tranif1 T14( mode[4], dataBus[4], readMode );
tranif1 T15( mode[5], dataBus[5], readMode );
tranif1 T16( mode[6], dataBus[6], readMode );
tranif1 T17( mode[7], dataBus[7], readMode );

/*--------------------------*/


/* OUTPUT LOGIC REGISTER ---*/

reg [7:0] out;

// read value from the data bus
always @ ( posedge en )
begin
    if ( regSel == OUTPUT_REGISTER_ADDRESS && rw == 1'b0 && rst == 1'b1 )
    begin
        out <= dataBus;
    end
end

/*--------------------------*/


/* PULLUP REGSITER ---------*/

reg [7:0] pullUp;

// read value from the data bus
always @ ( posedge en )
begin
    if ( regSel == PULLUP_REGISTER_ADDRESS && rw == 1'b0 && rst == 1'b1 )
    begin
        pullUp <= dataBus;
    end
end

/*--------------------------*/


/* RESET OPERATION ---------*/
always @ ( negedge rst )
begin
    out <= 8'b00000000;
    mode <= 8'b00000000;
    pullUp <= 8'b000000;
end
/*--------------------------*/


/* FINAL CONNECTIONS -------*/

tranif1 T20( out[0], pin[0], mode[0] );
tranif1 T21( out[1], pin[1], mode[1] );
tranif1 T22( out[2], pin[2], mode[2] );
tranif1 T23( out[3], pin[3], mode[3] );
tranif1 T24( out[4], pin[4], mode[4] );
tranif1 T25( out[5], pin[5], mode[5] );
tranif1 T26( out[6], pin[6], mode[6] );
tranif1 T27( out[7], pin[7], mode[7] );

/*--------------------------*/


endmodule