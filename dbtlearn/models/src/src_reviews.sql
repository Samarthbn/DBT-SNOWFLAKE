WITH raw_reviews AS (
    SELECT 
        * 
    FROM 
        -- AIRBNB.RAW.raw_reviews
        {{ source('airbnb', 'reviews')}}
)

SELECT 
    listing_id,
    date as review_date,
    reviewer_name,
    comments as review_text,
    sentiment as review_sentiment,
    CURRENT_TIMESTAMP AS audit_datetime
FROM
    raw_reviews