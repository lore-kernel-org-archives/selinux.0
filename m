Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA06126
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 09:59:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA17417
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 13:59:19 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA17413
	for <selinux@tycho.nsa.gov>; Wed, 10 Jul 2002 13:59:19 GMT
Date: Wed, 10 Jul 2002 09:58:56 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Ed Street <blacknet@simplyaquatics.com>
cc: "'Russell Coker'" <russell@coker.com.au>,
        "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: cleaning psidfiles database
In-Reply-To: <007601c22818$6ee1e7a0$0a01a8c0@ed>
Message-ID: <Pine.GSO.4.33.0207100952070.26546-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 10 Jul 2002, Ed Street wrote:

> Speaking of make relabel.  Would it not be a good idea to run a relabel
> at boot time?

Not unless you really want to reset the system to the initial state
specified in file_contexts on each boot.  The persistent label mappings
track runtime changes made since the initialization, like file type
transitions for new files and individual relabels via chcon.  A 'make
relabel' on each boot will lose such runtime changes unless you update
your file contexts configuration or you exclude these files via <<none>>
entries.  'make relabel' is also slow, as it must traverse the entire
filesystem.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
