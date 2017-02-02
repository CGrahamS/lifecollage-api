DROP SCHEMA IF EXISTS lifecollage_00_01_00;
CREATE SCHEMA IF NOT EXISTS lifecollage_00_01_00;

USE lifecollage_00_01_00;

-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2017-02-02 21:15:59.284

-- tables
-- Table: application_user
CREATE TABLE application_user (
    id int NOT NULL AUTO_INCREMENT,
    email varchar(200) NOT NULL,
    password varchar(200) NOT NULL,
    first_name varchar(100) NOT NULL,
    last_name varchar(100) NOT NULL,
    username varchar(100) NOT NULL,
    CONSTRAINT application_user_pk PRIMARY KEY (id)
);

-- Table: collage
CREATE TABLE collage (
    id int NOT NULL AUTO_INCREMENT,
    title varchar(100) NOT NULL,
    created datetime NOT NULL DEFAULT NOW(),
    application_user_id int NOT NULL,
    CONSTRAINT collage_pk PRIMARY KEY (id)
);

-- Table: picture
CREATE TABLE picture (
    id int NOT NULL AUTO_INCREMENT,
    location varchar(250) NOT NULL,
    created datetime NOT NULL DEFAULT NOW(),
    collage_id int NOT NULL,
    CONSTRAINT picture_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: collage_application_user (table: collage)
ALTER TABLE collage ADD CONSTRAINT collage_application_user FOREIGN KEY collage_application_user (application_user_id)
    REFERENCES application_user (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Reference: picture_collage (table: picture)
ALTER TABLE picture ADD CONSTRAINT picture_collage FOREIGN KEY picture_collage (collage_id)
    REFERENCES collage (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- End of file.
