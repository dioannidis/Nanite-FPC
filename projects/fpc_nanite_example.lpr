// The Nanite 85
//
// Ported from https://cpldcpu.wordpress.com/2014/04/25/the-nanite-85/
//
// Github  : https://github.com/cpldcpu/Nanite
//
// I made one using the through hole version from Danjovic (https://github.com/Danjovic/Nanite)
// on a veroboard for fun ... ;)
//
// ATTiny85 fuses with disable reset ....
//
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//
// WARNING WARNING WARNING WARNING WARNING
//
// FUSEOPT_DISABLERESET = -U lfuse:w:0xe1:m -U efuse:w:0xfe:m -U hfuse:w:0x5d:m
//
// You'll need a High Voltage programmer to restore the chip !
//
// WARNING WARNING WARNING WARNING WARNING
//
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//
// PS: Worked like a charm ...

program fpc_nanite_example;

{$MODE OBJFPC}
{$MACRO ON}
{$INLINE ON}
{$LONGSTRINGS OFF}
{$WRITEABLECONST OFF}

uses
  fpc_nanitelib;

//Delay 4 000 000 cycles
//500ms at 8.0 MHz
procedure _delay_ms_500; assembler; nostackframe;
Label
  L1;
asm
    ldi  r18, 21
    ldi  r19, 75
    ldi  r20, 191
  L1:
    dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
    nop
end;

var
  bLed: boolean = True;
begin
  nanite_init;
  repeat
    nanite_poll(bLed);
    _delay_ms_500;
    bLed := not bLed;
    //TODO:: Please write your application code
  until False;
end.

