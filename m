Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m25AM0Ug002235
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 05:22:00 -0500
Received: from ns1.a61.nl (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m25ALwUA017488
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 10:21:59 GMT
Received: from localhost ([127.0.0.1] helo=www.a61.nl)
	by ns1.a61.nl with esmtp (Exim 4.54)
	id 1JWqkg-0005Fg-Mu
	for selinux@tycho.nsa.gov; Wed, 05 Mar 2008 11:21:34 +0100
Message-ID: <37866.80.95.164.250.1204712494.squirrel@www.a61.nl>
Date: Wed, 5 Mar 2008 11:21:34 +0100 (CET)
Subject: Unreserved portnumbers in corenetwork
From: selinux@a61.nl
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Gents,

We're building a policy for JBoss. Jboss uses atleast port 8080 and 8083.
Besides this, the application we use on JBoss also opens port 8443 (https)

While building the jboss-module we ofcourse want to claim these ports and
patch corenetwork. However, this is where our problem arises; HTTP has
claimed some of the ports we need and http-cache has claimed 8080
allready.

But http and http-cache allow to open more ports (80, 443, 488, 8008,
8009) than we really need. We think this is against the SElinux policy of
least privilege.

So how do we deal with these kinds of port conflicts? Maybe corenetwork
isn't the best place to define unreserved (> 1024) ports?

Cheers,

Bart


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
