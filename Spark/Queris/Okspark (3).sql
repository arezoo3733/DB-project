
import time
start=time.time()

fcust = customer.filter("c_mktsegment = 'HOUSEHOLD'")
forders = orders.filter("o_orderdate < '1995-03-10'")
flineitem = lineitem.filter("l_shipdate > '1995-03-10'")
fjoin1=fcust.join(forders,fcust.C_CUSTKEY == forders.O_CUSTKEY)
fjoin1.join(flineitem, fjoin1.O_ORDERKEY == flineitem.L_ORDERKEY).groupBy('l_orderkey','o_orderdate','o_shippriority').agg(F.sum(lineitem.L_EXTENDEDPRICE*(1-lineitem.L_DISCOUNT)).alias('revenue')).orderBy(['revenue', 'o_orderdate'], ascending=[0, 1]).limit(10).show()

end=time.time()
total_time = end - start
print(total_time )
