import time
start=time.time()

fparts = part.filter(part.P_BRAND != 'Brand#23').filter(~ part.P_TYPE.like("MEDIUM POLISHED%")).filter(part.P_SIZE.isin([38, 23, 15, 9, 28, 42, 12, 49])).select('P_PARTKEY', 'P_BRAND', 'P_TYPE', 'P_SIZE')
res1 = supplier.filter(supplier.S_COMMENT.like("%Customer%Complaints%")).join(partsupp, supplier.S_SUPPKEY == partsupp.PS_SUPPKEY).select('PS_PARTKEY', 'PS_SUPPKEY')
res=res1.join(fparts, res1.PS_PARTKEY == fparts.P_PARTKEY).groupBy('P_BRAND', 'P_TYPE', 'P_SIZE').agg(F.countDistinct('ps_suppkey').alias('supplier_count')).sort(F.desc('supplier_count'), 'P_BRAND', 'P_TYPE', 'P_SIZE')
res.show()

end=time.time()
total_time = end - start
print(total_time )
