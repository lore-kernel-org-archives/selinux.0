Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6PCoxrT019989
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 08:51:01 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6PCoQVH010367
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 12:50:30 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 25 Jul 2004 12:50:51 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1Bohxr-0000KG-MS
	for selinux@tycho.nsa.gov; Sun, 25 Jul 2004 12:18:51 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BoidX-0002cI-NO
	for selinux@tycho.nsa.gov; Sun, 25 Jul 2004 14:01:55 +0100
Date: Sun, 25 Jul 2004 14:01:55 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: kdeinit
Message-ID: <20040725130155.GR3437@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

as you've seen, i sent a message to the kde-devel list, stephan kindly
responded by saying that it's possible to disable kdeinit by
defining KDE_IS_PRELINKED.

i've modified startkde (possibly not the smartest thing to do) to
have this at the top:

	#!/bin/sh
	#
	#  DEFAULT KDE STARTUP SCRIPT ( KDE-3.2 )
	#

	KDE_IS_PRELINKED=1
	export KDE_IS_PRELINKED

and voila, it appears that i end up saving about 30mbyte of virtual
memory - something that _could_ save a lot of time on a system that
is pushed for physical ram.

so it's a trade-off between saving some virtual memory and saving some
speed in the library pre-loading.

... but the important thing is that as far as SE/Linux is concerned
it IS possible to remove kdeinit from the loop, and therefore it IS
possible to write selinux policy files without kdeinit getting in
the way.

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
