Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA04555
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 08:49:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA19396
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 12:47:06 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA19392
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 12:47:06 GMT
Date: Mon, 6 May 2002 08:47:56 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Debian User <rogelio@evoworks.evoserve.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: preferred way to configure devfs contexts
In-Reply-To: <20020505144746.A353E8145A@coffeesaur2.evoserve.com>
Message-ID: <Pine.GSO.4.33.0205060846090.28613-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 5 May 2002, Debian User wrote:

> devfs_context is fast becoming my preferred way to configure
> /dev contexts. Can we do away with the hacked devfsd?

I'd actually expect the devfsd module to become mainstream, and the
devfs_contexts to be minimized or eliminated.  The devfsd module appears
to be the more general solution.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
