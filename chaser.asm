#include "p16F628a.inc"    
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF    
  
RES_VECT  CODE    0x0000            
    GOTO    START                  

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
    MOVLW b'00000000'
    MOVWF PORTB
    BSF STATUS, 0
INICIO:
    CALL Desplazamiento_Derecha
    NOP
    NOP

    CALL Desplazamiento_Izquierda
    GOTO INICIO
    
Desplazamiento_Derecha:
    RRF PORTB,F
    CALL tiempo
    BTFSS STATUS, C
    GOTO Desplazamiento_Derecha
    NOP
    NOP
    NOP
    NOP
    NOP
    return
    
Desplazamiento_Izquierda:
    RLF PORTB,F
    CALL tiempo
    BTFSS STATUS, C
    GOTO Desplazamiento_Izquierda
    NOP
    NOP
    NOP
    NOP
    NOP
    return
    
    
    
tiempo: 
  nop
  movlw d'113' 
  movwf m
mloop:
  decfsz m,f
  goto mloop
  movlw d'65' 
  movwf i
iloop:
  movlw d'20' 
  movwf j
jloop:
  nop
  movlw d'20' 
  movwf k
kloop:
  nop
  decfsz k,f
  goto kloop
  decfsz j,f
  goto jloop
  decfsz i,f
  goto iloop
  return
  
    END