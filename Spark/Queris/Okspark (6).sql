
import time
start=time.time()

flineitem=lineitem.filter("l_shipdate >= '1994-01-01'").filter("l_shipdate < '1995-01-01'").filter('l_discount>=0.04').filter('l_discount<=0.06').filter('l_quantity < 24')
flineitem.agg(F.sum(flineitem.L_EXTENDEDPRICE * flineitem.L_DISCOUNT).alias("revenue")).show()
	
end=time.time()
total_time = end - start
print(total_time )
