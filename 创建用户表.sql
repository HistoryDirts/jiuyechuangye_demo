#用户信息主表
CREATE TABLE user_info(
	id INT UNSIGNED AUTO_INCREMENT COMMENT '用户id', #主键
	user_name VARCHAR(12) NOT NULL DEFAULT '新用户' COMMENT '用户名', #用户名
	user_password VARCHAR(12) NOT NULL DEFAULT '123456' COMMENT '密码', #密码
	user_level TINYINT UNSIGNED NOT NULL DEFAULT 1  COMMENT '用户等级', #用户等级，初始默认为 1 级
	user_score INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户积分', #用户积分，初始为 0
	user_exp INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户经验值', #用户经验值，初始为 0
	user_intro VARCHAR(50) NOT NULL DEFAULT '什么也没有。' COMMENT '用户个人简介', #用户个人简介
	user_headshot VARCHAR(100) NOT NULL DEFAULT './headshot' COMMENT '用户头像目录', #用户头像目录
	user_nationality VARCHAR(50) NOT NULL DEFAULT '中国' COMMENT '用户国籍', #用户国籍，使用中文表达
	PRIMARY KEY(id)
);

#创建学生信息表
CREATE TABLE student_info(
	user_id INT UNSIGNED NOT NULL UNIQUE COMMENT '用户id', #user_info的外键
	stu_number INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '学号', 
	stu_name VARCHAR(50) NOT NULL DEFAULT '张三' COMMENT '姓名',
	stu_major_name VARCHAR(100) NOT NULL DEFAULT '计算机' COMMENT '专业名称', 
	stu_specialty VARCHAR(100) NOT NULL DEFAULT '编程' COMMENT '特长介绍', 
	stu_hobby VARCHAR(100) NOT NULL DEFAULT '唱歌' COMMENT '爱好介绍', 
	
	PRIMARY KEY(stu_number),
	CONSTRAINT fk_student_user FOREIGN KEY(user_id) REFERENCES user_info(id)
	
);


#教师信息表
CREATE TABLE teacher_info(
	user_id INT UNSIGNED NOT NULL UNIQUE COMMENT '用户id', #user_info的外键
	teacher_number INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '教师编号', 
	teacher_name VARCHAR(50) NOT NULL DEFAULT '张三' COMMENT '姓名',
	teacher_guidance VARCHAR(100) NOT NULL DEFAULT '什么也没有。' COMMENT '指导方向介绍',  
	teacher_specialty VARCHAR(100) NOT NULL DEFAULT '什么也没有。' COMMENT '特长介绍', 
	teacher_hobby VARCHAR(100) NOT NULL DEFAULT '什么也没有。' COMMENT '爱好介绍', 
	
	PRIMARY KEY(teacher_number),
	CONSTRAINT fk_teacher_user FOREIGN KEY(user_id) REFERENCES user_info(id)
	
);

#其它人员信息表
CREATE TABLE other_info(
	user_id INT UNSIGNED NOT NULL UNIQUE COMMENT '用户id', #user_info的外键
	other_id INT UNSIGNED NOT NULL COMMENT '人员编号', #人员编号
	other_name VARCHAR(50) NOT NULL COMMENT '人员名称',
	other_profile VARCHAR(100) NOT NULL DEFAULT '什么也没有' COMMENT '简介', 
	other_specialty VARCHAR(100) NOT NULL DEFAULT '编程' COMMENT '特长介绍', 
	other_hobby VARCHAR(100) NOT NULL DEFAULT '唱歌' COMMENT '爱好介绍', 
	
	PRIMARY KEY(other_id),
	CONSTRAINT fk_other_user FOREIGN KEY(user_id) REFERENCES user_info(id)
		
);

#企业用户表
CREATE TABLE company_info(
	user_id INT UNSIGNED NOT NULL UNIQUE COMMENT '用户id', #user_info的外键
	company_id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '企业id', #企业编号
	company_name VARCHAR(50) NOT NULL COMMENT '企业名称',
	company_business VARCHAR(100) NOT NULL DEFAULT '什么也没有。' COMMENT '业务方向介绍', 
	company_linkman VARCHAR(100) NOT NULL DEFAULT '张三' COMMENT '联系人', 
	company_profile VARCHAR(100) NOT NULL DEFAULT '什么也没有。' COMMENT '企业简介', 
	
	PRIMARY KEY(company_id),
	CONSTRAINT fk_company_user FOREIGN KEY(user_id) REFERENCES user_info(id)
	
);

#创建用户群组表
CREATE TABLE groups(
    group_id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '群组 id', 
    owner_id INT UNSIGNED NOT NULL COMMENT '群主 id',
    create_time DATE NOT NULL COMMENT '群组生成时间',
    
    PRIMARY KEY(group_id),
    CONSTRAINT fk_group_user FOREIGN KEY(owner_id) REFERENCES user_info(id)
);

#群组成员表
CREATE TABLE group_member(
    group_id INT UNSIGNED NOT NULL COMMENT '群组 id', 
    member_id INT UNSIGNED NOT NULL COMMENT '成员 id',
    add_time DATE NOT NULL COMMENT '成员加入时间',
    
    PRIMARY KEY(group_id, member_id),
    CONSTRAINT fk_member_group FOREIGN KEY(group_id) REFERENCES groups(group_id),
    CONSTRAINT fk_member_user FOREIGN KEY(member_id) REFERENCES user_info(id)
);

