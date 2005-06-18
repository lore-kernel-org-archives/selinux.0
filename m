Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5KCOdgA024364
	for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2005 08:24:39 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5KCEqs2003385
	for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2005 12:14:52 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j5KCG3KH003551
	for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2005 08:16:03 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j5KCG3QL003550
	for selinux@tycho.nsa.gov; Mon, 20 Jun 2005 08:16:03 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5IMAvgA016515
	for <selinux@tycho.nsa.gov>; Sat, 18 Jun 2005 18:10:57 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5IM1Pfq006936
	for <selinux@tycho.nsa.gov>; Sat, 18 Jun 2005 22:01:25 GMT
Subject: Useradd Integration (v. 2)
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: SELinux <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: multipart/mixed; boundary="=-b1s4koXcpBZhnnD1euSm"
Date: Sat, 18 Jun 2005 18:03:39 -0400
Message-Id: <1119132219.26988.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-b1s4koXcpBZhnnD1euSm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here's v.2 of my useradd patch.

I'm sure it has lots of bugs - I have yet to pass valgrind,
and address FIXMEs.. but at least it shows something working here.. 
I also still haven't addressed Steven's concerns about
multiline parsing, and proper default role, but I'll
get to that eventually.

Patch does:

- break up libsepol genusers into policy and file portions,
to allow future work on different backends than a flat file

- several handlers to do various things like add user, delete user,
iterate users, modify user, add role, delete role, set roles 

- designate functions that work with the policy image as "backwards
compatibility". Instead, we will work with the policydb, which will be
faster, and simpler. That way the image doesn't have to be analyzed
and the db reconstructed on every function call.

- unify most of policycoreutils/load_policy.c into a single function
in libselinux. This will simplify reloading the policy from different
programs. If you're wondering why that portion of the headers is 
in selinux-sepol.h, it's because I can't add <sepol/policydb.h>
due to header conflict (sidtab).

- first pass useradd integration. No usermod and userdel 
integration yet
==========

Next, I will work on writing C functions for manipulating the
homedir_template file. They will be analogous to users_file.c,
and basically move genhomedircon's job into the libsepol library.

The idea is that the users_file functions will invoke template
manipulating functions whenever the user is added, deleted, or 
the user's default role is changed. It will properly edit 
file_contexts.homedirs, and also restorecon the right things
if the user's defrole is changed.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-b1s4koXcpBZhnnD1euSm
Content-Disposition: attachment; filename=libselinux.diff
Content-Type: text/x-patch; name=libselinux.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur libselinux-1.23.10.orig/include/selinux/selinux.h libselinux-1.23.10.new/include/selinux/selinux.h
--- libselinux-1.23.10.orig/include/selinux/selinux.h	2005-06-16 15:30:20.000000000 -0400
+++ libselinux-1.23.10.new/include/selinux/selinux.h	2005-06-18 01:14:43.000000000 -0400
@@ -1,6 +1,7 @@
 #ifndef _SELINUX_H_
 #define _SELINUX_H_
 
+#include <stdlib.h>
 #include <sys/types.h>
 #include <stdarg.h>
 
@@ -9,6 +10,8 @@
 {
 #endif
 
+extern void security_debug(int on);
+
 /* Return 1 if we are running on a SELinux kernel, or 0 if not or -1 if we get an error. */
 extern int is_selinux_enabled(void);
 /* Return 1 if we are running on a SELinux MLS kernel, or 0 otherwise. */
@@ -133,7 +136,7 @@
 				 const char *username,
 				 security_context_t **con);
 
-/* Load a policy configuration. */
+/* Load a policy image. */
 extern int security_load_policy(void *data, size_t len);
 
 /* Translate boolean strict to name value pair. */
diff -Naur libselinux-1.23.10.orig/include/selinux/selinux-sepol.h libselinux-1.23.10.new/include/selinux/selinux-sepol.h
--- libselinux-1.23.10.orig/include/selinux/selinux-sepol.h	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.23.10.new/include/selinux/selinux-sepol.h	2005-06-18 01:15:55.000000000 -0400
@@ -0,0 +1,26 @@
+#ifndef _SELINUX_SEPOL_H
+#define _SELINUX_SEPOL_H
+
+#include <sepol/policydb.h>
+
+/* Create a policy database */
+int security_create_policydb(
+	policydb_t** policydb,
+	const char* polpath_arg,
+	const char* boolpath_arg,
+	int setbools_arg);
+
+/* Create a policydb from the default configuration */
+static inline int security_create_default_policydb(policydb_t** policydb) {
+	return security_create_policydb(policydb, NULL, NULL, 1);
+}
+
+/* Destroy a policy database */
+static inline void security_destroy_policydb(policydb_t* policydb) {
+	policydb_destroy(policydb);
+	free(policydb);
+}
+
+/* Load a policy database */
+extern int security_load_policydb(policydb_t* policydb);
+#endif
diff -Naur libselinux-1.23.10.orig/src/debug.c libselinux-1.23.10.new/src/debug.c
--- libselinux-1.23.10.orig/src/debug.c	2005-06-16 15:10:08.000000000 -0400
+++ libselinux-1.23.10.new/src/debug.c	2005-06-17 14:20:46.000000000 -0400
@@ -1,7 +1,11 @@
 #include <stdarg.h>
 #include <stdio.h>
 
