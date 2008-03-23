Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2NCfOnE032143
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2008 08:41:24 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2NCfMtS021382
	for <selinux@tycho.nsa.gov>; Sun, 23 Mar 2008 12:41:23 GMT
From: David Howells <dhowells@redhat.com>
In-Reply-To: <25920.1206249437@turing-police.cc.vt.edu>
References: <25920.1206249437@turing-police.cc.vt.edu> <20080229004405.4142.32147.stgit@warthog.procyon.org.uk> <20080229004332.4142.51771.stgit@warthog.procyon.org.uk> <17688.1205946728@redhat.com>
To: Valdis.Kletnieks@vt.edu
Cc: dhowells@redhat.com, akpm@linux-foundation.org, torvalds@osdl.org,
        Trond.Myklebust@netapp.com, chuck.lever@oracle.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: Performance degradation measurement [was Re: [PATCH 06/37] Security: Separate task security context from task_struct [ver #34]]
Date: Sun, 23 Mar 2008 12:40:48 +0000
Message-ID: <17671.1206276048@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Valdis.Kletnieks@vt.edu wrote:

> What's up with *that*?  The *fastest* run with it disabled is 1.118, and
> the *slowest* with it enabled is 1.119.  At that point, I have to wonder
> what we're really measuring here....

That's a good point.  I missed that, probably because I *knew* it would be
slower with SELinux enabled, and so just assumed that it was.

That's really odd. There should be no disk accesses happening (the
pagecache/buffer cache is preloaded and noatime is turned on), the CPUs are
running at top speed at all times, and there's lots of free RAM available.
Network activity should also be minimal, so I'm not sure why there's so much
variance.

I'll re-run my tests from a kernel running a single bash and nothing else, see
if I can get more consistent data.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
