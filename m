Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KCPMRb018050
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 08:25:22 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KCPBAR017522
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:25:11 GMT
Received: from smtp803.mail.ukl.yahoo.com (smtp803.mail.ukl.yahoo.com [217.12.12.140])
        by jazzband.ncsc.mil  with SMTP id i4KCOuHn017469 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:24:56 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 20 May 2004 12:18:16 -0000
Received: from highfield ([192.168.0.223]:33179 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BQmXy-00019D-Se
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:21:14 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BQmSY-0002QH-UI
	for selinux@tycho.nsa.gov; Thu, 20 May 2004 12:15:38 +0000
Date: Thu, 20 May 2004 12:15:38 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: FAM uses seteuid and setegid
Message-ID: <20040520121538.GA8810@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

just taking a look at famd, which uses seteuid and setegid before
going and 'avin a look at files (Cred::Implementation::become_user())

so, famd is designed to "effectively" set its user and group ids,
such that any file access is done as these, whilst still remaining
actually running as root.

... so... what tricks can be done that are equivalent to this?

setfscreatecon doesn't apply because that's presumably for file
creation, and famd does file access not file creation.

setexeccon doesn't apply because there _are_ no relevant exec
calls that occur in famd, and the only forks() and execs()
are to run programs (e.g. "insmod imon").

hum.

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
