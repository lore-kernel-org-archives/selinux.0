Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA05361
	for <selinux@tycho.nsa.gov>; Wed, 14 Nov 2001 14:51:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA01600
	for <selinux@tycho.nsa.gov>; Wed, 14 Nov 2001 19:50:46 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id TAA01596
	for <selinux@tycho.nsa.gov>; Wed, 14 Nov 2001 19:50:46 GMT
Date: Wed, 14 Nov 2001 14:50:45 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Are enhancements back-ported
In-Reply-To: <1005764617.19444.0.camel@vorpal>
Message-ID: <Pine.GSO.4.33.0111141425190.22794-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 14 Nov 2001, Justin Smith wrote:

> I've noticed that enhancements and fixes to the SELinux system appear to
> be implemented for the latest versions of the kernel. For various
> reasons, I can't use the latest versions of the Linux kernel (they have
> bugs that will probably EVENTUALLY be fixed but which are significant
> for the hardware I'm using). So my question is: do the versions of
> SELinux for kernel 2.4.9 (the latest one I can use) reflect the
> enhancements and fixes?

The NSA SELinux web site only provides a single release of SELinux at any
given time, and each release of SELinux is based on a particular snapshot
of the LSM kernel patch, which is relative to a particular kernel version.
The only SELinux release based on 2.4.9 was the August release (the first
LSM-based release), and there have been plenty of bug fixes and changes to
both LSM and SELinux since that time.

What exactly are the problems you are encountering with post-2.4.9
kernels?  Does they still occur with 2.4.15-pre4?  Do they occur with the
-ac series (looks like 2.4.13-ac8 is the most recent)?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
