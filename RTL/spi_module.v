/*
@author : Ashutosh Singh Parmar
@brief : This file contains design for 8 bit SPI module. This module will be used to read/write data from/to internal registers.
@description :
    SPI BUS
        > Data is sampled at negative clock edge
        > Data is shifted out at positive clock edge
        > MSB is shifted out first ( MSB FIRST ), though it is useless and always 0
        > ENABLE input is an ACTIVE LOW SIGNAL
    
    Behavioral modelling has been used for this design
*/

module SPI_MODULE(
    input mosi,
    output miso,
    input clk,
    input en,
    output enOut,
    input rw,
    input rst,
    inout [7:0]dataBus
);

/* DELAYED OUTPUT ENABLE SIGNAL --*/

wire enOut;
buff B0(enOut, en);

/*------------------------*/


/* SPI Operation ---------*/

reg temp;
reg [7:0] regVal;
/*
Data sampled from serial input line when :
> NEGATIVE EDGE OF CLOCK
> ENABLE ASSERTED (LOW)
> RESET NOT ASSERTED
*/
always @ ( negedge clk )
begin
    if ( en == 1'b0 && rst == 1'b1 )
    begin
        temp <= mosi;
    end
end

/*
Data shifted out when :
> POSITIVE EDGE OF CLOCK
> ENABLE ASSERTED (LOW)
> RESET NOT ASSERTED
*/
always @ ( posedge clk )
begin
    if ( en == 1'b0 && rst == 1'b1 )
    begin
        miso <= 1'b0;
        regVal <= {regVal[6:0], temp};
    end
end

/*
RESET ASSERTED
*/
always @ ( negedge rst )
begin
    regVal <= 8'b00000000;
    temp <= 1'b0;
end

/*-----------------------*/


/* BUS operation --------*/

wire [7:0] dataIn;

/*
READ DATA from the internal data bus when :
> R/W is LOW i.e. one of the internal register will put its data on the data bus
> NEGATIVE EDGE OF ENABLE SIGNAL
*/
always @ ( negedge en )
begin
    if( rw == 1'b0 && rst == 1'b1 )
    begin
        regVal <= dataIn;
    end
end

/*-----------------------*/


/* BUS CONNECTION -------*/

tranif1 T0( regVal, dataBus, rw );
tranif1 T1( dataBus, dataIn, !rw );

/*-----------------------*/


endmodule