Subject: [PATCH 3/6] libselinux: Remove obsolete interfaces and code for
	local boolean and user files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
References: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 09:53:54 -0400
Message-Id: <1177595634.24282.335.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove obsolete interfaces and code for local boolean and user files,
and remove the permanent flag from the security_set_boolean_list()
interface.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libselinux/include/selinux/selinux.h             |   10 -
 libselinux/man/man3/security_load_booleans.3     |   22 +-
 libselinux/man/man3/selinux_binary_policy_path.3 |    5 
 libselinux/man/man3/selinux_booleans_path.3      |    1 
 libselinux/src/booleans.c                        |  213 -----------------------
 libselinux/src/file_path_suffixes.h              |    2 
 libselinux/src/selinux_config.c                  |   36 +--
 libselinux/src/selinux_internal.h                |    2 
 libselinux/src/selinuxswig.i                     |    6 
 9 files changed, 26 insertions(+), 271 deletions(-)


Index: policyrep/libselinux/src/selinux_internal.h
===================================================================
--- policyrep/libselinux/src/selinux_internal.h	(revision 2382)
+++ policyrep/libselinux/src/selinux_internal.h	(working copy)
@@ -62,14 +62,12 @@
     hidden_proto(selinux_netfilter_context_path)
     hidden_proto(selinux_homedir_context_path)
     hidden_proto(selinux_user_contexts_path)
-    hidden_proto(selinux_booleans_path)
     hidden_proto(selinux_customizable_types_path)
     hidden_proto(selinux_media_context_path)
     hidden_proto(selinux_path)
     hidden_proto(selinux_check_passwd_access)
     hidden_proto(selinux_check_securetty_context)
     hidden_proto(matchpathcon_init_prefix)
-    hidden_proto(selinux_users_path)
     hidden_proto(selinux_usersconf_path);
 hidden_proto(selinux_translations_path);
 hidden_proto(selinux_getenforcemode);
Index: policyrep/libselinux/src/selinux_config.c
===================================================================
--- policyrep/libselinux/src/selinux_config.c	(revision 2382)
+++ policyrep/libselinux/src/selinux_config.c	(working copy)
@@ -27,18 +26,16 @@
 #define USER_CONTEXTS     5
 #define FAILSAFE_CONTEXT  6
 #define DEFAULT_TYPE      7
-#define BOOLEANS          8
-#define MEDIA_CONTEXTS    9
-#define REMOVABLE_CONTEXT 10
-#define CUSTOMIZABLE_TYPES    11
-#define USERS_DIR         12
-#define SEUSERS           13
-#define TRANSLATIONS      14
-#define NETFILTER_CONTEXTS    15
-#define FILE_CONTEXTS_HOMEDIR 16
-#define FILE_CONTEXTS_LOCAL 17
-#define SECURETTY_TYPES   18
-#define NEL               19
+#define MEDIA_CONTEXTS    8
+#define REMOVABLE_CONTEXT 9
+#define CUSTOMIZABLE_TYPES    10
+#define SEUSERS           11
+#define TRANSLATIONS      12
+#define NETFILTER_CONTEXTS    13
+#define FILE_CONTEXTS_HOMEDIR 14
+#define FILE_CONTEXTS_LOCAL 15
+#define SECURETTY_TYPES   16
+#define NEL               17
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -321,20 +314,6 @@
 
 hidden_def(selinux_user_contexts_path)
 
-const char *selinux_booleans_path()
-{
-	return get_path(BOOLEANS);
-}
-
-hidden_def(selinux_booleans_path)
-
-const char *selinux_users_path()
-{
-	return get_path(USERS_DIR);
-}
-
-hidden_def(selinux_users_path)
-
 const char *selinux_usersconf_path()
 {
 	return get_path(SEUSERS);
Index: policyrep/libselinux/include/selinux/selinux.h
===================================================================
--- policyrep/libselinux/include/selinux/selinux.h	(revision 2382)
+++ policyrep/libselinux/include/selinux/selinux.h	(working copy)
@@ -236,14 +236,8 @@
 	} SELboolean;
 	/* save a list of booleans in a single transaction.  */
 	extern int security_set_boolean_list(size_t boolcnt,
-					     SELboolean * boollist,
-					     int permanent);
+					     SELboolean * boollist);
 
-/* Load policy boolean settings.
-   Path may be NULL, in which case the booleans are loaded from
-   the active policy boolean configuration file. */
-	extern int security_load_booleans(char *path);
-
 /* Check the validity of a security context. */
 	extern int security_check_context(security_context_t con);
 	extern int security_check_context_raw(security_context_t con);
