[BITS 16]
[ORG 0x7C00]

start:
	mov si, board
	mov ah, 0x0e
	cli 
	cld

printBoard:
	lodsb
	or al, al
	jz game
	int 0x10
	jmp printBoard

game:
	mov si, board
	mov ah, 0h
	int 16h
	mov ah, 0eh

	mov ah, [player]
	
	cmp al, 49 ;if char is less than '1', try again
	jl game

	cmp al, 57 ;if char is greater than '9', try again
	jg game

	sub al, 49
	movzx bx, al
	mov bl, byte[values + bx]
	test bl, bl
	jnz game

checkValues:
	movzx bx, al
	add al, 49
	mov cl, [player]
	mov byte [values + bx], cl
	
changeTable:
     cmp al, 49
     je changeOne
     
     cmp al, 50
     je changeTwo
       
     cmp al, 51
     je changeThree
     
     cmp al, 52
     je changeFour
     
     cmp al, 53
     je changeFive
     
     cmp al, 54
     je changeSix                                                                                                                                                             
     cmp al, 55
     je changeSeven

     cmp al, 56
     je changeEight
     
     cmp al, 57
     je changeNine

changeOne:
     mov byte [one], ah
     jmp checkWin

changeTwo:
     mov byte [two], ah
     jmp checkWin

changeThree:
     mov byte [three], ah
     jmp checkWin

changeFour:
     mov byte [four], ah
     jmp checkWin

changeFive:
     mov byte [five], ah
     jmp checkWin

changeSix:
     mov byte [six], ah
     jmp checkWin                                                                                                                                               
changeSeven:
     mov byte [seven], ah
     jmp checkWin

changeEight:
     mov byte [eight], ah
     jmp checkWin

changeNine:
     mov byte [nine], ah
     jmp checkWin

checkWin:
     mov    al, [one]
     mov    ah, [two]
     cmp    al, ah
     jz first_row
     
     mov al, [four]
     mov ah, [five] 
     cmp ah, al
     je second_row
     
     mov al, [seven]
     mov ah, [eight]
     cmp al, ah
     je third_row
     
     mov al, [one]
     mov ah, [five]
     cmp al, ah
     je fourth_row
     
     mov al, [two]
     mov ah, [five]
     cmp al, ah
     je fifth_row
     
     mov al, [three]
     mov ah, [six]
     cmp al, ah
     je sixth_row
     
     mov al, [three]
     mov ah, [five]
     cmp al, ah
     je seventh_row
     
     mov al, [one]
     mov ah, [four]
     cmp ah, al
     je eight_row 
     jmp actuallBoard

first_row:
     mov ah, [three]
     cmp al, ah
     jz win

     jmp actuallBoard

second_row:
     
     mov ah, [six]
     cmp al, ah
     jz  win
     
     jmp actuallBoard

third_row:
     mov ah, [nine]
     cmp al, ah
     jz win
     
     jmp actuallBoard

fourth_row:
     mov ah, [nine]
     cmp al, ah
     jz win
     
     jmp actuallBoard

fifth_row:
     mov ah, [eight]
     cmp al, ah
     jz win

     jmp actuallBoard

sixth_row:
     mov ah, [nine]
     cmp al, ah
     jz win

     jmp actuallBoard

seventh_row:
     mov ah, [seven]
     cmp al, ah
     jz win

     jmp actuallBoard

eight_row:
     mov ah, [seven]
     cmp ah, al
     jz win

     jmp actuallBoard

actuallBoard:
     mov ah, [player] 
     cmp ah, 'X'
     je  changePlayerO
     
     cmp ah, 'O'
     je changePlayerX

changePlayerO:
     mov byte[player], 'O'
     jmp ok

changePlayerX:
     mov byte[player], 'X'

ok:
     mov ah, 0x00
     mov al, 0x03
     int 0x10
     
     mov si, board
     mov ah, 0x0e
     jmp printBoard

win:    
    cmp ah, ' '
    jz actuallBoard
 
    mov si, board
    jmp printBoard2

winClear:
     hlt

printText:
    lodsb
    or  al, al
    jz winClear

    mov ah, 0x0e
    mov bh, 0
    int 0x10
    jmp printText

setText:
    mov si, text
    jmp printText

printBoard2:
    lodsb
    or al, al
    jz setText

    mov ah, 0x0e
    mov bh, 0
    int 0x10
    jmp printBoard2

board: db 0x0D, 0x0A, 0x0D, 0x0A

one: db ' '

fence1: db " | "

two: db ' '

fence2: db " | "

three: db ' '

newline1: db 0x0D, 0x0A

four: db ' '

fence3: db " | "

five: db ' '

fence4: db " | "

six: db ' '

newline2: db 0x0D, 0x0A

seven: db ' '

fence5: db " | "

eight: db ' '

fence6: db " | "

nine: db ' ', 0

fence: db " | "

player: db 'X', 0

text: db 0x0A, "Victory", 0x0D, 0x0A, 0

values: db 0,0,0,0,0,0,0,0,0 ;Array of choices

times 510 - ($-$$) db 0
dw 0xaa55

