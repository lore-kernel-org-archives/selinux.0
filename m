Message-ID: <463B3438.5050506@redhat.com>
Date: Fri, 04 May 2007 09:25:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: More swig changes for libselinux
Content-Type: multipart/mixed;
 boundary="------------010501010609080602020002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010501010609080602020002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added get_context_list.h

--------------010501010609080602020002
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

--- nsalibselinux/src/selinuxswig.i	2007-04-12 16:02:48.000000000 -0400
+++ libselinux-2.0.13/src/selinuxswig.i	2007-04-23 10:26:21.000000000 -0400
@@ -21,6 +21,7 @@
 %module selinux
 %{
 	#include "selinux/selinux.h"
+	#include "selinux/get_context_list.h"
 %}
 %apply int *OUTPUT { int * };
 %apply int *OUTPUT { size_t * };
@@ -42,8 +43,12 @@
 
 %typedef unsigned mode_t;
 
+%include "../include/selinux/get_context_list.h"
+
 extern int is_selinux_enabled(void);
 extern int is_selinux_mls_enabled(void);
+extern void freecon(security_context_t con);
+extern void freeconary(security_context_t * con);
 extern int getcon(security_context_t *con);
 extern int setcon(security_context_t con);
 extern int getpidcon(int pid, security_context_t *con);
@@ -90,6 +95,11 @@
 			mode_t mode,
 			security_context_t *con);
 
+extern int matchpathcon_init_prefix(const char *path,
+				    const char *prefix);
+extern void matchpathcon_fini(void);
+
+
 extern int matchmediacon(const char *media,
 		 security_context_t *con);
 
@@ -106,6 +116,7 @@
 extern const char *selinux_homedir_context_path(void);
 extern const char *selinux_media_context_path(void);
 extern const char *selinux_contexts_path(void);
+extern const char *selinux_securetty_types_path(void);
 extern const char *selinux_booleans_path(void);
 extern const char *selinux_customizable_types_path(void);
 extern const char *selinux_users_path(void);
@@ -113,11 +124,15 @@
 extern const char *selinux_translations_path(void);
 extern const char *selinux_netfilter_context_path(void);
 extern const char *selinux_path(void);
-extern int selinux_check_passwd_access(access_vector_t requested);
-extern int checkPasswdAccess(access_vector_t requested);
+#extern int selinux_check_passwd_access(access_vector_t requested);
+#extern int checkPasswdAccess(access_vector_t requested);
 
+extern int selinux_check_securetty_context(security_context_t tty_context);
+void set_selinuxmnt(char *mnt);
+
+#ifdef SWIGpython
 // This tells SWIG to treat char ** as a special case
-%typemap(python,in) char ** {
+%typemap(in) char ** {
   /* Check if is a list */
   if (PyList_Check($input)) {
     int size = PyList_Size($input);
@@ -143,6 +158,7 @@
     return NULL;
   }
 }
+#endif
 
 extern int rpm_execcon(unsigned int verified, 
 		       const char *filename, 
@@ -164,3 +180,7 @@
 }
 extern int selinux_getpolicytype(char **enforce);
 extern int getseuserbyname(const char *linuxuser, char **seuser, char **level);
+
+int selinux_file_context_cmp(const security_context_t a, const security_context_t b);
+int selinux_file_context_verify(const char *path, mode_t mode);
+int selinux_lsetfilecon_default(const char *path);

--------------010501010609080602020002--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
