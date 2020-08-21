// The Nanite 85
//
// Ported from https://cpldcpu.wordpress.com/2014/04/25/the-nanite-85/
//
// Github  : https://github.com/cpldcpu/Nanite
unit fpc_nanitelib;

{$MODE OBJFPC}
{$MACRO ON}
{$INLINE ON}
{$LONGSTRINGS OFF}
{$WRITEABLECONST OFF}

{$DEFINE NANITE_PORT    := PORTB }
{$DEFINE NANITE_PIN     := 5     }
{$DEFINE NANITE_DDR     := DDRB  }
{$DEFINE NANITE_DDR_PIN := PINB  }

interface

procedure nanite_init;
procedure nanite_poll;
procedure nanite_poll(constref ALedOn: Boolean);

implementation

//Delay 82 cycles
//5us at 16.5 MHz
procedure _delay_us_5; assembler; nostackframe;
label
  L1;
asm
    LDI     r18, 27
  L1:
    DEC     r18
    BRNE    L1
    NOP
end;

procedure nanite_init;
begin
  NANITE_PORT := NANITE_PORT and not (1 shl NANITE_PIN);
  NANITE_DDR := NANITE_DDR and not (1 shl NANITE_PIN);
end;

procedure nanite_poll;
var
  nanite_tmp: byte;
begin
  nanite_tmp := NANITE_DDR;
  NANITE_DDR := NANITE_DDR and not (1 shl NANITE_PIN);
  _delay_us_5;
  if (NANITE_DDR_PIN and (1 shl NANITE_PIN) = 0) then
    WDTCR := WDTCR or (1 shl WDCE) or (1 shl WDE);
  NANITE_DDR := nanite_tmp;
end;

procedure nanite_poll(constref ALedOn: Boolean);
begin
  NANITE_DDR := NANITE_DDR and not (1 shl NANITE_PIN);
  _delay_us_5;
  if (NANITE_DDR_PIN and (1 shl NANITE_PIN) = 0) then
    WDTCR := WDTCR or (1 shl WDCE) or (1 shl WDE);
  if ALedOn then
    NANITE_DDR := NANITE_DDR or (1 shl NANITE_PIN);
end;

end.

