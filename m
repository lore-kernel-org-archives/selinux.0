Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71JT4rT008316
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 15:29:04 -0400 (EDT)
Received: from smtp809.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i71JT20x025589
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 19:29:03 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp809.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 19:29:03 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BrLXP-0002H1-EG
	for selinux@tycho.nsa.gov; Sun, 01 Aug 2004 18:58:27 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BrMBi-0005ST-9L
	for selinux@tycho.nsa.gov; Sun, 01 Aug 2004 20:40:06 +0100
Date: Sun, 1 Aug 2004 20:40:06 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: /etc/qt3/.qt*
Message-ID: <20040801194006.GF20103@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi there russell,

yes, after redoing the policy mods to get kde to work, i think
your idea of doing an etc_rw_t or xdm_var_run_t for /etc/qt3
is a good idea.

gawd only knows what kde (actually libqt) is doing needing to write 
lock files to /etc/qt3 but there y'go.

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
