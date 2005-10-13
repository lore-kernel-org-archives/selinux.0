Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9D6YFNs021111
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 02:34:15 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9D6WU5H007311
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 06:32:31 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 3229561B04
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 16:32:30 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 19603-10 for <selinux@tycho.nsa.gov>;
	Thu, 13 Oct 2005 16:32:29 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id C311361B01
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 16:32:29 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id BADD34D
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 16:32:25 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: MLS policy
Date: Thu, 13 Oct 2005 16:32:20 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200510131632.25597.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently a default root login gets a default level of s2.  This means that 
daemons initially run with the range s0-s9 but run with the range s2-s9 after 
being restarted.  Should we have range-transition rules in the daemon_domain 
family of macros to deal with this?

What is the benefit of assigning root the default level of s2 anyway?

range_transition kernel_t init_exec_t s0 - s9:c0.c255;

Currently we have the above in the MLS policy.  Is it desired that we only use 
up to s9 (highest level is s15)?  Or was it an oversight that the above line 
was not changed when the extra levels were added?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
