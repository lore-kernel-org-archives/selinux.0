Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6Q3eBrT022243
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 23:40:11 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6Q3e8Yd013675
	for <selinux@tycho.nsa.gov>; Mon, 26 Jul 2004 03:40:09 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: Selinux possible on Debian-Linux/ppc?
Date: Mon, 26 Jul 2004 13:40:04 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <1090769556.7265.32.camel@debby>
In-Reply-To: <1090769556.7265.32.camel@debby>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407261340.04981.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 26 Jul 2004 01:32, Wolfgang Pfeiffer <roto@gmx.net> wrote:
> But I'm not quite sure whether SElinux will run on that machine, and on
> Debian-ppc ...

It is expected to work, I think that the Gentoo people have been getting PPC 
machines to run SE Linux.

> But a quick search for SElinux packages for my system gives this:
>
>       * checkpolicy - SELinux policy compiler
>       * libselinux1 - SELinux shared libraries
>       * libselinux1-dev - SELinux development headers
>       * policycoreutils - SELinux core policy utilities
>       * selinux-doc - documentation for Security-Enhanced Linux
>       * selinux-policy-default - Policy config files and management for
>         NSA Security Enhanced Linux
>       * selinux-utils - SELinux utility programs

You will need to compile ssh, dpkg, cron, sysvinit, logrotate, and pam with 
the SE Linux patches from my web site to get it going.  I only have i386 
architecture hardware, and a lot of my stuff hasn't been accepted into Debian 
yet.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
