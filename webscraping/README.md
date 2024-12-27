# Rental Pricing in Budapest, Hungary

*By Greta Zsikla*

Medium article: [link](https://medium.com/@zsiki.greta/rental-pricing-in-budapest-hungary-ed911d04fa3f)

## Introduction

In this article, I analyze the rental market in Budapest. I scraped data from alberlet.hu, obtaining almost 1,400 observations. The data required significant cleaning, which I will explain during the exploratory data analysis.

## Data Cleaning

The dataset includes monthly rental fees in Hungarian Forints, excluding common and utility costs. Below are the data cleaning steps and adjustments made:

### Price Variable

- **Invalid Entries**: Removed 10 observations with a rental price of 0.
- **Corrections**: Adjusted a price from 21,000 Ft to 210,000 Ft based on listing details.
- **Outliers**: Retained a maximum price of 3.6 million Ft, corresponding to a luxury flat.
- **Distribution**: Noted a highly skewed distribution with a long right tail; considered logarithmic transformation for modeling.

### Common Cost Variable

- **Range**: Identified values from 1,000 Ft to over 30 million Ft.
- **Corrections**: Adjusted an incorrect entry from over 30 million Ft to 30,900 Ft.
- **High Values**: Retained verified high values associated with properties offering additional services.

### Utility Cost Variable

- **Invalid Entries**: Removed 3 observations with utility costs exceeding 1 million Ft.
- **Range**: Remaining values ranged from 1,000 Ft to 110,000 Ft; retained lower values based on listing details.

### Square Meter Variable

- **Corrections**: Corrected an entry from 4 m² to 40 m² based on listing details.
- **Range**: Verified minimum value of 18 m² and retained a maximum value of 650 m² for an office space.

### Districts

- **Distribution**: Districts 13, 5, 6, 11, and 2 had the most rentals, each with over 100 observations, collectively accounting for over 50% of the rental market.

### Number of Rooms

- **Distribution**: Approximately 300 rentals had 1 room, 300 had 2 rooms, and 200 had 3 rooms.
- **Half-Rooms**: Calculated total rooms by adding half the number of half-rooms.

### Sight Variable

- **Categorization**: Grouped numerous unique values into four categories: street, garden, park, or other.

### Other Variables

- **Floor Levels**: Most rentals were on the first or second floor.
- **Heating Systems**: Predominantly central or gas-based.
- **Amenities**: Majority were furnished, equipped with appliances, and located in buildings with elevators.

## A General Rent

Based on the data, a typical rental property in Budapest has the following characteristics:

- **Location**: 13th district
- **Common Cost**: 20,000 Ft (approx. 48 Euros)
- **Utility Cost**: 20,000 Ft (approx. 48 Euros)
- **Area**: 54 m²
- **Rooms**: 2
- **View**: Street-facing
- **Floor**: First floor
- **Amenities**: Furnished, equipped with appliances, building with elevator

## Modeling

Developed two log-linear models:

### First Model

- **Variables**: Included all explanatory variables.
- **Reference Groups**:
  - Sight types compared to street view.
  - Number of balconies compared to no balcony.
  - Districts compared to District 13.
  - Heating types compared to central heating.
- **Performance**: Explanatory variables accounted for 77% of the variance in price.

### Second model:
- I dropped variables that were not significant at the 10% significance level.
- I replaced the dummy variables for different numbers of balconies with a single dummy variable indicating whether the rental has a balcony or not.

## Key Findings
- Rentals with an American kitchen are 7% more expensive on average (ceteris paribus: keeping all other variables constant).
- Rentals with an elevator are 9% more expensive on average (ceteris paribus).
- Rentals that are 10 m² larger are 3% more expensive on average (ceteris paribus).
- Rentals with one additional room are 19% more expensive on average (ceteris paribus).
- Rentals with one additional half room are 11% more expensive on average (ceteris paribus).
- Rentals with a balcony are 7% more expensive on average (ceteris paribus).
- Rentals in Districts 2, 3, 4, 5, 6, 9, 10, 12, 14, 16, 17, 18, 19, 20, 21, and 23 are significantly different in price compared to District 13 at the 10% significance level.
- Rentals with floor-ceiling heating systems are 21% more expensive on average (ceteris paribus).
- Furnished rentals are 17% more expensive on average (ceteris paribus).






