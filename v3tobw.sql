--выгрузка привязок и изменений
with region_sr as (
select 
rgn.id, rgn.name as ter_name, brd."name" as brand, rgn.code as ter_code, rgn.status as ter_status, 
	(select usr.first_name || ' ' || usr.last_name 
	 from users as usr  
	 left join user_posts as usp on rgn.user_post_id = usp.id 
	 where usp.user_id  = usr.id) as srep_name,
rgn1.name as reg_name, rgn1.code as reg_code, rgn1.status as reg_status, 
	(select usr.first_name || ' ' || usr.last_name 
	 from users as usr  
	 left join user_posts as usp on rgn1.user_post_id = usp.id 
	 where usp.user_id  = usr.id) as asm_name,
rgn2.name as mreg_name, rgn2.code as mreg_code, rgn2.status as mreg_status, 
	(select usr.first_name || ' ' || usr.last_name 
	 from users as usr  
	 left join user_posts as usp on rgn2.user_post_id = usp.id 
	 where usp.user_id  = usr.id) as dr_name
from regions as rgn
left join regions as rgn1 on rgn.parent_id = rgn1.id
left join regions as rgn2 on rgn1.parent_id = rgn2.id
left join brands as brd on rgn.brand_id = brd.id
where rgn.region_level = 6 and rgn.structure_type = 1)
select 1200, 1200, 2,
(case rgu.brand 
	when 'loreal' then 23 
	when 'matrix' then 24
	when 'kerastase' then 20
	when 'redken' then 26
	when 'decleor' then 47
	when 'carita' then 46 end),
bwcst.code_bw, 
cast(sln.code_loreal as numeric), 
rgu.ter_code, rgu.ter_name, sln."name" ||'. '|| sln.address || '. ' || sln.city as salon_name, '',  sln.city,
sln.id, slt."name",
'', '', '', '', '', '', '', '', '', '', '', 5, 'TERR', 'RU', 'Russia',
 (case when left(bwcst.code_loreal, 1) = 'Y' or sln.id is Null then 'Y' else  (case when bwcst.code_loreal <> '0'|| sln.code_loreal then 'no_match' else 'match' end) end) as status_code_loreal,*
from  bw_y_customers as bwcst
left join y_customers as cst on bwcst.code_bw = cst.code_bw
left join salons as sln on sln.id = cst.salon_id
left join salon_types as slt on sln.salon_type_id = slt.id
left join regions_salons as rgs on sln.id = rgs.salon_id
left join region_sr as rgu on rgs.region_id = rgu.id
--where sln.id is null
order by sln.id