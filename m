Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6VIVGHa004722
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 14:31:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6VIVEDY018093
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 18:31:15 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Don Mills <drm2@dss.state.va.us>
Reply-To: drm2@dss.state.va.us
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Problems compiling libsecure
Date: Thu, 31 Jul 2003 14:31:02 -0400
Cc: selinux@tycho.nsa.gov
References: <200307311353.59002.drm2@dss.state.va.us> <1059674982.1052.252.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1059674982.1052.252.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200307311431.02417.drm2@dss.state.va.us>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,
	Yep that fixed it.  Much thanks.
	D


On Thursday 31 July 2003 02:09 pm, Stephen Smalley wrote:
> On Thu, 2003-07-31 at 13:53, Don Mills wrote:
> > To any helpful soul:
> > 	I am trying to compile and install the latest SE linux (2003071106) from
> > the lsm-2.4-selinux-2003071106.tgz package.  I am following the step by
> > step instructions rather than the quick install, and everything is
> > proceeding fine until I attempt to compile libsecure whereupon I
> > get(pardon my linewrap):
> >
> > cc -o fstat_secure.o -c -I../include -I/usr/local/selinux/include\
> > fstat_secure.c
> > In file included from fstat_secure.c:5:
> > xstat_conv.h: In function `xstat_conv':
> > xstat_conv.h:59: structure has no member named `st_atim'
> > xstat_conv.h:60: structure has no member named `st_atim'
> > xstat_conv.h:61: structure has no member named `st_mtim'
> > xstat_conv.h:62: structure has no member named `st_mtim'
> > xstat_conv.h:63: structure has no member named `st_ctim'
> > xstat_conv.h:64: structure has no member named `st_ctim'
> > make[1]: *** [fstat_secure.o] Error 1
> >
> > Now I don't profess to be a C programmer (or even close!) but I think
> > that bit of code is calling for the kernel's stat structure?  I tried
> > copying the lsm-2.4 /include/asm/stat* to the libsecure/include but no
> > help there...I also tried commenting out various includes from
> > kernel_stat.h but no help there either.
> > Other possibly helpful info: compiling on 2.4.7 kernel w/ gcc 2.96
> > 20000731 (old RedHat 7.1 laptop).  Any thoughts?
>
> The stat structure definition changed in more recent glibc's.  To make
> it work with your older glibc, save the attached patch to
> ~/oldstat.patch, cd selinux/libsecure, and run 'patch -p1 <
> ~/oldstat.patch'.  Then try building it again.
>
> This issue (and libsecure) will be obsoleted by the back port of the
> 2.5/6 SELinux API changes and xattr support to the 2.4-based SELinux,
> coming soon.  At that point, the same userland and policy should be
> useable for both versions of SELinux.

-- 
Don Mills
SCSA SCNA CCNP CCDP
CISSP CQS-VPN
Network Security/WAN Architect
VA Dept. of Social Services
drm2@dss.state.va.us



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