-int seldebug = 1;
+static int seldebug = 1;
+
+void security_debug(int on) {
+	seldebug = on;
+}
 
 __attribute__ ((format (printf, 1, 2))) 
 void __selinux_debug_printf(const char *fmt, ...) {
diff -Naur libselinux-1.23.10.orig/src/load_policy.c libselinux-1.23.10.new/src/load_policy.c
--- libselinux-1.23.10.orig/src/load_policy.c	2005-04-29 14:07:14.000000000 -0400
+++ libselinux-1.23.10.new/src/load_policy.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,27 +0,0 @@
-#include <unistd.h>
-#include <sys/types.h>
-#include <fcntl.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <errno.h>
-#include <selinux/selinux.h>
-#include "policy.h"
-#include <limits.h>
-
-int security_load_policy(void *data, size_t len)
-{
-	char path[PATH_MAX];
-	int fd, ret;
-	
-	snprintf(path, sizeof path, "%s/load", selinux_mnt);
-	fd = open(path, O_RDWR);
-	if (fd < 0) 
-		return -1;
-
-	ret = write(fd, data, len);
-	close(fd);
-	if (ret < 0)
-		return -1;
-	return 0;
-}
-
diff -Naur libselinux-1.23.10.orig/src/Makefile libselinux-1.23.10.new/src/Makefile
--- libselinux-1.23.10.orig/src/Makefile	2005-04-29 14:07:14.000000000 -0400
+++ libselinux-1.23.10.new/src/Makefile	2005-06-16 16:54:49.000000000 -0400
@@ -13,6 +13,7 @@
 LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
 CFLAGS = -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I../include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
+LDFLAGS = -lsepol
 RANLIB=ranlib
 
 all: $(LIBA) $(LIBSO)
diff -Naur libselinux-1.23.10.orig/src/policy.c libselinux-1.23.10.new/src/policy.c
--- libselinux-1.23.10.orig/src/policy.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.23.10.new/src/policy.c	2005-06-18 01:33:12.000000000 -0400
@@ -0,0 +1,279 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <limits.h>
+#include <unistd.h>
+#include <string.h>
+#include "policy.h"
+
+#include <selinux/selinux-sepol.h>
+#include <sepol/selinux.h>
+#include "selinux_internal.h"
+
+static inline int try_open(const char* polpath) {
+	int fd = open(polpath, O_RDONLY);
+
+	if (fd < 0) {
+		__selinux_debug_printf(
+			"%s: could not open '%s' for reading: %s\n",
+			__FUNCTION__, polpath, strerror(errno));
+		return -1;
+	}
+
+	return fd;
+}
+
+static inline int map_policy(const char* polpath_arg, int ntries, 
+	void** map, size_t* map_len) {
+
+	int fd = -1;
+	struct stat sb;
+	char polpath[PATH_MAX];
+
+	/* Did the user specify where to load from ? */
+	if (polpath_arg != NULL) {
+
+		/* Open a valid policy */
+		snprintf(polpath, sizeof polpath, "%s", polpath_arg);
+
+		fd = try_open(polpath);
+		if (fd < 0)
+			return -1;
+	}
+
+	/* He/she didn't. Try some things. */
+	else {
+		int vers = -1;
+
+		/* Open a valid policy */
+		while (ntries-- && (fd < 0)) {
+
+			vers = (vers == -1)? security_policyvers(): vers - 1;
+
+			/* Try a particular version */
+			snprintf(polpath, sizeof polpath, "%s.%d",
+				selinux_binary_policy_path(), vers);
+
+			fd = try_open(polpath);
+		}
+
+                if (fd < 0)
+			return -1;
+        }
+
+	/* Stat policy */
+	if (fstat(fd, &sb) < 0) {
+		__selinux_debug_printf(
+			"%s: could not stat '%s': %s\n",
+			__FUNCTION__, polpath, strerror(errno));
+		close(fd);
+		return -1;
+	}
+
+	/* Map policy file */
+	*map_len = sb.st_size;
+	*map = mmap(NULL, *map_len, PROT_READ | PROT_WRITE, 
+		MAP_PRIVATE, fd, 0);
+
+	if (*map == MAP_FAILED) {
+		__selinux_debug_printf(
+			"%s: could not map '%s': %s\n",
+		__FUNCTION__, polpath, strerror(errno));
+		close(fd);
+		return -1;
+        }
+
+	return 0;
+}
+
+static inline int load_file_booleans(
+	policydb_t* tmp_policydb, const char* boolpath_arg) {
+
+	const char* boolpath =
+		(boolpath_arg == NULL) ?
+		selinux_booleans_path():boolpath_arg;
+
+	if (sepol_load_booleans(tmp_policydb, boolpath) < 0) {
+
+		/* No booleans file or state booleans - non-fatal. */
+		if (errno == ENOENT || errno == EINVAL)
+			__selinux_debug_printf("%s: warning while "
+			"setting booleans from %s: %s\n", __FUNCTION__,
+				boolpath, strerror(errno));
+
+		/* Fatal error */
+		else {
+			__selinux_debug_printf("%s: error while "
+			"setting booleans from %s: %s\n", __FUNCTION__,
+				boolpath, strerror(errno));
+
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static inline int load_current_booleans(policydb_t* tmp_policydb) {
+	int i, ret = 0;
+
+	char** names = NULL;
+	int names_len = 0;
+	int* values = NULL;
+		
+	/* Preserve current boolean values. */
+	if (security_get_boolean_names(&names, &names_len)) {
+		/* Possibly ok, as there may be no booleans. */
+		__selinux_debug_printf("%s: Warning! unable to "
+			"get boolean names: %s\n",
+			__FUNCTION__, strerror(errno));
+		goto exit;
+	}
+	if (!names_len)
+		goto exit;
+
+	values = malloc(sizeof(int) * names_len);
+	if (!values) {
+		__selinux_debug_printf("%s: out of memory\n", __FUNCTION__);
+			ret = -1;
+			goto exit;
+	}
+
+	for (i = 0; i < names_len; i++) {
+		values[i] = security_get_boolean_active(names[i]);
+		if (values[i] < 0) {
+			__selinux_debug_printf("%s: Error while "
+				"getting value for boolean %s: %s\n",
+				__FUNCTION__, names[i], strerror(errno));
+				ret = -1;
+				goto exit;
+		}
+	}
+
+	if (sepol_load_booleans_array(tmp_policydb, names, values, names_len) < 0) {
+
+		/* No booleans file or state booleans - non-fatal. */
+		if (errno == ENOENT || errno == EINVAL)
+			__selinux_debug_printf("%s: warning while "
+				"setting booleans: %s\n", 
+				__FUNCTION__, strerror(errno));
+
+		/* Fatal error */
+		else {
+			__selinux_debug_printf("%s: error while "
+				"setting booleans: %s\n", 
+				__FUNCTION__, strerror(errno));
+
+			ret = -1;
+			goto exit;
+		}
+	}
+
+	exit:
+        for (i = 0; i < names_len; i++)
+                free(names[i]);
+        free(names);
+        free(values);
+
+	return ret;
+}
+
+int security_create_policydb(
+	policydb_t** policydb, 
+	const char* polpath_arg, 
+	const char* boolpath_arg, 
+	int setbools) {
+
+	/* Paths */
+	const char* usrpath = selinux_users_path();
+
+	/* Policy map */	
+	void* map = NULL;
+	size_t map_len; 
+
+	/* Temporary policydb */
+	policydb_t* tmp_policydb = 
+		(policydb_t*) malloc(sizeof(policydb_t));
+
+	if (!tmp_policydb) {
+		__selinux_debug_printf("%s: out of memory", __FUNCTION__);
+		goto err;
+	}
+
+	/* Map policy file */
+	if (map_policy(polpath_arg, 3, &map, &map_len) < 0)
+		goto err;
+
+	/* Construct a policy db */
+	if (policydb_from_image(map, map_len, tmp_policydb) < 0) {
+		munmap(map, map_len);
+		goto err;
+	}
+	munmap(map, map_len);
+
+	/* Load users. Error is not fatal. */
+	if (sepol_file_load_users(tmp_policydb, usrpath) < 0) {
+		__selinux_debug_printf(
+			"%s: error while setting user configuration "
+			"from %s: %s\n", __FUNCTION__, usrpath, 
+			strerror(errno));
+	}
+
+	/* Load booleans */
+	if (setbools) {
+		if (load_file_booleans(tmp_policydb, boolpath_arg) < 0) 
+			goto err;
+	}
+	else if (load_current_booleans(tmp_policydb) < 0) 
+		goto err;
+
+
+	/* Update policydb pointer */
+	*policydb = tmp_policydb;
+
+	return 0; 
+
+err:
+	/* Destroy policydb */
+	policydb_destroy(tmp_policydb);
+	free(tmp_policydb);
+
+	return -1;
+}
+
+int security_load_policydb(policydb_t* policydb) {
+	void* data = NULL;
+	size_t len;
+
+	if (policydb_to_image(policydb, &data, &len) < 0)
+		goto err;
+
+	if (security_load_policy(data, len) < 0)
+		goto err;	
+
+	free(data);
+        return 0;
+
+	err:
+	free(data);
+	return -1;	
+}
+
+int security_load_policy(void *data, size_t len) {
+        char path[PATH_MAX];
+        int fd, ret;
+
+        snprintf(path, sizeof path, "%s/load", selinux_mnt);
+        fd = open(path, O_RDWR);
+        if (fd < 0)
+                return -1;
+
+        ret = write(fd, data, len);
+        close(fd);
+        if (ret < 0)
+                return -1;
+        return 0;
+}
diff -Naur libselinux-1.23.10.orig/src/selinux_internal.h libselinux-1.23.10.new/src/selinux_internal.h
--- libselinux-1.23.10.orig/src/selinux_internal.h	2005-04-29 14:07:14.000000000 -0400
+++ libselinux-1.23.10.new/src/selinux_internal.h	2005-06-18 00:28:12.000000000 -0400
@@ -1,6 +1,9 @@
 #include <selinux/selinux.h>
 #include "dso.h"
 
+__attribute__ ((format (printf, 1, 2)))
+void __selinux_debug_printf(const char *fmt, ...);
+
 hidden_proto(security_set_boolean)
 hidden_proto(security_commit_booleans)
 hidden_proto(security_check_context)

--=-b1s4koXcpBZhnnD1euSm
Content-Disposition: attachment; filename=libsepol.diff
Content-Type: text/x-patch; name=libsepol.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur libsepol-1.5.9.orig/include/sepol/booleans.h libsepol-1.5.9.new/include/sepol/booleans.h
--- libsepol-1.5.9.orig/include/sepol/booleans.h	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/include/sepol/booleans.h	2005-06-18 00:04:32.000000000 -0400
@@ -0,0 +1,10 @@
+#ifndef _SEPOL_BOOLEANS_H
+#define _SEPOL_BOOLEANS_H
+
+#include <sepol/policydb.h>
+
+extern int sepol_load_booleans(policydb_t* policydb, const char *boolpath);
+extern int sepol_load_booleans_array(
+	policydb_t* policydb, char **names, int *values, int nel);
+
+#endif
diff -Naur libsepol-1.5.9.orig/include/sepol/context.h libsepol-1.5.9.new/include/sepol/context.h
--- libsepol-1.5.9.orig/include/sepol/context.h	2005-06-16 12:35:08.000000000 -0400
+++ libsepol-1.5.9.new/include/sepol/context.h	2005-06-17 21:33:31.000000000 -0400
@@ -20,7 +20,6 @@
 #define _CONTEXT_H_
 
 #include <sepol/ebitmap.h>
-#include <sepol/sepol.h>
 #include <sepol/mls_types.h>
 
 /*
diff -Naur libsepol-1.5.9.orig/include/sepol/hashtab.h libsepol-1.5.9.new/include/sepol/hashtab.h
--- libsepol-1.5.9.orig/include/sepol/hashtab.h	2005-06-16 12:35:06.000000000 -0400
+++ libsepol-1.5.9.new/include/sepol/hashtab.h	2005-06-16 12:36:18.000000000 -0400
@@ -18,8 +18,8 @@
 #include <errno.h>
 #include <stdio.h>
 
-typedef char *hashtab_key_t;	/* generic key type */
-typedef void *hashtab_datum_t;	/* generic datum type */
+typedef char *hashtab_key_t;		/* generic key type */
+typedef void *hashtab_datum_t;		/* generic datum type */
 
 typedef struct hashtab_node *hashtab_ptr_t;
 
diff -Naur libsepol-1.5.9.orig/include/sepol/mls_types.h libsepol-1.5.9.new/include/sepol/mls_types.h
--- libsepol-1.5.9.orig/include/sepol/mls_types.h	2005-06-16 12:35:07.000000000 -0400
+++ libsepol-1.5.9.new/include/sepol/mls_types.h	2005-06-17 21:34:21.000000000 -0400
@@ -19,7 +19,6 @@
 
 #include <stdint.h>
 #include <sepol/ebitmap.h>
-#include <sepol/sepol.h>
 #include <sepol/flask_types.h>
 
 typedef struct mls_level {
diff -Naur libsepol-1.5.9.orig/include/sepol/policydb.h libsepol-1.5.9.new/include/sepol/policydb.h
--- libsepol-1.5.9.orig/include/sepol/policydb.h	2005-06-16 12:35:06.000000000 -0400
+++ libsepol-1.5.9.new/include/sepol/policydb.h	2005-06-17 21:08:35.000000000 -0400
@@ -289,6 +289,10 @@
 
 extern int policydb_write(struct policydb *p, struct policy_file *pf);
 
+extern int policydb_from_image(void* data, size_t len, policydb_t* policydb);
+
+extern int policydb_to_image(policydb_t* policydb, void **newdata, size_t *newlen);
+
 #define PERM_SYMTAB_SIZE 32
 
 /* Identify specific policy version changes */
diff -Naur libsepol-1.5.9.orig/include/sepol/sepol.h libsepol-1.5.9.new/include/sepol/sepol.h
--- libsepol-1.5.9.orig/include/sepol/sepol.h	2005-06-16 12:35:07.000000000 -0400
+++ libsepol-1.5.9.new/include/sepol/sepol.h	2005-06-18 01:27:55.000000000 -0400
@@ -3,6 +3,16 @@
 
 #include <sys/types.h>
 #include <stdio.h>
+#include <stdarg.h>
+
+/* Draw in extra headers that should be visible from outside */
+
+#include <sepol/policydb.h>
+#include <sepol/booleans.h>
+#include <sepol/users_policy.h>
+#include <sepol/users_file.h>
+
+/*==== Backwards Compatibility definitions ==== */
 
 /* Given an existing binary policy (starting at 'data', with length 'len')
    and a boolean configuration file named by 'boolpath', rewrite the binary
@@ -16,20 +26,32 @@
    with 'nel' elements, rewrite the binary policy for the boolean settings.  
    The binary policy is rewritten in place in memory.
    Returns 0 upon success or -1 otherwise. */
-extern int sepol_genbools_array(void *data, size_t len, char **names, int *values, int nel);
+extern int sepol_genbools_array(
+	void *data, size_t len, 
+	char **names, int *values, int nel);
 
 /* Given an existing binary policy (starting at 'data with length 'len')
    and user configurations living in 'usersdir', generate a new binary
    policy for the new user configurations.  Sets '*newdata' and '*newlen'
    to refer to the new binary policy image. */
-extern int sepol_genusers(void *data, size_t len,
-			  const char *usersdir,
-			  void **newdata, size_t *newlen);
+extern int sepol_genusers(
+	void *data, size_t len, const char *usersdir,
+	void **newdata, size_t *newlen);
+
+static inline int sepol_genbools_policydb(
+	policydb_t* policydb, char *boolpath) {
+
+	return sepol_load_booleans(policydb, boolpath);
+}
 
 /* Enable or disable deletion of users by sepol_genusers(3) when
    a user in original binary policy image is not defined by the
    new user configurations.  Defaults to disabled. */
-extern void sepol_set_delusers(int on);
+static inline void sepol_set_delusers(int on) {
+	sepol_policy_set_delusers(on);
+}
+
+/* ==== End backwards compatibility ==== */
 
 /* Set internal policydb from a file for subsequent service calls. */
 extern int sepol_set_policydb_from_file(FILE *fp);
@@ -39,4 +61,5 @@
 
 /* Turn on or off sepol error messages. */
 extern void sepol_debug(int on);
+
 #endif
diff -Naur libsepol-1.5.9.orig/include/sepol/services.h libsepol-1.5.9.new/include/sepol/services.h
--- libsepol-1.5.9.orig/include/sepol/services.h	2005-06-16 12:35:08.000000000 -0400
+++ libsepol-1.5.9.new/include/sepol/services.h	2005-06-18 00:50:28.000000000 -0400
@@ -25,13 +25,6 @@
 extern int sepol_set_policydb(policydb_t *p);
 extern int sepol_set_sidtab(sidtab_t *s);
 
-/* Modify a policydb for boolean settings. */
-int sepol_genbools_policydb(policydb_t *policydb, const char *booleans);
-
-/* Modify a policydb for user settings. */
-int sepol_genusers_policydb(policydb_t *policydb,
-			    const char *usersdir);
-
 /* Load the security policy. This initializes the policydb
    and sidtab based on the provided binary policy. */
 int sepol_load_policy(void * data, size_t len);
diff -Naur libsepol-1.5.9.orig/include/sepol/user_config.h libsepol-1.5.9.new/include/sepol/user_config.h
--- libsepol-1.5.9.orig/include/sepol/user_config.h	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/include/sepol/user_config.h	2005-06-16 12:36:21.000000000 -0400
@@ -0,0 +1,90 @@
+#ifndef __SEPOL_USER_CONFIG_H
+#define __SEPOL_USER_CONFIG_H 
+
+#include <string.h>
+
+typedef struct user_config* user_config_t;
+
+struct role {
+	char* role;
+	struct role* next;
+};
+
+struct user_config {
+	/* This user's name */
+	char* name;
+
+	/* This user's mls level (only required for mls) */
+	char* mls_level;
+
+	/* This user's mls range (only required for mls) */
+	char* mls_range;
+
+	/* The number of roles */
+	int num_roles;
+
+	/* The default role */
+	struct role* def_role;
+
+	/* All roles (num_roles of them) */
+	struct role* roles;
+
+	/* Focus role (for iterator) */
+	struct role* next_role;
+};
+
+/* Name */
+static inline const char* uc_get_name(user_config_t user) {
+	return user->name;
+}
+
+static inline int uc_set_name(user_config_t user, const char* name) {
+	user->name = strdup(name);
+	return (user->name)? 0:-1;
+}
+
+/* MLS */
+static inline const char* uc_get_mls_level(user_config_t user) {
+	return user->mls_level;
+}
+
+static inline int uc_set_mls_level(user_config_t user, const char* mls_level) {
+	user->mls_level = strdup(mls_level);
+	return (user->mls_level)? 0:-1;
+}
+
+static inline const char* uc_get_mls_range(user_config_t user) {
+	return user->mls_range;
+}
+
+static inline int uc_set_mls_range(user_config_t user, const char* mls_range) {
+	user->mls_range = strdup(mls_range);
+	return (user->mls_range)? 0:-1;
+}
+
+/* Roles */
+static inline int uc_get_num_roles(user_config_t user) {
+	return user->num_roles;
+}
+
+static inline const char* uc_get_def_role(user_config_t user) {
+	return (user->def_role == NULL)? NULL : user->def_role->role;
+}
+
+extern int uc_add_role(user_config_t user, const char* role);
+extern int uc_del_role(user_config_t user, const char* role);
+extern int uc_has_role(user_config_t user, const char* role);
+extern int uc_set_def_role(user_config_t user, const char* role);
+extern int uc_reset_roles(user_config_t user);
+
+/* Iterator */
+static inline void uc_iter_init(user_config_t user) {
+	user->next_role = user->roles;
+}
+extern const char* uc_next_role(user_config_t user);
+
+/* Create/Destroy */
+extern user_config_t uc_create();
+extern void uc_destroy(user_config_t user);
+
+#endif
diff -Naur libsepol-1.5.9.orig/include/sepol/users_file.h libsepol-1.5.9.new/include/sepol/users_file.h
--- libsepol-1.5.9.orig/include/sepol/users_file.h	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/include/sepol/users_file.h	2005-06-17 22:15:39.000000000 -0400
@@ -0,0 +1,74 @@
+#ifndef _SEPOL_USERS_FILE_H
+#define _SEPOL_USERS_FILE_H
+
+#include <sepol/user_config.h>
+#include <sepol/policydb.h>
+#include <limits.h>
+
+/* Execute handler on all users iteratively, and terminate
+ * on negative return */
+int sepol_file_iterate_users(const char* users_file,
+	int (*handler) (user_config_t user, void* arg), void* arg);
+
+/* Executes handler on the matching username, and then rewrites the
+ * config file, with the updated user structure (the handler should
+ * change it). Also loads the user into policy. */
+int sepol_file_mod_user(
+	policydb_t* policydb,
+	const char* users_file,
+	const char* username,
+	int (*handler) (user_config_t user, void* arg),
+	void* arg);
+
+/* Loads users listed in the files into the policy */
+int sepol_file_load_users(policydb_t* policydb, const char* usersdir);
+
+/* Add/delete users from the users file and policy */
+extern int sepol_file_add_user(policydb_t* policydb,
+	const char *usersdir, user_config_t user);
+
+extern int user_del(user_config_t user, void* arg);
+static inline int sepol_file_del_user(policydb_t* policydb,
+	const char* usersdir, const char* username) {
+
+	char path[PATH_MAX];
+	snprintf(path, sizeof path, "%s/local.users", usersdir);
+	return sepol_file_mod_user(policydb, path, username, &user_del, NULL);
+}
+
+/* Role manipulation */
+extern int user_set_roles(user_config_t user, void* roles_arg);
+static inline int sepol_file_set_roles(
+	policydb_t* policydb, const char* usersdir,
+	const char* username, const char** roles) {
+
+	char path[PATH_MAX];
+	snprintf(path, sizeof path, "%s/local.users", usersdir);
+	return sepol_file_mod_user(policydb, path, username,
+		&user_set_roles, (void*) roles);
+}
+
+extern int user_add_role(user_config_t user, void* role_arg);
+static inline int sepol_file_add_role(
+	policydb_t* policydb, const char* usersdir,
+	const char* username, const char* role) {
+
+	char path[PATH_MAX];
+	snprintf(path, sizeof path, "%s/local.users", usersdir);
+	return sepol_file_mod_user(policydb, path, username,
+		&user_add_role, (void*) role);
+}
+
+extern int user_del_role(user_config_t user, void* role_arg);
+static inline int sepol_file_del_role(
+	policydb_t* policydb, const char* usersdir,
+	const char* username, const char* role) {
+	
+	char path[PATH_MAX];
+	snprintf(path, sizeof path, "%s/local.users", usersdir);
+	return sepol_file_mod_user(policydb, path, username,
+		&user_del_role, (void*) role);
+}
+
+
+#endif
diff -Naur libsepol-1.5.9.orig/include/sepol/users_policy.h libsepol-1.5.9.new/include/sepol/users_policy.h
--- libsepol-1.5.9.orig/include/sepol/users_policy.h	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/include/sepol/users_policy.h	2005-06-18 00:47:32.000000000 -0400
@@ -0,0 +1,18 @@
+#ifndef __SEPOL_USERS_INTERNAL_H
+#define __SEPOL_USERS_INTERNAL_H
+
+#include <sepol/policydb.h>
+#include <sepol/user_config.h>
+
+/* Del users */
+extern void sepol_policy_set_delusers(int on);
+
+/* Clear unused users (before reloading policy */
+void sepol_policy_clear_unused(policydb_t* policydb);
+
+/* Add/delete/load users from the policy */
+extern int sepol_policy_add_user(policydb_t* policydb, user_config_t user);
+extern int sepol_policy_del_user(policydb_t* policydb, const char* username);
+extern int sepol_policy_load_user(user_config_t user, void* policydb);
+
+#endif
diff -Naur libsepol-1.5.9.orig/src/booleans.c libsepol-1.5.9.new/src/booleans.c
--- libsepol-1.5.9.orig/src/booleans.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/src/booleans.c	2005-06-18 00:04:54.000000000 -0400
@@ -0,0 +1,172 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <ctype.h>
+#include <errno.h>
+
+#include <sepol/hashtab.h>
+#include <sepol/policydb.h>
+#include <sepol/conditional.h>
+
+#include "private.h"
+
+static char *strtrim(char *dest, char *source, int size) {
+	int i=0;
+	char *ptr=source;
+	i=0;
+	while(isspace(*ptr) && i < size) {
+		ptr++;
+		i++;
+	}
+	strncpy(dest,ptr,size);
+	for(i=strlen(dest)-1; i> 0; i--) {
+		if (!isspace(dest[i])) break;
+	}
+	dest[i+1]='\0';
+	return dest;
+}
+
+static int process_boolean(char *buffer, char *name, int namesize, int *val) {
+	char name1[BUFSIZ];
+	char *ptr;
+	char *tok=strtok_r(buffer,"=",&ptr);
+	if (tok) {
+		strncpy(name1,tok, BUFSIZ-1);
+		strtrim(name,name1,namesize-1);
+		if ( name[0]=='#' ) return 0;
+		tok=strtok_r(NULL,"\0",&ptr);
+		if (tok) {
+			while (isspace(*tok)) tok++;
+			*val = -1;
+			if (isdigit(tok[0]))
+				*val=atoi(tok);
+			else if (!strncasecmp(tok, "true", sizeof("true")-1))
+				*val = 1;
+			else if (!strncasecmp(tok, "false", sizeof("false")-1))
+				*val = 0;
+			if (*val != 0 && *val != 1) {
+				fprintf(stderr,"illegal value for boolean "
+					"%s=%s\n", name, tok);
+				return -1;
+			}
+			
+		}
+	}
+	return 1;
+}
+
+static int load_booleans(struct policydb *policydb, const char *path) {
+	FILE *boolf;
+	char *buffer=NULL;
+	size_t size=0;
+	char localbools[BUFSIZ];
+	char name[BUFSIZ];
+	int val;
+	int errors=0;
+	struct cond_bool_datum *datum;
+
+	boolf = fopen(path,"r");
+	if (boolf == NULL) 
+		goto localbool;
+
+	while (getline(&buffer, &size, boolf) > 0) {
+		int ret=process_boolean(buffer, name, sizeof(name), &val);
+		if (ret==-1) 
+			errors++;
+		if (ret==1) {
+			datum = hashtab_search(policydb->p_bools.table, name);
+			if (!datum) {
+				fprintf(stderr,"unknown boolean %s\n", name);
+				errors++;
+				continue;
+			}
+			datum->state = val;
+		}
+	}
+	fclose(boolf);
+localbool:
+	snprintf(localbools,sizeof(localbools), "%s.local", path);
+	boolf = fopen(localbools,"r");
+	if (boolf != NULL) {
+		while (getline(&buffer, &size, boolf) > 0) {
+			int ret = process_boolean(buffer, name, 
+				sizeof(name), &val);
+			if (ret == -1) 
+				errors++;
+			if (ret == 1) {
+				datum = hashtab_search(
+					policydb->p_bools.table, name);
+				if (!datum) {
+					fprintf(stderr,
+						"unknown boolean %s\n", name);
+					errors++;
+					continue;
+				}
+				datum->state = val;
+			}
+		}
+		fclose(boolf);
+	}
+	free(buffer);
+	if (errors)
+		errno = EINVAL;
+
+	return errors ? SEPOL_ERR : SEPOL_SUCCESS;
+}
+
+int sepol_load_booleans(policydb_t* policydb, const char *boolpath) {
+
+	if (load_booleans(policydb, boolpath) < 0)
+		__sepol_debug_printf("%s:  Warning! Error while reading %s\n",
+			__FUNCTION__, boolpath);
+
+	if (evaluate_conds(policydb) < 0) {
+		__sepol_debug_printf("%s:  Error while re-evaluating "
+                        "conditionals\n", __FUNCTION__);
+		errno = EINVAL;
+		return SEPOL_ERR;
+        }
+
+	return SEPOL_SUCCESS;
+}
+
+
+int sepol_load_booleans_array(
+	policydb_t* policydb, char **names, 
+	int *values, int nel) {
+		
+	int i, errors = 0;
+	struct cond_bool_datum *datum;
+
+	for (i = 0; i < nel; i++) {
+		datum = hashtab_search(policydb->p_bools.table, names[i]);
+		if (!datum) {
+			__sepol_debug_printf("%s:  unknown boolean %s\n",
+				__FUNCTION__, names[i]);
+			errors++;
+			continue;
+		}
+		if (values[i] != 0 && values[i] != 1) {
+			__sepol_debug_printf("%s: illegal value %d "
+			"for boolean %s\n", __FUNCTION__,values[i], names[i]);
+			errors++;
+			continue;
+		}
+		datum->state = values[i];
+	}
+
+	if (evaluate_conds(policydb) < 0) {
+		__sepol_debug_printf("%s:  Error while re-evaluating "
+			"conditionals\n", __FUNCTION__);
+		errno = EINVAL;
+		goto err;
+	}
+
+	if (errors) {
+		errno = EINVAL;
+		goto err;
+	}
+
+	return SEPOL_SUCCESS;
+	err:
+	return SEPOL_ERR;
+}
diff -Naur libsepol-1.5.9.orig/src/compatibility.c libsepol-1.5.9.new/src/compatibility.c
--- libsepol-1.5.9.orig/src/compatibility.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/src/compatibility.c	2005-06-18 00:46:00.000000000 -0400
@@ -0,0 +1,87 @@
+#include <stdlib.h>
+#include <string.h>
+#include <sepol/policydb.h>
+#include <sepol/users_file.h>
+#include <sepol/booleans.h>
+
+#include "private.h"
+
+/* Compatibility */
+int sepol_genusers(void *data, size_t len,
+                   const char *usersdir,
+                   void **new_data, size_t *new_len) {
+
+	struct policydb policydb;
+
+	if (policydb_from_image(data, len, &policydb) < 0)
+		return SEPOL_ERR;
+
+	if (sepol_file_load_users(&policydb, usersdir) < 0)
+		goto err;
+
+        if (policydb_to_image(&policydb, new_data, new_len) < 0) 
+		goto err;
+
+	policydb_destroy(&policydb);
+        return SEPOL_SUCCESS;
+
+	err:
+	policydb_destroy(&policydb);
+	return SEPOL_ERR;
+}
+
+int sepol_genbools(void *data, size_t len, char *booleans) {
+
+	struct policydb policydb;
+	void* new_data;
+	size_t new_len;
+
+	if (policydb_from_image(data, len, &policydb) < 0)
+		return SEPOL_ERR;
+
+	if (sepol_load_booleans(&policydb, booleans) < 0)
+		goto err;
+
+	if (policydb_to_image(&policydb, &new_data, &new_len) < 0)
+		goto err;
+
+	memcpy(data, new_data, len);
+
+	free(new_data);
+	policydb_destroy(&policydb);
+	return SEPOL_SUCCESS;
+
+        err:
+	free(new_data);
+        policydb_destroy(&policydb);
+        return SEPOL_ERR;
+}
+
+int sepol_genbools_array(
+		void *data, size_t len, 
+		char **names, int *values, int nel)
+{
+	struct policydb policydb;
+	void* new_data;
+	size_t new_len;
+
+	if (policydb_from_image(data, len, &policydb) < 0)
+		return SEPOL_ERR;
+
+	if (sepol_load_booleans_array(&policydb, names, values, nel) < 0)
+		goto err;
+
+	if (policydb_to_image(&policydb, &new_data, &new_len) < 0)
+		goto err;
+	
+	memcpy(data, new_data, len);		
+
+	free(new_data);
+	policydb_destroy(&policydb);
+	return SEPOL_SUCCESS;
+
+	err:
+	free(new_data);
+	policydb_destroy(&policydb);
+	return SEPOL_ERR;
+}
diff -Naur libsepol-1.5.9.orig/src/debug.c libsepol-1.5.9.new/src/debug.c
--- libsepol-1.5.9.orig/src/debug.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/src/debug.c	2005-06-17 14:18:41.000000000 -0400
@@ -0,0 +1,18 @@
+#include <stdarg.h>
+#include <stdio.h>
+
+static int gdebug = 1;
+
+void sepol_debug(int on) {
+	gdebug = on;
+}
+
+__attribute__ ((format (printf, 1, 2))) 
+void __sepol_debug_printf(const char *fmt, ...) {
+	if (gdebug) {
+		va_list ap;
+		va_start(ap, fmt);
+		vfprintf (stderr, fmt, ap);
+		va_end(ap);
+	}
+}
diff -Naur libsepol-1.5.9.orig/src/genbools.c libsepol-1.5.9.new/src/genbools.c
--- libsepol-1.5.9.orig/src/genbools.c	2005-06-16 12:35:12.000000000 -0400
+++ libsepol-1.5.9.new/src/genbools.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,238 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <ctype.h>
-#include <errno.h>
-
-#include <sepol/policydb.h>
-#include <sepol/conditional.h>
-
-#include "private.h"
-
-static char *strtrim(char *dest, char *source, int size) {
-	int i=0;
-	char *ptr=source;
-	i=0;
-	while(isspace(*ptr) && i < size) {
-		ptr++;
-		i++;
-	}
-	strncpy(dest,ptr,size);
-	for(i=strlen(dest)-1; i> 0; i--) {
-		if (!isspace(dest[i])) break;
-	}
-	dest[i+1]='\0';
-	return dest;
-}
-
-static int process_boolean(char *buffer, char *name, int namesize, int *val) {
-	char name1[BUFSIZ];
-	char *ptr;
-	char *tok=strtok_r(buffer,"=",&ptr);
-	if (tok) {
-		strncpy(name1,tok, BUFSIZ-1);
-		strtrim(name,name1,namesize-1);
-		if ( name[0]=='#' ) return 0;
-		tok=strtok_r(NULL,"\0",&ptr);
-		if (tok) {
-			while (isspace(*tok)) tok++;
-			*val = -1;
-			if (isdigit(tok[0]))
-				*val=atoi(tok);
-			else if (!strncasecmp(tok, "true", sizeof("true")-1))
-				*val = 1;
-			else if (!strncasecmp(tok, "false", sizeof("false")-1))
-				*val = 0;
-			if (*val != 0 && *val != 1) {
-				fprintf(stderr,"illegal value for boolean %s=%s\n", name, tok);
-				return -1;
-			}
-			
-		}
-	}
-	return 1;
-}
-
-static int load_booleans(struct policydb *policydb, const char *path) {
-	FILE *boolf;
-	char *buffer=NULL;
-	size_t size=0;
-	char localbools[BUFSIZ];
-	char name[BUFSIZ];
-	int val;
-	int errors=0;
-	struct cond_bool_datum *datum;
-
-	boolf = fopen(path,"r");
-	if (boolf == NULL) 
-		goto localbool;
-
-	while (getline(&buffer, &size, boolf) > 0) {
-		int ret=process_boolean(buffer, name, sizeof(name), &val);
-		if (ret==-1) 
-			errors++;
-		if (ret==1) {
-			datum = hashtab_search(policydb->p_bools.table, name);
-			if (!datum) {
-				fprintf(stderr,"unknown boolean %s\n", name);
-				errors++;
-				continue;
-			}
-			datum->state = val;
-		}
-	}
-	fclose(boolf);
-localbool:
-	snprintf(localbools,sizeof(localbools), "%s.local", path);
-	boolf = fopen(localbools,"r");
-	if (boolf != NULL) {
-		while (getline(&buffer, &size, boolf) > 0) {
-			int ret=process_boolean(buffer, name, sizeof(name), &val);
-			if (ret==-1) 
-				errors++;
-			if (ret==1) {
-				datum = hashtab_search(policydb->p_bools.table, name);
-				if (!datum) {
-					fprintf(stderr,"unknown boolean %s\n", name);
-					errors++;
-					continue;
-				}
-				datum->state = val;
-			}
-		}
-		fclose(boolf);
-	}
-	free(buffer);
-	if (errors)
-		errno = EINVAL;
-
-	return errors ? -1 : 0;
-}
-
-int sepol_genbools(void *data, size_t len, char *booleans)
-{
-	struct policydb policydb;
-	struct policy_file pf;
-	int rc;
-
-	pf.type = PF_USE_MEMORY;
-	pf.data = data;
-	pf.len = len;
-	if (policydb_read(&policydb,&pf, 0)) {
-		__sepol_debug_printf("%s:  binary policy image is invalid\n",
-			__FUNCTION__);
-		errno = EINVAL;
-		return -1;
-	}
-
-	/* Preserve the policy version of the original policy
-	   for the new policy. */
-	sepol_set_policyvers(policydb.policyvers);
-
-	if (load_booleans(&policydb, booleans) < 0) {
-		__sepol_debug_printf("%s:  Warning!  Error while reading %s\n",
-				     __FUNCTION__, booleans);
-	}
-
-	if (evaluate_conds(&policydb) < 0) {
-		__sepol_debug_printf("%s:  Error while re-evaluating conditionals\n",
-				     __FUNCTION__);
-		errno = EINVAL;
-		goto err;
-	}
-
-	pf.data = data;
-	pf.len = len;
-	rc = policydb_write(&policydb, &pf);
-	if (rc) {
-		__sepol_debug_printf("%s: Can't write new binary policy image\n",
-				     __FUNCTION__);
-		errno = EINVAL;
-		goto err;
-	}
-
-	policydb_destroy(&policydb);
-	return 0;
-
- err:
-	policydb_destroy(&policydb);
-	return -1;
-}
-
-int sepol_genbools_policydb(policydb_t *policydb, const char *booleans)
-{
-	int rc;
-
-	rc = load_booleans(policydb, booleans);
-	if (!rc)
-		rc = evaluate_conds(policydb);
-	if (rc)
-		errno = EINVAL;
-	return rc;
-}
-
-int sepol_genbools_array(void *data, size_t len, char **names, int *values, int nel)
-{
-	struct policydb policydb;
-	struct policy_file pf;
-	int rc, i, errors = 0;
-	struct cond_bool_datum *datum;
-
-	pf.type = PF_USE_MEMORY;
-	pf.data = data;
-	pf.len = len;
-	if (policydb_read(&policydb,&pf, 0)) {
-		__sepol_debug_printf("%s:  binary policy image is invalid\n",
-				     __FUNCTION__);
-		errno = EINVAL;
-		return -1;
-	}
-
-	/* Preserve the policy version of the original policy
-	   for the new policy. */
-	sepol_set_policyvers(policydb.policyvers);
-
-	for (i = 0; i < nel; i++) {
-		datum = hashtab_search(policydb.p_bools.table, names[i]);
-		if (!datum) {
-			__sepol_debug_printf("%s:  unknown boolean %s\n", 
-					     __FUNCTION__, names[i]);
-			errors++;
-			continue;
-		}
-		if (values[i] != 0 && values[i] != 1) {
-			fprintf(stderr,"illegal value %d for boolean %s\n", values[i], names[i]);
-			errors++;
-			continue;
-		}
-		datum->state = values[i];
-	}
-
-	if (evaluate_conds(&policydb) < 0) {
-		__sepol_debug_printf("%s:  Error while re-evaluating conditionals\n",
-				     __FUNCTION__);
-		errno = EINVAL;
-		goto err;
-	}
-
-	pf.data = data;
-	pf.len = len;
-	rc = policydb_write(&policydb, &pf);
-	if (rc) {
-		__sepol_debug_printf("%s:  Can't write binary policy\n",
-				     __FUNCTION__);
-		errno = EINVAL;
-		goto err;
-	}
-	if (errors) {
-		errno = EINVAL;
-		goto err;
-	}
-
-	policydb_destroy(&policydb);
-	return 0;
-err:
-	policydb_destroy(&policydb);
-	return -1;
-}
-
-
diff -Naur libsepol-1.5.9.orig/src/genbools.c.~1.8.~ libsepol-1.5.9.new/src/genbools.c.~1.8.~
--- libsepol-1.5.9.orig/src/genbools.c.~1.8.~	2005-06-16 12:35:12.000000000 -0400
+++ libsepol-1.5.9.new/src/genbools.c.~1.8.~	1969-12-31 19:00:00.000000000 -0500
@@ -1,177 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <ctype.h>
-#include <errno.h>
-
-#include <sepol/policydb.h>
-#include <sepol/conditional.h>
-
-#include "private.h"
-
-static char *strtrim(char *dest, char *source, int size) {
-	int i=0;
-	char *ptr=source;
-	i=0;
-	while(isspace(*ptr) && i < size) {
-		ptr++;
-		i++;
-	}
-	strncpy(dest,ptr,size);
-	for(i=strlen(dest)-1; i> 0; i--) {
-		if (!isspace(dest[i])) break;
-	}
-	dest[i+1]='\0';
-	return dest;
-}
-
-static int load_booleans(struct policydb *policydb, char *path) {
-	FILE *boolf;
-	char buffer[BUFSIZ];
-	char name[BUFSIZ];
-	char name1[BUFSIZ];
-	int val;
-	int errors=0;
-	struct cond_bool_datum *datum;
-
-	boolf = fopen(path,"r");
-	if (boolf == NULL) 
-		return -1;
-
-        while (fgets(buffer, sizeof(buffer), boolf)) {
-		char *tok=strtok(buffer,"=");
-		if (tok) {
-			strncpy(name1,tok, BUFSIZ-1);
-			strtrim(name,name1,BUFSIZ-1);
-			if ( name[0]=='#' ) continue;
-			tok=strtok(NULL,"\0");
-			if (tok) {
-				while (isspace(*tok)) tok++;
-				val = -1;
-				if (isdigit(tok[0]))
-					val=atoi(tok);
-				else if (!strncasecmp(tok, "true", sizeof("true")-1))
-					val = 1;
-				else if (!strncasecmp(tok, "false", sizeof("false")-1))
-					val = 0;
-				if (val != 0 && val != 1) {
-					fprintf(stderr,"illegal value for boolean %s=%s\n", name, tok);
-					errors++;
-					continue;
-				}
-
-				datum = hashtab_search(policydb->p_bools.table, name);
-				if (!datum) {
-					fprintf(stderr,"unknown boolean %s\n", name);
-					errors++;
-					continue;
-				}
-				datum->state = val;
-			}
-		}
-	}
-	fclose(boolf);
-
-	if (errors)
-		errno = EINVAL;
-
-	return errors ? -1 : 0;
-}
-
-int sepol_genbools(void *data, size_t len, char *booleans)
-{
-	struct policydb policydb;
-	struct policy_file pf;
-	int rc;
-
-	pf.type = PF_USE_MEMORY;
-	pf.data = data;
-	pf.len = len;
-	if (policydb_read(&policydb,&pf, 0)) {
-		fprintf(stderr, "Can't read binary policy:  %s\n",
-			strerror(errno));
-		return -1;
-	}
-
-	/* Preserve the policy version of the original policy
-	   for the new policy. */
-	sepol_set_policyvers(policydb.policyvers);
-
-	if (load_booleans(&policydb, booleans) < 0) {
-		fprintf(stderr, "Warning!  Error while reading %s:  %s\n",
-			booleans, strerror(errno));
-	}
-
-	if (evaluate_conds(&policydb) < 0) {
-		fprintf(stderr, "Error while re-evaluating conditionals: %s\n",
-			strerror(errno));
-		return -1;
-	}
-
-	pf.data = data;
-	pf.len = len;
-	rc = policydb_write(&policydb, &pf);
-	if (rc) {
-		fprintf(stderr, "Can't write binary policy:  %s\n",
-			strerror(errno));
-		return -1;
-	}
-	return 0;
-}
-
-int sepol_genbools_array(void *data, size_t len, char **names, int *values, int nel)
-{
-	struct policydb policydb;
-	struct policy_file pf;
-	int rc, i, errors = 0;
-	struct cond_bool_datum *datum;
-
-	pf.type = PF_USE_MEMORY;
-	pf.data = data;
-	pf.len = len;
-	if (policydb_read(&policydb,&pf, 0)) {
-		fprintf(stderr, "Can't read binary policy:  %s\n",
-			strerror(errno));
-		return -1;
-	}
-
-	/* Preserve the policy version of the original policy
-	   for the new policy. */
-	sepol_set_policyvers(policydb.policyvers);
-
-	for (i = 0; i < nel; i++) {
-		datum = hashtab_search(policydb.p_bools.table, names[i]);
-		if (!datum) {
-			fprintf(stderr,"unknown boolean %s\n", names[i]);
-			errors++;
-			continue;
-		}
-		if (values[i] != 0 && values[i] != 1) {
-			fprintf(stderr,"illegal value %d for boolean %s\n", values[i], names[i]);
-			errors++;
-			continue;
-		}
-		datum->state = values[i];
-	}
-
-	if (evaluate_conds(&policydb) < 0) {
-		fprintf(stderr, "Error while re-evaluating conditionals: %s\n",
-			strerror(errno));
-		return -1;
-	}
-
-	pf.data = data;
-	pf.len = len;
-	rc = policydb_write(&policydb, &pf);
-	if (rc) {
-		fprintf(stderr, "Can't write binary policy:  %s\n",
-			strerror(errno));
-		return -1;
-	}
-	if (errors) {
-		errno = EINVAL;
-		return -1;
-	}
-	return 0;
-}
-
-
diff -Naur libsepol-1.5.9.orig/src/genusers.c libsepol-1.5.9.new/src/genusers.c
--- libsepol-1.5.9.orig/src/genusers.c	2005-06-16 12:35:11.000000000 -0400
+++ libsepol-1.5.9.new/src/genusers.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,477 +0,0 @@
-#include <stdio.h>
-#include <stdio_ext.h>
-#include <stdlib.h>
-#include <ctype.h>
-#include <errno.h>
-#include <limits.h>
-
-#include <sepol/policydb.h>
-#include <sepol/mls.h>
-#include <stdarg.h>
-
-#include "private.h"
-
-static int gdebug=1;
-
-void sepol_debug(int on) { gdebug=on; };
-
-void __sepol_debug_printf(const char *fmt, ...) {
-	if (gdebug) {
-		va_list ap;
-		va_start(ap, fmt);
-		vfprintf (stderr, fmt, ap);
-		va_end(ap);
-	}
-}
-
-static int delusers = 0;
-
-void sepol_set_delusers(int on)
-{
-	delusers = on;
-}
-
-#undef BADLINE
-#define BADLINE() { \
-	__sepol_debug_printf("%s:  invalid entry %s on line %u\n", \
-		path, buffer, lineno); \
-	continue; \
-}
-
-static int load_users(struct policydb *policydb, const char *path) {
-	FILE *fp;
-	char *buffer = NULL, *p, *q, oldc;
-	size_t len = 0;
-	int rc;
-	unsigned lineno = 0, islist = 0, bit;
-	user_datum_t *usrdatum;
-	role_datum_t *roldatum;
-
-	fp = fopen(path,"r");
-	if (fp == NULL) 
-		return -1;
-	__fsetlocking(fp, FSETLOCKING_BYCALLER);
-
-        while (getline(&buffer, &len, fp) > 0) {
-		lineno++;
-		if (buffer[len - 1] == '\n')
-			buffer[len - 1] = 0;
-		p = buffer;
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p) || *p == '#')
-			continue;
-
-		if (strncasecmp(p, "user", 4))
-			BADLINE();
-		p += 4;
-		if (!isspace(*p))
-			BADLINE();
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p))
-			BADLINE();
-		q = p;
-		while (*p && !isspace(*p)) 
-			p++;
-		if (!(*p)) 
-			BADLINE();
-		*p++ = 0;
-
-		usrdatum = hashtab_search(policydb->p_users.table, q);
-		if (usrdatum) {
-			/* Replacing an existing user definition. */
-			ebitmap_init(&usrdatum->roles);
-			usrdatum->defined = 1;
-		} else {
-			char *id = strdup(q);
-			
-			/* Adding a new user definition. */
-			usrdatum = (user_datum_t *) malloc(sizeof(user_datum_t));
-			if (!id || !usrdatum) {
-				__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
-					path, buffer, lineno);
-				errno = ENOMEM;
-				free(buffer);
-				fclose(fp);
-				return -1;
-			}
-			memset(usrdatum, 0, sizeof(user_datum_t));
-			usrdatum->value = ++policydb->p_users.nprim;
-			ebitmap_init(&usrdatum->roles);
-			usrdatum->defined = 1;
-			rc = hashtab_insert(policydb->p_users.table,
-					    id, (hashtab_datum_t) usrdatum);
-			if (rc) {
-				__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
-					path, buffer, lineno);
-				errno = ENOMEM;
-				free(buffer);
-				fclose(fp);
-				return -1;
-			}
-		}
-
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p))
-			BADLINE();
-		if (strncasecmp(p, "roles", 5))
-			BADLINE();
-		p += 5;
-		if (!isspace(*p))
-			BADLINE();
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p))
-			BADLINE();
-		if (*p == '{') {
-			islist = 1;
-			p++;
-		} else 
-			islist = 0;
-
-		do { 
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-
-			q = p;
-			while (*p && *p != ';' && *p != '}' && !isspace(*p)) 
-				p++;
-			if (!(*p)) 
-				BADLINE();
-			if (*p == '}') 
-				islist = 0;
-			oldc = *p;
-			*p++ = 0;
-			if (!q[0])
-				break;
-
-			roldatum = hashtab_search(policydb->p_roles.table, q);
-			if (!roldatum) {
-				__sepol_debug_printf("%s:  undefined role %s in %s on line %u\n",
-					path, q, buffer, lineno);
-				continue;
-			}
-			/* Set the role and every role it dominates */
-			for (bit = ebitmap_startbit(&roldatum->dominates); bit < ebitmap_length(&roldatum->dominates); bit++) {
-				if (ebitmap_get_bit(&roldatum->dominates, bit))
-					if (ebitmap_set_bit(&usrdatum->roles, bit, 1)) {
-						__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
-							path, buffer, lineno);
-						errno = ENOMEM;
-						free(buffer);
-						fclose(fp);
-						return -1;
-					}
-			}
-		} while (islist);
-
-		if (mls_enabled) {
-			context_struct_t context;
-			char *scontext, *r, *s;
-
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-			if (strncasecmp(p, "level", 5))
-				BADLINE();
-			p += 5;
-			if (!isspace(*p))
-				BADLINE();
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-			q = p;
-			while (*p && strncasecmp(p, "range", 5))
-				p++;
-			if (!(*p)) 
-				BADLINE();
-			*--p = 0;
-			p++;
-
-			scontext = malloc(p - q);
-			if (!scontext) {
-				__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
-					path, buffer, lineno);
-				errno = ENOMEM;
-				free(buffer);
-				fclose(fp);
-				return -1;
-			}
-			r = scontext;
-			s = q;
-			while (*s) {
-				if (!isspace(*s))
-					*r++ = *s;
-				s++;
-			}
-			*r = 0;
-			r = scontext;
-
-			context_init(&context);
-			rc = mls_context_to_sid(policydb, oldc, &r, &context);
-			if (rc) {
-				__sepol_debug_printf("%s:  invalid level %s in %s on line %u\n",
-					path, scontext, buffer, lineno);
-				free(scontext);
-				continue;
-
-			}
-			free(scontext);
-			memcpy(&usrdatum->dfltlevel, &context.range.level[0], sizeof(usrdatum->dfltlevel));
-
-			if (strncasecmp(p, "range", 5))
-				BADLINE();
-			p += 5;
-			if (!isspace(*p))
-				BADLINE();
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-			q = p;
-			while (*p && *p != ';')
-				p++;
-			if (!(*p)) 
-				BADLINE();
-			*p++ = 0;
-
-			scontext = malloc(p - q);
-			if (!scontext) {
-				__sepol_debug_printf("%s:  out of memory for %s on line %u\n",
-					path, buffer, lineno);
-				errno = ENOMEM;
-				free(buffer);
-				fclose(fp);
-				return -1;
-			}
-			r = scontext;
-			s = q;
-			while (*s) {
-				if (!isspace(*s))
-					*r++ = *s;
-				s++;
-			}
-			*r = 0;
-			r = scontext;
-
-			context_init(&context);
-			rc = mls_context_to_sid(policydb, oldc, &r, &context);
-			if (rc) {
-				__sepol_debug_printf("%s:  invalid range %s in %s on line %u\n",
-					path, scontext, buffer, lineno);
-				free(scontext);
-				continue;
-			}
-			free(scontext);
-			memcpy(&usrdatum->range, &context.range, sizeof(usrdatum->range));
-		}
-	}
-
-	free(buffer);
-	fclose(fp);
-	return 0;
-}
-
-/* Select users for removal based on whether they were defined in the
-   new users configuration. */
-static int select_user(hashtab_key_t key, hashtab_datum_t datum, void *datap)
-{
-	user_datum_t *usrdatum = datum;
-	
-	if (!usrdatum->defined)
-		return 1;
-	return 0;
-}
-
-struct kill_user_data {
-	struct policydb *policydb;
-	ebitmap_t *free_users;
-};
-
-/* Kill the user entries selected by select_user, and
-   record that their slots are free. */
-static void kill_user(hashtab_key_t key, hashtab_datum_t datum, void *p)
-{
-	user_datum_t *usrdatum;
-	struct kill_user_data *kud = p;
-	struct policydb *pol = kud->policydb;
-	ebitmap_t *free_users = kud->free_users;
-
-	if (key)
-		free(key);
-
-	usrdatum = (user_datum_t *) datum;
-	ebitmap_set_bit(free_users, usrdatum->value - 1, 1);
-
-	ebitmap_destroy(&usrdatum->roles);
-	free(datum);
-	pol->p_users.nprim--;
-}
-
-/* Fold user values down to avoid holes generated by removal.
-   As the SID table is remapped by the kernel upon a policy reload,
-   this is safe for existing SIDs.  But it could be a problem for
-   constraints if they refer to the particular user.  */
-static int remap_users(hashtab_key_t key, hashtab_datum_t datum, void *p)
-{
-	user_datum_t *usrdatum = datum;
-	struct kill_user_data *kud = p;
-	struct policydb *pol = kud->policydb;
-	ebitmap_t *free_users = kud->free_users;
-	int i;
-
-	if (usrdatum->value > pol->p_users.nprim) {
-		for (i = ebitmap_startbit(free_users); i < ebitmap_length(free_users); i++) {
-			if (ebitmap_get_bit(free_users, i)) {
-				usrdatum->value = i+1;
-				ebitmap_set_bit(free_users, i, 0);
-				return 0;
-			}
-		}
-	}
-	return 0;
-}
-
-int sepol_genusers(void *data, size_t len,
-		   const char *usersdir,
-		   void **newdata, size_t *newlen)
-{
-	struct policydb policydb;
-	struct policy_file pf;
-	struct ebitmap free_users;
-	struct kill_user_data kud;
-	char path[PATH_MAX];
-	int rc;
-
-	/* Parse the original binary policy image into a struct policydb. */
-	pf.type = PF_USE_MEMORY;
-	pf.data = data;
-	pf.len = len;
-	if (policydb_read(&policydb,&pf, 0)) {
-		__sepol_debug_printf("%s:  binary policy image is invalid\n",
-				     __FUNCTION__);
-		errno = EINVAL;
-		return -1;
-	}
-
-	/* Load base set of system users from the policy package. */
-	snprintf(path, sizeof path, "%s/system.users", usersdir);
-	if (load_users(&policydb, path) < 0) {
-		__sepol_debug_printf("%s: Can't load system.users:  %s\n",
-				     __FUNCTION__, strerror(errno));
-		goto err;
-	}
-
-	/* Load locally defined users. */
-	snprintf(path, sizeof path, "%s/local.users", usersdir);
-	if (load_users(&policydb, path) < 0) {
-		__sepol_debug_printf("%s:  Can't load local.users:  %s\n",
-				     __FUNCTION__, strerror(errno));
-		goto err;
-	}
-
-	if (delusers) {
-		/* Kill unused users and remap to avoid holes. */
-		ebitmap_init(&free_users);
-		kud.policydb = &policydb;
-		kud.free_users = &free_users;
-		hashtab_map_remove_on_error(policydb.p_users.table, select_user, kill_user, &kud);
-		hashtab_map(policydb.p_users.table, remap_users, &kud);
-		ebitmap_destroy(&free_users);
-	}
-
-	/* Set the policy version for the new binary policy image we are
-	   about to generate so that it stays the same as the original,
-	   even if we support a newer one. */
-	sepol_set_policyvers(policydb.policyvers);
-
-	/* Compute the length for the new binary policy image. */
-	pf.type = PF_LEN;
-	pf.data = NULL;
-	pf.len = 0;
-	rc = policydb_write(&policydb, &pf);
-	if (rc) {
-		__sepol_debug_printf("%s: Can't compute length of binary policy\n",
-				     __FUNCTION__);
-		errno = EINVAL;
-		goto err;
-	}
-
-	/* Allocate the new binary policy image. */
-	pf.type = PF_USE_MEMORY;	
-	pf.data = malloc(pf.len);
-	if (!pf.data) {
-		__sepol_debug_printf("%s:  out of memory\n", __FUNCTION__);
-		goto err;
-	}
-
-	/* Need to save len and data prior to modification by policydb_write. */
-	*newlen = pf.len;
-	*newdata = pf.data;
-
-	/* Write out the new binary policy image. */
-	rc = policydb_write(&policydb, &pf);
-	if (rc) {
-		__sepol_debug_printf("%s:  Can't write binary policy\n",
-				     __FUNCTION__);
-		free(pf.data);
-		errno = EINVAL;
-		goto err;
-	}
-	policydb_destroy(&policydb);
-
-	/* Verify the new binary policy image. */
-	pf.type = PF_USE_MEMORY;
-	pf.data = *newdata;
-	pf.len = *newlen;
-	if (policydb_read(&policydb,&pf, 0)) {
-		__sepol_debug_printf("%s:  new binary policy image is invalid\n",
-				     __FUNCTION__);
-		errno = EINVAL;
-		return -1;
-	}
-
-	policydb_destroy(&policydb);
-	return 0;
-
-err:
-	policydb_destroy(&policydb);
-	return -1;
-}
-
-int sepol_genusers_policydb(policydb_t *policydb,
-			    const char *usersdir)
-{
-	char path[PATH_MAX];
-
-	/* Load base set of system users from the policy package. */
-	snprintf(path, sizeof path, "%s/system.users", usersdir);
-	if (load_users(policydb, path) < 0) {
-		__sepol_debug_printf("%s: Can't load system.users:  %s\n",
-				     __FUNCTION__, strerror(errno));
-		return -1;
-	}
-
-	/* Load locally defined users. */
-	snprintf(path, sizeof path, "%s/local.users", usersdir);
-	if (load_users(policydb, path) < 0) {
-		__sepol_debug_printf("%s:  Can't load local.users:  %s\n",
-				     __FUNCTION__, strerror(errno));
-		return -1;
-	}
-
-	if (policydb_reindex_users(policydb) < 0) {
-		__sepol_debug_printf("%s:  Can't reindex users:  %s\n",
-				     __FUNCTION__, strerror(errno));
-		return -1;
-
-	}
-
-	return 0;
-}
diff -Naur libsepol-1.5.9.orig/src/genusers.c.~1.2.~ libsepol-1.5.9.new/src/genusers.c.~1.2.~
--- libsepol-1.5.9.orig/src/genusers.c.~1.2.~	2005-06-16 12:35:12.000000000 -0400
+++ libsepol-1.5.9.new/src/genusers.c.~1.2.~	1969-12-31 19:00:00.000000000 -0500
@@ -1,404 +0,0 @@
-#include <stdio.h>
-#include <stdio_ext.h>
-#include <stdlib.h>
-#include <ctype.h>
-#include <errno.h>
-#include <limits.h>
-
-#include <sepol/policydb.h>
-#include <sepol/mls.h>
-
-#include "private.h"
-
-#undef BADLINE
-#define BADLINE() { \
-	fprintf(stderr, "%s:  invalid entry %s on line %u\n", \
-		path, buffer, lineno); \
-	continue; \
-}
-
-static int load_users(struct policydb *policydb, const char *path) {
-	FILE *fp;
-	char *buffer = NULL, *p, *q, oldc;
-	size_t len = 0;
-	int rc;
-	unsigned lineno = 0, islist = 0, bit;
-	user_datum_t *usrdatum;
-	role_datum_t *roldatum;
-
-	fp = fopen(path,"r");
-	if (fp == NULL) 
-		return -1;
-	__fsetlocking(fp, FSETLOCKING_BYCALLER);
-
-        while (getline(&buffer, &len, fp) > 0) {
-		lineno++;
-		if (buffer[len - 1] == '\n')
-			buffer[len - 1] = 0;
-		p = buffer;
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p) || *p == '#')
-			continue;
-
-		if (strncasecmp(p, "user", 4))
-			BADLINE();
-		p += 4;
-		if (!isspace(*p))
-			BADLINE();
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p))
-			BADLINE();
-		q = p;
-		while (*p && !isspace(*p)) 
-			p++;
-		if (!(*p)) 
-			BADLINE();
-		*p++ = 0;
-
-		usrdatum = hashtab_search(policydb->p_users.table, q);
-		if (usrdatum) {
-			/* Replacing an existing user definition. */
-			ebitmap_init(&usrdatum->roles);
-			usrdatum->defined = 1;
-		} else {
-			char *id = strdup(q);
-			
-			/* Adding a new user definition. */
-			usrdatum = (user_datum_t *) malloc(sizeof(user_datum_t));
-			if (!id || !usrdatum) {
-				fprintf(stderr, "%s:  out of memory for %s on line %u\n",
-					path, buffer, lineno);
-				errno = ENOMEM;
-				free(buffer);
-				return -1;
-			}
-			memset(usrdatum, 0, sizeof(user_datum_t));
-			usrdatum->value = ++policydb->p_users.nprim;
-			ebitmap_init(&usrdatum->roles);
-			usrdatum->defined = 1;
-			rc = hashtab_insert(policydb->p_users.table,
-					    id, (hashtab_datum_t) usrdatum);
-			if (rc) {
-				fprintf(stderr, "%s:  out of memory for %s on line %u\n",
-					path, buffer, lineno);
-				errno = ENOMEM;
-				free(buffer);
-				return -1;
-			}
-		}
-
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p))
-			BADLINE();
-		if (strncasecmp(p, "roles", 5))
-			BADLINE();
-		p += 5;
-		if (!isspace(*p))
-			BADLINE();
-		while (*p && isspace(*p))
-			p++;
-		if (!(*p))
-			BADLINE();
-		if (*p == '{') {
-			islist = 1;
-			p++;
-		} else 
-			islist = 0;
-
-		do { 
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-
-			q = p;
-			while (*p && *p != ';' && *p != '}' && !isspace(*p)) 
-				p++;
-			if (!(*p)) 
-				BADLINE();
-			if (*p == '}') 
-				islist = 0;
-			oldc = *p;
-			*p++ = 0;
-			if (!q[0])
-				break;
-
-			roldatum = hashtab_search(policydb->p_roles.table, q);
-			if (!roldatum) {
-				fprintf(stderr, "%s:  undefined role %s in %s on line %u\n",
-					path, q, buffer, lineno);
-				continue;
-			}
-			/* Set the role and every role it dominates */
-			for (bit = ebitmap_startbit(&roldatum->dominates); bit < ebitmap_length(&roldatum->dominates); bit++) {
-				if (ebitmap_get_bit(&roldatum->dominates, bit))
-					if (ebitmap_set_bit(&usrdatum->roles, bit, 1)) {
-						fprintf(stderr, "%s:  out of memory for %s on line %u\n",
-							path, buffer, lineno);
-						errno = ENOMEM;
-						free(buffer);
-						return -1;
-					}
-			}
-		} while (islist);
-
-		if (mls_enabled) {
-			context_struct_t context;
-			char *scontext, *r, *s;
-
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-			if (strncasecmp(p, "level", 5))
-				BADLINE();
-			p += 5;
-			if (!isspace(*p))
-				BADLINE();
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-			q = p;
-			while (*p && strncasecmp(p, "range", 5))
-				p++;
-			if (!(*p)) 
-				BADLINE();
-			*--p = 0;
-			p++;
-
-			scontext = malloc(p - q);
-			if (!scontext) {
-				fprintf(stderr, "%s:  out of memory for %s on line %u\n",
-					path, buffer, lineno);
-				errno = ENOMEM;
-				free(buffer);
-				return -1;
-			}
-			r = scontext;
-			s = q;
-			while (*s) {
-				if (!isspace(*s))
-					*r++ = *s;
-				s++;
-			}
-			*r = 0;
-			r = scontext;
-
-			context_init(&context);
-			rc = mls_context_to_sid(policydb, oldc, &r, &context);
-			if (rc) {
-				fprintf(stderr, "%s:  invalid level %s in %s on line %u\n",
-					path, scontext, buffer, lineno);
-				free(scontext);
-				continue;
-
-			}
-			free(scontext);
-			memcpy(&usrdatum->dfltlevel, &context.range.level[0], sizeof(usrdatum->dfltlevel));
-
-			if (strncasecmp(p, "range", 5))
-				BADLINE();
-			p += 5;
-			if (!isspace(*p))
-				BADLINE();
-			while (*p && isspace(*p))
-				p++;
-			if (!(*p))
-				BADLINE();
-			q = p;
-			while (*p && *p != ';')
-				p++;
-			if (!(*p)) 
-				BADLINE();
-			*p++ = 0;
-
-			scontext = malloc(p - q);
-			if (!scontext) {
-				fprintf(stderr, "%s:  out of memory for %s on line %u\n",
-					path, buffer, lineno);
-				errno = ENOMEM;
-				free(buffer);
-				return -1;
-			}
-			r = scontext;
-			s = q;
-			while (*s) {
-				if (!isspace(*s))
-					*r++ = *s;
-				s++;
-			}
-			*r = 0;
-			r = scontext;
-
-			context_init(&context);
-			rc = mls_context_to_sid(policydb, oldc, &r, &context);
-			if (rc) {
-				fprintf(stderr, "%s:  invalid range %s in %s on line %u\n",
-					path, scontext, buffer, lineno);
-				free(scontext);
-				continue;
-			}
-			free(scontext);
-			memcpy(&usrdatum->range, &context.range, sizeof(usrdatum->range));
-		}
-	}
-
-	free(buffer);
-
-	return 0;
-}
-
-/* Select users for removal based on whether they were defined in the
-   new users configuration. */
-static int select_user(hashtab_key_t key, hashtab_datum_t datum, void *datap)
-{
-	char *name = key;
-	user_datum_t *usrdatum = datum;
-	
-	if (!usrdatum->defined) {
-		/* XXX Hack:  Don't accidentally remove SELinux-only users. */
-		if (!strcmp(name, "system_u") || !strcmp(name, "user_u")) {
-			return 0;
-		}
-		return 1;
-	}
-	return 0;
-}
-
-struct kill_user_data {
-	struct policydb *policydb;
-	ebitmap_t *free_users;
-};
-
-/* Kill the user entries selected by select_user, and
-   record that their slots are free. */
-static void kill_user(hashtab_key_t key, hashtab_datum_t datum, void *p)
-{
-	user_datum_t *usrdatum;
-	struct kill_user_data *kud = p;
-	struct policydb *pol = kud->policydb;
-	ebitmap_t *free_users = kud->free_users;
-
-	if (key)
-		free(key);
-
-	usrdatum = (user_datum_t *) datum;
-	ebitmap_set_bit(free_users, usrdatum->value - 1, 1);
-
-	ebitmap_destroy(&usrdatum->roles);
-	free(datum);
-	pol->p_users.nprim--;
-}
-
-/* Fold user values down to avoid holes generated by removal.
-   As the SID table is remapped by the kernel upon a policy reload,
-   this is safe for existing SIDs.  But it could be a problem for
-   constraints if they refer to the particular user.  */
-static int remap_users(hashtab_key_t key, hashtab_datum_t datum, void *p)
-{
-	user_datum_t *usrdatum = datum;
-	struct kill_user_data *kud = p;
-	struct policydb *pol = kud->policydb;
-	ebitmap_t *free_users = kud->free_users;
-	int i;
-
-	if (usrdatum->value > pol->p_users.nprim) {
-		for (i = ebitmap_startbit(free_users); i < ebitmap_length(free_users); i++) {
-			if (ebitmap_get_bit(free_users, i)) {
-				usrdatum->value = i+1;
-				ebitmap_set_bit(free_users, i, 0);
-				return 0;
-			}
-		}
-	}
-	return 0;
-}
-
-int sepol_genusers(void *data, size_t len,
-		   const char *usersdir,
-		   void **newdata, size_t *newlen)
-{
-	struct policydb policydb;
-	struct policy_file pf;
-	struct ebitmap free_users;
-	struct kill_user_data kud;
-	char path[PATH_MAX];
-	int rc;
-
-	/* Parse the original binary policy image into a struct policydb. */
-	pf.type = PF_USE_MEMORY;
-	pf.data = data;
-	pf.len = len;
-	if (policydb_read(&policydb,&pf, 0)) {
-		fprintf(stderr, "%s:  Can't read binary policy:  %s\n",
-			__FUNCTION__, strerror(errno));
-		return -1;
-	}
-
-	/* Load base set of system users from the policy package. */
-	snprintf(path, sizeof path, "%s/system.users", usersdir);
-	if (load_users(&policydb, path) < 0) {
-		fprintf(stderr, "%s: Can't load system.users:  %s\n",
-			__FUNCTION__, strerror(errno));
-		return -1;
-	}
-
-	/* Load locally defined users. */
-	snprintf(path, sizeof path, "%s/local.users", usersdir);
-	if (load_users(&policydb, path) < 0) {
-		fprintf(stderr, "%s:  Can't load local.users:  %s\n",
-			__FUNCTION__, strerror(errno));
-		return -1;
-	}
-
-        /* Kill unused users and remap to avoid holes. */
-	ebitmap_init(&free_users);
-	kud.policydb = &policydb;
-	kud.free_users = &free_users;
-	hashtab_map_remove_on_error(policydb.p_users.table, select_user, kill_user, &kud);
-	hashtab_map(policydb.p_users.table, remap_users, &kud);
-	ebitmap_destroy(&free_users);
-
-	/* Set the policy version for the new binary policy image we are
-	   about to generate so that it stays the same as the original,
-	   even if we support a newer one. */
-	sepol_set_policyvers(policydb.policyvers);
-
-	/* Compute the length for the new binary policy image. */
-	pf.type = PF_LEN;
-	pf.data = NULL;
-	pf.len = 0;
-	rc = policydb_write(&policydb, &pf);
-	if (rc) {
-		fprintf(stderr, "Can't compute length of binary policy:  %s\n",
-			strerror(errno));
-		return -1;
-	}
-
-	/* Allocate the new binary policy image. */
-	pf.type = PF_USE_MEMORY;	
-	pf.data = malloc(pf.len);
-	if (!pf.data) {
-		fprintf(stderr, "%s:  %s\n", __FUNCTION__, strerror(errno));
-		return -1;
-	}
-
-	/* Need to save len and data prior to modification by policydb_write. */
-	*newlen = pf.len;
-	*newdata = pf.data;
-
-	/* Write out the new binary policy image. */
-	rc = policydb_write(&policydb, &pf);
-	if (rc) {
-		fprintf(stderr, "Can't write binary policy:  %s\n",
-			strerror(errno));
-		free(pf.data);
-		return -1;
-	}
-	policydb_destroy(&policydb);
-	return 0;
-}
diff -Naur libsepol-1.5.9.orig/src/libsepol.map libsepol-1.5.9.new/src/libsepol.map
--- libsepol-1.5.9.orig/src/libsepol.map	2005-06-16 12:35:12.000000000 -0400
+++ libsepol-1.5.9.new/src/libsepol.map	2005-06-18 01:19:39.000000000 -0400
@@ -1,4 +1,4 @@
 {
-  global: sepol_genbools*; sepol_set_policydb_from_file; sepol_check_context; sepol_genusers; sepol_debug; sepol_set_delusers;
+  global: sepol_genbools*; sepol_set_policydb_from_file; sepol_check_context; sepol_genusers; sepol_debug; sepol_set_delusers; uc_*; user_*; sepol_file_*; sepol_policy_*; policydb_*_image; policydb_destroy; sepol_load_booleans*;  
   local: *;
 };
