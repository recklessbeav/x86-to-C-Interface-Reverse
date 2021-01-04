; Beaverly Cuasi S15
global _main
extern _printf, _scanf, _getchar, _gets, _system

section .data
msg1 db "Invalid Input", 13,10,0
msg2 db "Invalid Terminator, please try again", 13,10, 0

prompt1 db "Enter a string: ", 0
prompt2 db "Palindrome: %s", 13,10,0
prompt3 db "Word: %d", 13,10,0
prompt4 db "Character: %d", 13,10,0
prompt5 db "Do you want to try again (y/n)? %s", 13,10,0

string times 21 db 0
reverse times 21 db 0


section .text

_main:
    mov ebp, esp; for correct debugging

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
    mov esi, 0 
    mov ebx, 0
    mov edx, -1
    
    LOOP1:
        cmp byte [eax], 0x21
        je LOOP2
        cmp byte [eax], 0
        je INVALIDTERM
        cmp byte [eax], 0x2E
        je REMAIN
        ;cmp byte [eax], 0x20
        inc esi
        inc eax
        inc ebx
        jmp LOOP1
        
    REMAIN:
        ;printf ("Palindrome: same string \n")
        push string 
        push prompt2
        call _printf
        add esp, 8
        jmp CHRTR
        
    LOOP2:
        cmp ebx, 0
        je INVALID
        
    LREVERSE:
        ;reverse
        mov dl, [string + ebx -1]
        mov [ecx], dl
        inc ecx
        dec ebx
        jnz LREVERSE
        jmp LOOP5
        
    INVALID:
        ;invalid
        push msg1
        call _printf
        add esp, 4
        JMP END
        
    INVALIDTERM:
        ;invalid terminator
        push msg2
        call _printf
        add esp, 4
        JMP _main
        
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
    
    CHRTR:
        ;character count
        push esi
        push prompt4
        call _printf
        add esp, 8
        
    
    
  
    END:
    xor eax, eax
    ret
