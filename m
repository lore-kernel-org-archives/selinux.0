Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA13341
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 11:05:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA28052
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 16:04:44 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA28048
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 16:04:43 GMT
Date: Thu, 11 Jan 2001 11:04:32 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: selinux@tycho.nsa.gov, linux-privs-discuss@sourceforge.net
Subject: Re: [Linux-privs-discuss] SELinux & Linux-privs projects
In-Reply-To: <20010111164556.A2075@caldera.de>
Message-ID: <Pine.SOL.3.95.1010111104920.23465S-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Thu, 11 Jan 2001, Christoph Hellwig wrote:

> Linux-privs and other Posix1003.1e subsystems currenlty in development
> for Linux provide a UNIXish way of trusted systems, while SELinux
> implements ruleset-based security and is rather differnt and put
> policy into the kernel, something that is dtringly disliked in UNIX.
> 
> So they are two rather different ways to achieve the same goal.

Allow me to clarify about SELinux.  I'll respond to your points
in reverse order.  SELinux and Linux-privs are NOT different ways
to achieve the same goal.  SELinux provides a flexible mandatory
access control architecture.  The architecture can enforce a wide
variety of security policies.  It can enforce the separation of
information based on confidentiality and integrity requirements.
This is quite different from Linux Privs, which provides a mechanism
for decomposing superuser privileges.  It is also quite different
from POSIX.1e mandatory access controls, which are tied to a 
specific kind of mandatory security policy.

It is also inaccurate to suggest that the issue is placing policy
in the kernel.  SELinux provides clean separation of policy from
enforcement, with the security policy cleanly encapsulated
in a single component of the operating system called the
security server with a general interface.  Many different
security server implementations are possible, including
implementations that consult user space servers.  The
example security server implementation consists of a
basic policy engine that consults a security policy configuration
read from a file.  This is also a false comparison, because
the POSIX.1e mandatory access control policy implementation would
likewise involve a kernel component, and it is more likely to
involve policy-specific code being used by other components of
the kernel.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
