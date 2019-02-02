import time
start=time.time()

fjoin = nation.filter("n_name = 'INDIA'").join(supplier, nation.N_NATIONKEY == supplier.S_NATIONKEY).join(partsupp, supplier.S_SUPPKEY == partsupp.PS_SUPPKEY).select(partsupp.PS_PARTKEY,(partsupp.PS_SUPPLYCOST * partsupp.PS_AVAILQTY).alias('value'))

totVal=fjoin.agg(F.sum('value').alias('total_value'))
tmp=fjoin.groupBy(fjoin.PS_PARTKEY).agg(F.sum('value').alias('partVal'))
tmp.join(totVal,tmp.partVal > (totVal.total_value * 0.0001)).sort(['partVal'],ascending=[0]).show()

end=time.time()
total_time = end - start
print(total_time )



