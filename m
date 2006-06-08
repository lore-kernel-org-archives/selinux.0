Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k58Jhrqv007161
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 15:43:53 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k58JhqrG012749
	for <selinux@tycho.nsa.gov>; Thu, 8 Jun 2006 19:43:52 GMT
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.11.136.114])
	by atlrel8.hp.com (Postfix) with ESMTP id EC4543431C
	for <selinux@tycho.nsa.gov>; Thu,  8 Jun 2006 15:43:51 -0400 (EDT)
Received: from [16.116.96.193] (flek.zko.hp.com [16.116.96.193])
	by smtp2.fc.hp.com (Postfix) with ESMTP id 974921BF6C
	for <selinux@tycho.nsa.gov>; Thu,  8 Jun 2006 19:43:51 +0000 (UTC)
Message-ID: <44887DF6.8010000@hp.com>
Date: Thu, 08 Jun 2006 15:43:50 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Proposal for increasing the granularity of "setopt"
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Before I go ahead and write any code I was wondering if there would be
any objections to increasing the granularity of the "setopt" permission
for sockets.  Right now it is not possible to differentiate between a
domain wanting to adjust the TCP socket options and a domain wanting to
adjust the IP socket options.  Probably not a big deal but this is a bit
of a concern for the CIPSO/NetLabel code as it relies heavily on socket
options.

I would like to propose introducing a new permission "setopt_ip" which
would allow domains to set IP level socket options.  This could also be
extended with "setopt_ipv6", "setopt_tcp", "setopt_udp", etc.  All calls
to setsockopt() with levels not protected by unique permissions would be
protected by the existing "setopt" permission.  Does that sound reasonable?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
