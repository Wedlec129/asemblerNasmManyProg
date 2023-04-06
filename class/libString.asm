section .data      				;используем статические перем. на этапе комп
str1 db 'hello',0
str2 db 'world',0xd,0xa,0

simvol db '0123456789abcdef'


section .bss  ;используем переменые типо динамические
str3 resb 100
str4 resb 16


section .text
global _start


; создаём метку   lol: метка глобальная | .lol: метка глобальная
;rsi -adr string
;rax - len str
strlen:
		mov rax,0 ;регистр rax=0
.next: cmp byte [rsi+rax],0 ;сравниваем rsi+rax ==0
		je .exit			;jamp eqwel| если рано то выходим	
		inc rax 			;incriment увеличиваем rax
		jmp .next	 		;переходтм обратно

.exit:
		ret	;перехватываем управление и возврашаемся в место откуда вызвали самую главную метку




;копирует в str1 str2
strcpy:
		push rsi 		;кидаем в стек
		push rdi
.next:	mov al,[rsi]
		mov [rdi],al
		cmp al,0
		je .exit
		inc rsi
		inc rdi
		jmp .next

.exit:
		pop rdi			;удаляем из стека
		pop rsi
		ret



;добавляет в st1 str2 
strcat:
		push rsi
		push rdi	
.next: 	cmp byte [rdi],0
		je .exit
		inc rdi
		jmp .next
	
.exit:
		mov al,[rsi]
		mov [rdi],al
		cmp al,0
		je .exit1
		inc rsi
		inc rdi
		jmp .exit

.exit1: pop rdi
		pop rsi
		ret
	

;
strchl: push rsi
.next:	cmp [rsi],bl
		je .exit1
		cmp byte [rsi],0
		je .exit2
		inc rsi
		jmp .next
	
.exit1:
		mov rax,rsi
		pop rsi
		sub rax, rsi
		ret

.exit2:
		pop rsi
		mov rax, -1
		ret



;вывод в х16 системе
htop:
		mov rbx,simvol
		mov rdx, 16
		mov cl,60
.next:	push rax
		shr rax,cl
		and rax, 0fh
		xlatb
		mov [rsi],al
		pop rax
		inc rsi
		sub cl,4
		dec rdx
		jnz .next
		ret





_start:

	mov rsi, str1
	mov rdi, str3
	call strcpy
		


	mov rsi,str3
	call strlen
	mov edx, eax



	mov eax,4
	mov ebx,1
	mov ecx, str3
	int 0x80

	mov rsi, str2
	mov rdi, str3
	call strcat
		


	mov rsi,str3
	call strlen
	mov edx, eax



	mov eax,4
	mov ebx,1
	mov ecx, str3
	int 0x80



	mov rsi, str3
	mov bl, 'w'
	call strchl	
	
	mov rsi, str4
	call htop

	mov eax, 4
	mov ebx, 1
	mov ecx, str4
	mov edx, 16
	int 0x80
	


	mov eax, 1
	mov ebx, 0
	int 0x80
