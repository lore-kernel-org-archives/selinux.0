Message-ID: <43BE8C6C.7080803@cornell.edu>
Date: Fri, 06 Jan 2006 10:27:40 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEPOL] Const in APIs (2)
Content-Type: multipart/mixed;
 boundary="------------080806050102010704000400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080806050102010704000400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Remove malloc nonsense due to non-const hashtab keys.

Note: I don't understand how symtab_init can get away with initializing 
a comparator/hasher with non-const keys. I specifically marked those 
const in hashtab_init, but that doesn't seem to cause any warnings.




--------------080806050102010704000400
Content-Type: text/x-patch;
 name="libsepol.const_api2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.const_api2.diff"

diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/include/sepol/policydb/hashtab.h new/libsepol/include/sepol/policydb/hashtab.h
--- old/libsepol/include/sepol/policydb/hashtab.h	2005-10-07 16:45:17.000000000 -0400
+++ new/libsepol/include/sepol/policydb/hashtab.h	2006-01-06 10:15:09.000000000 -0500
@@ -52,13 +52,17 @@ typedef hashtab_val_t *hashtab_t;
    Returns NULL if insufficent space is available or
    the new hash table otherwise.
  */
-extern hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
-						     hashtab_key_t key),
-			 int (*keycmp) (hashtab_t h,
-					hashtab_key_t key1,
-					hashtab_key_t key2),
-			 unsigned int size);
-
+extern hashtab_t hashtab_create(
+	unsigned int (*hash_value) (
+		hashtab_t h,
+		const hashtab_key_t key),
+
+	int (*keycmp) (
+		hashtab_t h,
+		const hashtab_key_t key1,
+		const hashtab_key_t key2),
+	
+	unsigned int size);
 /*
    Inserts the specified (key, datum) pair into the specified hash table.
 
@@ -103,7 +107,9 @@ extern int hashtab_replace(hashtab_t h, 
    Returns NULL if no entry has the specified key or
    the datum of the entry otherwise.
  */
-extern hashtab_datum_t hashtab_search(hashtab_t h, hashtab_key_t k);
+extern hashtab_datum_t hashtab_search(
+	hashtab_t h, 
+	const hashtab_key_t k);
 
 /*
    Destroys the specified hash table.
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/src/hashtab.c new/libsepol/src/hashtab.c
--- old/libsepol/src/hashtab.c	2005-10-07 16:45:46.000000000 -0400
+++ new/libsepol/src/hashtab.c	2006-01-06 10:10:47.000000000 -0500
@@ -11,13 +11,17 @@
 #include <string.h>
 #include <sepol/policydb/hashtab.h>
 
-hashtab_t hashtab_create(unsigned int (*hash_value) (hashtab_t h,
-						     hashtab_key_t key),
-			 int (*keycmp) (hashtab_t h,
-					hashtab_key_t key1,
-					hashtab_key_t key2),
-			 unsigned int size)
-{
+hashtab_t hashtab_create(
+	unsigned int (*hash_value) (
+		hashtab_t h,
+		const hashtab_key_t key),
+
+	int (*keycmp) (
+		hashtab_t h,
+		const hashtab_key_t key1,
+		const hashtab_key_t key2),
+		unsigned int size) {
+
 	hashtab_t p;
 	unsigned int i;
 
@@ -165,13 +169,13 @@ int hashtab_replace(hashtab_t h, hashtab
 }
 
 
-hashtab_datum_t
-hashtab_search(hashtab_t h, hashtab_key_t key)
-{
+hashtab_datum_t hashtab_search(
+	hashtab_t h, 
+	const hashtab_key_t key) {
+
 	int hvalue;
 	hashtab_ptr_t cur;
 
-
 	if (!h)
 		return NULL;
 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/src/roles.c new/libsepol/src/roles.c
--- old/libsepol/src/roles.c	2005-10-26 09:34:29.000000000 -0400
+++ new/libsepol/src/roles.c	2006-01-06 10:09:00.000000000 -0500
@@ -2,6 +2,7 @@
 #include <string.h>
 #include <stddef.h>
 
+#include <sepol/policydb/hashtab.h>
 #include <sepol/policydb/policydb.h>
 
 #include "debug.h"
@@ -15,14 +16,10 @@ int sepol_role_exists(
 	int* response) {
 
   	policydb_t *policydb = &p->p;
-	char* role_copy = strdup(role);
-	if (!role_copy) {
-		ERR(handle, "out of memory, role check failed");
-		return STATUS_ERR;
-	}
+	*response = (hashtab_search(policydb->p_roles.table, 
+		(const hashtab_key_t) role) != NULL);
 
-	*response = (hashtab_search(policydb->p_roles.table, role_copy) != NULL);
-	free(role_copy);
+	handle = NULL;
 	return STATUS_SUCCESS;
 }
 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/src/symtab.c new/libsepol/src/symtab.c
--- old/libsepol/src/symtab.c	2005-10-07 16:45:46.000000000 -0400
+++ new/libsepol/src/symtab.c	2006-01-06 10:11:44.000000000 -0500
@@ -8,6 +8,7 @@
  */
 
 #include <string.h>
