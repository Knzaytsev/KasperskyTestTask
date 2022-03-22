with last_notification as (
	select 
	[user]
	, product
	, splitted_components
	, concat(product_version_major, '.', product_version_minor, '.', product_version_build, '.', product_version_revision) as [Version]
	, MAX([datetime]) as max_datetime 
	from test_components 
	group by [user], product, splitted_components, concat(product_version_major, '.', product_version_minor, '.', product_version_build, '.', product_version_revision)
)

select 
COUNT(distinct [user]) as "Unique user count"
, splitted_components as "Component set"
, Product
, [Version]
from last_notification
where splitted_components is not NULL
group by product, splitted_components, [Version]
order by "Unique user count" desc;