Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA4FcwXZ023746
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 10:39:00 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA4Fcw8i029087
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 15:38:58 GMT
Date: Thu, 4 Nov 2004 10:38:57 -0500 (EST)
From: James Morris <jmorris@redhat.com>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
cc: selinux@tycho.nsa.gov
Subject: Re: Updated SELinux Release
In-Reply-To: <87k6t2qepg.fsf@glaurung.internal.golden-gryphon.com>
Message-ID: <Xine.LNX.4.44.0411041028180.18826-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 4 Nov 2004, Manoj Srivastava wrote:

> 	Moving waaay forward. I asked the Debian kernel team to
>  consider  compiling in SELinux (perhaps disabled by default, for
>  starters), and was told that that is not going to fly because of
>  "significant performance hit" one takes by compiling SELinux in.  I
>  did not have any data to refute the claim, so  that is where we sit.

There is a performance hit and a scalability hit.  Some work by NEC on 
AVC scalability should be going into the upstream kernel soon.

The baseline performance hit seems to be around 7% (although it needs to
be evaluated again after the code is tuned), although on some networking
benchmarks it is as high as 20% for gigabit networking (no significant
performance hit is seen at 100Mbps).  Work is being done on both the
baseline and networking performance for intensive workloads.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
