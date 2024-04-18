# Fashion-Campus-Orders
#### Data Engineering 2024 project for DataEngineer-Zoomcamp. Developed an end-to-end data pipeline for an Indonesian e-commerce website Fashion Campus. 

Data is extracted from Kaggle - https://www.kaggle.com/datasets/latifahhukma/fashion-campus/data?select=transactions.csv

Information about the data - Fashion Campus, an e-commerce fashion company targeting "Indonesian Young Urbans" - young people aged 15-35 - was established in Indonesia in early 2016. The company offers a catalog of local and international brands popular among young people. 
Given that the data is static, the data pipeline operates as a one-time process.
The dataset contains 4 CSV files
1. Clickstream 
2. Transactions
3. Product
4. Customer

#### Goal 
Develop a data architecture from the raw data of the Fashion Campus using Google Cloud Platform. The data is extracted from Kaggle, inital data ingestion and workflow orchestration is done through Mage. Final ETL pipeline is developed in DBT. When data is stored in the warehouse i.e. Bigquery, then visualization for business is done through Looker.

#### Data Architecture of the project-

![Screenshot 2024-04-18 at 1 13 39 PM](https://github.com/rtilwalia/Fashion-Campus-Orders/assets/32938713/5df1cdc8-5e62-4dd3-ac02-debb456673ca)

#### Tools and Steps
1. **Cloud:**
   - [Google Cloud Platform (GCP)](https://cloud.google.com/?utm_source=bing&utm_medium=cpc&utm_campaign=latam-AR-all-es-dr-BKWS-all-all-trial-e-dr-1707800-LUAC0016410&utm_content=text-ad-none-any-DEV_c-CRE_-ADGP_Hybrid+%7C+BKWS+-+MIX+%7C+Txt_+GCP-General-KWID_43700067403123893-kwd-77859523038025:loc-8&utm_term=KW_Google+Cloud+Platform-ST_Google+Cloud+Platform&gclid=f110f2a74b1b1da673c894aa2e0948fa&gclsrc=3p.ds&hl=en)
     
2. **Data Ingestion (batch):**
   - [Mage](https://www.mage.ai/)
   - Batch data ingestion is done through Mage, as it makes easy to handle big data and the data gets stored in data lake in batches.

3. **Data Lake:**
   - [Google Cloud Storage](https://cloud.google.com/storage?hl=en)
   - When data is ingested and processed from Mage, it is stored in google cloud storage. As it is a cloud platform, it becomes easy to access the data for further processing.

4. **Data Transformations and Processing:**
   - [dbt](https://www.getdbt.com/)
   - DBT is used for the development of the ETL of the data. Developed staging tables for the files which are further joined into a fact table.
   - Further dimensions are created according to the requirement and then data is pushed into data warehouse in batches.
  
     ![dbt_data_architecture](https://github.com/rtilwalia/Fashion-Campus-Orders/assets/32938713/87f79833-39c4-48bf-a47a-e84b26fb30a7)


5. **Data Warehousing:**
   - [Google BigQuery](https://cloud.google.com/bigquery?hl=en)
   - Data from both dev and prod environment is stored in bigquery. This can easily help us in writing adhoc SQL scripting and also provides data for visualization in looker

6. **Dashboarding:**
   - [Google Looker Studio](https://lookerstudio.google.com/overview)
   - Check out the dashboards below
   - **Fashion Campus Order Analysis** - https://lookerstudio.google.com/u/0/reporting/bd6e5b38-1d02-4395-9b30-395046c28f68/page/OoIxD?s=kgU0Du65M1k
     
     ![image](https://github.com/rtilwalia/Fashion-Campus-Orders/assets/32938713/779e5362-294c-4da1-bc7b-f243340a5330)

   - **Fashion Campus Product Details** - https://lookerstudio.google.com/s/kQqG5WWwpHo
     
     ![Screenshot 2024-04-18 at 2 11 41 PM](https://github.com/rtilwalia/Fashion-Campus-Orders/assets/32938713/88137e22-ae61-4bda-adf2-3568a8136033)


#### Future Scope of the project
1. Creating CI/CD pipeline on DBT, so that data can be merged easily on git.
2. Developing further visualizations of clickstream to retain customers.
3. Developing further dimensions of the ETL architecture to generate niche data.



