Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA06583
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 15:00:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA11176
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 18:58:55 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id SAA11172
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 18:58:55 GMT
Date: Mon, 6 May 2002 15:00:39 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: devfs systems and no devfsd
In-Reply-To: <20020506142058.1722D81376@coffeesaur2.evoserve.com>
Message-ID: <Pine.GSO.4.33.0205061453550.20696-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 6 May 2002, Debian User wrote:

> Can we use selinux with a devfs kernel but no devfsd?

Good question.  We don't use devfs on our systems, but we added the
devfs_contexts configuration as a simple mechanism for devfs users.  Then,
Russell created the devfsd module, which I had assumed would largely
supplant the use of devfs_contexts.  However, since devfs is intended to
work even without devfsd, I suppose that we should retain devfs_contexts
to support such operation.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
