
import time
start=time.time()

lineitem.filter("l_shipmode == 'TRUCK' or l_shipmode == 'AIR'").filter("l_commitdate < l_receiptdate").filter("l_shipdate < l_commitdate").filter("l_receiptdate >= '1994-01-01'").filter("l_receiptdate < '1995-01-01'").join(orders, lineitem.L_ORDERKEY == orders.O_ORDERKEY).select('l_shipmode', 'o_orderpriority').groupBy('l_shipmode').agg(F.sum(F.when((orders.O_ORDERPRIORITY == '1-URGENT') | (orders.O_ORDERPRIORITY == '2-HIGH'), 1).otherwise(0).alias('high_line_count')),F.sum(F.when((orders.O_ORDERPRIORITY != '1-URGENT') | (orders.O_ORDERPRIORITY!= '2-HIGH'), 1).otherwise(0)).alias('low_line_count')).sort('l_shipmode').show()

end=time.time()
total_time = end - start
print(total_time )



