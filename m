Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA11923
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 09:03:22 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA22363
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 14:02:46 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA22359
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 14:02:45 GMT
Date: Thu, 11 Jan 2001 09:01:41 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: =?iso-8859-2?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
cc: selinux@tycho.nsa.gov
Subject: Re: [selinux] Re: SELinux and covert channels
In-Reply-To: <20010111005355.A20214@bunuel.tii.matav.hu>
Message-ID: <Pine.SOL.3.95.1010111084456.23465H-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Thu, 11 Jan 2001, [iso-8859-2] Magosányi Árpád wrote:

> When a process
> -cannot see the existence of an other process (policy enforced on /proc)
> -cannot ipc with another process (policy enforced on sysv ipc mechanisms and sockets)
> -cannot use the same files as the other (policy enforced on files)
> and cannot send signals to another process (policy enforced on kill)
> how do the two processes create a covert channel?

Even with mandatory access controls implemented for each of the kernel
services, there are still channels related to shared resources such
as the /tmp directory, the process identifier number space, or
the TCP and UDP port number spaces.  But this is still a significant
improvement over the situation where there are no mandatory access
controls and there are numerous high-bandwidth _overt_ channels.

I think that Bill Kutz's message on the topic of covert channels (10 Jan
2001, william.r.kutz@lmco.com) is very much on target.  The focus now
should be on reviewing the SELinux mandatory access control architecture,
the security policy decision interfaces and the control points in the
process management, file system, and networking code.  Additionally, as
mentioned by Bill, it would be useful to evaluate how effective the
SELinux mechanisms are at countering known threats.  A covert channel
analysis would be premature at this point.

> BTW which of the above is not implemented yet?

In the current release, mandatory controls are not implemented for
the System V IPC mechanisms, although a design for such controls
is described in the documentation.  That design has undergone
some revision, and System V IPC controls have been implemented at
the NSA, but they have not yet been incorporated into the release.
Additionally, although mandatory access controls have been implemented
for sockets, the controls are currently limited because support
for communicating packet labels across the network has not yet
been implemented.  As discussed in the documentation, the intent is
to use IPSEC security associations to implicitly label packets
once IPSEC is integrated.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
