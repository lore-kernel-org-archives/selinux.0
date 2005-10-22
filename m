Message-ID: <435A24EC.5040804@cornell.edu>
Date: Sat, 22 Oct 2005 07:39:24 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL 4 ] user - to_record fn, mls cleanups
Content-Type: multipart/mixed;
 boundary="------------070006000407020102070002"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070006000407020102070002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

- moves code from user iterate() to user_to_record, like it was done for 
other things (this code can now be shared for query).
- renames mls_struct_* prefix to mls_* for consistency w/ other mls code
- change context_from_string to use mls_from_string, which simplifies 
this function (because that's a better interface that respects const 
char*, for example)

--------------070006000407020102070002
Content-Type: text/x-patch;
 name="libsepol.user_record_conv.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.user_record_conv.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/include/sepol/policydb/mls.h new/libsepol/include/sepol/policydb/mls.h
--- old/libsepol/include/sepol/policydb/mls.h	2005-10-07 16:45:17.000000000 -0400
+++ new/libsepol/include/sepol/policydb/mls.h	2005-10-22 07:19:20.000000000 -0400
@@ -34,12 +34,12 @@
 #include <sepol/policydb/context.h>
 #include <sepol/policydb/policydb.h>
 
-extern int mls_struct_from_string(
+extern int mls_from_string(
 	policydb_t* policydb,
 	const char* str,
 	context_struct_t* mls);
 
-extern int mls_struct_to_string(
+extern int mls_to_string(
 	policydb_t* policydb,
 	context_struct_t* mls,
 	char** str);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/context.c new/libsepol/src/context.c
--- old/libsepol/src/context.c	2005-10-22 06:46:18.000000000 -0400
+++ new/libsepol/src/context.c	2005-10-22 07:18:28.000000000 -0400
@@ -124,10 +124,9 @@ int context_to_string(
 	return STATUS_ERR;
 }
 
-
-/* Create a policy-dependent context structure, corresponding
- * to the provided high level representation */
-
+/*
+ * Create a context structure from the given record
+ */
 int context_from_record(
 	policydb_t* policydb, 
 	context_struct_t** cptr, 
@@ -142,13 +141,10 @@ int context_from_record(
 	char* user = strdup(sepol_context_get_user(record)); 
 	char* role = strdup(sepol_context_get_role(record));
 	char* type = strdup(sepol_context_get_type(record));
- 
- 	const char* tmp = sepol_context_get_mls(record);
- 	char* mls = tmp ? strdup(tmp): NULL;
- 	char* mls_ptr = mls;
+	const char* mls = sepol_context_get_mls(record); 
 
 	scontext = (context_struct_t*) malloc(sizeof(context_struct_t));
- 	if (!user || !role || !type || (tmp && !mls) || !scontext) {
+ 	if (!user || !role || !type || !mls || !scontext) {
 		DEBUG(__FUNCTION__, "out of memory\n"); 
 		goto err;
 	}
@@ -185,7 +181,6 @@ int context_from_record(
 	if (mls && !policydb->mls) {
  		DEBUG(__FUNCTION__, "Warning! mls context \"%s\" found, "
  			"but mls is disabled\n", mls);
- 		free(mls);
 		mls = NULL;
 	}
 	else if (!mls && policydb->mls) {
@@ -193,7 +188,7 @@ int context_from_record(
  			"mls context found\n");
 		goto err_destroy;
 	}
- 	if (mls && (mls_context_to_sid(policydb, '$', &mls_ptr, scontext) < 0)) {
+	if (mls && (mls_from_string(policydb, mls, scontext) < 0)) {
  		DEBUG(__FUNCTION__, "invalid mls context: %s\n", mls);
 		goto err_destroy;
 	}
@@ -217,7 +212,6 @@ int context_from_record(
 	free(user);	
 	free(type);
 	free(role);
-	free(mls);
 	return STATUS_SUCCESS;
 
 	err_destroy:
@@ -228,13 +222,13 @@ int context_from_record(
 	free(user);
 	free(type);
 	free(role);
-	free(mls);	
 	DEBUG(__FUNCTION__, "error creating context structure\n");
 	return STATUS_ERR;
 }
 
-/* Create a record from the context structure */
-
+/*
+ * Create a record from the given context structure
+ */
 int context_to_record(
 	policydb_t* policydb,
 	context_struct_t* context,
@@ -259,7 +253,7 @@ int context_to_record(
 		goto err;
 
 	if (policydb->mls) {
-		if (mls_struct_to_string(policydb, context, &mls) < 0)
+		if (mls_to_string(policydb, context, &mls) < 0)
 			goto err;
 
 		if (sepol_context_set_mls(tmp_record, mls) < 0)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/mls.c new/libsepol/src/mls.c
--- old/libsepol/src/mls.c	2005-10-07 16:45:46.000000000 -0400
+++ new/libsepol/src/mls.c	2005-10-22 07:11:08.000000000 -0400
@@ -38,7 +38,7 @@
 #include "debug.h"
 #include "private.h"
 
-int mls_struct_to_string(
+int mls_to_string(
 	policydb_t* policydb, 
 	context_struct_t* mls, 
 	char** str) {
@@ -73,7 +73,7 @@ int mls_struct_to_string(
 
 }
 
-int mls_struct_from_string(
+int mls_from_string(
 	policydb_t* policydb, 
 	const char* str, 
 	context_struct_t* mls) {
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude policy_components.c --exclude '*_record.c' --exclude '*_record.h' --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2005-10-21 16:17:46.000000000 -0400
+++ new/libsepol/src/users.c	2005-10-22 07:26:46.000000000 -0400
@@ -11,9 +11,75 @@
 #include <sepol/users.h>
 #include <sepol/user_record.h>
 
-/* Load a user into policydb. The user may exist already, in
- * which case the supplied data replaces the existing data. Alternatively,
- * the user could be new. */
+static int user_to_record (
+	policydb_t* policydb,
+	int user_idx,
+	sepol_user_t** record) {
+
+	const char* name = policydb->p_user_val_to_name[user_idx];
+	user_datum_t* usrdatum = policydb->user_val_to_struct[user_idx];
+	ebitmap_t* roles = &(usrdatum->roles.roles);
+	ebitmap_node_t* rnode;
+	unsigned bit;
+
+	sepol_user_t* tmp_record = NULL;
+
+	if (sepol_user_create(&tmp_record) < 0)
+		goto err;
+
+	if (sepol_user_set_name(tmp_record, name) < 0)
+		goto err;
+
+	/* Extract roles */
+	ebitmap_for_each_bit(roles, rnode, bit) {
+		if (ebitmap_node_get_bit(rnode, bit)) {
+			char* role = policydb->p_role_val_to_name[bit];
+			if (sepol_user_add_role(tmp_record, role) < 0)
+				goto err;
+		}
+	}
+
+	/* Extract MLS info */
+	if (policydb->mls) {
+		context_struct_t context;
+		char *str;
+
+		context_init(&context);
+		memcpy(&context.range.level[0],
+			&usrdatum->dfltlevel, sizeof(mls_level_t));
+		memcpy(&context.range.level[1],
+			&usrdatum->dfltlevel, sizeof(mls_level_t));
+
+		if (mls_to_string(policydb, &context, &str) < 0)
+			goto err;
+
+		if (sepol_user_set_mlslevel(tmp_record, str) < 0 ) {
+			free(str);
+			goto err;
+		}
+		free(str);
+
+		context_init(&context);
+		memcpy(&context.range, &usrdatum->range, sizeof(mls_range_t));
+
+		if (mls_to_string(policydb, &context, &str) < 0)
+			goto err;
+
+		if (sepol_user_set_mlsrange(tmp_record, str) < 0) {
+			free(str);
+			goto err;
+		}
+		free(str);
+	}
+
+	*record = tmp_record;
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	sepol_user_free(tmp_record);
+	return STATUS_ERR;
+}
 
 int sepol_user_modify(sepol_policydb_t* p, sepol_user_t* user) {
 	policydb_t *policydb = &p->p;
@@ -108,7 +174,7 @@ int sepol_user_modify(sepol_policydb_t* 
 			goto err;
 		}
 		
-		if (mls_struct_from_string(policydb, mls_level, &context) < 0) {
+		if (mls_from_string(policydb, mls_level, &context) < 0) {
 			DEBUG(__FUNCTION__, "invalid MLS default level %s for user %s\n", 
 				mls_level, name);
 			goto err;
@@ -124,7 +190,7 @@ int sepol_user_modify(sepol_policydb_t* 
 			goto err;
 		}	
 
-		if (mls_struct_from_string(policydb, mls_range, &context) < 0) {
+		if (mls_from_string(policydb, mls_range, &context) < 0) {
 			DEBUG(__FUNCTION__, "invalid MLS range %s for user %s\n", 
 				mls_range, name);
 			goto err;
@@ -191,8 +257,6 @@ int sepol_user_modify(sepol_policydb_t* 
 	return STATUS_ERR;
 }
 
-/* Check if a user is valid */
-
 int sepol_user_exists(
 	sepol_policydb_t* p, 
 	const char* user,
@@ -210,14 +274,13 @@ int sepol_user_exists(
 	return STATUS_SUCCESS;
 }
 
-/* Fill an array with all valid users */
-
 int sepol_user_iterate(
 	sepol_policydb_t* p, 
 	int (*fn)(
 		sepol_user_t* user,
 		void* fn_arg),
 	void* arg) {
+
 	policydb_t *policydb = &p->p;
 	size_t nusers = policydb->p_users.nprim;
 	sepol_user_t* user = NULL;
@@ -227,60 +290,10 @@ int sepol_user_iterate(
 	for (i = 0; i < nusers; i++) {
 
 		int status;
-		const char* name = policydb->p_user_val_to_name[i];
-		user_datum_t* usrdatum = policydb->user_val_to_struct[i];
-		ebitmap_t* roles = &(usrdatum->roles.roles);
-		ebitmap_node_t* rnode;
-		unsigned bit;
 
-		if (sepol_user_create(&user) < 0)
+		if (user_to_record(policydb, i, &user) < 0)
 			goto err;
 
-		if (sepol_user_set_name(user, name) < 0)
-			goto err; 
-
-		/* Extract roles */
-		ebitmap_for_each_bit(roles, rnode, bit) {
-			if (ebitmap_node_get_bit(rnode, bit)) {
-				char* role = policydb->p_role_val_to_name[bit];
-				if (sepol_user_add_role(user, role) < 0)
-					goto err;
-			}
-		}
-
-		/* Extract MLS info */
-		if (policydb->mls) {
-			context_struct_t context;
-			char *str;
-
-			context_init(&context);
-			memcpy(&context.range.level[0], 
-				&usrdatum->dfltlevel, sizeof(mls_level_t));
-			memcpy(&context.range.level[1],
-				&usrdatum->dfltlevel, sizeof(mls_level_t));	
-		
-			if (mls_struct_to_string(policydb, &context, &str) < 0)
-				goto err;
-	
-			if (sepol_user_set_mlslevel(user, str) < 0 ) {
-				free(str);
-				goto err;
-			}
-			free(str);			
-
-			context_init(&context);
-			memcpy(&context.range, &usrdatum->range, sizeof(mls_range_t));
-
-			if (mls_struct_to_string(policydb, &context, &str) < 0)
-				goto err;
-
-			if (sepol_user_set_mlsrange(user, str) < 0) {
-				free(str);
-				goto err;
-			}
-			free(str);
-		}
-
 		/* Invoke handler */
 		status = fn(user, arg);
 		if (status < 0) 

--------------070006000407020102070002--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
