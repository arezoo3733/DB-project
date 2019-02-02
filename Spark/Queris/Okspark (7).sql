import time
start=time.time()

fnation = nation.filter("n_name = 'INDIA' or n_name = 'EGYPT'")
flineitem = lineitem.filter("l_shipdate >= '1995-01-01' and l_shipdate <= '1996-12-31'")

supNation = fnation.join(supplier, fnation.N_NATIONKEY == supplier.S_NATIONKEY).join(flineitem , supplier.S_SUPPKEY == flineitem .L_SUPPKEY).withColumnRenamed('n_name','supp_nation')

custNation=fnation.join(customer, fnation.N_NATIONKEY == customer.C_NATIONKEY).join(orders, customer.C_CUSTKEY == orders.O_CUSTKEY).withColumnRenamed('n_name','cust_nation')

fjoin=custNation.join(supNation ,custNation.O_ORDERKEY == supNation.L_ORDERKEY)
res1=fjoin.filter("supp_nation = 'INDIA'").filter("cust_nation = 'EGYPT'")
res2=fjoin.filter("supp_nation = 'EGYPT'").filter("cust_nation = 'INDIA'")

res1.union(res2).groupBy('supp_nation','cust_nation',F.substring(supNation.L_SHIPDATE,0,4).alias('l_year')).agg(F.sum(supNation.L_EXTENDEDPRICE*(1-supNation .L_DISCOUNT)).alias('revenue')).sort('supp_nation','cust_nation','l_year').show()

end=time.time()
total_time = end - start
print(total_time )

