Message-ID: <4365F6B7.3020706@cornell.edu>
Date: Mon, 31 Oct 2005 05:49:27 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL 2 ] [ SEMANAGE 4 ] Record bugfixes
Content-Type: multipart/mixed;
 boundary="------------040000000903000402060305"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040000000903000402060305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

(Applies after the other patches)
Passes valgrind.

Record bugfixes:

- all records: do not leak old data on any modification calls
- all records: do not overwrite old data on failure

- user: always check if a role exists when adding it, not only for def_role
- user: properly set def_role on set_roles()
- user: allow deletion of the last role, and properly handle def_role = 
last_role being deleted
- user: simplify set_defrole to match the other functions

--------------040000000903000402060305
Content-Type: text/x-patch;
 name="libsemanage.libsepol.record_bugfixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.libsepol.record_bugfixes.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seuser_record.c new/libsemanage/src/seuser_record.c
--- old/libsemanage/src/seuser_record.c	2005-10-31 01:48:29.000000000 -0500
+++ new/libsemanage/src/seuser_record.c	2005-10-31 05:39:28.000000000 -0500
@@ -96,11 +96,13 @@ int semanage_seuser_set_name(
 	semanage_seuser_t* seuser, 
 	const char* name) {
 
-	seuser->name = strdup(name);
-	if (!seuser->name) {
+	char* tmp_name = strdup(name);
+	if (!tmp_name) {
 		ERR(handle, "out of memory, could not set seuser (Unix) name");
 		return STATUS_ERR;
 	}
+	free(seuser->name);
+	seuser->name = tmp_name;
 	return STATUS_SUCCESS;
 }
 
@@ -116,11 +118,13 @@ int semanage_seuser_set_sename(
 	semanage_seuser_t* seuser,
 	const char* sename) {
 
-	seuser->sename = strdup(sename);
-	if (!seuser->sename) {
+	char* tmp_sename = strdup(sename);
+	if (!tmp_sename) {
 		ERR(handle, "out of memory, could not set seuser (SELinux) name");
 		return STATUS_ERR;
 	}
+	free(seuser->sename);
+	seuser->sename = tmp_sename;
 	return STATUS_SUCCESS;
 }
 
@@ -136,11 +140,13 @@ int semanage_seuser_set_mlsrange(
 	semanage_seuser_t* seuser, 
 	const char* mls_range) {
 
-	seuser->mls_range = strdup(mls_range);
-	if (!seuser->mls_range) {
+	char* tmp_mls_range = strdup(mls_range);
+	if (!tmp_mls_range) {
 		ERR(handle, "out of memory, could not set seuser MLS range");
 		return STATUS_ERR;
 	}
+	free(seuser->mls_range);
+	seuser->mls_range = tmp_mls_range;
 	return STATUS_SUCCESS;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsepol/src/boolean_record.c new/libsepol/src/boolean_record.c
--- old/libsepol/src/boolean_record.c	2005-10-31 01:48:30.000000000 -0500
+++ new/libsepol/src/boolean_record.c	2005-10-31 04:56:02.000000000 -0500
@@ -82,11 +82,13 @@ int sepol_bool_set_name(
 	sepol_bool_t* boolean, 
 	const char* name) {
 
-	boolean->name = strdup(name);
-	if (!boolean->name) {
+	char* tmp_name = strdup(name);
+	if (!tmp_name) {
 		ERR(handle, "out of memory, could not set boolean name");
 		return STATUS_ERR;
 	}
+	free(boolean->name);
+	boolean->name = tmp_name;
 	return STATUS_SUCCESS;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsepol/src/context_record.c new/libsepol/src/context_record.c
--- old/libsepol/src/context_record.c	2005-10-31 01:48:30.000000000 -0500
+++ new/libsepol/src/context_record.c	2005-10-31 04:55:07.000000000 -0500
@@ -30,12 +30,15 @@ int sepol_context_set_user(
 	sepol_context_t* con, 
 	const char* user) {
 
-	con->user = strdup(user);
-	if (!con->user) { 
+	char* tmp_user = strdup(user);
+	if (!tmp_user) { 
 		ERR(handle, "out of memory, could not set "
 			"context user to %s", user);
 		return STATUS_ERR;
 	}
+
+	free(con->user);
+	con->user = tmp_user;
 	return STATUS_SUCCESS;
 }
 
@@ -49,12 +52,14 @@ int sepol_context_set_role(
 	sepol_context_t* con, 
 	const char* role) {
 
-	con->role = strdup(role);
-	if (!con->role) {
+	char* tmp_role = strdup(role);
+	if (!tmp_role) {
 		ERR(handle, "out of memory, could not set "
 			"context role to %s", role);
 		return STATUS_ERR;
 	}
+	free(con->role);
+	con->role = tmp_role;
 	return STATUS_SUCCESS;
 }
 
@@ -68,12 +73,14 @@ int sepol_context_set_type(
 	sepol_context_t* con, 
 	const char* type) {
 
-	con->type = strdup(type);
-	if (!con->role) {
+	char* tmp_type = strdup(type);
+	if (!tmp_type) {
 		ERR(handle, "out of memory, could not set "
 			"context type to %s", type);
 		return STATUS_ERR;
 	}
+	free(con->type);
+	con->type = tmp_type;
 	return STATUS_SUCCESS;
 }
 
@@ -87,12 +94,14 @@ int sepol_context_set_mls(
 	sepol_context_t* con, 
 	const char* mls) {
 
-	con->mls = strdup(mls);
-	if (!con->mls) {
+	char* tmp_mls = strdup(mls);
+	if (!tmp_mls) {
 		ERR(handle, "out of memory, could not set "
 			"MLS fields to %s", mls);
 		return STATUS_ERR;
 	}	
+	free(con->mls);
+	con->mls = tmp_mls;
 	return STATUS_SUCCESS;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsepol/src/iface_record.c new/libsepol/src/iface_record.c
--- old/libsepol/src/iface_record.c	2005-10-31 01:48:30.000000000 -0500
+++ new/libsepol/src/iface_record.c	2005-10-31 04:58:05.000000000 -0500
@@ -109,12 +109,14 @@ int sepol_iface_set_name(
 	sepol_iface_t* iface, 
 	const char* name) {
 
-	iface->name = strdup(name);
-	if (!iface->name) {
+	char* tmp_name = strdup(name);
+	if (!tmp_name) {
 		ERR(handle, "out of memory, "
 			"could not set interface name");
 		return STATUS_ERR;
 	}
+	free(iface->name);
+	iface->name = tmp_name;
 	return STATUS_SUCCESS;
 }
 
@@ -127,6 +129,7 @@ void sepol_iface_set_ifcon(
 	sepol_iface_t* iface, 
 	sepol_context_t* con) {
 
+	sepol_context_free(iface->netif_con);
 	iface->netif_con = con;
 }
 
@@ -139,6 +142,7 @@ void sepol_iface_set_msgcon(
 	sepol_iface_t* iface, 
 	sepol_context_t* con) {
 
+	sepol_context_free(iface->netmsg_con);
 	iface->netmsg_con = con;
 }
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsepol/src/port_record.c new/libsepol/src/port_record.c
--- old/libsepol/src/port_record.c	2005-10-31 01:48:30.000000000 -0500
+++ new/libsepol/src/port_record.c	2005-10-31 04:58:00.000000000 -0500
@@ -199,5 +199,6 @@ sepol_context_t* sepol_port_get_con(sepo
 }
 
 void sepol_port_set_con(sepol_port_t* port, sepol_context_t* con) {
+	sepol_context_free(port->con);
 	port->con = con;
 }
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsepol/src/user_record.c new/libsepol/src/user_record.c
--- old/libsepol/src/user_record.c	2005-10-31 01:48:30.000000000 -0500
+++ new/libsepol/src/user_record.c	2005-10-31 05:36:13.000000000 -0500
@@ -95,11 +95,13 @@ int sepol_user_set_name(
 	sepol_user_t* user, 
 	const char* name) {
 
-	user->name = strdup(name);
-	if (!user->name) {
+	char* tmp_name = strdup(name);
+	if (!tmp_name) {
 		ERR(handle, "out of memory, could not set name");
 		return STATUS_ERR;
 	}
+	free(user->name);
+	user->name = tmp_name;
 	return STATUS_SUCCESS;
 }
 
@@ -113,12 +115,14 @@ int sepol_user_set_mlslevel(
 	sepol_user_t* user, 
 	const char* mls_level) {
 
-	user->mls_level = strdup(mls_level);
-	if (!user->mls_level) {
+	char* tmp_mls_level = strdup(mls_level);
+	if (!tmp_mls_level) {
 		ERR(handle, "out of memory, "
 			"could not set MLS default level");
 		return STATUS_ERR;
 	}
+	free(user->mls_level);
+	user->mls_level = tmp_mls_level;
 	return STATUS_SUCCESS;
 }
 
@@ -131,12 +135,14 @@ int sepol_user_set_mlsrange(
 	sepol_user_t* user, 
 	const char* mls_range) {
 
-	user->mls_range = strdup(mls_range);
-	if (!user->mls_range) {
+	char* tmp_mls_range = strdup(mls_range);
+	if (!tmp_mls_range) {
 		ERR(handle, "out of memory, "
 			"could not set MLS allowed range");
 		return STATUS_ERR;
 	}
+	free(user->mls_range);
+	user->mls_range = tmp_mls_range;
 	return STATUS_SUCCESS;
 }
 
@@ -154,9 +160,16 @@ int sepol_user_add_role(
 	sepol_user_t* user, 
 	const char* role) {
 
-	char* role_cp = strdup(role);
-	char* role_cp2 = strdup(role); 
-	char** roles_realloc = realloc(user->roles, 
+	char* role_cp;
+	char* role_cp2;
+	char** roles_realloc;
+
+	if (sepol_user_has_role(user, role))
+		return STATUS_SUCCESS;
+
+	role_cp = strdup(role);
+	role_cp2 = strdup(role); 
+	roles_realloc = realloc(user->roles, 
 		sizeof(char*) * (user->num_roles + 1));
 
 	if (!role_cp || !role_cp2 || !roles_realloc) 
@@ -165,7 +178,7 @@ int sepol_user_add_role(
 	user->num_roles++;
 	user->roles = roles_realloc;
 	user->roles[user->num_roles - 1] = role_cp;
-	if (!user->def_role)
+	if (user->def_role == NULL)
 		user->def_role = role_cp2;
 	else
 		free(role_cp2);
@@ -196,23 +209,36 @@ int sepol_user_set_roles(
 	size_t num_roles) {
 
 	size_t i;
-	char** tmp_roles =
-		(char**) calloc(1, sizeof(char*) * num_roles);
+
+	/* First, make a copy */
+	char** tmp_roles = (char**) calloc(1, sizeof(char*) * num_roles);
 	if (!tmp_roles) 
 		goto omem;
-	
+
 	for (i = 0; i < num_roles; i++) {
 		tmp_roles[i] = strdup(roles_arr[i]); 
 		if (!tmp_roles[i])
 			goto omem;	
 	}
 
+	/* Try to set defrole - there should be no failures following
+	 * this call, since the old def role is not saved */
+	if (sepol_user_set_defrole(handle, user, tmp_roles[0]) < 0)
+		goto err;
+
+	/* Apply other changes */
+	for (i = 0; i < user->num_roles; i++)
+		free(user->roles[i]);
+	free(user->roles);
 	user->roles = tmp_roles;
 	user->num_roles = num_roles;
 	return STATUS_SUCCESS;
 
 	omem:
-	ERR(handle, "out of memory, could not "
+	ERR(handle, "out of memory");
+
+	err:
+	ERR(handle, "could not "
 		"allocate roles array for user %s", user->name);
 
 	if (tmp_roles) {
@@ -257,37 +283,39 @@ int sepol_user_del_role(
 	sepol_user_t* user, 
 	const char* role) {
 
+	int change_defrole = 0;
+	char* tmp_defrole = NULL;
 	size_t i;
+
 	for (i = 0; i < user->num_roles; i++) {
 		if (!strcmp(user->roles[i], role)) {
 
-			if (user->num_roles == 1) {
-				ERR(handle,	
-					"cannot delete last role "
-					"for user %s", user->name);
-				goto err;
+			/* Will replace default role */
+			if (user->num_roles > 1 && !strcmp(user->def_role, role))  {
+				tmp_defrole = strdup(user->roles[0]);
+				if (!tmp_defrole) {
+					ERR(handle, 
+						"out of memory, could not allocate "
+						"new default role");
+					return STATUS_ERR;
+				}
+				change_defrole = 1;
 			}
 
+			/* Apply changes */
 			free(user->roles[i]);
-			user->roles[i] = user->roles[user->num_roles-1];
+			user->roles[i] = user->roles[user->num_roles-1];			
 			user->num_roles--;
-
-			if (!strcmp(user->def_role, role))  {
+			if (change_defrole) {
 				free(user->def_role);
-				user->def_role = strdup(user->roles[0]);
-				if (!user->def_role)
-					goto omem;
+				user->def_role = tmp_defrole;
 			}
+
 			return STATUS_SUCCESS;
 		}
 	}
 
-	omem:
-	ERR(handle, "out of memory");
-	
-	err:
-	ERR(handle, "coult not allocate new default role");
-	return STATUS_ERR;
+	return STATUS_SUCCESS;
 }
 
 int sepol_user_set_defrole(
@@ -295,35 +323,22 @@ int sepol_user_set_defrole(
 	sepol_user_t* user, 
 	const char* role) {
 
-	char* old_defrole = NULL;
-
-	/* Backup previous default role */
-	if (user->def_role)
-		old_defrole = user->def_role;
-
-	/* Set as default */
-	user->def_role = strdup(role);
-	if (!user->def_role)
-		goto omem;		
-
-        /* Add the role if we don't have it */
-	if (!sepol_user_has_role(user, role)) {
-		if (sepol_user_add_role(handle, user, role) < 0)
-			goto err;
-	}
+	char* tmp_defrole = strdup(role);
+	if (!tmp_defrole)
+		goto omem;
 
-	/* Free old role */
-	free(old_defrole);
+	if (sepol_user_add_role(handle, user, role) < 0)
+		goto err;
 
+	free(user->def_role);
+	user->def_role = tmp_defrole;
 	return STATUS_SUCCESS;
 
 	omem:
 	ERR(handle, "out of memory");
 	
 	err:
-	free(user->def_role);
-	user->def_role = old_defrole;
-
+	free(tmp_defrole);
 	ERR(handle, "could not set default role for %s to %s", 
 		user->name, role);
 	return STATUS_ERR;

--------------040000000903000402060305--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
