Date: Tue, 12 Jul 2005 12:46:40 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200507121746.j6CHkePX004477@faith.austin.ibm.com>
To: SELinux@tycho.nsa.gov
Subject: port and address caches
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

My colleague implemented port and ipaddress caches 
in security_port_sid() and security_node_sid(). 
I ran a few benchmark tests as indicated below. 
The reaim benchmark is the only one that I
know contains networking tests. The 16-way with the cache changes
indicate some performance improvement. I am currently working 
on a testcase that will somewhat exercise the use of ports and/or
ipaddresses. Hopefully this will better indicate an improvement.

4way is an xSeries 350 with Pentium III, 4cpus, 700MHz 
16way is a pSeries, POWER4+(gq), 16cpus, 1703MHz

		4way-noselinux	             |  16way-noselinux
------------------------------------------------------------------------------
dbench	     376.455900 +- 2.467747	     | 1718.965400 +- 14.865441
tbench	     41.996104 +- 0.040601	     | 177.169960 +- 4.920701
kernbench    92.128000 +- 0.155041	     | 51.648000 +- 0.130161
reaim 1.     54245.452000 +- 1602.095192     | 125460.000000 +- 6922.200918
      3.     151823.077000 +- 2662.384795    | 361080.000000 +- 13844.401836
      5.     139263.695000 +- 3701.953136    | 571200.000000 +- 37679.689215
      7.     186472.529000 +- 4740.855753    | 828240.000000 +- 43071.472380
      9.     171836.393000 +- 4914.306920    | 1009800.000000 +- 69222.009182
     11.     186213.895000 +- 5088.933321    | 1234200.000000 +- 84604.677889
     13.     185644.266000 +- 4466.153424    | 1379040.000000 +- 79989.877276
     15.     191924.347000 +- 5481.351800    | 1442571.428000 +- 80742.191701
					     |
					     |
		4way-selinux  		     |	16way-selinux
------------------------------------------------------------------------------
dbench	     356.687920 +- 3.427899	     | 1555.935800 +- 20.199988
tbench       36.664890 +- 0.023621	     | 147.831740 +- 4.032795
kernbench    96.881000 +- 0.177305	     | 53.814000 +- 0.158717
reaim 1.     45776.702000 +- 1601.515981     | 106080.000000 +- 6153.067483
      3.     130268.574000 +- 1977.772337    | 342720.000000 +- 22607.813529
      5.     129163.044000 +- 1915.550702    | 502714.286000 +- 16481.430111
      7.     162464.205000 +- 4161.505992    | 683400.000000 +- 35246.121870
      9.     155945.104000 +- 5576.264093    | 852428.570000 +- 49444.293350
     11.     168403.747000 +- 3130.101412    | 1009800.003000 +- 55386.761457
     13.     163507.375000 +- 3621.656254    | 1122364.287000 +- 32138.790300
     15.     168243.771000 +- 3227.119768    | 1163892.857000 +- 37083.218881
					     |
 					     |
4way-cache-selinux			     |	16way-cache-selinux
-----------------------------------------------------------------------------
dbench	     357.095700 +- 5.042664	     | 1570.762200 +- 14.629696
tbench 	     37.386828 +- 0.028031	     | 149.319380 +- 2.510676
kernbench    97.110000 +- 0.099581	     | 53.742000 +- 0.199270
reaim 1.     45059.342000 +- 1242.184837     | 114822.857000 +- 9177.130312
					     |(114822.857000 +- 9177.130312)
      3.     129553.249091 +- 2542.720421    | 336600.000000 +- 23074.003061
					     |(324360.000000 +- 21147.673122)
      5.     133955.777000 +- 8591.698066    | 520200.000000 +- 23074.003061
					     |(520200.000000 +- 23074.003061) 
      7.     161541.847000 +- 6569.524478    | 714000.000000 +- 0.000000
					     |(714000.000000 +- 0.000000)
      9.     153761.123000 +- 5336.480442    | 918000.000000 +- 0.000000
					     |(918000.000000 +- 0.000000)
     11.     163268.492000 +- 4944.742131    | 1089942.858000 +- 48345.528929
					     |(1073914.287000 +- 55386.761457)
     13.     163184.442000 +- 3797.730103    | 1231285.715000 +- 71419.532744
					     |(1231285.715000 +- 71419.532744)
     15.     168201.899000 +- 2589.588903    | 1398857.142000 +- 80742.191701
					     |(1355142.856000 +- 65925.723461)

***Note: numbers in parenthesis were a result of a second run to
verify results in reaim tests 16way with port cache changes.

Regards,
Joy Latten

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
