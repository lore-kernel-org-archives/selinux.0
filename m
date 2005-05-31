Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4VB76gA000722
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 07:07:06 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4VB1DC0007475
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 11:01:13 GMT
Date: Tue, 31 May 2005 12:09:48 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Joshua Brindle <method@gentoo.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>, selinuxdev <selinux-dev@tresys.com>
Subject: Re: smaller memory footprint for 'strict' policy - helping gentoo as well
Message-ID: <20050531110947.GB4131@lkcl.net>
References: <20050531012824.GI28006@lkcl.net> <429BCDDD.8080106@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <429BCDDD.8080106@gentoo.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, May 30, 2005 at 10:37:17PM -0400, Joshua Brindle wrote:

> >... surely... there's some analysis done by the m4 macro
> >compiler that automatically removes "unwanted" / "unused"
> >macros?
> >
> >could that be done as a separate pre-pass / analysis step,
> >making it unnecessary to consider a macros/unused directory?
> >
> > 
> >
> Why? if the macro is unused it never makes it past the policy.conf which 
> you shouldn't be reading directly anyway, aside from debugging.
 
 okay - then i must have misunderstood what valdis has done that
 reduces the memory footprint so dramatically.

 i mean, _yes_ of course, personally, i remove any policy
 domains that aren't used, i assume that naturally _everybody_
 does that because otherwise a package could be installed
 without consent and it would work (whereas if the policy
 isn't there, it will definitely fail).

 i am confused.

 valdis, hi, any chance you could elaborate?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
