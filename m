Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1JICXZ029350
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 14:18:13 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1JGqCC027899
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 19:16:52 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 8DF37BF35
	for <selinux@tycho.nsa.gov>; Mon,  1 Nov 2004 19:17:59 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1COhrJ-0002cl-9b
	for selinux@tycho.nsa.gov; Mon, 01 Nov 2004 19:28:53 +0000
Date: Mon, 1 Nov 2004 19:28:53 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: dynamic context transitions - a seteuid parallel
Message-ID: <20041101192853.GF9643@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay, so this dynamic context transitions idea is pretty much
identical to the seteuid equivalence proposals, and doing
an equivalent of seteuid() it has been made abundantly clear
[many times], and why, that it should not be done.

... question: what it is about MLS that makes it so necessary to
implement dynamic context transitions?

what are the alternatives?

l.

p.s. not that i actually understand MLS enough to understand any answers
[yet] but i'm just encouraging people to bounce ideas.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
