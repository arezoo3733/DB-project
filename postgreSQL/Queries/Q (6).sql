-- $ID$
-- TPC-H/TPC-R Forecasting Revenue Change Query (Q6)
-- Functional Query Definition
-- Approved February 1998
:x
:o
\o  /root/pst-arezoo/q6.txt
EXPLAIN ANALYZE
select sum(l_extendedprice * l_discount) as revenue from lineitem where l_shipdate >= date '1994-01-01' 	and l_shipdate < date '1994-01-01' + interval '1' year and l_discount between 0.05 - 0.01 and 0.05 + 0.01 and l_quantity < 24;

