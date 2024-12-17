WITH raw_hosts AS (
    SELECT
        *
    FROM
    --    AIRBNB.RAW.raw_hosts
    {{ source('airbnb', 'hosts')}}

)
SELECT
    id AS host_id,
    NAME AS host_name,
    is_superhost,
    created_at,
    updated_at,
    CURRENT_TIMESTAMP AS audit_datetime
FROM
    raw_hosts