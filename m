Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71HH7rT007920
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 13:17:07 -0400 (EDT)
Received: from smtp809.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i71HGY52025084
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 17:16:34 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp809.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 17:16:50 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BrJTP-0002GN-Mz
	for selinux@tycho.nsa.gov; Sun, 01 Aug 2004 16:46:11 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BrK7j-0005IF-M9
	for selinux@tycho.nsa.gov; Sun, 01 Aug 2004 18:27:51 +0100
Date: Sun, 1 Aug 2004 18:27:51 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: matchfilecon (the program) vs matchfilecon (the libselinux1 fn)
Message-ID: <20040801172751.GD20103@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

does anyone know: the matchfilecon program reads
/etc/selinux/.../file_contexts/file_contexts.

does the matchfilecon libselinux1 api does the same?

or does it read a binary policy from somewhere?

the reason i ask is because if i were to code up stuff into
udev, it might solve the problem of having to move
/usr/share/selinux/stuff off of /usr and onto /etc.

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
