Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA26236
	for <selinux@tycho.nsa.gov>; Wed, 27 Dec 2000 05:11:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id KAA19553
	for <selinux@tycho.nsa.gov>; Wed, 27 Dec 2000 10:11:15 GMT
Received: from Allen.fw.matav.hu (matav-2.matav.hu [145.236.241.99])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id KAA19549
	for <selinux@tycho.nsa.gov>; Wed, 27 Dec 2000 10:11:09 GMT
Received: from benigni.tii.matav.hu ([10.3.73.154]) by intranet.matav.hu
          (Netscape Messaging Server 3.6)  with SMTP id AAA4B7
          for <selinux@tycho.nsa.gov>; Wed, 27 Dec 2000 11:32:54 +0100
From: Magosanyi Arpad <mag@bunuel.tii.matav.hu>
Date: Wed, 27 Dec 2000 11:10:47 +0100
To: selinux@tycho.nsa.gov
Subject: documentation enhancement
Message-ID: <77377356CB6.AAA4B7@intranet.matav.hu>
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

--- policy/README.orig	Wed Dec 27 03:06:12 2000
+++ policy/README	Wed Dec 27 03:07:11 2000
@@ -4,6 +4,9 @@
 load    - compile, install, and load the policy configuration.
 relabel - relabel the file system based on file_contexts.
 
+If you have configured MLS into your kernel, set CONFIG_FLASK_MLS=y
+in the Makefile.
+
 Three of the configuration files are independent of the particular
 security policy, and are identical to corresponding files in
 kernel/flask.  These files are:
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
