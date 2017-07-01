--проверка товарооборота партнеров по месяцам
select  bwyt.date_year, bwyt.date_month, Sum(cast(bwyt.value_partner as numeric)) , bwyc.partner_name
from  y_customers as ycst
left join bw_y_turnovers as bwyt on bwyt.code_bw = ycst.code_bw
left join bw_y_customers as bwyc on bwyc.code_bw = ycst.code_bw 
where  bwyc.partner_id is not null --  salon_id = '195'
group by  bwyt.date_year, bwyt.date_month, bwyc.partner_name
order by bwyt.date_year, bwyt.date_month


