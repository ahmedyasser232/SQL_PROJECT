-- Create Database
create database Fitzone ;
use Fitzone ;
----------------------------------------------
--Use DDL To Create Tables and Indetify PK AND Foreign key 
----------------------------------------------
--Create Table Fitnessmember  (type of column , pk ,fk)
Create table Fitnessmember 
( Unique_id Int Primary key,
  First_name Varchar(100) not null ,
  last_name varchar(100) not null,
  phone_number varchar(20) not null,
  city varchar(100) not null ,
  street varchar (100) ,
  date_of_birth date not null , 
);
-- create table membership_plan (type of column,pk, use check to get postive value , use not null when it's mandatory)
create table membership_plan 
(unique_plan_id int primary key ,
 plan_name varchar(100) not null ,
 monthly_fee int check(monthly_fee > 0),
 duration_in_month int check (duration_in_month > 0),
 unique_id int
   foreign key (Unique_id) references Fitnessmember(Unique_id)
);
--create table fitness_class (type of column , pk , fk )
create table Fitness_class 
(unique_class_id int primary key ,
 class_name varchar(100) not null ,
 maximum_Capacity int check (maximum_Capacity > 0) ,
 class_date date not null ,
 starting_date date ,
 difficulty_level varchar(100),
);
--create table room (types of column , pk, check capacity )
create table room 
( room_number int primary key ,
  room_name varchar(100) not null ,
  capacity int check (capacity > 0),
  unique_class_id int
   foreign key (unique_class_id) references  Fitness_class (unique_class_id)
);
--create table trainer (types of column , pk, )
create table trainer 
(Trainer_Unique_id int primary key ,
 first_name varchar (100) not null ,
 last_name varchar (100) not null ,
 phone_number varchar(20) not null ,
 Hire_date date ,
 specialty varchar(100) ,
 unique_class_id int
  foreign key (unique_class_id) references Fitness_class(unique_class_id)
);
--create table certification (type of column , pk  )
create table certification 
(Certification_code int primary key ,
 certification_name varchar(100) ,
  issuing_organization varchar(100)
);
--create table Trainer_certification (type of column , compsite pk   )
create table Trainer_certification 
( Trainer_Unique_id int  ,
  Certification_Code int ,
  date_certification_earned date ,
  primary key (Trainer_Unique_id ,Certification_Code),
  foreign key (Trainer_Unique_id)  references trainer(Trainer_Unique_id) ,
  foreign key (Certification_Code) references certification (Certification_code)
);

--Create Table member_registration (type of column , define composite pk , fk )
create table member_registration 
(unique_id int  ,
 unique_plan_id int ,
 registration_date date  ,
 registration_status varchar(100),
 primary key (unique_id ,unique_plan_id) ,
 foreign key (unique_id) references  Fitnessmember (unique_id),
 foreign key (unique_plan_id) references  membership_plan (unique_plan_id)
);