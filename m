Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA25548
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2001 18:14:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA09092
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2001 22:13:31 GMT
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.101])
	by jazzswing.ncsc.mil  with ESMTP id WAA09088
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2001 22:13:30 GMT
Received: from northrelay02.pok.ibm.com (northrelay02.pok.ibm.com [9.117.200.22])
	by e1.ny.us.ibm.com (8.9.3/8.9.3) with ESMTP id SAA484072
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2001 18:12:24 -0400
Received: from d01ml233.pok.ibm.com (d01ml233.pok.ibm.com [9.117.200.63])
	by northrelay02.pok.ibm.com (8.11.1m3/NCO v4.97) with ESMTP id f6RM7ue174440
	for <selinux@tycho.nsa.gov>; Fri, 27 Jul 2001 18:07:56 -0400
Subject: SELinux Performance and Scalability analysis
To: selinux@tycho.nsa.gov
Message-ID: <OF4D17E2DA.CA5BA1EA-ON85256A96.0079AD9D@pok.ibm.com>
From: "Rajan Ravindran" <rajancr@us.ibm.com>
Date: Fri, 27 Jul 2001 18:14:19 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Scalability / Performance test between Vanilla and SELinux kernel
(2.4.3)

Hubertus Franke, Rajan Ravindran, Shailabh Nagar
IBM T.J.Watson Research Center
Yorktown Heights, NY 10598
{frankeh,rajancr,nagar}@us.ibm.com

This paper is the continuation work of our earlier report posted under
subject
"SELinux Performance and Scalability analysis" on 06/11/2001.

In the earlier report we have shown some of the potential bottlenecks of
SELinux over Vanilla kernel.

As we have already mentioned, based on the output of chatroom, the overhead
is the
lock contention on avc_lock which is in the access vector cache (AVC) which
provides caching of access decision computations. Since this is a global
lock,
lock contention increases dramatically from  14% in 2-way to 73% for chat
room
benchmark on a 8-way system.

Here is the brief summary of current code flow.

avc_has_perm_ref_audit.
 inline int avc_has_perm_ref_audit(
  security_id_t ssid,
  security_id_t tsid,
  security_id_t tclass,
  access_vector_t requested,
  avc_entry_ref_t *aeref,
  avc_audit_data_t *auditdata);

This is the function which determines whether the requested permissions are
granted for the specified SID pair and class.

If aeref refers to a valid AVC entry (where AVC (access vector cache) is a
system component that provides caching of access decision computations
to minimize the performance overhead) for this permission check, then the
referenced entry is used. Otherwise, this function obtain a valid entry and
sets aeref to refer to this entry. To obtain a valid entry, this function
first searches the cache. If this fails then it calls the
security_compute_av
interface of the security server to compute the access vectos and adds a
new
entry to the cache.
On entry of this function, global lock (avc_lock) gets aquired atleast once
(may be twice) and releases while exiting from this function, and that
causes
this lock contention. We measured this lock contention using lock metering.
We did this for the 1,2,4,8 cpu system configuration and the results have
been
already published in our earlier report.

To make sure, that avc_has_perm_ref_audit is the function which
causes this problem, we tested by returning success for all the calls
to that function, without doing any further check. Here are those results.


          Throughput (bigger is better)
Rooms Messages      Vanilla        % overhead (r1)           % overhead
(r2)
10   100       250434               5.1            72.2
20   100       246635              15.6            78.6
30   100       181574              13.2            78.7

where     r1 is the overhead while returning success.
r2 is the overhead while running the present selinux.

Note: For more information about the chat room benchmark, please refer our
earlier report.

As we are facing an overhead of around 75% while running current selinux,
this measurement confirms this to be the function where we have bottleneck.

Next step we decided to split the avc_lock, so as to reduce the lock
contention.
In the present model all the audits are finally made by checking its
corresponding
node, which is present in any one of  the 512 entries in the AVC.

