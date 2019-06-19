; ����Դ���루stone.asm��
; ���������ı���ʽ��ʾ���ϴ�������һ��*��,��45���������˶���ײ���߿����,�������.
;  ��Ӧ�� 2014/3
;  ������ 2018/3
;  NASM����ʽ
	delay  equ 4					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
	sx     equ 0
	sy     equ 77
	wx     equ 25
	wy     equ 3
	org 100h					; ������ص�100h������������COM
	
start:
	push ds
	push es
	mov ax,940h
	mov ds,ax
	mov es,ax
	mov ax,0B800h				; �ı������Դ���ʼ��ַ
	mov gs,ax					; GS = B800h
loop1:
	dec word[count]				; �ݼ���������
	jnz end				; >0����ת;
	mov word[count],delay
	
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

end:
	pop es
	pop ds
	mov al,20h			; AL = EOI
	out 20h,al			; ����EOI����8529A
	out 0A0h,al			; ����EOI����8529A
	iret			; ���жϷ���

datadef:	
	count dw delay
	t    dw 0
	x    dw 0
	y    dw 0

	char db 'A'