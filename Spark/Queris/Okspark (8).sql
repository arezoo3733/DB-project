
import time
start=time.time()

fregion = region.filter("r_name == 'ASIA'")
forder = orders.filter("o_orderdate <= '1996-12-31' ").filter(" o_orderdate >= '1995-01-01' ")
fpart = part.filter(part.P_TYPE == 'ECONOMY ANODIZED STEEL')
res1 = nation.join(supplier, nation.N_NATIONKEY == supplier.S_NATIONKEY)
res2 = lineitem.select('L_PARTKEY', 'L_SUPPKEY', 'L_ORDERKEY', (lineitem.L_EXTENDEDPRICE *(1-lineitem.L_DISCOUNT)).alias('volume')).join(fpart, lineitem.L_PARTKEY == fpart.P_PARTKEY).join(res1, lineitem.L_SUPPKEY == res1.S_SUPPKEY)
res = nation.join(fregion, res1.N_REGIONKEY == fregion.R_REGIONKEY).select('N_NATIONKEY').join(customer, res1.N_NATIONKEY == customer.C_NATIONKEY).select('C_CUSTKEY').join(forder, customer.C_CUSTKEY == forder.O_CUSTKEY).select('O_ORDERKEY', 'O_ORDERDATE').join(res2, forder.O_ORDERKEY == res2.L_ORDERKEY).select(forder.O_ORDERDATE.substr(0,4).alias('o_year'), 'volume', F.when(res1.N_NAME.like("BRAZIL%"), res2.volume).otherwise(0).alias('case_volume')).groupBy('o_year').agg(F.sum('case_volume') / F.sum(res2.volume)).sort('o_year')
res.show()

end=time.time()
total_time = end - start
print(total_time)
