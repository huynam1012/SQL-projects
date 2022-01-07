SELECT count(*) FROM world.covid19;

SELECT * FROM world.covid19 limit 10;

select min(`Date Announced`) from world.covid19;
select max(`Date Announced`) from world.covid19;

select distinct(`Date Announced`) as Date_reported,
count(*) as no_of_records
from  world.covid19
group by date_reported
order by date_reported;

select distinct(`Age Bracket`) from world.covid19;

select distinct(gender) from world.covid19;

select distinct(gender),
count(*) as no_of_records
from world.covid19;

select distinct(`detected state`), `State code`
from world.covid19
order by `State code` ASC;

# version control
create table  world.covid19_clean_data as select * from world.covid19;

set sql_safe_updates = 0;
update world.covid19_clean_data set `detected state` = 'Andhra Pradesh'
where world.covid19_clean_data.`State code` = 'AP';

select distinct(`detected state`), `State code` as state_code
from world.covid19_clean_data
order by state_code ASC;

describe world.covid19_clean_data;

select distinct(`Current Status`) from world.covid19_clean_data;

update world.covid19_clean_data 
set `Current Status` = 
case
	when `Current Status` = 'Deceased'
    then 'deceased'
    else `Current Status`
    end; 

