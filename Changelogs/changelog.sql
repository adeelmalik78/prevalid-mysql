-- liquibase formatted sql 

--changeset adeel:table1
create table table1 (
    id int primary key,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback drop table table1

--changeset adeel:table2
create table table2 (
    id int primary key,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback drop table table2

--changeset adeel:person
CREATE TABLE person
( id int primary key,
  first_name varchar(50) NOT NULL,
  last_name varchar(50) NOT NULL
)
--rollback drop table person

--liquibase formatted sql

--changeset amalik:insert_adeel
INSERT INTO person (id,first_name,last_name)
	VALUES (1,'Adeel','Ashraf');
--rollback DELETE FROM person WHERE id=1;

--changeset amalik:insert_amy
INSERT INTO person (id,first_name,last_name)
	VALUES (2,'Amy','Smith');
--rollback DELETE FROM person WHERE id=2;

--changeset amalik:insert_roderick
INSERT INTO person (id,first_name,last_name)
	VALUES (3,'Roderick','Bowser');
--rollback DELETE FROM person WHERE id=3;

--changeset amalik:update_adeel
UPDATE person
	SET first_name='Ryan', last_name='Campbell'
	WHERE id=1;
--rollback UPDATE person SET first_name='Adeel', last_name='Malik' WHERE id=1;

--changeset adeel:employee
create table employee (
    id int primary key,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback drop table employee

--changeset adeel:contractors
create table contractors (
    id int primary key,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar(50),
    city varchar(30)
)
--rollback drop table contractors

--changeset adeel:users
create table users (
    id int primary key,
    name varchar(50) not null,
    address1 varchar(50),
    address2 varchar2(50),
    city varchar(30)
)
--rollback drop table users