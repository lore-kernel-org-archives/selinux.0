Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7NDWjOb027846
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 09:32:46 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7NDLToM001497
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 13:21:29 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j7NDMhnh027158
	for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2005 09:22:43 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j7NDMh4M027154
	for selinux@tycho.nsa.gov; Tue, 23 Aug 2005 09:22:43 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7MKUhOb023046
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:30:43 -0400 (EDT)
Message-ID: <430A33E5.1030100@redhat.com>
Date: Mon, 22 Aug 2005 16:21:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>
Subject: libselinux category patch
Content-Type: multipart/mixed;
 boundary="------------090402060309070601010004"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090402060309070601010004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

libselinux-rhat.patch is mainly tcs's patch with a couple of changes. 

One eliminate MLS from the checking.  No reason why this has to be MLS 
specific.
Change mlstrans.c to trans.c.  See above.
Allow context functions to handle null range.
    In MCS I want to translate X:Y:Z:s0 to X:Y:Z, That way we can 
introduce MCS policy to targeted without the user
seeing any change.
A couple of minor changes.

setrans.c is the library code

I am attaching the translation library code I am going to throw in for 
MCS handling.  Basically translates
c1=PatientRecord
I have called the file /etc/secat.conf, tried to put it in 
/etc/selinux/secat.conf, but suddenly lots of domains wanted to read 
selinux_config_t files.

Is this agreeable to everyone?

Dan

-- 



--------------090402060309070601010004
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.25.2/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2005-08-11 22:41:15.000000000 -0400
+++ libselinux-1.25.2/include/selinux/selinux.h	2005-08-17 15:51:32.000000000 -0400
@@ -27,6 +27,7 @@
 /* Get current context, and set *con to refer to it.
    Caller must free via freecon. */
 extern int getcon(security_context_t *con);
+extern int getcon_raw(security_context_t *con);
 
 /* Set the current security context to con.  
    Note that use of this function requires that the entire application
@@ -37,32 +38,39 @@
    as a result of a setcon() unless policy allows it to use descriptors opened
    by the old context. */
 extern int setcon(security_context_t con);
+extern int setcon_raw(security_context_t con);
 
 /* Get context of process identified by pid, and 
    set *con to refer to it.  Caller must free via freecon. */
 extern int getpidcon(pid_t pid, security_context_t *con);
+extern int getpidcon_raw(pid_t pid, security_context_t *con);
 
 /* Get previous context (prior to last exec), and set *con to refer to it.
    Caller must free via freecon. */
 extern int getprevcon(security_context_t *con);
+extern int getprevcon_raw(security_context_t *con);
 
 /* Get exec context, and set *con to refer to it.
    Sets *con to NULL if no exec context has been set, i.e. using default.
    If non-NULL, caller must free via freecon. */
 extern int getexeccon(security_context_t *con);
+extern int getexeccon_raw(security_context_t *con);
 
 /* Set exec security context for the next execve. 
    Call with NULL if you want to reset to the default. */
 extern int setexeccon(security_context_t con);
+extern int setexeccon_raw(security_context_t con);
 
 /* Get fscreate context, and set *con to refer to it.
    Sets *con to NULL if no fs create context has been set, i.e. using default.
    If non-NULL, caller must free via freecon. */
 extern int getfscreatecon(security_context_t *con);
+extern int getfscreatecon_raw(security_context_t *con);
 
 /* Set the fscreate security context for subsequent file creations.
    Call with NULL if you want to reset to the default. */
 extern int setfscreatecon(security_context_t context);
+extern int setfscreatecon_raw(security_context_t context);
 
 
 /* Wrappers for the xattr API. */
@@ -70,13 +78,19 @@
 /* Get file context, and set *con to refer to it.
    Caller must free via freecon. */
 extern int getfilecon(const char *path, security_context_t *con);
+extern int getfilecon_raw(const char *path, security_context_t *con);
 extern int lgetfilecon(const char *path, security_context_t *con);
+extern int lgetfilecon_raw(const char *path, security_context_t *con);
 extern int fgetfilecon(int fd, security_context_t *con);
+extern int fgetfilecon_raw(int fd, security_context_t *con);
 
 /* Set file context */
 extern int setfilecon(const char *path, security_context_t con);
+extern int setfilecon_raw(const char *path, security_context_t con);
 extern int lsetfilecon(const char *path, security_context_t con);
+extern int lsetfilecon_raw(const char *path, security_context_t con);
 extern int fsetfilecon(int fd, security_context_t con);
+extern int fsetfilecon_raw(int fd, security_context_t con);
 
 
 /* Wrappers for the socket API */
@@ -84,6 +98,7 @@
 /* Get context of peer socket, and set *con to refer to it.
    Caller must free via freecon. */
 extern int getpeercon(int fd, security_context_t *con);
+extern int getpeercon_raw(int fd, security_context_t *con);
 
 
 /* Wrappers for the selinuxfs (policy) API. */
@@ -105,6 +120,11 @@
 			       security_class_t tclass,
 			       access_vector_t requested,
 			       struct av_decision *avd);
+extern int security_compute_av_raw(security_context_t scon,
+                                   security_context_t tcon,
+                                   security_class_t tclass,
+                                   access_vector_t requested,
+                                   struct av_decision *avd);
 
 /* Compute a labeling decision and set *newcon to refer to it.
    Caller must free via freecon. */
@@ -112,6 +132,10 @@
 				   security_context_t tcon,
 				   security_class_t tclass,
 				   security_context_t *newcon);
+extern int security_compute_create_raw(security_context_t scon,
+                                       security_context_t tcon,
+                                       security_class_t tclass,
+                                       security_context_t *newcon);
 
 /* Compute a relabeling decision and set *newcon to refer to it.
    Caller must free via freecon. */
@@ -119,6 +143,10 @@
 				    security_context_t tcon,
 				    security_class_t tclass,
 				    security_context_t *newcon);
+extern int security_compute_relabel_raw(security_context_t scon,
+                                        security_context_t tcon,
+                                        security_class_t tclass,
+                                        security_context_t *newcon);
 
 /* Compute a polyinstantiation member decision and set *newcon to refer to it.
    Caller must free via freecon. */
