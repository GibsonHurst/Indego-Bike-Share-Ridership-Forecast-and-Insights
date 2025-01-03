# Indego Bike Share Ridership Insights & Forecast
December 2024 | By Gibson Hurst

In Philadelphia, the Indego Bike Share program provides vital transportation and recreational options for thousands of riders, who take an average of 3,500 trips per day. Indego offers 24/7 access to over 2,500 classic and pedal-assisted electric bikes at more than 250 stations. Last year, Indego ridership surpassed 1 million total trips for the first time and continues to show strong growth.

This project examines Indego bike share data from approximately 6 million trips recorded between Q1 2018 and Q3 2024. It includes insights, recommendations, and forecasts relevant to the program's owner, the City of Philadelphia Office of Transportation & Infrastructure Systems, and its operator, Bike Transit Systems.

For details on the methodology, including data structure, tools, and forecasting approaches, refer to the technical notes section at the end of this report.

![Stock photo](https://github.com/GibsonHurst/Indego-Bike-Share-Ridership-Forecast-and-Insights/blob/main/stock_photo.jpg)

## Quick Statistics
- Average daily ridership in past 12 months was 3,396 trips
- A typical trip lasts 10 minutes with a distance(geodesic) of 1.16 miles
- The most popular station destinations are 15th & Spruce, 23rd & South, Rodin Museum, and Kahn Park
- In the past 12 months, on average each bike has been taken on 392 trips and of these bikes 50% are classic and 50% are electric assisted

## Key Insights & Recommendations
![Yearly total forecast](https://github.com/GibsonHurst/Indego-Bike-Share-Ridership-Forecast-and-Insights/blob/main/indego-ridership-forecasted-to-hit-new-records-in-2024-2025.png)

Total annual ridership has grown each year since 2018, with the exception of 2020 due to reduced springtime ridership during the COVID-19 lockdowns. Indego is set to conclude 2024 with record ridership of 1.29 million trips, followed by a forecasted 1.50 million trips in 2025. The average annual ridership growth rate is 14.3%.

![Monthly total forecast](https://github.com/GibsonHurst/Indego-Bike-Share-Ridership-Forecast-and-Insights/blob/main/indego-monthly-total-ridership-follows-a-strong-seasonal-pattern-with-riders-avoiding-the-cold.png)
A strong relationship (r = 0.73) exists between daily high temperature and ridership, helping to explain the pronounced seasonal patterns observed each year. The share of round trips—trips that start and end at the same station—is highest in the summer, likely due to increased recreational use of the bike share system in warmer weather.

Notably, the share of round trips reached a record high of 30.8% on May 4, 2020, during the COVID-19 lockdowns, roughly five times the normal levels, as Philadelphians sought outdoor recreation during those challenging times.

**Recommendation #1:**  Overall ridership, including round-trip ridership associated with recreational use, is lowest during the winter months. It is recommended to offer a discount on monthly and annual memberships during the week encompassing New Year’s Day. This promotion would align with the holiday season, when many Philadelphians set fitness goals for the new year and could incentivize increased recreational use of the system.

![Average ridership](https://github.com/GibsonHurst/Indego-Bike-Share-Ridership-Forecast-and-Insights/blob/main/average-hourly-indego-ridership-peaks-during-the-evening-commute-with-fewer-riders-on-the-weekend.png)
**Recommendation #2:**  Average ridership is lowest at night, on weekends, and during winter months. Therefore, it is recommended that bike and station maintenance be scheduled during these times to minimize system interruptions and disruptions to essential commuter activity.

![Supply & demand](https://github.com/GibsonHurst/Indego-Bike-Share-Ridership-Forecast-and-Insights/blob/main/demand-for-indego-electric-assist-bikes-continues-to-grow-as-supply-growth-stalls.png)
Demand for electric bikes (58% of trips) currently exceeds their representation within the system (50% of bikes). Over the past three years, demand has grown while supply has remained constant. Therefore, steps should be taken to better balance demand between electric and classic bikes, improving system efficiency.

**Recommendation #3:**  Currently, Indego members are charged an additional 20 cents per minute when riding an electric bike. One option is to increase the price of electric bike usage. Another option is to increase the number of electric bikes within the system. If implemented together, the increased revenue from electric bike fees could help offset the investment in additional electric bikes.

![Ridership by passholder type](https://github.com/GibsonHurst/Indego-Bike-Share-Ridership-Forecast-and-Insights/blob/main/Annual-passholders-represent-an-increasing-segment-of-the-most-consistent-riders.png)
Breaking down total monthly ridership by passholder type reveals that the seasonal trend in ridership is largely driven by monthly and day passholders rather than annual passholders. This can be attributed to the fact that annual passholders primarily rely on Indego for transportation purposes, as they take about a quarter of the round trips that day passholders do. Day passholders have the largest round trip percentage at 19.4%, followed by monthly passholders at 7.8% and annual passholders at 4.4%.

![Parks & Trails](https://github.com/GibsonHurst/Indego-Bike-Share-Ridership-Forecast-and-Insights/blob/main/philadelphia-s-parks-trails-attract-the-highest-share-of-out-and-back-recreational-indego-bike-riders.png)

Ten of the top 14 stations with the highest percentage of trips starting and ending at the same location are situated near or within Philadelphia’s parks and trails. For example, the Manayunk Bridge station, located along the Cynwyd Heritage Trail and near the Schuylkill River Trail, sees 64.4% of trips both starting and ending at the station, rather than concluding at another location.

**Recommendation #4:**  The increase in the percentage of round trips during the summer, on weekends, during the COVID-19 lockdown, among day pass holders, and near Philadelphia’s parks and trails makes this an effective metric for measuring recreational activity within the Indego system. By adopting this metric, Indego can better segment recreational and transportation use of the system, enabling more tailored improvements, maintenance, marketing, and messaging.

The Indego Bike Share program continues to serve as a critical transportation and recreational resource for Philadelphia residents and visitors alike. This analysis highlights remarkable growth in ridership, seasonal trends, rider preferences, and demand patterns which reveal actionable opportunities for improving system efficiency and user satisfaction.

By addressing the demand for electric bikes, optimizing maintenance schedules, and offering targeted promotions during low-ridership periods, Indego can enhance its service offerings while fostering ridership growth. Additionally, leveraging round-trip metrics as a proxy for recreational activity provides a valuable tool for monitoring and tailoring the system to meet diverse user needs.

As Indego expands, these insights and recommendations can guide both strategic investments and operational improvements, ensuring that the program remains a cornerstone of sustainable, equitable transportation in Philadelphia.

## Technical Notes

### Data Source

- Indego Trip Data -  [https://www.rideindego.com/about/data/](https://www.rideindego.com/about/data/)

### Tools

- PostgreSQL & pgAdmin4: Used for data storage, joins, geospatial calculations, queries for data analysis, and other transformations.

- Python: Used for data cleaning, ridership time series analysis, and ridership forecasting.
	- Pandas & Numpy: data cleaning
	- Prophet: model training, forecasting
	- Statsmodels: autocorrelation analysis, partial autocorrelation analysis, Augmented Dickey-Fuller test for stationary, Runs test for independence, Shapiro-Wilk test for normality
	- Matplotlib: plotting of ACF, PACF, time series, residuals, histograms, qq-plots, and forecast
	- Sklearn: train test split, model evaluation metrics

- Datawrapper & Excel: Used for data visualization and organization of SQL outputs

### Ridership Time Series Forecast
![Forecast](https://github.com/GibsonHurst/Indego-Bike-Share-Ridership-Forecast-and-Insights/blob/main/prophet_forecast.png)

Monthly and yearly totals of the daily ridership outputs from the forecasting model were used to develop the data visualizations throughout the report.

This forecasting model has a Mean Absolute Percentage Error (MAPE) of 24% on one year of unseen testing data. This means that, on a given day, the forecasted number of daily trips is typically off by 24%—either above or below the true ridership—which is considered good. We are 95% confident that the true ridership will fall within the confidence interval shown above.

### Dataset Structure

Indego Trip Table – 5,963,709 instances between Q1 2018 and Q3 2024

- trip_id: Locally unique integer that identifies the trip
- duration: Length of trip in minutes
- start_time: The date/time when the trip began
- end_time: The date/time when the trip ended
- start_station: The station ID where the trip originated
- start_lat: The latitude of the station where the trip originated
- start_lon: The longitude of the station where the trip originated
- end_station: The station ID where the trip terminated
- end_lat: The latitude of the station where the trip terminated
- end_lon: The longitude of the station where the trip terminated
- bike_id: Locally unique integer that identifies the bike
- plan_duration: The number of days that the plan the passholder is using entitles them to ride; 0 is used for a single ride plan (Walk-up)
- trip_route_category: “Round Trip” for trips starting and ending at the same station or “One Way” for all other trips
- passholder_type: The name of the passholder’s plan
- bike_type: The kind of bike used on the trip, including standard pedal-powered bikes or electric assist bikes

Indego Stations Table
- station_id: Unique integer that identifies the station
- station_name: The public name of the station
- station_go_live_date: The date that the station was first available
- station_status: “Active” for stations available or “Inactive” for stations that are not available as of 2024-07-01
