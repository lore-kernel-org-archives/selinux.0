Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71ALorT006213
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 06:21:50 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i71ALm0x019107
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 10:21:48 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 10:21:48 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BrCzk-0002CC-Mw
	for selinux@tycho.nsa.gov; Sun, 01 Aug 2004 09:51:08 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BrDe8-0003nX-GF
	for selinux@tycho.nsa.gov; Sun, 01 Aug 2004 11:32:52 +0100
Date: Sun, 1 Aug 2004 11:32:52 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: selinux-policy-default 1.14 is missing _stacks_ of stuff
Message-ID: <20040801103252.GC7384@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi there,

for some reason i decided to upgrade to 2.6.7, and then policy.17
wasn't recognised, and then i have to install 1.14 etc. and it's
all gone pear-shaped.

there appears to be quite a lot of things missing from the
debian selinux-policy-default package.

- the appconfig directory
- the targeted directory
- the strict directory.

so, i can't use run_init because targeted/contexts/initrc_context
doesn't exist.

no strict directory exists either: i notice the existence of
this directory in the rpm spec file, but not in any of the debian/
files.

all sorts of other stuff is probably going pear-shaped.

i'm going to try just copy/installing the latest selinux-usr/policy/
cvs from the sf.net site, see what happens.

nothing to lose! :)

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
