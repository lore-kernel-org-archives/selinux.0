Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8KFH9rT018257
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 11:17:09 -0400 (EDT)
Received: from kokytos.rz.informatik.uni-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8KFGAoq001375
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 15:16:11 GMT
Received: from rom.cip.ifi.lmu.de (rom.cip.informatik.uni-muenchen.de [141.84.214.183])
	by kokytos.rz.informatik.uni-muenchen.de (Postfix) with ESMTP id 87856435BA
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 17:17:02 +0200 (CEST)
Date: Mon, 20 Sep 2004 17:17:01 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: selinux@tycho.nsa.gov
Subject: Re: [RFC] Upstream policy handling
Message-ID: <20040920151701.GA17900@rom.cip.ifi.lmu.de>
References: <414DA0A7.1000708@gentoo.org> <1095631736.4431.27.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1095631736.4431.27.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Colin Walters <walters@verbum.org> [2004-09-20 01:17]:
> On Sun, 2004-09-19 at 11:07 -0400, Joshua Brindle wrote:
> > If there are any other suggestions or comments on this I'd like to hear 
> > them. Obviously the implementation details are up in the air here, and I 
> > know that some of you can't/won't use bk. 
> >
> > If there are suggestions for a 
> >   better system and a way to host it (preferably neutrally) that would 
> > be great.
> 
> If you are set on this, I suggest GNU Arch.  It is actually better than
> Bitkeeper in a number of ways (besides the obvious one of licensing);
> for example, it supports cherry-picking (applying individual
> changesets), and doesn't require anything other than an unmodified web
> server for read access. 

I'd like to add a data point here: I have been using Arch for all my
policy work and it just works great. Arch makes it very easy to have
parallel branches and to merge between them. I don't think I would have
been able to keep my policy in sync with the fedora policy without arch.

Personally I think it is better to have one policy which governs all
distros. But regardless how this is decided, I think it would be great
if all policies were easily accessible in one place. Recently I wanted
to add the gentoo policy into my arch repository so I could compare the
approaches and see which changes had been made. However I could not find
the gentoo policy in an easily accessible format (a tarball with all
policy, cvs repository, ...). If anyone can recommend a method to get
it, I would be really thankful.

Thomas

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
