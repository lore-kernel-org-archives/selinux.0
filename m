Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6B8G6rT026765
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 04:16:06 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6B8G4SC016826
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 08:16:04 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 11 Jul 2004 08:15:54 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BjYxT-0006Xh-8z
	for selinux@tycho.nsa.gov; Sun, 11 Jul 2004 07:41:11 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Bj1l7-0000rK-4F
	for selinux@tycho.nsa.gov; Fri, 09 Jul 2004 21:14:13 +0100
Date: Fri, 9 Jul 2004 21:14:13 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: warning about debian hotplug package 20040329-9!
Message-ID: <20040709201413.GB3168@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

warning warning warning, do not install hotplug version 20040329-9
from debian unstable because /etc/hotplug/net.rc attempts to write
to /etc/hotplug/net.enable.

hotplug writing to /etc/ even /etc/hotplug is banned by the [present]
selinux policy.

i'm raising a bugreport about this one if there isn't one already.

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
