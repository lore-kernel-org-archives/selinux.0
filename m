Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4FsWXZ023911
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 10:54:32 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4FsW8i029904
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 15:54:32 GMT
Subject: Re: Updated SELinux Release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: James Morris <jmorris@redhat.com>
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>, selinux@tycho.nsa.gov
In-Reply-To: <Xine.LNX.4.44.0411041028180.18826-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0411041028180.18826-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1099583269.3174.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 04 Nov 2004 10:47:49 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-11-04 at 10:38, James Morris wrote:
> There is a performance hit and a scalability hit.  Some work by NEC on 
> AVC scalability should be going into the upstream kernel soon.
> 
> The baseline performance hit seems to be around 7% (although it needs to
> be evaluated again after the code is tuned), although on some networking
> benchmarks it is as high as 20% for gigabit networking (no significant
> performance hit is seen at 100Mbps).  Work is being done on both the
> baseline and networking performance for intensive workloads.

Right, but I think that the key issue as far as compile-time enabling of
SELinux is concerned is what performance hit is imposed by LSM itself,
because you can always disable SELinux at boot-time or runtime.  And you
can even trivially change the defaults for the boot-time parameter, as
SuSE did, so that selinux=0 is the default.  That allows users to still
enable SELinux without rebuilding the kernel, while only imposing the
overhead of LSM itself on non-SELinux users.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
