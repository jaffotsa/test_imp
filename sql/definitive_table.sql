SELECT

campaign_start_date,
campaign_end_date,
spend,
clicks,
impressions,
conversions,
super.date,
provider,
network,
account_id,
device,
campaign_name_short,
brand,
free_field,
adset_name,
adset_group,
ad_type,
ad_name,
display_path,
sessions,
users,
new_users,
page_views

FROM(
  SELECT
  *
  FROM
  improvado_jaffet_leon.summed_supertabs
) super


LEFT JOIN(
  SELECT
  *,
ROW_NUMBER() OVER (
  PARTITION BY 
                date,
                utm_source,
                campaign
            ORDER BY 
                date,
                utm_source,
                campaign) row_num
  FROM
  improvado_jaffet_leon.table_5
) tab_5
ON tab_5.date = super.date AND tab_5.utm_source = super.provider AND tab_5.campaign = super.campaign_name_short

where row_num = 1