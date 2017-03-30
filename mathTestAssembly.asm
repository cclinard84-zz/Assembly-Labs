; ***********************************************************************
; *  File : lab2.asm
; *  Author : Matt Clinard
; *  Description: This program computes -102x^4 + 11x^2 * 6 + 55.
; *  Register use:
; *     eax: nolds the value of x, then x^2, 
; *     ebx: holds the value of x^2, then x^2 * num1, negated, then added to num2.
; ***********************************************************************

        .386
        .MODEL FLAT
        ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD
        PUBLIC _start  ; make procedure _start public
; ***********************************************************************
; *                     Data Segment                                 
; ***********************************************************************
	.DATA
	x DWORD ?          ; x = ? 
	num1 DWORD 102     ; num1 = 102
	num2 DWORD 66      ; num2 = 11 * 6 = 66
	num3 DWORD 55	   ; num3 = 55

; ***********************************************************************
; *                     Stack Segment                                 
; ***********************************************************************
	.STACK  4096
; ***********************************************************************
; *                     Code Segment                                  
; ***********************************************************************
	.CODE
_start PROC NEAR32      ; start procedure called _start. Use flat, 32-bit address memory model
		
		mov eax, x      ; moves x to register eax
		imul eax, x     ; eax = eax*x
		mov ebx, eax    ; ebx = eax
		imul ebx, num1	; ebx = ebx * num1
		neg ebx         ; ebx = -ebx
		add ebx, num2	; ebx = ebx + num2
		imul eax, ebx	; eax = eax*ebx
		add eax, num3	; eax = eax + num3

        EVEN            ; Make rest of code aligned on an even-addressed byte
exit:   INVOKE  ExitProcess, 0  ; like return( 0 ) in C
_start  ENDP            ; end procedure _start
        END
