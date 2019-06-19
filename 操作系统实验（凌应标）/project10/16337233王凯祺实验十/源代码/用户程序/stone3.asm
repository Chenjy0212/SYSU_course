; ����Դ���루stone.asm��
; ���������ı���ʽ��ʾ���ϴ�������һ��*��,��45���������˶���ײ���߿����,�������.
;  ��Ӧ�� 2014/3
;  ������ 2018/3
;  NASM����ʽ
	delay  equ 50000					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
	ddelay equ 580					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
	sx     equ 13
	sy     equ 0
	wx     equ 12
	wy     equ 39
	org 100h					; ������ص�100h������������COM
	
start:
	mov ax,cs
	mov ds,ax
	mov es,ax
	mov ss,ax
	mov ax,0B800h				; �ı������Դ���ʼ��ַ
	mov gs,ax					; GS = B800h

loop1:
	dec word[count]				; �ݼ���������
	jnz loop1					; >0����ת;
	mov word[count],delay
	dec word[dcount]				; �ݼ���������
	jnz loop1
	mov word[count],delay
	mov word[dcount],ddelay
	
	dec word[timess]
	jnz skip_end
	jmp end
	
skip_end:
	xor dx, dx
	mov word ax, [t]
	xor bx, bx
	mov word bx, wx
	add bx, bx
	sub bx, 2
	div bx
	cmp dx, wx
	jb xok
	sub bx, dx
	mov dx, bx
xok:
	add dx, sx
	mov word [x], dx
	
	xor dx, dx
	mov word ax, [t]
	xor bx, bx
	mov word bx, wy
	add bx, bx
	sub bx, 2
	div bx
	cmp dx, wy
	jb yok
	sub bx, dx
	mov dx, bx
yok:
	add dx, sy
	mov word [y], dx
	
show:	
	xor dx, dx
	mov word ax, [t]
	mov bx, 15
	div bx
	mov cx, dx
	add cx, 1
	xor ax,ax                 ; �����Դ��ַ
	mov ax,word[x]
	mov bx,80
	mul bx
	add ax,word[y]
	mov bx,2
	mul bx
	mov bx,ax
	mov ah,cl				;  0000���ڵס�1111�������֣�Ĭ��ֵΪ07h��
	mov al,byte[char]			;  AL = ��ʾ�ַ�ֵ��Ĭ��ֵΪ20h=�ո����
	mov [gs:bx],ax  		;  ��ʾ�ַ���ASCII��ֵ
	inc word [t]
	
	mov ah, 03h
	mov bx, 0
	int 10h
	mov [cursorx], dh
	mov [cursory], dl
	
	mov ah, 13h
	mov al, 1
	mov bl, 0eh
	mov bh, 0
	mov dh, 10
	mov dl, 30
	mov bp, namemsg
	mov cx, 18
	int 10h
	
	mov ah, 13h
	mov al, 1
	mov bl, 0eh
	mov bh, 0
	mov dh, 11
	mov dl, 27
	mov bp, exitmsg
	mov cx, 25
	int 10h
	
	mov ah, 02h
	mov bh, 0
	mov dh, [cursorx]
	mov dl, [cursory]
	int 10h
	
	jmp loop1

end:
	retf

datadef:	
	count dw delay
	dcount dw ddelay
	t    dw 0
	x    dw 0
	y    dw 0
	cursorx	db 0
	cursory	db 0
	timess dw 250

	char db 'A'
	
	namemsg db '16337233 WangKaiqi'
	exitmsg db 'Wait a moment to exit ...'
