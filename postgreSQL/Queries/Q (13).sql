-- $ID$
-- TPC-H/TPC-R Customer Distribution Query (Q13)
-- Functional Query Definition
-- Approved February 1998
:x
:o
\o  /root/pst-arezoo/q13.txt
EXPLAIN ANALYZE
select c_count,count(*) as custdist from (select c_custkey, count(o_orderkey) from customer left outer join orders on c_custkey = o_custkey and o_comment not like '%unusual%requests%' group by c_custkey) as c_orders (c_custkey, c_count)group by c_count order by custdist desc,c_count desc;

