Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7CEA2wm000746
	for <selinux@tycho.nsa.gov>; Sat, 12 Aug 2006 10:10:02 -0400
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7CE9hmk015259
	for <selinux@tycho.nsa.gov>; Sat, 12 Aug 2006 14:09:43 GMT
Received: from megaweapon.nightmoose.net (HELO d.namei) ([66.92.66.197])
          (envelope-sender <jmorris@namei.org>)
          by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <selinux@tycho.nsa.gov>; 12 Aug 2006 14:10:00 -0000
Date: Sat, 12 Aug 2006 10:09:59 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] fixfiles: fix test for $LOGFILE
Message-ID: <Pine.LNX.4.64.0608121008560.14758@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please apply.

---

--- fixfiles.orig	2006-08-12 00:52:22.000000000 -0400
+++ fixfiles	2006-08-12 10:07:30.000000000 -0400
@@ -48,7 +48,7 @@
 # Log to either syslog or a LOGFILE
 #
 logit () {
-if [ -z $LOGFILE ]; then
+if [ ! -z $LOGFILE ]; then
     echo $1 >> $LOGFILE
 fi
 }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
