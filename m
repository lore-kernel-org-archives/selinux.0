Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3QK81W8030160
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 16:08:01 -0400
Received: from mail.gurulabs.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3QK7tSH002634
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 20:08:00 GMT
Received: from [10.2.3.10] (dhcp10.glwlan.gurulabs.com [10.2.3.10])
	by mail.gurulabs.com (Postfix) with ESMTP id BC890114995
	for <selinux@tycho.nsa.gov>; Thu, 26 Apr 2007 14:07:47 -0600 (MDT)
Subject: [PATCH 1/1] libselinux: helpful message when /selinux won't mount
From: Dax Kelson <dax@gurulabs.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 26 Apr 2007 14:07:47 -0600
Message-Id: <1177618067.26931.13.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Last night a co-worker was trying to do a Phyical-2-Virtual (P2V)
migration of a RHEL5 box.

During bootup, the following not-so-helpful message was seen:

"Unable to load SELinux Policy. Machine is in enforcing mode. Halting
now."

I ran it down to the /selinux mount point not existing on the root
filesystem, but the troubleshooting was more difficult than it should
have been (it didn't help that it was a 3am).

Please consider the following trivial patch for inclusion into
libselinux so that others may have an easier time if they happen into
the same situation.

Signed-off-by:  Dax Kelson <dax@gurulabs.com>

===================================================================
--- libselinux-2.0.8-org/src/load_policy.c	2007-03-08 12:44:37.000000000 -0700
+++ libselinux-2.0.8/src/load_policy.c	2007-04-26 13:54:18.000000000 -0600
@@ -226,6 +226,7 @@
 			 */
 			*enforce = 0;
 		}
+		printf("Mount failed for selinuxfs on /selinux\n");
 		goto noload;
 	}
 	set_selinuxmnt(SELINUXMNT);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
