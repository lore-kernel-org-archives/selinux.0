Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6VBuZrT002545
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 07:56:36 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6VBuYlX004736
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 11:56:34 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 31 Jul 2004 11:56:34 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1Bqrzk-0001Of-Ej
	for selinux@tycho.nsa.gov; Sat, 31 Jul 2004 11:25:44 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BqseK-000262-3n
	for selinux@tycho.nsa.gov; Sat, 31 Jul 2004 13:07:40 +0100
Date: Sat, 31 Jul 2004 13:07:40 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: webalizer.fc missing from selinux-policy-default v 1.14-1
Message-ID: <20040731120740.GL3378@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

file missing.  did a touch on that file because i don't intend to
install webalizer.

but this missing file means that an install will only work if you
have previously installed selinux (which did have a webalizer.fc in it)

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
