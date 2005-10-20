Message-ID: <4357F76A.7040009@cornell.edu>
Date: Thu, 20 Oct 2005 16:00:42 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Reorganize users.c
References: <4357F5DF.30905@cornell.edu>
In-Reply-To: <4357F5DF.30905@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------020108030007080206020202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020108030007080206020202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> - makes is_valid/exists function update a parameter, rather than 
> mixing response and return status code
Oops...forgot to initialize status in the success path. Corrected patch 
attach (gets rid of the variable).



--------------020108030007080206020202
Content-Type: text/x-patch;
 name="libsepol.reorganize_users.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.reorganize_users.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/users_policydb.c new/libsemanage/src/users_policydb.c
--- old/libsemanage/src/users_policydb.c	2005-10-18 10:53:30.000000000 -0400
+++ new/libsemanage/src/users_policydb.c	2005-10-20 15:44:20.000000000 -0400
@@ -22,7 +22,7 @@ extern record_table_t SEPOL_USER_RTABLE;
 
 /* USER RECRORD (SEPOL): POLICYDB extension: method table */
 record_policydb_table_t SEMANAGE_USER_POLICYDB_RTABLE = {
-	.add         = sepol_user_add,
+	.add         = NULL, /* FIXME */
 	.modify      = sepol_user_modify,
 	.iterate     = sepol_user_iterate,
 };
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/roles.h new/libsepol/include/sepol/roles.h
--- old/libsepol/include/sepol/roles.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsepol/include/sepol/roles.h	2005-10-20 15:41:22.000000000 -0400
@@ -0,0 +1,14 @@
+#ifndef _SEPOL_ROLES_H_
+#define _SEPOL_ROLES_H_
+
+extern int sepol_role_exists(
+	sepol_policydb_t* policydb,
+	const char* role,
+	int* response);
+
+extern int sepol_role_list(
+	sepol_policydb_t* policydb,
+	char*** roles,
+	size_t* nroles);
+
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/users.h new/libsepol/include/sepol/users.h
--- old/libsepol/include/sepol/users.h	2005-10-07 16:45:17.000000000 -0400
+++ new/libsepol/include/sepol/users.h	2005-10-20 15:41:42.000000000 -0400
@@ -9,35 +9,27 @@
 extern void sepol_clear_unused_users(
 	sepol_policydb_t* policydb);
 
-/* Add/delete/load users from the policy 
-   Load allows duplicates, but add does not. */
-extern int sepol_user_add(
-	sepol_policydb_t* policydb,
-	sepol_user_t* user); 
-
+/* Delete the user */
 extern int sepol_user_del(
 	sepol_policydb_t* policydb, 
 	const char *username);
 
+/* Add the user if missing, or modify otherwise */
 extern int sepol_user_modify(
 	sepol_policydb_t* policydb, 
 	sepol_user_t* user);
 
-/* Check if users or roles are valid */
-extern int sepol_user_is_valid(
-	sepol_policydb_t* policydb,
-	const char* user);
-
-extern int sepol_role_is_valid(
+/* Check if the specified user exists */
+extern int sepol_user_exists(
 	sepol_policydb_t* policydb,
-	const char* role);
+	const char* user,
+	int* response);
 
 /* Iterate the users
  * The handler may return:
  * -1 to signal an error condition,
  * 1 to signal successful exit
  * 0 to signal continue */
-
 extern int sepol_user_iterate(
 	sepol_policydb_t* policydb,
 	int (*fn)(
@@ -45,9 +37,4 @@ extern int sepol_user_iterate(
 		void* fn_arg),
 	void* arg);
 
-extern int sepol_get_valid_roles(
-	sepol_policydb_t* policydb, 
-	char*** roles, 
-	size_t* nroles);
-
 #endif 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/libsepol.map new/libsepol/src/libsepol.map
--- old/libsepol/src/libsepol.map	2005-10-18 10:08:39.000000000 -0400
+++ new/libsepol/src/libsepol.map	2005-10-20 15:41:55.000000000 -0400
@@ -20,7 +20,7 @@
 	sepol_link_modules; sepol_expand_module;
 	sepol_bool*; sepol_context*;
 	sepol_iface*; sepol_port*; sepol_user*; sepol_clear_unused_users;
-	sepol_role_is_valid; sepol_set_delusers;
+	sepol_set_delusers;
 	sepol_msg_*; sepol_handle_*;
   local: *;
 };
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/roles.c new/libsepol/src/roles.c
--- old/libsepol/src/roles.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsepol/src/roles.c	2005-10-20 15:57:44.000000000 -0400
@@ -0,0 +1,60 @@
+#include <stdlib.h>
+#include <sepol/policydb/policydb.h>
+#include "debug.h"
+
+/* Check if a role exists */
+int sepol_role_exists(
+	sepol_policydb_t* p, 
+	const char* role,
+	int* response) {
+
+  	policydb_t *policydb = &p->p;
+	char* role_copy = strdup(role);
+	if (!role_copy) {
+		DEBUG(__FUNCTION__, "out of memory, role check failed\n");
+		return STATUS_ERR;
+	}
+
+	*response = (hashtab_search(policydb->p_roles.table, role_copy) != NULL);
+	free(role_copy);
+	return STATUS_SUCCESS;
+}
+
+
+/* Fill an array with all valid roles */
+int sepol_role_list(
+	sepol_policydb_t* p, 
+	char*** roles, 
+	size_t* nroles) {
+
+	policydb_t *policydb = &p->p;
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
+
+
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2005-10-07 16:45:46.000000000 -0400
+++ new/libsepol/src/users.c	2005-10-20 15:58:12.000000000 -0400
@@ -79,43 +79,6 @@ void sepol_clear_unused_users(sepol_poli
         }
 }
 
