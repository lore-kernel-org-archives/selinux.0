Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72FtirT013730
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 11:55:44 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72Ft3XV029948
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 15:55:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: selinux-policy-default 1.14 is missing _stacks_ of stuff
Date: Tue, 3 Aug 2004 01:55:16 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20040801103252.GC7384@lkcl.net> <200408022323.48941.russell@coker.com.au> <1091459400.23582.83.camel@icampbell-debian>
In-Reply-To: <1091459400.23582.83.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408030155.16121.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Aug 2004 01:10, Ian Campbell <ijc@hellion.org.uk> wrote:
> > This means that you do it in the Debian way.  You install a package that
> > supplies what you want to do.
> >
> > Having two conflicting packages installed at once is not the Debian way.
>
> I appreciate that this is true for some packages, MTAs being the prime
> example. But what about packages that use the alternatives system --
> they do not conflict with each other even though they supply "the same
> thing".

This is true for cases such as nvi vs vim.  You can install both nvi and vim 
on the same system, some users will prefer one and configure their account 
(by putting an alias in ~/.bash_profile or similar) for their preferred 
editor.  Some users won't really care because they use so few features that 
both nvi and vim are the same to them, they can just run "vi" and get 
whichever it's linked to.

SE Linux policy is quite different.  Turning off SE Linux enforcement, 
relabelling all file systems, rm'ing files from /tmp and /var/tmp, rebooting, 
and maybe having to unlink some temporary files that were created during the 
shutdown process is quite a serious and significant operation.

I might say to myself "hey I think I'll try a different vi today", but the 
decision to change to a different SE Linux policy is much more significant.

When someone else packages a SE Linux policy for Debian we can review this.  I 
think that I have done a decent job of planning for multiple policies over 
the last 3 years even though there has only been one policy in Debian.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
