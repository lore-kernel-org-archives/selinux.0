Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA21277
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 08:46:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA15419
	for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 12:44:42 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA15415 for <selinux@tycho.nsa.gov>; Fri, 21 Jun 2002 12:44:41 GMT
Date: Fri, 21 Jun 2002 08:45:25 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: Russell Coker <russell@coker.com.au>, <selinux@tycho.nsa.gov>
Subject: Re: selinux cramfs
In-Reply-To: <Pine.GSO.4.33.0206210807570.12888-100000@raven>
Message-ID: <Pine.GSO.4.33.0206210844000.12888-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 21 Jun 2002, Stephen Smalley wrote:

> You might be able to handle cramfs to some degree using the new
> genfs_contexts configuration, which is a generalization of devfs_contexts.
> That isn't in the current release, but will be in the next one.

I just tried using genfs_contexts to specify a context for cramfs and
then mounting a cramfs image, and it appears to work correctly.  So this
will hopefully be addressed by the next public release.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
