Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m15IaUXh014625
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 13:36:30 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m15IaUts011388
	for <selinux@tycho.nsa.gov>; Tue, 5 Feb 2008 18:36:30 GMT
Subject: segfault in checkpolicy stable
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 13:34:21 -0500
Message-Id: <1202236461.7533.55.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

With all of the newest stable userland:

libsepol-1.16.10
libselinux-1.34.14 
libsemanage-1.10.9
checkpolicy-1.34.4

I'm getting a segfault in checkpolicy.

Compiling refpolicy policy.21
/usr/bin/checkpolicy policy.conf -o policy.21
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
make: *** [policy.21] Segmentation fault


Steps to reproduce:

1. check out refpolicy trunk
2. # make conf
3. # make policy

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
