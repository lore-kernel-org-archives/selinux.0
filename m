Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i76NW5rT015353
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 19:32:05 -0400 (EDT)
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i76NW3qv008954
	for <selinux@tycho.nsa.gov>; Fri, 6 Aug 2004 23:32:04 GMT
Subject: Re: Build error pam on ppc
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200408061646.12198.russell@coker.com.au>
References: <1091728350.2840.49.camel@debby>
	 <200408061646.12198.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1091835108.5709.102.camel@debby>
Mime-Version: 1.0
Date: Sat, 07 Aug 2004 01:31:48 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-06 at 08:46, Russell Coker wrote:
> On Fri, 6 Aug 2004 03:52, Wolfgang Pfeiffer <roto@gmx.net> wrote:
> > Hi All
> >
> > When I built *successfully* pam on ppc with
> >
> > fakeroot apt-get source --compile pam=0.77-0.se5
> >
> > I got this error, that I *ignored*:
> >
> > ----------------------------------------
> >
> > mkdir -p /home/shorty/russellpackages/pam/pam-0.77/debian/tmp/lib
> > /usr/bin/install -m 755 libpamc.so
> > /home/shorty/russellpackages/pam/pam-0.77/debian/tmp/lib/libpamc.so.0.77
> > /sbin/ldconfig
> > /sbin/ldconfig: Can't create temporary cache file /etc/ld.so.cache~:
> > Permission denied make[2]: *** [install] Error 1
> 
> I recall getting the same error on i386.  I just ignored it, but probably we 
> should have a bug report filed about that if you can reproduce it on the 
> version of PAM that's in Debian.

I'll try to compile a stock Debian PAM this weekend, and if I see this
error on that build, too, I'll file a bug report ... 

Nice weekend

Best Regards
Wolfgang
-- 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
