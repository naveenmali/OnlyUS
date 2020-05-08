-- CREATE database raw;
-- CREATE database intermediate;
-- CREATE database final;

-- ------------------------------------------------------------------
-- Queries for no of rows in each table
select count(*) from raw.orderinformation o;-- 3051
select count(*) from raw.dailypayroll d ; -- 139
select count(*) from raw.menuitemstats m ;-- 40
select count(*) from raw.payroll p ;-- 139
select count(*) from raw.summaryitems s ;-- 399
select count(*) from raw.summarysales s ;-- 17
select count(*) from raw.summarytransactions s ;-- 1547
---- ------------------------------------------------------------------
select * from raw.orderinformation o;-- 3051
select * from raw.dailypayroll d ; -- 139
select * from raw.menuitemstats_v2 mv  ;-- 40
select * from raw.payroll p ;-- 139
select * from raw.summaryitems s ;-- 399
select * from raw.summarysales s ;-- 17
select * from raw.summarytransactions s ;-- 1547
---------------------------------------------------------------------------------
-- cleaning table 
create table menuitemstats_v2 as
select replace( replace (substring_index(`Store Name` ,'-',-1),'0',''),')','') as parsed_storeid,m.* from menuitemstats m 
--------------------------------------------------------------------------------------------

-- intermediate table 


select * from (
select *,coalesce(mv.parsed_storeid,sm.Store_ID) as final_store_id  from menuitemstats_v2 mv 
right join summaryitems sm 
on mv.`Menu Category ID` =sm.Category_ID 
and mv.parsed_storeid = sm.Store_ID  and mv.`Menu Item ID` =sm.Menu_Item_Id
) t1
left join summarysales ss on t1.final_store_id =ss.`Store ID` 

-- miscellaneous queries 
create table newtab as 

select `Franchise ID` ,parsed_storeid ,`Store Name` ,`Menu Item ID` ,`Menu Category ID` ,
`Menu Category Name` ,`Menu Display` ,`Total Dollars` ,`Total Qty` ,`Menu Price` ,ss.`Date` ,
ss.`Net Sales` as Total_sales ,ss.Tax from (
select *,coalesce(mv.parsed_storeid,sm.Store_ID) as final_store_id  from menuitemstats_v2 mv 
right join summaryitems sm 
on mv.`Menu Category ID` =sm.Category_ID 
and mv.parsed_storeid = sm.Store_ID  and mv.`Menu Item ID` =sm.Menu_Item_Id
) t1
left join summarysales ss on t1.final_store_id =ss.`Store ID`






left join summarytransactions st on t1.final_store_id=st.`Store ID` 

select count(distinct `Store ID` ) from summarytransactions s2 


select count(distinct t1.parsed_storeid ) from (
select * from menuitemstats_v2 mv 
right join summaryitems sm 
on mv.`Menu Category ID` =sm.Category_ID 
and mv.parsed_storeid = sm.Store_ID  and mv.`Menu Item ID` =sm.Menu_Item_Id
) t1

select * from raw.store_menu_sales s
where `Transaction Type` ='PO'
order by final_store_id 

select * from store_menu_sales sms 
where final_store_id =1 and `Transaction Type` in ('PO') ;

select * from summarytransactions s
where `Store ID` =1

select distinct final_store_id from store_menu_sales sms 

select * from orderinformation o 
right join dailypayroll on 
o.`Employee ID` = dailypayroll.`Employee ID`
where  o.`Employee ID` =333668069


select `Employee ID` ,count(*) from dailypayroll d group by `Employee ID` having count(*) > 1;
select * from dailypayroll d where `Employee ID` = 333668069;

select `Employee ID` ,count(*) from orderinformation o2  group by `Employee ID` having count(*) > 1;
select * from orderinformation o2  where `Employee ID` = 333668069;


select * from orderinformation o;
select * from dailypayroll d ;

select count(distinct `Employee ID` ) from orderinformation o ;
select count(distinct `Employee ID` )from dailypayroll d 