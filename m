Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA15764
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 12:59:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA24979
	for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 16:57:58 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id QAA24975 for <selinux@tycho.nsa.gov>; Mon, 10 Jun 2002 16:57:58 GMT
Date: Mon, 10 Jun 2002 12:58:16 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: auditing etc
In-Reply-To: <20020609085923.59B6E466@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206101250020.13767-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 9 Jun 2002, Russell Coker wrote:

> What are the future plans for auditing on SE Linux?

I think my comments from
http://marc.theaimsgroup.com/?l=selinux&m=97907408104978&w=2 are still
applicable on this topic.

> Also would it be possible to have an option in the debugging kernel build to
> send a signal 11 to a process that violates the security policy?  It would
> make it much easier to find out why it chose to do what I don't want...

Possibly, but this is _not_ the expected behavior for mandatory access
controls.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
