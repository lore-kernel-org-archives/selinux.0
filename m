Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72DNsrT012149
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 09:23:54 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72DNJXV018521
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 13:23:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: selinux-policy-default 1.14 is missing _stacks_ of stuff
Date: Mon, 2 Aug 2004 23:23:48 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040801103252.GC7384@lkcl.net> <200408012254.15553.russell@coker.com.au> <1091452092.23449.33.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1091452092.23449.33.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408022323.48941.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2 Aug 2004 23:08, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Sun, 2004-08-01 at 08:54, Russell Coker wrote:
> > There is no support for targeted in Debian, only strict and it has the
> > directory name "." .
> >
> > > so, i can't use run_init because targeted/contexts/initrc_context
> > > doesn't exist.
> >
> > Your /etc/selinux/config file should have the following line:
> > SELINUXTYPE=.
>
> What does this mean for supporting multiple policies in Debian?

This means that you do it in the Debian way.  You install a package that 
supplies what you want to do.

Having two conflicting packages installed at once is not the Debian way.

Of course changing a system from one policy package to another will be 
awkward, but I think I can make it no more painful than it has to be (relabel 
and reboot).  Not that it really matters while there's only one policy 
available in Debian.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
