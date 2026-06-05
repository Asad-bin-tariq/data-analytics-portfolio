# NYC Airbnb Relational Database Architecture & Market Analytics

## Technical Objective
Raw transaction files naturally possess deep structural flaws, including extensive string duplication, high data redundancy, and a high footprint risk for operational update anomalies. This project systematically standardizes a flat dataset of ~49,000 real-world transaction rows into an optimized relational schema engineered on Google BigQuery.

## Relational Architecture Strategy (3NF Normalization)
The flat dataset was programmatically segmented into normalized entity layers to maximize querying performance and minimize storage requirements:
* **Dimension Tables:** Built localized entity arrays for `Hosts` (collapsing recurring profiles), `Neighborhoods` (structuring geographic strings), and `RoomTypes` (utilizing `ROW_NUMBER() OVER` logic to assign strict numeric surrogate keys).
* **Fact Architecture & Extensions:** Anchored a central `Listings` fact table connected to operational extensions (`Pricing`, `LocationDetails`, `BookingPolicies`, `ReviewMetrics`) via clear primary (`_PK`) and foreign key (`_FK`) constraints.

## Advanced Data Engineering Features Evaluated
* **Relational Integrity Audits:** Deployed deep `FULL OUTER JOIN` scripts specifically targeting query unmatched records (`WHERE l.name IS NULL OR rm.number_of_reviews IS NULL`) to identify and resolve underlying platform data leakage or orphan profiles.
* **Portfolio Concentration Mapping:** Applied analytical metrics grouping along conditional `HAVING` matrices to isolate institutional market operators (hosts maintaining portfolios greater than 10 properties).
* **Cross-Entity Subquery Pipelines:** Built layered, nested subquery expressions to evaluate market signals, such as pulling high-value hosts running properties priced above $5,000/night or extracting listings outperforming standard regional engagement baselines by 5x.

## Directory Structure
```text
project1-nyc-airbnb-sql/
├── 01_table_DDL_3NF.sql           # Database initialization, table definitions, and 3NF configurations
├── 02_joins_and_data_audits.sql    # Verification matrix queries (Inner, Left, Right, Full Outer Joins)
├── 03_market_intelligence_queries.sql # Combined script hosting aggregations, GROUP BYs, HAVING filters, and subqueries
└── README.md                       # Comprehensive structural engineering documentation
