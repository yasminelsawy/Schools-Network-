##create database mileston;
#drop database milestone;
 create database milestone;
 use milestone;
create TABLE schools(
id INT PRIMARY key AUTO_INCREMENT,
email varchar(100) not null,
phone_number varchar(30),
general_information varchar(40),
type  ENUM('INTERNATIONAL ','NATIONAL') not null,
vision varchar(40) ,
fees double not null,
mission varchar(40) ,
school_name varchar(20) not null,
main_language varchar(20) ,
address varchar(100) not null
);

create table  levels(
name varchar(20) Primary key ,
grade_offered varchar(20)
);

create table elementary (
school_id int ,
level_name varchar(30) default 'Elementary',
 FOREIGN KEY(level_name) references levels (name) on delete cascade,
primary key(school_id),
FOREIGN KEY (school_id) 
  REFERENCES schools (id) 
  ON DELETE CASCADE
);

create table elementary_supplies(
school_id int ,
supply varchar(20),
primary key(school_id,supply),
constraint skool_id
FOREIGN KEY (school_id) 
  REFERENCES schools (id) 
  ON DELETE CASCADE
);

create table middle (
school_id int ,
level_name varchar(30) default 'midde', 
FOREIGN KEY(level_name) references levels(name) on delete cascade,
primary key(school_id),
constraint mdl
FOREIGN KEY (school_id) 
  REFERENCES schools (id) 
  ON DELETE CASCADE
);

create table high (
school_id int ,
level_name varchar(30) default 'High', 
FOREIGN KEY(level_name) references levels(name) on delete cascade,
primary key(school_id),
constraint hgl
FOREIGN KEY (school_id) 
  REFERENCES schools (id) 
  ON DELETE CASCADE
);

#CHANGE HERE
 #drop table Clubs;
create table clubs(
school_id int ,
name_club varchar(20),
purpose varchar(20),


constraint clb

FOREIGN KEY (school_id) 
REFERENCES high (school_id) 
ON DELETE CASCADE ,

primary key(school_id, name_club)
);


create table parents(
user_name varchar(20) ,
address varchar(40) not null,
password varchar(20) unique not null,
first_name varchar(20) not null,
last_name varchar(20) not null,
home_number varchar(30)  not null,
email varchar(100) not null,
primary key(user_name)
);

create table parent_mobile_numbers(
parent_username varchar(20),
mobile_number varchar(30),
 primary key(parent_username ,mobile_number),
constraint pmn
FOREIGN KEY (parent_username) 
  REFERENCES parents (user_name) 
  ON DELETE CASCADE 
);

#drop database trialcopy;
create table students (
SSN int,
parent_username varchar (20),
school_id int,
name varchar(100) not null,
password varchar(20) ,
gender ENUM('MALE ','FEMALE') not null,
birth_date date  not null,
user_name varchar(20) unique,

grade int ,
constraint prnt_nme
FOREIGN KEY (parent_username) 
  REFERENCES parents (user_name) 
   ON DELETE NO ACTION,
  constraint sklid
FOREIGN KEY (school_id) 
  REFERENCES schools (id) 
  ON DELETE set null,
primary key  (SSN) 
);


ALTER TABLE students 
ADD COLUMN age int AS (YEAR('2016-1-1') - YEAR(birth_date));

#ALTER TABLE student 
#ADD COLUMN grade int as age-5 ;



alter table levels rename to Levels;
alter table  parents rename to Parents;
alter table schools rename to Schools;
alter table parent_mobile_numbers rename to Parent_mobile_numbers;

alter table parents change column password password varchar(20) unique not null;




alter table schools change column type type ENUM('INTERNATIONAL ','NATIONAL') not null ;

alter table parents modify user_name varchar(20) first;

alter table levels change column name name varchar(20);


##CHANGE HERE 
#drop table  Questions;
create table Questions (
course_code varchar(20) ,
Question_number int auto_increment ,
teacher_id int,
student_SSN int ,
answer varchar(20),
primary key(course_code,Question_number),
foreign key (course_code) references
courses (course_code) on delete cascade,

foreign key (teacher_id) references 
employees(id),
foreign key (student_SSN) references 
students (SSN) ON DELETE NO ACTION
)engine=MyISAM;
ALTER TABLE `questions` ADD `content` VARCHAR(100) NULL DEFAULT NULL AFTER `answer`;

ALTER TABLE `questions` CHANGE `answer` `answer` varchar(100);

