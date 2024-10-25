create schema termproject01;
use termproject01;

SHOW VARIABLES LIKE 'secure_file_priv';
-- ---------------------------------------------------creating tables and loading data------------------------------------------------
drop table if exists births;
create table births
(year INTEGER NOT NULL,
month INTEGER NOT NULL,
births integer NOT NULL);
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
birth_year integer,
birth_month integer,
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

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/nhl_teams.csv' 
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



-- -------------------------------------------------select and other functions---------------------------------------------------------
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
