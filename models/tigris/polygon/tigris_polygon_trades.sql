{{ config(
        alias = alias('trades')
        )
}}

{% set tigris_models = [
ref('tigris_v1_polygon_trades')
,ref('tigris_v2_polygon_trades')
] %}


SELECT *
FROM (
    {% for perpetual_model in tigris_models %}
    SELECT
        blockchain,
        day,
        evt_block_time,
        evt_index,
        evt_tx_hash,
        position_id,
        price,
        new_margin,
        leverage,       
        volume_usd,
        margin_asset,
        pair,
        direction,
        referral,
        trader,
        margin_change,
        trade_type,
        version
    FROM {{ perpetual_model }}
    {% if not loop.last %}
    UNION ALL
    {% endif %}
    {% endfor %}
)
;