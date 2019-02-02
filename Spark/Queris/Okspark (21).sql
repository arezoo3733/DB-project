
fsupplier = supplier.select('s_suppkey', 's_nationkey', 's_name')

plineitem = lineitem.select('l_suppkey', 'l_orderkey','l_receiptdate', 'l_commitdate')
   
flineitem = plineitem.filter("l_receiptdate > l_commitdate")
 
line1 = plineitem.groupBy('l_orderkey').agg(F.countDistinct('l_suppkey').alias('suppkey_count'), F.max('l_suppkey').alias('suppkey_max')).select(plineitem.l_orderkey.alias('key'),'suppkey_count', 'suppkey_max')

line2 = flineitem.groupBy('l_orderkey').agg(F.countDistinct('l_suppkey').alias('suppkey_count'), F.max('l_suppkey').alias('suppkey_max')).select(flineitem.l_orderkey.alias('key'), 'suppkey_count', 'suppkey_max')

forder = orders.select('o_orderkey', 'o_orderstatus').filter("o_orderstatus = 'F'")

fnation=nation.filter("n_name = 'CANADA'").join(fsupplier, nation.N_NATIONKEY == fsupplier.s_nationkey).join(flineitem, fsupplier.s_suppkey == flineitem.l_suppkey).join(forder, flineitem.l_orderkey == forder.o_orderkey).join(line1, flineitem.l_orderkey == line1.key).filter("suppkey_count > 1 or (suppkey_count = 1 and l_suppkey = suppkey_max)").select('s_name', 'l_orderkey', 'l_suppkey')
res=fnation.join(line2, fnation.l_orderkey == line2.key, 'left_outer').select('s_name', 'l_orderkey', 'l_suppkey', 'suppkey_count','suppkey_max').filter("suppkey_count = 1 and l_suppkey = suppkey_max").groupBy('s_name').agg(F.count('l_suppkey').alias('numwait')).sort(['numwait','s_name'],ascending=[0,1]).limit(100)
res.show()

end=time.time()
total_time = end - start
print(total_time )

