GLOBAL _my_strlen
    EXPORT _my_strlen

section .text

_my_strlen:
	push esi
	
	xor eax, eax
	mov esi, [ESP+0x08]
	
.check:	
	cmp byte [esi], 0x00
	je .end
	inc eax
	inc esi
	jmp .check	
	
.end:	
	pop esi
	
	ret