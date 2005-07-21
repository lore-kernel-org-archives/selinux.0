Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LJ2LgA029338
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 15:02:21 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LIvhrg006606
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 18:57:43 GMT
Subject: Re: [ libsepol 3/6] Users
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42DFE632.1080001@tresys.com>
References: <1121967866.9844.32.camel@celtics.boston.redhat.com>
	 <42DFE632.1080001@tresys.com>
Content-Type: multipart/mixed; boundary="=-gBKpmDGYTpotUZB7+BvC"
Date: Thu, 21 Jul 2005 14:55:18 -0400
Message-Id: <1121972118.9844.81.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-gBKpmDGYTpotUZB7+BvC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> The libsemanage api I'm writing right now has num_roles, IMO better than 
> null termination in that it's easier to make mistakes with null termination

Attached is a new version with num_roles.



--=-gBKpmDGYTpotUZB7+BvC
Content-Disposition: attachment; filename=libsepol-2.1-users.diff
Content-Type: text/x-patch; name=libsepol-2.1-users.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -p -aru libsepol.work/include/sepol/users.h libsepol-2.1-users/include/sepol/users.h
--- libsepol.work/include/sepol/users.h	2005-07-04 06:37:59.000000000 -0400
+++ libsepol-2.1-users/include/sepol/users.h	2005-07-21 14:51:14.000000000 -0400
@@ -0,0 +1,54 @@
+#ifndef _SEPOL_USERS_H_
+#define _SEPOL_USERS_H_
+
+#include <sepol/policydb.h>
+#include <sys/types.h>
+
+/* High level representation of a user */
+typedef struct sepol_uinfo {
+	const char* name;
+	const char** roles;
+	size_t num_roles;
+	const char* mls_level;
+	const char* mls_range;
+} sepol_uinfo_t;
+
+/* Clear unused users */
+extern void sepol_clear_unused_users(
+	policydb_t* policydb);
+
+/* Add/delete/load users from the policy 
+   Load allows duplicates, but add does not. */
+extern int sepol_user_add(
+	policydb_t* policydb,
+	sepol_uinfo_t* user); 
+
+extern int sepol_user_del(
+	policydb_t* policydb, 
+	const char *username);
+
+extern int sepol_user_load(
+	policydb_t* policydb, 
+	sepol_uinfo_t* user);
+
+/* Check if users or roles are valid */
+extern int sepol_user_is_valid(
+	policydb_t* policydb,
+	const char* user);
+
+extern int sepol_role_is_valid(
+	policydb_t* policydb,
+	const char* role);
+
+/* Obtain an array of all valid users/roles */
+extern int sepol_get_valid_users(
+	policydb_t* policydb,
+	char*** users,
+	size_t* nusers);
+
+extern int sepol_get_valid_roles(
+	policydb_t* policydb, 
+	char*** roles, 
+	size_t* nroles);
+
+#endif /* _SEPOL_USERS_H_ */
diff -p -aru libsepol.work/src/genusers.c libsepol-2.1-users/src/genusers.c
--- libsepol.work/src/genusers.c	2005-07-18 15:05:30.000000000 -0400
+++ libsepol-2.1-users/src/genusers.c	2005-07-20 09:42:58.000000000 -0400
@@ -30,12 +30,7 @@ void __sepol_debug_printf(const char *fm
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
@@ -382,7 +377,7 @@ int sepol_genusers(void *data, size_t le
 		goto err;
 	}
 
-	if (delusers) {
+	if (selinux_delusers) {
 		/* Kill unused users and remap to avoid holes. */
 		ebitmap_init(&free_users);
 		kud.policydb = &policydb;
diff -p -aru libsepol.work/src/users.c libsepol-2.1-users/src/users.c
--- libsepol.work/src/users.c	2005-07-04 06:38:26.000000000 -0400
+++ libsepol-2.1-users/src/users.c	2005-07-21 14:51:22.000000000 -0400
@@ -0,0 +1,413 @@
+#include <stdlib.h>
+
+#include "private.h"
+#include "debug.h"
+
+#include <sepol/sepol.h>
+#include <sepol/policydb.h>
+#include <sepol/mls.h>
+#include <sepol/users.h>
+#include <sys/types.h>
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
+int sepol_user_add(policydb_t* policydb, sepol_uinfo_t* user) {
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
+	if (sepol_user_load(policydb, user) < 0) 
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
+int sepol_user_del(policydb_t* policydb, const char* username) {
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
+	omem:
+	DEBUG(__FUNCTION__, "out of memory\n");
+
+	err:
+	DEBUG(__FUNCTION__, "could not remove %s from policy\n", name);
+	free(name);
+	return STATUS_ERR;
+}
+
+/* Load a user into policydb. The user may exist already, in
+ * which case the supplied data replaces the existing data. Alternatively,
+ * the user could be new. */
+
+int sepol_user_load(policydb_t* policydb, sepol_uinfo_t* user) {
+
+	/* For user data */
+	char *name = NULL, *role = NULL, 
+	     *mls_level = NULL, *mls_range = NULL,
+	     *key = NULL;
+	user_datum_t* usrdatum = NULL;
+	role_datum_t* roldatum;
+	int i;
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
+	for (i = 0; i < user->num_roles; i++) {
+		role = strdup(user->roles[i]);
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
+	if (mls_enabled) {
+		context_init(&context);
+
+		/* MLS level */
+		if (user->mls_level == NULL) {
+			DEBUG(__FUNCTION__, "mls is enabled, but no mls "
+					"level found for user %s\n", 
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
+			DEBUG(__FUNCTION__, "mls is enabled, but no "
+				"mls range found for user %s\n", name);
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
+/* Check if a user is valid */
+
+int sepol_user_is_valid(policydb_t* policydb, const char* user) {
+	int status;	
+	char* user_copy = strdup(user);
+	if (!user_copy) {
+		DEBUG(__FUNCTION__, "out of memory, user check failed\n");
+		return STATUS_ERR;
+	}
+	
+	status = hashtab_search(policydb->p_users.table, user_copy) != NULL;
+	free(user_copy);
+	return status;
+}
+
+/* Check if a role is valid */
+
+int sepol_role_is_valid(policydb_t* policydb, const char* role) {
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
+/* Fill an array with all valid users */
+
+int sepol_get_valid_users(policydb_t* policydb, char*** users, size_t* nusers) {
+	size_t tmp_nusers = policydb->p_users.nprim;
+	char **tmp_users = (char**) malloc(tmp_nusers * sizeof(char*));
+	char **ptr;
+	size_t i;
+	if (!tmp_users)
+		goto omem;
+	
+	for (i = 0; i < tmp_nusers; i++) {
+		tmp_users[i] = strdup(policydb->p_user_val_to_name[i]);
+		if (!tmp_users[i])
+			goto omem;
+	}
+
+	*nusers = tmp_nusers;
+	*users = tmp_users;
+
+	return STATUS_SUCCESS;
+
+	omem:
+	DEBUG(__FUNCTION__, "out of memory, could not "
+		"allocate list of valid users\n");
+
+	ptr = tmp_users;
+	while (ptr && *ptr) 
+		free(*ptr++);
+	free(tmp_users);
+	return STATUS_ERR;
+}
+
+/* Fill an array with all valid roles */
+
+int sepol_get_valid_roles(policydb_t* policydb, char*** roles, size_t* nroles) {
+	size_t tmp_nroles = policydb->p_roles.nprim;
+	char **tmp_roles = (char**) malloc(tmp_nroles * sizeof(char*));
+	char **ptr;
+	size_t i;
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

--=-gBKpmDGYTpotUZB7+BvC--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
