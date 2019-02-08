
#drop database Submission;
CREATE DATABASE Nourhan;
use Nourhan;
CREATE TABLE Schools (
id INT AUTO_INCREMENT PRIMARY KEY,
email VARCHAR(100),
phone_number VARCHAR(100),
general_information VARCHAR(100),
school_type ENUM('INTERNATIONAL','NATIONAL') NOT NULL,
vision VARCHAR(100),
fees DOUBLE,
mission VARCHAR(100),
school_name VARCHAR(100) NOT NULL,
main_language VARCHAR(100),
address VARCHAR(100) NOT NULL 
);
#drop table  buses; 
create table buses(
bus_num int AUTO_INCREMENT ,
route varchar(100),
model int ,
capactiy varchar(100),
school_id int,
FOREIGN KEY(school_id) REFERENCES Schools(id) ON DELETE CASCADE ,
PRIMARY KEY(bus_num,school_id)
);

CREATE TABLE Levels(
level_name VARCHAR(100) PRIMARY KEY
);
ALTER TABLE `levels` ADD `grade_offered` VARCHAR(100) NOT NULL AFTER `level_name`;

CREATE TABLE Elementary_schools(
school_id INT,
level_name VARCHAR(100) DEFAULT 'Elementary',
PRIMARY KEY(school_id),
FOREIGN KEY(school_id) REFERENCES Schools(id) ON DELETE CASCADE,
FOREIGN KEY(level_name) REFERENCES Levels(level_name)  
);

CREATE TABLE Middle_schools(
school_id INT,
level_name VARCHAR(100) DEFAULT 'Middle',
PRIMARY KEY(school_id),
FOREIGN KEY(school_id) REFERENCES Schools(id) ON DELETE CASCADE,
FOREIGN KEY(level_name) REFERENCES Levels(level_name)
);

CREATE TABLE High_schools(
school_id INT,
level_name VARCHAR(100) DEFAULT 'High',
PRIMARY KEY(school_id),
FOREIGN KEY(school_id) REFERENCES Schools(id) ON DELETE CASCADE,
FOREIGN KEY(level_name) REFERENCES Levels(level_name)
);

CREATE TABLE Elementary_supplies(
supply VARCHAR(100),
school_id INT,
PRIMARY KEY(supply,school_id),
FOREIGN KEY(school_id) REFERENCES Elementary_schools(school_id) ON DELETE CASCADE
);

CREATE TABLE Clubs(
club_name VARCHAR(100),
school_id INT,
purpose VARCHAR(100),
PRIMARY KEY(club_name,school_id),
FOREIGN KEY(school_id) REFERENCES High_schools(school_id) ON DELETE CASCADE
);

CREATE TABLE Parents(
user_name VARCHAR(100) PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
email VARCHAR(100),
parent_password VARCHAR(100),
home_phone_number INT,
address VARCHAR(100)
);

CREATE TABLE Parent_mobile_numbers(
mobile_number INT,
parent_user_name VARCHAR(100),
PRIMARY KEY(mobile_number,parent_user_name),
FOREIGN KEY(parent_user_name) REFERENCES Parents(user_name) ON DELETE CASCADE
);

CREATE TABLE Students(
ssn INT PRIMARY KEY,
student_name VARCHAR(100),
gender ENUM('Male','Female'),
birth_date DATE NOT NULL,
age INT AS(YEAR('2016-1-1')- YEAR(birth_date)),
grade INT AS ((YEAR('2016-1-1')- YEAR(birth_date)) - 5),
student_password VARCHAR(100),
user_name VARCHAR(100) UNIQUE,
school_id INT,
parent_user_name VARCHAR(100),
bus_id int,

FOREIGN KEY(school_id) REFERENCES Schools(id) ON DELETE SET NULL,
FOREIGN KEY(parent_user_name) REFERENCES Parents(user_name) ON DELETE CASCADE
);

