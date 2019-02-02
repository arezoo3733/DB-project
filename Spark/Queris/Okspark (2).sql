import time
start=time.time()

fregion = region.filter("R_NAME == 'EUROPE' ").join(nation, region.R_REGIONKEY == nation.N_REGIONKEY).join(supplier, nation.N_NATIONKEY == supplier.S_NATIONKEY).join(partsupp, supplier.S_SUPPKEY == partsupp.PS_SUPPKEY)
fpart = part.filter("P_SIZE == 50" ).filter(part.P_TYPE.like("%NICKEL")).join(fregion, fregion.PS_PARTKEY == part.P_PARTKEY)
minCost = fpart.groupBy(fpart.PS_PARTKEY).agg(F.min(fpart.PS_SUPPLYCOST).alias('min'))

res=fpart.join(minCost, fpart.PS_PARTKEY == minCost.PS_PARTKEY).filter(fpart.PS_SUPPLYCOST == minCost.min).select("S_ACCTBAL", "S_NAME", "N_NAME", "P_PARTKEY", "P_MFGR", "S_ADDRESS", "S_PHONE", "S_COMMENT").sort(fpart.S_ACCTBAL.desc(), "N_NAME", "S_NAME", fpart.P_PARTKEY).limit(100).show()

end=time.time()
total_time = end - start
print(total_time )


