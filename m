Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8U3NnNs023940
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 23:23:49 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8U3HxS2018675
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 03:17:59 GMT
Message-ID: <433CB082.8050602@cornell.edu>
Date: Thu, 29 Sep 2005 23:26:58 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: dwalsh@redhat.com
Subject: Re: [ 9/9 ] [ SEPOL ] User list function, Bugfixes
References: <433CA7CA.6000207@cornell.edu>
In-Reply-To: <433CA7CA.6000207@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------060303000703090404030806"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060303000703090404030806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Steven,  I implemented the interfaces you wanted. I think the end result 
looks just as bad as before, if not worse.
However, it's now hidden away into mls.c, instead of having to implement 
it in every caller. Also, looks like you were right not to trust me, 
because I ran the code through valgrind, and found all kinds of bugs, 
which I fixed (so says valgrind).

mls.c is just evil. Apparently compute_length () returns the size of the 
context (plus the ':', which I don't want), *minus* the NULL terminator 
at the end. However, mls_context_to_sid will write the NULL terminator 
at the end. Not only will it write it, it won't skip over it, but will 
stop on top of it ( I think), causing mayhem in my code. This interface 
makes no sense to me - the replacement is based on it, but it hides the 
detail from the caller.

Attached is my resubmission of the user list function, including new mls 
functions, and a series of bugfixes for user roles. One of those is 
particularly bad (realloc fix).

--------------060303000703090404030806
Content-Type: text/x-patch;
 name="libsepol.08.user_list.bugs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.08.user_list.bugs.diff"

diff -Naur --exclude CVS libsepol/include/sepol/mls.h libsepol.new/include/sepol/mls.h
--- libsepol/include/sepol/mls.h	2005-07-13 15:42:37.000000000 -0400
+++ libsepol.new/include/sepol/mls.h	2005-09-29 20:44:29.000000000 -0400
@@ -34,15 +34,28 @@
 #include <sepol/context.h>
 #include <sepol/policydb.h>
 
+extern int mls_struct_from_string(
+	policydb_t* policydb,
+	const char* str,
+	context_struct_t* mls);
+
+extern int mls_struct_to_string(
+	policydb_t* policydb,
+	context_struct_t* mls,
+	char** str);
+
+/* Deprecated */
 extern int mls_compute_context_len(policydb_t *policydb,
 			    context_struct_t * context);
 
+/* Deprecated */
 extern void mls_sid_to_context(policydb_t *policydb,
                         context_struct_t *context,
                         char **scontext);
 
 extern int mls_context_isvalid(policydb_t *p, context_struct_t * c);
 
+/* Deprecated */
 extern int mls_context_to_sid(policydb_t *policydb,
 		       char oldc,
 	               char **scontext,
@@ -63,5 +76,7 @@
 	context_struct_t *fromcon, user_datum_t *user,
 	context_struct_t *usercon);
 
-#endif	/* _MLS_H_ */
+
+
+#endif	
 
diff -Naur --exclude CVS libsepol/include/sepol/users.h libsepol.new/include/sepol/users.h
--- libsepol/include/sepol/users.h	2005-09-29 20:26:57.000000000 -0400
+++ libsepol.new/include/sepol/users.h	2005-09-29 20:31:49.000000000 -0400
@@ -32,10 +32,10 @@
 	policydb_t* policydb,
 	const char* role);
 
