SELECT
-- TAB1
tab_1.date,
tab_1.account_id,		
tab_1.campaign_id,		
tab_1.campaign_name,		
tab_1.adset_id,		
tab_1.adset_name,		
tab_1.ad_id,		
tab_1.ad_name,		
tab_1.ad_type,		
tab_1.device,		
tab_1.spend,		
tab_1.clicks,		
tab_1.imps,		
tab_1.conversions,
tab_1.provider,
tab_1.network,
tab_1.adset_group,
-- TAB 3
tab_3.headline1,		
tab_3.headline2,		
tab_3.headline3,		
tab_3.description,		
tab_3.final_url,		
tab_3.path1,		
tab_3.path2,		
tab_3.text
,
ROW_NUMBER() OVER (
  PARTITION BY 
                cast(spend as int), 
                clicks, 
                imps,
                conversions
            ORDER BY 
                spend, 
                clicks, 
                imps,
                conversions
        ) row_num


FROM
(
SELECT
*,
CASE WHEN campaign_name like '%_CN%' THEN 'Platform 1' ELSE NULL END AS provider,
CASE WHEN campaign_name like '%_CN%' THEN 'channel 1' ELSE NULL END AS network,
CASE WHEN adset_name like '%|%' THEN regexp_substr(adset_name, '[^|]+') ELSE NULL END AS adset_group
FROM
improvado_jaffet_leon.table_1
) as tab_1

LEFT JOIN
(
SELECT
*
FROM
improvado_jaffet_leon.table_3
) as tab_3
ON tab_1.ad_id = tab_3.ad_id and tab_1.account_id = tab_3.account_id and tab_1.campaign_id = tab_3.campaign_id and tab_1.adset_id = tab_3.adset_id and tab_1.date = tab_3.date