Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA22603
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 08:46:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA24366
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 12:45:15 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA24362
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 12:45:14 GMT
Date: Thu, 29 Aug 2002 08:45:48 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: makefile patch
In-Reply-To: <20020828141944.7F9263F5F@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208290844400.2189-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 28 Aug 2002, Russell Coker wrote:

> In the post-install script of my selinux-policy-default package I have the
> following:
>   make -s -C /etc/selinux install
>   make -s -C /etc/selinux load || true
>
> This results in the policy being compiled twice when using the NSA Makefile,
> I've attached a patch to fix this.

This breaks if you don't already have a tmp directory pre-created.  Try
removing your tmp directory and doing a make (or a make policy.conf).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