create table Employees(
id int auto_increment,
school_id int,
user_name varchar(20) not null,
password varchar(20) not null,
birth_date date,
salary double not null,
email varchar(100),
address varchar(40) not null,
first_name varchar(100) not null,
middle_name varchar(100) not null,
last_name varchar(100) not null,
gender ENUM('MALE','FEMALE'),
job_type ENUM('ADMINSTARTOR','EMPLOYEE'),
years_of_exp int ,
primary key (id),
constraint skol_id 
foreign key (school_id)
references schools (id)
on delete set  null
);



create table announcements(
announcement_number int auto_increment ,
admin_id int ,
title varchar(20) not null,
type varchar(20),
date date ,
description varchar(20),
primary key (announcement_number),
constraint adn_id 
foreign key (admin_id)
references employees ( id) 
on delete no action
);

alter table employees change column job_type job_type enum ('ADMINSTRATOR','TEACHER');

create table reports(
report_number int  auto_increment ,
teacher_id int,
student_SSN int,
parent_username varchar(20),
issue_date date not null,
comment varchar(20),
reply varchar(20),


foreign key (teacher_id)
references employees(id) 
on delete no action ,


foreign key (student_SSN)
references students (SSN) 
on delete no action ,


foreign key (parent_username)
references parents (user_name) 
on delete no action ,

primary key (report_number, teacher_id,student_SSN)
);

create table school_review_parent(
parent_username varchar(20),
school_id int ,
description varchar(20),
primary key(parent_username,school_id),
constraint parent_usernme
foreign key (parent_username)
references parents(user_name)
on delete no action ,
constraint skoool_ID
foreign key (school_id)
references schools(id)
on delete no action 
); 


create table Courses(
course_code varchar(20), 
course_name varchar(15), 
grade_offered int, 
description varchar(20), 
primary key(course_code)
);

ALTER TABLE `courses` ADD `level_name` varchar(20)   NOT NULL AFTER `course_code` ;

alter table `courses` add constraint vds foreign key (level_name) references levels (name) on delete cascade;


create table teacher_teaches_course_to_student(
student_SSN int  ,
course_code varchar(20),
teacher_id int ,


primary key (student_SSN,course_code),

##constraint teacher_idd
foreign key (teacher_id)
references employees (id)
 ON delete set null,
##on delete set null,

##constraint course_codee
foreign key (course_code)
references courses (course_code)
ON DELETE CASCADE,
##on delete set null,

##constraint student_SSNn
foreign key (student_SSN)
references students (SSN)
ON DELETE CASCADE
-- on delete set null
);




-- UPDATE Students SET grade = age/2;
-------------------------------------------------------------- 


create table Assignments (
course_code varchar(20) ,
assignment_number int,
due_date datetime,
start_date datetime,
content varchar(30),
teacher_id_post int,
primary key(course_code,assignment_number),

 constraint course_c
foreign key (course_code) references courses(course_code) on delete cascade,

 constraint teacher_d
foreign key (teacher_id_post) references employees (id) on delete cascade
 );
 
  ALTER TABLE assignments  
DROP FOREIGN KEY teacher_d;

ALTER TABLE assignments  
ADD CONSTRAINT teacher_d
FOREIGN KEY (teacher_id_post) references employees (id) on delete no action ;


create table Parent_rate_Teacher (
teacher_id int,
parent_user_name varchar(30),
rate_number int,
primary key(teacher_id,parent_user_name),

constraint rate_teacher_id
foreign key (teacher_id) references Employees(id) on delete cascade,

constraint parent_rate
foreign key (parent_user_name) references Parents (user_name) on delete cascade
 );
 
 create table Teacher_supervises_Teacher(
 teacher_id int,
 supervisor_id int,
 primary key (teacher_id, supervisor_id),
 
 constraint supervisor_teacher_id
 FOREIGN KEY (teacher_id) 
 REFERENCES Employees(id)
 ON DELETE cascade,
  FOREIGN KEY (supervisor_id)
  REFERENCES Employees(id)
 ON DELETE cascade
 );
 

create table Activities(
Activity_name varchar(15),
Activity_type varchar(15),
description varchar(40),
equipment varchar(15),
location varchar(15),
teacher_id_assigned int, 
admin_id int,
Activity_date date not null,
primary key(Activity_name),
constraint ta
FOREIGN KEY (admin_id) 
REFERENCES Employees(id) 
ON DELETE NO ACTION,
constraint taa
FOREIGN KEY (teacher_id_assigned) 
REFERENCES Employees(id) 
ON DELETE set null
);


 
 create table Activity_join_Student(
student_SSN int,
activity_name varchar(20),

primary key(student_SSN,activity_name),

constraint ccc
FOREIGN KEY (student_SSN) 
REFERENCES students (SSN)
on delete cascade , 


constraint dd
FOREIGN KEY (activity_name) 
REFERENCES activities (Activity_name)
on delete cascade

 );
 

 
