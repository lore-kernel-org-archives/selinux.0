Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4TEc0rT014705
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 10:38:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4TEZUTg027821
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 14:35:30 GMT
Received: from smtp800.mail.ukl.yahoo.com (smtp800.mail.ukl.yahoo.com [217.12.12.142])
	by jazzswing.ncsc.mil  with SMTP id i4TEZTPE027818
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 14:35:29 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 29 May 2004 14:37:58 -0000
Received: from highfield ([192.168.0.223]:32771 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.34 #1)
	id 1BU4Jr-0000jI-HV
	for <selinux@tycho.nsa.gov>; Sat, 29 May 2004 13:56:15 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BU4ve-0001L8-Jh
	for selinux@tycho.nsa.gov; Sat, 29 May 2004 14:35:18 +0000
Date: Sat, 29 May 2004 14:35:18 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: moving to /etc/security/selinux and impact on .deb build
Message-ID: <20040529143518.GA5135@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hiya,

i seem to be caught in the middle of some updates and/or lack of
information.

i have downloaded the .diffs for creating .debs selinux-policy-default,
checkpolicy etc. from http://selinux.lemuria.org/walters and have used
them to create .debs from latest cvs.

i have noted the discussions about "new location for selinux"
and have hoped that my confusion about /usr/share/selinux and
/etc/selinux and now /etc/security/selinux would go away.

but this is not to be.

could someone please help clarify some things for me?

what is the purpose of /usr/share/selinux/, it containing pretty much
the same stuff in its policy/default directory as there is in
/etc/selinux?

why the move to /etc/security/selinux, or more specifically, from where
can i obtain updated .diffs to recreate the .debs correctly, or if those
are not yet available, what modifications do i need to make to the
.diffs, myself, in order to get a working system?

at present i have only a few files in /etc/security/selinux, directories
only in /etc/selinux, an selinux-policy-default deb package that expects
a Makefile /etc/selinux/Makefile which is definitely not present, and
consequently a broken system.

pointers to pre-existing docs appreciated as much as a direct answer.

tia,

l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
