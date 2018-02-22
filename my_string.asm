GLOBAL _my_strlen
    EXPORT _my_strlen
GLOBAL _my_memset
    EXPORT _my_memset

section .text

_my_strlen:
	push esi
	
	xor eax, eax
	mov esi, [esp+0x08]
	
.check:	
	cmp byte [esi], 0x00
	je .end
	inc eax
	inc esi
	jmp .check	
	
.end:	
	pop esi
	
	ret
	
_my_memset:
	mov eax, dword [esp+0x04]    ;Start of pointer to write elements to
	mov ecx, dword [esp+0x08]    ;Element to be written
	mov edx, dword [esp+0x0C]    ;Number of elements to be written
	
	push eax                     ;Create copy of pointer to start of string
	
.write_element:
	cmp edx, 0x00
	je .end
	mov byte [eax], cl
	dec edx
	inc eax
	jmp .write_element
	
.end:
	pop eax;                     ;Retrieve pointer to start of string

	ret