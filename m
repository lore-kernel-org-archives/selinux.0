Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAF1kvIi020688
	for <selinux@tycho.nsa.gov>; Sun, 14 Nov 2004 20:46:58 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAF1l0PE022137
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 01:47:00 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 0D73CBFD7
	for <selinux@tycho.nsa.gov>; Mon, 15 Nov 2004 01:46:53 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CTW7p-0007w5-BM
	for selinux@tycho.nsa.gov; Mon, 15 Nov 2004 01:57:49 +0000
Date: Mon, 15 Nov 2004 01:57:49 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
Message-ID: <20041115015749.GS5031@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i have what i believe to be an important question about how dynamic
context transitions should partition resources:

is it the case that:

- when a single process transitions (dynamically) to a new context,
  any resources it presently has opened (file handles etc.) will
  still be available and accessible in the new context.

or is it the case that:

- when a single process transitions (dynamically) to a new context,
  any resources it presently has opened (file handles etc.) will
  NOT be accessible in the new context, but that, should the process
  (dynamically) transition BACK to the new context, those resources
  become accessible again.

the former is a trivial implementation, i presume [by comparison to...]

the latter requires that every resource accessible by a process
has a context handle associated with it (eek!)

the distinction is critical because the latter is more like the exec()
model and the former is more seteuid-like.

i wouldn't want to be explaining and advocating something that was
misunderstood!

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
