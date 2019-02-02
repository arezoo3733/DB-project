import time
start=time.time()

fpart=part.join(lineitem, part.P_PARTKEY == lineitem.L_PARTKEY ).filter("l_shipdate > '1994-10-01'").filter("l_shipdate <= '1994-11-01'").select(part.P_TYPE, (lineitem.L_EXTENDEDPRICE *(1-lineitem.L_DISCOUNT)).alias('promo_revenue'))
res=fpart.agg(F.sum(F.when(fpart.P_TYPE.like("PROMO%"), fpart.promo_revenue).otherwise(0)) * 100/ F.sum(fpart.promo_revenue))
res.show()

end=time.time()
total_time = end - start
print(total_time)

