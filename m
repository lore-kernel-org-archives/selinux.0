Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5ALv0rT002008
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 17:57:00 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5ALuvaH026010
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 17:56:57 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 10 Jun 2004 21:56:58 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BYWuO-0001mu-0Q
	for selinux@tycho.nsa.gov; Thu, 10 Jun 2004 21:16:24 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BYXV4-0000zp-SJ
	for selinux@tycho.nsa.gov; Thu, 10 Jun 2004 21:54:18 +0000
Date: Thu, 10 Jun 2004 21:54:18 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040610215418.GR2861@lkcl.net>
References: <20040609144404.GJ5477@philips.com> <200406101817.28861.russell@coker.com.au> <20040610120344.GM5477@philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040610120344.GM5477@philips.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 10, 2004 at 02:03:44PM +0200, Magnus Therning wrote:

> I forgot to mention the contents of my /etc/apt/sources.list:
> 
>  deb http://ftp.uk.debian.org/debian/ testing main non-free contrib
>  deb http://ftp.uk.debian.org/debian-non-US testing/non-US main contrib non-free
> 
>  deb http://ftp.uk.debian.org/debian/ unstable main non-free contrib
>  deb http://ftp.uk.debian.org/debian-non-US sid/non-US main contrib non-free
> 
>  deb http://www.coker.com.au/newselinux/ ./
> 
> This together with the following line in /etc/apt/apt.conf should give
> me a Sid system:
> 
>  APT::Default-Release "unstable";
> 
> I did a 'apt-get update' and a 'apt-get dist-upgrade' after this.
> 
> On Thu, Jun 10, 2004 at 06:17:28PM +1000, Russell Coker wrote:
> >On Thu, 10 Jun 2004 00:44, Magnus Therning <magnus-work@therning.org> wrote:
> >> Installing selinux-default-policy failed, make complains about
> >> 'chsid' not being present. These are the problems I run into when
> >> trying to complete the installation of the policies:
> >
> >Sounds like you have old SE Linux, that is ancient and no longer being
> >supported.  It is only supported to kernel 2.4.21 upstream and 2.4.22
> >on my web site (in the section that is no longer maintained).  I
> >strongly recommend the new SE Linux.
> 
> The selinux-default-policy came from the apt-repository mentioned above.
 
 ah, there _isn't_ one in newselinux, you mean the one from
 ftp.uk.debian.org.

 check that you have 1.12-1

 tell y'what, here's a list of packages i have installed:

 sez:/boot# dpkg -l | grep selinux
 ii  bsdutils       2.11z-4.selinu Basic utilities from 4.4BSD-Lite
 ii  fileutils      5.0-4.selinux. The GNU file management utilities (transitio
 ii  kernel-image-2 selinux.1.0    Linux kernel binary image for version 2.6.6-
 ii  libpam-doc     0.76-13.selinu Documentation of PAM
 ii  libselinux1    1.12-1         SELinux shared libraries
 ii  libselinux1-de 1.12-1         SELinux development headers
 ii  mount          2.11z-4.selinu Tools for mounting and manipulating filesyst
 ii  psmisc         21.3-1.selinux Utilities that use the proc filesystem
 ii  selinux-policy 1.12-1         Policy config files and management for NSA S
 ii  selinux-utils  1.12-1         SELinux utility programs
 ii  shellutils     5.0-4.selinux. The GNU shell programming utilities (transit
 ii  textutils      5.0-4.selinux. The GNU text file processing utilities (tran
 ii  util-linux     2.11z-4.selinu Miscellaneous system utilities
 ii  util-linux-loc 2.11z-4.selinu Locales files for util-linux

 sez:/boot# dpkg -l | grep se1    
 ii  cron           3.0pl1-83.se1  management of regular background processing
 ii  dpkg           1.10.21-se1    Package maintenance system for Debian
 ii  initscripts    2.85-15.se1    Standard scripts needed for booting and shut
 ii  logrotate      3.7-1.se1      Log rotation utility
 ii  sysv-rc        2.85-15.se1    Standard boot mechanism using symlinks in /e
 ii  sysvinit       2.85-15.se1    System-V like init

sez:/boot# dpkg -l | grep se5
ii  libpam-modules 0.77-0.se5     Pluggable Authentication Modules for PAM
ii  libpam-runtime 0.77-0.se5     Runtime support for the PAM library
ii  libpam0g       0.77-0.se5     Pluggable Authentication Modules library
ii  libpam0g-dev   0.77-0.se5     Development files for PAM

 
 and that happy lot seems to do it for me.  some of those are from
 selinux.lemuria.org/walters but as russell says these are older
 packages so may cause conflicts with an unstable system (unless you
 put them on "hold"?)

 .


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
