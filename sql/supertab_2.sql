SELECT

-- TAB2
tab_2.date,
tab_2.account_id,		
tab_2.campaign_id,		
tab_2.campaign_name,		
tab_2.adset_id,		
tab_2.adset_name,		
tab_2.ad_id,		
tab_2.ad_name,		
tab_2.ad_type,		
tab_2.device,		
tab_2.spend,		
tab_2.clicks,		
tab_2.imps,		
tab_2.conversions,
tab_2.provider,
tab_2.network,
tab_2.adset_group,
-- TAB3
tab_4.headline1,		
tab_4.headline2,		
tab_4.headline3,		
tab_4.description,		
tab_4.final_url,		
tab_4.path1,		
tab_4.path2,		
tab_4.text

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
CASE WHEN campaign_name like '%_CN%' THEN 'Platform 2' ELSE NULL END AS provider,
CASE WHEN campaign_name like '%_CN%' THEN 'channel 2' ELSE NULL END AS network,
CASE WHEN adset_name like '%|%' THEN regexp_substr(adset_name, '[^|]+') ELSE NULL END AS adset_group
FROM
improvado_jaffet_leon.table_2
) as tab_2

LEFT JOIN
(
SELECT
*
FROM
improvado_jaffet_leon.table_4
) as tab_4
ON tab_2.ad_id = tab_4.ad_id and tab_2.account_id = tab_4.account_id and tab_2.campaign_id = tab_4.campaign_id and tab_2.adset_id = tab_4.adset_id