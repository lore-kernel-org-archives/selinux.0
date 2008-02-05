Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m15J62dW019846
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 14:06:02 -0500
Received: from mail.seekline.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m15J60ts026669
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 19:06:01 GMT
Received: from [IPv6:2001:6f8:1294:1:211:24ff:fee1:776c] ([IPv6:2001:6f8:1294:1:211:24ff:fee1:776c])
	(authenticated bits=0)
	by mail.seekline.net (8.13.8/8.13.8) with ESMTP id m15J697f007852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 20:06:09 +0100
Subject: SELinux and Linux user mapping
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 05 Feb 2008 20:05:56 +0100
Message-Id: <1202238356.2672.26.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Since my last upgrade to refpolicy-20071214 whenever I try to login with
my username I'm in the default role (user).

$ semanage login -l
[...]
stefan	staff_u

But:

$ id
uid=1000(stefan) gid=1000(stefan) groups=1000(stefan)
context=user_u:user_r:user_t

I tried to login locally and remote via ssh. No AVCs are generated or
whatever. Did I miss something? That's really strange. Did something
change in the past?

Also other users are always logged in as user_u and not e.g. staff_u
(enforcing or permissive mode does not change anything).
I'm using Debian (testing).

cheers
Stefan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