diff -Naur libsepol-1.5.9.orig/src/Makefile libsepol-1.5.9.new/src/Makefile
--- libsepol-1.5.9.orig/src/Makefile	2005-06-16 12:35:13.000000000 -0400
+++ libsepol-1.5.9.new/src/Makefile	2005-06-16 12:36:43.000000000 -0400
@@ -10,7 +10,7 @@
 LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
 LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
-CFLAGS = -Wall
+CFLAGS = -Wall -g 
 override CFLAGS += -I. -I../include -D_GNU_SOURCE
 
 all: $(LIBA) $(LIBSO)
diff -Naur libsepol-1.5.9.orig/src/policydb.c libsepol-1.5.9.new/src/policydb.c
--- libsepol-1.5.9.orig/src/policydb.c	2005-06-16 12:35:14.000000000 -0400
+++ libsepol-1.5.9.new/src/policydb.c	2005-06-17 18:18:47.000000000 -0400
@@ -1756,6 +1756,3 @@
 
 	return 0;
 }
-
-
-
diff -Naur libsepol-1.5.9.orig/src/policydb_convert.c libsepol-1.5.9.new/src/policydb_convert.c
--- libsepol-1.5.9.orig/src/policydb_convert.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/src/policydb_convert.c	2005-06-18 01:36:09.000000000 -0400
@@ -0,0 +1,98 @@
+#include <stdlib.h>
+#include <sepol/policydb.h>
+
+#include "private.h"
+
+/* Construct a policydb from the supplied (data, len) pair */
+
+int policydb_from_image(void* data, size_t len, policydb_t* policydb) {
+
+        struct policy_file pf;
+
+        pf.type = PF_USE_MEMORY;
+        pf.data = data;
+        pf.len = len;
+
+        if (policydb_read(policydb, &pf, 0)) {
+                __sepol_debug_printf("%s: binary policy image is invalid\n",
+                        __FUNCTION__);
+
+                errno = EINVAL;
+                return SEPOL_ERR;
+        }
+
+        return SEPOL_SUCCESS;
+}
+
+/* Write a policydb to a memory region, and return the (data, len) pair. */
+
+int policydb_to_image(
+	policydb_t* policydb, void **newdata, size_t *newlen) {
+
+	void *tmp_data = NULL;
+	size_t tmp_len;
+	struct policy_file pf;
+	struct policydb tmp_policydb;
+
+	/* Set the policy version for the new binary policy image we are
+	   about to generate so that it stays the same as the original,
+	   even if we support a newer one. */
+	sepol_set_policyvers(policydb->policyvers);
+
+	/* Compute the length for the new binary policy image. */
+	pf.type = PF_LEN;
+	pf.data = NULL;
+	pf.len = 0;
+	if (policydb_write(policydb, &pf)) {
+		__sepol_debug_printf("%s: Can't compute length of binary "
+			"policy\n", __FUNCTION__);
+		errno = EINVAL;	
+		goto err;
+	}
+
+	/* Allocate the new binary policy image. */
+	pf.type = PF_USE_MEMORY;
+	pf.data = malloc(pf.len);
+	if (!pf.data) {
+		__sepol_debug_printf("%s:  out of memory\n", __FUNCTION__);
+		goto err;
+        }
+
+	/* Need to save len and data prior to modification by policydb_write.*/
+	tmp_len = pf.len;
+	tmp_data = pf.data;
+
+	/* Write out the new binary policy image. */
+	if (policydb_write(policydb, &pf)) {
+		__sepol_debug_printf("%s:  Can't write binary policy\n",
+			__FUNCTION__);
+		errno = EINVAL;
+		goto err;
+        }
+
+	/* Verify the new binary policy image. */
+	pf.type = PF_USE_MEMORY;
+	pf.data = tmp_data;
+        pf.len = tmp_len;
+        if (policydb_read(&tmp_policydb, &pf, 0)) {
+		__sepol_debug_printf("%s:  new binary policy image is "
+			"invalid\n", __FUNCTION__);
+                errno = EINVAL;
+		goto err;
+        }
+	policydb_destroy(&tmp_policydb);
+
+	/* Update (newdata, newlen) */
+	*newdata = tmp_data;
+	*newlen = tmp_len;
+
+	/* Recover */
+	sepol_set_policyvers(POLICYDB_VERSION_MAX);
+        return SEPOL_SUCCESS;
+
+err:
+	/* Recover */
+	sepol_set_policyvers(POLICYDB_VERSION_MAX);
+	free(tmp_data);
+        return SEPOL_ERR;
+}
diff -Naur libsepol-1.5.9.orig/src/private.h libsepol-1.5.9.new/src/private.h
--- libsepol-1.5.9.orig/src/private.h	2005-06-16 12:35:12.000000000 -0400
+++ libsepol-1.5.9.new/src/private.h	2005-06-17 22:28:39.000000000 -0400
@@ -4,6 +4,12 @@
 
 #include <byteswap.h>
 #include <endian.h>