@@ -422,9 +416,7 @@
 	extern const char *selinux_media_context_path(void);
 	extern const char *selinux_contexts_path(void);
 	extern const char *selinux_securetty_types_path(void);
-	extern const char *selinux_booleans_path(void);
 	extern const char *selinux_customizable_types_path(void);
-	extern const char *selinux_users_path(void);
 	extern const char *selinux_usersconf_path(void);
 	extern const char *selinux_translations_path(void);
 	extern const char *selinux_netfilter_context_path(void);
Index: policyrep/libselinux/src/booleans.c
===================================================================
--- policyrep/libselinux/src/booleans.c	(revision 2382)
+++ policyrep/libselinux/src/booleans.c	(working copy)
@@ -234,162 +234,6 @@
 
 hidden_def(security_commit_booleans)
 
-static char *strtrim(char *dest, char *source, int size)
-{
-	int i = 0;
-	char *ptr = source;
-	i = 0;
-	while (isspace(*ptr) && i < size) {
-		ptr++;
-		i++;
-	}
-	strncpy(dest, ptr, size);
-	for (i = strlen(dest) - 1; i > 0; i--) {
-		if (!isspace(dest[i]))
-			break;
-	}
-	dest[i + 1] = '\0';
-	return dest;
-}
-static int process_boolean(char *buffer, char *name, int namesize, int *val)
-{
-	char name1[BUFSIZ];
-	char *ptr;
-	char *tok = strtok_r(buffer, "=", &ptr);
-	if (tok) {
-		strncpy(name1, tok, BUFSIZ - 1);
-		strtrim(name, name1, namesize - 1);
-		if (name[0] == '#')
-			return 0;
-		tok = strtok_r(NULL, "\0", &ptr);
-		if (tok) {
-			while (isspace(*tok))
-				tok++;
-			*val = -1;
-			if (isdigit(tok[0]))
-				*val = atoi(tok);
-			else if (!strncasecmp(tok, "true", sizeof("true") - 1))
-				*val = 1;
-			else if (!strncasecmp
-				 (tok, "false", sizeof("false") - 1))
-				*val = 0;
-			if (*val != 0 && *val != 1) {
-				errno = EINVAL;
-				return -1;
-			}
-
-		}
-	}
-	return 1;
-}
-static int save_booleans(size_t boolcnt, SELboolean * boollist)
-{
-	ssize_t len;
-	size_t i;
-	char outbuf[BUFSIZ];
-	char *inbuf = NULL;
-
-	/* Open file */
-	const char *bool_file = selinux_booleans_path();
-	char local_bool_file[PATH_MAX];
-	char tmp_bool_file[PATH_MAX];
-	FILE *boolf;
-	int fd;
-	int *used = (int *)malloc(sizeof(int) * boolcnt);
-	if (!used) {
-		return -1;
-	}
-	/* zero out used field */
-	for (i = 0; i < boolcnt; i++)
-		used[i] = 0;
-
-	snprintf(tmp_bool_file, sizeof(tmp_bool_file), "%s.XXXXXX", bool_file);
-	fd = mkstemp(tmp_bool_file);
-	if (fd < 0) {
-		free(used);
-		return -1;
-	}
-
-	snprintf(local_bool_file, sizeof(local_bool_file), "%s.local",
-		 bool_file);
-	boolf = fopen(local_bool_file, "r");
-	if (boolf != NULL) {
-		ssize_t ret;
-		size_t size = 0;
-		int val;
-		char boolname[BUFSIZ];
-		char *buffer;
-		inbuf = NULL;
-		__fsetlocking(boolf, FSETLOCKING_BYCALLER);
-		while ((len = getline(&inbuf, &size, boolf)) > 0) {
-			buffer = strdup(inbuf);
-			if (!buffer)
-				goto close_remove_fail;
-			ret =
-			    process_boolean(inbuf, boolname, sizeof(boolname),
-					    &val);
-			if (ret != 1) {
-				ret = write(fd, buffer, len);
-				free(buffer);
-				if (ret != len)
-					goto close_remove_fail;
-			} else {
-				free(buffer);
-				for (i = 0; i < boolcnt; i++) {
-					if (strcmp(boollist[i].name, boolname)
-					    == 0) {
-						snprintf(outbuf, sizeof(outbuf),
-							 "%s=%d\n", boolname,
-							 boollist[i].value);
-						len = strlen(outbuf);
-						used[i] = 1;
-						if (write(fd, outbuf, len) !=
-						    len)
-							goto close_remove_fail;
-						else
-							break;
-					}
-				}
-				if (i == boolcnt) {
-					snprintf(outbuf, sizeof(outbuf),
-						 "%s=%d\n", boolname, val);
-					len = strlen(outbuf);
-					if (write(fd, outbuf, len) != len)
-						goto close_remove_fail;
-				}
-			}
-			free(inbuf);
-			inbuf = NULL;
-		}
-		fclose(boolf);
-	}
-
-	for (i = 0; i < boolcnt; i++) {
-		if (used[i] == 0) {
-			snprintf(outbuf, sizeof(outbuf), "%s=%d\n",
-				 boollist[i].name, boollist[i].value);
-			len = strlen(outbuf);
-			if (write(fd, outbuf, len) != len) {
-			      close_remove_fail:
-				free(inbuf);
-				close(fd);
-			      remove_fail:
-				unlink(tmp_bool_file);
-				free(used);
-				return -1;
-			}
-		}
-
-	}
-	if (fchmod(fd, S_IRUSR | S_IWUSR) != 0)
-		goto close_remove_fail;
-	close(fd);
-	if (rename(tmp_bool_file, local_bool_file) != 0)
-		goto remove_fail;
-
-	free(used);
-	return 0;
-}
 static void rollback(SELboolean * boollist, int end)
 {
 	int i;
@@ -400,11 +244,11 @@
 								 name));
 }
 
