
import time
start=time.time()

revenue = lineitem.filter("l_shipdate >= '1994-10-01'" ).filter("l_shipdate < '1995-01-01'").groupBy('l_suppkey').agg(F.sum(lineitem.L_EXTENDEDPRICE*(1-lineitem.L_DISCOUNT)).alias('total'))
max=revenue.agg(F.max('total').alias('max_total'))
tmp=max.join(revenue,max.max_total == revenue.total)
tmp.join(supplier, tmp.l_suppkey  == supplier.S_SUPPKEY).sort('s_suppkey').show() 

end=time.time()
total_time = end - start
print(total_time )
