/*=================================================*/
/* Table: BookInfo
/* Definition: 
/* Author: gzez2012@163.com
/*=================================================*/
CREATE TABLE IF NOT EXISTS `BookInfo` (
	`isbn`	VARCHAR(50)	NOT NULL	COMMENT 'ISBN',
	`class`	VARCHAR(50)	COMMENT '����',
	`title`	VARCHAR(50)	COMMENT '����',
	`author`	VARCHAR(50)	COMMENT '����',
	`press`	VARCHAR(50)	COMMENT '������',
	`publish_date`	VARCHAR(50)	COMMENT '��������',
	`intro`	TEXT	COMMENT '���',
	PRIMARY KEY (`isbn`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE=utf8_bin
COMMENT='�鼮��Ϣ';
/*=================================================*/
/* Table: Reader
/* Definition: 
/* Author: gzez2012@163.com
/*=================================================*/
CREATE TABLE IF NOT EXISTS `Reader` (
	`id`	INTEGER	NOT NULL	COMMENT 'ѧ��',
	`name`	VARCHAR(50)	NOT NULL	COMMENT '����',
	`department`	VARCHAR(50)	COMMENT '����ϵ',
	`penalty`	INTEGER	NOT NULL	DEFAULT '0'	COMMENT '�ۼ�Υ�´���',
	`borrowed_book`	INTEGER	NOT NULL	DEFAULT '0'	COMMENT '�ۼƽ������',
	`gender`	VARCHAR(1)	COMMENT '�Ա�||CU0097',
	`phone`	VARCHAR(50)	COMMENT '��ϵ�绰',
	`remark`	TEXT	COMMENT '��ע',
	PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE=utf8_bin
COMMENT='����';
/*=================================================*/
/* Table: Admin
/* Definition: 
/* Author: gzez2012@163.com
/*=================================================*/
CREATE TABLE IF NOT EXISTS `Admin` (
	`id`	INTEGER	NOT NULL	COMMENT '������',
	`name`	VARCHAR(50)	NOT NULL	COMMENT '����',
	`gender`	VARCHAR(1)	COMMENT '�Ա�||CU0097',
	`phone`	VARCHAR(50)	COMMENT '�绰',
	`address`	VARCHAR(50)	COMMENT '��ͥסַ',
	`remark`	TEXT	COMMENT '��ע',
	PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE=utf8_bin
COMMENT='����Ա';
/*=================================================*/
/* Table: Book
/* Definition: 
/* Author: gzez2012@163.com
/*=================================================*/
CREATE TABLE IF NOT EXISTS `Book` (
	`id`	VARCHAR(50)	NOT NULL	COMMENT '�����',
	`isbn`	VARCHAR(50)	NOT NULL	COMMENT 'ISBN',
	`remark`	TEXT	COMMENT '��ע',
	PRIMARY KEY (`id`),
	CONSTRAINT `fk_Book_4` FOREIGN KEY (`isbn`) REFERENCES `BookInfo`(`isbn`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE=utf8_bin
COMMENT='�鱾';
/*=================================================*/
/* Table: Borrows
/* Definition: 
/* Author: gzez2012@163.com
/*=================================================*/
CREATE TABLE IF NOT EXISTS `Borrows` (
	`rec_id`	INTEGER	NOT NULL	COMMENT '�����¼���',
	`stu_id`	INTEGER	NOT NULL	COMMENT '����ѧ��',
	`book_id`	VARCHAR(50)	NOT NULL	COMMENT '�����',
	`admin_id`	INTEGER	NOT NULL	COMMENT '�����߹�����',
	`continue_debit`	VARCHAR(1)	NOT NULL	DEFAULT 'N'	COMMENT '�Ƿ�����',
	`borrow_date`	DATE	NOT NULL	COMMENT '��������',
	`return_date`	DATE	NOT NULL	COMMENT 'Ӧ������',
	`actual_return_date`	DATE	COMMENT 'ʵ�ʻ�������',
	PRIMARY KEY (`rec_id`),
	CONSTRAINT `fk_Borrows_2` FOREIGN KEY (`book_id`) REFERENCES `Book`(`book_id`),
	CONSTRAINT `fk_Borrows_3` FOREIGN KEY (`stu_id`) REFERENCES `Reader`(`stu_id`),
	CONSTRAINT `fk_Borrows_4` FOREIGN KEY (`admin_id`) REFERENCES `Admin`(`admin_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE=utf8_bin
COMMENT='���Ĺ�ϵ';
