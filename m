Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9HEXCrT016581
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 10:33:14 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9HEX88B029857
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 14:33:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris PeBenito <pebenito@gentoo.org>
Subject: Re: gentoo merge for postfix
Date: Mon, 18 Oct 2004 00:32:51 +1000
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   petre rodan <kaiowas@gentoo.org>, SELinux Mail List <selinux@tycho.nsa.gov>
References: <417149C9.9010102@gentoo.org> <20041017111346.GA2537@jmh.mhn.de> <1098017540.6785.7.camel@chris.pebenito.net>
In-Reply-To: <1098017540.6785.7.camel@chris.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410180032.52049.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 17 Oct 2004 22:52, Chris PeBenito <pebenito@gentoo.org> wrote:
> On Sun, 2004-10-17 at 13:13 +0200, Thomas Bleher wrote:
> > * petre rodan <kaiowas@gentoo.org> [2004-10-17 00:55]:
> > > can you please ifdef 'rhgb_domain(postfix_master_t)' since it's not
> > > part of some distros?
> >
> > I disagree. rhgb_domain() is a no-op if you don't use rhgb.te. Using
> > additional ifdefs just makes the policy harder to read.
>
> That is assuming rhgb_macros.te is included.  It is not included in
> Gentoo's policy since we never use it.  I'm not going to add unneeded
> files to fix something thats not properly ifdef'ed.

If that's the approach you want to take then you should submit a patch that 
makes equivalent changes to can_ypbind() and lots of other macros.

The current behaviour of such macros is intentional, it is designed to make 
the policy smaller and easier to read.  It is not an omission, it is a design 
decision.

It would not be difficult for you to put in a macros file that does null 
declarations of all the macros that you don't want in a single file, thus 
achieving your goal of a minimum number of macros files while not bloating 
the other policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
