Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA07630
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 08:32:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA07860
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 12:32:28 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA07856
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 12:32:27 GMT
Date: Wed, 19 Jun 2002 08:32:13 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: new policy changes
In-Reply-To: <20020619122636.F3AA61C9F@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206190829240.17899-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 19 Jun 2002, Russell Coker wrote:

> Actually on my system it defaults to devfs_t which is the same as all the
> /dev/pts/* files (due to the problems with devpts labelling on devfs).  So I
> enabled writing to devfs_t character devices...

I see.  In our devfs_contexts configuration (now a subset of the
genfs_contexts configuration), we assign system_u:object_r:devpts_t to
/pts.  Although this doesn't address the goal of maintaining separate
types on ptys for different domains (when using devfs), it at least avoids
the need to grant such generic access to devfs_t.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
