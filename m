Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6VCGIrT002648
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 08:16:19 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6VCFkHs003352
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 12:15:47 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 31 Jul 2004 12:16:17 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BqsIo-0001Ol-Ie
	for selinux@tycho.nsa.gov; Sat, 31 Jul 2004 11:45:26 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BqsxN-00027k-Bz
	for selinux@tycho.nsa.gov; Sat, 31 Jul 2004 13:27:21 +0100
Date: Sat, 31 Jul 2004 13:27:21 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: genhomedircon - bugs in sed stuff with unknown { } characters
Message-ID: <20040731122721.GN3378@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay, i removed the {s and }s from the genhomedircon's use of sed,
and whoopee, off it went, looks like it's working now.

don't know why, don't care why :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