+#include <sepol/policydb/hashtab.h>
 #include <sepol/policydb/symtab.h>
 
 static unsigned int symhash(hashtab_t h, hashtab_key_t key)
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2006-01-06 09:36:28.000000000 -0500
+++ new/libsepol/src/users.c	2006-01-06 10:08:46.000000000 -0500
@@ -7,6 +7,7 @@
 #include "handle.h"
 
 #include <sepol/policydb/policydb.h>
+#include <sepol/policydb/hashtab.h>
 #include <sepol/policydb/expand.h>
 #include "user_internal.h"
 #include "mls.h"
@@ -108,11 +109,10 @@ int sepol_user_modify(
 
 	/* For user data */	
 	const char *cname, *cmls_level, *cmls_range;
-	char *name = NULL, *mls_level = NULL, *mls_range = NULL;
+	char *name = NULL;
 
 	const char **roles = NULL;
 	size_t num_roles = 0;
-	char *role = NULL;
 
 	/* Low-level representation */
 	user_datum_t* usrdatum = NULL;
@@ -127,22 +127,17 @@ int sepol_user_modify(
 
 	/* First, extract all the data */
 	sepol_user_key_unpack(key, &cname);
-	name = strdup(cname);
 
 	cmls_level = sepol_user_get_mlslevel(user);
 	cmls_range = sepol_user_get_mlsrange(user);
-	mls_level = cmls_level? strdup(cmls_level): NULL;
-	mls_range = cmls_range? strdup(cmls_range): NULL;
 
 	/* Make sure that worked properly */
 	if (sepol_user_get_roles(handle, user, &roles, &num_roles) < 0)
 		goto err;
 
-	if (!name || (cmls_level && !mls_level) || (cmls_range && !mls_range))
-		goto omem;
-		
 	/* Now, see if a user exists */
-	usrdatum = hashtab_search(policydb->p_users.table, name);
+	usrdatum = hashtab_search(policydb->p_users.table, 
+		(const hashtab_key_t) cname);
 
 	/* If it does, we will modify it */
 	if (usrdatum) {
@@ -163,15 +158,13 @@ int sepol_user_modify(
 
 	/* For every role */
 	for (i = 0; i < num_roles; i++) {
-		char* role = strdup(roles[i]);
-		if (!role)
-			goto omem;
 
 		/* Search for the role */
-		roldatum = hashtab_search(policydb->p_roles.table, role);
+		roldatum = hashtab_search(policydb->p_roles.table, 
+			(const hashtab_key_t) roles[i]);
 		if (!roldatum) {
 			ERR(handle, "undefined role %s for user %s", 
-				role, name);
+				roles[i], cname);
 			goto err;	
 		}
 
@@ -183,47 +176,44 @@ int sepol_user_modify(
 					goto omem;
 			}
 		}
-		
-		free(role);
-		role = NULL;
 	}
 
 	/* For MLS systems */
 	if (policydb->mls) {
 
 		/* MLS level */
-		if (mls_level == NULL) {
+		if (cmls_level == NULL) {
 			ERR(handle, "MLS is enabled, but no MLS "
-				"default level was defined for user %s", name);
+				"default level was defined for user %s", cname);
 			goto err;
 		}
 		
 		context_init(&context);
-		if (mls_from_string(handle, policydb, mls_level, &context) < 0) {
+		if (mls_from_string(handle, policydb, cmls_level, &context) < 0) {
 			context_destroy(&context);
 			goto err;
 		}
 		if (mls_level_cpy(&usrdatum->dfltlevel, &context.range.level[0]) < 0) {
-			ERR(handle, "could not copy MLS level %s", mls_level); 
+			ERR(handle, "could not copy MLS level %s", cmls_level); 
 			context_destroy(&context);
 			goto err;
 		}
 		context_destroy(&context);			
 	
 		/* MLS range */
-		if (mls_range == NULL) {
+		if (cmls_range == NULL) {
 			ERR(handle, "MLS is enabled, but no MLS"
-				"range was defined for user %s", name);
+				"range was defined for user %s", cname);
 			goto err;
 		}	
 		
 		context_init(&context);
-		if (mls_from_string(handle, policydb, mls_range, &context) < 0) {
+		if (mls_from_string(handle, policydb, cmls_range, &context) < 0) {
 			context_destroy(&context);
 			goto err;
 		}
 		if (mls_range_cpy(&usrdatum->range, &context.range) < 0) {
-			ERR(handle, "could not copy MLS range %s", mls_range);
+			ERR(handle, "could not copy MLS range %s", cmls_range);
 			context_destroy(&context);
 			goto err;
 		}
@@ -247,6 +237,11 @@ int sepol_user_modify(
 			goto omem;
 		policydb->sym_val_to_name[SYM_USERS] = tmp_ptr;
 
+		/* Need to copy the user name */
+		name = strdup(cname);
+		if (!name) 
+			goto omem;
+
 		/* Store user */
 		usrdatum->value = ++policydb->p_users.nprim;
 		if (hashtab_insert(policydb->p_users.table, name, 
@@ -265,10 +260,7 @@ int sepol_user_modify(
 		}
 	}	
 
-	free(name);
 	free(roles);
-	free(mls_range);
-	free(mls_level);
 	return STATUS_SUCCESS;
 
 	omem:
@@ -278,10 +270,7 @@ int sepol_user_modify(
 	ERR(handle, "could not load %s into policy", name);
 
 	free(name);
-	free(role);
 	free(roles);
-	free(mls_range);
-	free(mls_level);
 	if (new && usrdatum) {
 		role_set_destroy(&usrdatum->roles);
 		free(usrdatum);
@@ -298,17 +287,12 @@ int sepol_user_exists(
 	const policydb_t* policydb = &p->p;
 
 	const char* cname;	
-	char* name = NULL;
 	sepol_user_key_unpack(key, &cname);
-	name = strdup(cname);	
 
-	if (!name) {
-		ERR(handle, "out of memory, user check failed");
-		return STATUS_ERR;
-	}
-	
-	*response = (hashtab_search(policydb->p_users.table, name) != NULL);
-	free(name);
+	*response = (hashtab_search(policydb->p_users.table, 
+		(const hashtab_key_t) cname) != NULL);
+
+	handle = NULL;
 	return STATUS_SUCCESS;
 }
 
@@ -334,16 +318,10 @@ int sepol_user_query(
 	user_datum_t* usrdatum = NULL;
 
 	const char* cname;
-	char* name = NULL;
 	sepol_user_key_unpack(key, &cname);
-	name = strdup(cname);
 
-	if (!name) 
-		goto omem;
-
-	usrdatum = hashtab_search(policydb->p_users.table, name);
-	free(name);
-	name = NULL;
+	usrdatum = hashtab_search(policydb->p_users.table, 
+		(const hashtab_key_t) cname);
 
 	if (!usrdatum) {
 		*response = NULL;
@@ -356,12 +334,8 @@ int sepol_user_query(
 
 	return STATUS_SUCCESS;
 
-	omem:
-	ERR(handle, "out of memory");
-
 	err:
 	ERR(handle, "could not query user %s", cname);
-	free(name);
 	return STATUS_ERR;
 }
 

--------------080806050102010704000400--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