alter table students add bus_id int;
alter table students add FOREIGN KEY(bus_id) REFERENCES buses(bus_num) ON DELETE SET NULL;

create table regidter_students_buses(
student_SSn int,
bus_id int ,
primary key(student_SSn,bus_id),
FOREIGN KEY(bus_id) REFERENCES buses(bus_num) ON DELETE cascade,
FOREIGN KEY(student_SSn) REFERENCES students(ssn) ON DELETE cascade
);

CREATE TABLE Employees(
id INT AUTO_INCREMENT PRIMARY KEY,
user_name VARCHAR(100) UNIQUE,
employee_password VARCHAR(100),
birth_date DATE,
salary DOUBLE,
email VARCHAR(100) UNIQUE,
address VARCHAR(100),
first_name VARCHAR(100),
middle_name VARCHAR(100),
last_name VARCHAR(100),
gender ENUM('Male','Female'),
job_type ENUM('Adminstrator','Teacher') NOT NULL,
years_of_experience INT,
school_id INT,
FOREIGN KEY(school_id) REFERENCES Schools(id) ON DELETE SET NULL
);

CREATE TABLE Activities(
activity_name VARCHAR(100) PRIMARY KEY,
activity_type VARCHAR(100),
description VARCHAR(100),
equipment VARCHAR(100),
location VARCHAR(100),
activity_date DATE,
teacher_id INT,
admin_id INT,
FOREIGN KEY(teacher_id) REFERENCES Employees(id) ON DELETE CASCADE,
FOREIGN KEY(admin_id) REFERENCES Employees(id) ON DELETE SET NULL
);

CREATE TABLE Announcements(
announcement_number INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(100),
announcement_type VARCHAR(100),
announcement_date DATE,
description VARCHAR(100),
admin_id INT, 
FOREIGN KEY(admin_id) REFERENCES Employees(id) ON DELETE SET NULL
);

CREATE TABLE Courses(
course_code VARCHAR(100) PRIMARY KEY,
course_name VARCHAR(100),
grade_offered INT,
description VARCHAR(100),
level_name VARCHAR(100),
FOREIGN KEY(level_name) REFERENCES Levels(level_name) ON DELETE CASCADE
);

CREATE TABLE Reports(
report_number INT AUTO_INCREMENT,
student_ssn INT,
teacher_id INT,
issue_date DATE,
reply VARCHAR(100),
report_comment VARCHAR(100),
parent_user_name VARCHAR(100),
PRIMARY KEY(report_number,student_ssn,teacher_id),
FOREIGN KEY(student_ssn) REFERENCES Students(ssn) ON DELETE CASCADE,
FOREIGN KEY(teacher_id) REFERENCES Employees(id) ON DELETE CASCADE,
FOREIGN KEY(parent_user_name) REFERENCES Parents(user_name) ON DELETE SET NULL
);

CREATE TABLE Questions(
question_number INT AUTO_INCREMENT,
course_code VARCHAR(100),
content VARCHAR(100),
answer VARCHAR(100),
teacher_id INT,
student_ssn INT,
PRIMARY KEY(question_number,course_code),
FOREIGN KEY(course_code) REFERENCES Courses(course_code) ON DELETE CASCADE,
FOREIGN KEY(teacher_id) REFERENCES Employees(id) ON DELETE SET NULL,
FOREIGN KEY(student_ssn) REFERENCES Students(ssn) ON DELETE SET NULL
);

CREATE TABLE Assignments(
assignment_number INT AUTO_INCREMENT,
course_code VARCHAR(100),
start_date DATE,
due_date DATE,
content VARCHAR(100),
teacher_id INT,
PRIMARY KEY(assignment_number,course_code),
FOREIGN KEY(course_code) REFERENCES Courses(course_code) ON DELETE CASCADE,
FOREIGN KEY(teacher_id) REFERENCES Employees(id) ON DELETE CASCADE
);

