Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA27381
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2002 09:29:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA19160
	for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2002 14:28:38 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA19155 for <selinux@tycho.nsa.gov>; Wed, 23 Jan 2002 14:28:37 GMT
Date: Wed, 23 Jan 2002 09:29:13 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>, <rgooch@ras.ucalgary.ca>
Subject: Re: devfs_contexts
In-Reply-To: <20020123020122.13E9F330083@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0201230927270.12859-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 23 Jan 2002, Russell Coker wrote:

> Do you think it would make sense to have a SE version of devfsd that applied
> SE SID's at the same time as applying regular permissions to devfs managed
> device nodes?  It makes sense to me to have both regular file system
> permissions and SE sids applied at the same time.

Yes, this would make sense.  You would also need to define a domain for
devfsd.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
