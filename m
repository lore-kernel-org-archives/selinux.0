Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2K0Mxx6014081
	for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2003 19:23:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2K0JVn8007795
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 00:19:31 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id h2K0JTpk007792
	for <selinux@tycho.nsa.gov>; Thu, 20 Mar 2003 00:19:30 GMT
Date: Thu, 20 Mar 2003 11:22:46 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: SE-Linux and 2.4.20
Message-ID: <20030320002246.GC13288@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I have found I simply cannot use a 2.4.20 kernel with SE-Linux
support on my laptop computer with out it "hanging" after a while.

By this I mean random processes hang, and cannot be killed, even with
kill -9, and rebooting doesn't work.

Combinations tested:

2.4.19 + older selinux patch (v12) = OK
2.4.20 with SE-Linux (accidently) disabled = OK
2.4.20 with new SE-Linux patch (v12) = crashed before 30 minutes.
(was doing nothing but downloading files at the time with apt-get).

In all cases I have the same policy installed.

Any ideas on how to debug this problem further?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
