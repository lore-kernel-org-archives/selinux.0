Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA05322
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 08:01:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA00824
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 12:01:12 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA00820
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 12:01:11 GMT
Date: Mon, 15 Jul 2002 08:01:10 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Brian May <bam@snoopy.apana.org.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: currupt policy.11 file
In-Reply-To: <20020715042551.A39C7424F@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0207150756180.29432-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 15 Jul 2002, Russell Coker wrote:

> On Mon, 15 Jul 2002 03:43, you wrote:
> > I accidently currupted my policy.11 file, probably by loading it before
> > it had been fully written (yes, stupid thing to do).
> >
> > Anyway, the effect of this was my computer promptly crashed.
> > By this I mean it was running extremely slowly, and eventually
> > refused to respond to any user input.

I'd be interested in obtaining a copy of the corrupted policy.11 file so
that I can try to reproduce the error.  I just tried loading a truncated
policy.11 file (both a truncated compressed policy.11 and a truncated
uncompressed policy.11), and in both cases, the security server reported
an appropriate error during the load and continued operating under the old
policy.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
