; ***********************************************************************
; *  File : lab4.asm
; *  Author : Matt Clinard
; *  Description: This program calculates n!.
; *  Register use:  ecx - set to 0, n copied to ecx via addition,
; *                       compared to i, decremented and multiplied by ebx
; *                 ebx - set to n, compared to 0 twice, multiplied by ecx,
; *                       incremented if ebx == 0, made 0 if less than 0
; ***********************************************************************
        .386
        .MODEL FLAT
        ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD
        PUBLIC _start  ; make procedure _start public
; ***********************************************************************
; *                     Data Segment                                 
; ***********************************************************************
	.DATA
	n DWORD ?          ; n = ?
	i DWORD 1          ; i = 1
	answer DWORD ?     ; answer = ?
; ***********************************************************************
; *                     Stack Segment                                 
; ***********************************************************************
	.STACK  4096
; ***********************************************************************
; *                     Code Segment                                  
; ***********************************************************************
	.CODE
	
; ***********************************************************************
; * factorial: computes the factorial of a number
; * Parameters: n - the initial factorial number
; *             i - set to 1 for comparison of factorial
; * Register usage: ecx - set to 0, n copied to ecx via addition,
; *                       compared to i, decremented and multiplied by ebx
; *                 ebx - set to n, compared to 0 twice, multiplied by ecx,
; *                       incremented if ebx == 0, made 0 if less than 0
; ***********************************************************************
factorial PROC NEAR32
		push ebp ; pushes base pointer
		mov ebp, esp ; moves the value of the base to stack pointer
		mov ecx, 0 ; sets ecx to 0
		mov ebx, [ebp+8] ; ebx = n 
		add ecx, ebx ; copies ebx to ecx via addition
		cmp ebx, 0 ; compares ebx to 0
		je zero ; jumps to zero
		cmp ebx, 0 ; 
		jl ngtve ; jumps to ngtve if ebx < 0
faLoop: cmp ecx, i ; compares ecx to eax
		je ex ; if ecx == i jump to ex
		dec ecx ; decrements the ecx register
		imul ebx, ecx ; fac *= i
		jmp faLoop ; jumps to faLoop
zero:   inc ebx ; increments ebx if ebx == 0 to 1
		jmp ex ; jumps to exit
ngtve:  mov ebx, 0 ; makes the ebx register 0 if less than 0 initially 
        jmp ex ;jumps to exit
ex:	    pop ebp ; pops base pointer 
		ret
factorial ENDP

_start PROC NEAR32      ; start procedure called _start. Use flat, 32-bit address memory model
		push n ; pushes n to the stack
		call factorial  ; calls the factorial function
		add esp, 4      ; removes anything left in stack
		mov answer, ebx ; moves value in eax to the answer variable
		EVEN            ; Make rest of code aligned on an even-addressed byte
exit:   INVOKE  ExitProcess, 0  ; like return( 0 ) in C
_start  ENDP            ; end procedure _start
        END
		
		
  
