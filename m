Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA28743
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2001 15:04:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA25503
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2001 19:03:14 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA25499
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2001 19:03:13 GMT
Date: Thu, 16 Aug 2001 15:03:44 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Conan Callen <ccallen@windowpane.com>
cc: selinux@tycho.nsa.gov
Subject: Re: selinux on freebsd
In-Reply-To: <011b01c1261c$29836020$3a8314d1@nwlink.com>
Message-ID: <Pine.SOL.3.95.1010816145246.9676I-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Wed, 15 Aug 2001, Conan Callen wrote:

> 2. I read in the FAQ that selinux can be installed on an existing linux 
> install. Can it be installed on a Freebsd system with linux
> compatibility? Is anyone working on a port for freebsd or openbsd?

SELinux is an implementation of flexible, fine-grained nondiscretionary
access controls for the Linux kernel.  The FAQ doesn't mean that you
run SELinux on top of the Linux kernel as an application - it means
that you install the SELinux kernel on an existing Linux platform 
and then boot that kernel.  

The TrustedBSD project (www.trustedbsd.org) and the CBOSS project
(http://opensource.nailabs.com/initiatives/cboss) are developing
similar features for FreeBSD.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com







--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