+#include <sepol/policydb.h>
+
+#define SEPOL_SUCCESS 0
+#define SEPOL_ERR -1
+#define SEPOL_HANDLER_ERR -2
+#define SEPOL_HANDLER_SIGDEL 1
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define cpu_to_le32(x) (x)
@@ -25,7 +31,9 @@
 };
 
 extern struct policydb_compat_info *policydb_lookup_compat(int version);
-extern void __sepol_debug_printf(const char *fmt, ...);
+
+__attribute__ ((format (printf, 1, 2))) 
+void __sepol_debug_printf(const char *fmt, ...);
 
 /* Reading from a policy "file". */
 static inline void *next_entry(struct policy_file * fp, size_t bytes)
diff -Naur libsepol-1.5.9.orig/src/user_config.c libsepol-1.5.9.new/src/user_config.c
--- libsepol-1.5.9.orig/src/user_config.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/src/user_config.c	2005-06-17 22:27:15.000000000 -0400
@@ -0,0 +1,148 @@
+#include <errno.h>
+#include <stdlib.h>
+#include <sepol/user_config.h>
+
+#include "private.h"
+
+/* Most functions are inlined in user_config.h */
+
+int uc_add_role(user_config_t user, const char* role) {
+        struct role* r = (struct role*) malloc(sizeof(struct role));
+	if (!r) {
+		errno = ENOMEM;
+		return SEPOL_ERR;
+	}
+
+	r->role = strdup(role);
+	if (!role) return SEPOL_ERR;
+		
+
+        r->next = user->roles;
+        user->roles = r;
+        if (!user->def_role)
+                user->def_role = r;
+        user->num_roles++;
+
+        return SEPOL_SUCCESS;
+}
+
+const char* uc_next_role(user_config_t user) {
+	struct role* r = user->next_role;
+	if (r == NULL)
+		return NULL;
+	else {
+		user->next_role = r->next;
+		return r->role;
+	}
+}
+
+int uc_has_role(user_config_t user, const char* role) {
+	struct role* ptr;
+	
+	for (ptr = user->roles; ptr != NULL; ptr = ptr->next)
+		if (!strcmp(ptr->role, role)) 
+			return 1;
+	return 0;
+}
+
+int uc_del_role(user_config_t user, const char* role) {
+	struct role *ptr, *prev = NULL;
+
+	for (ptr = user->roles; ptr != NULL; ptr=ptr -> next) {
+		if (!strcmp(ptr->role, role)) {
+
+			if (user->num_roles == 1) 
+				return SEPOL_ERR;
+
+			if (prev)
+				prev->next = ptr->next;
+			else 
+				user->roles = ptr->next;
+			
+			if (user->def_role == ptr) 
+				user->def_role = user->roles;
+
+			prev = ptr;
+			free(ptr->role);
+			free(ptr);
+			return SEPOL_SUCCESS;
+		} 
+		else 
+			prev = ptr;
+	}
+
+	return SEPOL_SUCCESS;
+}
+
+int uc_reset_roles(user_config_t user) {
+	struct role *ptr, *prev = NULL;
+	for (ptr = user->roles; ptr != NULL; ptr = ptr->next) {
+		if (prev != NULL) {
+			free(prev->role);
+			free(prev);
+		}
+		prev = ptr;
+	}
+	if (prev != NULL) {
+		free(prev->role);
+		free(prev);
+	}
+
+	user->roles = NULL;
+	user->def_role = NULL;
+
+	return SEPOL_SUCCESS;
+}
+
+int uc_set_def_role(user_config_t user, const char* role) {
+	struct role* ptr;
+	int status;
+
+	for (ptr = user->roles; ptr != NULL; ptr=ptr->next)
+		if (!strcmp(ptr->role, role)) {
+			user->def_role = ptr;
+			return SEPOL_SUCCESS;
+		}
+
+	status = uc_add_role(user, role);
+	user->def_role = user->roles;
+	return status;
+}
+
+user_config_t uc_create() {
+        struct user_config* user = 
+		(struct user_config*) malloc(sizeof(struct user_config));
+
+        if (!user) {
+		errno = ENOMEM;
+		return NULL;
+	}
+
+        user->roles = NULL;
+        user->def_role = NULL;
+        user->num_roles = 0;
+        user->name = NULL;
+	user->mls_level = NULL;
+	user->mls_range = NULL;
+
+        return user;
+}
+
+void uc_destroy(user_config_t user) {
+	struct role* ptr;
+	
+	free(user->name);
+
+	while (user->roles) {
+		ptr = user->roles;
+		user->roles = user->roles->next;
+		free(ptr->role);
+		free(ptr);
+        }
+	if (user->mls_level)
+		free(user->mls_level);
+	if (user->mls_range)
+		free(user->mls_range);
+
+	free(user);
+}
diff -Naur libsepol-1.5.9.orig/src/user_config_handlers.c libsepol-1.5.9.new/src/user_config_handlers.c
--- libsepol-1.5.9.orig/src/user_config_handlers.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/src/user_config_handlers.c	2005-06-17 22:29:34.000000000 -0400
@@ -0,0 +1,42 @@
+#include <sepol/user_config.h>
+
+#include "private.h"
+
+/* Config handlers are passed to
+ * iterator functions so that they can
+ * manipulate user configuration. 
+ * They can't be inlined 
+ */
+
+int user_del(user_config_t user, void* arg) {
+	return SEPOL_HANDLER_SIGDEL;
+}
+
+int user_add_role(user_config_t user, void* role_arg) {
+	char* role = (char*) role_arg;
+	return uc_has_role(user, role)? 0: uc_add_role(user,role);
+}
+
+int user_del_role(user_config_t user, void* role_arg) {
+	char* role = (char*) role_arg;
+	return uc_del_role(user, role);
+}
+
+int user_set_roles(user_config_t user, void* roles_arg) {
+	const char** roles = (const char**) roles_arg;
+	const char** ptr = roles;
+	int status = uc_reset_roles(user);
+
+	if (status < 0)
+		return status;
+
+	while(ptr) {
+		status = uc_add_role(user, *ptr);
+		if (status < 0)
+			return SEPOL_ERR;
+		ptr++;
+	}
+
+	return SEPOL_SUCCESS;
+}
+
diff -Naur libsepol-1.5.9.orig/src/users_file.c libsepol-1.5.9.new/src/users_file.c
--- libsepol-1.5.9.orig/src/users_file.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/src/users_file.c	2005-06-18 00:54:50.000000000 -0400
@@ -0,0 +1,505 @@
+#include <stdio.h>
+#include <stdio_ext.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <limits.h>
+#include <ctype.h>
+
+#include <sepol/policydb.h>
+#include <sepol/user_config.h>
+#include <sepol/users_file.h>
+#include <sepol/users_policy.h>
+
+#include "private.h"
+
+/*
+ * Print user record to the given stream 
+ */
+static void print_user(user_config_t user, FILE* str) {
+	const char *mls_level, *mls_range, *role, *def_role;
+
+
+	/* Interpret NULL name as deletion signal */
+	if (uc_get_name(user) == NULL) 
+		return;
+
+	fprintf(str, "user %s roles { ", uc_get_name(user));
+
+	/* Default role is first */
+	def_role = uc_get_def_role(user);
+		fprintf(str, "%s ", def_role);
+
+	/* Then we print the rest of them */
+        uc_iter_init(user);
+        while((role = uc_next_role(user)))
+		if (strcmp(role, def_role))
+			fprintf(str, "%s ", role);
+
+        fprintf(str, "}");
+	
+	/* MLS */
+	mls_level = uc_get_mls_level(user);
+	mls_range = uc_get_mls_range(user);
+
+	if (mls_level != NULL && mls_range != NULL) 
+		fprintf(str, "level %s range %s", mls_level, mls_range);
+
+	fprintf(str, ";\n");
+}
+
+/*
+ * Parse a configuration line in the users file,
+ * and construct a user_config_t structure from it
+ */
+
+static int parse_user_line(char* ptr, user_config_t user) {
+	int islist = 0;
+	char* start;
+
+	/* Parse user name */
+	if (strncasecmp(ptr, "user", 4))
+		return SEPOL_ERR;
+	ptr += 4;
+	if (!isspace(*ptr))
+		return SEPOL_ERR;
+	while (*ptr && isspace(*ptr))
+		ptr++;
+	if (!(*ptr))
+		return SEPOL_ERR;
+
+	start = ptr;
+
+	while (*ptr && !isspace(*ptr))
+		ptr++;
+	if (!(*ptr))
+		return SEPOL_ERR;
+	*ptr++ = '\0';
+
+	if (uc_set_name(user, start) < 0)
+		return SEPOL_ERR;
+
+	/* Parse roles header */ 
+	while (*ptr && isspace(*ptr))
+		ptr++;
+	if (!(*ptr))
+		return SEPOL_ERR;
+
+	if (strncasecmp(ptr, "roles", 5))
+		return SEPOL_ERR;
+	ptr += 5;
+	
+	if (!isspace(*ptr))
+		return SEPOL_ERR;
+	while (*ptr && isspace(*ptr))
+		ptr++;
+	if (!(*ptr))
+		return SEPOL_ERR;
+	if (*ptr == '{') {
+		islist = 1;
+		ptr++;
+	} else
+		islist = 0;
+
+	/* For each role, loop */
+	do { 
+		while (*ptr && isspace(*ptr))
+			ptr++;
+		if (!(*ptr))
+			return SEPOL_ERR;
+		start = ptr;
+
+		while (*ptr && *ptr != ';' && *ptr != '}' && !isspace(*ptr)) 
+			ptr++;
+
+		if (!(*ptr))
+			return SEPOL_ERR;
+
+		*ptr++ = '\0';
+
+		while (*ptr && isspace(*ptr))
+			ptr++;
+
+		if (*ptr == '}') 
+			islist = 0;
+
+		if (uc_add_role(user, start) < 0)
+			return SEPOL_ERR;
+
+	} while (islist);
+
+
+	/* Handle mls */
+	if (mls_enabled) {
+		char* ptr2;
+
+		/* Parse level header */
+		while (*ptr && isspace(*ptr))
+			ptr++;
+		if (!(*ptr))
+			return SEPOL_ERR;
+		if (*ptr == ';')
+			return SEPOL_SUCCESS;		
+
+		if (strncasecmp(ptr, "level", 5))
+			return SEPOL_ERR;
+		ptr += 5;
+		if (!isspace(*ptr))
+			return SEPOL_ERR;
+		while (*ptr && isspace(*ptr))
+			ptr++;
+		if (!(*ptr))
+			return SEPOL_ERR;
+
+		/* Parse level, spaces are allowed */
+		start = ptr;
+		ptr2 = ptr;
+		while (*ptr2 && strncasecmp(ptr2, "range", 5)) {
+			if (!isspace(ptr2))
+				*ptr++ = *ptr2;
+			ptr2++;
+		}
+		if (!(*ptr2))
+			return SEPOL_ERR;
+		*ptr++ = '\0';
+		ptr = ptr2;
+
+		if (uc_set_mls_level(user, start) < 0)
+			return SEPOL_ERR;
+
+		/* Parse range header */
+		if (strncasecmp(ptr, "range", 5))
+			return SEPOL_ERR;
+		ptr += 5;
+		if (!isspace(*ptr))
+			return SEPOL_ERR;
+		while (*ptr && isspace(*ptr))
+			ptr++;
+		if (!(*ptr))
+			return SEPOL_ERR;
+
+		/* Parse range, spaces are allowed */
+		start = ptr;
+		ptr2 = ptr;
+		while (*ptr2 && *ptr2 != ';') {
+			if (!isspace(ptr2))
+				*ptr++ = *ptr2;
+			ptr2++;
+		}
+		if (!(*ptr2))
+			return SEPOL_ERR;
+		*ptr++ = '\0';
+		ptr = ptr2;
+		if (uc_set_mls_range(user, start) < 0)
+			return SEPOL_ERR;
+	}
+
+	return SEPOL_SUCCESS;
+}
+
+/*
+ * Iterate over all user records in the given file,
+ * and invoke the handler with its given argument on each user.
+ * The handler is supplied a user_config_t structure containing 
+ * the parsed data.
+ */
+
+int sepol_file_iterate_users(
+	const char* users_file, 
+	int (*handler) (user_config_t user, void* arg), 
+	void* arg) 
+{ 
+	FILE *fp = NULL;
+	char *buffer = NULL, *ptr = NULL;
+	unsigned int lineno = 0;
+	size_t len = 0;
+
+	/* Open the users file */
+	fp = fopen(users_file,"r");
+	if (fp == NULL) {
+		__sepol_debug_printf("%s: unable to open %s for reading\n", 
+			__FUNCTION__, users_file);
+		return SEPOL_ERR;
+	}
+	__fsetlocking(fp, FSETLOCKING_BYCALLER);
+
+	/* Iterate over each line of the file */
+	while (getline(&buffer, &len, fp) >= 0) {
+		lineno++;
+
+		/* Empty line */
+		if (len == 0) 
+			goto next;
+
+		/* Eat newline, preceding whitespace */
+		if ((buffer[len - 1] == '\n'))
+			buffer[len - 1] = '\0';
+		ptr = buffer;
+		while (*ptr && isspace(*ptr))
+			ptr++;
+
+		/* Process users */
+		if (*ptr && *ptr != '#') { 
+
+			user_config_t user = NULL;
+			int status = 0;
+
+			/* Create a user config structure */
+			user = uc_create();
+			if (!user) {
+				__sepol_debug_printf("%s: out of memory while "
+				"iterating %s\n", __FUNCTION__, users_file);
+
+				errno = ENOMEM;
+				goto err;
+			}
+
+			/* Parse user data into that structure */
+			if( parse_user_line(ptr, user) < 0 ) {
+				__sepol_debug_printf("%s: malformed line "
+					"%u in %s\n", __FUNCTION__, lineno, 
+					users_file);
+
+				errno = EIO;
+				uc_destroy(user);
+				goto err;
+			}
+
+			/* Invoke handler with the user config struct 
+			   Please note that the user config struct data 
+			   is only valid while buffer is not written over */
+			status = handler(user, arg); 
+
+			uc_destroy(user);
+
+			/* If the handler returned a negative number, 
+			 * stop iterating */
+			if (status < 0) 
+				goto handler_exit;
+		}
+	
+		next:
+			free(buffer);
+			buffer = NULL;
+	}
+
+	fclose(fp);
+	return SEPOL_SUCCESS;
+
+err:
+	free(buffer);
+	fclose(fp);
+	return SEPOL_ERR;
+
+handler_exit:
+	free(buffer);
+	fclose(fp);
+	return SEPOL_HANDLER_ERR;
+}
+
+/*
+ * Copy users_file to users_file.tmp, updating data for a particular user.
+ * Invoke the handler, which may update the user data. 
+ * Grammar vertification is performed on all users. On failure, the tmp 
+ * file is erased. On success, the tmp file replaces the old file.
+ */
+int sepol_file_mod_user(policydb_t* policydb, const char* users_file, 
+	const char* username,  
+	int (*handler) (user_config_t user, void* arg), 
+	void* arg) 
+{
+
+	char tmp_file[PATH_MAX], *ptr, *buffer = NULL;
+        size_t len = 0;
+	FILE *fp, *fp2;
+	unsigned int lineno = 0;
+	int status = 0;
+	int match = 0;
+	user_config_t user = NULL;
+
+	snprintf(tmp_file, sizeof tmp_file, "%s.bak", users_file);
+
+        fp = fopen(users_file, "r");
+        if (!fp) {
+                __sepol_debug_printf("%s: unable to open %s for reading\n", 
+			__FUNCTION__, users_file);
+                return SEPOL_ERR;
+        }
+	__fsetlocking(fp, FSETLOCKING_BYCALLER);
+
+        fp2 = fopen(tmp_file, "a");
+        if (!fp2) {
+                __sepol_debug_printf("%s: unable to open %s for writing\n", 
+			__FUNCTION__, tmp_file);
+                fclose(fp);
+                return SEPOL_ERR;
+        }
+	__fsetlocking(fp2, FSETLOCKING_BYCALLER);
+
+	/* Iterate over each line of the file */
+	while (getline(&buffer, &len, fp) >= 0) {
+		lineno++;
+
+		/* Empty line */
+		if (len == 0) {
+			fprintf(fp2, "\n");
+			goto next;
+		}
+
+		/* Eat newline, preceding whitespace */
+		if (buffer[len - 1] == '\n')
+			buffer[len - 1] = '\0';
+		ptr = buffer;
+		while (*ptr && isspace(*ptr))
+			ptr++;
+
+                /* Skip comments and blank lines */
+                if (!(*ptr) || *ptr == '#')
+			fprintf(fp2, "%s", buffer);
+		
+                /* Process the rest */
+                else {
+
+			/* Create a user config structure */
+			user_config_t user = uc_create();
+			if (!user) {
+				__sepol_debug_printf("%s: out of memory while "
+				"iterating %s\n", __FUNCTION__, users_file);
+
+				errno = ENOMEM;
+				goto err;
+			}
+
+			/* Parse user data into that structure */
+			if( parse_user_line(ptr, user) < 0 ) {
+				__sepol_debug_printf("%s: malformed line %u "
+				"in %s\n", __FUNCTION__, lineno, users_file);
+
+				errno = EIO;
+				goto err;
+			}
+
+			/* Invoke handler - it may modify user */
+			if (!strcmp(username, uc_get_name(user))) {	
+				status = handler(user, arg);
+				match = 1;
+			}
+
+			/* On delete signal, delete the user. */
+			if (match && (status == SEPOL_HANDLER_SIGDEL)) {
+				if (sepol_policy_del_user(
+					policydb, uc_get_name(user)) < 0) 
+				goto err;
+			}
+
+			/* Try to load the user into policy */
+			else if (match && (status >= 0)) {
+
+				/* Success - print to file */
+				if (sepol_policy_load_user(
+					user, (void*) policydb) >= 0) 
+					print_user(user, fp2);
+				else 
+					goto err;
+			}
+
+			/* Handler error */
+			else 
+				goto err;
+
+                        uc_destroy(user);
+			user = NULL;
+		}
+	
+		next:
+			free(buffer);
+			buffer = NULL;
+	}
+
+        fclose(fp);
+	fclose(fp2);
+	if (!match) {
+		remove(tmp_file);
+		__sepol_debug_printf("%s: unable to find user %s\n", 
+			__FUNCTION__, username);
+		errno = EIO;
+		return SEPOL_ERR;
+	}
+	return rename(tmp_file, users_file);
+
+err:
+	if (buffer)
+		free(buffer);
+	if (user) 
+		uc_destroy(user);
+        fclose(fp);
+	fclose(fp2);
+	remove(tmp_file);
+        return SEPOL_ERR;
+}
+
+/* Load users from usersdir (both local.users and system.users)
+ * into the provided policydb */
+
+int sepol_file_load_users(policydb_t* policydb, const char* usersdir) {
+	char path[PATH_MAX];
+
+	/* Clear unused users */
+	sepol_policy_clear_unused(policydb);
+
+	/* Load base set of system users from the policy package. */
+	snprintf(path, sizeof path, "%s/system.users", usersdir);
+	if (sepol_file_iterate_users(
+			path, &sepol_policy_load_user, 
+			(void*) policydb) < 0) {
+
+		__sepol_debug_printf("%s: Can't load system.users: %s\n", 
+			__FUNCTION__, strerror(errno));
+		return SEPOL_ERR;
+	}
+
+	/* Load local users */
+	snprintf(path, sizeof path, "%s/local.users", usersdir);
+	if (sepol_file_iterate_users(
+			path, &sepol_policy_load_user, 
+			(void*) policydb) < 0) {
+
+		__sepol_debug_printf("%s: Can't load local.users: %s\n", 
+			__FUNCTION__, strerror(errno));
+		return SEPOL_ERR;
+	}
+
+	return SEPOL_SUCCESS;
+}
+
+/* 
+ * Add a user to the users config file (local) and to policy. 
+ */
+int sepol_file_add_user(policydb_t* policydb, 
+	const char* usersdir, user_config_t user) {
+
+	char path[PATH_MAX];
+	FILE* fp;
+
+	/* First, add the user to policy */
+        if (sepol_policy_add_user(policydb, user) < 0) {
+		__sepol_debug_printf("%s: Can't load %s into policy\n", 
+			__FUNCTION__, uc_get_name(user));
+		return SEPOL_ERR;
+        }
+
+	/* Add the user at the end of the config file */
+	snprintf(path, sizeof path, "%s/local.users", usersdir);
+
+	fp = fopen(path, "a");
+	if (!fp) {
+		__sepol_debug_printf("%s: Can't load local.users: %s\n", 
+			__FUNCTION__, strerror(errno));
+		return SEPOL_ERR;
+	}
+
+	fseek(fp, 0, SEEK_END);
+
+	print_user(user, fp);
+	fclose(fp);
+	return SEPOL_SUCCESS;
+}
diff -Naur libsepol-1.5.9.orig/src/users_policy.c libsepol-1.5.9.new/src/users_policy.c
--- libsepol-1.5.9.orig/src/users_policy.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/src/users_policy.c	2005-06-17 22:30:43.000000000 -0400
@@ -0,0 +1,344 @@
+#include <stdlib.h>
+#include <sepol/policydb.h>
+#include <sepol/mls.h>
+
+#include <sepol/user_config.h>
+#include <sepol/users_policy.h>
+
+#include "private.h"
+
+static int delusers;
+
+struct kill_user_data {
+        struct policydb *policydb;
+        ebitmap_t *free_users;
+};
+
+/* Select users for removal based on whether they were defined in the
+   new users configuration. */
+static int select_user(
+	hashtab_key_t key, hashtab_datum_t datum, void *datap) {
+	user_datum_t *usrdatum = datum;
+
+	if (!usrdatum->defined)
+		return 1;
+	return 0;
+}
+
+/* Fold user values down to avoid holes generated by removal.
+   As the SID table is remapped by the kernel upon a policy reload,
+   this is safe for existing SIDs.  But it could be a problem for
+   constraints if they refer to the particular user.  */
+static int remap_users(hashtab_key_t key, hashtab_datum_t datum, void *p)
+{
+	user_datum_t *usrdatum = datum;
+	struct kill_user_data *kud = p;
+	struct policydb *pol = kud->policydb;
+	ebitmap_t *free_users = kud->free_users;
+	int i;
+
+	if (usrdatum->value > pol->p_users.nprim) {
+		for (i = ebitmap_startbit(free_users); 
+		     i < ebitmap_length(free_users); i++) {
+
+			if (ebitmap_get_bit(free_users, i)) {
+				usrdatum->value = i+1;
+				ebitmap_set_bit(free_users, i, 0);
+				return 0;
+			}
+		}
+	}
+	return 0;
+}
+
+/* Kill the user entries selected by select_user, and
+   record that their slots are free. */
+static void kill_user(hashtab_key_t key, hashtab_datum_t datum, void *p)
+{
+	user_datum_t *usrdatum;
+	struct kill_user_data *kud = p;
+	struct policydb *pol = kud->policydb;
+	ebitmap_t *free_users = kud->free_users;
+
+	if (key)
+		free(key);
+	
+	usrdatum = (user_datum_t *) datum;
+	
+	if (free_users != NULL) 
+		ebitmap_set_bit(free_users, usrdatum->value - 1, 1);
+
+	ebitmap_destroy(&usrdatum->roles);
+	free(datum);
+	pol->p_users.nprim--;
+}
+
+void sepol_policy_clear_unused(policydb_t* policydb) {
+	struct ebitmap free_users;
+	struct kill_user_data kud;
+
+	if (delusers) {
+		/* Kill unused users and remap to avoid holes. */
+		ebitmap_init(&free_users);
+		kud.policydb = policydb;
+		kud.free_users = &free_users;
+		hashtab_map_remove_on_error(
+			policydb->p_users.table,
+			&select_user,
+			&kill_user, &kud);
+
+		hashtab_map(
+			policydb->p_users.table,
+			&remap_users, &kud);
+			ebitmap_destroy(&free_users);
+        }
+}
+
+
+/* Add a user to the given policydb. The user may not exist already */
+
+int sepol_policy_add_user(policydb_t* policydb, user_config_t user) {
+	char* name;
+	user_datum_t* usrdatum;
+
+	/* See if a user exists */
+	name = strdup(uc_get_name(user));
+	if (!name) {
+		__sepol_debug_printf("%s: out of memory for %s\n", 
+			__FUNCTION__, uc_get_name(user));
+		return SEPOL_ERR;
+	}
+
+        usrdatum = hashtab_search(policydb->p_users.table, name);
+
+	/* If it does, fail */
+	if (usrdatum) {
+		__sepol_debug_printf("%s: %s is already in the policy\n", 
+			__FUNCTION__, name);
+		free(name);
+		return SEPOL_ERR;	
+	}
+	
+	else {
+		free(name);
+		return sepol_policy_load_user(user, policydb);
+	}
+}
+
+/* Delete a user from the given policydb. This function will
+ * fail if the user does not exist. */
+
+int sepol_policy_del_user(policydb_t* policydb, const char* username) {
+	user_datum_t* usrdatum;
+	struct kill_user_data kud;
+
+	char* name = strdup(username);
+	if (!name) {
+		__sepol_debug_printf("%s: out of memory for %s\n", 
+			__FUNCTION__, username);
+		return SEPOL_ERR;
+	}
+	
+	/* See if such a user exists */
+	usrdatum = hashtab_search(policydb->p_users.table, name);
+
+	/* If not, fail */
+	if (usrdatum == NULL) {
+		__sepol_debug_printf("%s: %s does not exist in the policy\n", 
+			__FUNCTION__, name);
+		errno = EIO;
+		goto err;
+	}
+	else {
+		kud.policydb = policydb;
+		kud.free_users = NULL; /* FIXME? */
+
+		hashtab_remove(
+			policydb->p_users.table, name, 
+			&kill_user, &kud);
+
+	}
+
+	free(name);
+	return SEPOL_SUCCESS;
+err:
+
+	free(name);
+	return SEPOL_ERR;
+}
+
+/* Load a user into policydb. The user may exist already, in
+ * which case the supplied data replaces the existing data. Alternatively,
+ * the user could be new. */
+
+int sepol_policy_load_user(user_config_t user, void* policydb_arg) {
+	policydb_t* policydb = (policydb_t*) policydb_arg;
+
+	/* For user data */
+	const char* tmp;
+	char *name, *role, *mls_level, *mls_range;
+	user_datum_t* usrdatum = NULL;
+	role_datum_t* roldatum;
+	context_struct_t context;
+	unsigned bit;
+	int new = 0;
+
+	/* See if a user exists */
+	name = strdup(uc_get_name(user));
+	if (!name) {
+		__sepol_debug_printf("%s: out of memory for %s\n", 
+			__FUNCTION__, uc_get_name(user));
+		return SEPOL_ERR;
+	}
+
+	usrdatum = hashtab_search(policydb->p_users.table, name);
+
+	/* If it does, we will modify it */
+	if (usrdatum) {
+		ebitmap_init(&usrdatum->roles);
+		usrdatum->defined = 1;
+
+	/* Otherwise, create a new one */
+	} else {
+		usrdatum = (user_datum_t *) malloc(sizeof(user_datum_t));
+		if (!usrdatum) {
+			__sepol_debug_printf("%s:  out of memory for %s\n",
+				 __FUNCTION__, name);
+			free(name);
+			errno = ENOMEM;
+			return SEPOL_ERR;
+		}
+		memset(usrdatum, 0, sizeof(user_datum_t));
+		ebitmap_init(&usrdatum->roles);
+		usrdatum->defined = 1;
+		new = 1;
+	}
+
+	uc_iter_init(user);
+
+	/* For every role */
+	while ((tmp = uc_next_role(user))) {
+		role = strdup(tmp);
+		if (!role) {
+			__sepol_debug_printf("%s: out of memory for %s\n", 
+				__FUNCTION__, name);
+			goto err;
+		}
+
+		/* Search for the role */
+		roldatum = hashtab_search(policydb->p_roles.table, role);
+		if (!roldatum) {
+			__sepol_debug_printf("sepol_add_user(): undefined role "
+				"%s for user %s\n", role, name);
+
+			errno = EIO;
+			free(role);
+			goto err;	
+		}
+
+		/* Set the role and every role it dominates */
+		for (bit = ebitmap_startbit(&roldatum->dominates); 
+		     bit < ebitmap_length(&roldatum->dominates); bit++) {
+
+			if (ebitmap_get_bit(&roldatum->dominates, bit)) {
+				if (ebitmap_set_bit(&usrdatum->roles, bit, 1)) {
+					__sepol_debug_printf("sepol_add_user():"
+					"  out of memory for %s\n", name);
+
+					errno = ENOMEM;
+					free(role);
+					goto err;
+				}
+			}
+		}
+		
+		free(role);
+	}
+
+	/* MLS level */
+	if (mls_enabled) {
+		context_init(&context);
+
+		if (uc_get_mls_level(user) == NULL) {
+			__sepol_debug_printf("%s: no mls level for user %s\n", 
+				__FUNCTION__, name);
+			errno = EIO;
+			goto err;
+		}
+
+		mls_level = strdup(uc_get_mls_level(user));
+		if (!mls_level) {
+			__sepol_debug_printf("%s: out of memory for %s\n", 
+				__FUNCTION__, name);
+			goto err;
+		}
+
+		if (mls_context_to_sid(policydb, '$', &mls_level, &context)) {
+			__sepol_debug_printf("%s:  invalid level %s for user %s\n", 
+				__FUNCTION__, mls_level, name);
+			errno = EIO;
+			free(mls_level);
+			goto err;
+		}
+		free(mls_level);
+		memcpy(&usrdatum->dfltlevel, 
+		       &context.range.level[0], 
+		        sizeof(usrdatum->dfltlevel));
+		
+		/* MLS range */
+		context_init(&context);
+		if (uc_get_mls_range(user) == NULL) {
+			__sepol_debug_printf("%s: no mls range for user %s\n", 
+				__FUNCTION__, name);
+			errno = EIO;
+			goto err;
+		}	
+
+		mls_range = strdup(uc_get_mls_level(user));
+		if (!mls_range) {
+			__sepol_debug_printf("%s: out of memory for %s\n", 
+				__FUNCTION__, name);
+			goto err;
+		}
+
+		if (mls_context_to_sid(policydb, '$', &mls_range, &context)) {
+			__sepol_debug_printf("%s: invalid range %s for user %s\n", 
+				__FUNCTION__, mls_range, name);
+			errno = EIO;
+			free(mls_range);
+			goto err;
+		}
+		free(mls_range);
+		memcpy(&usrdatum->range, &context.range, sizeof(usrdatum->range));
+	}
+
+	/* If there are no errors, and this is a new user, add the user to policy */
+	if (new) {
+		char *id = strdup(name);
+		if (!id) {
+			__sepol_debug_printf("%s: out of memory for %s\n", 
+				__FUNCTION__, name); 
+			goto err;
+		}
+
+		usrdatum->value = ++policydb->p_users.nprim;
+		if (hashtab_insert(policydb->p_users.table, 
+			id, (hashtab_datum_t) usrdatum)) {
+
+			__sepol_debug_printf("%s: out of memory for %s\n", 
+				__FUNCTION__, name);
+
+			errno = ENOMEM;
+			free(id);
+			goto err;
+		}
+	}
+
+	free(name);
+	return SEPOL_SUCCESS;
+
+	err:
+		free(name);
+		free(usrdatum);
+		return SEPOL_ERR;
+}

