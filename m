Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA09247
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 16:18:26 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA14393
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 21:17:49 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id VAA14388
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 21:17:48 GMT
Received: from localhost (sds@localhost)
	by raven.gw.tislabs.com (8.11.6/8.11.6) with ESMTP id fA8LHTW11038
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2001 16:17:30 -0500 (EST)
Date: Thu, 8 Nov 2001 16:17:29 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: Re: How can i configure this?
In-Reply-To: <Pine.GSO.4.33.0111081211180.17720-100000@raven>
Message-ID: <Pine.GSO.4.33.0111081607120.4512-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 8 Nov 2001, Stephen Smalley wrote:

> In any event, this particular AVC denied message looks
> like it is being caused by a problem in the SELinux support for assigning
> security contexts to devfs entries, which is experimental and isn't being
> actively used by us.  I'll have to look into it.

Hugo subsequently clarified via private email that he was using the old
(pre-LSM) SELinux prototype.  That prototype never supported assigning
security contexts to devfs entries, so it isn't surprising that they show
up as unlabeled_t, although it does look like there is a bug in the
assignment of the security class.  The devfs labeling support wasn't added
until the 2nd release of the LSM-based SELinux prototype (the 9/26
release).  However, as I mentioned above, even this support is
experimental and isn't being actively used by us, so I don't know how
well it will work for real devfs users.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
