Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i75HrKrT007075
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 13:53:20 -0400 (EDT)
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i75Hqjn4023815
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 17:52:45 GMT
Subject: Build error pam on ppc
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Russell Coker <russell@coker.com.au>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1091728350.2840.49.camel@debby>
Mime-Version: 1.0
Date: Thu, 05 Aug 2004 19:52:30 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All

When I built *successfully* pam on ppc with

fakeroot apt-get source --compile pam=0.77-0.se5

I got this error, that I *ignored*:

----------------------------------------

mkdir -p /home/shorty/russellpackages/pam/pam-0.77/debian/tmp/lib
/usr/bin/install -m 755 libpamc.so /home/shorty/russellpackages/pam/pam-0.77/debian/tmp/lib/libpamc.so.0.77
/sbin/ldconfig
/sbin/ldconfig: Can't create temporary cache file /etc/ld.so.cache~: Permission denied
make[2]: *** [install] Error 1
make[2]: Leaving directory `/home/shorty/russellpackages/pam/pam-0.77/Linux-PAM/libpamc'
make[2]: Entering directory `/home/shorty/russellpackages/pam/pam-0.77/Linux-PAM/libpam_misc'
mkdir -p dynamic
mkdir -p static
mkdir -p /home/shorty/russellpackages/pam/pam-0.77/debian/tmp/usr/include/security
/usr/bin/install -m 644 include/security/pam_misc.h /home/shorty/russellpackages/pam/pam-0.77/debian/tmp/usr/include/security
mkdir -p /home/shorty/russellpackages/pam/pam-0.77/debian/tmp/lib
/usr/bin/install -m 755 libpam_misc.so /home/shorty/russellpackages/pam/pam-0.77/debian/tmp/lib/libpam_misc.so.0.77
/sbin/ldconfig
/sbin/ldconfig: Can't create temporary cache file /etc/ld.so.cache~: Permission denied
make[2]: *** [install] Error 1
____________________________________________________


Is it okay to offer packages for downloading if they're built with that
error?

Thanks in anticipation

Regards
Wolfgang
-- 
Profile, links: http://profiles.yahoo.com/wolfgangpfeiffer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