--=-b1s4koXcpBZhnnD1euSm
Content-Disposition: attachment; filename=shadow.diff
Content-Type: text/x-patch; name=shadow.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur -X shadow.excludes shadow-4.0.7.orig/configure.in shadow-4.0.7.new/configure.in
--- shadow-4.0.7.orig/configure.in	2004-12-19 21:31:26.000000000 -0500
+++ shadow-4.0.7.new/configure.in	2005-06-18 00:37:57.000000000 -0400
@@ -246,9 +246,18 @@
 fi
 
 if test "$with_selinux" = "yes"; then
-	AC_CHECK_LIB(selinux, is_selinux_enabled, [LIBSELINUX="-lselinux"], [SELinuux enabled but libselinux not found])
+	AC_CHECK_LIB(selinux, security_create_policydb, [LIBSELINUX="-lselinux"], 
+		AC_MSG_ERROR(SELinux enabled but libselinux missing or wrong version))
+	AC_CHECK_LIB(sepol, sepol_file_add_user, [LIBSEPOL="-lsepol"], 
+		AC_MSG_ERROR(SELinux enabled but libsepol missing or wrong version))
+
 	AC_SUBST(LIBSELINUX)
-	AC_CHECK_HEADERS(selinux/selinux.h, [], [selinux/selinux.h is missing])
+	AC_SUBST(LIBSEPOL)
+
+	AC_CHECK_HEADERS(selinux/selinux.h, [], AC_MSG_ERROR(selinux/selinux.h is missing))
+	AC_CHECK_HEADERS(sepol/sepol.h, [], AC_MSG_ERROR(sepol/sepol.h is missing))
+	AC_CHECK_HEADERS(sepol/user_config.h, [], AC_MSG_ERROR(sepol/user_config.h is missing))
+
 	AC_DEFINE(WITH_SELINUX, 1, [Build shadow with SELinux support])
 fi
 