CREATE TABLE Activity_join_Student(
activity_name VARCHAR(100),
student_ssn INT,
PRIMARY KEY(activity_name,student_ssn),
FOREIGN KEY(activity_name) REFERENCES Activities(activity_name) ON DELETE CASCADE,
FOREIGN KEY(student_ssn) REFERENCES Students(ssn) ON DELETE CASCADE
);

CREATE TABLE Club_join_Student(
club_name VARCHAR(100),
school_id INT,
student_ssn INT,
PRIMARY KEY(club_name,school_id,student_ssn),
FOREIGN KEY(club_name,school_id) REFERENCES Clubs(club_name,school_id) ON DELETE CASCADE,
FOREIGN KEY(student_ssn) REFERENCES Students(ssn) ON DELETE CASCADE
);

CREATE TABLE Parent_rate_Teacher(
teacher_id INT,
parent_user_name VARCHAR(100),
rating INT,
PRIMARY KEY(teacher_id,parent_user_name),
FOREIGN KEY(teacher_id) REFERENCES EmployeEs(id) ON DELETE CASCADE,
FOREIGN KEY(parent_user_name) REFERENCES Parents(user_name) ON DELETE CASCADE
);

CREATE TABLE Parent_review_School(
school_id INT,
parent_user_name VARCHAR(100),
review VARCHAR(100),
PRIMARY KEY(school_id,parent_user_name),
FOREIGN KEY(school_id) REFERENCES Schools(id) ON DELETE CASCADE,
FOREIGN KEY(parent_user_name) REFERENCES Parents(user_name) ON DELETE CASCADE
);

CREATE TABLE Assignment_solve_Student(
assignment_number INT,
course_code VARCHAR(100),
student_ssn INT,
grade VARCHAR(100),
solution VARCHAR(100),
PRIMARY KEY(assignment_number,course_code,student_ssn),
FOREIGN KEY(assignment_number,course_code) REFERENCES Assignments(assignment_number,course_code)
ON DELETE CASCADE,
FOREIGN KEY(student_ssn) REFERENCES Students(ssn) ON DELETE CASCADE
);

CREATE TABLE Teacher_supervises_Teacher(
teacher_id INT,
supervisor_id INT,
PRIMARY KEY(teacher_id,supervisor_id),
FOREIGN KEY(teacher_id) REFERENCES Employees(id) ON DELETE CASCADE,
FOREIGN KEY(supervisor_id) REFERENCES Employees(id) ON DELETE CASCADE
);



create table Parent_apply_School_Student(
school_id int, 
student_SSN int,
is_accepted bit default b'0', 
parent_user_name varchar(100),

primary key(school_id, student_SSN),

FOREIGN KEY (school_id) 
REFERENCES Schools (id) 
ON DELETE cascade,

FOREIGN KEY (student_SSN) 
REFERENCES Students (ssn) 
ON DELETE cascade,

FOREIGN KEY (parent_user_name) 
REFERENCES Parents (user_name) 
ON DELETE NO ACTION
);



CREATE TABLE Course_prerequisite_Course(
course_code VARCHAR(100),
prerequisited_course_code VARCHAR(100),
PRIMARY KEY(course_code,prerequisited_course_code),
FOREIGN KEY(course_code) REFERENCES Courses(course_code) ON DELETE CASCADE,
FOREIGN KEY(prerequisited_course_code) REFERENCES Courses(course_code) ON DELETE CASCADE
);



CREATE TABLE Course_teaches_Student_Teacher(
student_ssn INT,
course_code VARCHAR(100),
teacher_id INT,
PRIMARY KEY(student_ssn,course_code),
FOREIGN KEY(student_ssn) REFERENCES Students(ssn) ON DELETE CASCADE,
FOREIGN KEY(course_code) REFERENCES Courses(course_code) ON DELETE CASCADE,
FOREIGN KEY(teacher_id) REFERENCES Employees(id) ON DELETE SET NULL
);