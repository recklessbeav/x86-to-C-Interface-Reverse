; Beaverly Cuasi S15
global _main
extern _printf, _scanf, _gets, _system

section .data
msg1 db "Invalid Input", 13,10,0
msg2 db "Invalid Terminator, please try again", 13,10, 0
msg3 db "Max input", 13,10,0

prompt1 db "Enter string: ", 0
prompt2 db "Palindrome: %s", 13,10,0
prompt3 db "Word: %d", 13,10,0
prompt4 db "Character: %d", 13,10,0
prompt5 db "Do you want to try again (y/n)?", 13,10,0


clr db "cls", 0
string times 21 db 0
period times 21 db 0
reverse times 21 db 0
answer db 0


section .text

_main:
;clear screen
    push clr
    call _system
    add esp, 4
    
   ; mov dword [string], 0
   ; mov dword [period], 0
   ; mov dword [reverse], 0
    
    reset_pal:
    lea esi, [string]
    lea edi, [reverse]
    mov cl, 0
    mov al, 0
    jmp reset_pal2
    
    reset_pal2:
    cmp cl, 21
    je reset_per
    mov [esi], al
    mov [edi], al
    inc esi
    inc edi
    inc cl
    jmp reset_pal2
    
    reset_per:
    lea esi, [period]
    jmp reset_per2
    
    reset_per2:
    cmp cl, 0
    je here
    mov [esi], al
    inc esi
    dec cl
    jmp reset_per2

;printf ("Enter a string: \n")
here:
    push prompt1
    call _printf
    add esp, 4
    
    
;gets(string)
    push string
    call _gets
    add esp, 4
    
    lea eax, [string]
    lea ecx, [reverse]
    lea ebp, [period]
   
    mov esi, 0
    mov edi, 1 
    mov ebx, 0
    mov edx, -1
    
    cmp byte [eax], 0
    je INVALID
    
    LOOP1:
        cmp byte [eax], 0x21 ; exclamation point
        je LOOP2
        cmp byte [eax], 0 ; null
        je INVALIDTERM
        cmp byte [eax + 1], 0x2E ; period
        je REMAIN
        cmp byte [eax], 0x20 ; space
        je WORDCOUNT
        inc esi ; character
        cmp esi, 21
        jge MAXINPUT
        mov dx, [eax]
        mov [ebp], dx
        inc eax
        inc ebx
        inc ebp
        jmp LOOP1
    
    WORDCOUNT:
        ;jump here when there is a space
        inc edi
        inc esi
        inc eax
        inc ebx
        inc ebp
        jmp LOOP1
        
    REMAIN:
        ;print same string without terminator
        inc esi
        push period 
        push prompt2
        call _printf
        add esp, 8
        jmp WORDPRINT
        
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
        ;invalid null
        push msg1
        call _printf
        add esp, 4
        jmp TRY
        
    INVALIDTERM:
        ;invalid terminator
        push msg2
        call _printf
        add esp, 4
        jmp TRY
        
    MAXINPUT:
        ;string greater than 20
        push msg3
        call _printf
        add esp, 4
        jmp TRY
        
    LOOP5:
        ;print palindrome 
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
    
    WORDPRINT:
        ;print wordcount
        push edi
        push prompt3
        call _printf
        add esp, 8
    
    CHRTR:
        ;print character count
        push esi
        push prompt4
        call _printf
        add esp, 8
    
    TRY:
       ;ask to try again
       push prompt5
       call _printf
       add esp, 4
    
       ;gets(answer)
       push answer
       call _gets
       add esp, 4
       
       lea eax, [answer]
       
       cmp byte [eax], "y"
       JE _main
       cmp byte [eax], "Y"
       JE _main
       cmp byte [eax], "n"
       JE END
       cmp byte [eax], "N"
       JE END
       cmp byte [eax], 0
       JE TRY
    
  
    END:
    xor eax, eax
    ret
