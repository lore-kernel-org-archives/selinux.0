Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71HwxrT008054
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 13:59:00 -0400 (EDT)
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i71HwR52025798
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 17:58:27 GMT
Subject: gcc-2.95: checking for va_list assignment copy... configure:
	error: no
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Debian Bug Tracking System <submit@bugs.debian.org>,
   SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1091383127.1295.283.camel@debby>
Mime-Version: 1.0
Date: Sun, 01 Aug 2004 19:58:48 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Package: gcc-2.95
Version: 1:2.95.4-22
Severity: normal


Trying to build a SE-Linux dpkg package with gcc-2.95 and this script:

=========================================== 
#!/bin/sh -x
cd $HOME/russellpackages/dpkg/ && \
rm -rf * && \
curl -f -O http://selinux.lemuria.org/newselinux/dpkg/dpkg_1.10.22.orig.tar.gz && \
curl -f -O http://selinux.lemuria.org/newselinux/dpkg/dpkg_1.10.22-se1.diff.gz && \
tar -xzvf *\.tar.gz && \
cd dpkg-1.10.22/ && \
cp ../dpkg_1.10.22-se1.diff.gz . && \
gzip -cd dpkg_1.10.22-se1.diff.gz | patch -p1 && \
chmod +x debian/rules && \
autoconf && \
fakeroot debian/rules binary
=================================================

ends like this:
---------------------------------------------------- 
checking for initscr in -lncurses... yes
checking if TIOCNOTTY is defined in sys/ioctl.h... yes
checking for va_copy... no
checking for va_list assignment copy... configure: error: no
make: *** [/home/shorty/russellpackages/dpkg/dpkg-1.10.22/build/configure-stamp] Error 1
----------------------------------------------------

Google hints that
"gcc build has failed to install varargs.h"
<http://www.uclibc.org/lists/uclibc/2003-February/005694.html>

$ locate varargs.h
/usr/lib/gcc-lib/powerpc-linux/2.95.4/include/varargs.h
/usr/lib/gcc-lib/powerpc-linux/3.0.4/include/varargs.h
/usr/lib/gcc-lib/powerpc-linux/3.3.4/include/varargs.h
/usr/lib/gcc/powerpc-linux/3.4.1/include/varargs.h

Trying to build the package with the mentioned script above plus gcc-3.3
or gcc-3.0 or gcc-3.4 each time successfully builds these packages:

dpkg-dev_1.10.22-se1_all.deb
dpkg-doc_1.10.22-se1_all.deb
dpkg_1.10.22-se1_powerpc.deb
dselect_1.10.22-se1_powerpc.deb

HTH

Regards
Wolfgang


-- System Information:
Debian Release: 3.1
  APT prefers unstable
  APT policy: (990, 'unstable')
Architecture: powerpc (ppc)
Kernel: Linux 2.4.25-ben1
Locale: LANG=C, LC_CTYPE=C

Versions of packages gcc-2.95 depends on:
ii  binutils                   2.14.90.0.7-8 The GNU assembler, linker and bina
ii  cpp-2.95                   1:2.95.4-22   The GNU C preprocessor
ii  libc6                      2.3.2.ds1-13  GNU C Library: Shared libraries an
-- no debconf information
-- 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