-/* Add a user to the given policydb. The user may not exist already */
-
-int sepol_user_add(sepol_policydb_t* p, sepol_user_t* user) {
-
-	char* name = NULL;
-	user_datum_t* usrdatum;
-	policydb_t *policydb = &p->p;
-
-	/* See if a user exists */
-	name = strdup(sepol_user_get_name(user));
-	if (!name) 
-		goto omem;
-
-        usrdatum = hashtab_search(policydb->p_users.table, name);
-
-	/* If it does, fail */
-	if (usrdatum) {
-		DEBUG(__FUNCTION__,"%s is already in policy\n", name);
-		goto err;
-	}
-	
-	if (sepol_user_modify(p, user) < 0) 
-		goto err;
-
-	free(name);
-	return STATUS_SUCCESS;
-
-	omem:
-	DEBUG(__FUNCTION__, "out of memory\n");
-
-	err:
-	DEBUG(__FUNCTION__, "could not add %s to policy\n", 
-		sepol_user_get_name(user));
-	free(name);
-	return STATUS_ERR;
-}
-
 /* Delete a user from the given policydb. This function will
  * fail if the user does not exist. */
 
@@ -337,34 +300,21 @@ int sepol_user_modify(sepol_policydb_t* 
 
 /* Check if a user is valid */
 
-int sepol_user_is_valid(sepol_policydb_t* p, const char* user) {
+int sepol_user_exists(
+	sepol_policydb_t* p, 
+	const char* user,
+	int* response) {
+
 	policydb_t *policydb = &p->p;
-	int status;	
 	char* user_copy = strdup(user);
 	if (!user_copy) {
 		DEBUG(__FUNCTION__, "out of memory, user check failed\n");
 		return STATUS_ERR;
 	}
 	
-	status = hashtab_search(policydb->p_users.table, user_copy) != NULL;
+	*response = (hashtab_search(policydb->p_users.table, user_copy) != NULL);
 	free(user_copy);
-	return status;
-}
-
-/* Check if a role is valid */
-
-int sepol_role_is_valid(sepol_policydb_t* p, const char* role) {
-  	policydb_t *policydb = &p->p;
-	int status;
-	char* role_copy = strdup(role);
-	if (!role_copy) {
-		DEBUG(__FUNCTION__, "out of memory, role check failed\n");
-		return STATUS_ERR;
-	}
-
-	status = hashtab_search(policydb->p_roles.table, role_copy) != NULL;
-	free(role_copy);
-	return status;
+	return STATUS_SUCCESS;
 }
 
 /* Fill an array with all valid users */
@@ -458,36 +408,3 @@ int sepol_user_iterate(
 	sepol_user_free(user);
 	return STATUS_ERR;
 }
-
-/* Fill an array with all valid roles */
-
-int sepol_get_valid_roles(sepol_policydb_t* p, char*** roles, size_t* nroles) {
-	policydb_t *policydb = &p->p;
-	size_t tmp_nroles = policydb->p_roles.nprim;
-	char **tmp_roles = (char**) malloc(tmp_nroles * sizeof(char*));
-	char **ptr;
-	size_t i;
-	if (!tmp_roles) 
-		goto omem;
-
-	for (i =0; i < tmp_nroles; i++) {
-		tmp_roles[i] = strdup(policydb->p_role_val_to_name[i]);
-		if (!tmp_roles[i]) 
-			goto omem;
-	}	 
-
-	*nroles = tmp_nroles;
-	*roles = tmp_roles;
-
-        return STATUS_SUCCESS;
-
-	omem:
-	DEBUG(__FUNCTION__, "out of memory, could not "
-		"allocate list of valid roles\n");
-	
-	ptr = tmp_roles;
-	while (ptr && *ptr) 
-		free(*ptr++);
-	free(tmp_roles);
-	return STATUS_ERR;
-}

--------------020108030007080206020202--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
