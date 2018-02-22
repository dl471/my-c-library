GLOBAL _my_strlen
    EXPORT _my_strlen
GLOBAL _my_memset
    EXPORT _my_memset
GLOBAL _my_memcpy
	EXPORT _my_memcpy

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
	mov byte [eax], cl
	inc eax
	dec edx
	jnz .write_element
	
	pop eax;                     ;Retrieve pointer to start of string

.end:
	ret
	
_my_memcpy:
	cmp dword [esp+0x0C], 0x00   ;Immediately return if no bytes are to be copied
	je .end
	
	push dword [esp+4]           ;Create copy of pointer to destination string
	push esi
	push edi
	
	mov edi, dword [esp+0x10]    ;Destination string
	mov esi, dword [esp+0x14]    ;Source string
	mov eax, dword [esp+0x18]    ;Number of elements to be copied
	
.write_element:
	mov cl, byte [esi]
	mov byte [edi], cl
	inc esi
	inc edi
	dec eax
	jnz .write_element

	pop edi
	pop esi
	pop eax                      ;Retrieve pointer to destination string
	
.end:
	ret