import time
start=time.time()

fpart = part.filter(part.P_BRAND== 'Brand#34').filter(part.P_CONTAINER == 'MED BOX').select('p_partkey').join(lineitem, part.P_PARTKEY == lineitem.L_PARTKEY, 'left_outer')

fpart1=fpart.groupBy('p_partkey').agg((F.avg('l_quantity')*0.2).alias('avg_quantity')).select(fpart.p_partkey.alias('key'),'avg_quantity')

fpart1.join(fpart, fpart1.key == fpart.p_partkey).filter(fpart.L_QUANTITY < fpart1.avg_quantity).agg(F.sum(fpart.L_EXTENDEDPRICE) / 7.0).show()

end=time.time()
total_time = end - start
print(total_time )
