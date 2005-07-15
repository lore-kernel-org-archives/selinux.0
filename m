Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FJKFgA013880
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 15:20:15 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FJFrBp000627
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 19:15:53 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6FJGcGu014600
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 15:16:38 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6FJGcV13282
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 15:16:38 -0400
Received: from celtics.boston.redhat.com (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j6FJGbg1012894
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 15:16:38 -0400
Subject: Patches: libsepol
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-ccxeFKmwDt208ERjT45F"
Date: Fri, 15 Jul 2005 15:13:28 -0400
Message-Id: <1121454809.10134.11.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ccxeFKmwDt208ERjT45F
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch adds a new debugging system, which
allows setting the printf function, and provides a separate 
field for the function name. 

libsepol-1-debug.diff

The following patch marks more functions extern, and provides
two new functions - policydb_from_image, and policydb_to_image.
Those helper functions will be used in future code.

libsepol-4-policydb_convert.diff

The following patch is attached for comments only.
It is intended as a replacement for genusers.c, to provide
an interface for libsemanage to work with users.

libsepol-5-users.diff

Note that no new functions are added to the shared interface,
following up with the plan to make this library static. Also,
I've dropped patches which make the policydb an opaque structure,
as they will not be necessary, and may cause instability.

--=-ccxeFKmwDt208ERjT45F
Content-Disposition: attachment; filename=libsepol-1-debug.diff
Content-Type: text/x-patch; name=libsepol-1-debug.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aru libsepol.work/include/sepol/debug.h libsepol-1-debug/include/sepol/debug.h
--- libsepol.work/include/sepol/debug.h	2005-07-09 20:38:18.000000000 -0400
+++ libsepol-1-debug/include/sepol/debug.h	2005-07-15 13:09:13.000000000 -0400
@@ -0,0 +1,9 @@
+#ifndef _SEPOL_DEBUG_H_
+#define _SEPOL_DEBUG_H_
+
+extern void sepol_enable_debug(
+	void (*fn)(const char* fname, const char *fmt, ...));
+
+extern void sepol_disable_debug();
+
+#endif /* _SEPOL_DEBUG_H_ */
diff -aru libsepol.work/src/debug.c libsepol-1-debug/src/debug.c
--- libsepol.work/src/debug.c	2005-07-04 06:38:32.000000000 -0400
+++ libsepol-1-debug/src/debug.c	2005-07-15 14:34:11.000000000 -0400
@@ -0,0 +1,52 @@
+#include <stdarg.h>
+#include <stdio.h>
+
+#include <sepol/sepol.h>
+#include <sepol/debug.h>
+#include "debug.h"
+
+#ifdef __GNUC__
+__attribute__ ((format (printf, 2, 3))) 
+#endif
+static void default_printf(
+	const char* fname, 
+	const char *fmt, ...) {
+
+	va_list ap;
+	va_start(ap, fmt);
+	fprintf(stderr, "libsepol.%s: ", fname);
+	vfprintf (stderr, fmt, ap);
+	va_end(ap);
+}
+
+#ifdef __GNUC__
+__attribute__ ((format (printf, 2, 3)))
+#endif
+static void suppress_printf(
+	const char* unused1, 
+	const char* unused2, ...) { 
+		unused1 = NULL;
+		unused2 = NULL;
+}
+
+void (*DEBUG) (const char* fname, const char* fmt, ...) = default_printf;
+
+void sepol_debug_compat(int on) {
+	DEBUG = (on)? default_printf : suppress_printf;
+}
+
+void sepol_enable_debug(
+	void (*fn)(const char* fname, const char *fmt, ...)) {
+
+	DEBUG = (fn)? fn: default_printf;	
+
+	/* Compatibility  - old debug system */
+	sepol_debug(1);
+}
+
+void sepol_disable_debug() {
+	DEBUG = suppress_printf;
+
+	/* Compatibility - old debug system */
+	sepol_debug(0);
+}
diff -aru libsepol.work/src/debug.h libsepol-1-debug/src/debug.h
--- libsepol.work/src/debug.h	2005-07-04 06:38:32.000000000 -0400
+++ libsepol-1-debug/src/debug.h	2005-07-15 14:34:12.000000000 -0400
@@ -0,0 +1,17 @@
+#ifndef _SEPOL_INTERNAL_DEBUG_H_
+#define _SEPOL_INTERNAL_DEBUG_H_
+
+#define STATUS_SUCCESS 0
+#define STATUS_ERR -1
+#define STATUS_NODATA 1
+
+extern void sepol_debug_compat(int on);
+
+#ifdef __GNUC__
+__attribute__ ((format (printf, 2, 3)))
+#endif
+extern void (*DEBUG) (
+	const char* fname,
+	const char* fmt, ...);
+
+#endif /* _SEPOL_INTERNAL_DEBUG_H_ */
diff -aru libsepol.work/src/genusers.c libsepol-1-debug/src/genusers.c
--- libsepol.work/src/genusers.c	2005-07-07 06:50:51.000000000 -0400
+++ libsepol-1-debug/src/genusers.c	2005-07-15 14:34:31.000000000 -0400
@@ -9,11 +9,17 @@
 #include <sepol/mls.h>
 #include <stdarg.h>
 
+#include "debug.h"
 #include "private.h"
 
 static int gdebug=1;
 
-void sepol_debug(int on) { gdebug=on; };
+void sepol_debug(int on) { 
+	gdebug=on; 
+
+	/* New debug system */
+	sepol_debug_compat(on);
+};
 
 void __sepol_debug_printf(const char *fmt, ...) {
 	if (gdebug) {

--=-ccxeFKmwDt208ERjT45F
Content-Disposition: attachment; filename=libsepol-4-policydb_convert.diff
Content-Type: text/x-patch; name=libsepol-4-policydb_convert.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aru libsepol.work/include/sepol/policydb.h libsepol-4-policydb_convert/include/sepol/policydb.h
--- libsepol.work/include/sepol/policydb.h	2005-07-07 06:50:51.000000000 -0400
+++ libsepol-4-policydb_convert/include/sepol/policydb.h	2005-07-15 14:36:56.000000000 -0400
@@ -436,6 +436,10 @@
 
 extern int policydb_init(policydb_t * p, int policy_type);
 
+extern int policydb_from_image(void* data, size_t len, policydb_t* policydb);
+
+extern int policydb_to_image(policydb_t* policydb, void **newdata, size_t *newlen);
+
 extern int policydb_index_classes(policydb_t * p);
 
 extern int policydb_index_bools(policydb_t * p);
@@ -449,43 +453,43 @@
 extern int policydb_load_isids(policydb_t *p, sidtab_t *s);
 
 extern int policydb_context_isvalid(policydb_t *p, context_struct_t *c);
-void symtabs_destroy(symtab_t *symtab);
-int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p);
+extern void symtabs_destroy(symtab_t *symtab);
+extern int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p);
 typedef void (*hashtab_destroy_func_t) (hashtab_key_t k, hashtab_datum_t d, void *args);
-hashtab_destroy_func_t get_symtab_destroy_func(int sym_num);
+extern hashtab_destroy_func_t get_symtab_destroy_func(int sym_num);
 
-void class_perm_node_init(class_perm_node_t *x);
-void type_set_init(type_set_t *x);
-void type_set_destroy(type_set_t *x);
-int type_set_cpy(type_set_t *dst, type_set_t *src);
-int type_set_or_eq(type_set_t *dst, type_set_t *other);
-void role_set_init(role_set_t *x);
-void role_set_destroy(role_set_t *x);
-void avrule_init(avrule_t *x);
-void avrule_destroy(avrule_t *x);
-void avrule_list_destroy(avrule_t *x);
-void role_trans_rule_init(role_trans_rule_t *x);
-void role_trans_rule_list_destroy(role_trans_rule_t *x);
-
-void role_datum_init(role_datum_t *x);
-void role_datum_destroy(role_datum_t *x);
-void role_allow_rule_init(role_allow_rule_t *x);
-void role_allow_rule_destroy(role_allow_rule_t *x);
-void role_allow_rule_list_destroy(role_allow_rule_t *x);
-void type_datum_init(type_datum_t *x);
-void type_datum_destroy(type_datum_t *x);
-void user_datum_init(user_datum_t *x);
-void user_datum_destroy(user_datum_t *x);
+extern void class_perm_node_init(class_perm_node_t *x);
+extern void type_set_init(type_set_t *x);
+extern void type_set_destroy(type_set_t *x);
+extern int type_set_cpy(type_set_t *dst, type_set_t *src);
+extern int type_set_or_eq(type_set_t *dst, type_set_t *other);
+extern void role_set_init(role_set_t *x);
+extern void role_set_destroy(role_set_t *x);
+extern void avrule_init(avrule_t *x);
+extern void avrule_destroy(avrule_t *x);
+extern void avrule_list_destroy(avrule_t *x);
+extern void role_trans_rule_init(role_trans_rule_t *x);
+extern void role_trans_rule_list_destroy(role_trans_rule_t *x);
+
+extern void role_datum_init(role_datum_t *x);
+extern void role_datum_destroy(role_datum_t *x);
+extern void role_allow_rule_init(role_allow_rule_t *x);
+extern void role_allow_rule_destroy(role_allow_rule_t *x);
+extern void role_allow_rule_list_destroy(role_allow_rule_t *x);
+extern void type_datum_init(type_datum_t *x);
+extern void type_datum_destroy(type_datum_t *x);
+extern void user_datum_init(user_datum_t *x);
+extern void user_datum_destroy(user_datum_t *x);
 
-int check_assertions(policydb_t *p, avrule_t *avrules, avtab_t *avtab);
-int symtab_insert(policydb_t *x, uint32_t sym,
+extern int check_assertions(policydb_t *p, avrule_t *avrules, avtab_t *avtab);
+extern int symtab_insert(policydb_t *x, uint32_t sym,
                   hashtab_key_t key, hashtab_datum_t datum,
                   uint32_t scope, uint32_t avrule_decl_id,
                   uint32_t *value);
 
 /* A policy "file" may be a memory region referenced by a (data, len) pair
    or a file referenced by a FILE pointer. */
-struct policy_file {
+typedef struct policy_file {
 #define PF_USE_MEMORY  0
 #define PF_USE_STDIO   1
 #define PF_LEN         2 /* total up length in len field */ 
@@ -494,7 +498,7 @@
 	size_t len;
 	FILE *fp;
         unsigned char buffer[BUFSIZ];
-};
+} policy_file_t;
 
 extern int policydb_read(policydb_t * p, struct policy_file * fp, unsigned int verbose);
 extern int avrule_read_list(policydb_t *p, avrule_t **avrules, struct policy_file *fp);
diff -aru libsepol.work/src/policydb_convert.c libsepol-4-policydb_convert/src/policydb_convert.c
--- libsepol.work/src/policydb_convert.c	2005-07-04 06:39:32.000000000 -0400
+++ libsepol-4-policydb_convert/src/policydb_convert.c	2005-07-15 14:51:05.000000000 -0400
@@ -0,0 +1,104 @@
+#include <stdlib.h>
+
+#include "private.h"
+#include "debug.h"
+
+#include <sepol/policydb.h>
+
+/* Construct a policydb from the supplied (data, len) pair */
+
+int policydb_from_image(void* data, size_t len, policydb_t* policydb) {
+
+        policy_file_t pf;
+
+        pf.type = PF_USE_MEMORY;
+        pf.data = data;
+        pf.len = len;
+
+        if (policydb_read(policydb, &pf, 0)) {
+                DEBUG(__FUNCTION__, "policy image is invalid\n");
+                errno = EINVAL;
+                return STATUS_ERR;
+        }
+
+        return STATUS_SUCCESS;
+}
+
+/* Write a policydb to a memory region, and return the (data, len) pair. */
+
+int policydb_to_image(
+	policydb_t* policydb, void **newdata, size_t *newlen) {
+
+	void *tmp_data = NULL;
+	size_t tmp_len;
+	policy_file_t pf;
+	struct policydb tmp_policydb;
+
+	if (policydb_init(&tmp_policydb, POLICY_KERN) < 0) {
+		DEBUG(__FUNCTION__, "could not initialize temporary policy\n");
+		goto err;
+	}
+	/* Set the policy version for the new policy image we are
+	   about to generate so that it stays the same as the original,
+	   even if we support a newer one. */
+	sepol_set_policyvers(policydb->policy_type, policydb->policyvers);
+
+	/* Compute the length for the new policy image. */
+	pf.type = PF_LEN;
+	pf.data = NULL;
+	pf.len = 0;
+	if (policydb_write(policydb, &pf)) {
+		DEBUG(__FUNCTION__, "could not compute policy length\n"); 
+		errno = EINVAL;	
+		goto err_free;
+	}
+
+	/* Allocate the new policy image. */
+	pf.type = PF_USE_MEMORY;
+	pf.data = malloc(pf.len);
+	if (!pf.data) {
+		DEBUG(__FUNCTION__, "out of memory\n");
+		goto err_free;
+        }
+
+	/* Need to save len and data prior to modification by policydb_write.*/
+	tmp_len = pf.len;
+	tmp_data = pf.data;
+
+	/* Write out the new policy image. */
+	if (policydb_write(policydb, &pf)) {
+		DEBUG(__FUNCTION__, "could not write policy\n");
+		errno = EINVAL;
+		goto err_free;
+        }
+
+	/* Verify the new policy image. */
+	pf.type = PF_USE_MEMORY;
+	pf.data = tmp_data;
+        pf.len = tmp_len;
+        if (policydb_read(&tmp_policydb, &pf, 0)) {
+		DEBUG(__FUNCTION__, "new policy image is invalid\n");
+                errno = EINVAL;
+		goto err_free;
+        }
+	policydb_destroy(&tmp_policydb);
+
+	/* Update (newdata, newlen) */
+	*newdata = tmp_data;
+	*newlen = tmp_len;
+
+	/* Recover */
+	sepol_set_policyvers(POLICY_KERN, POLICYDB_VERSION_MAX);
+        return STATUS_SUCCESS;
+
+	err_free:
+	policydb_destroy(&tmp_policydb);
+
+	err:
+	DEBUG(__FUNCTION__, "could not create policy image\n");
+
+	/* Recover */
+	sepol_set_policyvers(POLICY_KERN, POLICYDB_VERSION_MAX);
+	free(tmp_data);
+	return STATUS_ERR;
+}

--=-ccxeFKmwDt208ERjT45F
Content-Disposition: attachment; filename=libsepol-5-users.diff
Content-Type: text/x-patch; name=libsepol-5-users.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aru libsepol.work/include/sepol/users.h libsepol-5-users/include/sepol/users.h
--- libsepol.work/include/sepol/users.h	2005-07-04 06:37:59.000000000 -0400
+++ libsepol-5-users/include/sepol/users.h	2005-07-15 13:59:22.000000000 -0400
@@ -0,0 +1,39 @@
+#ifndef _SEPOL_USERS_H_
+#define _SEPOL_USERS_H_
+
+#include <sepol/policydb.h>
+
+typedef struct sepol_uinfo {
+	const char* name;
+	const char** roles;
+	const char* mls_level;
+	const char* mls_range;
+} sepol_uinfo_t;
+
+/* Clear unused users */
+extern void sepol_clear_unused_users(
+	policydb_t* policydb);
+
+/* Add/delete/load users from the policy */
+extern int sepol_add_user(
+	policydb_t* policydb,
+	sepol_uinfo_t* user); 
+
+extern int sepol_del_user(
+	policydb_t* policydb, 
+	const char *username);
+
+extern int sepol_load_user(
+	policydb_t* policydb, 
+	sepol_uinfo_t* user);
+
+extern int sepol_is_role_valid(
+	policydb_t* policydb,
+	const char* role);
+
+extern int sepol_get_valid_roles(
+	policydb_t* policydb, 
+	char*** roles, 
+	int* nroles);
+
+#endif /* _SEPOL_USERS_H_ */
diff -aru libsepol.work/src/genusers.c libsepol-5-users/src/genusers.c
--- libsepol.work/src/genusers.c	2005-07-15 15:00:19.000000000 -0400
+++ libsepol-5-users/src/genusers.c	2005-07-15 15:00:14.000000000 -0400
@@ -30,12 +30,7 @@
 	}
 }
 
