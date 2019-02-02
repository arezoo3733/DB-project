
import time
start=time.time()

forders = orders.filter("o_orderdate >= date '1994-01-01'").filter("o_orderdate < date '1995-01-01'")

fjoin1=region.filter("r_name = 'EUROPE'").join(nation,region.R_REGIONKEY == nation.N_REGIONKEY).join(supplier, nation.N_NATIONKEY == supplier.S_NATIONKEY).join (lineitem,supplier.S_SUPPKEY == lineitem.L_SUPPKEY)                                                                                                                                           

fjoin1.join(forders, fjoin1.L_ORDERKEY == forders.O_ORDERKEY).join(customer, (fjoin1.S_NATIONKEY == customer.C_NATIONKEY) & (forders.O_CUSTKEY == customer.C_CUSTKEY)). groupBy('n_name').agg(F.sum(lineitem.L_EXTENDEDPRICE*(1-lineitem.L_DISCOUNT)).alias('revenue')).sort('revenue').show()   

end=time.time()
total_time = end - start
print(total_time )

