import time
start=time.time()

forders = orders.filter("O_ORDERDATE >= '1996-08-01' ").filter("O_ORDERDATE < '1996-11-01' ")
flineitems = lineitem.filter("L_COMMITDATE < L_RECEIPTDATE").select('L_ORDERKEY').distinct()
flineitems.join(forders, flineitems.L_ORDERKEY == forders.O_ORDERKEY).groupBy(forders.O_ORDERPRIORITY).agg( F.count(forders.O_ORDERPRIORITY)).sort(forders.O_ORDERPRIORITY).show()

end=time.time()
total_time = end - start
print(total_time )



