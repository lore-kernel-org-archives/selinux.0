Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6SA8TrT008712
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 06:08:29 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6SA7wAN029146
	for <selinux@tycho.nsa.gov>; Wed, 28 Jul 2004 10:07:59 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 28 Jul 2004 10:08:28 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1Bpkru-0000n5-0T
	for selinux@tycho.nsa.gov; Wed, 28 Jul 2004 09:37:02 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BplX3-0008TC-Jx
	for selinux@tycho.nsa.gov; Wed, 28 Jul 2004 11:19:33 +0100
Date: Wed, 28 Jul 2004 11:19:33 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: no access to /var/backups/infodir.bak (?)
Message-ID: <20040728101933.GC32474@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

i'm getting this on installation of gcc bison etc. has it been
addressed for debian policy > 1.12 or is it just me?

l.

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility if acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=f

npacking libtool (from .../libtool_1.5.6-2_i386.deb) ...
Setting up gcc-3.3-base (3.3.4-5) ...
Setting up bison (1.875a-1.1) ...
cp: setting attribute `security.selinux' for `/var/backups/infodir.bak': Permission denied
install-info(/usr/share/info/bison.info): couldn't backup /usr/share/info/dir in /var/backups/infodir.bak: Inappropriate ioctl for device

Setting up cpp-3.3 (3.3.4-5) ...
Setting up cpp (3.3.4-2) ...
Setting up flex (2.5.31-27) ...
cp: setting attribute `security.selinux' for `/var/backups/infodir.bak': Permission denied
install-info(/usr/share/info/flex.info): couldn't backup /usr/share/info/dir in /var/backups/infodir.bak: Inappropriate ioctl for device
cp: setting attribute `security.selinux' for `/var/backups/infodir.bak': Permission denied
install-info(/usr/share/info/flex.info): couldn't backup /usr/share/info/dir in /var/backups/infodir.bak: Inappropriate ioctl for device

Setting up gcc-3.3 (3.3.4-5) ...
Setting up gcc (3.3.4-2) ...

Setting up autoconf (2.59-7) ...
cp: setting attribute `security.selinux' for `/var/backups/infodir.bak': Permission denied
install-info(/usr/share/info/autoconf.info): couldn't backup /usr/share/info/dir in /var/backups/infodir.bak: Inappropriate ioctl for device
cp: setting attribute `security.selinux' for `/var/backups/infodir.bak': Permission denied
install-info(/usr/info/standards.info): couldn't backup /usr/share/info/dir in /var/backups/infodir.bak: Inappropriate ioctl for device
cp: setting attribute `security.selinux' for `/var/backups/infodir.bak': Permission denied
install-info(/usr/share/info/standards.info): couldn't backup /usr/share/info/dir in /var/backups/infodir.bak: Inappropriate ioctl for device
cp: setting attribute `security.selinux' for `/var/backups/infodir.bak': Permission denied
install-info(/usr/info/maintain.info): couldn't backup /usr/share/info/dir in /var/backups/infodir.bak: Inappropriate ioctl for device
cp: setting attribute `security.selinux' for `/var/backups/infodir.bak': Permission denied
install-info(/usr/share/info/maintain.info): couldn't backup /usr/share/info/dir in /var/backups/infodir.bak: Inappropriate ioctl for device

Setting up autotools-dev (20040312.1) ...
Setting up automake (1.4-p4-1.1) ...
cp: setting attribute `security.selinux' for `/var/backups/infodir.bak': Permission denied
install-info(/usr/share/info/automake.info): couldn't backup /usr/share/info/dir in /var/backups/infodir.bak: Inappropriate ioctl for device


--5vNYLRcllDrimb99--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
