;����Դ���루myos1.asm��
org  7c00h		; BIOS���������������ص�0:7C00h��������ʼִ��
OffSetOfUserPrg1 equ 0a100h
Start:
	mov	ax, cs	       ; �������μĴ���ֵ��CS��ͬ
	mov	ds, ax	       ; ���ݶ�
	mov	ax, ds		   ; ES:BP = ����ַ
	mov	es, ax		   ; ��ES=DS
	
LoadnEx:
	;�����̻�Ӳ���ϵ����������������ڴ��ES:BX����
	mov bx, OffSetOfUserPrg1  ;ƫ�Ƶ�ַ; ������ݵ��ڴ�ƫ�Ƶ�ַ
	mov cx, bx
	mov ah,2                 ; ���ܺ�
	mov al,17                 ;������
	mov dl,0                 ;�������� ; ����Ϊ0��Ӳ�̺�U��Ϊ80H
	mov dh,0                 ;��ͷ�� ; ��ʼ���Ϊ0
	mov ch,0                 ;����� ; ��ʼ���Ϊ0
	mov cl,2                 ;��ʼ������ ; ��ʼ���Ϊ1
	int 13H ;                ���ö�����BIOS��13h����
	; �û�����a.com�Ѽ��ص�ָ���ڴ�������
	jmp OffSetOfUserPrg1

AfterRun:
	jmp Start                      ;����ѭ��
	times 510-($-$$) db 0
	db 0x55,0xaa
