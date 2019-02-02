import time
start=time.time()

lineitem.groupBy('L_ORDERKEY').agg(F.sum('L_QUANTITY').alias('sum_quantity')).filter("sum_quantity > 313 ").select(lineitem.L_ORDERKEY, 'sum_quantity').join(orders, lineitem.L_ORDERKEY == orders.O_ORDERKEY).join(customer, customer.C_CUSTKEY == orders.O_CUSTKEY).select('sum_quantity','C_NAME', 'C_CUSTKEY', 'C_CUSTKEY', 'O_ORDERKEY', 'O_ORDERDATE', 'O_TOTALPRICE').groupBy('C_NAME', 'C_CUSTKEY', 'O_ORDERKEY', 'O_ORDERDATE', 'O_TOTALPRICE').agg(F.sum('sum_quantity')).sort(orders.O_TOTALPRICE.desc(), orders.O_ORDERDATE).limit(100).show()

end=time.time()
total_time = end - start
print(total_time )

