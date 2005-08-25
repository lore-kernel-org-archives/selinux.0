Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7PEWhOb016097
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2005 10:32:43 -0400 (EDT)
Subject: Re: libselinux category patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <430A33E5.1030100@redhat.com>
References: <430A33E5.1030100@redhat.com>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 10:19:00 -0400
Message-Id: <1124979540.3873.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-22 at 16:21 -0400, Daniel J Walsh wrote:
> libselinux-rhat.patch is mainly tcs's patch with a couple of changes. 

Hide the translation-related symbols entirely, as they are only used
internally, and provide hidden definitions of the raw functions so that
their internal use by libselinux is always satisfied locally.  See 
http://people.redhat.com/drepper/dsohowto.pdf

Index: libselinux/src/booleans.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/booleans.c,v
retrieving revision 1.18
diff -u -p -r1.18 booleans.c
--- libselinux/src/booleans.c	11 Aug 2005 13:58:28 -0000	1.18
+++ libselinux/src/booleans.c	25 Aug 2005 13:51:59 -0000
@@ -165,6 +165,7 @@ int security_get_boolean_active(const ch
 	free(buf);
 	return val;
 }
+hidden_def(security_get_boolean_active)
 
 int security_set_boolean(const char *name, int value)
 {
Index: libselinux/src/checkAccess.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/checkAccess.c,v
retrieving revision 1.4
diff -u -p -r1.4 checkAccess.c
--- libselinux/src/checkAccess.c	23 Aug 2005 16:46:40 -0000	1.4
+++ libselinux/src/checkAccess.c	25 Aug 2005 13:54:57 -0000
@@ -31,6 +31,7 @@ int selinux_check_passwd_access(access_v
         
         return status;
 }
+hidden_def(selinux_check_passwd_access)
 
 int checkPasswdAccess(access_vector_t requested) {
        return selinux_check_passwd_access(requested);
Index: libselinux/src/compute_member.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/compute_member.c,v
retrieving revision 1.3
diff -u -p -r1.3 compute_member.c
--- libselinux/src/compute_member.c	23 Aug 2005 16:59:39 -0000	1.3
+++ libselinux/src/compute_member.c	25 Aug 2005 13:52:26 -0000
@@ -54,6 +54,7 @@ out:
 	close(fd);
 	return ret;
 }
+hidden_def(security_compute_member_raw)
 
 int security_compute_member(security_context_t scon,
                             security_context_t tcon,
Index: libselinux/src/compute_relabel.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/compute_relabel.c,v
retrieving revision 1.12
diff -u -p -r1.12 compute_relabel.c
--- libselinux/src/compute_relabel.c	23 Aug 2005 16:59:39 -0000	1.12
+++ libselinux/src/compute_relabel.c	25 Aug 2005 13:52:50 -0000
@@ -54,6 +54,7 @@ out:
 	close(fd);
 	return ret;
 }
+hidden_def(security_compute_relabel_raw)
 
 int security_compute_relabel(security_context_t scon,
                              security_context_t tcon,
Index: libselinux/src/fgetfilecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/fgetfilecon.c,v
retrieving revision 1.8
diff -u -p -r1.8 fgetfilecon.c
--- libselinux/src/fgetfilecon.c	23 Aug 2005 16:59:39 -0000	1.8
+++ libselinux/src/fgetfilecon.c	25 Aug 2005 13:53:39 -0000
@@ -43,6 +43,7 @@ out:			
 		*context = buf;
 	return ret;
 }
+hidden_def(fgetfilecon_raw)
 
 int fgetfilecon(int fd, security_context_t *context)
 {
Index: libselinux/src/fsetfilecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/fsetfilecon.c,v
retrieving revision 1.3
diff -u -p -r1.3 fsetfilecon.c
--- libselinux/src/fsetfilecon.c	23 Aug 2005 16:46:40 -0000	1.3
+++ libselinux/src/fsetfilecon.c	25 Aug 2005 13:54:06 -0000
@@ -11,6 +11,7 @@ int fsetfilecon_raw(int fd, security_con
 {
 	return fsetxattr(fd, XATTR_NAME_SELINUX, context, strlen(context)+1, 0);
 }
+hidden_def(setfilecon_raw)
 
 int fsetfilecon(int fd, security_context_t context)
 {
Index: libselinux/src/getexeccon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/getexeccon.c,v
retrieving revision 1.7
diff -u -p -r1.7 getexeccon.c
--- libselinux/src/getexeccon.c	23 Aug 2005 16:59:39 -0000	1.7
+++ libselinux/src/getexeccon.c	25 Aug 2005 13:59:12 -0000
@@ -47,6 +47,7 @@ out:
 	close(fd);
 	return ret;
 }
+hidden_def(getexeccon_raw)
 
 int getexeccon(security_context_t *context)
 {
Index: libselinux/src/getfscreatecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/getfscreatecon.c,v
retrieving revision 1.7
diff -u -p -r1.7 getfscreatecon.c
--- libselinux/src/getfscreatecon.c	23 Aug 2005 16:59:39 -0000	1.7
+++ libselinux/src/getfscreatecon.c	25 Aug 2005 13:58:56 -0000
@@ -47,6 +47,7 @@ out:
 	close(fd);
 	return ret;
 }
+hidden_def(getfscreatecon_raw)
 
 int getfscreatecon(security_context_t *context)
 {
Index: libselinux/src/getpeercon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/getpeercon.c,v
retrieving revision 1.4
diff -u -p -r1.4 getpeercon.c
--- libselinux/src/getpeercon.c	23 Aug 2005 16:59:39 -0000	1.4
+++ libselinux/src/getpeercon.c	25 Aug 2005 13:53:09 -0000
@@ -42,6 +42,7 @@ out:			
 		*context = buf;
 	return ret;
 }
+hidden_def(getpeercon_raw)
 
 int getpeercon(int fd, security_context_t *context)
 {
Index: libselinux/src/getpidcon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/getpidcon.c,v
retrieving revision 1.6
diff -u -p -r1.6 getpidcon.c
--- libselinux/src/getpidcon.c	23 Aug 2005 16:59:39 -0000	1.6
+++ libselinux/src/getpidcon.c	25 Aug 2005 13:59:03 -0000
@@ -46,6 +46,7 @@ out:
 	close(fd);
 	return ret;
 }
+hidden_def(getpidcon_raw)
 
 int getpidcon(pid_t pid, security_context_t *context)
 {
Index: libselinux/src/init.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/init.c,v
retrieving revision 1.11
diff -u -p -r1.11 init.c
--- libselinux/src/init.c	24 Aug 2005 19:57:00 -0000	1.11
+++ libselinux/src/init.c	25 Aug 2005 13:43:41 -0000
@@ -9,6 +9,7 @@
 #include <stdio.h>
 #include <dlfcn.h>
 
+#include "dso.h"
 #include "policy.h"
 
 char *selinux_mnt = NULL;
@@ -73,11 +74,12 @@ void set_selinuxmnt(char *mnt)
 	selinux_mnt = strdup(mnt);
 }
  
-int context_translations = 0;
-void *translation_lib_handle = NULL;
+int context_translations hidden;
+void *translation_lib_handle hidden;
+
 /* from libsetrans.c */
-extern int (*lib_trans_to_raw_context)(char *trans, char **rawp);
-extern int (*lib_raw_to_trans_context)(char *raw, char **transp);
+extern int hidden (*lib_trans_to_raw_context)(char *trans, char **rawp);
+extern int hidden (*lib_raw_to_trans_context)(char *raw, char **transp);
 
 
 static void init_translations(void)
Index: libselinux/src/lgetfilecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/lgetfilecon.c,v
retrieving revision 1.8
diff -u -p -r1.8 lgetfilecon.c
--- libselinux/src/lgetfilecon.c	23 Aug 2005 16:59:39 -0000	1.8
+++ libselinux/src/lgetfilecon.c	25 Aug 2005 13:53:28 -0000
@@ -43,6 +43,7 @@ out:			
 		*context = buf;
 	return ret;
 }
+hidden_def(lgetfilecon_raw)
 
 int lgetfilecon(const char *path, security_context_t *context)
 {
Index: libselinux/src/lsetfilecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/lsetfilecon.c,v
retrieving revision 1.3
diff -u -p -r1.3 lsetfilecon.c
--- libselinux/src/lsetfilecon.c	23 Aug 2005 16:46:41 -0000	1.3
+++ libselinux/src/lsetfilecon.c	25 Aug 2005 13:54:01 -0000
@@ -11,6 +11,7 @@ int lsetfilecon_raw(const char *path, se
 {
 	return lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(context)+1, 0);
 }
+hidden_def(lsetfilecon_raw)
 
 int lsetfilecon(const char *path, security_context_t context)
 {
Index: libselinux/src/selinux_internal.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/selinux_internal.h,v
retrieving revision 1.8
diff -u -p -r1.8 selinux_internal.h
--- libselinux/src/selinux_internal.h	24 Aug 2005 19:57:00 -0000	1.8
+++ libselinux/src/selinux_internal.h	25 Aug 2005 13:58:37 -0000
@@ -1,6 +1,7 @@
 #include <selinux/selinux.h>
 #include "dso.h"
 
+hidden_proto(security_get_boolean_active)
 hidden_proto(security_set_boolean)
 hidden_proto(security_commit_booleans)
 hidden_proto(security_check_context)
@@ -11,6 +12,8 @@ hidden_proto(security_compute_user)
 hidden_proto(security_compute_user_raw)
 hidden_proto(security_compute_create)
 hidden_proto(security_compute_create_raw)
+hidden_proto(security_compute_member_raw)
+hidden_proto(security_compute_relabel_raw)
 hidden_proto(is_selinux_enabled)
 hidden_proto(is_selinux_mls_enabled)
 hidden_proto(freecon)
@@ -19,10 +22,21 @@ hidden_proto(getprevcon)
 hidden_proto(getprevcon_raw)
 hidden_proto(getcon)
 hidden_proto(getcon_raw)
+hidden_proto(setcon_raw)
+hidden_proto(getpeercon_raw)
+hidden_proto(getpidcon_raw)
+hidden_proto(getexeccon_raw)
 hidden_proto(getfilecon)
 hidden_proto(getfilecon_raw)
+hidden_proto(lgetfilecon_raw)
+hidden_proto(fgetfilecon_raw)
+hidden_proto(setfilecon_raw)
+hidden_proto(lsetfilecon_raw)
+hidden_proto(fsetfilecon_raw)
 hidden_proto(setexeccon)
 hidden_proto(setexeccon_raw)
+hidden_proto(getfscreatecon_raw)
+hidden_proto(setfscreatecon_raw)
 hidden_proto(security_getenforce)
 hidden_proto(selinux_default_context_path)
 hidden_proto(selinux_failsafe_context_path)
@@ -32,9 +46,10 @@ hidden_proto(selinux_user_contexts_path)
 hidden_proto(selinux_booleans_path)
 hidden_proto(selinux_customizable_types_path)
 hidden_proto(selinux_media_context_path)
+hidden_proto(selinux_check_passwd_access)
 hidden_proto(matchpathcon_init)
 hidden_proto(selinux_users_path)
 
-extern int context_translations;
-extern int trans_to_raw_context(char *trans, char **rawp);
-extern int raw_to_trans_context(char *raw, char **transp);
+extern int context_translations hidden;
+extern int hidden trans_to_raw_context(char *trans, char **rawp);
+extern int hidden raw_to_trans_context(char *raw, char **transp);
Index: libselinux/src/setcon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/setcon.c,v
retrieving revision 1.2
diff -u -p -r1.2 setcon.c
--- libselinux/src/setcon.c	23 Aug 2005 16:46:41 -0000	1.2
+++ libselinux/src/setcon.c	25 Aug 2005 13:58:48 -0000
@@ -25,6 +25,7 @@ int setcon_raw(security_context_t contex
 	else
 		return 0;
 }
+hidden_def(setcon_raw)
 
 int setcon(char *context)
 {
Index: libselinux/src/setfilecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/setfilecon.c,v
retrieving revision 1.3
diff -u -p -r1.3 setfilecon.c
--- libselinux/src/setfilecon.c	23 Aug 2005 16:46:41 -0000	1.3
+++ libselinux/src/setfilecon.c	25 Aug 2005 13:53:53 -0000
@@ -11,6 +11,7 @@ int setfilecon_raw(const char *path, sec
 {
 	return setxattr(path, XATTR_NAME_SELINUX, context, strlen(context)+1, 0);
 }
+hidden_def(setfilecon_raw)
 
 int setfilecon(const char *path, security_context_t context)
 {
Index: libselinux/src/setfscreatecon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/setfscreatecon.c,v
retrieving revision 1.5
diff -u -p -r1.5 setfscreatecon.c
--- libselinux/src/setfscreatecon.c	23 Aug 2005 16:46:41 -0000	1.5
+++ libselinux/src/setfscreatecon.c	25 Aug 2005 13:54:37 -0000
@@ -21,6 +21,7 @@ int setfscreatecon_raw(char *context)
 	else
 		return 0;
 }
+hidden_def(setfscreatecon_raw)
 
 int setfscreatecon(char *context)
 {
Index: libselinux/src/trans.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/trans.c,v
retrieving revision 1.3
diff -u -p -r1.3 trans.c
--- libselinux/src/trans.c	24 Aug 2005 20:03:32 -0000	1.3
+++ libselinux/src/trans.c	25 Aug 2005 13:43:24 -0000
@@ -1,10 +1,10 @@
 #include "selinux_internal.h"
 #include <string.h>
 
-int (*lib_trans_to_raw_context)(char *trans, char **rawp) = NULL;
-int (*lib_raw_to_trans_context)(char *raw, char **transp) = NULL;
+int (*lib_trans_to_raw_context)(char *trans, char **rawp) hidden;
+int (*lib_raw_to_trans_context)(char *raw, char **transp) hidden;
 
-int trans_to_raw_context(char *trans, char **rawp)
+int hidden trans_to_raw_context(char *trans, char **rawp)
 {
 	*rawp = NULL;
 	if (!trans)
@@ -16,7 +16,7 @@ int trans_to_raw_context(char *trans, ch
 	return *rawp ? 0 : -1;
 }
 
-int raw_to_trans_context(char *raw, char **transp)
+int hidden raw_to_trans_context(char *raw, char **transp) 
 {
 	*transp = NULL;
 	if (!raw)


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
