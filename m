Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6VBqmrT002509
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 07:52:49 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6VBqGHs003050
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 11:52:17 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 31 Jul 2004 11:52:42 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1Bqrw0-0001OZ-35
	for selinux@tycho.nsa.gov; Sat, 31 Jul 2004 11:21:52 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BqsaZ-00025U-LB
	for selinux@tycho.nsa.gov; Sat, 31 Jul 2004 13:03:47 +0100
Date: Sat, 31 Jul 2004 13:03:47 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: genhomedircon bugs
Message-ID: <20040731120347.GJ3378@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

there are a couple of bugs in genhomedircon, where

	join("some string", some_list)
	
is used.

this should be

	"some string".join(some_list)

or for consistency with the style used in other places,

	string.join("some string", some_list)

or, for simplicity, at the top, put:

	from string import join.

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
