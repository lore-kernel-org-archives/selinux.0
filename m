Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA9FdOSf000902
	for <selinux@tycho.nsa.gov>; Sun, 9 Nov 2003 10:39:24 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA9Fd01W016476
	for <selinux@tycho.nsa.gov>; Sun, 9 Nov 2003 15:39:00 GMT
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by jazzswing.ncsc.mil  with SMTP id hA9Fcx5e016473
	for <selinux@tycho.nsa.gov>; Sun, 9 Nov 2003 15:39:00 GMT
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: stripped static binaries
Date: Sun, 9 Nov 2003 16:38:15 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_n9lr/9sUfXNt618"
Message-Id: <200311091638.15350.carstengrohmann@gmx.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_n9lr/9sUfXNt618
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I think, we should strip the static binaries like load_policy. Thru 
this we could save space in the initrd. The patch for the 
policycoreutils is attached.

What do you think about it?


--Boundary-00=_n9lr/9sUfXNt618
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="static.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="static.diff"

diff -ur policycoreutils-1.2.orig/load_policy/Makefile policycoreutils-1.2/load_policy/Makefile
--- policycoreutils-1.2.orig/load_policy/Makefile	2003-08-27 18:07:11.000000000 +0200
+++ policycoreutils-1.2/load_policy/Makefile	2003-11-09 16:05:25.000000000 +0100
@@ -11,7 +11,7 @@
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
-all: $(TARGETS)
+all: $(TARGETS) strip
 
 install: all
 	-mkdir -p $(SBINDIR)
@@ -22,3 +22,7 @@
 
 relabel:
 	setfilecon system_u:object_r:load_policy_exec_t $(SBINDIR)/load_policy 
+
+strip:
+	strip $(TARGETS)
+ 

--Boundary-00=_n9lr/9sUfXNt618--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
