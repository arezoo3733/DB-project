import time
start=time.time()

flineitem = lineitem.filter("L_SHIPDATE >= '1994-01-01'").filter("L_SHIPDATE < '1998-01-01'").groupBy('L_PARTKEY', 'L_SUPPKEY').agg((F.sum('L_QUANTITY') * 0.5).alias('sum_quantity'))
fnation = nation.filter("N_NAME == 'CANADA'")
nat_supp = supplier.select('S_SUPPKEY', 'S_NAME', 'S_NATIONKEY', 'S_ADDRESS').join(fnation, supplier.S_NATIONKEY == fnation.N_NATIONKEY)
res1 = part.filter(part.P_NAME.like("%forest")).select('P_PARTKEY').distinct().join(partsupp, part.P_PARTKEY == partsupp.PS_PARTKEY).join(flineitem, (partsupp.PS_PARTKEY == flineitem.L_PARTKEY) & (partsupp.PS_SUPPKEY == flineitem.L_SUPPKEY))
res2 = res1.filter(res1.PS_AVAILQTY > 'sum_quantity').select(res1.PS_SUPPKEY).distinct()
query = res1.join(nat_supp, res2.PS_SUPPKEY == nat_supp.S_SUPPKEY).select(nat_supp.S_NAME, nat_supp.S_ADDRESS).sort(nat_supp.S_NAME).show() 

end=time.time()
total_time = end - start
print(total_time )
