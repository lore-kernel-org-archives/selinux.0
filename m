Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6VCHXrT002666
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 08:17:33 -0400 (EDT)
Received: from smtp808.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6VCHUlX004975
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 12:17:30 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp808.mail.ukl.yahoo.com with SMTP; 31 Jul 2004 12:17:31 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BqsK0-0001Oo-3s
	for selinux@tycho.nsa.gov; Sat, 31 Jul 2004 11:46:40 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BqsyZ-00027z-Dj
	for selinux@tycho.nsa.gov; Sat, 31 Jul 2004 13:28:35 +0100
Date: Sat, 31 Jul 2004 13:28:35 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: hacked Makefile to use 17 instead of 18
Message-ID: <20040731122835.GO3378@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

well, i'm about to find out if it's okay, but i hacked the 1.14-1
Makefile to forcibly put policy file of type 18 into a file named
policy.17.

not that i _care_ about this particular computer or anything :)

oh, darn, i'm using xfs, hope that's okay.

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
