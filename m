Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA14494
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 12:50:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA15466
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 17:49:05 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA15460
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 17:49:04 GMT
Received: from coalstove.epoch.ncsc.mil (coalstove [144.51.25.13])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA11408
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 12:50:28 -0500 (EST)
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA13474
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 11:16:17 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA10883
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 16:14:50 GMT
Received: from ns.caldera.de (ns.caldera.de [212.34.180.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA10879
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 16:14:49 GMT
Date: Thu, 11 Jan 2001 17:16:02 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Stephen Smalley <sds@tislabs.com>
Cc: selinux@tycho.nsa.gov, linux-privs-discuss@sourceforge.net
Subject: Re: [Linux-privs-discuss] SELinux & Linux-privs projects
Message-ID: <20010111171602.B5816@caldera.de>
References: <20010111164556.A2075@caldera.de> <Pine.SOL.3.95.1010111104920.23465S-100000@clipper.gw.tislabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SOL.3.95.1010111104920.23465S-100000@clipper.gw.tislabs.com>; from sds@tislabs.com on Thu, Jan 11, 2001 at 11:04:32AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Thu, Jan 11, 2001 at 11:04:32AM -0500, Stephen Smalley wrote:
> Allow me to clarify about SELinux.  I'll respond to your points
> in reverse order.  SELinux and Linux-privs are NOT different ways
> to achieve the same goal.  SELinux provides a flexible mandatory
> access control architecture.  The architecture can enforce a wide
> variety of security policies.  It can enforce the separation of
> information based on confidentiality and integrity requirements.
> This is quite different from Linux Privs, which provides a mechanism
> for decomposing superuser privileges.

The capabilities do that, right.  But if I'm not completly wrong
Linux-Privs stands for all the Posix 1003.1e stuff, but currently
only caps are implemented, though work is done on other parts
(acl, aud, mac).

> It is also quite different
> from POSIX.1e mandatory access controls, which are tied to a 
> specific kind of mandatory security policy.

Capabilities and mac are of course different, otherwise you probably
won't find them in the same posix standard...

> It is also inaccurate to suggest that the issue is placing policy
> in the kernel.  SELinux provides clean separation of policy from
> enforcement, with the security policy cleanly encapsulated
> in a single component of the operating system called the
> security server with a general interface.  Many different
> security server implementations are possible, including
> implementations that consult user space servers.

Then you basically end up with rsbac.  But your current code does not
look like you provide support for that.

> The
> example security server implementation consists of a
> basic policy engine that consults a security policy configuration
> read from a file.  This is also a false comparison, because
> the POSIX.1e mandatory access control policy implementation would
> likewise involve a kernel component, and it is more likely to
> involve policy-specific code being used by other components of
> the kernel.

No.  The pocily for posix 1003.1e mac is set from usespace and stored
in extented attributes, at least in the TrustedBSD version, my initial
Linux hack and SGIs version.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
