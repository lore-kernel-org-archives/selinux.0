Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5KCOigA024370
	for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2005 08:24:44 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5KCEvs2003388
	for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2005 12:14:57 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j5KCG85d003556
	for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2005 08:16:08 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j5KCG8MJ003555
	for selinux@tycho.nsa.gov; Mon, 20 Jun 2005 08:16:08 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5K3VLgA021604
	for <selinux@tycho.nsa.gov>; Sun, 19 Jun 2005 23:31:21 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5K3LaGW014193
	for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2005 03:21:36 GMT
Subject: Re: Useradd Integration (v. 3)
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: SELinux <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1119134520.27489.4.camel@localhost.localdomain>
References: <1119132219.26988.14.camel@localhost.localdomain>
	 <1119134520.27489.4.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-a1uumVP3ayr1MnJP6HE9"
Date: Sun, 19 Jun 2005 23:24:03 -0400
Message-Id: <1119237843.20806.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-a1uumVP3ayr1MnJP6HE9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-06-18 at 18:42 -0400, Ivan Gyurdiev wrote:
> > Next, I will work on writing C functions for manipulating the
> > homedir_template file. They will be analogous to users_file.c,
> > and basically move genhomedircon's job into the libsepol library.
> 
> Actually, I think it would be better if I pulled out 
> iterate, mod_user, add... into a more generic thing I can reuse
> for net_contexts, and homedir... 

Attached libsepol changes for v.3.

I've changed some of the functions above into
generic parser utilities, and created a concept of a record - 
you can provide a table of methods for how to work with a particular
record, and then use the record_file.c methods to iterate over
records in a file using the same code, just a different parsing
function.

I am still not quite happy with this. It could be made simpler,
and better. I'm pretty sure the MLS parsing code is broken,
and I need to rewrite/test this. 

On the other hand I got multiline parsing to work,
and parsing is simpler in general. I can also
reuse a large part of the code to parse other things
than the users file.

Next - homedir template file..

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-a1uumVP3ayr1MnJP6HE9
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
+++ libsepol-1.5.9.new/include/sepol/sepol.h	2005-06-19 00:57:33.000000000 -0400
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
@@ -16,20 +26,39 @@
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
+	void *data, size_t len, 
+	const char *usersdir,
+	void **newdata, size_t *newlen);
+
+static inline int sepol_genbools_policydb(
+	policydb_t* policydb, char *boolpath) {
+
+	return sepol_load_booleans(policydb, boolpath);
+}
+
+static inline int sepol_genusers_policydb( 
+	policydb_t* policydb, const char* usersdir) {
+
+	return sepol_load_users_file(policydb, usersdir);
+}
 
 /* Enable or disable deletion of users by sepol_genusers(3) when
    a user in original binary policy image is not defined by the
    new user configurations.  Defaults to disabled. */
-extern void sepol_set_delusers(int on);
+static inline void sepol_set_delusers(int on) {
+	sepol_set_delusers_policy(on);
+}
+
+/* ==== End backwards compatibility ==== */
 
 /* Set internal policydb from a file for subsequent service calls. */
 extern int sepol_set_policydb_from_file(FILE *fp);
