[BITS 16]
[ORG 0x7C00]

start:
     mov si, board
     mov ah, 0x0e ;call for write character     
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
     cmp ah, 'X'
     je  changePlayerO
     
     cmp ah, 'O'
     je changePlayerX

changePlayerO:
     mov byte[player], 'O'
     jmp changeTable

changePlayerX:
     mov byte[player], 'X'
     jmp changeTable

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

     jmp printBoard

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
     mov si, board
     mov ah, 0x0e
     jmp printBoard

win:
    
    cmp ah, ' '
    jz actuallBoard
 
    mov si, board
    jmp printBoard2

winClear:
     
     mov byte[one], ' '
     mov byte[two], ' '
     mov byte[three], ' '
     mov byte[four], ' '
     mov byte[five], ' '
     mov byte[six], ' '
     mov byte[seven], ' '
     mov byte[eight], ' '
     mov byte[nine], ' '

     jmp actuallBoard

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

one:   db ' '

plot1: db " | "

two:   db ' '

plot2: db " | "

three: db ' '
nowalinia1:  db 0x0D, 0x0A

four:  db ' '

plot3: db " | "

five:  db ' '

plot4: db " | "

six:   db ' '
nowalinia2: db 0x0D, 0x0A

seven: db ' '

plot5: db " | "

eight: db ' '

plot6: db " | "

nine: db ' ' , 0

plot: db " | "

player: db 88, 0

text: db " You won game broooo!!!!", 0x0D, 0x0A

times 510 - ($-$$) db 0
dw 0xaa55
