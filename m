Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i522t7rT000589
	for <selinux@tycho.nsa.gov>; Tue, 1 Jun 2004 22:55:07 -0400 (EDT)
Received: from smtp802.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i52Ancbn009228
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 06:49:39 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp802.mail.ukl.yahoo.com with SMTP; 2 Jun 2004 00:08:21 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BVIdw-0000CH-7C
	for selinux@tycho.nsa.gov; Tue, 01 Jun 2004 23:26:04 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BVJGN-0005oz-Cb
	for selinux@tycho.nsa.gov; Wed, 02 Jun 2004 00:05:47 +0000
Date: Wed, 2 Jun 2004 00:05:47 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: ACLs and Capabilities
Message-ID: <20040602000547.GU5690@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

... the significant difference between [most!] implementations
of "access control" and capabilities is that with capabilities,
what you may wish to do simply.... isn't there, full stop,
and with "access control", it's _all_ there, and on each
type of operation, something checks whether you are "allowed"
to do that operation.

... *click*  who am _i_ teaching???  i'll shut up now.  l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