diff -Naur -X shadow.excludes shadow-4.0.7.orig/lib/selinux.h shadow-4.0.7.new/lib/selinux.h
--- shadow-4.0.7.orig/lib/selinux.h	1969-12-31 19:00:00.000000000 -0500
+++ shadow-4.0.7.new/lib/selinux.h	2005-06-17 15:45:12.000000000 -0400
@@ -0,0 +1,21 @@
+#ifndef _SHADOW_SELINUX_H
+#define _SHADOW_SELINUX_H
+
+#include <sepol/user_config.h>
+#include "defines.h"
+
+#define E_SUCCESS	0	/* success */
+#define E_POL_MAP	100	/* can't map the SELinux policy */
+#define E_POL_UPDATE	101	/* can't update the policy/users file */
+#define E_POL_LOAD	102	/* can't load the SELinux policy */
+#define E_UC_ERR	103	/* can't construct the user_config structure */
+#define E_SELINUX_OFF	104	/* selinux is disabled */
+
+int selinux_get_roles (
+	char *list, 
+	user_config_t* sel_user);
+
+int selinux_add(const char* name, user_config_t sel_user);
+int selinux_delete(const char* name);
+
+#endif
diff -Naur -X shadow.excludes shadow-4.0.7.orig/src/Makefile.am shadow-4.0.7.new/src/Makefile.am
--- shadow-4.0.7.orig/src/Makefile.am	2004-10-25 20:48:32.000000000 -0400
+++ shadow-4.0.7.new/src/Makefile.am	2005-06-17 11:11:14.000000000 -0400
@@ -62,7 +62,8 @@
 passwd_LDADD   = $(LDADD) $(LIBPAM) $(LIBCRACK)
 su_SOURCES     = su.c suauth.c
 su_LDADD       = $(LDADD) $(LIBPAM)
