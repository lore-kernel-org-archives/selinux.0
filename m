Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5QHoarT005460
	for <selinux@tycho.nsa.gov>; Sat, 26 Jun 2004 13:50:36 -0400 (EDT)
Received: from smtp807.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5QHoMAP017458
	for <selinux@tycho.nsa.gov>; Sat, 26 Jun 2004 17:50:22 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp807.mail.ukl.yahoo.com with SMTP; 26 Jun 2004 17:49:19 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BeGiR-00040L-DD
	for selinux@tycho.nsa.gov; Sat, 26 Jun 2004 17:11:47 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BeHFt-0000yM-Vh
	for selinux@tycho.nsa.gov; Sat, 26 Jun 2004 17:46:21 +0000
Date: Sat, 26 Jun 2004 17:46:21 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [DEBIAN] module-init-tools 3.1-pre2 WATCH OUT - write permission requested!
Message-ID: <20040626174621.GE3559@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=255242

debian users, beware: apparently this has been fixed, some people
will have missed it, but if you find that your system doesn't
load _any_ modules, it's because certain versions of modprobe
try to open modules with write permission!

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
