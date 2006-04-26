Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3Q0LFCW003858
	for <selinux@tycho.nsa.gov>; Tue, 25 Apr 2006 20:21:15 -0400
Received: from e32.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3Q0LDan000590
	for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2006 00:21:14 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3Q0LDOH002856
	for <selinux@tycho.nsa.gov>; Tue, 25 Apr 2006 20:21:13 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3Q0HLs4261496
	for <selinux@tycho.nsa.gov>; Tue, 25 Apr 2006 18:17:25 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3Q0L8i6028197
	for <selinux@tycho.nsa.gov>; Tue, 25 Apr 2006 18:21:08 -0600
Subject: nethooks stress testing completed successfully
From: Joy Latten <latten@austin.ibm.com>
To: redhat-lspp@redha.com
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 25 Apr 2006 19:13:35 -0500
Message-Id: <1146010415.2498.85.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The networking hooks using IPSec were stressed with netperf
sending constant stream of tcp and udp packets.
All tests have completed successfully!

All tests had following configuration:
Pseries lpars running FC5
IPSec was configured to use:
 - ESP (Encapsulating Security Payload)
 - security label, "system_u:object_r:unlabeled_t:s0"
SELinux
 - Targeted Policy (targeted-mcs) with IPSec module
   included in base.
 - Enforcing mode

Stress Test 1
 - 24 hour run
 - IPSecv4 in transport mode
 - manual keying (setkey command)

Stress Test 2
 - 48 hour run (over the weekend)
 - IPSecv6 in transport mode
 - manual keying (setkey command)

Stress Test 3
 - 18 hour run
 - IPSecv4 in transport mode
 - dynamic keying (racoon)

Stress Test 4
 - 24 hour run
 - IPSecv4 in tunnel mode
 - manual keying

Stress Test 5
 - 24 hour run
 - IPSecv6 in tunnel mode
 - manual keying

Below is a snapshot of performance between 2 System X(xSeries) machines,
one has 4cpus and the other 8cpus.

******NOTE*****
Numbers IN parenthesis represent numbers taken for
ipsec WITHOUT labels. The number next to it without
parenthesis represent number for ipsec WITH labels.
***************

Testing with the following command line:
/opt/netperf/netperf -t TCP_STREAM -l 60 -H xxxx -i 10,3 -I 99,5 -- -s
57344 -S 57344 -m 4096

TCP STREAM TEST to xxxx : +/-2.5% @ 99% conf. : interval
Recv   Send    Send                          
Socket Socket  Message  Elapsed              
Size   Size    Size     Time     Throughput  
bytes  bytes   bytes    secs.    10^6bits/sec  

262142 114688   4096    60.02      22.87   (23.22)



------------------------------------
Testing with the following command line:
/opt/netperf/netperf -t TCP_STREAM -l 60 -H xxxx -i 10,3 -I 99,5 -- -s
32768 -S 32768 -m 4096

TCP STREAM TEST to xxxx : +/-2.5% @ 99% conf. : interval
!!! WARNING
!!! Desired confidence was not achieved within the specified iterations.
!!! This implies that there was variability in the test environment that
!!! must be investigated before going further.
!!! Confidence intervals: Throughput      :  8.2%
!!!                       Local CPU util  :  0.0%
!!!                       Remote CPU util :  0.0%

Recv   Send    Send                          
Socket Socket  Message  Elapsed              
Size   Size    Size     Time     Throughput  
bytes  bytes   bytes    secs.    10^6bits/sec  

262142  65536   4096    60.01      23.05   (23.02 confidence interval
was not
					    met, it was 9.8 for throughput)

------------------------------------
Testing with the following command line:
/opt/netperf/netperf -t TCP_RR -l 60 -H xxxx -i 10,3 -I 99,5 -- -r 1,1

TCP REQUEST/RESPONSE TEST to xxxx : +/-2.5% @ 99% conf. : interval
Local /Remote
Socket Size   Request  Resp.   Elapsed  Trans.
Send   Recv   Size     Size    Time     Rate         
bytes  Bytes  bytes    bytes   secs.    per sec   

16384  87380  1        1       60.00     878.09   (877.30)
65536  262142



------------------------------------
Testing with the following command line:
/opt/netperf/netperf -t UDP_RR -l 60 -H selinux4way -i 10,3 -I 99,5 --
-r 1,1

UDP REQUEST/RESPONSE TEST to selinux4way : +/-2.5% @ 99% conf. :
interval
Local /Remote
Socket Size   Request  Resp.   Elapsed  Trans.
Send   Recv   Size     Size    Time     Rate         
bytes  Bytes  bytes    bytes   secs.    per sec   

107520 107520 1        1       60.00    1105.25  (1105.03)
262142 262142



------------------------------------
Testing with the following command line:
/opt/netperf/netperf -t UDP_RR -l 60 -H selinux4way -i 10,3 -I 99,5 --
-r 516,4

UDP REQUEST/RESPONSE TEST to selinux4way : +/-2.5% @ 99% conf. :
interval
Local /Remote
Socket Size   Request  Resp.   Elapsed  Trans.
Send   Recv   Size     Size    Time     Rate         
bytes  Bytes  bytes    bytes   secs.    per sec   

107520 107520 516      4       60.00     756.26   (689.66 confidence
interval 
262142 262142					   not met. 57%for throughput)

------------------------------------
Testing with the following command line:
/opt/netperf/netperf -t UDP_STREAM -l 60 -H selinux4way -i 10,3 -I 99,5
-- -s 32768 -S 32768 -m 4096

UDP UNIDIRECTIONAL SEND TEST to selinux4way : +/-2.5% @ 99% conf. :
interval
Socket  Message  Elapsed      Messages                
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

 65536    4096   60.00       63460      0      34.66 (34.45)
107520           60.00       40063             21.88 (23.75)




------------------------------------
Testing with the following command line:
/opt/netperf/netperf -t UDP_STREAM -l 60 -H selinux4way -i 10,3 -I 99,5
-- -s 32768 -S 32768 -m 1024

UDP UNIDIRECTIONAL SEND TEST to selinux4way : +/-2.5% @ 99% conf. :
interval
Socket  Message  Elapsed      Messages                
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

 65536    1024   60.00      217219      0      29.66  (29.18)
107520           60.00      138541             18.91  (20.94)




If you wish to submit these results to the netperf database at
http://www.cup.hp.com/netperf/NetperfPage.html, please submit each
datapoint individually. Individual datapoints are separated by
lines of dashes.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