-useradd_LDADD  = $(LDADD) $(LIBPAM)
+useradd_LDADD  = $(LDADD) $(LIBPAM) $(LIBSELINUX) $(LIBSEPOL)
+useradd_SOURCES = useradd.c selinux.c  
 userdel_LDADD  = $(LDADD) $(LIBPAM)
 usermod_LDADD  = $(LDADD) $(LIBPAM)
 
diff -Naur -X shadow.excludes shadow-4.0.7.orig/src/selinux.c shadow-4.0.7.new/src/selinux.c
--- shadow-4.0.7.orig/src/selinux.c	1969-12-31 19:00:00.000000000 -0500
+++ shadow-4.0.7.new/src/selinux.c	2005-06-18 17:28:26.000000000 -0400
@@ -0,0 +1,160 @@
+#include <config.h>
+
+#ifdef WITH_SELINUX
+
+#include <errno.h>
+#include <selinux/selinux.h>
+#include <selinux/selinux-sepol.h>
+#include <sepol/sepol.h>
+#include "selinux.h"
+
+extern char* Prog;
+
+int selinux_get_roles (
+	char *list, 
+	user_config_t* sel_user)
+{
+	char* cp;
+	int ret = E_SUCCESS;
+
+	if (!*list)
+		return ret;
+
+	*sel_user = uc_create();
+	if (!*sel_user) {
+		ret = E_UC_ERR;
+		goto err;
+	}
+
+	do {
+		/*
+		 * Strip role from list
+		 */
+
+		if ((cp = strchr (list, ',')))
+			*cp++ = '\0';
+
+		/* FIXME: check the validity of roles here ?? */
+
+		/*
+		 * Add role to user roles
+		 */
+
+		if (uc_add_role(*sel_user, list) < 0) {
+			ret = E_UC_ERR;
+			goto err;
+		}
+
+		list = cp;
+
+	} while (list);
+
+	return ret;
+
+	err:
+
+	if (errno == ENOMEM)
+		fprintf(stderr, _("%s: out of memory.\n"), Prog);
+	else
+		fprintf(stderr, _("%s: unspecified error while "
+			"constructing SELinux user structure.\n"), Prog);
+
+	if (*sel_user)
+		uc_destroy(*sel_user);
+
+	*sel_user = NULL;
+
+	return ret;
+}
+
+int selinux_add(const char* name, user_config_t sel_user) {
+	int ret = E_SUCCESS;
+	policydb_t* policydb = NULL;
+
+	if (!sel_user) {
+		ret = E_UC_ERR;
+		fprintf(stderr, 
+			_("%s: user SELinux structure is null.\n"), Prog);
+		goto exit;
+	}
+	
+	if (uc_set_name(sel_user, name) < 0) {
+		ret = E_UC_ERR;
+
+		if (errno == ENOMEM)
+			fprintf(stderr, _("%s: out of memory.\n"), Prog);
+
+		else
+			fprintf(stderr, _("%s: unspecified error while "
+			"constructing SELinux user structure.\n"), Prog);
+	
+		goto exit;
+	}
+
+	if (security_create_default_policydb(&policydb) < 0) {
+		ret = E_POL_MAP;
+		fprintf(stderr, _("%s: can't create SELinux policy db.\n"), Prog);
+		goto exit;
+	}
+
+	if (sepol_file_add_user(policydb, selinux_users_path(), sel_user) < 0) {
+
+		ret = E_POL_UPDATE;
+		fprintf(stderr, _("%s: can't add %s to SElinux file.\n"), 
+			Prog, uc_get_name(sel_user));
+		goto exit;
+	}
+
+	if (security_load_policydb(policydb) < 0) {
+		ret = E_POL_LOAD;
+		fprintf(stderr, _("%s: Warning! User %s added to file, "
+			"but we can't reload the SELinux policy.\n"), 
+			Prog, uc_get_name(sel_user));
+
+		goto exit;
+	}
+
+	exit:
+	if (sel_user)
+		uc_destroy(sel_user);
+
+	if (policydb)
+		security_destroy_policydb(policydb);
+
+	return ret;
+}
+
+int selinux_delete(const char* name) {
+
+	policydb_t* policydb = NULL;
+	int ret = E_SUCCESS;
+
+	if (security_create_default_policydb(&policydb) < 0) {
+		ret = E_POL_MAP;
+		fprintf(stderr, _("%s: can't create SELinux policy db.\n"), Prog);
+		goto exit;
+        }
+
+        if (sepol_file_del_user(policydb, selinux_users_path(), name) < 0) {
+
+		ret = E_POL_UPDATE;
+		fprintf(stderr, 
+			_("%s: can't remove %s from SElinux file.\n"), 
+				Prog, name);
+		goto exit;
+        }
+
+        if (security_load_policydb(policydb) < 0) {
+		ret = E_POL_LOAD;
+		fprintf(stderr, _("%s: Warning! User %s removed from file, "
+			"but we can't reload the SELinux policy.\n"), 
+			Prog, name);
+		goto exit;
+        }
+	exit:
+
+	security_destroy_policydb(policydb);
+        return ret;
+}
+
+# endif
diff -Naur -X shadow.excludes shadow-4.0.7.orig/src/useradd.c shadow-4.0.7.new/src/useradd.c
--- shadow-4.0.7.orig/src/useradd.c	2005-06-16 16:42:10.000000000 -0400
+++ shadow-4.0.7.new/src/useradd.c	2005-06-18 17:31:24.000000000 -0400
@@ -48,6 +48,11 @@
 #include <security/pam_misc.h>
 #include <pwd.h>
 #endif				/* USE_PAM */
