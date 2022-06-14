SELECT
MIN(super.date) AS campaign_start_date,
MAX(super.date) AS campaign_end_date,
SUM(spend) spend,
SUM(clicks) clicks,
SUM(imps) impressions,
SUM(conversions) conversions,
super.date,
provider,
network,
account_id,
device,
LOWER(regexp_substr(campaign_name, r'\|(.+?)\_')) AS campaign_name_short,
regexp_substr(campaign_name, r'BR(.+?)\_FF') AS brand,
regexp_EXTRACT(campaign_name, r'\_FF(.*)') AS free_field,
adset_name,
adset_group,
ad_type,
CONCAT(headline1,'|',headline2,"|",headline3) as ad_name,
CONCAT(NET.REG_DOMAIN(final_url),"/",path1) as display_path

FROM(
SELECT *
FROM
improvado_jaffet_leon.supertab_1

UNION ALL


SELECT *
FROM
improvado_jaffet_leon.supertab_2
where row_num =1
) super


GROUP BY

7,8,9,10,11,12,13,14,15,16,17,18,19