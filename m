Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA21300
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2001 17:20:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA28004
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2001 21:19:56 GMT
Received: from e3.ny.us.ibm.com ([32.97.182.103])
	by jazzswing.ncsc.mil  with ESMTP id VAA27993
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2001 21:19:53 GMT
Received: from northrelay02.pok.ibm.com (northrelay02.pok.ibm.com [9.117.200.22])
	by e3.ny.us.ibm.com (8.9.3/8.9.3) with ESMTP id RAA42924
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2001 17:18:30 -0400
Received: from d01ml244.pok.ibm.com (d01ml244.pok.ibm.com [9.117.127.106])
	by northrelay02.pok.ibm.com (8.11.1m3/NCO v4.96) with ESMTP id f5BLDGU121180
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2001 17:13:16 -0400
Subject: SELinux Performance and Scalability analysis
To: <selinux@tycho.nsa.gov>
Message-ID: <OF46CCDE0F.5D036ECF-ON85256A68.00740F04@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Mon, 11 Jun 2001 17:19:40 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Scalability / Performance test between Vanilla and SELinux kernel (2.4.3)


Hubertus Franke, Rajan Ravindran, Shailabh Nagar
IBM T.J.Watson Research Center
Yorktown Heights, NY 10598
{frankeh,rajancr,nagar}@us.ibm.com


In order to establish potential bottlenecks that might exist in the current
SE-Linux prototype, we compared the performance between Vanilla and SELinux
kernels in a highend system. This comparision is based on the 2.4.3
kernels.

Machine Used: Netfinity 8500R, 8-way, Pentium III (700 MHz, 2MB cache),
2.5GB Memory, , RedHat (7.1).