@@ -126,12 +154,19 @@
 				   security_context_t tcon,
 				   security_class_t tclass,
 				   security_context_t *newcon);
+extern int security_compute_member_raw(security_context_t scon,
+                                       security_context_t tcon,
+                                       security_class_t tclass,
+                                       security_context_t *newcon);
 
 /* Compute the set of reachable user contexts and set *con to refer to 
    the NULL-terminated array of contexts.  Caller must free via freeconary. */
 extern int security_compute_user(security_context_t scon,
 				 const char *username,
 				 security_context_t **con);
+extern int security_compute_user_raw(security_context_t scon,
+                                     const char *username,
+                                     security_context_t **con);
 
 /* Load a policy configuration. */
 extern int security_load_policy(void *data, size_t len);
@@ -153,6 +188,7 @@
 
 /* Check the validity of a security context. */
 extern int security_check_context(security_context_t con);
+extern int security_check_context_raw(security_context_t con);
 
 /* Get the enforce flag value. */
 extern int security_getenforce(void);
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man8/selinuxenabled.8 libselinux-1.25.2/man/man8/selinuxenabled.8
--- nsalibselinux/man/man8/selinuxenabled.8	2004-11-02 14:26:19.000000000 -0500
+++ libselinux-1.25.2/man/man8/selinuxenabled.8	2005-08-17 15:51:32.000000000 -0400
@@ -7,7 +7,7 @@
 .SH "DESCRIPTION"
 .B selinuxenabled
 Indicates whether SELinux is enabled or disabled. It exits with status 0 
-if SELinux is enabled and -256 if it is not enabled.
+if SELinux is enabled and 1 if it is not enabled.
 
 .SH AUTHOR	
 Dan Walsh, <dwalsh@redhat.com>
diff --exclude-from=exclude -N -u -r nsalibselinux/src/checkAccess.c libselinux-1.25.2/src/checkAccess.c
--- nsalibselinux/src/checkAccess.c	2005-08-11 22:41:15.000000000 -0400
+++ libselinux-1.25.2/src/checkAccess.c	2005-08-17 15:51:32.000000000 -0400
@@ -11,13 +11,13 @@
         security_context_t user_context;
         if (is_selinux_enabled() == 0) 
                 return 0;
