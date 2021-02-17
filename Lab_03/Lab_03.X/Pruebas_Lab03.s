
; Autor: Fredy Josue Godoy Lucero - 19260
; Laboratorio No. 03 - Programación de Microcontraladores


    
processor 16F887
#include <xc.inc>

; CONFIG1
  CONFIG  FOSC = INTRC_NOCLKOUT
  CONFIG  WDTE = OFF             ; Watchdog Timer Enable bit (WDT enabled)
  CONFIG  PWRTE = ON           ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  MCLRE = ON            ; RE3/MCLR pin function select bit (RE3/MCLR pin function is MCLR)
  CONFIG  CP = OFF              ; Code Protection bit (Program memory code protection is disabled)
  CONFIG  CPD = OFF             ; Data Code Protection bit (Data memory code protection is disabled)
  CONFIG  BOREN = ON            ; Brown Out Reset Selection bits (BOR enabled)
  CONFIG  IESO = ON             ; Internal External Switchover bit (Internal/External Switchover mode is enabled)
  CONFIG  FCMEN = ON            ; Fail-Safe Clock Monitor Enabled bit (Fail-Safe Clock Monitor is enabled)
  CONFIG  LVP = ON              ; Low Voltage Programming Enable bit (RB3/PGM pin has PGM function, low voltage programming enabled)

; CONFIG2
  CONFIG  BOR4V = BOR40V        ; Brown-out Reset Selection bit (Brown-out Reset set to 4.0V)
  CONFIG  WRT = OFF             ; Flash Program Memory Self Write Enable bits (Write protection off)

; Variables a usar

  
PSECT code, delta=2, abs

ORG 100h 

    
main:
    BANKSEL  OSCCON
    bcf      IRCF0
    bcf      IRCF1
    bsf      IRCF2
    
    
    BANKSEL  ANSEL
    clrf     ANSEL
    clrf     ANSELH
    
    BANKSEL TRISA
    bsf     TRISA,5      ; se define el pin 0 de PORTA como entrada 
    bsf     TRISA,4      ; se define el pin 1 de PORTA como entrada 
    bcf     TRISA,0
    bcf     TRISA,1
    bcf     TRISA,2
    bcf     TRISA,3
    bcf     TRISC,0      ; se definen los pines 0-3 de PORTC como salidas
    bcf     TRISC,1
    bcf     TRISC,2
    bcf     TRISC,3
    bcf     TRISD,0      ; se definen los pines 0-7 de PORTD como salidas
    bcf     TRISD,1
    bcf     TRISD,2
    bcf     TRISD,3
    bcf     TRISD,4
    bcf     TRISD,5
    bcf     TRISD,6
    bcf     TRISE,0      ; Se define el pin 0 de PORTE como salida
    
    
    
    movlw   00000111B
    movwf   OPTION_REG   ; Se selecciona un preescaler de 256
    
    banksel PORTA
    
    clrf    PORTA
    clrf    PORTC
    clrf    PORTD
    clrf    PORTB
    clrf    PORTE
    clrf    TMR0
    movlw   1010000B
    movwf   INTCON
    

;-------------------------------------------
;----------- Loop Principal ----------------
;movlw  1111B
;movwf  PORTB
loop:      
    BCF     PORTD,0
    call    Temporizador_65ms
    call    Temporizador_65ms
    call    Temporizador_65ms
    call    Temporizador_65ms
    call    Temporizador_65ms
    call    Temporizador_65ms
    call    Temporizador_65ms
    call    Temporizador_65ms
    BSF     PORTD,0
    GOTO    loop

Incremento:    
    BTFSS   PORTA,0
    GOTO    $-1
    INCF    PORTB,1
    movf    PORTB
    ;CALL    tabla
    movwf   PORTD
    RETURN
Temporizador_65ms:
    ;clrf   PORTD
    movlw  11000001B     ; 193
    movwf  TMR0
    BCF    INTCON,2
    BTFSS  INTCON,2
    GOTO   $-1
    RETURN


    ; 01110110B ; Cero
    ; 00000110B ;Uno
    ; 01011011B ;Dos
    ; 01001111B ;Tres
    ; 01100110B ;Cuatro
    ; 01101101B ;Cinco
    ; 01111101B ;Seis 
    ; 00000111B ;Siete
    ; 01111111B ;Ocho
    ; 01100111B ;Nueve
    ; 01110111B ;A
    ; 01111100B ;B
    ; 00111001B ;C
    ; 01011110B ;D
    ; 01111001B ;E
    ; 01110001B ;F
    
end


