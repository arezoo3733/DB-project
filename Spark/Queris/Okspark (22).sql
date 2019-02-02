
import time
start=time.time()

fcustomer = customer.select('C_ACCTBAL', 'C_CUSTKEY', customer.C_PHONE.substr(0, 2).alias('cntrycode')).filter(F.col('cntrycode').isin(['28', '43', '22', '39', '31', '30', '41']))

avg_customer = fcustomer.filter(customer.C_ACCTBAL > 0.00).agg(F.avg(customer.C_ACCTBAL).alias('avg_acctbal'))

res1 = orders.select(orders.O_CUSTKEY).join(fcustomer, orders.O_CUSTKEY == fcustomer.C_CUSTKEY, "right_outer").filter(orders.O_CUSTKEY.isNull())
res2=res1.join(avg_customer,res1.C_ACCTBAL > avg_customer.avg_acctbal).groupBy('cntrycode').agg(F.count(fcustomer.C_ACCTBAL), F.sum(fcustomer.C_ACCTBAL)).sort('cntrycode')
res=res2.show()

end=time.time()
total_time = end - start
print(total_time )

