#New York City Restaurant Inspections Analysis

PLEASE NOTE: I am still working on documenting this project and finishing visualizations.

This project has been created after participating the DataTalksClub data engineering zoomcamp.  

##Data Description:
This data was obtained from the NYC OpenData [website](https://data.cityofnewyork.us/Health/DOHMH-New-York-City-Restaurant-Inspection-Results/43nn-pn8j/about_data)
Per the website, the data contains every violation citation from every full or special inspection for restaurants as well 
as college cafeterias for up to 3 years prior to their most recent inspection. 

Some notable information about the data includes:
* Some restaurants received more than one violation/inspection
* Only restaurants with a currently active status are included in the data
* Records are also included for restaurants that have applied for a permit, but has not yet been inspected
* There are also records included for restaurants that have not received a violation
* This data is updated daily.

##Project Objectives
The main objective of this project was to create a data pipeline, use the pipeline to load the data into a data warehouse, 
and finally, build a dashboard to visualize the data. 

Some questions that I would like to answer include:
*What are the most common violations?
*Do certain boros have more violations than one would expect based on population?


##Infrastructure
Technologies used to create this project include:
*Docker (containerization)
*Terraform (infrastructure as code)
*GCP (data lake)
*BigQuery (data warehouse)
*Mage (orchestration)
*dbt (data transformation)
*Looker (data visualization)

##Dashboard

##Ideas for Improvement

Some ideas that I have for improving this project include:
*The code could be scheduled to run and refresh more frequently. 

##How to Reproduce This Project

Please note that these instructions are based on use of a MacOS. There may be some differences with use of Windows.

###Prerequisites

*Docker
*Terraform
*GCP Account

###Project set up

1. Clone this repository
2. Enter the directory that contains the project. 
3. Setup a new GCP Project

####Terraform

4. Edit terraform variables.tf file
5. Prepare working directory with terraform init
6. Check execution plan
7. Create the infrastructure

####Mage

8. Rename dev.env to .env
9. Edit the .env file to reflect the same Project ID and bucket name that you have configured for Terraform.
10. Build the Mage docker container
11. Start the docker container. 
12. Access the web interface
13. Execute pipeline.  After Mage runs, you should see new datasets that have been created within BigQuery.




