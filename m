Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA03996
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2001 09:20:11 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA15566
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2001 14:19:31 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id OAA15562
	for <selinux@tycho.nsa.gov>; Wed, 21 Nov 2001 14:19:31 GMT
Date: Wed, 21 Nov 2001 09:19:39 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Tracy R Reed <treed@ultraviolet.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: SELinux policy configuration tutorial?
In-Reply-To: <20011121023020.D6432@ultraviolet.org>
Message-ID: <Pine.GSO.4.33.0111210914570.3513-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 21 Nov 2001, Tracy R Reed wrote:

> No domain is currently allowed to bind http_port_t
>
> Why have fully defined policies for running apache if it isn't allowed to
> bind to the port? How can I allow this?

The technical reports aren't up-to-date.  The first report (Integrating
Flexible Support for Security Policies into the Linux Operating System)
still describes the design and implementation of the original
2.2-based SELinux kernel patch, not the LSM-based SELinux security
module.  We're working on a new technical report that describes the
LSM-based SELinux security module.  The second technical report (A
Security Policy Configuration for the Security-Enhanced Linux) describes
the original example security policy configuration that was developed for
the original SELinux on RH6.1, and doesn't reflect subsequent changes.
Much of it is still applicable, but this particular note about http_port_t
is not true in the current example policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
