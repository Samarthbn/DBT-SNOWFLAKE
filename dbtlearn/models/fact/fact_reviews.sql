{{
  config(
    materialized = 'incremental',
    on_schema_change='fail'
    )
}}


WITH src_reviews AS (
  SELECT * FROM {{ ref('src_reviews') }}
)
SELECT * FROM src_reviews
WHERE review_text is not null

{% if is_incremental() %}
  AND review_date > (select max(review_date) from {{ this }})
{% endif %}

-- This is a Jinja conditional block used by dbt
-- If it is incremental, append this statement at the end of the sql stmt.
--{{ this }} is a dbt Jinja expression that refers to the current model

--The condition ensures that only the new reviews (those with a review_date greater than the maximum date already in the target table) are included in the result.