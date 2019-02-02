
import time
start=time.time()

linePart = part.filter(part.P_NAME.like('%hot%')).join(lineitem, part.P_PARTKEY == lineitem.L_PARTKEY)

Supnat = nation.join(supplier,nation.N_NATIONKEY== supplier.S_NATIONKEY)

res1=linePart.join(Supnat,linePart.L_SUPPKEY == Supnat.S_SUPPKEY).join(partsupp, (linePart.L_SUPPKEY == partsupp.PS_SUPPKEY) & (linePart.L_PARTKEY == partsupp.PS_PARTKEY))
res2=res1.join(orders, res1.L_ORDERKEY == orders.O_ORDERKEY).groupBy(res1.N_NAME,F.substring(orders.O_ORDERDATE,0,4).alias('o_year'))
res3=res2.agg(F.sum(linePart.L_EXTENDEDPRICE * (1 - linePart.L_DISCOUNT) - (partsupp.PS_SUPPLYCOST * linePart.L_QUANTITY) ).alias('sum_profit'))
res3.sort(['n_name', 'o_year'],ascending=[1,0]).show()

end=time.time()
total_time = end - start
print(total_time )