#身份信息表
CREATE TABLE identity_info (
	`name` VARCHAR(20) NOT NULL DEFAULT 'student' COMMENT '身份名称',
	id TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '身份编码',
	
	PRIMARY KEY (id)
);


#创建用户身份关系表
CREATE TABLE user_identity (
	user_id INT UNSIGNED COMMENT '用户id',
	user_type TINYINT UNSIGNED DEFAULT 1 COMMENT '表示用户类型',
	
	PRIMARY KEY(user_id, user_type),
	CONSTRAINT fk_identity_user FOREIGN KEY(user_id) REFERENCES user_info(id),
	CONSTRAINT fk_identity_user_info FOREIGN KEY(user_type) REFERENCES identity_info(id)
);

#创建帖子表
CREATE TABLE user_post(
   post_id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '帖子 id',
   post_title VARCHAR(30) NOT NULL COMMENT '标题',
   post_owner INT UNSIGNED NOT NULL COMMENT '发帖用户 id',
   post_content VARCHAR(1000) NOT NULL COMMENT '帖子内容(一楼)',
   post_replys_number INT UNSIGNED NOT NULL COMMENT '回复数',
   post_likes_number INT UNSIGNED NOT NULL COMMENT '点赞数',
   create_time DATETIME NOT NULL COMMENT '发帖时间',
   
   PRIMARY KEY(post_id),
   CONSTRAINT fk_post_user FOREIGN KEY(post_owner) REFERENCES user_info(id)
);

#创建帖子回复表
CREATE TABLE post_replys(
   post_id INT UNSIGNED NOT NULL COMMENT '帖子 id',
   reply_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '回复 id',
   reply_user INT UNSIGNED NOT NULL COMMENT '回复用户 id',
   reply_floor INT UNSIGNED NOT NULL COMMENT '所在楼层',
   reply_content VARCHAR(1000) NOT NULL COMMENT '回复内容',
   reply_type TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '回复类型',
   #回复类型表示回复主楼还是回复其它楼层，0表示回复主楼，否则为1
   reply_to_floor INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '回复对象楼层',
   post_likes_number INT UNSIGNED NOT NULL COMMENT '点赞数',
   reply_time DATETIME NOT NULL COMMENT '回复时间',
   
   PRIMARY KEY(reply_id),
   CONSTRAINT fk_reply_user FOREIGN KEY(reply_user) REFERENCES user_info(id),
   CONSTRAINT fk_reply_post FOREIGN KEY(post_id) REFERENCES user_post(post_id)
);

#创建项目信息表
CREATE TABLE project(
    pro_id INT UNSIGNED AUTO_INCREMENT COMMENT '项目id',
    pro_name VARCHAR(50) NOT NULL DEFAULT '我的项目' COMMENT '项目名',
    pro_level VARCHAR(50) NOT NULL COMMENT '项目级别描述',
    pro_description VARCHAR(100) NOT NULL DEFAULT '什么也没有。' COMMENT '项目简介',
    pro_tags VARCHAR(100) NOT NULL DEFAULT '空' COMMENT '项目标签',
    pro_owner INT UNSIGNED NOT NULL COMMENT '发起人id',
    is_open TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否公开,0为否',
    requirement VARCHAR(100) NOT NULL DEFAULT '空' COMMENT '需求描述',
    pro_group INT UNSIGNED NOT NULL COMMENT '项目群组 id',
    pro_rate  INT UNSIGNED NOT NULL COMMENT '项目进度描述(百分比)',
    file_path VARCHAR(100) NOT NULL DEFAULT './' COMMENT '项目文件目录',
    pro_achievement VARCHAR(100) NOT NULL DEFAULT '无' COMMENT '项目成果描述',
    pro_likes INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
    pro_estimate VARCHAR(100) NOT NULL DEFAULT '无' COMMENT '评价',
    
    PRIMARY KEY(pro_id),
    CONSTRAINT fk_project_user FOREIGN KEY(pro_owner) REFERENCES user_info(id),
    CONSTRAINT fk_project_group FOREIGN KEY(pro_group) REFERENCES groups(group_id),
    CHECK(pro_rate >= 0 AND pro_rate <= 100)   
);

#创建用户好友表
CREATE TABLE user_friend(
    user_id_1 INT UNSIGNED NOT NULL COMMENT '用户 1 id', 
    user_id_2 INT UNSIGNED NOT NULL COMMENT '用户 2 id', 
    add_time DATE NOT NULL COMMENT '好友添加时间',
    
    PRIMARY KEY(user_id_1, user_id_2),
    CONSTRAINT fk_friend_user1 FOREIGN KEY(user_id_1) REFERENCES user_info(id),
    CONSTRAINT fk_friend_user2 FOREIGN KEY(user_id_2) REFERENCES user_info(id)
);

#插入身份信息
INSERT INTO identity_info VALUES ("student",0), ("teacher",1),("company",2),("other",3)

