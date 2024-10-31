# Data

The files that I downloaded from the [GitHub page](https://github.com/rfordatascience/tidytuesday/tree/master/data/2024/2024-01-09#nhl_player_birthscsv) contain information about:

### 1. Birth Statistics
   - In which year and in which month how many people were born in Canada 
   - Between 1991 and 2022

### 2. Statistics about NHL Players
   - Each player is one row with a unique ID
   - The birth dates range from 1879 to 2005
   - There is information about: 
      - Birth date, birth city, birth country, birth state or province, birth year, birth month

### 3. NHL Rosters Statistics
   - Covers seasons from 1979-1980 until 2010-2011
   - Variables:
      - Team code, season, position type, player ID, player name, preferred hand, height in inches and centimeters, weight in pounds and kilograms, birth date, birth city, birth country, birth state or province, birth year, birth month

### 4. NHL Teams
   - The data contains the teams' full names and codes

### External Data: Population of Canadian Cities
   - I used an external data source with information on cities’ populations in Canada
   - I found the data from a [website](https://worldpopulationreview.com/cities/canada), provided my email address, and they emailed the data to me shortly after.

# Research questions
   1.	It is common knowledge that in the first quater of the year, more professional sportman were born. In my research I will check this in the dataset and check if the statement is true on general birth data as well. For further analysis it is possible to test whether the birth ratio per month for sportman is significantly different from birth ratio per month in general.
   2.	When viewed proportionally, is there a higher likelihood of professional hockey players emerging from larger cities than smaller towns due to better facilities and opportunities?

# Steps of Analysis

 1. Create a New Schema
 2. Create New Tables for the Data
 3. Fill the Tables with Data

    I exported the data to separate SQL files for easier loading. These SQL files are available in my GitHub repository under the Term1 folder.
    During the loading process, some errors occurred:

    a. Comma and Quotation Errors
      - Table: player_birth
      - Record: player_id = 8475325, birth_city = "Garden River, First Nations"
      - Issue: The quotation mark in the code was not handled correctly, and the comma in the city name misaligned the data.
        
    b. Duplicate Entry Errors
      - Table: player_birth
      - Duplicate 1: player_id = 8480870
      - Solution: Both rows were identical, so I deleted the second one.
      - Duplicate 2: player_id = 8478449
      - Issue: The two records had different birth cities. One listed Nokia and the other Tampere as the birth city. Since both are valid, I decided to keep the record listing Nokia.
        
    c. Missing Values in rosters
      - Attributes: sweater number, height, and weight
      - Solution: Replaced missing values with NULL.
        
    d. City Name Issue in rosters (similar to player_birth issue for player_id = 8475325)
      - Solution: Searched in Excel for all instances of "Garden River, First Nations" and updated them to "Garden River First Nations".
### 4. ERM diagram
![You should see my ERM diagram here, if you cannot see it, search it up in my repository as ERM_diagram_as_png](https://github.com/gretazsikla/ceu_business_analytics_zsikla_greta/blob/main/sql/Term1/ERM_diagram_as_png.png)
   
### 5. Forward engineering
   - Here is a [link](https://github.com/gretazsikla/ceu_business_analytics_zsikla_greta/blob/main/sql/Term1/ERM_diagram_as_sql_file.mwb) to the sql script for the forward engineering
### 6. Exploratory Data Analysis
   - Lines 113-173
   - From which year do we have birth data? (1991-2022)
   - How many NHL players came from each country? (From Canada 5468, from USA 1403 etc.)
     | Country Code | Number of NHL Players |
     |--------------|-----------------------|
     | CAN          | 5468                  |
     | USA          | 1403                  |
     | SWE          | 403                   |
   - Which 6 Canadian provinces produce the most NHL players, and how many come from each?
      | Province           | Number of NHL Players |
      |--------------------|-----------------------|
      | Ontario            | 2407                  |
      | Quebec             | 865                   |
      | Alberta            | 645                   |
      | Saskatchewan       | 530                   |
      | Manitoba           | 408                   |
      | British Columbia    | 408                   |
   - Which 6 USA provinces produce the most NHL players, and how many come from each?
      | State              | Number of NHL Players |
      |--------------------|-----------------------|
      | Minnesota          | 301                   |
      | Massachusetts      | 219                   |
      | Michigan           | 192                   |
      | New York           | 144                   |
      | Illinois           | 77                    |
      | California         | 54                    |
   - How many players does each team have in season 2010-2011?
   - What is the average height in each team in season 2010-2011?
   - What is the average weight in each team in season 2010-2011?
   - What is the age of the players in each team in season 2010-2011?
   - What is the average age in each team in season 2010-2011?
   - Categorizing each player based on their age in season 2010-2011:
      - if younger than 27 years then young
      - average between 27-30
      - if older than 30 then old 
### 7. Dimensions
Illeszd be a képet ide
### 8. Data Warehouse
At my Data Warehouse each row is one NHL player. Most of the important variables are in the player_birth table (player_id, first_name, last_name, birth year, birth month, birth_country, birth_city). For the city population dimension, we will need the can_cities table. As the name suggests, the table only contains data about canadian cities, but I don't want to lose the data about the players who are not canadian so I will use **left join**, instead of inner join.
This is the result of the join:
| Player ID | First Name | Last Name | Birth Year | Birth Month | Birth Country | Birth City | Population |
|-----------|------------|-----------|------------|-------------|---------------|------------|------------|
| 8444850   | Henry      | Harris    | 1906       | 4           | Canada        | Kenora     | 15096      |
| 8444851   | Gordon     | Spence    | 1897       | 7           |               |            |            |
| 8444852   | Ron        | Hudson    | 1911       | 7           | Canada        | Calgary    | 1019942    |

The next step is adding the general birth data. The difficult part of this process, that for the better comparison, I want to have the same amount of data for general birth data and player birth data. If I calculated that in each month how many poeople were born based on the player_birth table, then I would have a monthly average between 1991 and 2022 while there is no NHL player who was born in 2022. It is not good enough if I restrict my analisys between 1879 and 2005, because not in every month had an NHL player born in 2005.

So I added the general birth data to the previous table with an inner join and named it **data_warehouse_process**. This way I have general birth data to those time periods when an NHL player was born as well. My table is not ready though because each general birth data is connected a year-month pair and not to a month.
| Player ID | First Name | Last Name   | Birth Year | Birth Month | Birth Country | Birth City   | Population | Births |
|-----------|------------|-------------|------------|-------------|---------------|--------------|------------|--------|
| 8477444   | Andre      | Burakovsky  | 1995       | 2           | AUT           | Klagenfurt   | NULL       | 29076  |
| 8480382   | Alexandar  | Georgiev    | 1996       | 2           | BGR           | Ruse         | NULL       | 28843  |

I made a temporary table where I selected from the previous table the distinct year, month, births columns, and then aggregated by the birth month and saved the table as sum_birth_data_per_month. 
| Month | sum_birth_data_per_month  |
|-------|---------------------------|
| 1     |         402 161            |
| 2     |         384 776            |
| 3     |         408 326            |
| 4     |         432 689            |
| 5     |         479 555            |
| 6     |         402 393            |
| 7     |         413 302            |
| 8     |         369 563            |
| 9     |         370 812            |
| 10    |         381 800            |
| 11    |         357 139            |
| 12    |         338 865            |

With an inner join I added these data so now I have the general birth data dimension as well.
| First Name | Last Name  | Player ID | Birth Year | Birth Month | Birth Country | Birth City     | Population | Sum_birth_data_per_month |
|------------|------------|-----------|------------|-------------|---------------|----------------|------------|--------|
| Mathieu    | Perreault  | 8473618   | 1988       | 1           | Canada        | Drummondville  | 59489      | 402161 |
| Josh       | Tordjman   | 8473632   | 1985       | 1           | Canada        | Montreal       | 1600000    | 402161 |

From the data_warehouse_process I selected the distinct births numbers, and summed them up. I supposed that there is no year-month pair with the same birth number. Now I know that in those time periods when at least one NHL player was born, 4 258 749 people were born. I saved this value into @number_of_people_born.

I update the data_warehouse_process with a new column where I divide the Sum_birth_data_per_month by the @number_of_people_born and multiply by 100.
| First Name | Last Name  | Player ID | Birth Year | Birth Month | Country | City         | Population | Sum Birth Data Per Month | People Born Percent |
|------------|------------|-----------|------------|-------------|---------|--------------|------------|--------------------------|----------------------|
| Mathieu    | Perreault  | 8473618   | 1988       | 1           | Canada  | Drummondville | 59489     | 402161                   | 9.44317              |




