Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5EBcZrT017476
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 07:38:35 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5EBcPxZ001042
	for <selinux@tycho.nsa.gov>; Mon, 14 Jun 2004 11:38:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Greg Norris <haphazard@kc.rr.com>
Subject: Re: SELinux on Debian (Sid)
Date: Mon, 14 Jun 2004 21:38:23 +1000
Cc: selinux@tycho.nsa.gov
References: <20040609144404.GJ5477@philips.com> <20040613232622.GA13617@yggdrasil.localdomain> <20040614033955.GA14338@yggdrasil.localdomain>
In-Reply-To: <20040614033955.GA14338@yggdrasil.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406142138.23039.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 14 Jun 2004 13:39, Greg Norris <haphazard@kc.rr.com> wrote:
> On Sun, Jun 13, 2004 at 06:26:22PM -0500, Greg Norris wrote:
> > I case anyone else encounters this issue, I've submitted a bugreport
> > to the Debian bug-tracking system.  You can view it at
> > "http://bugs.debian.org/254219".
>
> Ok, I've finally managed to get the package to install... it turns out
> that I needed to include chkpwd.te and inetd.se in my policy
> selections.  I'm not actually using the corresponding software for
> either, but they apparently include some definitions which are needed
> by other policies.

Actually you do need chkpwd.te, the current SE Linux policy will not allow 
programs to authenticate against /etc/shadow unless you have chkpwd.te 
installed.

I have to change selinux-policy-default to not allow you to deselect 
chkpwd.te.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