-int security_set_boolean_list(size_t boolcnt, SELboolean * boollist,
-			      int permanent)
+int security_set_boolean_list(size_t boolcnt, SELboolean * boollist)
 {
 
 	size_t i;
+
 	for (i = 0; i < boolcnt; i++) {
 		if (security_set_boolean(boollist[i].name, boollist[i].value)) {
 			rollback(boollist, i);
@@ -416,59 +260,6 @@
 	if (security_commit_booleans()) {
 		return -1;
 	}
-
-	if (permanent)
-		return save_booleans(boolcnt, boollist);
-
 	return 0;
 }
-int security_load_booleans(char *path)
-{
-	FILE *boolf;
-	char *inbuf;
-	char localbools[BUFSIZ];
-	size_t len = 0, errors = 0;
-	int val;
-	char name[BUFSIZ];
 
-	boolf = fopen(path ? path : selinux_booleans_path(), "r");
-	if (boolf == NULL)
-		goto localbool;
-
-	__fsetlocking(boolf, FSETLOCKING_BYCALLER);
-	while (getline(&inbuf, &len, boolf) > 0) {
-		int ret = process_boolean(inbuf, name, sizeof(name), &val);
-		if (ret == -1)
-			errors++;
-		if (ret == 1)
-			if (security_set_boolean(name, val) < 0) {
-				errors++;
-			}
-	}
-	fclose(boolf);
-      localbool:
-	snprintf(localbools, sizeof(localbools), "%s.local",
-		 (path ? path : selinux_booleans_path()));
-	boolf = fopen(localbools, "r");
-
-	if (boolf != NULL) {
-		int ret;
-		__fsetlocking(boolf, FSETLOCKING_BYCALLER);
-		while (getline(&inbuf, &len, boolf) > 0) {
-			ret = process_boolean(inbuf, name, sizeof(name), &val);
-			if (ret == -1)
-				errors++;
-			if (ret == 1)
-				if (security_set_boolean(name, val) < 0) {
-					errors++;
-				}
-		}
-		fclose(boolf);
-	}
-	if (security_commit_booleans() < 0)
-		return -1;
-
-	if (errors)
-		errno = EINVAL;
-	return errors ? -1 : 0;
-}
Index: policyrep/libselinux/src/file_path_suffixes.h
===================================================================
--- policyrep/libselinux/src/file_path_suffixes.h	(revision 2382)
+++ policyrep/libselinux/src/file_path_suffixes.h	(working copy)
@@ -8,11 +8,9 @@
     S_(FAILSAFE_CONTEXT, "/contexts/failsafe_context")
     S_(DEFAULT_TYPE, "/contexts/default_type")
     S_(SECURETTY_TYPES, "/contexts/securetty_types")
-    S_(BOOLEANS, "/booleans")
     S_(MEDIA_CONTEXTS, "/contexts/files/media")
     S_(REMOVABLE_CONTEXT, "/contexts/removable_context")
     S_(CUSTOMIZABLE_TYPES, "/contexts/customizable_types")
-    S_(USERS_DIR, "/users/")
     S_(SEUSERS, "/seusers")
     S_(TRANSLATIONS, "/setrans.conf")
     S_(NETFILTER_CONTEXTS, "/contexts/netfilter_contexts")
Index: policyrep/libselinux/src/selinuxswig.i
===================================================================
--- policyrep/libselinux/src/selinuxswig.i	(revision 2382)
+++ policyrep/libselinux/src/selinuxswig.i	(working copy)
@@ -66,9 +66,7 @@
 extern int selinux_mkload_policy(int preservebools);
 extern int selinux_init_load_policy(int *enforce);
 extern int security_set_boolean_list(size_t boolcnt, 
-				     SELboolean *boollist, 
-				     int permanent);
-extern int security_load_booleans(char *path);
+				     SELboolean *boollist);
 extern int security_check_context(security_context_t con);
 extern int security_canonicalize_context(security_context_t con,
 					 security_context_t *canoncon);
@@ -106,9 +104,7 @@
 extern const char *selinux_homedir_context_path(void);
 extern const char *selinux_media_context_path(void);
 extern const char *selinux_contexts_path(void);
-extern const char *selinux_booleans_path(void);
 extern const char *selinux_customizable_types_path(void);
-extern const char *selinux_users_path(void);
 extern const char *selinux_usersconf_path(void);
 extern const char *selinux_translations_path(void);
 extern const char *selinux_netfilter_context_path(void);
Index: policyrep/libselinux/man/man3/selinux_booleans_path.3
===================================================================
--- policyrep/libselinux/man/man3/selinux_booleans_path.3	(revision 2382)
+++ policyrep/libselinux/man/man3/selinux_booleans_path.3	(working copy)
@@ -1 +0,0 @@
-.so man3/selinux_binary_policy_path.3
Index: policyrep/libselinux/man/man3/security_load_booleans.3
===================================================================
--- policyrep/libselinux/man/man3/security_load_booleans.3	(revision 2382)
+++ policyrep/libselinux/man/man3/security_load_booleans.3	(working copy)
@@ -1,13 +1,11 @@
 .TH "security_get_boolean_names" "3" "15 November 2004" "dwalsh@redhat.com" "SELinux API Documentation"
 .SH "NAME"
-security_load_booleans, security_set_boolean, security_commit_booleans, 
+security_set_boolean_list, security_set_boolean, security_commit_booleans, 
 security_get_boolean_names, security_get_boolean_active,
 security_get_boolean_pending \- routines for manipulating SELinux boolean values
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-extern int security_load_booleans(char *path);
-.br
 extern int security_get_boolean_names(char ***names, int *len);
 .br
 extern int security_get_boolean_pending(const char *name);
@@ -17,21 +15,19 @@
 extern int security_set_boolean(const char *name, int value);
 .br
 extern int security_commit_booleans(void);
+.br.
+extern int security_set_boolean_list(size_t boolcnt, SELboolean *boollist);
 
-
 .SH "DESCRIPTION"
 
 The SELinux policy can include conditional rules that are enabled or
 disabled based on the current values of a set of policy booleans.
 These policy booleans allow runtime modification of the security
-policy without having to load a new policy.  
+policy without having to load a new policy.  These interfaces
+allow for the manipulation of the active boolean values at runtime
+without changing them persistently.  Persistent changes must be
+performed using the libsemanage interfaces.
 
-The SELinux API allows for a transaction based update.  So you can set several boolean values and the commit them all at once.
-
-security_load_booleans
-.br
-Load policy boolean settings. Path may be NULL, in which case the booleans are loaded from the active policy boolean configuration file.
-
 security_get_boolean_names
 .br
 Returns a list of boolean names, currently supported by the loaded policy.
@@ -52,6 +48,10 @@
 .br
 Commit all pending values for the booleans.
 
+security_set_boolean_list
+.br
+Set a list of booleans to new values.
+
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 
Index: policyrep/libselinux/man/man3/selinux_binary_policy_path.3
===================================================================
--- policyrep/libselinux/man/man3/selinux_binary_policy_path.3	(revision 2382)
+++ policyrep/libselinux/man/man3/selinux_binary_policy_path.3	(working copy)
@@ -4,7 +4,7 @@
 selinux_failsafe_context_path, selinux_removable_context_path,
 selinux_default_context_path, selinux_user_contexts_path,
 selinux_file_context_path, selinux_media_context_path,
-selinux_contexts_path, selinux_booleans_path \- These functions return the paths to the active SELinux policy configuration
+selinux_contexts_path, \- These functions return the paths to the active SELinux policy configuration
 directories and files.
 
 .SH "SYNOPSIS"
@@ -31,9 +31,7 @@
 .br
 extern const char *selinux_contexts_path(void);
 .br
-extern const char *selinux_booleans_path(void);
 
-
 .SH "DESCRIPTION"
 
 These functions return the paths to the active policy configuration
@@ -60,7 +58,6 @@
 .sp
 selinux_securetty_types_path() - defines tty types for newrole securettys
 .sp
-selinux_booleans_path() - initial policy boolean settings
 
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
