Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1MGGfaZ030993
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 11:16:41 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1MGGT29009197
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 16:16:30 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <17916.1203636833@redhat.com>
References: <17916.1203636833@redhat.com> <28196.1203605703@redhat.com> <200802201907.40406.phillips@phunq.net> <20080220160557.4715.66608.stgit@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Daniel Phillips <phillips@phunq.net>,
        Trond.Myklebust@netapp.com, chuck.lever@oracle.com,
        casey@schaufler-ca.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/37] Permit filesystem local caching
Date: Fri, 22 Feb 2008 16:14:35 +0000
Message-ID: <19020.1203696875@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Howells <dhowells@redhat.com> wrote:

> > > Have you got before/after benchmark results?
> > 
> > See attached.
> 
> Attached here are results using BTRFS (patched so that it'll work at all)
> rather than Ext3 on the client on the partition backing the cache.

And here are XFS results.

Tuning XFS makes a *really* big difference for the lots of small/medium files
being tarred case.  However, in general BTRFS is much better.

David
---


=========================
FEW BIG FILES TEST ON XFS
=========================

Completely cold caches:

	[root@andromeda ~]# time cat /warthog/bigfile >/dev/null
	real    0m2.286s
	user    0m0.000s
	sys     0m1.828s
	[root@andromeda ~]# time cat /warthog/biggerfile >/dev/null
	real    0m4.228s
	user    0m0.000s
	sys     0m1.360s

Warm NFS pagecache:

	[root@andromeda ~]# time cat /warthog/bigfile >/dev/null
	real    0m0.058s
	user    0m0.000s
	sys     0m0.060s
	[root@andromeda ~]# time cat /warthog/biggerfile >/dev/null
	real    0m0.122s
	user    0m0.000s
	sys     0m0.120s

Warm XFS pagecache, cold NFS pagecache:

	[root@andromeda ~]# time cat /warthog/bigfile >/dev/null
	real    0m0.181s
	user    0m0.000s
	sys     0m0.180s
	[root@andromeda ~]# time cat /warthog/biggerfile >/dev/null
	real    0m1.034s
	user    0m0.000s
	sys     0m0.404s

Warm on-disk cache, cold pagecaches:

	[root@andromeda ~]# time cat /warthog/bigfile >/dev/null
	real    0m1.540s
	user    0m0.000s
	sys     0m0.256s
	[root@andromeda ~]# time cat /warthog/biggerfile >/dev/null
	real    0m3.003s
	user    0m0.000s
	sys     0m0.532s


==========================================
MANY SMALL/MEDIUM FILE READING TEST ON XFS
==========================================

Completely cold caches:

	[root@andromeda ~]# time tar cf - /warthog/aaa >/dev/zero
	real    4m56.827s
	user    0m0.180s
	sys     0m6.668s

Warm NFS pagecache:

	[root@andromeda ~]# time tar cf - /warthog/aaa >/dev/zero
	real    0m15.084s
	user    0m0.212s
	sys     0m5.008s

Warm XFS pagecache, cold NFS pagecache:

	[root@andromeda ~]# time tar cf - /warthog/aaa >/dev/zero
	real    0m13.547s
	user    0m0.220s
	sys     0m5.652s

Warm on-disk cache, cold pagecaches:

	[root@andromeda ~]# time tar cf - /warthog/aaa >/dev/zero
	real    4m36.316s
	user    0m0.148s
	sys     0m4.440s


=======================================================
MANY SMALL/MEDIUM FILE READING TEST ON AN OPTIMISED XFS
=======================================================

mkfs.xfs -d agcount=4 -l size=128m,version=2 /dev/sda6


Completely cold caches:

	[root@andromeda ~]# time tar cf - /warthog/aaa >/dev/zero
	real    3m44.033s
	user    0m0.248s
	sys     0m6.632s

Warm on-disk cache, cold pagecaches:

	[root@andromeda ~]# time tar cf - /warthog/aaa >/dev/zero
	real    3m8.582s
	user    0m0.108s
	sys     0m3.420s

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
