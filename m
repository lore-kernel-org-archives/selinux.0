Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i578PYrT002470
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2004 04:25:34 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i578PT22025975
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2004 04:25:29 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 7 Jun 2004 08:25:22 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BXEne-0001F1-8i
	for selinux@tycho.nsa.gov; Mon, 07 Jun 2004 07:44:06 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BXFP1-00025b-Nd
	for selinux@tycho.nsa.gov; Mon, 07 Jun 2004 08:22:43 +0000
Date: Mon, 7 Jun 2004 08:22:43 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: support for fireflight reading /proc/NNN/fd and /proc/NNN/exe
Message-ID: <20040607082243.GH4543@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

got an interesting issue that i don't quite know how to tackle.

i picked fireflight because it's exactly the sort of thing that i
need to put 
-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
