Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l57DcNXh013729
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2007 09:38:23 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l57DcMWW000392
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2007 13:38:22 GMT
Subject: [PATCH 0/5] libselinux: add object class discovery
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 09:37:03 -0400
Message-Id: <1181223423.6578.78.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch set adds basic support to libselinux to leverage the kernel
portion of the object class discovery, exported in selinuxfs, to handle
the four string<->value functions for classes and permissions.  When a
class is looked up, all of the names and values of the permissions for
the class are looked up and cached.

Rebased for the errno change.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
