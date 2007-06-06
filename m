Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l56JCA1V028991
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 15:12:10 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l56JC7MB007616
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 19:12:07 GMT
Subject: [PATCH 0/5] libselinux: add object class discovery
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 15:10:43 -0400
Message-Id: <1181157043.6578.35.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch set adds basic support to libselinux to leverage the kernel
portion of the object class discovery, exported in selinuxfs, to handle
the four string<->value functions for classes and permissions.  When a
class is looked up, all of the names and values of the permissions for
the class are looked up and cached.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
