Subject: [PATCH] Add users.fc to policy
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-7gVV2BRDEygtkzM7/mFV"
Message-Id: <1074878849.27824.211.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Fri, 23 Jan 2004 12:27:29 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-7gVV2BRDEygtkzM7/mFV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is a patch that moves the home directory labeling information
in the policy from file_contexts/types.fc to file_contexts/users.fc. It
also changes the Makefile to pick up any .fc files in the file_contexts
directory.

This patch is motivated by our work to make seuser correctly label users
home directories when they are added to the policy. Moving the user home
directory labeling information out of types.fc will make it easier for
seuser to manipulate the information. Additionally, I think that this is
clearer for administrators as it puts the file context information that
is most likely to change in one place. Any comments are welcome. This
patch doesn't update the documentation, but I can do that if requested.

Thanks,

Karl

Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134

--=-7gVV2BRDEygtkzM7/mFV
Content-Disposition: attachment; filename=user-fc-1-24-2004.patch
Content-Type: text/x-patch; name=user-fc-1-24-2004.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -ruN selinux-usr-orig/policy/file_contexts/types.fc selinux-usr/policy/file_contexts/types.fc
--- selinux-usr-orig/policy/file_contexts/types.fc	2003-11-25 09:43:01.000000000 -0500
+++ selinux-usr/policy/file_contexts/types.fc	2004-01-23 12:15:57.000000000 -0500
@@ -75,25 +75,6 @@
 /var/ftp/lib/lib.*\.so.* --	system_u:object_r:shlib_t
 /var/ftp/etc(/.*)?		system_u:object_r:etc_t
 
-# 
-# The superuser home directory.
-#
-/root(/.*)?			system_u:object_r:sysadm_home_t
-/root			-d	system_u:object_r:sysadm_home_dir_t
-
-# 
-# Ordinary user home directories.
-#
-/home			-d	system_u:object_r:home_root_t
-/home/[^/]+		-d	system_u:object_r:user_home_dir_t
-/home/[^/]+/.+			system_u:object_r:user_home_t
-
-#
-# Other staff home directories, replace "jadmin" with appropriate name
-#
-/home/jadmin/.+			system_u:object_r:staff_home_t
-/home/jadmin		-d	system_u:object_r:staff_home_dir_t
-
 #
 # /bin
 #
diff -ruN selinux-usr-orig/policy/file_contexts/users.fc selinux-usr/policy/file_contexts/users.fc
--- selinux-usr-orig/policy/file_contexts/users.fc	1969-12-31 19:00:00.000000000 -0500
+++ selinux-usr/policy/file_contexts/users.fc	2004-01-23 12:20:05.000000000 -0500
@@ -0,0 +1,23 @@
+# This file describes the security contexts to be applied to
+# users home directories when the security policy is installed.
+# See types.fc for more information about the format of this file.
+
+# 
+# The superuser home directory.
+#
+/root(/.*)?			system_u:object_r:sysadm_home_t
+/root			-d	system_u:object_r:sysadm_home_dir_t
+
+# 
+# Ordinary user home directories.
+#
+/home			-d	system_u:object_r:home_root_t
+/home/[^/]+		-d	system_u:object_r:user_home_dir_t
+/home/[^/]+/.+			system_u:object_r:user_home_t
+
+#
+# Other staff home directories, replace "jadmin" with appropriate name
+#
+/home/jadmin/.+			system_u:object_r:staff_home_t
+/home/jadmin		-d	system_u:object_r:staff_home_dir_t
+
diff -ruN selinux-usr-orig/policy/Makefile selinux-usr/policy/Makefile
--- selinux-usr-orig/policy/Makefile	2003-11-26 11:31:20.000000000 -0500
+++ selinux-usr/policy/Makefile	2004-01-23 12:19:13.000000000 -0500
@@ -40,7 +40,7 @@
 UNUSED_TE_FILES := $(wildcard domains/program/unused/*.te)
 
 FC = file_contexts/file_contexts
-FCFILES=file_contexts/types.fc $(wildcard file_contexts/misc/*.fc) $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te))
+FCFILES=$(wildcard file_contexts/*.fc) $(wildcard file_contexts/misc/*.fc) $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te))
 
 APPDIR=$(DESTDIR)/etc/security
 APPFILES = $(addprefix $(APPDIR)/,default_contexts default_type initrc_context failsafe_context)

--=-7gVV2BRDEygtkzM7/mFV--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
