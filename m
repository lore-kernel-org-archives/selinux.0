Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5UFx8sq016802
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 11:59:08 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5UFx8Xd004698
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 15:59:08 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5UFx7rV027801
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 11:59:07 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5UFx7kC009679
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 11:59:07 -0400
Received: from localhost.localdomain (dhcp-10-16-61-233.boston.devel.redhat.com [10.16.61.233])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5UFx7Qq031989
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 11:59:07 -0400
Message-ID: <486902CA.4030607@redhat.com>
Date: Mon, 30 Jun 2008 11:59:06 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: restorecond should not be started by default
Content-Type: multipart/mixed;
 boundary="------------010708070601030107060408"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010708070601030107060408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Fedora is trying to eliminate most daemons that get started by default.
 They want the admin to select whether the daemon should start.

--------------010708070601030107060408
Content-Type: text/plain;
 name="restorecond.init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="restorecond.init.patch"

--- nsapolicycoreutils/restorecond/restorecond.init	2008-06-12 23:25:21.000000000 -0400
+++ policycoreutils-2.0.50/restorecond/restorecond.init	2008-06-30 11:49:38.000000000 -0400
@@ -2,7 +2,7 @@
 #
 # restorecond:		Daemon used to maintain path file context
 #
-# chkconfig:	2345 12 87
+# chkconfig:	- 12 87
 # description:	restorecond uses inotify to look for creation of new files \
 # listed in the /etc/selinux/restorecond.conf file, and restores the \
 # correct security context.

--------------010708070601030107060408--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
