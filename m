Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA04201
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 09:17:47 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA25495
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 14:17:45 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id OAA25491
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2001 14:17:44 GMT
Date: Tue, 6 Feb 2001 09:16:21 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Smith, Randall B" <rbsmith@sandia.gov>
cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: PPC port of SELinux
In-Reply-To: <9A4B2157EFDBE546BECD68C62AC3B1C801C803C5@es05snlnt>
Message-ID: <Pine.SOL.3.95.1010206084949.24039C-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Mon, 5 Feb 2001, Smith, Randall B wrote:

> Is anyone working on a Power PC / Macintosh G4 port of SELinux? If so, can
> you say something about the status of the work?

I'm not aware of anyone working on ports to any other architecture yet.
However, only a small portion of the SELinux changes are in the
architecture-specific headers and code, so a port to other
architectures should not be difficult.  

> Also, can anyone provide a ballpark estimate on the level-of-effort for the
> 2.2.12 enhancements and/or the anticipated effort for the 2.4 port?

I'm not sure about an estimate for the level-of-effort for the original
2.2.12 enhancements, since they were spread over a longer period of time.
We are currently finishing up a port to 2.4.1 now. I would estimate that
the effort has taken around 2 person-months of effort.  However, part of
that time is also attributable to some enhancements that were made during
the port.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
