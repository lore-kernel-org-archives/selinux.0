Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA06915
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 08:21:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA10597
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 12:20:42 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA10593
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 12:20:42 GMT
Date: Mon, 19 Aug 2002 08:21:05 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Brad Chapman <jabiru_croc@yahoo.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: psidfiles_init errors
In-Reply-To: <20020819120728.0A026846C@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208190820240.14458-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 19 Aug 2002, Russell Coker wrote:

> On Mon, 19 Aug 2002 13:51, you wrote:
> >          Does this functionality belong in setfiles? And if so, how hard
> > would it be to figure out a method to remove the bogus ...security entries?
>
> That's not possible on a running SE system, there is no kernel interface for
> it.

Yes, it belongs in setfiles, and you can use 'make reset' in the policy
directory followed by a reboot as a coarse-grained approach.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
