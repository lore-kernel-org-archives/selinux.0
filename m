Message-ID: <435903C2.2050805@cornell.edu>
Date: Fri, 21 Oct 2005 11:05:38 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL ] Further users cleanup
Content-Type: multipart/mixed;
 boundary="------------080500040706050304010103"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080500040706050304010103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

- remove select/kill/clear_unused things (will only be used in genusers)
- remove delete (all changes will be additive for now, through semanage)

- move delusers things into genusers.c
- move genusers/genbools prototypes from sepol.h into their respective 
headers

- map: remove sepol_clear_unused_users
- map: remove duplicate sepol_set_delusers (it's in there twice) 

--------------080500040706050304010103
Content-Type: text/x-patch;
 name="libsepol.user_cleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.user_cleanup.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/booleans.h new/libsepol/include/sepol/booleans.h
--- old/libsepol/include/sepol/booleans.h	2005-10-07 16:45:17.000000000 -0400
+++ new/libsepol/include/sepol/booleans.h	2005-10-21 10:58:33.000000000 -0400
@@ -5,6 +5,28 @@
 #include <sepol/policydb.h>
 #include <sepol/boolean_record.h>
 
+/*--------------compatibility--------------*/
+
+/* Given an existing binary policy (starting at 'data', with length 'len')
+   and a boolean configuration file named by 'boolpath', rewrite the binary
+   policy for the boolean settings in the boolean configuration file.
+   The binary policy is rewritten in place in memory.
+   Returns 0 upon success, or -1 otherwise. */
+extern int sepol_genbools(
+	void *data, size_t len, 
+	char *boolpath);
+
+/* Given an existing binary policy (starting at 'data', with length 'len')
+   and boolean settings specified by the parallel arrays ('names', 'values')
+   with 'nel' elements, rewrite the binary policy for the boolean settings.
+   The binary policy is rewritten in place in memory.
+   Returns 0 upon success or -1 otherwise. */
+extern int sepol_genbools_array(
+	void *data, size_t len, 
+	char **names, int *values, 
+	int nel);
+/*---------------end compatbility------------*/
+
 /* Load a boolean into the policy */
 extern int sepol_bool_load (
 	sepol_policydb_t* policydb, 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/sepol.h new/libsepol/include/sepol/sepol.h
--- old/libsepol/include/sepol/sepol.h	2005-10-13 13:06:06.000000000 -0400
+++ new/libsepol/include/sepol/sepol.h	2005-10-21 10:58:26.000000000 -0400
@@ -19,33 +19,6 @@
 #include <sepol/policydb.h>
 #include <sepol/module.h>
 
-/* Given an existing binary policy (starting at 'data', with length 'len')
-   and a boolean configuration file named by 'boolpath', rewrite the binary
-   policy for the boolean settings in the boolean configuration file.
-   The binary policy is rewritten in place in memory.
-   Returns 0 upon success, or -1 otherwise. */
-extern int sepol_genbools(void *data, size_t len, char *boolpath);
-
-/* Given an existing binary policy (starting at 'data', with length 'len')
-   and boolean settings specified by the parallel arrays ('names', 'values')
-   with 'nel' elements, rewrite the binary policy for the boolean settings.  
-   The binary policy is rewritten in place in memory.
-   Returns 0 upon success or -1 otherwise. */
-extern int sepol_genbools_array(void *data, size_t len, char **names, int *values, int nel);
-
-/* Given an existing binary policy (starting at 'data with length 'len')
-   and user configurations living in 'usersdir', generate a new binary
-   policy for the new user configurations.  Sets '*newdata' and '*newlen'
-   to refer to the new binary policy image. */
-extern int sepol_genusers(void *data, size_t len,
-			  const char *usersdir,
-			  void **newdata, size_t *newlen);
-
-/* Enable or disable deletion of users by sepol_genusers(3) when
-   a user in original binary policy image is not defined by the
-   new user configurations.  Defaults to disabled. */
-extern void sepol_set_delusers(int on);
-
 /* Set internal policydb from a file for subsequent service calls. */
 extern int sepol_set_policydb_from_file(FILE *fp);
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/users.h new/libsepol/include/sepol/users.h
--- old/libsepol/include/sepol/users.h	2005-10-21 09:54:18.000000000 -0400
+++ new/libsepol/include/sepol/users.h	2005-10-21 10:56:26.000000000 -0400
@@ -5,14 +5,23 @@
 #include <sepol/user_record.h>
 #include <stddef.h>
 
-/* Clear unused users */
-extern void sepol_clear_unused_users(
-	sepol_policydb_t* policydb);
+/*---------compatibility------------*/
 
-/* Delete the user */
-extern int sepol_user_del(
-	sepol_policydb_t* policydb, 
-	const char *username);
+/* Given an existing binary policy (starting at 'data with length 'len')
+   and user configurations living in 'usersdir', generate a new binary
+   policy for the new user configurations.  Sets '*newdata' and '*newlen'
+   to refer to the new binary policy image. */
+extern int sepol_genusers(
+	void *data, size_t len,
+	const char *usersdir,
+	void **newdata, size_t *newlen);
+
+/* Enable or disable deletion of users by sepol_genusers(3) when
+   a user in original binary policy image is not defined by the
+   new user configurations.  Defaults to disabled. */
+extern void sepol_set_delusers(int on);
+
+/*--------end compatibility----------*/
 
 /* Add the user if missing, or modify otherwise */
 extern int sepol_user_modify(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/genusers.c new/libsepol/src/genusers.c
--- old/libsepol/src/genusers.c	2005-10-18 10:08:39.000000000 -0400
+++ new/libsepol/src/genusers.c	2005-10-21 10:53:28.000000000 -0400
@@ -12,7 +12,11 @@
 #include "debug.h"
 #include "private.h"
 
-extern int selinux_delusers;
+int selinux_delusers = 0;
+
+void sepol_set_delusers(int on) {
+	selinux_delusers = on;
+}
 
 #undef BADLINE
 #define BADLINE() { \
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/libsepol.map new/libsepol/src/libsepol.map
--- old/libsepol/src/libsepol.map	2005-10-21 09:54:25.000000000 -0400
+++ new/libsepol/src/libsepol.map	2005-10-21 10:59:23.000000000 -0400
@@ -1,6 +1,6 @@
 {
   global: 
-	sepol_genbools*; sepol_set_policydb_from_file; sepol_check_context; sepol_genusers; sepol_debug; sepol_set_delusers;
+	sepol_genbools*; sepol_set_policydb_from_file; sepol_check_context; sepol_genusers; sepol_debug; 
 	sepol_policy_file_create; sepol_policy_file_free;
 	sepol_policy_file_set_mem; sepol_policy_file_set_fp;
 	sepol_policy_file_get_len; sepol_policy_file_set_handle;
@@ -19,7 +19,7 @@
 	sepol_module_package_write; 
 	sepol_link_modules; sepol_expand_module;
 	sepol_bool*; sepol_context*;
-	sepol_iface*; sepol_port*; sepol_user*; sepol_clear_unused_users;
+	sepol_iface*; sepol_port*; sepol_user*; 
 	sepol_set_delusers;
 	sepol_msg_*; sepol_handle_*;
   local: *;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2005-10-21 09:54:25.000000000 -0400
+++ new/libsepol/src/users.c	2005-10-21 10:54:20.000000000 -0400
@@ -1,5 +1,5 @@
 #include <stdlib.h>
-#include <sys/types.h>
+#include <stddef.h>
 
 #include "private.h"
 #include "debug.h"
@@ -11,113 +11,6 @@
 #include <sepol/users.h>
 #include <sepol/user_record.h>
 
-int selinux_delusers = 0;
-
-void sepol_set_delusers(int on) {
-	selinux_delusers = on;
-}
-
-/* Select users for removal based on whether they were defined in the
-   new users configuration. */
-static int select_user(
-	hashtab_key_t key __attribute__ ((unused)), 
-	hashtab_datum_t datum, 
-	void *datap __attribute__ ((unused))) {
-	user_datum_t *usrdatum = datum;
-
-	if (!usrdatum->defined)
-		return 1;
-	return 0;
-}
-
-/* Kill the user entries selected by select_user, and
-   record that their slots are free. */
-static void kill_user(
-	hashtab_key_t key, 
-	hashtab_datum_t datum, 
-	void *arg)
-{
-	user_datum_t *usrdatum = (user_datum_t*) datum;
-	policydb_t* policydb = (policydb_t*) arg;
-
-	/* Locations of user we're deleting, and last user */
-	int old_pos = usrdatum->value - 1;
-	int last_pos = policydb->p_users.nprim - 1;
-
-	/* Fill hole with last user/data pair */
-	if (old_pos != last_pos) {
-
-		char* last_name = policydb->p_user_val_to_name[last_pos];
-		user_datum_t* last_data = 
-			policydb->user_val_to_struct[last_pos];
-
-		/* Decrement prim */
-		last_data->value--;
-	
-		/* Update sid in reverse mapings */
-		policydb->p_user_val_to_name[old_pos] = last_name;
-		policydb->user_val_to_struct[old_pos] = last_data;
-	}
-
-	/* Decrement prim */
-	policydb->p_users.nprim--;
-	
-	/* Free key and data */
-	if (key)
-		free(key);
-	role_set_destroy(&usrdatum->roles);
-	free(datum);
-}
-
-void sepol_clear_unused_users(sepol_policydb_t* policydb) {
-	if (selinux_delusers) {
-		hashtab_map_remove_on_error(
-			policydb->p.p_users.table,
-			&select_user, 
-			&kill_user, 
-			&policydb->p);
-        }
-}
-
-/* Delete a user from the given policydb. This function will
- * fail if the user does not exist. */
-
-int sepol_user_del(sepol_policydb_t* p, const char* username) {
-	user_datum_t* usrdatum;
-	char* name = NULL;
-	policydb_t *policydb = &p->p;
-
-	name = strdup(username);
-	if (!name) 
-		goto omem;
-	
-	/* See if such a user exists */
-	usrdatum = hashtab_search(policydb->p_users.table, name);
-
-	/* If not, fail */
-	if (usrdatum == NULL) {
-		DEBUG(__FUNCTION__, "%s does not exist in policy\n", name);
-		goto err;
-	}
-	else {
-		if ( hashtab_remove(
-			policydb->p_users.table, name, 
-			&kill_user, policydb) < 0)
-			goto err;
-	}
-
-	free(name);
-	return STATUS_SUCCESS;
-
-	omem:
-	DEBUG(__FUNCTION__, "out of memory\n");
-
-	err:
-	DEBUG(__FUNCTION__, "could not remove %s from policy\n", name);
-	free(name);
-	return STATUS_ERR;
-}
-
 /* Load a user into policydb. The user may exist already, in
  * which case the supplied data replaces the existing data. Alternatively,
  * the user could be new. */

--------------080500040706050304010103--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
