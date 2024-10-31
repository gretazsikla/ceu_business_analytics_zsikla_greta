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
   - 
      





