Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2LGHf5R022190
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 12:17:42 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2LGHZRY018675
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 16:17:35 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2LGGnsE025300
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 12:17:24 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2LFts7J015421
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 11:55:54 -0400
Received: from [10.11.14.108] (vpn-14-108.rdu.redhat.com [10.11.14.108])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2LFts5J003963
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2007 11:55:54 -0400
Subject: [PATCH] sepolgen: move interface info to var
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 21 Mar 2007 11:54:35 -0400
Message-Id: <1174492475.3116.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch moves the sepolgen runtime data from /usr/share to /var/lib
to facilitate a read-only /usr.

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

diff -r 8e23d0938bd8 sepolgen/src/sepolgen/defaults.py
--- a/sepolgen/src/sepolgen/defaults.py	Wed Mar 21 11:42:54 2007 -0400
+++ b/sepolgen/src/sepolgen/defaults.py	Wed Mar 21 11:52:19 2007 -0400
@@ -22,7 +22,7 @@ Various default settings, including file
 """
 
 def data_dir():
-    return "/usr/share/sepolgen"
+    return "/var/lib/sepolgen"
 
 def perm_map():
     return data_dir() + "/perm_map"
diff -r 8e23d0938bd8 sepolgen/src/share/Makefile
--- a/sepolgen/src/share/Makefile	Wed Mar 21 11:42:54 2007 -0400
+++ b/sepolgen/src/share/Makefile	Wed Mar 21 11:52:20 2007 -0400
@@ -1,4 +1,4 @@ SHAREDIR ?= $(DESTDIR)/usr/share/sepolge
-SHAREDIR ?= $(DESTDIR)/usr/share/sepolgen
+SHAREDIR ?= $(DESTDIR)/var/lib/sepolgen
 
 install:
 	-mkdir -p $(SHAREDIR)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
