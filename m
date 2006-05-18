Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4IK6wo7017530
	for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 16:06:58 -0400
Received: from purple.iano.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4IK6v7v013071
	for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 20:06:57 GMT
Received: from purple.iano.org (localhost [127.0.0.1])
	by purple.iano.org (8.13.2/8.13.2) with ESMTP id k4IK6uWX022802
	for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 16:06:56 -0400 (EDT)
Received: (from iano@localhost)
	by purple.iano.org (8.13.2/8.13.2/Submit) id k4IK6udr022801
	for selinux@tycho.nsa.gov; Thu, 18 May 2006 16:06:56 -0400 (EDT)
Date: Thu, 18 May 2006 16:06:56 -0400
From: Maria Iano <maria@iano.org>
To: selinux@tycho.nsa.gov
Subject: correct way to set context in perl?
Message-ID: <20060518160656.V26098@iano.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What is a good way to set the security context for a new file created within a perl script? I have a perl script that creates new directories and zone files for my name server, and some are master and some slave. So when the script creates them it needs to set some to be of type named_zone_t and some to be of type named_cache_t. Should I just use the system call to chcon?

Thanks for any help.

Maria 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
