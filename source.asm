; 6809 Assembly for Tandy Color Computer
;

                ORG $3000

                JSR ScreenInit
                JSR DrawImage

                LDX #$E00
                LDA #$0
                JSR DrawDigit

                JSR WaitForX
                JSR RestoreScreen

                RTS




;
; Draw a digit from 0-9
;
;   A - digit to draw (0-9)
;   X - memory location to draw into
;
DrawDigit       LDY #Digit0
                LDB #$8
DigitLoop       LDA ,Y+
                STA ,X
                LEAX $20,X
                DECB
                BNE DigitLoop
                RTS


;
; Initialize graphics mode 6C
;
ScreenInit      LDA #$E8
                STA $FF22
                STA $FFC3
                STA $FFC5


;
; Move display memory to E00
;
                STA $FFD2
                STA $FFD0
                STA $FFCE
                STA $FFCC
                STA $FFCB
                STA $FFC9
                STA $FFC7

                RTS


;
; Copy bytes from IMGDATA to $0400
;
DrawImage       LDX #$E00
                LDY #IMGDATA
ImageLoop       LDD ,Y++
                STD ,X++
                CMPX #$2600
                BNE ImageLoop
                RTS


;
; Wait for X key
;
WaitForX        JSR $A1B1
                CMPA #$58
                BNE WaitForX
                RTS


;
; Restore screen to text mode
;
RestoreScreen   LDA #$00
                STA $FF22
                STA $FFC2
                STA $FFC4
                RTS




;
; Digits 0-9
;
Digit0          #%00111100
                #%01000010
                #%01000010
                #%01000010
                #%01000010
                #%00111100
                #%00000000
                #%00000000

                INCLUDE "imgdata.asm"
