GLOBAL _my_strlen
    EXPORT _my_strlen
GLOBAL _my_memset
    EXPORT _my_memset
GLOBAL _my_memcpy
    EXPORT _my_memcpy
GLOBAL _my_memchr
    EXPORT _my_memchr

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
    cmp dword [esp+0x0C], 0x00   ;Immediately return if no bytes are to be copied
    je .premature_end
    
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

    ret

.premature_end:
    mov eax, dword [esp+0x04]
    ret
    
_my_memcpy:
    cmp dword [esp+0x0C], 0x00   ;Immediately return if no bytes are to be copied
    je .premature_end
    
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
    
    ret
    
.premature_end:
    mov eax, dword [esp+0x04]
    ret
    
_my_memchr:
    cmp dword [esp+0x0C], 0x00   ;Immediately return if no bytes are to be examined
    je .no_match_found
    
    mov eax, dword [esp+0x04]    ;String to search
    mov ecx, dword [esp+0x08]    ;Byte to search for
    mov edx, dword [esp+0x0C]    ;Number of bytes to examine

.examine_byte: 
    cmp byte [eax], cl
    je .end
    inc eax
    dec edx
    jnz .examine_byte
 
.no_match_found:
    mov eax, 0x00

.end:
    ret
    

;0x04 = search string
;0x08 = element to find
;0x0C = bytes to analyze