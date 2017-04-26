Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3Q0VgBK023254
 for <selinux@tycho.nsa.gov>; Tue, 25 Apr 2017 20:31:42 -0400
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH v2] libsemanage: remove lock files
Date: Wed, 26 Apr 2017 10:31:34 +1000
References: <58517705.198270.1492699110308@pim.register.it>
 <201704251630.03844.russell@coker.com.au>
 <1493150773.12050.2.camel@trentalancia.net>
In-Reply-To: <1493150773.12050.2.camel@trentalancia.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201704261031.34910.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 26 Apr 2017 06:06:13 AM Guido Trentalancia wrote:
> > Pidfile locking also never works across network filesystems as pids
> > are local to 
> > a system.  You could have some combination of pid and hostname (as
> > done by 
> > some web browsers) but that gets ugly.
> 
> No, I didn't mean the complicate circumstance of NFS shared amongst
> multiple systems.
> 
> I only meant the simpler (and most common) situation where the NFS is
> mounted for only one system, therefore PIDs are unique and there is no
> need to include the hostname.

flock(2) seems to indicate that locks always worked locally on NFS filesystems 
and thus would always have worked in that case.

Please do some testing and prove that the problem occurs on NFS-root systems.

> > Really pidfiles are so horrible that one of the noteworthy features
> > of systemd 
> > is removing the need for them.
> 
> I am not that pessimistic about locking with aid of PIDs.
> 
> To be honest, the current situation has more drawbacks in my opinion.
> 
> In particular, I don't like the fact that it leaves unused lock files
> around the filesystem.

Everything else that uses lock files does that.

> > Having multiple systems operate with NFS root and a shared
> > /etc/selinux is 
> > never going to work well.  Even if everything works well (and it
> > probably 
> > won't) you will end up with systems that have the policy in
> > /etc/selinux not 
> > matching what is running.
> 
> Please forget sharing NFS. I meant dedicated NFS.
> 
> Anyway, I have created a new version of the patch that should probably
> improve the previous race condition.
> 
> If you have a way of testing a dedicated store over NFS, then I'd like
> to hear back from you the result of such testing !
> 
> But, if you are not interested in testing it, then never mind...

I think that when someone wants to change behavior that is the same as used in 
many programs they should demonstrate that it has a problem.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