@@ -39,4 +68,5 @@
 
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
+++ libsepol-1.5.9.new/include/sepol/users_file.h	2005-06-19 00:29:04.000000000 -0400
@@ -0,0 +1,39 @@
+#ifndef _SEPOL_USERS_FILE_H
+#define _SEPOL_USERS_FILE_H
+
+#include <sepol/user_config.h>
+#include <sepol/policydb.h>
+
+extern int sepol_load_users_file(
+	policydb_t* policydb,
+	const char* usersdir);
+
+extern int sepol_add_user_file(
+	policydb_t* policydb,
+	const char* usersdir,
+	user_config_t user);
+
+extern int sepol_del_user_file(
+	policydb_t* policydb,
+	const char* usersdir,
+	const char* username);
+
+extern int sepol_set_roles_file(
+	policydb_t* policydb,
+	const char* usersdir,
+	const char* username,
+	const char** roles);
+
+extern int sepol_add_role_file(
+	policydb_t* policydb,
+	const char* usersdir,
+	const char* username,
+	const char* role);
+
+extern int sepol_del_role_file(
+	policydb_t* policydb,
+	const char* usersdir,
+	const char* username,
+	const char* role);
+
+#endif
diff -Naur libsepol-1.5.9.orig/include/sepol/users_policy.h libsepol-1.5.9.new/include/sepol/users_policy.h
--- libsepol-1.5.9.orig/include/sepol/users_policy.h	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/include/sepol/users_policy.h	2005-06-19 00:52:34.000000000 -0400
@@ -0,0 +1,18 @@
+#ifndef __SEPOL_USERS_INTERNAL_H
+#define __SEPOL_USERS_INTERNAL_H
+
+#include <sepol/policydb.h>
+#include <sepol/user_config.h>
+
+/* Del users */
+extern void sepol_set_delusers_policy(int on);
+
+/* Clear unused users (before reloading policy */
+void sepol_clear_users_policy(policydb_t *policydb);
+
+/* Add/delete/load users from the policy */
+extern int sepol_add_user_policy(policydb_t *policydb, user_config_t user);
+extern int sepol_del_user_policy(policydb_t *policydb, const char *username);
+extern int sepol_load_user_policy(policydb_t *policydb, user_config_t user);
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
+++ libsepol-1.5.9.new/src/compatibility.c	2005-06-19 00:36:46.000000000 -0400
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
+	if (sepol_load_users_file(&policydb, usersdir) < 0)
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
+++ libsepol-1.5.9.new/src/debug.c	2005-06-19 21:47:29.000000000 -0400
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
+++ libsepol-1.5.9.new/src/libsepol.map	2005-06-19 00:36:06.000000000 -0400
@@ -1,4 +1,4 @@
 {
-  global: sepol_genbools*; sepol_set_policydb_from_file; sepol_check_context; sepol_genusers; sepol_debug; sepol_set_delusers;
+  global: sepol_*; policydb_*_image; policydb_destroy; uc_*;  
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
+++ libsepol-1.5.9.new/src/private.h	2005-06-19 19:02:55.000000000 -0400
@@ -4,6 +4,11 @@
 
 #include <byteswap.h>
 #include <endian.h>
+#include <sepol/policydb.h>
+
+#define SEPOL_EXIT 1
+#define SEPOL_SUCCESS 0
+#define SEPOL_ERR -1
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define cpu_to_le32(x) (x)
@@ -25,7 +30,9 @@
 };
 
 extern struct policydb_compat_info *policydb_lookup_compat(int version);
-extern void __sepol_debug_printf(const char *fmt, ...);
+
+__attribute__ ((format (printf, 1, 2))) 
+void __sepol_debug_printf(const char *fmt, ...);
 
 /* Reading from a policy "file". */
 static inline void *next_entry(struct policy_file * fp, size_t bytes)
