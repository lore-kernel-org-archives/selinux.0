Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i766kLrT010525
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 02:46:21 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i766kJO0014709
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 06:46:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: Build error pam on ppc
Date: Fri, 6 Aug 2004 16:46:12 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <1091728350.2840.49.camel@debby>
In-Reply-To: <1091728350.2840.49.camel@debby>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408061646.12198.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 6 Aug 2004 03:52, Wolfgang Pfeiffer <roto@gmx.net> wrote:
> Hi All
>
> When I built *successfully* pam on ppc with
>
> fakeroot apt-get source --compile pam=0.77-0.se5
>
> I got this error, that I *ignored*:
>
> ----------------------------------------
>
> mkdir -p /home/shorty/russellpackages/pam/pam-0.77/debian/tmp/lib
> /usr/bin/install -m 755 libpamc.so
> /home/shorty/russellpackages/pam/pam-0.77/debian/tmp/lib/libpamc.so.0.77
> /sbin/ldconfig
> /sbin/ldconfig: Can't create temporary cache file /etc/ld.so.cache~:
> Permission denied make[2]: *** [install] Error 1

I recall getting the same error on i386.  I just ignored it, but probably we 
should have a bug report filed about that if you can reproduce it on the 
version of PAM that's in Debian.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
