Subject: [PATCH 1/4] features/fixes for rawhide and refpolicy
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-SFDbiK3Pq3MQNqOgKL43"
Date: Mon, 24 Oct 2005 12:58:54 -0400
Message-Id: <1130173134.15661.24.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-SFDbiK3Pq3MQNqOgKL43
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds paths to libselinux necessary for libsemanage, specifically
homedir_template and selinux_root

Joshua

--=-SFDbiK3Pq3MQNqOgKL43
Content-Disposition: attachment; filename=1-libselinux-paths.diff
Content-Type: text/x-patch; name=1-libselinux-paths.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -purN -x .svn libselinux/src/compat_file_path.h libselinux/src/compat_file_path.h
--- libselinux/src/compat_file_path.h	2005-10-11 13:49:55.000000000 -0400
+++ libselinux/src/compat_file_path.h	2005-10-24 08:12:27.000000000 -0400
@@ -2,6 +2,7 @@
 S_(BINPOLICY, SECURITYDIR "/selinux/policy")
 S_(CONTEXTS_DIR, SECURITYDIR)
 S_(FILE_CONTEXTS, SECURITYDIR "/selinux/file_contexts")
+S_(HOMEDIR_CONTEXTS, SECURITYDIR "/homedir_template")
 S_(DEFAULT_CONTEXTS, SECURITYDIR "/default_contexts")
 S_(USER_CONTEXTS, SECURITYDIR "/default_contexts.user/")
 S_(FAILSAFE_CONTEXT, SECURITYDIR "/failsafe_context")
diff -purN -x .svn libselinux/src/file_path_suffixes.h libselinux/src/file_path_suffixes.h
--- libselinux/src/file_path_suffixes.h	2005-10-11 13:49:55.000000000 -0400
+++ libselinux/src/file_path_suffixes.h	2005-10-22 18:00:04.000000000 -0400
@@ -2,6 +2,7 @@
 S_(BINPOLICY, "/policy/policy")
 S_(CONTEXTS_DIR, "/contexts")
 S_(FILE_CONTEXTS, "/contexts/files/file_contexts")
+S_(HOMEDIR_CONTEXTS, "/contexts/files/homedir_template")
 S_(DEFAULT_CONTEXTS, "/contexts/default_contexts")
 S_(USER_CONTEXTS, "/contexts/users/")
 S_(FAILSAFE_CONTEXT, "/contexts/failsafe_context")
diff -purN -x .svn libselinux/src/selinux_config.c libselinux/src/selinux_config.c
--- libselinux/src/selinux_config.c	2005-10-11 13:50:00.000000000 -0400
+++ libselinux/src/selinux_config.c	2005-10-24 08:12:27.000000000 -0400
@@ -21,17 +21,18 @@
 #define BINPOLICY         0
 #define CONTEXTS_DIR      1    
 #define FILE_CONTEXTS     2
-#define DEFAULT_CONTEXTS  3
-#define USER_CONTEXTS     4
-#define FAILSAFE_CONTEXT  5
-#define DEFAULT_TYPE      6
-#define BOOLEANS          7
-#define MEDIA_CONTEXTS    8
-#define REMOVABLE_CONTEXT 9
-#define CUSTOMIZABLE_TYPES    10
-#define USERS_DIR         11
-#define SEUSERS           12
-#define NEL               13
+#define HOMEDIR_CONTEXTS  3
+#define DEFAULT_CONTEXTS  4
+#define USER_CONTEXTS     5
+#define FAILSAFE_CONTEXT  6
+#define DEFAULT_TYPE      7
+#define BOOLEANS          8
+#define MEDIA_CONTEXTS    9
+#define REMOVABLE_CONTEXT 10
+#define CUSTOMIZABLE_TYPES    11
+#define USERS_DIR         12
+#define SEUSERS           13
+#define NEL               14
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -121,6 +122,7 @@ int selinux_getenforcemode(int *enforce)
 hidden_def(selinux_getenforcemode)
 
 static char *selinux_policyroot = NULL;
+static char *selinux_rootpath = NULL;
 
 static void init_selinux_config(void) __attribute__ ((constructor));
 
@@ -134,10 +136,12 @@ static void init_selinux_config(void)
   if (selinux_policyroot) return;
   if (access(SELINUXDIR, F_OK) != 0) {
 	  selinux_policyroot = SECURITYDIR;
+	  selinux_rootpath = SECURITYDIR;
 	  use_compat_file_path = 1;
 	  return;
   }
 
+  selinux_rootpath = SELINUXDIR;
   fp = fopen(SELINUXCONFIG,"r");
   if (fp) {
 	  while (getline(&line_buf, &len, fp) > 0) {
@@ -237,6 +241,11 @@ const char *selinux_policy_root() {
 	return selinux_policyroot;
 }
 
+const char *selinux_path() {
+	return selinux_rootpath;
+}
+hidden_def(selinux_path)
+
 const char *selinux_default_context_path() {
   return get_path(DEFAULT_CONTEXTS);
 }
@@ -262,6 +271,11 @@ const char *selinux_file_context_path() 
 }
 hidden_def(selinux_file_context_path)
 
+const char *selinux_homedir_context_path() {
+  return get_path(HOMEDIR_CONTEXTS);
+}
+hidden_def(selinux_homedir_context_path)
+
 const char *selinux_media_context_path() {
   return get_path(MEDIA_CONTEXTS);
 }
diff -purN -x .svn libselinux/src/selinux_internal.h libselinux/src/selinux_internal.h
--- libselinux/src/selinux_internal.h	2005-10-11 13:50:00.000000000 -0400
+++ libselinux/src/selinux_internal.h	2005-10-24 08:12:27.000000000 -0400
@@ -50,10 +50,12 @@ hidden_proto(selinux_default_context_pat
 hidden_proto(selinux_failsafe_context_path)
 hidden_proto(selinux_removable_context_path)
 hidden_proto(selinux_file_context_path)
+hidden_proto(selinux_homedir_context_path)
 hidden_proto(selinux_user_contexts_path)
 hidden_proto(selinux_booleans_path)
 hidden_proto(selinux_customizable_types_path)
 hidden_proto(selinux_media_context_path)
+hidden_proto(selinux_path)
 hidden_proto(selinux_check_passwd_access)
 hidden_proto(matchpathcon_init)
 hidden_proto(selinux_users_path)
diff -purN -x .svn libselinux/include/selinux/selinux.h libselinux/include/selinux/selinux.h
--- libselinux/include/selinux/selinux.h	2005-10-11 13:49:50.000000000 -0400
+++ libselinux/include/selinux/selinux.h	2005-10-24 08:12:26.000000000 -0400
@@ -352,12 +352,14 @@ extern const char *selinux_removable_con
 extern const char *selinux_default_context_path(void);
 extern const char *selinux_user_contexts_path(void);
 extern const char *selinux_file_context_path(void);
+extern const char *selinux_homedir_context_path(void);
 extern const char *selinux_media_context_path(void);
 extern const char *selinux_contexts_path(void);
 extern const char *selinux_booleans_path(void);
 extern const char *selinux_customizable_types_path(void);
 extern const char *selinux_users_path(void);
 extern const char *selinux_usersconf_path(void);
+extern const char *selinux_path(void);
 
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */

--=-SFDbiK3Pq3MQNqOgKL43--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