-static int delusers = 0;
-
-void sepol_set_delusers(int on)
-{
-	delusers = on;
-}
+extern int selinux_delusers;
 
 #undef BADLINE
 #define BADLINE() { \
@@ -382,7 +377,7 @@
 		goto err;
 	}
 
-	if (delusers) {
+	if (selinux_delusers) {
 		/* Kill unused users and remap to avoid holes. */
 		ebitmap_init(&free_users);
 		kud.policydb = &policydb;
diff -aru libsepol.work/src/users.c libsepol-5-users/src/users.c
--- libsepol.work/src/users.c	2005-07-04 06:38:26.000000000 -0400
+++ libsepol-5-users/src/users.c	2005-07-15 14:59:17.000000000 -0400
@@ -0,0 +1,358 @@
+#include <stdlib.h>
+
+#include "private.h"
+#include "debug.h"
+
+#include <sepol/sepol.h>
+#include <sepol/policydb.h>
+#include <sepol/mls.h>
+#include <sepol/users.h>
+
+int selinux_delusers = 0;
+
+void sepol_set_delusers(int on) {
+	selinux_delusers = on;
+}
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
+/* Kill the user entries selected by select_user, and
+   record that their slots are free. */
+static void kill_user(
+	hashtab_key_t key, 
+	hashtab_datum_t datum, 
+	void *arg)
+{
+	user_datum_t *usrdatum = (user_datum_t*) datum;
+	policydb_t* policydb = (policydb_t*) arg;
+
+	/* Locations of user we're deleting, and last user */
+	int old_pos = usrdatum->value - 1;
+	int last_pos = policydb->p_users.nprim - 1;
+
+	/* Fill hole with last user/data pair */
+	if (old_pos != last_pos) {
+
+		char* last_name = policydb->p_user_val_to_name[last_pos];
+		user_datum_t* last_data = 
+			policydb->user_val_to_struct[last_pos];
+
+		/* Decrement prim */
+		last_data->value--;
+	
+		/* Update sid in reverse mapings */
+		policydb->p_user_val_to_name[old_pos] = last_name;
+		policydb->user_val_to_struct[old_pos] = last_data;
+	}
+
+	/* Decrement prim */
+	policydb->p_users.nprim--;
+	
+	/* Free key and data */
+	if (key)
+		free(key);
+	role_set_destroy(&usrdatum->roles);
+	free(datum);
+}
+
+void sepol_clear_unused_users(policydb_t* policydb) {
+	if (selinux_delusers) {
+		hashtab_map_remove_on_error(
+			policydb->p_users.table,
+			&select_user, 
+			&kill_user, 
+			policydb);
+        }
+}
+
+/* Add a user to the given policydb. The user may not exist already */
+
+int sepol_add_user(policydb_t* policydb, sepol_uinfo_t* user) {
+
+	char* name = NULL;
+	user_datum_t* usrdatum;
+
+	/* See if a user exists */
+	name = strdup(user->name);
+	if (!name) 
+		goto omem;
+
+        usrdatum = hashtab_search(policydb->p_users.table, name);
+
+	/* If it does, fail */
+	if (usrdatum) {
+		DEBUG(__FUNCTION__,"%s is already in policy\n", name);
+		goto err;
+	}
+	
+	if (sepol_load_user(policydb, user) < 0) 
+		goto err;
+
+	return STATUS_SUCCESS;
+
+	omem:
+	DEBUG(__FUNCTION__, "out of memory\n");
+
+	err:
+	DEBUG(__FUNCTION__, "could not add %s to policy\n", user->name);
+	free(name);
+	return STATUS_ERR;
+}
+
+/* Delete a user from the given policydb. This function will
+ * fail if the user does not exist. */
+
+int sepol_del_user(policydb_t* policydb, const char* username) {
+	user_datum_t* usrdatum;
+	char* name = NULL;
+
+	name = strdup(username);
+	if (!name) 
+		goto omem;
+	
+	/* See if such a user exists */
+	usrdatum = hashtab_search(policydb->p_users.table, name);
+
+	/* If not, fail */
+	if (usrdatum == NULL) {
+		DEBUG(__FUNCTION__, "%s does not exist in policy\n", name);
+		goto err;
+	}
+	else {
+		if ( hashtab_remove(
+			policydb->p_users.table, name, 
+			&kill_user, policydb) < 0)
+			goto err;
+	}
+
+	free(name);
+	return STATUS_SUCCESS;
+
+omem:
+	DEBUG(__FUNCTION__, "out of memory\n");
+err:
+	DEBUG(__FUNCTION__, "could not remove %s from policy\n", name);
+	free(name);
+	return STATUS_ERR;
+}
+
+/* Load a user into policydb. The user may exist already, in
+ * which case the supplied data replaces the existing data. Alternatively,
+ * the user could be new. */
+
+int sepol_load_user(policydb_t* policydb, sepol_uinfo_t* user) {
+
+	/* For user data */
+	const char** tmp_role;
+	char *name = NULL, *role = NULL, 
+	     *mls_level = NULL, *mls_range = NULL,
+	     *key = NULL;
+	user_datum_t* usrdatum = NULL;
+	role_datum_t* roldatum;
+
+	context_struct_t context;
+	unsigned bit;
+	int new = 0;
+
+	/* See if a user exists */
+	name = strdup(user->name);
+	if (!name) 
+		goto omem;
+
+	usrdatum = hashtab_search(policydb->p_users.table, name);
+
+	/* If it does, we will modify it */
+	if (usrdatum) {
+		role_set_destroy(&usrdatum->roles);
+		role_set_init(&usrdatum->roles);
+		usrdatum->defined = 1;
+
+	/* Otherwise, create a new one */
+	} else {
+		usrdatum = (user_datum_t *) malloc(sizeof(user_datum_t));
+		if (!usrdatum) 
+			goto omem;
+		memset(usrdatum, 0, sizeof(user_datum_t));
+		role_set_init(&usrdatum->roles);
+		usrdatum->defined = 1;
+		new = 1;
+	}
+
+	/* For every role */
+	for (tmp_role = user->roles; *tmp_role; tmp_role++) {
+		role = strdup(*tmp_role);
+		if (!role) 
+			goto omem;
+
+		/* Search for the role */
+		roldatum = hashtab_search(policydb->p_roles.table, role);
+		if (!roldatum) {
+			DEBUG(__FUNCTION__, "undefined role %s for user %s\n", 
+				role, name);
+			goto err;	
+		}
+
+		/* Set the role and every role it dominates */
+		for (bit = ebitmap_startbit(&roldatum->dominates); 
+		     bit < ebitmap_length(&roldatum->dominates); bit++) {
+
+			if (ebitmap_get_bit(&roldatum->dominates, bit)) {
+				if (ebitmap_set_bit(&(usrdatum->roles.roles), bit, 1)) 
+					goto omem;
+			}
+		}
+		
+		free(role);
+		role = NULL;
+	}
+
+	/* MLS level */
+	if (mls_enabled) {
+		context_init(&context);
+
+		if (user->mls_level == NULL) {
+			DEBUG(__FUNCTION__, "no mls level for user %s\n", 
+				name);
+			goto err;
+		}
+
+		mls_level = strdup(user->mls_level);
+		if (!mls_level) 
+			goto omem;
+
+		if (mls_context_to_sid(policydb, '$', &mls_level, &context)) {
+			DEBUG(__FUNCTION__, "invalid level %s for user %s\n", 
+				mls_level, name);
+			goto err;
+		}
+		free(mls_level);
+		mls_level = NULL;
+		memcpy(&usrdatum->dfltlevel, &context.range.level[0], 
+		        sizeof(usrdatum->dfltlevel));
+		
+		/* MLS range */
+		context_init(&context);
+		if (user->mls_range == NULL) {
+			DEBUG(__FUNCTION__, "no mls range for user %s\n", name);
+			goto err;
+		}	
+
+		mls_range = strdup(user->mls_range);
+		if (!mls_range) 
+			goto omem;
+
+		if (mls_context_to_sid(policydb, '$', &mls_range, &context)) {
+			DEBUG(__FUNCTION__, "invalid range %s for user %s\n", 
+				mls_range, name);
+			goto err;
+		}
+		free(mls_range);
+		mls_range = NULL;
+		memcpy(&usrdatum->range, &context.range, sizeof(usrdatum->range));
+	}
+
+	/* If there are no errors, and this is a new user, add the user to policy */
+	if (new) {
+		key = strdup(name);
+		void *tmp_ptr;
+
+		if (!key) 
+			goto omem;
+
+		/* Ensure reverse lookup array has enough space */
+		tmp_ptr = realloc(policydb->user_val_to_struct, 
+			(policydb->p_users.nprim + 1) * sizeof(user_datum_t *));
+		if (!tmp_ptr)
+			goto omem;
+		policydb->user_val_to_struct = tmp_ptr;
+
+		tmp_ptr = realloc(policydb->sym_val_to_name[SYM_USERS], 
+			(policydb->p_users.nprim + 1) * sizeof(user_datum_t *));
+		if (!tmp_ptr)
+			goto omem;
+		policydb->sym_val_to_name[SYM_USERS] = tmp_ptr;
+
+		/* Store user */
+		usrdatum->value = ++policydb->p_users.nprim;
+		if (hashtab_insert(policydb->p_users.table, key, 
+			(hashtab_datum_t) usrdatum) < 0) 
+			goto omem;
+
+		/* Set up reverse entry */
+		policydb->p_user_val_to_name[usrdatum->value - 1] = key;
+		policydb->user_val_to_struct[usrdatum->value - 1] = usrdatum;
+	}	
+	 
+	free(name);
+	return STATUS_SUCCESS;
+
+	omem:
+	DEBUG(__FUNCTION__, "out of memory\n");
+
+	err:
+	DEBUG(__FUNCTION__, "could not load %s into policy\n", 
+		user->name);
+	free(key);
+	free(name);
+	free(role);
+	free(mls_range);
+	free(mls_level);
+	if (new && usrdatum) {
+		role_set_destroy(&usrdatum->roles);
+		free(usrdatum);
+	}
+	return STATUS_ERR;
+}
+
+int sepol_is_role_valid(policydb_t* policydb, const char* role) {
+	int status;
+	char* role_copy = strdup(role);
+	if (!role_copy) {
+		DEBUG(__FUNCTION__, "out of memory, role check failed\n");
+		return STATUS_ERR;
+	}
+
+	status = hashtab_search(policydb->p_roles.table, role_copy) != NULL;
+	free(role_copy);
+	return status;
+}
+
+int sepol_get_valid_roles(policydb_t* policydb, char*** roles, int* nroles) {
+	int tmp_nroles = policydb->p_roles.nprim;
+	char **tmp_roles = (char**) malloc(tmp_nroles * sizeof(char*));
+	char **ptr;
+	int i;
+	if (!tmp_roles) 
+		goto omem;
+
+	for (i =0; i < tmp_nroles; i++) {
+		tmp_roles[i] = strdup(policydb->p_role_val_to_name[i]);
+		if (!tmp_roles[i]) 
+			goto omem;
+	}	 
+
+	*nroles = tmp_nroles;
+	*roles = tmp_roles;
+
+        return STATUS_SUCCESS;
+
+	omem:
+	DEBUG(__FUNCTION__, "out of memory, could not "
+		"allocate list of valid roles\n");
+	
+	ptr = tmp_roles;
+	while (ptr && *ptr) 
+		free(*ptr++);
+	free(tmp_roles);
+	return STATUS_ERR;
+}
+

--=-ccxeFKmwDt208ERjT45F--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
