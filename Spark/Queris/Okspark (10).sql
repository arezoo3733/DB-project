
import time
start=time.time()

flineitem = lineitem.filter("l_returnflag = 'R'")

orders.filter("o_orderdate < '1995-01-01' ").filter("o_orderdate >= '1994-10-01' ").join(customer, orders.O_CUSTKEY == customer.C_CUSTKEY).join(nation, customer.C_NATIONKEY == nation.N_NATIONKEY).join(flineitem, orders.O_ORDERKEY == flineitem.L_ORDERKEY).groupBy('C_CUSTKEY', 'C_NAME', 'C_ACCTBAL', 'N_NAME', 'C_ADDRESS', 'C_PHONE', 'C_COMMENT').agg(F.sum(lineitem.L_EXTENDEDPRICE*(1-lineitem.L_DISCOUNT)).alias('revenue')).sort(['revenue'], ascending=[0]).limit(20).show()

end=time.time()
total_time = end - start
print(total_time )