diff -Naur libsepol-1.5.9.orig/src/record_file.c libsepol-1.5.9.new/src/record_file.c
--- libsepol-1.5.9.orig/src/record_file.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/src/record_file.c	2005-06-19 22:27:23.000000000 -0400
@@ -0,0 +1,343 @@
+#include <stdio.h>
+#include <stdio_ext.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <limits.h>
+#include <ctype.h>
+
+#include "record_file.h"
+#include "private.h"
+
+void record_dispose_line(parse_info_t* info) {
+	if (info->orig_line) {
+		free(info->orig_line);
+		info->orig_line = NULL;
+	}
+
+	if (info->working_copy) {
+		free(info->working_copy);
+		info->working_copy = NULL;
+	}
+
+	info->ptr = NULL;
+}
+
+char* record_fetch_string(parse_info_t* info) {
+	char* start = info->ptr;
+
+	while (*(info->ptr) && !isspace(*(info->ptr)))
+		info->ptr++;
+	*(info->ptr)++ = '\0';
+
+	return start;
+}
+
+int record_assert_noeof(parse_info_t* info) {
+	if (!info->ptr) {
+		__sepol_debug_printf("%s: unexpected end of file\n",
+			__FUNCTION__);
+		return SEPOL_ERR;
+	}
+	return SEPOL_SUCCESS;
+}
+
+int record_assert_space(parse_info_t* info) {
+	if (!isspace(*(info->ptr))) {
+		__sepol_debug_printf("%s: malformed line %u in %s: \n%s\n",
+			__FUNCTION__, info->lineno, info->filename,
+			info->orig_line);
+		return SEPOL_ERR;
+	}
+	return SEPOL_SUCCESS;
+}
+
+
+int record_assert_ch(parse_info_t* info, const char ch) {
+
+	if (record_assert_noeof(info) < 0)
+		return SEPOL_ERR;
+
+	if (*(info->ptr) != ch) {
+		__sepol_debug_printf("%s: malformed line %u in %s: \n%s\n"
+		"expected character \'%c\', but found \'%c\'\n", 
+		__FUNCTION__, info->lineno, info->filename, 
+		info->orig_line, ch, *(info->ptr));
+
+		return SEPOL_ERR;
+	}
+
+	return SEPOL_SUCCESS;
+}
+
+int record_assert_str(parse_info_t* info, const char* assert_str) {
+
+	if (record_assert_noeof(info) < 0)
+		return SEPOL_ERR;
+
+        if (strncasecmp(info->ptr, assert_str, strlen(assert_str))) {
+		__sepol_debug_printf("%s: malformed line %u in %s: \n%s\n"
+		"expected string \"%s\"\n",__FUNCTION__, 
+		info->lineno, info->filename, info->orig_line, assert_str);
+
+		return SEPOL_ERR;
+	}
+
+	info->ptr += strlen(assert_str);
+	return SEPOL_SUCCESS;
+}
+
+int record_skip_space(parse_info_t* info) {
+	unsigned int len = 0;
+	int lineno = info->lineno;
+	char* buffer = NULL;
+	char* ptr;
+
+	if (info->ptr) { 
+		while (*(info->ptr) && isspace(*(info->ptr)))
+			info->ptr++;
+		
+		if (*(info->ptr))
+			return SEPOL_SUCCESS;
+	}
+
+	record_dispose_line(info);
+
+	while (getline(&buffer, &len, info->file_stream) >= 0) {
+		lineno++;
+
+		/* Empty line */
+		if (len == 0) {
+			if (info->copy_stream)
+				fprintf(info->copy_stream, "\n"); 
+			goto next;
+		}
+
+		/* Eat newline, preceding whitespace */
+		if (buffer[len - 1] == '\n')
+			buffer[len - 1] = '\0';
+
+		ptr = buffer;
+		while (*ptr && isspace(*ptr))
+			ptr++;
+
+		/* Skip comments and blank lines */
+		if (!(*ptr) || *ptr == '#') {
+			if (info->copy_stream)			
+				fprintf(info->copy_stream, "%s", buffer);
+			goto next;
+		}
+
+		else {
+			char* tmp = strdup(buffer);
+			if (!tmp) {
+				__sepol_debug_printf("%s: out of memory\n", 
+					__FUNCTION__);
+				goto err;
+			}
+
+			info -> lineno = lineno;
+			info -> working_copy = buffer;
+			info -> len = len;
+			info -> orig_line = tmp;
+			info -> ptr = ptr;
+
+			return SEPOL_SUCCESS;
+		}
+	
+		next:	
+		free(buffer);
+		buffer = 0;
+	}
+
+	return SEPOL_SUCCESS;
+		
+	err:
+	if (buffer)
+		free(buffer);
+
+	return SEPOL_ERR;
+}
+
+static int process_records (
+	record_table_t* rtable, 
+	parse_info_t* info,
+	int (*handler) (record_t record, void* arg),
+	void* arg) {
+
+	record_t* record = NULL;
+	int status = 0;
+
+	while(!(status & RECORD_HANDLER_SIGEXIT)) { 
+
+		/* Create a record config structure */
+		record = rtable->create();
+		if (!record) {
+			__sepol_debug_printf("%s: out of memory\n", __FUNCTION__);
+			goto err;
+		}
+
+		status = rtable->parse(info, record);
+		if (status < 0) 
+			goto err;
+		else if (status == SEPOL_EXIT)
+			goto out;
+	
+		status = handler(record, arg); 
+
+		if (status & RECORD_HANDLER_SIGMATCH)
+			info -> match_found = 1;
+
+		if (status & RECORD_HANDLER_SIGERR) 
+			goto err;
+
+		if (info->copy_stream && ! (status & RECORD_HANDLER_SIGDEL))
+			rtable->print(record, info->copy_stream);
+
+		rtable->destroy(record);
+		record = NULL;
+	}
+
+	out:
+	if (record)
+		rtable->destroy(record);
+	return SEPOL_SUCCESS;
+
+	err:
+	if (record)
+		rtable->destroy(record);
+	return SEPOL_ERR;
+}
+
+static int open_file(parse_info_t* info, int copy_stream) {
+
+	info->file_stream = fopen(info->filename, "r");
+	if (!info->file_stream) {
+		 __sepol_debug_printf("%s: unable to open %s for reading: %s\n",
+			__FUNCTION__, info->filename, strerror(errno));
+		return SEPOL_ERR;
+	}
+	__fsetlocking(info->file_stream, FSETLOCKING_BYCALLER);
+
+	if (copy_stream) {
+		char tmp_file[PATH_MAX];   
+		snprintf(tmp_file, sizeof tmp_file, "%s.bak", info->filename);
+		
+		info->copy_stream = fopen(tmp_file, "a");
+		if (!info->copy_stream) {
+			__sepol_debug_printf("%s: unable to open %s for append: %s\n",
+				__FUNCTION__, tmp_file, strerror(errno));
+			fclose(info->file_stream);
+                	return SEPOL_ERR;
+        	}
+    	    __fsetlocking(info->copy_stream, FSETLOCKING_BYCALLER);
+	}
+
+	return SEPOL_SUCCESS;
+}
+
+static int close_file(parse_info_t* info, int err) {
+	fclose(info->file_stream);
+
+	if (info->copy_stream) {
+		char tmp_file[PATH_MAX];
+		snprintf(tmp_file, sizeof tmp_file, "%s.bak", info->filename);
+
+		fclose(info->copy_stream);
+		if (!info->match_found) {
+			remove(tmp_file);
+			__sepol_debug_printf("%s: unable to match record\n",
+         			__FUNCTION__);
+			errno = EIO;
+			return SEPOL_SUCCESS;
+		}
+		else if (err) { 
+			remove(tmp_file);
+			return SEPOL_SUCCESS;
+		}
+		else
+			return rename(tmp_file, info->filename);
+	}
+
+	return SEPOL_SUCCESS;
+}
+
+int record_iterate_file(
+	const char* filename,
+	record_table_t* rtable,
+	int (*handler) (record_t record, void* arg),
+	void* arg) { 
+
+	parse_info_t info;
+	info.filename = filename;
+	info.lineno = 0;
+	info.working_copy = NULL;
+	info.orig_line = NULL;
+	info.file_stream = NULL;
+	info.copy_stream = NULL;
+	info.len = 0;
+	info.match_found = 0;
+	info.ptr = NULL;
+
+	if (open_file(&info, 0) < 0)
+		goto err;
+
+	if (process_records(rtable, &info, handler, arg) < 0)
+		goto err;	
+
+	close_file(&info, 0);
+	return SEPOL_SUCCESS;
+
+err:
+	close_file(&info, 1);
+	return SEPOL_ERR;
+}
+
+int record_modify_file(
+	const char* filename, 
+	record_table_t* rtable,
+	int (*handler) (record_t record, void* arg),
+	void* arg) {
+
+	parse_info_t info;
+	info.filename = filename;
+	info.lineno = 0;
+	info.working_copy = NULL;
+	info.orig_line = NULL;
+	info.file_stream = NULL;
+	info.copy_stream = NULL;
+	info.len = 0;
+	info.match_found = 0;
+	info.ptr = NULL;
+
+	if (open_file(&info, 1) < 0)
+		goto err;
+
+	if (process_records(rtable, &info, handler, arg) < 0)
+		goto err;
+
+	return close_file(&info, 0);
+err:
+	close_file(&info, 1);
+        return SEPOL_ERR;
+}
+
+int record_addto_file(
+	const char* filename,
+	record_table_t* rtable,
+	record_t record) {
+
+	FILE* fp;
+
+	fp = fopen(filename, "a");
+	if (!fp) {
+		__sepol_debug_printf("%s: can't open %s for append: %s\n", 
+			__FUNCTION__, filename, strerror(errno));
+		return SEPOL_ERR;
+	}
+
+	fseek(fp, 0, SEEK_END);
+
+	rtable->print(record, fp);
+	fclose(fp);
+	return SEPOL_SUCCESS;
+}
diff -Naur libsepol-1.5.9.orig/src/record_file.h libsepol-1.5.9.new/src/record_file.h
--- libsepol-1.5.9.orig/src/record_file.h	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/src/record_file.h	2005-06-19 22:06:00.000000000 -0400
@@ -0,0 +1,73 @@
+#ifndef _SEPOL_RECORD_FILE_H
+#define _SEPOL_RECORD_FILE_H
+
+#ifndef RECORD_DEFINED
+typedef void* record_t;
+#define RECORD_DEFINED
+#endif
+
+#define RECORD_HANDLER_SIGOK 	0x0001
+#define RECORD_HANDLER_SIGERR	0x0002
+#define RECORD_HANDLER_SIGMATCH 0x0004
+#define RECORD_HANDLER_SIGDEL	0x0008
+#define RECORD_HANDLER_SIGEXIT  0x0010
+
+typedef struct parse_info {
+	unsigned int lineno;
+	char* orig_line;
+	char* working_copy;
+	char* ptr;
+	unsigned int len;
+	const char* filename;
+	FILE* file_stream;
+	FILE* copy_stream;
+	int match_found;
+} parse_info_t;
+
+typedef struct record_table {
+	record_t (*create) (void);
+	void (*destroy) (record_t record);
+	int (*parse) (parse_info_t* info, record_t record);
+	void (*print) (record_t record, FILE* str);
+} record_table_t;
+
+/*
+ * Iterate over all records in the given file,
+ * and invoke the handler with its given argument on each record.
+ * The handler is supplied a record_t structure containing
+ * the parsed data.
+ */
+
+int record_iterate_file(
+	const char* filename,
+	record_table_t* rtable,
+	int (*handler) (record_t record, void* arg), void* arg);
+
+/*
+ * Copy filename to filename.tmp, updating a particular record.
+ * Invoke the handler, which may update the record, or issue a
+ * delete signal. On failure, the tmp file is erased.
+ * On success, the tmp file replaces the old file.
+ */
+int record_modify_file(
+        const char* filename,
+        record_table_t* rtable,
+	int (*handler) (record_t record, void* arg), void* arg);
+
+/*
+ * Add a record to the config file (local) and to policy.
+ */
+int record_addto_file(
+	const char* filename,
+	record_table_t* rtable,
+	record_t record);
+
+void record_dispose_line(parse_info_t* info);
+int record_skip_space(parse_info_t* info);
+char* record_fetch_string(parse_info_t* info);
+int record_assert_noeof(parse_info_t* info);
+int record_assert_space(parse_info_t* info);
+int record_assert_ch(parse_info_t* info, const char ch);
+int record_assert_str(parse_info_t* info, const char* assert_str);
+
+#endif
diff -Naur libsepol-1.5.9.orig/src/user_config.c libsepol-1.5.9.new/src/user_config.c
--- libsepol-1.5.9.orig/src/user_config.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/src/user_config.c	2005-06-19 21:50:29.000000000 -0400
@@ -0,0 +1,157 @@
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
+		__sepol_debug_printf("%s: out of memory\n", 
+			__FUNCTION__);
+		return SEPOL_ERR;
+	}
+
+	r->role = strdup(role);
+	if (!role) {
+		__sepol_debug_printf("%s: out of memory\n", 
+			__FUNCTION__);
+		return SEPOL_ERR;
+	}
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
+			if (user->num_roles == 1) {
+				__sepol_debug_printf("%s: unable to delete"
+					"the last role for user %s\n", 
+					__FUNCTION__, uc_get_name(user));
+
+				return SEPOL_ERR;
+			}
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
diff -Naur libsepol-1.5.9.orig/src/users_file.c libsepol-1.5.9.new/src/users_file.c
--- libsepol-1.5.9.orig/src/users_file.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/src/users_file.c	2005-06-19 23:10:39.000000000 -0400
@@ -0,0 +1,480 @@
+#include <stdio.h>
+#include <stdio_ext.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <limits.h>
+#include <ctype.h>
+
+#include <sepol/policydb.h>
+#include <sepol/users_file.h>
+#include <sepol/user_config.h>
+#include <sepol/users_policy.h>
+
+#include "private.h"
+
+typedef user_config_t record_t;
+#define RECORD_DEFINED
+#include "record_file.h"
+
+#define MLS_MAX 40
+/* FIXME: what's the correct value */
+
+/*
+ * Print user record to the given stream 
+ */
+static void print_user(user_config_t user, FILE* str) {
+	const char *mls_level, *mls_range, *role, *def_role;
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
+static int parse_user(parse_info_t* info, user_config_t user) {
+
+	int islist = 0;
+	char mls[MLS_MAX];
+	int i;
+	
+	char* start;
+	
+	if (record_skip_space(info) < 0)
+		goto err;
+	if (!info->ptr)
+		goto last;
+	
+	/* Parse user name */
+	if (record_assert_str(info, "user") < 0)
+		goto err;
+	
+	if (record_assert_space(info) < 0)
+		goto err;
+
+	if (record_skip_space(info) < 0)
+		goto err;
+
+	if (record_assert_noeof(info) < 0)
+		goto err;
+
+	if (uc_set_name(user, record_fetch_string(info)) < 0)
+		goto err;
+
+	/* Parse roles header */
+	if (record_skip_space(info) < 0)
+		goto err;
+
+	if (record_assert_str(info,"roles") < 0)
+		goto err;
+
+	if (record_assert_space(info) < 0)
+		goto err;
+	
+	if (record_skip_space(info) < 0)
+		goto err;
+
+	if (record_assert_noeof(info) < 0)
+		goto err;
+
+	if (*(info->ptr) == '{') {
+		islist = 1;
+		info->ptr++;
+	} else
+		islist = 0;
+
+	/* For each role, loop */
+	do { 
+		if (record_skip_space(info) < 0)
+			goto err;
+		if (record_assert_noeof(info) < 0)
+			goto err;
+
+		start = info->ptr;
+		while (*(info->ptr) && *(info->ptr) != ';' 
+			&& *(info->ptr) != '}' && !isspace(*(info->ptr))) 
+			info->ptr++;
+		*(info->ptr)++ = '\0';
+	
+		if (uc_add_role(user, start) < 0)
+			goto err;
+
+		if (record_skip_space(info) < 0)
+			goto err;
+		if (record_assert_noeof(info) < 0)	
+			goto err;
+
+		if (*(info->ptr) == '}') 
+			islist = 0;
+
+	} while (islist);
+
+	/* Handle mls */
+	if (mls_enabled) {
+
+		/* Parse level header */
+		if (record_skip_space(info) < 0)
+			goto err;
+		if (record_assert_noeof(info) < 0)
+			goto err;
+
+		if (*(info->ptr) == ';')
+			goto out;
+
+		if (record_assert_str(info, "level") < 0)
+			goto err;
+
+		if (record_assert_space(info) < 0)
+			goto err;
+
+		if (record_skip_space(info) < 0)
+			goto err;
+		if (record_assert_noeof(info) < 0)
+			goto err;
+
+		/* Parse level, spaces are allowed */
+		do {
+			if (!isspace(info->ptr)) { 
+				if (i > (MLS_MAX - 2)) 
+					goto context_toobig;
+				mls[i++] = *(info->ptr);
+			}
+			info->ptr++;
+	
+			if (record_skip_space(info) < 0)
+				goto err;
+			if (record_assert_noeof(info) < 0)
+				goto err;
+
+		} while(!strncasecmp(info->ptr, "range", 5));
+
+		mls[i] = '\0';
+		i = 0;
+		if (uc_set_mls_level(user, mls) < 0)
+			goto err;
+
+		/* Parse range header */
+		if (record_assert_str(info, "range") < 0)
+			goto err;
+
+		if (record_assert_space(info) < 0)
+			goto err;
+
+		if (record_skip_space(info) < 0)
+			goto err;
+		if (record_assert_noeof(info) < 0)
+			goto err;
+
+		/* Parse range, spaces are allowed */
+                do {
+			if (!isspace(info->ptr)) {
+				if (i > (MLS_MAX - 2))
+					goto context_toobig;
+				mls[i++] = *(info->ptr);
+			}
+			(info->ptr)++;
+
+			if (record_skip_space(info) < 0)
+				goto err;
+			if (record_assert_noeof(info) < 0)
+				goto err;
+
+		} while(*(info->ptr) != ';');
+
+		mls[i] = '\0';
+		if (uc_set_mls_range(user, mls) < 0)
+			goto err;
+	}
+
+	out:
+	record_dispose_line(info);
+	return SEPOL_SUCCESS;
+
+	last:
+	return SEPOL_EXIT;
+
+	context_toobig:
+	__sepol_debug_printf("%s: MLS context is too long\n", 
+		__FUNCTION__);
+	record_dispose_line(info);
+	return SEPOL_ERR;
+
+	err:
+	record_dispose_line(info);
+	return SEPOL_ERR;
+}
+
+static record_table_t USER_RTABLE = {
+	.create  = uc_create,
+	.destroy = uc_destroy,
+	.parse   = parse_user,
+	.print   = print_user
+};
+
+typedef struct user_query {
+	const char* name;
+	policydb_t* policydb;
+} user_query_t;
+
+typedef struct role_query {
+	const char* name;
+	const char* role;
+	policydb_t* policydb;
+} role_query_t;
+
+typedef struct roles_query {
+	const char* name;
+	const char** roles;
+	policydb_t* policydb;
+} roles_query_t;
+
+static int user_load(user_config_t user, void* policydb_arg) {
+	policydb_t* policydb = (policydb_t*) policydb_arg;
+
+	if (sepol_load_user_policy(policydb, user) < 0)
+		return RECORD_HANDLER_SIGERR;
+	else
+		return RECORD_HANDLER_SIGOK;	
+}
+
+static int user_del(user_config_t user, void* query_arg) {	
+	int status = 0;
+	
+	user_query_t* query = (user_query_t*) query_arg;
+
+	if (!strcmp(uc_get_name(user), query->name))
+		status |= RECORD_HANDLER_SIGMATCH;
+
+	if (sepol_del_user_policy(query->policydb, query->name) < 0) {
+		status |= RECORD_HANDLER_SIGERR;
+		goto exit;
+	}
+	else
+		status |= RECORD_HANDLER_SIGDEL;
+
+	status |= RECORD_HANDLER_SIGOK;
+	exit:
+	return status;
+}
+
+static int user_add_role(user_config_t user, void* query_arg) {
+	int status = 0;
+
+	role_query_t* query = (role_query_t*) query_arg;
+
+	if (!strcmp(uc_get_name(user), query->name))
+		status |= RECORD_HANDLER_SIGMATCH;
+
+	if (uc_has_role(user, query->role))
+		goto exit;
+	
+	else if (uc_add_role(user, query->role) < 0) {
+		status |= RECORD_HANDLER_SIGERR;
+		goto exit;
+	}
+	
+	if (sepol_load_user_policy(query->policydb, user) < 0) {
+		status |= RECORD_HANDLER_SIGERR;
+		goto exit;
+	}
+
+	status |= RECORD_HANDLER_SIGOK;
+	exit:
+	return status;
+}
+
+static int user_del_role(user_config_t user, void* query_arg) {
+	int status = 0;
+	
+	role_query_t* query = (role_query_t*) query_arg;
+
+	if (!strcmp(uc_get_name(user), query->name))
+		status |= RECORD_HANDLER_SIGMATCH;
+
+	if (uc_del_role(user, query->role) < 0) {
+		status |= RECORD_HANDLER_SIGERR;
+		goto exit;
+	}
+
+	if (sepol_load_user_policy(query->policydb, user) < 0) {
+		status |= RECORD_HANDLER_SIGERR;
+		goto exit;
+	}
+	
+	status |= RECORD_HANDLER_SIGOK;
+	exit:	
+	return status;
+}
+
+static int user_set_roles(user_config_t user, void* query_arg) {
+	int status = 0;
+	const char** ptr;
+
+	roles_query_t* query = (roles_query_t*) query_arg;
+
+	if (!strcmp(uc_get_name(user), query->name))
+		status |= RECORD_HANDLER_SIGMATCH;
+
+	if (uc_reset_roles(user) < 0) {
+		status |= RECORD_HANDLER_SIGERR;
+		goto exit;
+	}
+		
+	ptr = query->roles;
+	while(ptr) {
+		if (uc_add_role(user, *ptr) < 0) {
+			status |= RECORD_HANDLER_SIGERR;
+			goto exit;
+		}
+		ptr++;
+	}
+
+	if (sepol_load_user_policy(query->policydb, user) < 0) {
+		status |= RECORD_HANDLER_SIGERR;
+		goto exit;
+	}
+
+	status |= RECORD_HANDLER_SIGOK;
+	exit:
+	return status;
+}
+
+int sepol_load_users_file( 
+	policydb_t* policydb, 
+	const char* usersdir) {
+
+	char path[PATH_MAX];
+
+	/* Clear unused users */
+	sepol_clear_users_policy(policydb);
+
+	/* Load base set of system users from the policy package. */
+	snprintf(path, sizeof path, "%s/system.users", usersdir);
+	if (record_iterate_file(path, &USER_RTABLE, 
+		user_load, (void*) policydb) < 0) {
+		return SEPOL_ERR;
+	}
+
+	/* Load local users */
+	snprintf(path, sizeof path, "%s/local.users", usersdir);
+	if (record_iterate_file(path, &USER_RTABLE,
+		user_load, (void*) policydb) < 0) {
+		return SEPOL_ERR;
+	}
+
+        return SEPOL_SUCCESS;
+}
+
+/* Add/delete users */
+
+int sepol_add_user_file(
+	policydb_t* policydb, 
+	const char* usersdir,
+	user_config_t user) {
+
+	char path[PATH_MAX];
+	snprintf(path, sizeof path, "%s/local.users", usersdir);
+
+	if (!(user_load(user, (void*) policydb) & RECORD_HANDLER_SIGOK)) 
+		return SEPOL_ERR; 
+
+	return record_addto_file(path, &USER_RTABLE, user);
+}
+
+int sepol_del_user_file(
+	policydb_t* policydb,
+        const char* usersdir, 
+	const char* username) {
+
+	user_query_t query;
+	char path[PATH_MAX];
+	snprintf(path, sizeof path, "%s/local.users", usersdir);
+
+	query.name = username;
+	query.policydb = policydb;
+
+	return record_modify_file(path, &USER_RTABLE,
+		user_del, (void*) &query);		
+}
+
+/* Role manipulation */
+int sepol_set_roles_file(
+	policydb_t* policydb, 
+	const char* usersdir,
+	const char* username, 
+	const char** roles) {
+
+	roles_query_t query;
+	char path[PATH_MAX];
+	snprintf(path, sizeof path, "%s/local.users", usersdir);
+
+	query.name = username;
+	query.policydb = policydb;
+	query.roles = roles;
+
+	return record_modify_file(path, &USER_RTABLE,
+		user_set_roles, (void*) &query);		
+}
+
+int sepol_add_role_file(
+	policydb_t* policydb, 
+	const char* usersdir,
+	const char* username, 
+	const char* role) {
+	
+	role_query_t query;
+	char path[PATH_MAX];
+
+	query.name = username;
+	query.policydb = policydb;
+	query.role = role;
+
+	snprintf(path, sizeof path, "%s/local.users", usersdir);
+	return record_modify_file(path, &USER_RTABLE,
+		user_add_role, (void*) &query);
+}
+
+int sepol_del_role_file(
+	policydb_t* policydb, 
+	const char* usersdir,
+	const char* username, 
+	const char* role) {
+
+	role_query_t query;
+	char path[PATH_MAX];
+	snprintf(path, sizeof path, "%s/local.users", usersdir);
+
+	query.name = username;
+	query.policydb = policydb;
+	query.role = role;
+
+	return record_modify_file(path, &USER_RTABLE,
+		user_del_role, (void*) &query);
+}
+
diff -Naur libsepol-1.5.9.orig/src/users_policy.c libsepol-1.5.9.new/src/users_policy.c
--- libsepol-1.5.9.orig/src/users_policy.c	1969-12-31 19:00:00.000000000 -0500
+++ libsepol-1.5.9.new/src/users_policy.c	2005-06-19 18:43:00.000000000 -0400
@@ -0,0 +1,345 @@
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
+void sepol_clear_users_policy(policydb_t* policydb) {
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
+int sepol_add_user_policy(policydb_t* policydb, user_config_t user) {
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
+		return sepol_load_user_policy(policydb, user);
+	}
+}
+
+/* Delete a user from the given policydb. This function will
+ * fail if the user does not exist. */
+
+int sepol_del_user_policy(policydb_t* policydb, const char* username) {
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
+int sepol_load_user_policy(policydb_t* policydb, user_config_t user) {
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
+			__sepol_debug_printf("%s: undefined role "
+				"%s for user %s\n", 
+				__FUNCTION__, role, name);
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
+					__sepol_debug_printf("%s:"
+					"  out of memory for %s\n", 
+					__FUNCTION__, name);
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

--=-a1uumVP3ayr1MnJP6HE9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
