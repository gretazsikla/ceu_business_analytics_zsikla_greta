Rental pricing in Budapest, Hungary
Introduction
In this article I will analyse the rent market in Budapest. For this I scraped alberlet.hu giving almost 1400 observations. The data itself was messy and required a lot of cleaning. During the explanatory data analysis I will explain how I changed the data to make it better to model.
Data cleaning
The dataset includes rental fees for one month in Hungarian Forints, excluding common costs and utility costs. Below, I outline the data cleaning steps and adjustments made:
Price Variable
The minimum rental price in the dataset was 0, which is invalid. I removed these 10 observations.
The minimum non-zero price was 21,000 Forints (approximately 50 Euros). Upon reviewing the listing, I found this to be a mistake, as the description stated the rental price as 210,000 Forints (500 Euros). I corrected this value in the dataset.
The maximum rental price was 3.6 million Forints (8,675 Euros), which corresponds to a luxury flat. Since this value was verified as accurate, I retained it.
The distribution of rental prices is highly skewed with a long right tail. For modeling purposes, I considered applying a logarithmic transformation to normalize the distribution.
Common Cost Variable
The common cost variable is also skewed, ranging from 1,000 Forints (2.4 Euros) to over 30 million Forints (72,200 Euros).
For observations with a common cost exceeding 100,000 Forints (240 Euros), I examined the descriptions:
One observation was a clear mistake, as the description mentioned a common cost of 30,900 Forints (75 Euros), which I corrected.
The other high values were verified and often associated with properties offering services like a reception desk. These were retained as they were not mistakes.
