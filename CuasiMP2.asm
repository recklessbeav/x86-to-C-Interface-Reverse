; template file for C-assembly
global _main
extern _printf, _scanf, _getchar, _gets, _system

section .data
message db "Hello World",13,10,0
message1 db "Hello again",13,10,0
subprint db "Subroutine!",13,10,0
CLR db "cls",0
prompt1 db "Please enter an integer = ",0
prompt2 db "The number you entered is %d",13,10,0
prompt3 db "Please enter your name: ",0
prompt4 db "The name you entered is %s",13,10,0
prompt5 db "Please enter a floating number = ",0
prompt6 db "The fp number you entered is %g",13,10,0
prompt7 db "Register value of EAX is %#x ",13,10,0

section .text

_main:
