Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5DAoFrT013410
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 06:50:16 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5DAoCkj023020
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 06:50:13 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 13 Jun 2004 10:50:13 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BZRwG-0002ER-0U
	for selinux@tycho.nsa.gov; Sun, 13 Jun 2004 10:10:08 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BZSWQ-0006Pf-Np
	for selinux@tycho.nsa.gov; Sun, 13 Jun 2004 10:47:30 +0000
Date: Sun, 13 Jun 2004 10:47:30 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: debian font manager (defoma) and true-type fonts
Message-ID: <20040613104730.GH2861@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

russell, hi,

another couple of debian font manager related ones, i think you
said you added this already?

allow xprint_t readable_t:dir { search };
	#EXE=/usr/bin/Xprt  NAME=defoma   :  search

allow xprint_t readable_t:file { getattr read };
	#EXE=/usr/bin/Xprt  NAME=fonts.dir   :  read
	#EXE=/usr/bin/Xprt
	PATH=/var/lib/defoma/x-ttcidfont-conf.d/dirs/TrueType/fonts.dir :  getattr

allow xprint_t var_lib_t:dir { search };
	#EXE=/usr/bin/Xprt  NAME=lib   :  search

i'm trying this out, in file_contexts/types.fc

	/usr/lib/defoma(/.*)?  system_u:object_r:fonts_t


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
