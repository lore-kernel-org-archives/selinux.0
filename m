Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i55HkqrT026639
	for <selinux@tycho.nsa.gov>; Sat, 5 Jun 2004 13:46:52 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i55Hkn22028619
	for <selinux@tycho.nsa.gov>; Sat, 5 Jun 2004 13:46:49 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 5 Jun 2004 17:46:45 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BWebW-0000qX-Q7
	for selinux@tycho.nsa.gov; Sat, 05 Jun 2004 17:05:10 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BWfDC-00020u-Tz
	for selinux@tycho.nsa.gov; Sat, 05 Jun 2004 17:44:06 +0000
Date: Sat, 5 Jun 2004 17:44:06 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: kdm 3.2.2 patch looks like it _is_ required
Message-ID: <20040605174406.GA7233@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i don't exactly know what's going on, but that patch to kdm looks like
it's going to be necessary.

i set up a system which logs in a user automatically via kdm.

with the unpatched kdm, and using pam_selinux, logins requiring
passwords work fine but an AutoLogin doesn't.

with the patched kdm and pam_selinux removed, both scenarios work.

i don't pretend to know why, i just need a system that "works" that
users can't do any damage to...

l.

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
