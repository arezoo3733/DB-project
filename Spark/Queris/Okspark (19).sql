import time
start=time.time()
sm = ["SM CASE","SM BOX","SM PACK","SM PKG"]
md = ["MED BAG","MED BOX","MED PKG","MED PACK"]
lg = ["LG CASE","LG BOX","LG PACK","LG PKG"]

pljoin= part.join(lineitem, part.P_PARTKEY == lineitem.L_PARTKEY).filter("l_shipmode = 'AIR' or l_shipmode = 'AIR REG'").filter("l_shipinstruct = 'DELIVER IN PERSON'")

fpart1=pljoin.filter("p_brand = 'Brand#34'").filter(part.P_CONTAINER.isin(sm)).filter("l_quantity >= 9").filter("l_quantity <= 19").filter("p_size >= 1").filter("p_size <= 5")

fpart2= pljoin.filter("p_brand = 'Brand#12'").filter(part.P_CONTAINER.isin(md)).filter("l_quantity >= 15").filter("l_quantity <= 25").filter("p_size >= 1").filter("p_size <= 10") 

fpart3= pljoin.filter("p_brand = 'Brand#23'").filter(part.P_CONTAINER.isin(lg)).filter("l_quantity >= 24").filter("l_quantity <= 34").filter("p_size >= 1").filter("p_size <= 15") 

res=fpart1.union(fpart2).union(fpart3)
res.agg(F.sum(res.L_EXTENDEDPRICE*(1-res.L_DISCOUNT))).alias('revenue').show()

end=time.time()
total_time = end - start
print(total_time )
