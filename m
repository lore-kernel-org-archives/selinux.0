Message-ID: <4365FA41.8010302@cornell.edu>
Date: Mon, 31 Oct 2005 06:04:33 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL 3 ] Improve/fix sepol_user_set_roles
Content-Type: multipart/mixed;
 boundary="------------000107080302030400020107"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000107080302030400020107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

- fix set_roles to properly handle num_roles = 0
- simplify a bit...



--------------000107080302030400020107
Content-Type: text/x-patch;
 name="libsepol.set_roles.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.set_roles.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsepol/src/user_record.c new/libsepol/src/user_record.c
--- old/libsepol/src/user_record.c	2005-10-31 05:49:40.000000000 -0500
+++ new/libsepol/src/user_record.c	2005-10-31 06:01:54.000000000 -0500
@@ -209,37 +209,41 @@ int sepol_user_set_roles(
 	size_t num_roles) {
 
 	size_t i;
+	char** tmp_roles = NULL;
+	char* tmp_def_role = NULL;
 
-	/* First, make a copy */
-	char** tmp_roles = (char**) calloc(1, sizeof(char*) * num_roles);
-	if (!tmp_roles) 
-		goto omem;
+	if (num_roles > 0) {
 
-	for (i = 0; i < num_roles; i++) {
-		tmp_roles[i] = strdup(roles_arr[i]); 
-		if (!tmp_roles[i])
-			goto omem;	
-	}
+		/* First, make a copy */
+		tmp_roles = (char**) calloc(1, sizeof(char*) * num_roles);
+		if (!tmp_roles) 
+			goto omem;
 
-	/* Try to set defrole - there should be no failures following
-	 * this call, since the old def role is not saved */
-	if (sepol_user_set_defrole(handle, user, tmp_roles[0]) < 0)
-		goto err;
+		for (i = 0; i < num_roles; i++) {
+			tmp_roles[i] = strdup(roles_arr[i]); 
+			if (!tmp_roles[i])
+				goto omem;	
+		}
 
+		tmp_def_role = strdup(tmp_roles[0]);
+		if (!tmp_def_role) 
+			goto omem;
+	}
+	
 	/* Apply other changes */
 	for (i = 0; i < user->num_roles; i++)
 		free(user->roles[i]);
 	free(user->roles);
+	free(user->def_role);
 	user->roles = tmp_roles;
 	user->num_roles = num_roles;
+	user->def_role = tmp_def_role;
+
 	return STATUS_SUCCESS;
 
 	omem:
-	ERR(handle, "out of memory");
-
-	err:
-	ERR(handle, "could not "
-		"allocate roles array for user %s", user->name);
+	ERR(handle, "out of memory, could not allocate roles array for"
+		"user %s", user->name);
 
 	if (tmp_roles) {
 		for (i = 0; i < num_roles; i++ ) {
@@ -247,8 +251,9 @@ int sepol_user_set_roles(
 				break;
 			free(tmp_roles[i]);
 		}
-		free(tmp_roles);
 	}
+	free(tmp_roles);
+	free(tmp_def_role);
 	return STATUS_ERR;	
 }
 

--------------000107080302030400020107--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
