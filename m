Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h844nCLa006650
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2003 00:49:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h844nBet013401
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2003 04:49:11 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h844n9lq013396 for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2003 04:49:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom <tom@lemuria.org>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Enable SELinux via boot parameter
Date: Thu, 4 Sep 2003 14:49:23 +1000
References: <20030903145423.D3990@lemuria.org> <Pine.LNX.4.44.0309031217030.15283-100000@thoron.boston.redhat.com> <20030903195451.E32398@lemuria.org>
In-Reply-To: <20030903195451.E32398@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309041449.23651.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 4 Sep 2003 03:54, Tom wrote:
> Maybe we should actually ask a distro or two what they think, though.

That's been done.  James and I are employed by Red Hat, and I also represent 
the interests of the Debian project when it comes to SE Linux kernel issues.

All of the options that we discussed seemed OK to me for Debian.  I don't 
think it's much of a big deal.  Having a distribution kernel with minor 
variations from the kernel.org kernel is expected, so whether things default 
to on or off doesn't matter too much IMHO.

Distributions which don't like the idea can always patch it out.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
