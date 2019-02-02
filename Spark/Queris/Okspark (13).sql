
import time
start=time.time()

forder=orders.filter(~ orders.O_COMMENT.like('%unusual%requests%'))
customer.join(forder, customer.C_CUSTKEY == forder.O_CUSTKEY , "left_outer").groupBy('o_custkey').agg(F.count('o_orderkey').alias('c_count')).groupBy('c_count').agg(F.count('o_custkey').alias('custdist')).sort(['custdist','c_count'],ascending=[0,0]).show()

end=time.time()
total_time = end - start
print(total_time )
