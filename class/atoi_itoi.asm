section .data ;статические данные

i2at db '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'

section .bss ;динамические данные
	string resb 65



section .text
global _start

itoa:
	mov rbx, i2at
	mov r8, rdx
	add rsi,64
	mov rdi, rsi
ml:
	mov rdx, 0
	div r8
	xchg rdx, rax
	xlatb
	mov [rsi],al
	xchg rdx, rax
	cmp rax, 0
	je m2
	dec esi
	jmp ml
m2:
	mov rax, rdi
	sub rax, rsi
	inc rax
	ret

atoi:
	xor rax, rax
	xor rbx, rbx

.next:
	mov bl, [rsi]
	sub bl,'0'
	cmp bl, 9
	ja .end
	imul rax, rax, 10
	add rax, rbx
	inc rsi
	jmp .next
.end:
	ret

_start:
	mov rax,0
	mov rdi,0
	mov rsi, string
	mov rdx,65
	syscall
	call atoi

	;mov rax,671
	mov rsi, string
	mov rdx, 16
	call itoa
	mov rax,1
	mov rdi,1
	mov rdx, rax
	syscall

	mov eax, 1
	mov ebx,0
	int 0x80