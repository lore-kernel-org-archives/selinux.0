Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5G0Vf6s018887
	for <selinux@tycho.nsa.gov>; Thu, 15 Jun 2006 20:31:41 -0400
Received: from ccerelbas01.cce.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5G0Veir015874
	for <selinux@tycho.nsa.gov>; Fri, 16 Jun 2006 00:31:40 GMT
Received: from mailrelay01.cce.cpqcorp.net (compaqcce.compaq.com [16.47.68.171])
	by ccerelbas01.cce.hp.com (Postfix) with ESMTP id E7432341AA
	for <selinux@tycho.nsa.gov>; Thu, 15 Jun 2006 19:31:39 -0500 (CDT)
Received: from kitche.zk3.dec.com (kitche4.zk3.dec.com [16.140.160.166])
	by mailrelay01.cce.cpqcorp.net (Postfix) with ESMTP id DCBC4C9CC
	for <selinux@tycho.nsa.gov>; Thu, 15 Jun 2006 19:31:38 -0500 (CDT)
Message-ID: <4491FBE5.10902@hp.com>
Date: Thu, 15 Jun 2006 20:31:33 -0400
From: Matt Anderson <mra@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: determining security level domination
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm working on lpq and I need to determine if a user can see a job in
the queue.  By this time the user's context is known, and all the jobs
in the queue have a context associated with them.

It seems like avc_has_perm_noaudit() is close to what I need, but I'm
not sure.  The main problem I see with that is avc_has_perm may fail
based on user, role, or type, which I don't think I'm concerned with.
Conceivably I could get around this by mangling one of the contexts so
that I was only comparing levels and categories, but that doesn't sound
like a good idea at all.

Is there some function I've missed that does something like this?

thanks
-matt

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
