Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5C2JIrT008579
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 22:19:18 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5C2JD1j000522
	for <selinux@tycho.nsa.gov>; Fri, 11 Jun 2004 22:19:14 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Date: Sat, 12 Jun 2004 12:19:12 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040609214126.GF5727@lkcl.net> <200406111107.39205.russell@coker.com.au> <20040611230218.GI2861@lkcl.net>
In-Reply-To: <20040611230218.GI2861@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406121219.12208.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 12 Jun 2004 09:02, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> On Fri, Jun 11, 2004 at 11:07:39AM +1000, Russell Coker wrote:
> > On Fri, 11 Jun 2004 07:11, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
wrote:
> > > ?if it bit me (who is coming into this blind with no prior
> > > ?knowledge or expectations other than "install it and find out
> > > ?how to fix it if it's broke") then it's definitely going to
> > > ?bite other people.
> >
> > http://www.coker.com.au/selinux/tweaks.html
>
> ah ha!  thank you russell.
>
> i'm raising wish-list bug report items for some of these in
> debian because if you think hundreds and thousands of people,
> a good proportion of them are not going to know about that
> document.

A good thing you could raise would be removal of the 
old /dev/[tp]ty[abcdepqrstuvwxyz][0-9a-f] nodes.  I don't think that there is 
any good reason to have BSD pty nodes in Debian.  It will probably take some 
work to get this done however.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
