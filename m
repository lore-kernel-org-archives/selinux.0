Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77NDv8j008378
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 19:13:57 -0400
Received: from g1t0026.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m77NDmQl000744
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 23:13:49 GMT
Received: from mailstation.cce.hp.com (mailstation.zcce.gate.cpqcorp.net [16.104.192.124])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by g1t0026.austin.hp.com (Postfix) with ESMTP id 55C09C2F0
	for <selinux@tycho.nsa.gov>; Thu,  7 Aug 2008 23:13:54 +0000 (UTC)
Received: from orb.usa.hp.com (c-24-147-68-184.hsd1.nh.comcast.net [24.147.68.184])
	by mailstation.cce.hp.com (Postfix) with ESMTP id 9E3E9C029
	for <selinux@tycho.nsa.gov>; Thu,  7 Aug 2008 18:13:53 -0500 (CDT)
Message-ID: <489B81A4.9050007@hp.com>
Date: Thu, 07 Aug 2008 19:13:40 -0400
From: Matt Anderson <mra@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: SELinux policy and performance impacts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm currently looking into the performance impact of SELinux.  Most of 
what I have seen so far involve testing the system's performance with 
file creation, open, and exec, but I was hoping to gather some more data 
before finalizing any conclusions.

I was wondering if anyone knows of any types of policy rules that when 
loaded into the kernel are particularly detrimental to system 
performance.  My understanding is that all policy rules are treated 
equally once they've been compiled to binary, but I wanted to ask here 
first in order to confirm that.

Thanks
-matt

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
