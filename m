Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA23890
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 09:27:53 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA21092
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 14:27:11 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id OAA21088
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 14:27:11 GMT
Date: Mon, 3 Dec 2001 09:26:55 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Paul Krumviede <pwk@acm.org>
cc: selinux <selinux@tycho.nsa.gov>
Subject: RE: use of ps in ipsec shutdown
In-Reply-To: <145184994.1007125560@localhost>
Message-ID: <Pine.GSO.4.33.0112030925150.4293-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 30 Nov 2001, Paul Krumviede wrote:

> while this would suppress the warnings, what would happen
> if one wanted to restart the ipsec stuff, perhaps because of
> a config file change, when in enforcing mode? it would seem
> that stopping the service would fail (actually, it would look like
> it worked, but because _realsetup wouldn't think that pluto is
> running, pluto wouldn't be shut down) and i don't know what
> would be the result of the subsequent start.

As long as _realsetup is running in ipsec_t, it should be able to
see the pluto daemon and kill it.  But I'm wondering if _realsetup
should really run in a separate domain (e.g. ipsec_client_t) that
can see the ipsec_t domain and communicate with it, but cannot directly
access PF_KEY sockets.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
