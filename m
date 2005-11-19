Message-ID: <437EBD3A.7090606@cornell.edu>
Date: Sat, 19 Nov 2005 00:50:50 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEPOL] Remove defrole from sepol
Content-Type: multipart/mixed;
 boundary="------------020301030801090306060308"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020301030801090306060308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch removes defrole from sepol, because it does not belong there, 
and it's just plain wrong. The default role is not preserved in the 
binary policy - therefore it can only exist in semanage (unless we 
change the policy format to contain it). This simplifies user_record.c.

It also updates del_role to have a void return type, as it can no longer 
fail.

Now we need to add the labeling prefix back into semanage somehow.


--------------020301030801090306060308
Content-Type: text/x-patch;
 name="libsepol.remove_def_role.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.remove_def_role.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'booleans_kernel.*' --exclude 'database_pserver.*' old/libsemanage/include/semanage/user_record.h new/libsemanage/include/semanage/user_record.h
--- old/libsemanage/include/semanage/user_record.h	2005-11-08 09:32:57.000000000 -0500
+++ new/libsemanage/include/semanage/user_record.h	2005-11-18 19:55:14.000000000 -0500
@@ -70,7 +70,7 @@ extern int semanage_user_add_role(
 	semanage_user_t* user, 
 	const char* role);
 
