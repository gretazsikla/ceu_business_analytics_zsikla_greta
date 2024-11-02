create schema termproject1_ZSG;
use termproject1_ZSG;

SHOW VARIABLES LIKE 'secure_file_priv';
-- ---------------------------------------------------creating tables and loading data------------------------------------------------
drop table if exists births;
create table births
(year INTEGER NOT NULL,
month INTEGER NOT NULL,
births integer NOT NULL,
PRIMARY KEY(year, month));
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/canada_births_1991_2022.csv' 
INTO TABLE births 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(year, month, births);
select * from births;


drop table if exists player_birth;
create table player_birth
(player_id INTEGER NOT NULL,
first_name varchar(20),
last_name varchar(20),
birth_date date,
birth_city varchar(30),
birth_country varchar(20),
birth_state_province varchar(30),
birth_year integer not null,
birth_month integer not null,
PRIMARY KEY(player_id));

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/nhl_player_births.csv' 
INTO TABLE  player_birth
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(player_id,first_name,last_name,birth_date,birth_city,birth_country,birth_state_province,birth_year,birth_month);
select * from player_birth;


drop table if exists rosters;
create table rosters
(team_code varchar(5),
season integer,
position_type varchar(15),
player_id integer not null,
headshot varchar(150),
first_name varchar(20),
last_name varchar(20),
sweater_number integer null,
position_code varchar(1),
shoots_catches varchar(2),
height_in_inches integer,
weight_in_pounds integer,
height_in_centimeters integer,
weight_in_kilograms integer,
birth_date date,
birth_city varchar(30),
birth_country varchar(30),
birth_state_province varchar(30));

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/nhl_rosters.csv' 
INTO TABLE  rosters
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(team_code,season,position_type,player_id,headshot,first_name,last_name,
@sweater_number,position_code,shoots_catches,@height_in_inches,
@weight_in_pounds, @height_in_centimeters,@weight_in_kilograms,
birth_date,birth_city,birth_country,birth_state_province)
SET sweater_number = IF(@sweater_number = 'NA', NULL, @sweater_number),
	height_in_inches = IF(@height_in_inches = 'NA', NULL, @height_in_inches),
    height_in_centimeters = IF(@height_in_centimeters = 'NA', NULL, @height_in_centimeters),
    weight_in_pounds = if(@weight_in_pounds = 'NA', NULL, @weight_in_pounds),
    weight_in_kilograms = if(@weight_in_kilograms = 'NA', NULL, @weight_in_kilograms);
select * from rosters;


drop table if exists teams;
create table teams
(team_code varchar(5),
full_name varchar(30),
primary key(team_code));

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/nhl_teams_clean.csv' 
INTO TABLE  teams
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(team_code,full_name);
select * from teams;

drop table if exists can_cities;
create table can_cities
(city varchar(100),
country varchar(30),
pop2024 integer,
primary key(city));

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/canada-cities.csv' 
INTO TABLE  can_cities
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n' 
IGNORE 1 LINES 
(city, country, pop2024);
select * from can_cities;

-- ------------------------------------------------------forward engineering, setting foreign keys and reverse engineering-------------------------------------------------------------------
-- ------------------------------------------------- EDA select and other functions---------------------------------------------------------
select * from births;
select distinct(year) from births;

select * from player_birth;
select distinct birth_country from player_birth;
select birth_country, count(player_id) as number_of_players 
	from player_birth 
    group by birth_country 
    order by number_of_players desc;
select birth_state_province, count(player_id) as number_of_players
	from player_birth
    where birth_country = 'CAN'
    group by birth_state_province
    order by number_of_players desc
    limit 6;
select birth_state_province, count(player_id) as number_of_players
	from player_birth
    where birth_country = 'USA'
    group by birth_state_province
    order by number_of_players desc
    limit 6;
    
select * from rosters;
select count(player_id) as number_of_players, team_code
	from rosters
    where season = 20102011
	group by team_code
    order by number_of_players asc;
    
select avg(height_in_centimeters) as avg_height, team_code
	from rosters
    where season = 20102011
	group by team_code
    order by avg_height desc;

select avg(weight_in_kilograms) as avg_weight, team_code
	from rosters
    where season = 20102011
	group by team_code
    order by avg_weight desc;

select team_code, first_name, last_name, player_id, (2010-year(birth_date)) as age
	from rosters
    where season = 20102011;
select team_code, avg(2010-year(birth_date)) as avg_age
	from rosters
    where season = 20102011
	group by team_code
    order by avg_age desc;
select team_code, first_name, last_name, player_id, (2010-year(birth_date)) as age,
	case
		when (2010-year(birth_date)) <27
			then 'young'
		when (2010-year(birth_date))>27 and (2010-year(birth_date)) <31
			then 'average age'
		else
			'old'
    end
    as age_category
	from rosters
    where season = 20102011;

 -- ------------------------------------------------------------------------------- Data Warehouse ---------------------------------------------------------------------------
