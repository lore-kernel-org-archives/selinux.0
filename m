Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA01986
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 07:54:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id LAA13168
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 11:52:16 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id LAA13164 for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 11:52:16 GMT
Date: Tue, 1 Oct 2002 07:53:46 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: /dev/pty*
In-Reply-To: <Pine.GSO.4.33.0210010740110.1579-100000@raven>
Message-ID: <Pine.GSO.4.33.0210010749480.1579-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 1 Oct 2002, Stephen Smalley wrote:

> Possibly, but you are likely to need some additional rules.  We've always
> used the devpts pseudo filesystem (or alternatively, devfs now that
> Rogelio's patch has been merged) and haven't tried using SELinux with
> traditional /dev/pty* nodes.

In addition to policy changes, you'll also need to deal with more explicit
relabels for traditional /dev/pty* nodes.  With devpts or devfs, we can
automatically assign a derived type to the dynamically created pty node
based on the allocating process' domain, so when a user program allocates
a pty, the new pty automatically picks up the right type.  In contrast,
traditional /dev/pty* nodes will have to be explicitly relabeled.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
