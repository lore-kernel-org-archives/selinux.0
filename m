Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1QKAQRb008442
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 15:10:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1QK8olK006238
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 20:08:50 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by jazzswing.ncsc.mil  with ESMTP id i1QK8nOX006235
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 20:08:49 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.11.6/8.11.6) with ESMTP id i1QKAOb28141
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 15:10:24 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i1QKAO828672
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 15:10:24 -0500
Received: from redhat.com (dwalsh.cipe.redhat.com [10.0.2.138])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id i1QKALYJ030118
	for <selinux@tycho.nsa.gov>; Thu, 26 Feb 2004 15:10:22 -0500
Message-ID: <403E52AD.5090103@redhat.com>
Date: Thu, 26 Feb 2004 15:10:21 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Proposed patch to policy file_contexts
Content-Type: multipart/mixed;
 boundary="------------080506020001070209040802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080506020001070209040802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Since the file_contexts file is now being build with m4, I am proposing 
this patch to allow for simpler specifications of alternate 
homedirectories or staff users.

As we are roling this out we are finding many users placing their 
homedirectories in the non standard location.

What do you think?

Dan

--------------080506020001070209040802
Content-Type: text/x-diff;
 name="policy-homedir.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-homedir.patch"

--- policy-1.6/file_contexts/users.fc.homedir	2004-02-26 15:03:53.957826373 -0500
+++ policy-1.6/file_contexts/users.fc	2004-02-26 15:03:07.283167405 -0500
@@ -0,0 +1,9 @@
+#
+# If you have an alternate homedir you would specify it here
+#
+#home_dir(user, /local_home)
+#
+#  If you have alternate members of staff you would specify it here
+#
+#home_dir(staff, /home,jadmin)
+#home_dir(staff, /local_home,jadmin)
--- policy-1.6/file_contexts/types.fc.homedir	2004-02-26 14:57:19.071019536 -0500
+++ policy-1.6/file_contexts/types.fc	2004-02-26 14:59:04.624938026 -0500
@@ -82,9 +82,7 @@
 # 
 # Ordinary user home directories.
 #
-/home			-d	system_u:object_r:home_root_t
-/home/[^/]+		-d	system_u:object_r:user_home_dir_t
-/home/[^/]+/.+			system_u:object_r:user_home_t
+home_dir(user,/home)
 
 #
 # /bin
@@ -418,7 +416,8 @@
 /lost\+found(/.*)?		system_u:object_r:lost_found_t
 /usr/lost\+found(/.*)?		system_u:object_r:lost_found_t
 /boot/lost\+found(/.*)?		system_u:object_r:lost_found_t
-/home/lost\+found(/.*)?		system_u:object_r:lost_found_t
+# moved to home.fc 
+# /home/lost\+found(/.*)?		system_u:object_r:lost_found_t
 /var/lost\+found(/.*)?		system_u:object_r:lost_found_t
 /tmp/lost\+found(/.*)?		system_u:object_r:lost_found_t
 /usr/local/lost\+found(/.*)?	system_u:object_r:lost_found_t
--- policy-1.6/file_contexts/homedir.homedir	2004-02-26 14:57:07.079392137 -0500
+++ policy-1.6/file_contexts/homedir	2004-02-26 14:56:33.529232470 -0500
@@ -0,0 +1,14 @@
+define(`home_dir',`
+$2			-d	system_u:object_r:home_root_t
+ifelse($3,`',`
+$2/[^/]+		-d	system_u:object_r:$1_home_dir_t
+$2/[^/]+/.+			system_u:object_r:$1_home_t
+$2/\.journal			<<none>>
+$2/lost\+found(/.*)?		system_u:object_r:lost_found_t
+', `
+$2/$3/[^/]+		-d	system_u:object_r:$1_home_dir_t
+$2/$3/[^/]+/.+			system_u:object_r:$1_home_t
+$2/$3/\.journal			<<none>>
+$2/$3/lost\+found(/.*)?		system_u:object_r:lost_found_t
+')
+')
--- policy-1.6/Makefile.homedir	2004-02-26 15:00:50.902774628 -0500
+++ policy-1.6/Makefile	2004-02-26 15:01:16.167883200 -0500
@@ -51,7 +51,7 @@
 UNUSED_TE_FILES := $(wildcard domains/program/unused/*.te)
 
 FC = file_contexts/file_contexts
-FCFILES=file_contexts/types.fc $(wildcard file_contexts/misc/*.fc) $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te))
+FCFILES=file_contexts/homedir file_contexts/types.fc file_contexts/users.fc $(wildcard file_contexts/misc/*.fc) $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te))
 
 APPDIR=$(DESTDIR)/etc/security
 APPFILES = $(addprefix $(APPDIR)/,default_contexts default_type initrc_context failsafe_context)

--------------080506020001070209040802--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