-extern int semanage_user_del_role(
+extern void semanage_user_del_role(
 	semanage_handle_t* handle,
 	semanage_user_t* user, 
 	const char* role);
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'booleans_kernel.*' --exclude 'database_pserver.*' old/libsemanage/src/semanageswig_wrap.c new/libsemanage/src/semanageswig_wrap.c
--- old/libsemanage/src/semanageswig_wrap.c	2005-11-15 08:06:18.000000000 -0500
+++ new/libsemanage/src/semanageswig_wrap.c	2005-11-19 00:39:01.000000000 -0500
@@ -1680,7 +1680,7 @@ int semanage_user_set_mlsrange(semanage_
 int semanage_user_get_num_roles(semanage_user_t *);
 char const *semanage_user_get_defrole(semanage_user_t *);
 int semanage_user_add_role(semanage_handle_t *,semanage_user_t *,char const *);
-int semanage_user_del_role(semanage_handle_t *,semanage_user_t *,char const *);
+void semanage_user_del_role(semanage_handle_t *,semanage_user_t *,char const *);
 int semanage_user_has_role(semanage_user_t *,char const *);
 int semanage_user_set_defrole(semanage_handle_t *,semanage_user_t *,char const *);
 int semanage_user_get_roles(semanage_handle_t *,semanage_user_t *,char const ***,size_t *);
@@ -3292,7 +3292,6 @@ static PyObject *_wrap_semanage_user_del
     semanage_handle_t *arg1 = (semanage_handle_t *) 0 ;
     semanage_user_t *arg2 = (semanage_user_t *) 0 ;
     char *arg3 = (char *) 0 ;
-    int result;
     PyObject * obj0 = 0 ;
     PyObject * obj1 = 0 ;
     PyObject * obj2 = 0 ;
@@ -3305,11 +3304,9 @@ static PyObject *_wrap_semanage_user_del
     if (!SWIG_AsCharPtr(obj2, (char**)&arg3)) {
         SWIG_arg_fail(3);SWIG_fail;
     }
-    result = (int)semanage_user_del_role(arg1,arg2,(char const *)arg3);
-    
-    {
-        resultobj = SWIG_From_int((int)(result)); 
-    }
+    semanage_user_del_role(arg1,arg2,(char const *)arg3);
+
+    Py_INCREF(Py_None); resultobj = Py_None;
     return resultobj;
     fail:
     return NULL;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'booleans_kernel.*' --exclude 'database_pserver.*' old/libsemanage/src/user_record.c new/libsemanage/src/user_record.c
--- old/libsemanage/src/user_record.c	2005-11-08 09:32:57.000000000 -0500
+++ new/libsemanage/src/user_record.c	2005-11-19 00:37:59.000000000 -0500
@@ -12,9 +12,11 @@ typedef semanage_user_t record_t;
 typedef semanage_user_key_t record_key_t;
 #define DBASE_RECORD_DEFINED
 
+#include <stdlib.h>
 #include <stddef.h>
 #include "handle.h"
 #include "database.h"
+#include "debug.h"
 
 /* Key */
 int semanage_user_key_create(
@@ -110,7 +112,9 @@ int semanage_user_get_num_roles(
 const char* semanage_user_get_defrole(
 	semanage_user_t* user) {
 
-	return sepol_user_get_defrole(user);
+	/* FIXME: stub */
+	user = NULL;
+	return "";
 }
 hidden_def(semanage_user_get_defrole)
 
@@ -123,12 +127,12 @@ int semanage_user_add_role(
 }
 hidden_def(semanage_user_add_role)
 
-int semanage_user_del_role(
+void semanage_user_del_role(
 	semanage_handle_t* handle,
 	semanage_user_t* user, 
 	const char* role) {
 
-	return sepol_user_del_role(handle->sepolh, user, role);
+	sepol_user_del_role(handle->sepolh, user, role);
 }
 
 int semanage_user_has_role(
@@ -143,7 +147,11 @@ int semanage_user_set_defrole(
 	semanage_user_t* user, 
 	const char* role) {
 
-	return sepol_user_set_defrole(handle->sepolh, user, role);
+	/* FIXME: stub */
+	handle = NULL;
+	user = NULL;
+	role = NULL;
+	return STATUS_ERR;
 }
 hidden_def(semanage_user_set_defrole)
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'booleans_kernel.*' --exclude 'database_pserver.*' old/libsepol/include/sepol/user_record.h new/libsepol/include/sepol/user_record.h
--- old/libsepol/include/sepol/user_record.h	2005-10-31 11:09:39.000000000 -0500
+++ new/libsepol/include/sepol/user_record.h	2005-11-18 19:51:51.000000000 -0500
@@ -61,15 +61,12 @@ extern int sepol_user_set_mlsrange(
 extern int sepol_user_get_num_roles(
 	sepol_user_t* user);
 
-extern const char* sepol_user_get_defrole(
-	sepol_user_t* user);
-
 extern int sepol_user_add_role(
 	sepol_handle_t* handle,
 	sepol_user_t* user, 
 	const char* role);
 
-extern int sepol_user_del_role(
+extern void sepol_user_del_role(
 	sepol_handle_t* handle,
 	sepol_user_t* user, 
 	const char* role);
@@ -78,11 +75,6 @@ extern int sepol_user_has_role(
 	sepol_user_t* user, 
 	const char* role);
 
-extern int sepol_user_set_defrole(
-	sepol_handle_t* handle,
-	sepol_user_t* user, 
-	const char* role);
-
 extern int sepol_user_get_roles(
 	sepol_handle_t* handle,
 	sepol_user_t* user,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'booleans_kernel.*' --exclude 'database_pserver.*' old/libsepol/src/user_internal.h new/libsepol/src/user_internal.h
--- old/libsepol/src/user_internal.h	2005-11-01 17:32:59.000000000 -0500
+++ new/libsepol/src/user_internal.h	2005-11-18 19:52:24.000000000 -0500
@@ -11,7 +11,6 @@ hidden_proto(sepol_user_get_roles)
 hidden_proto(sepol_user_has_role)
 hidden_proto(sepol_user_key_create)
 hidden_proto(sepol_user_key_unpack)
-hidden_proto(sepol_user_set_defrole)
 hidden_proto(sepol_user_set_mlslevel)
 hidden_proto(sepol_user_set_mlsrange)
 hidden_proto(sepol_user_set_name)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'booleans_kernel.*' --exclude 'database_pserver.*' old/libsepol/src/user_record.c new/libsepol/src/user_record.c
--- old/libsepol/src/user_record.c	2005-11-01 17:32:59.000000000 -0500
+++ new/libsepol/src/user_record.c	2005-11-18 19:51:17.000000000 -0500
@@ -21,9 +21,6 @@ struct sepol_user {
 
 	/* The number of roles */
 	size_t num_roles;
-
-	/* The default role */
-	char* def_role;
 };
 
 struct sepol_user_key {
@@ -158,44 +155,33 @@ int sepol_user_get_num_roles(sepol_user_
 	return user->num_roles;
 }
 
-const char* sepol_user_get_defrole(sepol_user_t* user) {
-	 return (user->def_role == NULL)? NULL : user->def_role;
-}
-
 int sepol_user_add_role(
 	sepol_handle_t* handle,
 	sepol_user_t* user, 
 	const char* role) {
 
 	char* role_cp;
-	char* role_cp2;
 	char** roles_realloc;
 
 	if (sepol_user_has_role(user, role))
 		return STATUS_SUCCESS;
 
 	role_cp = strdup(role);
-	role_cp2 = strdup(role); 
 	roles_realloc = realloc(user->roles, 
 		sizeof(char*) * (user->num_roles + 1));
 
-	if (!role_cp || !role_cp2 || !roles_realloc) 
+	if (!role_cp || !roles_realloc) 
 		goto omem;
 
 	user->num_roles++;
 	user->roles = roles_realloc;
 	user->roles[user->num_roles - 1] = role_cp;
-	if (user->def_role == NULL)
-		user->def_role = role_cp2;
-	else
-		free(role_cp2);
 
         return STATUS_SUCCESS;
 
 	omem:
 	ERR(handle, "out of memory, could not add role %s", role);
 	free(role_cp);
-	free(role_cp2);
 	free(roles_realloc);
 	return STATUS_ERR;
 }
@@ -219,7 +205,6 @@ int sepol_user_set_roles(
 
 	size_t i;
 	char** tmp_roles = NULL;
-	char* tmp_def_role = NULL;
 
 	if (num_roles > 0) {
 
@@ -233,21 +218,14 @@ int sepol_user_set_roles(
 			if (!tmp_roles[i])
 				goto omem;	
 		}
-
-		tmp_def_role = strdup(tmp_roles[0]);
-		if (!tmp_def_role) 
-			goto omem;
 	}
 	
 	/* Apply other changes */
 	for (i = 0; i < user->num_roles; i++)
 		free(user->roles[i]);
 	free(user->roles);
-	free(user->def_role);
 	user->roles = tmp_roles;
 	user->num_roles = num_roles;
-	user->def_role = tmp_def_role;
-
 	return STATUS_SUCCESS;
 
 	omem:
@@ -262,7 +240,6 @@ int sepol_user_set_roles(
 		}
 	}
 	free(tmp_roles);
-	free(tmp_def_role);
 	return STATUS_ERR;	
 }
 
@@ -293,73 +270,22 @@ int sepol_user_get_roles(
 }
 hidden_def(sepol_user_get_roles)
 
-int sepol_user_del_role(
+void sepol_user_del_role(
 	sepol_handle_t* handle,	
 	sepol_user_t* user, 
 	const char* role) {
 
-	int change_defrole = 0;
-	char* tmp_defrole = NULL;
 	size_t i;
-
 	for (i = 0; i < user->num_roles; i++) {
 		if (!strcmp(user->roles[i], role)) {
-
-			/* Will replace default role */
-			if (user->num_roles > 1 && !strcmp(user->def_role, role))  {
-				tmp_defrole = strdup(user->roles[0]);
-				if (!tmp_defrole) {
-					ERR(handle, 
-						"out of memory, could not allocate "
-						"new default role");
-					return STATUS_ERR;
-				}
-				change_defrole = 1;
-			}
-
-			/* Apply changes */
 			free(user->roles[i]);
+                        user->roles[i] = NULL;
 			user->roles[i] = user->roles[user->num_roles-1];			
 			user->num_roles--;
-			if (change_defrole) {
-				free(user->def_role);
-				user->def_role = tmp_defrole;
-			}
-
-			return STATUS_SUCCESS;
 		}
 	}
-
-	return STATUS_SUCCESS;
 }
 
-int sepol_user_set_defrole(
-	sepol_handle_t* handle,
-	sepol_user_t* user, 
-	const char* role) {
-
-	char* tmp_defrole = strdup(role);
-	if (!tmp_defrole)
-		goto omem;
-
-	if (sepol_user_add_role(handle, user, role) < 0)
-		goto err;
-
-	free(user->def_role);
-	user->def_role = tmp_defrole;
-	return STATUS_SUCCESS;
-
-	omem:
-	ERR(handle, "out of memory");
-	
-	err:
-	free(tmp_defrole);
-	ERR(handle, "could not set default role for %s to %s", 
-		user->name, role);
-	return STATUS_ERR;
-}
-hidden_def(sepol_user_set_defrole)
-
 /* Create */
 int sepol_user_create(
 	sepol_handle_t* handle,
@@ -374,7 +300,6 @@ int sepol_user_create(
 	}
 
         user->roles = NULL;
-        user->def_role = NULL;
         user->num_roles = 0;
         user->name = NULL;
 	user->mls_level = NULL;
@@ -405,9 +330,6 @@ int sepol_user_clone(
 			goto err;
 	}
 
-	if (sepol_user_set_defrole(handle, new_user, user->def_role) < 0)
-		goto err;	
-
 	if (user->mls_level &&
 	   (sepol_user_set_mlslevel(handle, new_user, user->mls_level) < 0))
 		goto err;
@@ -435,7 +357,6 @@ void sepol_user_free(sepol_user_t* user)
 	free(user->name);
 	for (i = 0; i < user->num_roles; i++)
 		free(user->roles[i]);
-	free(user->def_role);
 	free(user->roles);
 	free(user->mls_level);
 	free(user->mls_range);

--------------020301030801090306060308--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
