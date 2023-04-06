section .data
str1 db 'hello.txt',0
str_len equ $-str1
d_f dd 0

segment .bss
str2 resb 100

section .txt
global _start

_start:

    mov eax, 5
    mov ebx, str1
    mov ecx, 2
    int 0x80

    mov [d_f], eax
    mov eax, 3
    mov ebx, [d_f]
    mov edx, 100
    int 0x80
    
    mov edx, eax
    mov eax, 4
    mov ebx, 1
    mov ecx, str2
    int 0x80
    
    mov eax, 4
    mov ebx, [d_f]
    mov ecx, str1
    mov edx, str_len
    int 0x80 
    



    mov eax, 1
    mov ebx, 0
    int 0x80


