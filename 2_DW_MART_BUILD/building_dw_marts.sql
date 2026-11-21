--duckdb dw_marts.duckdb -c ".read building_dw_marts.sql"

-- Step 1: DW - Creating Star schema tables
.read 01_create_tables_dw.sql

--Step 2: DW — Load data from CSV files into tables
.read 02_loading_DW.sql

--Step 3: Mart — Create flat mart
.read 03_create_flat_mart.sql