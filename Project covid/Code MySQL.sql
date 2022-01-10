CREATE SCHEMA `data_covid`;

CREATE TABLE covid(
   Entry_ID                                INTEGER  NOT NULL PRIMARY KEY 
  ,State_Patient_Number                    VARCHAR(500) DEFAULT NULL
  ,Date_Announced                          DATE  DEFAULT NULL
  ,Age_Bracket                             VARCHAR(500) DEFAULT NULL
  ,Gender                                  VARCHAR(500) DEFAULT NULL
  ,FIELD6                                  VARCHAR(500) DEFAULT NULL
  ,Detected_District                       VARCHAR(500) DEFAULT NULL
  ,Detected_State                          VARCHAR(200) DEFAULT NULL
  ,State_code                              VARCHAR(50)  DEFAULT NULL
  ,Num_Cases                               INTEGER  DEFAULT NULL
  ,Current_Status                          VARCHAR(200) DEFAULT NULL
  ,Contracted_from_which_Patient_Suspected VARCHAR(500) DEFAULT NULL
  ,Notes                                   VARCHAR(500) DEFAULT NULL
  ,Source_1                                VARCHAR(1000) DEFAULT NULL
  ,Source_2                                VARCHAR(500) DEFAULT NULL
  ,Source_3                                VARCHAR(500) DEFAULT NULL
  ,Nationality                             VARCHAR(500) DEFAULT NULL
  ,Type_of_transmission                    VARCHAR(500) DEFAULT NULL
  ,Status_Change_Date                      VARCHAR(500) DEFAULT NULL
  ,Patient_Number                          VARCHAR(10) DEFAULT NULL
);

SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'C:/temp/raw_data19_1.csv' 
INTO TABLE covid 
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select count(*) from covid;

select distinct(Age_Bracket) from covid
order by Age_Bracket DESC;

select distinct(Detected_State), State_code
from covid
order by State_code DESC;

create table covid19_clean_data as select * from covid;

select * from covid19_clean_data;
select count(*) from covid19_clean_data;

set sql_safe_updates = 0;
update covid19_clean_data set Detected_State = 'Andhra Pradesh'
where State_code = 'AP';

select distinct(Detected_State), State_code
from covid19_clean_data
order by State_code DESC;

describe world.covid19_clean_data;

select distinct(Current_Status) from covid19_clean_data;

update covid19_clean_data 
set Current_Status = 
case
	when Current_Status = 'Migrated_Other'
    then 'Other'
    else Current_Status
    end; 
    
SELECT *
FROM covid19_clean_data
INTO OUTFILE 'C:/temp/covid_clean_data1.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY ''
LINES TERMINATED BY '\n';