create table course_isprerequisiteof_course(
course_code varchar(20),
prerequisted_course_code varchar(20),
primary key (course_code,prerequisted_course_code),
foreign key (course_code)
references courses(course_code)
on delete cascade,
foreign key ( prerequisted_course_code)
references courses(course_code)
);

## CHANGE HERE
 # drop table Assignment_solve_Student;
create Table Assignment_solve_Student (
course_code varchar(20),
assignment_number int,
student_SSN int,
grade varchar(15),
solution varchar(100),
primary key(course_code,assignment_number,student_SSN) ,
FOREIGN KEY (course_code,assignment_number) 
REFERENCES assignments(course_code,assignment_number)           -- here 
ON DELETE cascade,

FOREIGN KEY (student_SSN) 
REFERENCES students(SSN) 
ON DELETE cascade
);

#CHANGE HERE
create table Students_join_Clubs(
studet_SSN int, 
club_name varchar(20),
school_id int,
primary key(studet_SSN, club_name,school_id) ,
 
FOREIGN KEY (studet_SSN) 
REFERENCES Students (SSN) 
ON DELETE NO ACTION,


FOREIGN KEY (school_id,club_name) 
REFERENCES clubs (school_id,name_club)
on delete cascade

);



create table Parent_applyTo_School_for_Student(
school_id int, 
student_SSN int, 
is_accepted bit,
parent_user_name varchar(15),
primary key(school_id, student_SSN),
constraint sat
FOREIGN KEY (school_id) 
REFERENCES Schools (id) 
ON DELETE cascade,
constraint ssat
FOREIGN KEY (student_SSN) 
REFERENCES Students (ssn) 
ON DELETE cascade,
constraint pat
FOREIGN KEY (parent_user_name) 
REFERENCES Parents (user_name) 
ON DELETE NO ACTION
);


 -- drop table Parent_applyTo_School_for_Student;
-- ALTER TABLE Parent_applyTo_School_for_Student drop school_id;


ALTER TABLE `employees` CHANGE `user_name` `user_name` VARCHAR(100)  NOT NULL;

 
ALTER TABLE `employees` CHANGE `password` `password` VARCHAR(100) NOT NULL;

 
alter table `employees` change `email` `email` VARCHAR(100) DEFAULT NULL;


ALTER TABLE `employees` CHANGE `first_name` `first_name` VARCHAR(100) NOT NULL;


ALTER TABLE `employees` CHANGE `middle_name` `middle_name` VARCHAR(100)  NOT NULL;


ALTER TABLE `employees` CHANGE `last_name` `last_name` VARCHAR(100) NOT NULL;


ALTER TABLE `schools` CHANGE `email` `email` VARCHAR(100) NOT NULL;


ALTER TABLE `schools` CHANGE `address` `address` VARCHAR(100)  NOT NULL;


ALTER TABLE `employees` ADD UNIQUE(`user_name`);


ALTER TABLE `employees` ADD UNIQUE(`password`);


ALTER TABLE `students` CHANGE `name` `name` VARCHAR(100) NOT NULL;

ALTER TABLE `parents` CHANGE `email` `email` VARCHAR(100) NOT NULL;


ALTER TABLE `students` CHANGE `birth_date` `birth_date` DATE NOT NULL;


alter table parent_applyto_school_for_student change column is_accepted is_accepted bit default b'0';





alter table elementary  change level_name level_name varchar(30) default'Elementary';

alter table high  change level_name level_name varchar(30) default'High';

alter table middle  change level_name level_name varchar(30) default'middle';

#alter table levels add grade_offered varchar(20);

##alter table levels drop grade_offered;


## drop table teacher_teaches_course_to_student;


#####################################################

#drop table questions;

ALTER TABLE `parent_applyto_school_for_student` CHANGE `parent_user_name` `parent_user_name` VARCHAR(100) NULL DEFAULT NULL;

ALTER TABLE `activity_join_student` CHANGE `activity_name` `activity_name` VARCHAR(30)  NOT NULL;

#drop database trialcopy;