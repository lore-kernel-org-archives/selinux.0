Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA25334
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 09:08:55 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA11381
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 13:07:29 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA11377 for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 13:07:28 GMT
Date: Thu, 27 Jun 2002 09:07:53 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: modifying utilities to use libselinux
In-Reply-To: <3D1AB057.1040206@evoworks.evoserve.com>
Message-ID: <Pine.GSO.4.33.0206270845460.1331-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 27 Jun 2002, Debian User wrote:

> is it wise to modify utiliies to use libsecure? what kind of utilities
> besides login and ssh should use libsecure? how about screen? I had a
> big problem making it work in selinux.

The modified daemons and the new and modified utilities that are provided
with SELinux are described briefly in the Configuring the SELinux Policy
report (the Security-Aware Applications section).  The login and sshd
modifications are important for initially setting the security
context for user sessions.  You can then typically just use automatic
domain transitions within a user session to change permissions as
necessary as particular programs are executed.  I'm not sure why screen
would require modifications - can you clarify?

You can typically support applications transparently by configuring the
polcy appropriately.  In some cases, you may still choose to modify the
application in order to provide more information to users (e.g. the
modified ps and ls utilities to display contexts) or to better support
fine-grained access control (e.g. the modified logrotate to preserve log
file security contexts when they are rotated).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
