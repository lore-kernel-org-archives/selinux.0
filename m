Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2TIUjeJ019806
	for <selinux@tycho.nsa.gov>; Sat, 29 Mar 2008 14:30:45 -0400
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2TIUhDZ012125
	for <selinux@tycho.nsa.gov>; Sat, 29 Mar 2008 18:30:44 GMT
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 854CF36980
	for <selinux@tycho.nsa.gov>; Sat, 29 Mar 2008 19:23:35 +0100 (CET)
From: Jim Meyering <jim@meyering.net>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: doc typo fix: s/behaviors/behavior/
Date: Sat, 29 Mar 2008 19:23:35 +0100
Message-ID: <87sky98k48.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's a tiny typo fix:

Index: libselinux/man/man3/getfscreatecon.3
===================================================================
--- libselinux/man/man3/getfscreatecon.3	(revision 2858)
+++ libselinux/man/man3/getfscreatecon.3	(working copy)
@@ -29,7 +29,7 @@
 
 
 Note: Signal handlers that perform an setfscreate must take care to
-save, reset, and restore the fscreate context to avoid unexpected behaviors.
+save, reset, and restore the fscreate context to avoid unexpected behavior.
 .SH "RETURN VALUE"
 On error -1 is returned.
 On success 0 is returned.
Index: libselinux/man/man3/getexeccon.3
===================================================================
--- libselinux/man/man3/getexeccon.3	(revision 2858)
+++ libselinux/man/man3/getexeccon.3	(working copy)
@@ -34,7 +34,7 @@
 
 
 Note: Signal handlers that perform an execve must take care to
-save, reset, and restore the exec context to avoid unexpected behaviors.
+save, reset, and restore the exec context to avoid unexpected behavior.
 
 
 .B rpm_execcon

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