+#ifdef WITH_SELINUX
+#include "selinux.h"
+#include <selinux/selinux.h>
+#include <sepol/sepol.h>
+#endif
 #include "pwauth.h"
 #if HAVE_LASTLOG_H
 #include <lastlog.h>
@@ -105,10 +110,15 @@
 static int is_shadow_grp;
 #endif
 static char **user_groups;	/* NULL-terminated list */
+#ifdef WITH_SELINUX
+user_config_t sel_user = NULL;	/* SELinux user configuration */
+static int do_selinux_add = 0;
+static int sel_user_added = 0;
+#endif
 static long sys_ngroups;
 static int do_grp_update = 0;	/* group files need to be updated */
 
-static char *Prog;
+char *Prog;
 
 static int
  bflg = 0,			/* new default root of home directory */
@@ -125,8 +135,9 @@
  nflg = 0,			/* do NOT create a group having the same name as the user */
  oflg = 0,			/* permit non-unique user ID to be specified with -u */
  rflg = 0,			/* create a system account */
+ Rflg = 0,			/* SElinux roles for this user */ 
  sflg = 0,			/* shell program for new account */
- uflg = 0;			/* specify user ID for new account */
+ uflg = 0,			/* specify user ID for new account */
  lflg = 0;			/* do not add user to lastlog database file */
 
 extern char *optarg;
@@ -241,6 +252,14 @@
 	if (gr_dbm_added)
 		fprintf (stderr, _("%s: rebuild the group database\n"),
 			 Prog);
+
+#ifdef WITH_SELINUX
+	if (sel_user_added) {
+		int ret = selinux_delete(user_name);
+		if (ret != E_SUCCESS) 
+			fprintf(stderr, _("%s: SELinux undo failed\n"));
+	}
+#endif
 #ifdef	SHADOWPWD
 	if (sp_dbm_added)
 		sp_dbm_remove (user_name);
@@ -738,12 +757,14 @@
 	fprintf (stderr, _("               [-f inactive] [-e expire]\n"));
 #endif
 	fprintf (stderr, _("               [-p passwd] [-M] [-n] [-r] [-l] name\n"));
+#ifdef WITH_SELINUX
+        fprintf (stderr, _("               [-R role,...] \n"));
+#endif
 	fprintf (stderr,
 		 _("       useradd -D [-g group] [-b base] [-s shell]\n"));
 #ifdef SHADOWPWD
 	fprintf (stderr, _("               [-f inactive] [-e expire]\n"));
 #endif
-
 	exit (E_USAGE);
 }
 
@@ -1153,13 +1174,13 @@
 {
 	const struct group *grp;
 	int anyflag = 0;
-	int arg;
+	int arg, ret;
 	char *cp;
 
 #ifdef SHADOWPWD
-#define FLAGS "A:Du:og:G:d:s:c:mk:p:f:e:b:O:Mnrl"
+#define FLAGS "A:Du:og:G:R:d:s:c:mk:p:f:e:b:O:Mnrl"
 #else
-#define FLAGS "A:Du:og:G:d:s:c:mk:p:b:O:Mnrl"
+#define FLAGS "A:Du:og:G:R:d:s:c:mk:p:b:O:Mnrl"
 #endif
 	while ((arg = getopt (argc, argv, FLAGS)) != EOF) {
 #undef FLAGS
@@ -1310,6 +1331,27 @@
 			}
 			user_pass = optarg;
 			break;
+
+		case 'R':
+#ifdef WITH_SELINUX
+
+			if (!is_selinux_enabled()) {
+				fprintf(stderr, _("%s: flag -R requires "
+					"enabled SElinux."), Prog);
+				exit (E_SELINUX_OFF);
+			}
+
+			ret = selinux_get_roles (optarg, &sel_user);
+			if (ret != E_SUCCESS) 
+				exit (ret);
+			else
+				do_selinux_add++;
+#else
+			fprintf(stderr, _("%s: flag -R is not available: "
+				"not compiled with SELinux support.\n", Prog));
+#endif
+			Rflg++;
+			break;
 		case 's':
 			if (!VALID (optarg) || (optarg[0] &&
 						(optarg[0] != '/'
@@ -1646,6 +1688,18 @@
 
 	if (do_grp_update)
 		grp_update ();
+
+#ifdef WITH_SELINUX
+	if (do_selinux_add) {
+		int ret = selinux_add (user_name, sel_user);
+		if (ret != E_SUCCESS)
+			fail_exit (ret);
+		else
+			sel_user_added = 1;
+
+		/* FIXME: do genhomedircon thing here */
+	}
+#endif
 }
 
 /* a fake something */
@@ -1770,6 +1824,11 @@
 
 static void create_home (void)
 {
+	int mode = 0777 & ~getdef_num ("UMASK", 022);
+#ifdef WITH_SELINUX
+	security_context_t con = NULL;
+#endif
+
 	if (access (user_home, F_OK)) {
 		/* XXX - create missing parent directories.  --marekm */
 		if (mkdir (user_home, 0)) {
@@ -1778,8 +1837,15 @@
 				 Prog, user_home);
 			fail_exit (E_HOMEDIR);
 		}
+#ifdef WITH_SELINUX
+		security_context_t con = NULL;
+		if (!matchpathcon (user_home, mode, &con))
+			setfilecon(user_home, con);
+		if (con)
+			freecon(con);
+#endif
 		chown (user_home, user_id, user_gid);
-		chmod (user_home, 0777 & ~getdef_num ("UMASK", 022));
+		chmod (user_home, mode);
 		home_added++;
 	}
 }
@@ -1866,6 +1932,11 @@
 	bindtextdomain (PACKAGE, LOCALEDIR);
 	textdomain (PACKAGE);
 
+#ifdef WITH_SELINUX
+	/* security_debug(0);
+	 * sepol_debug(0); */
+#endif
+
 	OPENLOG("useradd");
 
 	sys_ngroups = sysconf(_SC_NGROUPS_MAX);

--=-b1s4koXcpBZhnnD1euSm--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
