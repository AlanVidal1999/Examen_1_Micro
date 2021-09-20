#include "p16F628a.inc" 
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
    
RES_VECT CODE 0x0000 
    GOTO START 
    
MAIN_PROG CODE
i equ 0x30
j equ 0x31
k equ 0x32
m equ 0x33

START
    MOVLW 0x07 
    MOVWF CMCON
    BCF STATUS, RP1
    BSF STATUS, RP0
    MOVLW b'00000000' 
    MOVWF TRISB
    BCF STATUS, RP0 
    NOP

inicio:
    bcf PORTB,0 
    call tiempo_bajo 
    nop 
    nop
    bsf PORTB,0 
    call tiempo_alto 
    goto inicio 

tiempo_bajo: ; Calibrador para 3 microsegundos 
    nop
    nop		; NOTA: PARA 1 SEG QUITAR ESTE NOP, para 0.191099 seg esta bien
    movlw d'143' 
    movwf m
    
mloop_bajo:
    decfsz m,f
    goto mloop_bajo
    movlw d'40' 
    movwf i
    
iloop_bajo:
    nop 
    movlw d'51' 
    movwf j
    
jloop_bajo:
    nop 
    movlw d'118' 
    movwf k
kloop_bajo:
    decfsz k,f
    goto kloop_bajo
    decfsz j,f
    goto jloop_bajo
    decfsz i,f
    goto iloop_bajo
    return 

tiempo_alto: ; Calibrador para 3 microsegundos 
		; NOTA: PARA 1 SEG QUITAR ESTE NOP, para 0.191099 seg esta bien
    movlw d'207' 
    movwf m
    
mloop_alto:
    decfsz m,f
    goto mloop_alto
    movlw d'195' 
    movwf i
    
iloop_alto:
    nop 
    nop
    movlw d'20' 
    movwf j
    
jloop_alto:
    nop 
    movlw d'21' 
    movwf k
kloop_alto:
    decfsz k,f
    goto kloop_alto
    decfsz j,f
    goto jloop_alto
    decfsz i,f
    goto iloop_alto
    return 
    
    END
    ; 1seg: m 180 / i 90 / j 60 / k 60
    ; 0.191099 seg: m 196 + NOP / i 100 / j 20 / k 30