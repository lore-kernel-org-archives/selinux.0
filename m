Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6HCb1rT004335
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 08:37:01 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6HCabIR018980
	for <selinux@tycho.nsa.gov>; Sat, 17 Jul 2004 12:36:37 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 17 Jul 2004 12:36:59 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BlnuZ-0007Sv-Cr
	for selinux@tycho.nsa.gov; Sat, 17 Jul 2004 12:03:27 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Blobk-0004qK-LJ
	for selinux@tycho.nsa.gov; Sat, 17 Jul 2004 13:48:04 +0100
Date: Sat, 17 Jul 2004 13:48:04 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: installing openoffice.org-mimelnk gives access error to /tmp
Message-ID: <20040717124804.GG8887@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi there,

when doing se_apt-get install openoffice.org-mimelnk i get this:

	Setting up openoffice.org-mimelnk (1.1.1-4) ...
	cp: setting attribute `security.selinux' for `/tmp/tmp.bcYMog':
	Permission denied
	run-parts:
	/usr/share/openoffice.org-debian-files/hooks/postinst.d/prelink exited
	with return code 1
	dpkg: error processing openoffice.org-mimelnk (--configure):
	 subprocess post-installation script returned error exit status 1

this is with the 1.12 debian policy (with a few hacks).

any clues, anyone?  this been sorted in later versions?

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


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
