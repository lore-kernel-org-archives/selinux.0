Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA03276
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 16:31:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA27318
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 20:31:03 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id UAA27314
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2001 20:31:02 GMT
Date: Tue, 3 Jul 2001 16:30:45 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Levi A Bard <labard@ole.augie.edu>
cc: selinux@tycho.nsa.gov
Subject: Re: checkpolicy fails - compiler probs
In-Reply-To: <200107032011.UAA06380@jazzband.ncsc.mil>
Message-ID: <Pine.SOL.3.95.1010703162752.5583v-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 3 Jul 2001, Levi A Bard wrote:

> There have been notorious and well-documented problems with
> the C compiler installed by Redhat 7.0, hence the need for
> kgcc (just an earlier version of gcc) with that
> distribution.  

With regard to the checkpolicy problem, it really was a bug
in the checkpolicy program, not just a compiler problem.
See my patch from the archives for a fix.  I don't know whether
the other problem (with 'make relabel') is a bug in the
setfiles program or if it is a compiler problem.  

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
