; ����Դ���루stone.asm��
; ���������ı���ʽ��ʾ���ϴ�������һ���ַ���'16337233WangKaiqi',��45���������˶���ײ���߿����,�������.
; ��Ӧ�� 2014/3
; ������ 2018/3
; NASM����ʽ
	Dn_Rt equ 1                  ;D-Down,U-Up,R-right,L-Left
	Up_Rt equ 2                  ;
	Up_Lt equ 3                  ;
	Dn_Lt equ 4                  ;
	delay equ 50000					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�
	ddelay equ 580					; ��ʱ���ӳټ���,���ڿ��ƻ�����ٶ�

org 100h

section .data
	count dw delay
	dcount dw ddelay
	rdul db Dn_Rt         ; �������˶�
	x    dw 7
	y    dw 0
	char db 'A'
	message db '16337233WangKaiqi'

section .text
	
start:
	mov word [x], 7
	mov word [y], 0
	mov byte [char], 'A'
	mov byte [rdul], Dn_Rt
	mov word [count], delay
	mov word [dcount], ddelay
	mov si, message
	mov byte [si], '1'
	inc si
	mov byte [si], '6'
	inc si
	mov byte [si], '3'
	inc si
	mov byte [si], '3'
	inc si
	mov byte [si], '7'
	inc si
	mov byte [si], '2'
	inc si
	mov byte [si], '3'
	inc si
	mov byte [si], '3'
	inc si
	mov byte [si], 'W'
	inc si
	mov byte [si], 'a'
	inc si
	mov byte [si], 'n'
	inc si
	mov byte [si], 'g'
	inc si
	mov byte [si], 'K'
	inc si
	mov byte [si], 'a'
	inc si
	mov byte [si], 'i'
	inc si
	mov byte [si], 'q'
	inc si
	mov byte [si], 'i'
	
	;xor ax,ax					; AX = 0   ������ص�0000��100h������ȷִ��
	mov ax,0B800h				; �ı������Դ���ʼ��ַ
	mov gs,ax				        ; GS = 0xB800h
	mov byte[char],'A'
loop1:
	dec word[count]				; �ݼ���������
	jnz loop1					; >0����ת;
	mov word[count],delay
	dec word[dcount]				; �ݼ���������
	jnz loop1
	mov word[count],delay
	mov word[dcount],ddelay

	mov al,1
	cmp al,byte[rdul]
	jz  DnRt
	mov al,2
	cmp al,byte[rdul]
	jz  UpRt
	mov al,3
	cmp al,byte[rdul]
	jz  UpLt
	mov al,4
	cmp al,byte[rdul]
	jz  DnLt
	jmp $	

DnRt:
	inc word[x]
	inc word[y]
	mov bx,word[x]
	mov ax,25
	sub ax,bx
	jz  dr2ur
	mov bx,word[y]
	mov ax,63
	sub ax,bx
	jz  dr2dl
	jmp show
dr2ur:
	mov word[x],23
	mov byte[rdul],Up_Rt	
	jmp show
dr2dl:
	mov word[y],62
	mov byte[rdul],Dn_Lt	
	jmp show

UpRt:
	dec word[x]
	inc word[y]
	mov bx,word[y]
	mov ax,63
	sub ax,bx
	jz  ur2ul
	mov bx,word[x]
	mov ax,-1
	sub ax,bx
	jz  ur2dr
	jmp show
ur2ul:
	mov word[y],62
	mov byte[rdul],Up_Lt	
	jmp show
ur2dr:
	mov word[x],1
	mov byte[rdul],Dn_Rt	
	jmp show	
	
UpLt:
	dec word[x]
	dec word[y]
	mov bx,word[x]
	mov ax,-1
	sub ax,bx
	jz  ul2dl
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
	jz  ul2ur
	jmp show

ul2dl:
	mov word[x],1
	mov byte[rdul],Dn_Lt	
	jmp show
ul2ur:
	mov word[y],1
	mov byte[rdul],Up_Rt	
	jmp show
	
DnLt:
	inc word[x]
	dec word[y]
	mov bx,word[y]
	mov ax,-1
	sub ax,bx
	jz  dl2dr
	mov bx,word[x]
	mov ax,25
	sub ax,bx
	jz  dl2ul
	jmp show

dl2dr:
	mov word[y],1
	mov byte[rdul],Dn_Rt	
	jmp show
	
dl2ul:
	mov word[x],23
	mov byte[rdul],Up_Lt	
	jmp show
	
show:
	mov byte ah,0
	mov byte al,0
	mov bx,0
	mov cx,2000
black:
	mov [gs:bx],ax
	inc bx
	inc bx
	loop black
	
	xor ax,ax                 ; �����Դ��ַ
	mov word ax,[x]
	mov bx,80
	mul bx
	add word ax,[y]
	mov bx,2
	mul bx
	mov bx,ax
	mov si, message
	mov cx, 17
print_str:
	mov byte ah,0Fh				;  0000���ڵס�1111�������֣�Ĭ��ֵΪ07h��
	mov byte al,[si]			;  AL = ��ʾ�ַ�ֵ��Ĭ��ֵΪ20h=�ո����
	mov [gs:bx],ax  		;  ��ʾ�ַ���ASCII��ֵ
	inc si
	inc bx
	inc bx
	loop print_str
	jmp loop1
	
end:
    jmp $                   ; ֹͣ��������ѭ�� 
