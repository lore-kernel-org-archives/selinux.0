Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA04908
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 14:19:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA27046
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 18:19:20 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id SAA27042
	for <selinux@tycho.nsa.gov>; Tue, 28 May 2002 18:19:19 GMT
Date: Tue, 28 May 2002 14:19:04 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: devfs mysterious relabelling
In-Reply-To: <200205281404.g4SE4ju17785@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.33.0205281412320.1315-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 28 May 2002, Richard Gooch wrote:

> Or until the entry is unregistered (and if you haven't configured
> devfsd to restore permissions).

> Nope. Devfs currently uses it's own backing store (i.e. file tree),
> thus devfs dentries may be freed. That's going to change in 2.5,
> however.

Based on Richard's comments, I think that we will need hooks within the
kernel devfs code in order to preserve SIDs managed by devfsd on devfs
entries.  I can add it to our TODO list, but it isn't a high priority for
us at this time.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
