
; ***********************************************************************
; *  File : lab8.asm
; *  Author : Matt Clinard
; *  Description: This program computes miles per gallon.
; *  Register use:
; *     eax: holds miles, and the dividend that will be mpg or miles per gallon
; *     ebx: holds the value for gallons and subsequently divided. Also used to 
; *          hold a value used to divide the number of gallons to see if rounding
; *          will occur.
; ***********************************************************************

        .386
        .MODEL FLAT
        ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD
        PUBLIC _start  ; make procedure _start public
; ***********************************************************************
; *                     Data Segment                                 
; ***********************************************************************
	.DATA
	miles DWORD ? ; miles = ? 
	gallons DWORD ? ; gallons = ?
	mpg DWORD ? ; milesPerGallon = ?
	num1 DWORD ? ; num1 = ? variable to hold remainder for comparison

; ***********************************************************************
; *                     Stack Segment                                 
; ***********************************************************************
	.STACK  4096
; ***********************************************************************
; *                     Code Segment                                  
; ***********************************************************************
	.CODE
_start PROC NEAR32      ; start procedure called _start. Use flat, 32-bit address memory model
		
		mov edx, 0 ; clears edx register
		mov eax, miles    ; moves miles to register eax
		mov ebx, gallons  ; moves gallons to register ebx
		idiv ebx          ; eax = eax/ebx
		mov mpg, eax      ; mpg = eax
		mov num1, edx     ; num1 = edx
		cmp num1, 0       ; compares num1 value to 0
		je toexit ; if num1 == 0 jump toexit 
		
		mov edx, 0 ; clears edx register
		mov eax, gallons  ; moves gallons to register ebx
		mov ebx, 2 ; sets ebx register to 2
		idiv ebx ; eax = eax/ebx
		cmp num1, eax ; compares eax and num1
		jge gequal ; if eax >= num1 jump to gequal
		
gequal:	inc mpg
toexit:


        EVEN            ; Make rest of code aligned on an even-addressed byte
exit:   INVOKE  ExitProcess, 0  ; like return( 0 ) in C
_start  ENDP            ; end procedure _start
        END