To do this analysis we used the following benchmarks, which we also
use in our scheduler scalability work
(http://lse.sourceforge.net/scheduling)
1. Chat Room (http://lbs.sourceforge.net)
2. Lmbench     (http://www.bitmover.com/lmbench)

We first report the general performance we observed.
We then profiled the program.
We then studied lock contention.

In order to get a better understanding and quantification of the overhead
we
profiled the various executions of the various benchmark runs


Below is the output of various benchmarks and profiling.

Chat Room:
---------

Chatroom is a benchmark that emulates a set of users exchanging
messages in a chatroom. The benchmark is a "C" implementation
modeled after the Java "Volano Benchmark".
It creates a number of rooms in which a 20 simulated test users
exchange messages (chatting) as quickly as possible. Each user
in each room is represented by a set of 4 threads. The benchmark
measures the average throughput of messages that can be exchanged
on a given system for a given setup of rooms and #messages. It
is extremely scheduler and kernel intensive.

     Chat Room 8-way

Vanilla    1-way     2-way       4-way    8-way
------------------------------------------------------
10   100  173418    174339    294968     287190
10   200  190078    162790    245659     174521
10   300  200897    164949    243203     220282
20   100  153570    171744    287648     265399
20   200  176574    162635    216309     121664
20   300  190320    164960    213473     169291
30   100  138788    162034    263137     266330
30   200  163631    147485    173068     96217
30   300  179772    149500    181357     113502

SELinux
------------------------------------------------------
10   100  144251    119768    128817     73726
10   200  158375    117092    124796     80089
10   300  163257    123968    132866     83095
20   100  132982    120550    124233     67769
20   200  148748    117002    125465     76934
20   300  158690    120810    129426     79945
30   100  122010    118962    113934     54997
30   200  141380    109374    116758     61614
30   300  150224    114563    124773     63468



               Overhead % (Vanilla vs SELinux)

10   100  16.8189   31.30166  56.32848   74.32849
10   200  16.67894  28.07175  49.1995    54.10925
10   300  18.73597  24.84465  45.36827   62.2779
20   100  13.40626  29.80832  56.81075   74.46524
20   200  15.75883  28.05854  41.99733   36.76519
20   300  16.61938  26.76406  39.37126   52.77658
30   100  12.08894  26.58208  56.70164   79.35005
30   200  13.59828  25.84059  32.53634   35.9635
30   300  16.43637  23.36923  31.20034   44.08204


The data reveal that in low end system the performance overhead is
roughly in the range of 12..19%. That is scales well with the workload
itself. However with an increased number of cpus, the overhead is
starting to show up, indicating that there are hot locks. We will
investigate this issue further down.


LMBench:
---------

Standard benchmark in the community to establish OS performance.
Here is the summary.

L M B E N C H  2 . 0   S U M M A R Y
------------------------------------

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz

--------- ------------- ----------------------- ----
ssm20.wat Linux 2.4.3-v       i686-pc-linux-gnu  700
ssm20.wat Linux 2.4.3-F       i686-pc-linux-gnu  700


Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec
sh
                             call  I/O stat clos TCP   inst hndl proc proc
proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ----
----
ssm20.wat Linux 2.4.3-v  700 0.47 0.87 5.84 7.61    40 1.33 4.18  497 1381
14K
ssm20.wat Linux 2.4.3-F  700 0.49 1.05 6.88 8.56    67 1.32 4.02  481 1405
12K

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
ssm20.wat Linux 2.4.3-v 4.080 9.9200     23 8.9000     25      10      27
ssm20.wat Linux 2.4.3-F 4.170     11     26     10     32      10      32

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
ssm20.wat Linux 2.4.3-v 4.080    14   37    58    71    69   115  107
ssm20.wat Linux 2.4.3-F 4.170    13   61    67    78    69   119  130

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page

                        Create Delete Create Delete  Latency Fault   Fault
--------- ------------- ------ ------ ------ ------  ------- -----   -----
ssm20.wat Linux 2.4.3-v 9.5102 1.3670     19 4.1506      112 1.044 5.00000
ssm20.wat Linux 2.4.3-F     11 1.4412     21 4.0133      135 0.910 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem
Mem
                             UNIX      reread reread (libc) (hand) read
write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ----
-----
ssm20.wat Linux 2.4.3-v  506   31  192    255    289    190    138  289
186
ssm20.wat Linux 2.4.3-F  390   68  117    251    286    188    137  287
191

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
ssm20.wat Linux 2.4.3-v   700 4.285     12    210
ssm20.wat Linux 2.4.3-F   700 4.287     12    210


Note:
2.4.3-v => Vanilla kernel
2.4.3-F => SELinux kernel

_______________________________________________________________________________
_______________________________________________________________________________

Kernel Profiling

For details about Kernel profiling, visit
http://oss.sgi.com/projects/kernprof/faq.html

There are various modes in kernel profiling, here we used annotated
call graph mode, which is a combination of PC sampling and
Call graph mode. PC sampling collects periodic Program Counter
addresses and translates them into kernel procedure names.
Over a reasonable execution time this identifies which functions
are executed at what percentage rate. So the longer the execution time,
the more precise the sampling will be. The Call graph gives further
information on where the certain execution took place rather than simply
identifying the individual invocations.

We did sample profiling by running chat room with 20 rooms and 200
messages.
>From the output of the profiling values, we picked the top CPU hog output.
As expected for the Chatroom, significant time is spent in tcp send and
receive calls (apart from scheduling). However, the tcp_sendmsg in SELinux
consumes 9.5% of execution, while in Vanilla it only consumes 4.2%.

The profiling output is as follows:

Vanilla

  %   cumulative   self              self     total
 time   seconds   seconds    calls  ms/call  ms/call  name
 32.41     28.35    28.35                             cg_record_arc
 21.35     47.02    18.67   116912   159.69   160.68  schedule
 15.45     60.53    13.51   568095    23.78    23.78  _wake_up
  4.16     64.17     3.64  1600003     2.27     9.55  tcp_sendmsg
  2.58     66.43     2.26  3201397     0.71     0.71  fget
  1.93     72.21     1.69     2353   718.23   718.23  default_idle
  0.81     77.07     0.71  1600003     0.44    13.65  tcp_recvmsg
  0.14     84.61     0.12  1600003     0.07    13.72  inet_recvmsg
  0.11     85.37     0.10  1600003     0.06     9.61  inet_sendmsg

SELinux

  %   cumulative   self              self     total
 time   seconds   seconds    calls  ms/call  ms/call  name
 19.49     30.19    30.19   151842   198.83   199.99  schedule
 18.89     59.44    29.25                             cg_record_arc
 12.78     79.24    19.80   907710    21.81    21.81  _wake_up
  9.53     94.00    14.76  1600003     9.22    15.34  tcp_sendmsg_secure
  9.03    107.99    13.99  1600003     8.74    29.05  inet_sendmsg_secure
  7.12    119.01    11.02  1600003     6.89    29.32  inet_recvmsg_secure
  2.71    123.20     4.19     2500  1676.00  1676.00  default_idle
  2.36    126.85     3.65   358455    10.18    33.28  ip_rcv
  2.32    130.45     3.60   358540    10.04    13.01  ip_output
  1.71    133.10     2.65   356627     7.43    18.89  tcp_rcv_established
  1.15    138.88     1.78  3201528     0.56     0.56  fget
  0.39    145.15     0.60  1600003     0.37    21.19  tcp_recvmsg_secure

%         the percentage of the total running time of the
time      program used by this function

cumulative     running sum of the number of seconds accounted
seconds   for by this function and those listed above it.

self      the number of seconds accounted for by this
seconds   function alone. This is the major sort for this listing.

calls          the number of times this function was invoked, if
          This function is profiled, else blank.
self      the average number of milliseconds spent in this
ms/call   function per call, if this function is profiled, else blank.

total          the average number of milliseconds spent in this
ms/call   function and its descendents per call, if this function is
Profiled, else blank.

name      the name of the function.

The calling sequence of the tcp send call is as follows (top to bottom):

     Vanilla        SELinux
     -------        -------
     system_call         system_call
sys_socketcall      sys_socketcall
sys_send            sys_send
sys_sendto               sys_sendto
sock_sendmsg        sys_sendto_secure
inet_sendmsg        sock_sendmsg_secure
tcp_sendmsg         inet_sendmsg_secure
tcp_sendmsg_secure

Here we highlight one particular callgraph section for the sys_recvfrom and
sys_sendto functions. We identified these two functions because of their
code
path of send and receive calls, get diverged only after these functions.

Vanilla

index % time    self  children    called     name
                0.18   23.45 1600003/1600003     sys_recv [4]
[5]     27.4    0.18   23.45 1600003         sys_recvfrom [5]
                0.10   21.96 1600003/1600003     sock_recvmsg [6]
                0.14    1.13 1600003/3200810     sockfd_lookup [26]
                0.10    0.01 1600003/3203048     fput [63]
-----------------------------------------------
                0.18   16.87 1600003/1600003     sys_send [10]
[11]    19.8    0.18   16.87 1600003         sys_sendto [11]
                0.10   15.37 1600003/1600003     sock_sendmsg [12]
                0.14    1.13 1600003/3200810     sockfd_lookup [26]
                0.10    0.01 1600003/3203048     fput [63]

SELinux

index % time    self  children    called     name
                0.07   48.40 1600027/1600027     sys_recv [3]
[4]     31.6    0.07   48.40 1600027         sys_recvfrom [4]
                0.10   48.30 1600027/1600027     sys_recvfrom_secure [5]
-----------------------------------------------
                0.03   47.83 1600004/1600004     sys_send [6]
[7]     31.2    0.03   47.83 1600004         sys_sendto [7]
                0.12   47.71 1600004/1600004     sys_sendto_secure [8]

The line with the index number at the left hand margin lists the current
function. The lines above it list the functions that called this function,
and
the lines below it list the functions this one called.
This line lists:
     Index          A unique number given to each function.

% time    This is the percentage of the 'total' time that was spent
          in this function and its children.

self      This is the total amount of time spent in this function.

children  This is the total amount of time propagated into this function
          by its children.

called    This is the number of times the function was called.

name      The name of the current function. The index number is printed
after it.


____________________________________________________________________________
____________________________________________________________________________

Lock Metering
-------------

Having identified the limited scalability with respect to the number of
CPUs,
we post here the results of the lock metering. Lock metering identifies the
lock contention, average+max lock hold and lock wait times. Again, we did
this for the 1,2,4,8 cpu system configuration. Since in the initial
analysis
we showed that SELinux adds almost constant (predictable) overhead
independent
of the workload configuration, we have chosen 10 rooms/100 messages as the
focal
point of this analysis to avoid other hot spots in the system. As can be
seen,
the AVC lock contention increases dramatically from 14% contention in the
2-way to 73% in the 8-way. At the same time the object manager lock is not
contented in this particular benchmark, as new objects are not created
during
the run.
Next we will be locking on how to break up a lock. There are various ways
we
can go, for instance we can "color" the avc vectors and thus split up the
lock,
we can also use some of the newly proposed RCU (read copy update) locks
(lse.sourceforge.net/locking). But again, we don't want to get of ourselves
here. More on this to follow hopefully soon.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - -
SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN
RJECT  NAME

(8) CPUs:
 26.2% 73.5%  1.6us(  14us)   16us( 499us)(24.4%)  16266843 26.5% 73.5%
0%  avc_lock
 0.34%  1.7%  0.2us(  13us)  1.3us( 9.6us)(0.00%)   1691151 98.3%  1.7%
0%  ss_lock
 19.0% 46.3%   24us( 181us)   67us(2135us)( 3.1%)    766205 53.7% 46.3%
0%  runqueue_lock

(4) CPUs:
 14.7% 42.7%  0.7us(  83us)  2.8us(  84us)( 6.2%)  17186455 57.3% 42.7%
0%  avc_lock
 0.44%  2.1%  0.2us(  13us)  1.1us( 7.0us)(0.01%)   2059578 97.9%  2.1%
0%  ss_lock
  9.8% 21.2%  8.5us( 111us)   12us( 323us)(0.71%)    965766 78.8% 21.2%
0%  runqueue_lock

(2) CPUs:
  9.1% 14.7%  0.5us(  76us)  1.8us(  69us)( 2.2%)  15344726 85.3% 14.7%
0%  avc_lock
 0.24% 0.58%  0.2us(  11us)  1.3us( 3.5us)(0.01%)   1322487 99.4% 0.58%
0%  ss_lock
  3.1%  5.3%  4.6us(  58us)  5.2us(  56us)(0.09%)    606905 94.7%  5.3%
0%  runqueue_lock

(1) CPU:
  2.1%    0%  0.1us( 3.1us)    0us                 13031153  100%    0%
0%  avc_lock
 0.07%    0%  0.2us( 7.7us)    0us                   395736  100%    0%
0%  ss_lock
  1.0%    0%  3.7us( 105us)    0us                   252639  100%    0%
0%  runqueue_lock
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
- - - - - - - - - - -


       TOT/SEC Number of times per second that the lock was set.
       UTIL    % of time that the lock was busy during the measurement.
               (Only one of the above two is printed.  The -C flag selects
               which one is printed.  The default is to print UTIL.)
       CON     Amount of contention that occurred for the lock.  The
               number represents the percent of time that lock was NOT
               acquired without spinning or sleeping.
       HOLD    Mean and max lock hold times, in microseconds (us) or
               milliseconds (ms), and the percentage of total CPU cycles
               consumed by the waiting.
               This is reported per caller for spin locks and
               for write mode locks on rwlocks.  It is reported
               over all callers for read mode locks on rwlocks.
       MAXRDR  Maximum number of readers for a rwlock.
       RDR BUSY PERIOD Length (in microseconds) of 'reader busy' periods
               for a rwlock.  A reader busy period starts when the first
               reader lock is set and ends when the last reader releases
the
               lock.  This statistic is reported over all read lock callers
               on a rwlock (not on a per caller basis).
       WAIT    Mean spin-wait wait time, in microseconds.
       WAIT WW For write locks, we also report wait time that a
               a writer waited for a writer holding the lock.
       TOTAL   Total number of times that the lock was set.
       NOWAIT  Percentage of times the lock was acquired without waiting
       SPIN    Percentage of times it was necessary to spin waiting for
               a spinlock.
       SPIN WW Percentage of times a writer could not get a rwlock because
               another writer was holding the lock.
       RJECT   Percentage of times a "trylock" failed.
       NAME    Identifies the lock and/or the routine that set the lock.
               If the lock is statically defined and not part of an array,
               both the lock name and the functions that set the
               lock are listed.  If the lock is dynamically allocated,
               only the function name that set the lock will be listed.
               If spin lock code at a particular address sets more than one
               lock (e. g. if a procedure sets a spin lock in an argument)
               then stats for all such locks are combined and reported by
               calling address (procedure and offset) only.  No lock name
               or address is given in that case.



Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
