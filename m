Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71CUcrT006719
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 08:30:38 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i71CU552021063
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 12:30:05 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 12:30:36 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BrF0N-0002Df-OP
	for selinux@tycho.nsa.gov; Sun, 01 Aug 2004 11:59:55 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BrFek-0003zW-Ha
	for selinux@tycho.nsa.gov; Sun, 01 Aug 2004 13:41:38 +0100
Date: Sun, 1 Aug 2004 13:41:38 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: lkm rootkitted, or issue with selinux 2.6.7 kernel?
Message-ID: <20040801124138.GA15205@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hello, hello,

i have a slight situation with the fireflier and mysql packages:
their use results in chkrootkit's lkm (linux kernel module) test
showing a warning.

what i wondered was has anyone _else_ seen this issue, on debian/unstable,
with a 2.6.7 kernel.

ta,

l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