-        if( getprevcon(&user_context)==0 ) {
+        if( getprevcon_raw(&user_context)==0 ) {
                 struct av_decision avd;
-                int retval = security_compute_av(user_context,
-                                                 user_context,
-                                                 SECCLASS_PASSWD,
-                                                 requested,
-                                                 &avd);
+                int retval = security_compute_av_raw(user_context,
+                                                     user_context,
+                                                     SECCLASS_PASSWD,
+                                                     requested,
+                                                     &avd);
                 
                 if ((retval == 0) && 
                     ((requested & avd.allowed) == requested)) {
diff --exclude-from=exclude -N -u -r nsalibselinux/src/check_context.c libselinux-1.25.2/src/check_context.c
--- nsalibselinux/src/check_context.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/check_context.c	2005-08-17 15:51:32.000000000 -0400
@@ -9,7 +9,7 @@
 #include "policy.h"
 #include <limits.h>
 
-int security_check_context(security_context_t con)
+int security_check_context_raw(security_context_t con)
 {
 	char path[PATH_MAX];
 	int fd, ret;
@@ -25,4 +25,21 @@
 		return -1;
 	return 0;
 }
+hidden_def(security_check_context_raw)
+
+int security_check_context(security_context_t con)
+{
+	int ret;
+	security_context_t rcon = con;
+
+	if (context_translations && trans_to_raw_context(con, &rcon))
+		return -1;
+
+ 	ret = security_check_context_raw(rcon);
+
+	if (context_translations)
+		freecon(rcon);
+
+	return ret;
+}
 hidden_def(security_check_context)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/compute_av.c libselinux-1.25.2/src/compute_av.c
--- nsalibselinux/src/compute_av.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/compute_av.c	2005-08-17 15:51:32.000000000 -0400
@@ -10,11 +10,11 @@
 #include "policy.h"
 #include <limits.h>
 
-int security_compute_av(security_context_t scon,
-			security_context_t tcon,
-			security_class_t tclass,
-			access_vector_t requested,
-			struct av_decision *avd)
+int security_compute_av_raw(security_context_t scon,
+                            security_context_t tcon,
+                            security_class_t tclass,
+                            access_vector_t requested,
+                            struct av_decision *avd)
 {
 	char path[PATH_MAX];
 	char *buf;
@@ -58,4 +58,34 @@
 	close(fd);
 	return ret;
 }
+hidden_def(security_compute_av_raw)
+
+int security_compute_av(security_context_t scon,
+                        security_context_t tcon,
+                        security_class_t tclass,
+                        access_vector_t requested,
+                        struct av_decision *avd)
+{
+	int ret;
+	security_context_t rscon = scon;
+	security_context_t rtcon = tcon;
+
+	if (context_translations) {
+		if (trans_to_raw_context(scon, &rscon))
+			return -1;
+		if (trans_to_raw_context(tcon, &rtcon)) {
+			freecon(rscon);
+			return -1;
+		}
+	}
+
+ 	ret = security_compute_av_raw(rscon, rtcon, tclass, requested, avd);
+
+	if (context_translations) {
+		freecon(rscon);
+		freecon(rtcon);
+	}
+
+	return ret;
+}
 hidden_def(security_compute_av)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/compute_create.c libselinux-1.25.2/src/compute_create.c
--- nsalibselinux/src/compute_create.c	2005-01-28 12:15:29.000000000 -0500
+++ libselinux-1.25.2/src/compute_create.c	2005-08-17 15:51:32.000000000 -0400
@@ -10,10 +10,10 @@
 #include "policy.h"
 #include <limits.h>
 
-int security_compute_create(security_context_t scon,
-			    security_context_t tcon,
-			    security_class_t tclass,
-			    security_context_t *newcon)
+int security_compute_create_raw(security_context_t scon,
+                                security_context_t tcon,
+                                security_class_t tclass,
+                                security_context_t *newcon)
 {
 	char path[PATH_MAX];
 	char *buf;
@@ -54,4 +54,42 @@
 	close(fd);
 	return ret;
 }
+hidden_def(security_compute_create_raw)
+
+int security_compute_create(security_context_t scon,
+                            security_context_t tcon,
+                            security_class_t tclass,
+                            security_context_t *newcon)
+{
+	int ret;
+	security_context_t rscon = scon;
+	security_context_t rtcon = tcon;
+	security_context_t rnewcon;
+
+	if (context_translations) {
+		if (trans_to_raw_context(scon, &rscon))
+			return -1;
+		if (trans_to_raw_context(tcon, &rtcon)) {
+			freecon(rscon);
+			return -1;
+		}
+	}
+
+ 	ret = security_compute_create_raw(rscon, rtcon, tclass, &rnewcon);
+
+	if (context_translations) {
+		freecon(rscon);
+		freecon(rtcon);
+		if (!ret) {
+			if (raw_to_trans_context(rnewcon, newcon)) {
+				*newcon = NULL;
+				ret = -1;
+			}
+			freecon(rnewcon);
+		}
+	} else
+		*newcon = rnewcon;
+
+	return ret;
+}
 hidden_def(security_compute_create)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/compute_member.c libselinux-1.25.2/src/compute_member.c
--- nsalibselinux/src/compute_member.c	2004-12-02 13:20:18.000000000 -0500
+++ libselinux-1.25.2/src/compute_member.c	2005-08-17 15:51:32.000000000 -0400
@@ -6,14 +6,14 @@
 #include <errno.h>
 #include <string.h>
 #include <asm/page.h>
-#include <selinux/selinux.h>
+#include "selinux_internal.h"
 #include "policy.h"
 #include <limits.h>
 
-int security_compute_member(security_context_t scon,
-			    security_context_t tcon,
-			    security_class_t tclass,
-			    security_context_t *newcon)
+int security_compute_member_raw(security_context_t scon,
+                                security_context_t tcon,
+                                security_class_t tclass,
+                                security_context_t *newcon)
 {
 	char path[PATH_MAX];
 	char *buf;
@@ -54,3 +54,40 @@
 	close(fd);
 	return ret;
 }
+
+int security_compute_member(security_context_t scon,
+                            security_context_t tcon,
+                            security_class_t tclass,
+                            security_context_t *newcon)
+{
+	int ret;
+	security_context_t rscon = scon;
+	security_context_t rtcon = tcon;
+	security_context_t rnewcon;
+
+	if (context_translations) {
+		if (trans_to_raw_context(scon, &rscon))
+			return -1;
+		if (trans_to_raw_context(tcon, &rtcon)) {
+			freecon(rscon);
+			return -1;
+		}
+	}
+
+ 	ret = security_compute_member_raw(rscon, rtcon, tclass, &rnewcon);
+
+	if (context_translations) {
+		freecon(rscon);
+		freecon(rtcon);
+		if (!ret) {
+			if (raw_to_trans_context(rnewcon, newcon)) {
+				*newcon = NULL;
+				ret = -1;
+			}
+			freecon(rnewcon);
+		}
+	} else
+		*newcon = rnewcon;
+
+	return ret;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/compute_relabel.c libselinux-1.25.2/src/compute_relabel.c
--- nsalibselinux/src/compute_relabel.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/compute_relabel.c	2005-08-17 15:51:32.000000000 -0400
@@ -6,14 +6,14 @@
 #include <errno.h>
 #include <string.h>
 #include <asm/page.h>
-#include <selinux/selinux.h>
+#include "selinux_internal.h"
 #include "policy.h"
 #include <limits.h>
 
-int security_compute_relabel(security_context_t scon,
-			    security_context_t tcon,
-			    security_class_t tclass,
-			    security_context_t *newcon)
+int security_compute_relabel_raw(security_context_t scon,
+                                 security_context_t tcon,
+                                 security_class_t tclass,
+                                 security_context_t *newcon)
 {
 	char path[PATH_MAX];
 	char *buf;
@@ -54,3 +54,40 @@
 	close(fd);
 	return ret;
 }
+
+int security_compute_relabel(security_context_t scon,
+                             security_context_t tcon,
+                             security_class_t tclass,
+                             security_context_t *newcon)
+{
+	int ret;
+	security_context_t rscon = scon;
+	security_context_t rtcon = tcon;
+	security_context_t rnewcon;
+
+	if (context_translations) {
+		if (trans_to_raw_context(scon, &rscon))
+			return -1;
+		if (trans_to_raw_context(tcon, &rtcon)) {
+			freecon(rscon);
+			return -1;
+		}
+	}
+
+ 	ret = security_compute_relabel_raw(rscon, rtcon, tclass, &rnewcon);
+
+	if (context_translations) {
+		freecon(rscon);
+		freecon(rtcon);
+		if (!ret) {
+			if (raw_to_trans_context(rnewcon, newcon)) {
+				*newcon = NULL;
+				ret = -1;
+			}
+			freecon(rnewcon);
+		}
+	} else
+		*newcon = rnewcon;
+
+	return ret;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/compute_user.c libselinux-1.25.2/src/compute_user.c
--- nsalibselinux/src/compute_user.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/compute_user.c	2005-08-17 15:51:32.000000000 -0400
@@ -10,9 +10,9 @@
 #include "policy.h"
 #include <limits.h>
 
-int security_compute_user(security_context_t scon,
-			  const char *user,
-			  security_context_t **con)
+int security_compute_user_raw(security_context_t scon,
+                              const char *user,
+                              security_context_t **con)
 {
 	char path[PATH_MAX];
 	char **ary;
@@ -73,4 +73,36 @@
 	close(fd);
 	return ret;
 }
+hidden_def(security_compute_user_raw)
+
+int security_compute_user(security_context_t scon,
+                          const char *user,
+                          security_context_t **con)
+{
+	int ret;
+	security_context_t rscon = scon;
+
+	if (context_translations && trans_to_raw_context(scon, &rscon))
+		return -1;
+
+ 	ret = security_compute_user_raw(rscon, user, con);
+
+	if (context_translations) {
+		freecon(rscon);
+		if (!ret) {
+			security_context_t *ptr, tmpcon;
+			for (ptr = *con; *ptr; ptr++) {
+				if (raw_to_trans_context(*ptr, &tmpcon)) {
+					freeconary(*con);
+					*con = NULL;
+					return -1;
+				}
+				freecon(*ptr);
+				*ptr = tmpcon;
+			}
+		}
+	}
+
+	return ret;
+}
 hidden_def(security_compute_user)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/context.c libselinux-1.25.2/src/context.c
--- nsalibselinux/src/context.c	2005-08-11 22:41:15.000000000 -0400
+++ libselinux-1.25.2/src/context.c	2005-08-17 15:51:32.000000000 -0400
@@ -15,7 +15,8 @@
 
 /*
  * Allocate a new context, initialized from str.  There must be 3 or
- * 4 colon-separated components and no whitespace.
+ * 4 colon-separated components and no whitespace in the user, role, or type
+ * components.  MLS components may have spaces in translated form.
  */
 context_t
 context_new(const char *str)
@@ -35,7 +36,8 @@
         for ( i = count = 0, p = str; *p; p++ ) {
                 switch ( *p ) { 
                 case ':': count++; break;
-                case '\n': case '\t': case '\r': case ' ': goto err; /* sanity check */
+                case '\n': case '\t': case '\r': goto err; /* sanity check */
+                case ' ': if (count < 3) goto err; /* sanity check */
                 }
         }
 	/*
@@ -141,8 +143,8 @@
         const char *p;
         if ( !t ) { return 1; }
         for ( p = str; *p; p++ ) {
-                if ( *p == '\t' || *p == ' ' || *p == '\n' || *p == '\r' ||
-                     (*p == ':' && index != COMP_RANGE) ) {
+                if ( *p == '\t' || *p == '\n' || *p == '\r' ||
+                     ((*p == ':' || *p == ' ') && index != COMP_RANGE) ) {
                         free(t);
                         return 1;
                 }
diff --exclude-from=exclude -N -u -r nsalibselinux/src/enabled.c libselinux-1.25.2/src/enabled.c
--- nsalibselinux/src/enabled.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/enabled.c	2005-08-17 15:51:32.000000000 -0400
@@ -42,7 +42,7 @@
 
 	enabled = 1;
 
-	if (getcon(&con) == 0) {
+	if (getcon_raw(&con) == 0) {
 		if (!strcmp(con, "kernel"))
 			enabled = 0;
 		freecon(con);
diff --exclude-from=exclude -N -u -r nsalibselinux/src/fgetfilecon.c libselinux-1.25.2/src/fgetfilecon.c
--- nsalibselinux/src/fgetfilecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/fgetfilecon.c	2005-08-17 15:51:32.000000000 -0400
@@ -1,13 +1,13 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <sys/xattr.h>
+#include "selinux_internal.h"
 #include "policy.h"
 
-int fgetfilecon(int fd, security_context_t *context)
+int fgetfilecon_raw(int fd, security_context_t *context)
 {
 	char *buf;
 	ssize_t size;
@@ -43,3 +43,22 @@
 		*context = buf;
 	return ret;
 }
+
+int fgetfilecon(int fd, security_context_t *context)
+{
+	security_context_t rcontext;
+	int ret;
+
+ 	ret = fgetfilecon_raw(fd, &rcontext);
+
+	if (context_translations && ret > 0) {
+		if (raw_to_trans_context(rcontext, context)) {
+			*context = NULL;
+			ret = -1;
+		}
+		freecon(rcontext);
+	} else
+		*context = rcontext;
+
+	return ret;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/fsetfilecon.c libselinux-1.25.2/src/fsetfilecon.c
--- nsalibselinux/src/fsetfilecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/fsetfilecon.c	2005-08-17 15:51:32.000000000 -0400
@@ -1,13 +1,29 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <sys/xattr.h>
+#include "selinux_internal.h"
 #include "policy.h"
 
-int fsetfilecon(int fd, security_context_t context)
+int fsetfilecon_raw(int fd, security_context_t context)
 {
 	return fsetxattr(fd, XATTR_NAME_SELINUX, context, strlen(context)+1, 0);
 }
+
+int fsetfilecon(int fd, security_context_t context)
+{
+	int ret;
+	security_context_t rcontext = context;
+
+	if (context_translations && trans_to_raw_context(context, &rcontext))
+		return -1;
+
+ 	ret = fsetfilecon_raw(fd, rcontext);
+
+	if (context_translations)
+		freecon(rcontext);
+
+	return ret;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getcon.c libselinux-1.25.2/src/getcon.c
--- nsalibselinux/src/getcon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/getcon.c	2005-08-17 15:51:32.000000000 -0400
@@ -7,7 +7,7 @@
 #include <asm/page.h>
 #include "policy.h"
 
-int getcon(security_context_t *context)
+int getcon_raw(security_context_t *context)
 {
 	char *buf;
 	size_t size;
@@ -42,4 +42,24 @@
 	close(fd);
 	return ret;
 }
+hidden_def(getcon_raw)
+
+int getcon(security_context_t *context)
+{
+	int ret;
+	security_context_t rcontext;
+
+ 	ret = getcon_raw(&rcontext);
+
+	if (context_translations && !ret) {
+		if (raw_to_trans_context(rcontext, context)) {
+			*context = NULL;
+			ret = -1;
+		}
+		freecon(rcontext);
+	} else
+		*context = rcontext;
+
+	return ret;
+}
 hidden_def(getcon)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getexeccon.c libselinux-1.25.2/src/getexeccon.c
--- nsalibselinux/src/getexeccon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/getexeccon.c	2005-08-17 15:51:32.000000000 -0400
@@ -1,13 +1,13 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <asm/page.h>
+#include "selinux_internal.h"
 #include "policy.h"
 
-int getexeccon(security_context_t *context)
+int getexeccon_raw(security_context_t *context)
 {
 	char *buf;
 	size_t size;
@@ -47,3 +47,22 @@
 	close(fd);
 	return ret;
 }
+
+int getexeccon(security_context_t *context)
+{
+	int ret;
+	security_context_t rcontext;
+
+ 	ret = getexeccon_raw(&rcontext);
+
+	if (context_translations && !ret) {
+		if (raw_to_trans_context(rcontext, context)) {
+			*context = NULL;
+			ret = -1;
+		}
+		freecon(rcontext);
+	} else
+		*context = rcontext;
+
+	return ret;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getfilecon.c libselinux-1.25.2/src/getfilecon.c
--- nsalibselinux/src/getfilecon.c	2005-01-28 12:15:29.000000000 -0500
+++ libselinux-1.25.2/src/getfilecon.c	2005-08-17 15:51:32.000000000 -0400
@@ -7,7 +7,7 @@
 #include <sys/xattr.h>
 #include "policy.h"
 
-int getfilecon(const char *path, security_context_t *context)
+int getfilecon_raw(const char *path, security_context_t *context)
 {
 	char *buf;
 	ssize_t size;
@@ -43,4 +43,24 @@
 		*context = buf;
 	return ret;
 }
+hidden_def(getfilecon_raw)
+
+int getfilecon(const char *path, security_context_t *context)
+{
+	int ret;
+	security_context_t rcontext;
+
+ 	ret = getfilecon_raw(path, &rcontext);
+
+	if (context_translations && ret > 0) {
+		if (raw_to_trans_context(rcontext, context)) {
+			*context = NULL;
+			ret = -1;
+		}
+		freecon(rcontext);
+	} else
+		*context = rcontext;
+
+	return ret;
+}
 hidden_def(getfilecon)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getfscreatecon.c libselinux-1.25.2/src/getfscreatecon.c
--- nsalibselinux/src/getfscreatecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/getfscreatecon.c	2005-08-17 15:51:32.000000000 -0400
@@ -1,13 +1,13 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <asm/page.h>
+#include "selinux_internal.h"
 #include "policy.h"
 
-int getfscreatecon(security_context_t *context)
+int getfscreatecon_raw(security_context_t *context)
 {
 	char *buf;
 	size_t size;
@@ -47,3 +47,22 @@
 	close(fd);
 	return ret;
 }
+
+int getfscreatecon(security_context_t *context)
+{
+	int ret;
+	security_context_t rcontext;
+
+ 	ret = getfscreatecon_raw(&rcontext);
+
+	if (context_translations && !ret) {
+		if (raw_to_trans_context(rcontext, context)) {
+			*context = NULL;
+			ret = -1;
+		}
+		freecon(rcontext);
+	} else
+		*context = rcontext;
+
+	return ret;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getpeercon.c libselinux-1.25.2/src/getpeercon.c
--- nsalibselinux/src/getpeercon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/getpeercon.c	2005-08-17 15:51:32.000000000 -0400
@@ -1,17 +1,17 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <sys/socket.h>
+#include "selinux_internal.h"
 #include "policy.h"
 
 #ifndef SO_PEERSEC
 #define SO_PEERSEC 31
 #endif
 
-int getpeercon(int fd, security_context_t *context)
+int getpeercon_raw(int fd, security_context_t *context)
 {
 	char *buf;
 	socklen_t size;
@@ -42,3 +42,22 @@
 		*context = buf;
 	return ret;
 }
+
+int getpeercon(int fd, security_context_t *context)
+{
+	int ret;
+	security_context_t rcontext;
+
+ 	ret = getpeercon_raw(fd, &rcontext);
+
+	if (context_translations && !ret) {
+		if (raw_to_trans_context(rcontext, context)) {
+			*context = NULL;
+			ret = -1;
+		}
+		freecon(rcontext);
+	} else
+		*context = rcontext;
+
+	return ret;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getpidcon.c libselinux-1.25.2/src/getpidcon.c
--- nsalibselinux/src/getpidcon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/getpidcon.c	2005-08-17 15:51:32.000000000 -0400
@@ -1,14 +1,14 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <selinux/selinux.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <asm/page.h>
+#include "selinux_internal.h"
 #include "policy.h"
 
-int getpidcon(pid_t pid, security_context_t *context)
+int getpidcon_raw(pid_t pid, security_context_t *context)
 {
 	char path[40];
 	char *buf;
@@ -46,3 +46,22 @@
 	close(fd);
 	return ret;
 }
+
+int getpidcon(pid_t pid, security_context_t *context)
+{
+	int ret;
+	security_context_t rcontext;
+
+ 	ret = getpidcon_raw(pid, &rcontext);
+
+	if (context_translations && !ret) {
+		if (raw_to_trans_context(rcontext, context)) {
+			*context = NULL;
+			ret = -1;
+		}
+		freecon(rcontext);
+	} else
+		*context = rcontext;
+
+	return ret;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/getprevcon.c libselinux-1.25.2/src/getprevcon.c
--- nsalibselinux/src/getprevcon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/getprevcon.c	2005-08-17 15:51:32.000000000 -0400
@@ -7,7 +7,7 @@
 #include <asm/page.h>
 #include "policy.h"
 
-int getprevcon(security_context_t *context)
+int getprevcon_raw(security_context_t *context)
 {
 	char *buf;
 	size_t size;
@@ -42,4 +42,24 @@
 	close(fd);
 	return ret;
 }
+hidden_def(getprevcon_raw)
+
+int getprevcon(security_context_t *context)
+{
+	int ret;
+	security_context_t rcontext;
+
+ 	ret = getprevcon_raw(&rcontext);
+
+	if (context_translations && !ret) {
+		if (raw_to_trans_context(rcontext, context)) {
+			*context = NULL;
+			ret = -1;
+		}
+		freecon(rcontext);
+	} else
+		*context = rcontext;
+
+	return ret;
+}
 hidden_def(getprevcon)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/init.c libselinux-1.25.2/src/init.c
--- nsalibselinux/src/init.c	2005-04-29 14:06:52.000000000 -0400
+++ libselinux-1.25.2/src/init.c	2005-08-17 15:51:32.000000000 -0400
@@ -7,13 +7,12 @@
 #include <ctype.h>
 #include <asm/page.h>
 #include <stdio.h>
+#include <dlfcn.h>
 
 #include "policy.h"
 
 char *selinux_mnt = NULL;
 
-static void init_selinuxmnt(void) __attribute__ ((constructor));
-
 static void init_selinuxmnt(void)
 {
 	char *buf, *bufp, *p;
@@ -63,8 +62,6 @@
 
 }
 
-static void fini_selinuxmnt(void) __attribute__ ((destructor));
-
 static void fini_selinuxmnt(void)
 {
 	free(selinux_mnt);
@@ -76,3 +73,60 @@
 	selinux_mnt = strdup(mnt);
 }
  
+int context_translations = 0;
+void *translation_lib_handle = NULL;
+/* from libsetrans.c */
+extern int (*lib_trans_to_raw_context)(char *raw, char **transp);
+extern int (*lib_raw_to_trans_context)(char *trans, char **rawp);
+
+
+static void init_translations(void)
+{
+	int (*lib_trans_init)(void) = NULL;
+
+	translation_lib_handle = dlopen("libsetrans.so.0", RTLD_NOW);
+	if (!translation_lib_handle)
+		return;
+
+	dlerror();
+
+	lib_trans_init = dlsym(translation_lib_handle,
+	                       "init_context_translations");
+	if (dlerror() || lib_trans_init())
+		return;
+
+	lib_raw_to_trans_context = dlsym(translation_lib_handle,
+	                                 "translate_context");
+	if (dlerror())
+		return;
+
+	lib_trans_to_raw_context = dlsym(translation_lib_handle,
+	                                 "untranslate_context");
+	if (dlerror())
+		return;
+
+	context_translations = 1;
+}
+
+static void fini_translations(void)
+{
+	context_translations = 0;
+	if (translation_lib_handle) {
+		dlclose(translation_lib_handle);
+		translation_lib_handle = NULL;
+	}
+}
+
+static void init_lib(void) __attribute__ ((constructor));
+static void init_lib(void)
+{
+	init_selinuxmnt();
+	init_translations();
+}
+
+static void fini_lib(void) __attribute__ ((destructor));
+static void fini_lib(void)
+{
+	fini_translations();
+	fini_selinuxmnt();
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/lgetfilecon.c libselinux-1.25.2/src/lgetfilecon.c
--- nsalibselinux/src/lgetfilecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/lgetfilecon.c	2005-08-17 15:51:32.000000000 -0400
@@ -1,13 +1,13 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <sys/xattr.h>
+#include "selinux_internal.h"
 #include "policy.h"
 
-int lgetfilecon(const char *path, security_context_t *context)
+int lgetfilecon_raw(const char *path, security_context_t *context)
 {
 	char *buf;
 	ssize_t size;
@@ -43,3 +43,22 @@
 		*context = buf;
 	return ret;
 }
+
+int lgetfilecon(const char *path, security_context_t *context)
+{
+	int ret;
+	security_context_t rcontext;
+
+ 	ret = lgetfilecon_raw(path, &rcontext);
+
+	if (context_translations && ret > 0) {
+		if (raw_to_trans_context(rcontext, context)) {
+			*context = NULL;
+			ret = -1;
+		}
+		freecon(rcontext);
+	} else
+		*context = rcontext;
+
+	return ret;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/lsetfilecon.c libselinux-1.25.2/src/lsetfilecon.c
--- nsalibselinux/src/lsetfilecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/lsetfilecon.c	2005-08-17 15:51:32.000000000 -0400
@@ -1,13 +1,29 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <sys/xattr.h>
+#include "selinux_internal.h"
 #include "policy.h"
 
-int lsetfilecon(const char *path, security_context_t context)
+int lsetfilecon_raw(const char *path, security_context_t context)
 {
 	return lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(context)+1, 0);
 }
+
+int lsetfilecon(const char *path, security_context_t context)
+{
+	int ret;
+	security_context_t rcontext = context;
+
+	if (context_translations && trans_to_raw_context(context, &rcontext))
+		return -1;
+
+ 	ret = lsetfilecon_raw(path, rcontext);
+
+	if (context_translations)
+		freecon(rcontext);
+
+	return ret;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/matchmediacon.c libselinux-1.25.2/src/matchmediacon.c
--- nsalibselinux/src/matchmediacon.c	2005-03-29 21:55:23.000000000 -0500
+++ libselinux-1.25.2/src/matchmediacon.c	2005-08-17 15:51:32.000000000 -0400
@@ -58,7 +58,14 @@
 	if (!(*ptr2)) {
 		return -1;
 	}
-	
-	*con = strdup(ptr2);
+
+	if (context_translations) {
+		if (raw_to_trans_context(ptr2, con)) {
+			*con = NULL;
+			return -1;
+		}
+	} else
+		*con = strdup(ptr2);
+
 	return 0;
 }
diff --exclude-from=exclude -N -u -r nsalibselinux/src/matchpathcon.c libselinux-1.25.2/src/matchpathcon.c
--- nsalibselinux/src/matchpathcon.c	2005-08-11 22:41:15.000000000 -0400
+++ libselinux-1.25.2/src/matchpathcon.c	2005-08-17 15:51:32.000000000 -0400
@@ -514,6 +514,18 @@
 		spec_arr[nspec].context = context;
 		
 		if (strcmp(context, "<<none>>")) {
+			if (context_translations) {
+				if (raw_to_trans_context(context,
+				                    &spec_arr[nspec].context)) {
+					myprintf("%s: line %u has invalid "
+					         "context %s\n",
+					         path, lineno, context);
+					return 0;
+				}
+				free(context);
+				context = spec_arr[nspec].context;
+			}
+
 			if (myinvalidcon(path, lineno, context))
 				return 0;
 		}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/rpm.c libselinux-1.25.2/src/rpm.c
--- nsalibselinux/src/rpm.c	2005-04-06 06:57:35.000000000 -0400
+++ libselinux-1.25.2/src/rpm.c	2005-08-17 15:51:32.000000000 -0400
@@ -16,15 +16,15 @@
 	if (is_selinux_enabled() < 1)
 		return execve(filename, argv, envp);
 
-	rc = getcon(&mycon);
+	rc = getcon_raw(&mycon);
 	if (rc < 0)
 		goto out;
 
-	rc = getfilecon(filename, &fcon);
+	rc = getfilecon_raw(filename, &fcon);
 	if (rc < 0)
 		goto out;
 
-	rc = security_compute_create(mycon, fcon, SECCLASS_PROCESS, &newcon);
+	rc = security_compute_create_raw(mycon, fcon, SECCLASS_PROCESS, &newcon);
 	if (rc < 0)
 		goto out;
 
@@ -41,7 +41,7 @@
 			goto out;
 	}
 
-	rc = setexeccon(newcon);
+	rc = setexeccon_raw(newcon);
 	if (rc < 0) 
 		goto out;
 	rc = execve(filename, argv, envp);
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_internal.h libselinux-1.25.2/src/selinux_internal.h
--- nsalibselinux/src/selinux_internal.h	2005-02-17 14:22:28.000000000 -0500
+++ libselinux-1.25.2/src/selinux_internal.h	2005-08-17 15:51:32.000000000 -0400
@@ -4,18 +4,25 @@
 hidden_proto(security_set_boolean)
 hidden_proto(security_commit_booleans)
 hidden_proto(security_check_context)
+hidden_proto(security_check_context_raw)
 hidden_proto(security_compute_av)
+hidden_proto(security_compute_av_raw)
 hidden_proto(security_compute_user)
+hidden_proto(security_compute_user_raw)
 hidden_proto(security_compute_create)
+hidden_proto(security_compute_create_raw)
 hidden_proto(is_selinux_enabled)
 hidden_proto(is_selinux_mls_enabled)
-hidden_proto(security_check_context)
 hidden_proto(freecon)
 hidden_proto(freeconary)
 hidden_proto(getprevcon)
+hidden_proto(getprevcon_raw)
 hidden_proto(getcon)
+hidden_proto(getcon_raw)
 hidden_proto(getfilecon)
+hidden_proto(getfilecon_raw)
 hidden_proto(setexeccon)
+hidden_proto(setexeccon_raw)
 hidden_proto(security_getenforce)
 hidden_proto(selinux_default_context_path)
 hidden_proto(selinux_failsafe_context_path)
@@ -27,3 +34,7 @@
 hidden_proto(selinux_media_context_path)
 hidden_proto(matchpathcon_init)
 hidden_proto(selinux_users_path)
+
+extern int context_translations;
+extern int trans_to_raw_context(char *raw, char **transp);
+extern int raw_to_trans_context(char *trans, char **rawp);
diff --exclude-from=exclude -N -u -r nsalibselinux/src/setcon.c libselinux-1.25.2/src/setcon.c
--- nsalibselinux/src/setcon.c	2004-11-30 15:59:03.000000000 -0500
+++ libselinux-1.25.2/src/setcon.c	2005-08-17 15:51:32.000000000 -0400
@@ -5,9 +5,9 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <selinux/selinux.h>
+#include "selinux_internal.h"
 
-int setcon(security_context_t context)
+int setcon_raw(security_context_t context)
 {
 	int fd;
 	ssize_t ret;
@@ -25,3 +25,19 @@
 	else
 		return 0;
 }
+
+int setcon(char *context)
+{
+	int ret;
+	security_context_t rcontext = context;
+
+	if (context_translations && trans_to_raw_context(context, &rcontext))
+		return -1;
+
+ 	ret = setcon_raw(rcontext);
+
+	if (context_translations)
+		freecon(rcontext);
+
+	return ret;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/setexeccon.c libselinux-1.25.2/src/setexeccon.c
--- nsalibselinux/src/setexeccon.c	2005-01-28 12:15:29.000000000 -0500
+++ libselinux-1.25.2/src/setexeccon.c	2005-08-17 15:51:32.000000000 -0400
@@ -3,7 +3,7 @@
 #include <string.h>
 #include "selinux_internal.h"
 
-int setexeccon(security_context_t context)
+int setexeccon_raw(security_context_t context)
 {
 	int fd;
 	ssize_t ret;
@@ -21,4 +21,21 @@
 	else
 		return 0;
 }
+hidden_def(setexeccon_raw)
+
+int setexeccon(char *context)
+{
+	int ret;
+	security_context_t rcontext = context;
+
+	if (context_translations && trans_to_raw_context(context, &rcontext))
+		return -1;
+
+ 	ret = setexeccon_raw(rcontext);
+
+	if (context_translations)
+		freecon(rcontext);
+
+	return ret;
+}
 hidden_def(setexeccon)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/setfilecon.c libselinux-1.25.2/src/setfilecon.c
--- nsalibselinux/src/setfilecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/setfilecon.c	2005-08-17 15:51:32.000000000 -0400
@@ -1,13 +1,29 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
-#include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <sys/xattr.h>
+#include "selinux_internal.h"
 #include "policy.h"
 
-int setfilecon(const char *path, security_context_t context)
+int setfilecon_raw(const char *path, security_context_t context)
 {
 	return setxattr(path, XATTR_NAME_SELINUX, context, strlen(context)+1, 0);
 }
+
+int setfilecon(const char *path, security_context_t context)
+{
+	int ret;
+	security_context_t rcontext = context;
+
+	if (context_translations && trans_to_raw_context(context, &rcontext))
+		return -1;
+
+ 	ret = setfilecon_raw(path, rcontext);
+
+	if (context_translations)
+		freecon(rcontext);
+
+	return ret;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/setfscreatecon.c libselinux-1.25.2/src/setfscreatecon.c
--- nsalibselinux/src/setfscreatecon.c	2004-10-20 16:31:36.000000000 -0400
+++ libselinux-1.25.2/src/setfscreatecon.c	2005-08-17 15:51:32.000000000 -0400
@@ -1,9 +1,9 @@
 #include <unistd.h>
 #include <string.h>
 #include <fcntl.h>
-#include <selinux/selinux.h>
+#include "selinux_internal.h"
 
-int setfscreatecon(char *context)
+int setfscreatecon_raw(char *context)
 {
 	int fd;
 	ssize_t ret;
@@ -21,3 +21,19 @@
 	else
 		return 0;
 }
+
+int setfscreatecon(char *context)
+{
+	int ret;
+	security_context_t rcontext = context;
+
+	if (context_translations && trans_to_raw_context(context, &rcontext))
+		return -1;
+
+ 	ret = setfscreatecon_raw(rcontext);
+
+	if (context_translations)
+		freecon(rcontext);
+
+	return ret;
+}
diff --exclude-from=exclude -N -u -r nsalibselinux/src/trans.c libselinux-1.25.2/src/trans.c
--- nsalibselinux/src/trans.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.25.2/src/trans.c	2005-08-17 15:51:32.000000000 -0400
@@ -0,0 +1,32 @@
+#include "selinux_internal.h"
+#include <string.h>
+
+int (*lib_trans_to_raw_context)(char *raw, char **transp) = NULL;
+int (*lib_raw_to_trans_context)(char *trans, char **rawp) = NULL;
+
+int trans_to_raw_context(char *raw, char **transp)
+{
+	if (!raw) {
+		*transp = NULL;
+		return 0;
+	}
+
+	if (lib_trans_to_raw_context(raw, transp))
+		*transp = strdup(raw);
+
+	return transp ? 0 : -1;
+}
+
+int raw_to_trans_context(char *trans, char **rawp)
+{
+	if (!trans) {
+		*rawp = NULL;
+		return 0;
+	}
+
+	if (lib_raw_to_trans_context(trans, rawp))
+		*rawp = strdup(trans);
+
+	return rawp ? 0 : -1;
+}
+

--------------090402060309070601010004
Content-Type: text/x-csrc;
 name="setrans.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setrans.c"

#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <ctype.h>
#include <selinux/selinux.h>
#include <selinux/context.h>

#define CATEGORYFILE "/etc/secat.conf"

/* Define data structures */
typedef struct selevel {
	char* name;
	char* sename;
} selevel_t;

/* catlist is a simple linked list of selevels extracted from the CATEGORYFILE */
typedef struct cat {
	struct cat *next;
	selevel_t level;
} cat_t;

static cat_t *catlist=NULL;

/* Remove excess white space */
static char *strtrim(char *dest, char *source, int size) {
	int i=0;
	char *ptr=source;
	i=0;
	while(isspace(*ptr) && i < size) {
		ptr++;
		i++;
	}
	strncpy(dest,ptr,size);
	for(i=strlen(dest)-1; i> 0; i--) {
		if (!isspace(dest[i])) break;
	}
	dest[i+1]='\0';
	return dest;
}
/* Process line from CATEGORYFILE. 
   Remove white space and set name do data before the "=" and sename to data
   after it */
static int process_category(char *buffer, cat_t **cat) {
	char name[BUFSIZ];
	char name1[BUFSIZ];
	int namesize=sizeof(name);
	struct cat *next;
	char *ptr;
	char *tok=strtok_r(buffer,"=",&ptr);
	if (!tok) return 0;
	strncpy(name1,tok, BUFSIZ-1);
	strtrim(name,name1,namesize-1);
	if ( name[0]=='#' ) return 0;
	tok=strtok_r(NULL,"\0",&ptr);
	if (!tok) return 0;
	while (isspace(*tok)) tok++;
	next=(cat_t *) calloc(sizeof(cat_t), 1);
	if (!next) return 0;
	next->level.name=strdup(name);
	if (!next->level.name) {
		free(next);
		return 0;
	}
	strncpy(name1,tok, BUFSIZ-1);
	strtrim(name,name1,namesize-1);
	next->level.sename=strdup(name);
	if (!next->level.sename) {
		free(next->level.name);
		free(next);
		return 0;
	}
	*cat=next;
	return 1;
}

/* Read in CATEGORYFILE Only runs once per process.  
   Might want to change to some kind of reload eventually, for long running
   processes.
 */
int init_context_translations() {
	FILE *cfg;
	cat_t *ptr=NULL;
	cat_t *next=NULL;
	size_t size=0;
	char *buffer=NULL;
	int ctr=0;
	if (catlist) return 0;
	cfg = fopen(CATEGORYFILE,"r");
	if (cfg == NULL) 
		return 1;

	ptr=catlist=calloc(1,sizeof(cat_t));
	while (getline(&buffer, &size, cfg) > 0) {
		if (process_category(buffer, &next)) {
			ctr++;
			ptr->next=next;
			ptr=next;
		}
	}
	if (buffer)
		free(buffer);
	return 0;
}

/* Look for selevel via internal name */
static char *translate(const char *cat) {
	cat_t *ptr=NULL;
	if (catlist) 
		for (ptr=catlist->next;ptr; ptr=ptr->next) 
			if (strcmp(cat,ptr->level.name)==0) 
				return strdup(ptr->level.sename); 
	return strdup(cat);
}

/* Look for selevel via external name */
static char *untranslate(const char *sename) {
	cat_t *ptr=NULL;
	if (catlist) 
		for(ptr=catlist->next;ptr; ptr=ptr->next)
			if (strcmp(sename,ptr->level.sename)==0) 
				return strdup(ptr->level.name); 
	return strdup(sename);
}

/* Look for selevel via external name */
int translate_context( const security_context_t oldcon, security_context_t *rcon) {
	const char *range=NULL;
	char *newrange=NULL;
	const char *ptr=NULL;
	context_t con=context_new(oldcon);

	if (! con)
		return -1;

	range=context_range_get(con);
	if (range) {
		if(strcmp(range,"s0") == 0 ) {
			context_range_set(con,NULL);
		}
		else 
		{
			ptr=strrchr(range,':');
			if (ptr) 
				ptr++;
			else
				ptr=range;
			newrange=translate(ptr);
			if (newrange) {
				context_range_set(con,newrange);
			}
		}
	}
	*rcon=strdup(context_str(con));
	context_free(con);
	return 0;
}

/* Look for selevel via external name */
int untranslate_context( const security_context_t oldcon, security_context_t *rcon) {
	const char *range=NULL;
	char *newrange=NULL;
	context_t con=context_new(oldcon);

	if (! con)
		return -1;

	range=context_range_get(con);
	if (range) {
		newrange=untranslate(range);
		if (newrange) {
			context_range_set(con,newrange);
		}
	}
	*rcon=strdup(context_str(con));
	context_free(con);
	return 0;
}



--------------090402060309070601010004--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