Here are our various approaches, by which we can avoid having one global
spin lock
1. Split lock
   Locks can be created 1 per entry.
   Locks can be created 1 per block where block is 'n' entries.
2. Change type of lock
   Instead of spin lock, use read/write lock.
   Provide read lock where we are not doing any updation, so that several
objects can simultaneously read the data.
   Provide write lock while updating the entry, so that only one can hold
the lock at any time.

Based on these two approaches, these are the items we experimented and the
results are given below

·    split avc_lock in to 512 locks such a way that each entry have an
individual spin lock.
·    use global read/write lock instead of spin lock.
·    split avc_lock in to 512 locks such a way that each entry have a
individual read/write lock.
·    block (spin and read/write) lock by having a block size of 8 (64
entries per block)

Labelling convention for these approaches are as follows:
G.Spin - Global Spin lock (currently used by SELinux)
L.Spin - Local Spin lock
G.R/W - Global R/W lock
L.R/W - Local R/W lock
B.Spin - Block Spin lock
B.R/W - Block R/W lock

Comparision of vanilla and  the existing Global Spin lock selinux kernel
while running chat room

               Throughput (bigger is better)
Rooms Messages      Vanilla        G.Spin         Overhead (%)
10   100            250434     69489          72.2
20   100            246635     52536          78.6
30   100            181574     38535          78.7

Here are few results, which compares our new approaches with the existing
Global Spin Lock kernel while running chat room on the 8-way machine.

·    split avc_lock in to 512 locks such a way that each entry have an
individual spin lock.

               Throughput (bigger is better)
Rooms Messages      G.Spin         L.Spin     Improvement (%)
10   100            69489          94680           26.6
20   100            52536          68235           23.0
30   100            38535          46556           17.2

We added some counters to find out how much access to the entries.
It showed very few entries were always hot.  Here are the results of
avc_cache slots hit.

avc_cache[323] = 12989361
avc_cache[331] = 1974482
avc_cache[351] = 1974482

rest of the entries got only a few hundreds of hits and some are < 100.
It is very clear if a benchmark exercises the same object, then we will not
be seeing much improvement in the performance.
____________________________________________________________________________________

·    use global read/write lock instead of spin lock.

We grabbed the write lock (which grants exclusive access to the objects) in
the adding part of new entry of avc_has_perm_ref_audit and we grabbed the
read lock for the rest of the code path in avc_has_perm_ref_audit.
Here are the results of G.R/W  lock approach

               Throughput (bigger is better)
Rooms Messages      G.Spin         G.R/W           Improvement (%)
10   100       69489          102670     32.3
20   100       52536          62182           15.5
30   100       38535          40010           4.1

____________________________________________________________________________________

·    split avc_lock in to 512 locks such a way that each entry have an
individual read/write lock.

Similar to the local spin lock mechanism, except that we are using
read/write lock
instead of spin lock


Here are the results of L.R/W lock approach

               Throughput (bigger is better)
Rooms Messages      G.Spin         L.R/W           Improvement (%)
10   100       69489          110129     36.9
20   100       52536          61098           14.0
30   100       38535          42375           9.1

____________________________________________________________________________________

·    block (spin and read/write) lock by having a block size of 8 (64
entries per block)

Here are the results of block lock (both spin and read/write).

               Throughput (bigger is better)
Rooms Messages      G.Spin         B.Spin (%)      B.R/W (%)
10   100            69489          90376 (25.0)     124802 (44.2)
20   100            52536          82761 (36.5)      84465 (36.5)
30   100            38535          62230  (38.0)     63117 (38.0)

(%) Improvement %

Conclusion:
--------------

Our new implementation of individual cache line spin lock , individual
cache line R/W lock, block spin & RW lock gives significant performance
improvement for the chat room benchmark.
However chat room has significant lock contention which may overexpose the
problem.
Therefore we are planning to run more benchmarks (such as kernel build,
lmbench, etc) and will keep posting those results.

Thanks,
Rajan


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
