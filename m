Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA05084
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 10:48:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA03368
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 15:48:50 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA03364
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 15:48:49 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id KAA29371
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 10:48:14 -0500 (EST)
Date: Tue, 6 Feb 2001 10:48:14 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: Re: PPC port of SELinux
In-Reply-To: <Pine.SOL.3.95.1010206084949.24039C-100000@clipper.gw.tislabs.com>
Message-ID: <Pine.SOL.3.95.1010206104325.24039N-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


Just to be clear, the level-of-effort estimate that I provided was for
porting all of the changes from 2.2.12 to 2.4.1.  That includes all of the
architecture-independent changes as well as the architecture-specific
changes, and it involves dealing with the changes that have occurred
between the 2.2 and 2.4 kernels.  Merely porting the architecture-specific
changes to a different architecture like the PPC should be a much simpler
task.  Only a few modifications were made to the architecture-specific
files in arch/i386 and include/asm-i386, and it should be easy to
transfer most of those changes to a different architecture.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
