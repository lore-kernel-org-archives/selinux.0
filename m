Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4TDNFrT014497
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 09:23:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4TDKjTg027498
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 13:20:45 GMT
Received: from smtp800.mail.ukl.yahoo.com (smtp800.mail.ukl.yahoo.com [217.12.12.142])
	by jazzswing.ncsc.mil  with SMTP id i4TDKiPE027495
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 13:20:44 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 29 May 2004 13:23:12 -0000
Received: from highfield ([192.168.0.223]:32833 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.34 #1)
	id 1BU39W-0000ik-Fy
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 12:41:30 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BU3lC-0003iu-5V
	for selinux@tycho.nsa.gov; Sat, 29 May 2004 13:20:26 +0000
Date: Sat, 29 May 2004 13:20:25 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: latest cvs: policy appears to have different specs for apt-get
Message-ID: <20040529132024.GA12259@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i'm getting this error on make relabel:

	ERROR: Multiple different specifications for /usr/bin/apt-get
	(system_u:object_r:rpm_exec_t and system_u:object_r:apt_exec_t).
	/usr/sbin/setfiles:  labeling files under /

i won't pretend to know how it occurs...

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
