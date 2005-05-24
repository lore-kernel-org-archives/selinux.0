Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4OIAAgA019733
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 14:10:10 -0400 (EDT)
Received: from e31.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4OI5OMp028469
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 18:05:25 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j4OI5Mua398856
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 14:05:24 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j4OI5Muc222256
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 12:05:22 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j4OI5MYh021191
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2005 12:05:22 -0600
Date: Tue, 24 May 2005 13:05:16 -0500
From: serue@us.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, latten@us.ibm.com
Subject: A few performance results
Message-ID: <20050524180516.GA25663@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Attached are a series of benchmark results comparing 2.6.12-rc2 with and
without selinux compiled in.  Both systems had capabilities enabled.
The test system was a dual opteron fedora core 3 system with a custom
dummy policy.  The root filesystem was ext3, but the benchmarks were run
on a separate ext2 filesystem.  The benchmarks run were dbench, tbench,
reaim, fsx-linux (jsut as a stress test) and kernbench.  I did two runs
with no profiling, which is what I'm mainly reporting here.  I also did
one run with profiling enabled.  From those results I am appending the
dbench output as well as the oprofile results.  I can send the other
profiling results if there is interest.

This is a temporary test system, which will sson become unavailable.
However, within the week we hope to have 1,4,8 and 16-cpu power
partitions ready for testing.

-serge

******************************************************************
dbench
******************************************************************
no selinux:

4 clients started
   0     62477  1453.84 MB/sec
Throughput 1453.74 MB/sec 4 procs

4 clients started
   0     62477  1427.67 MB/sec
Throughput 1427.57 MB/sec 4 procs


with selinux:

4 clients started
   2     61326  1366.68 MB/sec
   0     62477  1347.72 MB/sec
Throughput 1347.66 MB/sec 4 procs

4 clients started
   2     54192  1213.94 MB/sec
   0     62477  1151.10 MB/sec
Throughput 1151.05 MB/sec 4 procs

******************************************************************
reaim
******************************************************************
Times are in seconds - Child times from tms.cstime and tms.cutime
Num     Parent   Child   Child  Jobs per   Jobs/min/  Std_dev  Std_dev  JTI
Forked  Time     SysTime UTime   Minute     Child      Time     Percent 

no selinux:

1       0.05     0.00    0.01    122400.00  122400.00  0.00     0.00     100  
3       0.05     0.03    0.04    367200.00  122400.00  0.00     10.88    89   
5       0.07     0.05    0.07    437142.86  87428.57   0.01     14.81    85   
7       0.10     0.07    0.10    428400.00  61200.00   0.01     8.45     91   
9       0.11     0.08    0.12    500727.27  55636.36   0.02     18.04    81   
Max Jobs per Minute 500727.27

1       0.04     0.02    0.01    153000.00  153000.00  0.00     0.00     100  
3       0.05     0.02    0.05    367200.00  122400.00  nan      nan      -2147483648 
5       0.08     0.04    0.07    382500.00  76500.00   0.00     5.56     94   
7       0.09     0.07    0.09    476000.00  68000.00   0.01     15.75    84   
9       0.11     0.09    0.12    500727.27  55636.36   0.01     11.74    88   
Max Jobs per Minute 500727.27

with selinux:

1       0.04     0.01    0.02    153000.00  153000.00  0.00     0.00     100  
3       0.05     0.03    0.04    367200.00  122400.00  0.00     10.88    89   
5       0.08     0.06    0.07    382500.00  76500.00   nan      nan      -2147483648 
7       0.11     0.09    0.09    389454.55  55636.36   0.02     20.55    79   
9       0.13     0.12    0.11    423692.31  47076.92   0.01     9.25     90   
Max Jobs per Minute 423692.31

1       0.05     0.01    0.01    122400.00  122400.00  0.00     0.00     100  
3       0.06     0.04    0.04    306000.00  102000.00  0.00     8.32     91   
5       0.08     0.07    0.07    382500.00  76500.00   0.01     14.41    85   
7       0.11     0.10    0.08    389454.55  55636.36   0.02     17.01    82   
9       0.12     0.11    0.13    459000.00  51000.00   0.02     23.39    76   
Max Jobs per Minute 459000.00

******************************************************************
kernbench
******************************************************************
no selinux:

168.22user 28.19system 1:39.03elapsed 198%CPU (0avgtext+0avgdata 0maxresident)k
168.34user 28.17system 1:39.13elapsed 198%CPU (0avgtext+0avgdata 0maxresident)k
168.31user 28.25system 1:39.03elapsed 198%CPU (0avgtext+0avgdata 0maxresident)k

sys average: 28.203333 stdev 0.033993

168.16user 27.97system 1:38.93elapsed 198%CPU (0avgtext+0avgdata 0maxresident)k
168.09user 28.26system 1:39.04elapsed 198%CPU (0avgtext+0avgdata 0maxresident)k
168.43user 27.95system 1:38.98elapsed 198%CPU (0avgtext+0avgdata 0maxresident)k

sys average: 28.060000 stdev 0.141657

with selinux:

169.07user 29.74system 1:40.36elapsed 198%CPU (0avgtext+0avgdata 0maxresident)k
169.16user 29.77system 1:40.28elapsed 198%CPU (0avgtext+0avgdata 0maxresident)k
168.85user 29.93system 1:40.37elapsed 198%CPU (0avgtext+0avgdata 0maxresident)k

sys average: 29.813333 stdev 0.083400

169.08user 29.13system 1:40.10elapsed 198%CPU (0avgtext+0avgdata 0maxresident)k
168.99user 29.34system 1:40.29elapsed 197%CPU (0avgtext+0avgdata 0maxresident)k
168.97user 29.27system 1:40.10elapsed 198%CPU (0avgtext+0avgdata 0maxresident)k

sys average: 29.246667 stdev 0.087305

******************************************************************
tbench
******************************************************************
no selinux:

1 clients started
   1     42087  238.24 MB/sec
   0     62477  235.94 MB/sec
Throughput 235.938 MB/sec 1 procs

1 clients started
   1     41763  237.03 MB/sec
   0     62477  233.86 MB/sec
Throughput 233.853 MB/sec 1 procs

with selinux:

1 clients started
   1     42262  238.62 MB/sec
   0     62477  236.64 MB/sec
Throughput 236.636 MB/sec 1 procs

1 clients started
   1     42180  238.48 MB/sec
   0     62477  236.03 MB/sec
Throughput 236.021 MB/sec 1 procs


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
