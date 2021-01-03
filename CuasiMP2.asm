; Beaverly Cuasi S15
global _main
extern _printf, _scanf, _getchar, _gets, _system

section .data
msg1 db "Invalid Input", 13,10,0
msg2 db "Hello again \n",0

prompt1 db "Enter a string: ", 0
prompt2 db "Palindrome: %s", 13,10,0
prompt3 db "Please enter an integer: ",0 
prompt4 db "Character: %s", 13,10,0

string times 21 db 0
reverse times 21 db 0
length times 21 db 0

scanlne db "%d", 0
intnum dd 0


section .text

_main:

;printf ("Enter a string: \n")
    push prompt1
    call _printf
    add esp, 4
    
;gets(string)
    push string
    call _gets
    add esp, 4
    
    lea eax, [string]
    lea ecx, [reverse]
    mov ebx, 0
    mov edx, -1
    
    LOOP1:
        cmp byte [eax], 0
        je LOOP2
        inc eax
        inc ebx
        jmp LOOP1
        
    LOOP2:
        cmp ebx, 0
        je LOOP4
        
    LOOP3:
        mov dl, [string + ebx -1]
        mov [ecx], dl
        inc ecx
        dec ebx
        jnz LOOP3
        jmp LOOP5
        
    LOOP4:
        push msg1
        call _printf
        add esp, 4
        JMP END
        
    LOOP5:
        ;printf ("Palindrome %s \n")
        push reverse 
        push prompt2
        call _printf
        add esp, 8
        jmp LOOP6
        
    LOOP6:
        inc edx
        mov bl, [reverse + edx]
        cmp bl, 0x0A
        je CHK
        cmp bl, 0
        jne LOOP6
        
    CHK:
        mov dword [reverse + edx], 0
    
    ;STR_MTY:
     ;   mov eax, reverse
      ;  mov ecx, -1
       ; cmp byte [eax], 0
        ;je LOOP4
        ;jmp VALID
        
    ;VALID:
     ;   inc ecx 
      ;  mov ebx, [eax + ecx]
       ; cmp ebx, 0
       ; jne VALID
        
       ; mov dword [length], ecx
       ; push length
       ; push prompt4
       ; call _printf
        ;add esp, 8
  
    END:
    xor eax, eax
    ret
