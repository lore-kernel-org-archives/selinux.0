Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA09980
	for <selinux@tycho.nsa.gov>; Thu, 5 Jul 2001 14:05:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA17584
	for <selinux@tycho.nsa.gov>; Thu, 5 Jul 2001 18:04:46 GMT
Received: from smtp2.abac.com (smtp2.abac.com [216.55.128.11])
	by jazzswing.ncsc.mil  with ESMTP id SAA17578
	for <selinux@tycho.nsa.gov>; Thu, 5 Jul 2001 18:04:45 GMT
Received: from steve.computer.org (02-099.039.popsite.net [64.24.107.99])
	by smtp2.abac.com (8.10.1/8.10.1) with ESMTP id f65I5Nn06479
	for <selinux@tycho.nsa.gov>; Thu, 5 Jul 2001 11:05:23 -0700 (PDT)
Message-Id: <4.3.2.7.2.20010705115300.00aed870@mail1.abac.com>
Date: Thu, 05 Jul 2001 12:05:35 -0600
To: selinux@tycho.nsa.gov
From: Steve Eckmann <eckmann@computer.org>
Subject: how to add new user roles
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've read the "Security Policy Configuration" paper and looked at the policy configuration files, but it isn't obvious what is needed to add new user roles with separate domains. I guess I need to create a file like user.te for each new domain, possibly containing just a new type definition and a user_domain() "call", plus whatever new rules apply to each new domain.

Can someone share a simple new user domain they've developed, or at least the steps needed to add a new domain and role? For example, suppose I want two new domains A and B just like user except that A can read and execute B files, and B can read but not execute A files.

Steve


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
