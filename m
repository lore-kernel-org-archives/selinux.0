Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5344lrT009559
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 00:04:47 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5444S0x018464
	for <selinux@tycho.nsa.gov>; Fri, 4 Jun 2004 00:04:29 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: issue with SE/Linux - sshd not giving access to /dev/pts/[n]
Date: Thu, 3 Jun 2004 14:04:35 +1000
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
References: <20040601090345.GM8312@lkcl.net> <200406021631.50230.russell@coker.com.au> <1086196986.15871.106.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1086196986.15871.106.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406031404.35028.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 3 Jun 2004 03:23, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > There is a bug in the SE Linux pam code or in sshd which results in the
> > terminal not being correctly relabelled in some situations.  Someone
> > (maybe you) needs to debug this.  I would guess that the PAM code is
> > doing the wrong thing, the PAM code in question is in Fedora and in my
> > repository for SE Linux Debian packages.  It is not in the main-line PAM
> > distribution because nothing happens there.
>
> I hadn't seen such a bug report previously - is this also true of the
> RedHat openssh package (still based on 3.6.1p2) or is it new to 3.8?  If
> using pam doesn't work with 3.8 (e.g. if they have moved the call to
> pam_open_session such that it is no longer performed at the right point
> in processing for us to set the exec context and relabel the pty), then

I don't think it occurred on 3.6.x.  It occurs on both Fedora and Debian, but 
does not always happen.  I'm not sure of the exact cause.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
