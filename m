Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72FA4rT013230
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 11:10:05 -0400 (EDT)
Received: from mta02-svc.ntlworld.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72FA3KV014555
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 15:10:03 GMT
Subject: Re: selinux-policy-default 1.14 is missing _stacks_ of stuff
From: Ian Campbell <ijc@hellion.org.uk>
To: russell@coker.com.au
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200408022323.48941.russell@coker.com.au>
References: <20040801103252.GC7384@lkcl.net>
	 <200408012254.15553.russell@coker.com.au>
	 <1091452092.23449.33.camel@moss-spartans.epoch.ncsc.mil>
	 <200408022323.48941.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1091459400.23582.83.camel@icampbell-debian>
Mime-Version: 1.0
Date: Mon, 02 Aug 2004 16:10:00 +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-02 at 14:23, Russell Coker wrote:
> On Mon, 2 Aug 2004 23:08, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > On Sun, 2004-08-01 at 08:54, Russell Coker wrote:
> > > There is no support for targeted in Debian, only strict and it has the
> > > directory name "." .
> > >
> > > > so, i can't use run_init because targeted/contexts/initrc_context
> > > > doesn't exist.
> > >
> > > Your /etc/selinux/config file should have the following line:
> > > SELINUXTYPE=.
> >
> > What does this mean for supporting multiple policies in Debian?
> 
> This means that you do it in the Debian way.  You install a package that 
> supplies what you want to do.
> 
> Having two conflicting packages installed at once is not the Debian way.

I appreciate that this is true for some packages, MTAs being the prime
example. But what about packages that use the alternatives system --
they do not conflict with each other even though they supply "the same
thing".

However I don't claim to know enough about SE Linux and/or Debian's
policies (although I am long-time Debian user) to say which of the two
situations is the most suitable model for SE Linux policies.

Ian.
-- 
Ian Campbell
Current Noise: Kreator - Awakening of the Gods



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
