Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6OHjIHa002283
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 13:45:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6OHjHDW001691
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 17:45:17 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h6OHjHeN001688 for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2003 17:45:17 GMT
Received: from columbia (rrcs-central-24-123-136-65.biz.rr.com [24.123.136.65])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "columbia.verbum.org", Issuer "verbum.org CA" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id A754132A6BB
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2003 01:49:39 -0400 (EDT)
Subject: Re: Linuxfromscratch.org
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
In-Reply-To: <200307231934.PAA18920@nerd-xing.mit.edu>
References: <200307231934.PAA18920@nerd-xing.mit.edu>
Content-Type: text/plain
Message-Id: <1059068428.1698.14.camel@columbia>
Mime-Version: 1.0
Date: 24 Jul 2003 13:40:28 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-07-23 at 15:34, karlm@mit.edu wrote:

> I believe Dean is mistaken and is actually referring to Ken Thompson's
> theoretical attack.  The point is you can't see if the backdoor
> exists.  Unless you have personally recreated the history of modern
> computing from first priciples in your basement or place of work, you
> may be 0wn3d and not know it, in theory.

The thing is though that to do any kind of "useful" damage (e.g. send
passwords back to the author), at some point the trojan is going to have
to connect to the network.  And if it does that, chances are some
careful network administrator somewhere is going to notice some strange
connections, eventually.  I mean, when your file server starts making
HTTP POST requests or whatever, you'd get very suspicious. 

It seems much harder to believe this trojan would have been able to
compromise all the network traffic sniffers out there.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
