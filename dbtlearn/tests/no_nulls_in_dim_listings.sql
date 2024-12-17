{{ no_nulls_in_columns(ref('dim_listings_cleansed')) }}


-- dbt test --select dim_listings_cleansed