; APROXIMARE TANH(x) CU FRACTII LAMBERT

; MOVSD = MOVE SCALAR DOUBLE PRECISION
; MULSD = MULTIPLY SCALAR DOUBLE PRECISION
; ADDSD = ADD SCALAR DOUBLE PRECISION
; DIVSD = DIVIDE SCALAR DOUBLE PRECISION
; XMM = REGISTRII PENTRU OPERATII CU DATE MATEMATICE
extern printf

section .data

;fixam x
x dq 1.3

;declaram constantele
F378 dq 378.0
F17325 dq 17325.0
F135135 dq 135135.0
F28 dq 28.0
F3150 dq 3150.0
F62370 dq 62370.0

fmt db "tanh(x) = %f", 10, 0 ; format de afisare pentru x
mesaj db "x = %f", 10, 0 ; format de afisare pentru tanh(x)

section .bss
section .text
global main
main:

;initializare stack
push rbp
mov rbp, rsp

; afisam x
movsd xmm0, [x] ; primul argument pentru printf
mov rdi, mesaj ; formatul de afisare
mov rax, 1 ; nr de argumente pentru printf
call printf


movsd xmm2, [x] ;
movsd xmm0, xmm2 ; xmm0 = x
mulsd xmm2, xmm2 ; xmm2 = x^2

; xmm3 = (((X^2 + 378) * X^2 + 17325) * X^2 + 135135) * X
movsd xmm3, xmm2
addsd xmm3, [F378]
mulsd xmm3, xmm2
addsd xmm3, [F17325]
mulsd xmm3, xmm2
addsd xmm3, [F135135]
mulsd xmm3, xmm0

; xmm4 = ((28 * X^2 + 3150) * X^2 + 62370) * X^2 + 135135
movsd xmm4, [F28]
mulsd xmm4, xmm2
addsd xmm4, [F3150]
mulsd xmm4, xmm2
addsd xmm4, [F62370]
mulsd xmm4, xmm2
addsd xmm4, [F135135]

; xmm3 = xmm3 / xmm4
divsd xmm3, xmm4

; afisam rezultatul
movsd xmm0, xmm3
mov rdi, fmt
mov rax, 1
call printf

;return
mov rsp, rbp
pop rbp
