Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAAIJsSf005170
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 13:19:54 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAAIJrKl015252
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 18:19:54 GMT
Received: from smtp4.na.baesystems.com (smtp4.na.baesystems.com [63.164.202.13])
        by jazzband.ncsc.mil  with ESMTP id hAAIJn5m015234 for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 18:19:53 GMT
Received: from BLUMS0022.bluelnk.net ([10.40.96.145])
	by smtp4.na.baesystems.com (8.12.10/8.12.10) with ESMTP id hAAIJjEf023204
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 13:19:45 -0500 (EST)
Message-ID: <93DA0219FE13D511889F00508BCFEB900D756C1E@u02m02.usa02.na.baesystems.com>
From: "Miner, Jonathan W" <jonathan.w.miner@baesystems.com>
To: "'Richard Troth '" <rtroth@bmc.com>,
   "'Stephen Smalley '"
	 <sds@epoch.ncsc.mil>
Cc: "'Tom '" <tom@lemuria.org>,
   "'selinux@tycho.nsa.gov '"
	 <selinux@tycho.nsa.gov>
Subject: RE: Do we break POSIX?
Date: Mon, 10 Nov 2003 13:19:41 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Solaris behaves the same way.

-----Original Message-----
From: Richard Troth
To: Stephen Smalley
Cc: Tom; selinux@tycho.nsa.gov
Sent: 11/10/03 12:18 PM
Subject: Re: Do we break POSIX?

> NFS can yield the same behavior.  If you are holding a file open on
the
> client and writing to it, and someone changes the ownership of the
file
> on the server, then subsequent write() requests will fail with
> Permission denied.  I just tested with a Linux client and server to
> verify, and this is what happens.

Find a Sun.
Test with Solaris.
(Just to be more sure.)
-------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
