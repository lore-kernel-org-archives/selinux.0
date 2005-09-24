Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8QEQ6Ns013419
	for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2005 10:26:06 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8QEKquQ018391
	for <selinux@tycho.nsa.gov>; Mon, 26 Sep 2005 14:20:52 GMT
Message-ID: <4334E273.9070703@cornell.edu>
Date: Sat, 24 Sep 2005 01:21:55 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: dwalsh@redhat.com
Subject: [ SEPOL ] Extract user records from binary policy
Content-Type: multipart/mixed;
 boundary="------------060503080106050609040502"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060503080106050609040502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch does the following:

- makes a couple of internal functions static
- un-inlines a boolean function

- changes existing sepol_valid_users_list, which returns tha names of 
valid users, to  sepol_list_users, which returns an array of records, 
more suitable for semanage dbase operations (plus that includes all the 
data, not just names). This is fine for a short list users - may not be 
the appropriate thing to do for something like allow rules.

I did actually try this, so it should work :)

Here's the old genusers loading the MLS users, and then list_users 
extracting the info back in record format:

[phantom@cobra src]$ ./test /etc/selinux/mls/policy/policy.19
User: system_u with default MLS level s2, range s0-s9:c0.c127, roles: 
system_r
User: user_u with default MLS level s2, range s2, roles: user_r
User: root with default MLS level s2, range s0-s9:c0.c127, roles: 
system_r sysadm_r staff_r secadm_r
./test:  Warning! unable to get boolean names:  No such file or directory


--------------060503080106050609040502
Content-Type: text/x-patch;
 name="libsepol.users.list.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.users.list.diff"

diff -Nrua libsepol.new/include/sepol/users.h libsepol/include/sepol/users.h
--- libsepol.new/include/sepol/users.h	2005-09-14 11:44:44.000000000 -0400
+++ libsepol/include/sepol/users.h	2005-09-23 21:55:52.000000000 -0400
@@ -32,10 +32,10 @@
 	policydb_t* policydb,
 	const char* role);
 
-/* Obtain an array of all valid users/roles */
-extern int sepol_get_valid_users(
+/* Obtain an array of all valid users */
+extern int sepol_user_list(
 	policydb_t* policydb,
-	char*** users,
+	sepol_user_t** users,
 	size_t* nusers);
 
 extern int sepol_get_valid_roles(
@@ -43,4 +43,4 @@
 	char*** roles, 
 	size_t* nroles);
 
-#endif /* _SEPOL_USERS_H_ */
+#endif 
diff -Nrua libsepol.new/src/booleans.c libsepol/src/booleans.c
--- libsepol.new/src/booleans.c	2005-09-21 10:42:24.000000000 -0400
+++ libsepol/src/booleans.c	2005-09-23 20:42:45.000000000 -0400
@@ -11,7 +11,7 @@
 #include <sepol/conditional.h>
 #include <sepol/boolean_record.h>
 
-static inline int bool_update (
+static int bool_update (
 	policydb_t* policydb,
 	sepol_bool_t boolean) {
 
diff -Nrua libsepol.new/src/interfaces.c libsepol/src/interfaces.c
--- libsepol.new/src/interfaces.c	2005-09-21 10:42:24.000000000 -0400
+++ libsepol/src/interfaces.c	2005-09-23 20:43:05.000000000 -0400
@@ -12,7 +12,7 @@
 
 /* Create a low level interface structure from
  * a high level representation */
-int sepol_iface_struct_create(
+static int sepol_iface_struct_create(
 	policydb_t* policydb,
 	ocontext_t** iface,
 	sepol_iface_t data) {
diff -Nrua libsepol.new/src/ports.c libsepol/src/ports.c
--- libsepol.new/src/ports.c	2005-08-02 09:17:09.000000000 -0400
+++ libsepol/src/ports.c	2005-09-23 20:42:12.000000000 -0400
@@ -25,7 +25,7 @@
 
 /* Create a low level port structure from
  * a high level representation */
-int sepol_port_struct_create(
+static int sepol_port_struct_create(
 	policydb_t* policydb,
 	ocontext_t** port,
 	sepol_port_t data) {
diff -Nrua libsepol.new/src/users.c libsepol/src/users.c
--- libsepol.new/src/users.c	2005-09-21 10:42:24.000000000 -0400
+++ libsepol/src/users.c	2005-09-24 01:01:00.000000000 -0400
@@ -257,8 +257,7 @@
 				mls_level, name);
 			goto err;
 		}
-		memcpy(&usrdatum->dfltlevel, &context.range.level[0], 
-		        sizeof(usrdatum->dfltlevel));
+		memcpy(&usrdatum->dfltlevel, &context.range.level[0], sizeof(mls_level_t));
 		
 		/* MLS range */
 		context_init(&context);
@@ -274,7 +273,7 @@
 				mls_range, name);
 			goto err;
 		}
-		memcpy(&usrdatum->range, &context.range, sizeof(usrdatum->range));
+		memcpy(&usrdatum->range, &context.range, sizeof(mls_range_t));
 	}
 
 	/* If there are no errors, and this is a new user, add the user to policy */
@@ -368,18 +367,80 @@
 
 /* Fill an array with all valid users */
 
-int sepol_get_valid_users(policydb_t* policydb, char*** users, size_t* nusers) {
+int sepol_user_list(
+	policydb_t* policydb, 
+	sepol_user_t** users,
+	size_t* nusers) {
+
 	size_t tmp_nusers = policydb->p_users.nprim;
-	char **tmp_users = (char**) malloc(tmp_nusers * sizeof(char*));
-	char **ptr;
+	sepol_user_t* tmp_users = 
+		(sepol_user_t*) calloc(tmp_nusers, sizeof(sepol_user_t));
+
+	sepol_user_t* ptr;
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
+			int len;
+
+			context_init(&context);
+			memcpy(&context.range.level[0], 
+				&usrdatum->dfltlevel, sizeof(mls_level_t));
+			memcpy(&context.range.level[1],
+				&usrdatum->dfltlevel, sizeof(mls_level_t));	
+			len = mls_compute_context_len(policydb, &context);
+			str = (char*) malloc(len);
+			if (str == NULL)
+				goto omem;
+			mls_sid_to_context(policydb, &context, &str);				
+			str -= len;
+			
+			if ( sepol_user_set_mlslevel(tmp_users[i], str + 1) < 0 ) {
+				free(str);
+				goto err;
+			}
+			
+			context_init(&context);
+			memcpy(&context.range, &usrdatum->range, sizeof(mls_range_t));
+			len = mls_compute_context_len(policydb, &context);
+			mls_sid_to_context(policydb, &context, &str);
+			str -= len;
+	
+			if ( sepol_user_set_mlsrange(tmp_users[i], str + 1) < 0) {
+				free(str);
+				goto err;
+			}
+
+			free(str);
+		}
 	}
 
 	*nusers = tmp_nusers;
@@ -388,12 +449,14 @@
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

--------------060503080106050609040502--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