drop table if exists first_t;
create table if not exists first_t as select
	p.player_id, p.first_name, p.last_name, 
    p.birth_year, p.birth_month, c.country, c.city, c.pop2024
    from player_birth p 
    left join can_cities c
		on p.birth_city = c.city;
select * from first_t;


drop table if exists data_warehouse_process;
CREATE TABLE if not exists data_warehouse_process AS SELECT 
	p.first_name, p.last_name, p.player_id,
    p.birth_year, p.birth_month, p.birth_country, p.birth_city, c.pop2024, b.births
    from player_birth p 
    inner join births b 
		on b.year=p.birth_year and b.month=p.birth_month
	left join can_cities c
		on p.birth_city = c.city
	order by birth_year asc, birth_month asc;
select * from data_warehouse_process;

select sum(distinct(births)) into @number_of_people_born from data_warehouse_process; -- How many people were born in these time period? -- 4258749 - I save it for later analysis

drop table if exists sum_birth_data_per_month;
create table sum_birth_data_per_month as
with test as (
select distinct birth_year, birth_month, births from data_warehouse_process
)
select birth_month, sum(births) as sum_birth_data_per_month
from test
group by birth_month;
select * from sum_birth_data_per_month;


drop table if exists data_warehouse_process2;
CREATE TABLE if not exists data_warehouse_process2 AS SELECT 
	p.first_name, p.last_name, p.player_id,
    p.birth_year, p.birth_month, c.country, c.city, c.pop2024, sum_birth_data_per_month.sum_birth_data_per_month
    from player_birth p 
    inner join sum_birth_data_per_month
		on p.birth_month = sum_birth_data_per_month.birth_month
    inner join can_cities c
		on p.birth_city = c.city
    order by birth_month;
select * from data_warehouse_process2;

ALTER TABLE data_warehouse_process2
ADD COLUMN people_born_percent FLOAT;
SET SQL_SAFE_UPDATES = 0;
UPDATE data_warehouse_process2
SET people_born_percent = sum_birth_data_per_month / @number_of_people_born*100 ;
select * from data_warehouse_process2;

select birth_month, avg(people_born_percent) from data_warehouse_process2
	group by birth_month;


-- adding the player birth data
drop table if exists player_birth_summary;
create table if not exists player_birth_summary as
	select birth_month, count(player_id) as players_born_by_month from data_warehouse_process2
	group by birth_month;
select * from player_birth_summary;

drop table if exists data_warehouse_process3;
CREATE TABLE if not exists data_warehouse_process3 AS SELECT 
	dw2.first_name, dw2.last_name, dw2.player_id,
    dw2.birth_year, dw2.birth_month, dw2.country, dw2.city, dw2.pop2024, dw2.sum_birth_data_per_month, dw2.people_born_percent, player_birth_summary.players_born_by_month
    from data_warehouse_process2 dw2 
    inner join player_birth_summary using(birth_month);
select * from data_warehouse_process3;

select count(*) into @number_of_NHLplayers_born from data_warehouse_process2; -- How many NHL players were born? - 3951 - I save it for later analysis

ALTER TABLE data_warehouse_process3
ADD COLUMN players_born_percent FLOAT;
SET SQL_SAFE_UPDATES = 0;
UPDATE data_warehouse_process3
SET players_born_percent = players_born_by_month / @number_of_NHLplayers_born*100 ;
select * from data_warehouse_process3;

select birth_month, avg(players_born_percent) from data_warehouse_process3
	group by birth_month;
    
ALTER TABLE data_warehouse_process3 RENAME TO THE_DATA_WAREHOUSE;
select * from the_data_warehouse;

show tables;
drop table avg_birth_data_per_month, birth_summary_for_dw, data_warehouse_process, data_warehouse_process2, first_t, player_birth_summary, playerbirth_summary_for_dw, sum_birth_data_per_month;
show tables;
-- ---------------------------------------------------------------------------------------- Data Marts --------------------------------------------------------------------------------
drop view if exists `birth_comparison`;
create view  `birth_comparison` as
	select birth_month, round(avg(people_born_percent),2) as people_born_percent1 , 
		round(avg(players_born_percent),2) as players_born_percent1,
        round((round(avg(players_born_percent),2)-round(avg(people_born_percent),2)),2) as difference
    from the_data_warehouse
    group by birth_month;
select * from `birth_comparison`;


drop view if exists `citycomparison`;
create view `citycomparison` as
select city, count(player_id) as number_of_players, avg(pop2024), round(avg(pop2024)/count(player_id),0) as ratio, 
		case
			when avg(pop2024) < 15000
				then 'below 15 000'
			when avg(pop2024) < 50000
				then 'between 15000 and 50 000'
			else
				'above 50 000'
		end
		as city_category
	from the_data_warehouse
	group by city
	order by ratio asc;
select avg(ratio) as avg_pop_per_player_ratio, city_category from `citycomparison` group by city_category;
select count(ratio) as num_cities, city_category from `citycomparison` group by city_category;












