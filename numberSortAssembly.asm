; ***********************************************************************
; *  File : lab10.asm
; *  Author : Matt Clinard
; *  Description: This program sorts an array of numbers from least to greatest.
; *  Register use: eax - holds the address of the array for reference purposes.
; *                ebx - holds a value to be sorted
; *                ecx - holds a value to be sorted
; *                esi - holds the value of n
; *                edi - holds the value of n-1
; *                edx - holds the address of the array[n] to be actively altered
;      
; ***********************************************************************
       .386
       .MODEL FLAT
       ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD
       PUBLIC _start   ; make procedure _start public
; ***********************************************************************
; *                     Data Segment                                 
; ***********************************************************************
	.DATA
	n DWORD ? ; n = number of elements filled
	myArray DWORD 10 DUP (0) ; creates an array of 10 DWORDS initialized to 0

; ***********************************************************************
; *                     Stack Segment                                 
; ***********************************************************************
	.STACK  4096
; ***********************************************************************
; *                     Code Segment                                  
; ***********************************************************************
	.CODE
; ***********************************************************************
; * swap: swaps values
; * Parameters: ebx > ecx && edi != 0
; * Register usage: ebx - holds a value to be swapped
; *                 ecx - holds a value in the array to be swapped
; *                 edx - values are swapped inside of edx register
; ***********************************************************************
swap PROC NEAR32
		push ebp ; pushes base pointer
		mov ebp, esp ; moves the value of the base to stack pointer
		mov [edx-4], ecx ; ecx = myArray[whatever - 4]
		mov [edx], ebx	; ebx = myArray[whatever]
		pop ebp ; pops base pointer 
		ret
swap ENDP
; ***********************************************************************
; * sort: Compares values and calls swap function if ebx > ecx
; * Parameters: none
; * Register usage: eax - holds the address of the array for reference purposes.
; *                ebx - holds a value to be sorted
; *                ecx - holds a value to be sorted
; *                esi - holds the value of n
; *                edi - holds the value of n-1
; *                edx - holds the address of the array[n] to be actively altered
; ***********************************************************************
sort PROC NEAR32
		push ebp ; pushes base pointer
		mov ebp, esp ; moves the value of the base to stack pointer
		mov eax, [ebp+12] ; eax = &myArray[0] for reference purposes
		mov edx, [ebp+12] ; edx = &myArray[0] to be used actively
		mov ebx, [eax] ; ebx = [eax]
		mov ecx, [eax + 4] ; ecx = [eax+4]
		add edx, 4 ; edx = edx + 4
		mov esi, n ; esi = n
		dec n ; decrements n 
		mov edi, n ; edi = n - 1
loopA:	cmp edi, 0 ; compares edi and 0 
		je bottom ; if edi == 0 jumps to bottom label
		cmp ebx, ecx ; compares ebx to ecx
		jle Nothin ; if ebx is less than or equal to ecx jump to Nothin -->
		push ebx ; pushes ebx to swap function
		push ecx ; pushes ecx to swap function 
		push edx ; pushes edx to swap function
		call swap ; --> otherwise call swap
		add esp, 12 ; removes ebx, ecx, and edx from swap/stack
Nothin: mov ebx, [edx] ; ebx = myArray[whatever]
		add edx, 4     ; edx = edx + 4
		mov ecx, [edx] ; ecx = myArray[whatever]
		dec edi ; decrements edi register
		jmp loopA ; jumps to loopA
bottom: mov edx, [ebp+12] ; edx = &myArray[0]
		mov edi, n ; edi = n - 1
		mov ebx, 0 ; ebx = 0
		mov ecx, 0 ; ecx = 0
		dec esi ; decrement esi register
		cmp esi, 0 ; compare esi register to 0
		je ex ; jumps to exit if esi == 0
		jmp loopA ; jumps to loopA if esi != 0
ex:		pop ebp ; pops base pointer 
		ret
sort ENDP

_start  PROC    NEAR32    ; start procedure called _start. Use flat, 32-bit address memory model
	lea eax, myArray ; loads the address of myArray into eax
	push eax ; push eax onto the stack
	push n ; push n onto the stack
	call sort ; calls sort function
	add esp, 4 ; removes eax from sort function/stack
        EVEN           ; Make rest of code aligned on an even-addressed byte
exit:   INVOKE  ExitProcess, 0  ; like return( 0 ) in C
_start  ENDP                    ; end procedure _start
        END
