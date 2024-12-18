{{
  config(
    materialized = 'incremental',
    on_schema_change='sync_all_columns',
    unique_key='host_id'
    )
}}

WITH src_hosts AS (
    SELECT * FROM
            {{ref('src_hosts')}}
)

SELECT
    host_id,
    NVL(host_name, 'Anonymous') as host_name,
    is_superhost,
    created_at,
    updated_at,
    CURRENT_TIMESTAMP AS audit_datetime    
FROM
    src_hosts

{% if is_incremental() %}
    WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }})
{% endif %}