-/* Obtain an array of all valid users/roles */
-extern int sepol_get_valid_users(
+/* Obtain the user list */
+extern int sepol_user_list(
 	policydb_t* policydb,
-	char*** users,
+	sepol_user_t*** users,
 	size_t* nusers);
 
 extern int sepol_get_valid_roles(
diff -Naur --exclude CVS libsepol/src/mls.c libsepol.new/src/mls.c
--- libsepol/src/mls.c	2005-08-11 12:57:51.000000000 -0400
+++ libsepol.new/src/mls.c	2005-09-29 22:21:34.000000000 -0400
@@ -35,8 +35,65 @@
 
 #include <stdlib.h>
 
+#include "debug.h"
 #include "private.h"
 
+int mls_struct_to_string(
+	policydb_t* policydb, 
+	context_struct_t* mls, 
+	char** str) {
+
+	char *ptr = NULL, *ptr2 = NULL;
+
+	/* Temporary buffer - length + NULL terminator */
+	int len = mls_compute_context_len(policydb, mls) + 1;
+
+	ptr = (char*) malloc(len);
+	if (ptr == NULL)
+		goto omem;
+
+	/* Final string w/ ':' cut off */
+	ptr2 = (char*) malloc(len - 1);
+	if (ptr2 == NULL)
+		goto omem;
+
+	mls_sid_to_context(policydb, mls, &ptr);
+	ptr -= len - 1;
+	strcpy(ptr2, ptr + 1);
+
+	free(ptr);
+	*str = ptr2;
+	return STATUS_SUCCESS;
+
+	omem:
+	DEBUG(__FUNCTION__, "out of memory\n");
+	free(ptr);
+	free(ptr2);
+	return STATUS_ERR;
+
+}
+
+int mls_struct_from_string(
+	policydb_t* policydb, 
+	const char* str, 
+	context_struct_t* mls) {
+
+	char* tmp = strdup(str);
+	if (!tmp) {
+		DEBUG(__FUNCTION__, "out of memory\n");
+		return STATUS_ERR;
+	}
+
+	if (mls_context_to_sid(policydb, '$', &tmp, mls)) {
+		DEBUG(__FUNCTION__, "invalid MLS context %s\n", str);
+		free(tmp);
+		return STATUS_ERR;
+	}
+	
+	free(tmp);
+	return STATUS_SUCCESS;
+}
+
 /*
  * Return the length in bytes for the MLS fields of the
  * security context string representation of `context'.
diff -Naur --exclude CVS libsepol/src/user_record.c libsepol.new/src/user_record.c
--- libsepol/src/user_record.c	2005-09-29 20:26:57.000000000 -0400
+++ libsepol.new/src/user_record.c	2005-09-29 21:41:54.000000000 -0400
@@ -1,6 +1,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include <stddef.h>
 
 #include <sepol/user_record.h>
 #include "debug.h"
@@ -19,7 +20,7 @@
 	char** roles;
 
 	/* The number of roles */
-	unsigned int num_roles;
+	size_t num_roles;
 
 	/* The default role */
 	char* def_role;
@@ -129,7 +130,9 @@
 
 	char* role_cp = strdup(role);
 	char* role_cp2 = strdup(role); 
-	char** roles_realloc = realloc(user->roles, user->num_roles + 1);
+	char** roles_realloc = realloc(user->roles, 
+		sizeof(char*) * (user->num_roles + 1));
+
 	if (!role_cp || !role_cp2 || !roles_realloc) 
 		goto omem;
 
@@ -138,6 +141,8 @@
 	user->roles[user->num_roles - 1] = role_cp;
 	if (!user->def_role)
 		user->def_role = role_cp2;
+	else
+		free(role_cp2);
 
         return STATUS_SUCCESS;
 
@@ -151,7 +156,7 @@
 }
 
 int sepol_user_has_role(sepol_user_t* user, const char* role) {
-	unsigned int i;
+	size_t i;
 
 	for (i = 0; i < user->num_roles; i++)
 		if (!strcmp(user->roles[i], role)) 
@@ -164,7 +169,7 @@
 	const char** roles_arr,
 	size_t num_roles) {
 
-	unsigned int i;
+	size_t i;
 	char** tmp_roles =
 		(char**) calloc(1, sizeof(char*) * num_roles);
 	if (!tmp_roles) 
@@ -200,7 +205,7 @@
 	const char*** roles_arr, 
 	size_t* num_roles) {
 
-	unsigned int i;	
+	size_t i;	
 	const char** tmp_roles = 
 		(const char**) malloc(sizeof (char*) * user->num_roles);
 	if (!tmp_roles)
@@ -221,7 +226,7 @@
 }
 
 int sepol_user_del_role(sepol_user_t* user, const char* role) {
-	unsigned int i;
+	size_t i;
 	for (i = 0; i < user->num_roles; i++) {
 		if (!strcmp(user->roles[i], role)) {
 
@@ -256,23 +261,34 @@
 
 int sepol_user_set_defrole(sepol_user_t* user, const char* role) {
 
-	/* First, add the role if we don't have it */
-	if (!sepol_user_has_role(user, role)) {
-		if (sepol_user_add_role(user, role) < 0)
-			goto err;
-	}
+	char* old_defrole = NULL;
+
+	/* Backup previous default role */
+	if (user->def_role)
+		old_defrole = user->def_role;
 
 	/* Set as default */
 	user->def_role = strdup(role);
 	if (!user->def_role)
 		goto omem;		
 
+        /* Add the role if we don't have it */
+	if (!sepol_user_has_role(user, role)) {
+		if (sepol_user_add_role(user, role) < 0)
+			goto err;
+	}
+
+	/* Free old role */
+	free(old_defrole);
 
 	return STATUS_SUCCESS;
 	omem:
 	DEBUG(__FUNCTION__, "out of memory\n");
 	
 	err:
+	free(user->def_role);
+	user->def_role = old_defrole;
+
 	DEBUG(__FUNCTION__, "could not set default role for %s to %s\n",
 		user->name, role);
 	return STATUS_ERR;
@@ -302,7 +318,7 @@
 /* Deep copy clone */
 int sepol_user_clone(sepol_user_t* user, sepol_user_t** user_ptr) {
 	sepol_user_t* new_user = NULL;
-	unsigned int i;
+	size_t i;
 
 	if (sepol_user_create(&new_user) < 0)
 		goto err;
@@ -319,11 +335,11 @@
 		goto err;	
 
 	if (user->mls_level &&
-	    (sepol_user_set_mlslevel(new_user, user->mls_level) < 0))
+	   (sepol_user_set_mlslevel(new_user, user->mls_level) < 0))
 		goto err;
 
 	if (user->mls_range &&
-	    (sepol_user_set_mlsrange(new_user, user->mls_range) < 0))
+	   (sepol_user_set_mlsrange(new_user, user->mls_range) < 0))
 		goto err;
 
 	*user_ptr = new_user;
@@ -337,7 +353,7 @@
 
 /* Destroy */
 void sepol_user_free(sepol_user_t* user) {
-	unsigned int i;
+	size_t i;
 
 	if (!user)
 		return;
diff -Naur --exclude CVS libsepol/src/users.c libsepol.new/src/users.c
--- libsepol/src/users.c	2005-09-29 20:26:57.000000000 -0400
+++ libsepol.new/src/users.c	2005-09-29 21:00:54.000000000 -0400
@@ -241,19 +241,17 @@
 
 	/* For MLS systems */
 	if (mls_enabled) {
-		char* mls_tmp;
 		context_init(&context);
 
 		/* MLS level */
 		if (mls_level == NULL) {
-			DEBUG(__FUNCTION__, "mls is enabled, but no mls "
-				"level found for user %s\n", name);
+			DEBUG(__FUNCTION__, "MLS is enabled, but no MLS "
+				"default level was defined for user %s\n", name);
 			goto err;
 		}
-
-		mls_tmp = mls_level;
-		if (mls_context_to_sid(policydb, '$', &mls_tmp, &context)) {
-			DEBUG(__FUNCTION__, "invalid level %s for user %s\n", 
+		
+		if (mls_struct_from_string(policydb, mls_level, &context) < 0) {
+			DEBUG(__FUNCTION__, "invalid MLS default level %s for user %s\n", 
 				mls_level, name);
 			goto err;
 		}
@@ -263,14 +261,13 @@
 		/* MLS range */
 		context_init(&context);
 		if (mls_range == NULL) {
-			DEBUG(__FUNCTION__, "mls is enabled, but no mls"
-				"range found for user %s\n", name);
+			DEBUG(__FUNCTION__, "MLS is enabled, but no MLS"
+				"range was defined for user %s\n", name);
 			goto err;
 		}	
 
-		mls_tmp = mls_range; 
-		if (mls_context_to_sid(policydb, '$', &mls_tmp, &context)) {
-			DEBUG(__FUNCTION__, "invalid range %s for user %s\n", 
+		if (mls_struct_from_string(policydb, mls_range, &context) < 0) {
+			DEBUG(__FUNCTION__, "invalid MLS range %s for user %s\n", 
 				mls_range, name);
 			goto err;
 		}
@@ -368,18 +365,76 @@
 
 /* Fill an array with all valid users */
 
-int sepol_get_valid_users(policydb_t* policydb, char*** users, size_t* nusers) {
+int sepol_user_list(
+	policydb_t* policydb, 
+	sepol_user_t*** users,
+	size_t* nusers) {
+
 	size_t tmp_nusers = policydb->p_users.nprim;
-	char **tmp_users = (char**) malloc(tmp_nusers * sizeof(char*));
-	char **ptr;
+	sepol_user_t** tmp_users = 
+		(sepol_user_t**) calloc(tmp_nusers, sizeof(sepol_user_t*));
+
+	sepol_user_t** ptr;
 	size_t i;
 	if (!tmp_users)
 		goto omem;
-	
+
+	/* For each user */	
 	for (i = 0; i < tmp_nusers; i++) {
-		tmp_users[i] = strdup(policydb->p_user_val_to_name[i]);
-		if (!tmp_users[i])
-			goto omem;
+			
+		const char* name = policydb->p_user_val_to_name[i];
+		user_datum_t* usrdatum = policydb->user_val_to_struct[i];
+		ebitmap_t* roles = &(usrdatum->roles.roles);
+		ebitmap_node_t* rnode;
+		unsigned bit;
+
+		if (sepol_user_create(&tmp_users[i]) < 0)
+			goto err;
+
+		if (sepol_user_set_name(tmp_users[i], name) < 0)
+			goto err; 
+
+		/* Extract roles */
+		ebitmap_for_each_bit(roles, rnode, bit) {
+			if (ebitmap_node_get_bit(rnode, bit)) {
+				char* role = policydb->p_role_val_to_name[bit];
+				if (sepol_user_add_role(tmp_users[i], role) < 0)
+					goto err;
+			}
+		}
+
+		/* Extract MLS info */
+		if (mls_enabled) {
+			context_struct_t context;
+			char *str;
+
+			context_init(&context);
+			memcpy(&context.range.level[0], 
+				&usrdatum->dfltlevel, sizeof(mls_level_t));
+			memcpy(&context.range.level[1],
+				&usrdatum->dfltlevel, sizeof(mls_level_t));	
+		
+			if (mls_struct_to_string(policydb, &context, &str) < 0)
+				goto err;
+	
+			if (sepol_user_set_mlslevel(tmp_users[i], str) < 0 ) {
+				free(str);
+				goto err;
+			}
+			free(str);			
+
+			context_init(&context);
+			memcpy(&context.range, &usrdatum->range, sizeof(mls_range_t));
+
+			if (mls_struct_to_string(policydb, &context, &str) < 0)
+				goto err;
+
+			if (sepol_user_set_mlsrange(tmp_users[i], str) < 0) {
+				free(str);
+				goto err;
+			}
+			free(str);
+		}
 	}
 
 	*nusers = tmp_nusers;
@@ -388,12 +443,14 @@
 	return STATUS_SUCCESS;
 
 	omem:
-	DEBUG(__FUNCTION__, "out of memory, could not "
-		"allocate list of valid users\n");
+	DEBUG(__FUNCTION__, "out of memory\n");
+
+	err:
+	DEBUG(__FUNCTION__, "could not enumerate users\n");
 
 	ptr = tmp_users;
-	while (ptr && *ptr) 
-		free(*ptr++);
+	while (ptr && (*ptr != NULL)) 
+		sepol_user_free(*ptr++);
 	free(tmp_users);
 	return STATUS_ERR;
 }

--------------060303000703090404030806--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
