Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA27482
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 08:55:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA25684
	for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 12:53:49 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA25680 for <selinux@tycho.nsa.gov>; Tue, 9 Jul 2002 12:53:48 GMT
Date: Tue, 9 Jul 2002 08:54:34 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: sshd_devpts_t
In-Reply-To: <3D2ACA61.6000400@evoworks.evoserve.com>
Message-ID: <Pine.GSO.4.33.0207090849460.27193-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 9 Jul 2002, Debian User wrote:

> Has this been fixed yet? I cant ssh into my pc anymore. Where should
> this be fixed?

I'm not sure what you are asking.  If you are using devfs, you will likely
need some additional allow rules for access to devpts_t, since the
per-domain pty labeling that we support for the devpts filesystem is not
implemented for the devfs filesystem.  If people want more complete devfs
support, the best way to get it would be to contribute some patches.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
