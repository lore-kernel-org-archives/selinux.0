Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6NDto6V013121
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 09:55:50 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6NDtm3O001083
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 13:55:48 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id l6NDtGfD016161
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2007 09:55:16 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id l6NDtGNj016160
	for selinux@tycho.nsa.gov; Mon, 23 Jul 2007 09:55:16 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6KJbFtV019939
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 15:37:15 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l6KJbEKP009714
	for <selinux@tycho.nsa.gov>; Fri, 20 Jul 2007 19:37:14 GMT
Date: Fri, 20 Jul 2007 15:32:23 -0400
Subject: [RFC][PATCH 01/01] SELinux: add VM entrypoint object
 class/permission
From: David Windsor <dwindsor@tresys.com>
To: selinux <selinux@tycho.nsa.gov>,
        kvm-devel <kvm-devel@lists.sourceforge.net>
CC: Joshua Brindle <jbrindle@tresys.com>
Message-ID: <C2C68607.366F%dwindsor@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset modifies libselinux to include the vm object class and the
entrypoint permission for use with the userspace qemu SELinux code.


Index: src/selinux/libselinux/include/selinux/av_permissions.h
===================================================================
--- src.orig/selinux/libselinux/include/selinux/av_permissions.h
2007-07-14 23:55:36.000000000 -0400
+++ src/selinux/libselinux/include/selinux/av_permissions.h     2007-07-15
00:18:59.000000000 -0400
@@ -897,3 +897,4 @@
 #define KEY__CREATE                               0x00000040UL
 #define CONTEXT__TRANSLATE                        0x00000001UL
 #define CONTEXT__CONTAINS                         0x00000002UL
+#define VM__ENTRYPOINT                           0x00000001UL
Index: src/selinux/libselinux/include/selinux/flask.h
===================================================================
--- src.orig/selinux/libselinux/include/selinux/flask.h 2007-07-14
23:55:36.000000000 -0400
+++ src/selinux/libselinux/include/selinux/flask.h      2007-07-15
00:55:14.000000000 -0400
@@ -64,6 +64,7 @@
 #define SECCLASS_PACKET                                  57
 #define SECCLASS_KEY                                     58
 #define SECCLASS_CONTEXT                                 59
+#define SECCLASS_VM                                     60
 
 /*
  * Security identifier indices for initial entities
Index: src/selinux/libselinux/src/class_to_string.h
===================================================================
--- src.orig/selinux/libselinux/src/class_to_string.h   2007-07-14
23:55:36.000000000 -0400
+++ src/selinux/libselinux/src/class_to_string.h        2007-07-15
00:18:59.000000000 -0400
@@ -62,3 +62,4 @@
     S_("packet")
     S_("key")
     S_("context")
+    S_("vm")
Index: src/selinux/libselinux/src/av_perm_to_string.h
===================================================================
--- src.orig/selinux/libselinux/src/av_perm_to_string.h 2007-07-14
23:55:36.000000000 -0400
+++ src/selinux/libselinux/src/av_perm_to_string.h      2007-07-15
00:57:10.000000000 -0400
@@ -267,3 +267,4 @@
     S_(SECCLASS_KEY, KEY__CREATE, "create")
     S_(SECCLASS_CONTEXT, CONTEXT__TRANSLATE, "translate")
     S_(SECCLASS_CONTEXT, CONTEXT__CONTAINS, "contains")
+    S_(SECCLASS_VM, VM__ENTRYPOINT, "entrypoint")

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
