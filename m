Message-ID: <43AB9FCB.70403@cornell.edu>
Date: Fri, 23 Dec 2005 01:57:15 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [SEMANAGE][SEPOL] Support ordering of records in compare function
Content-Type: multipart/mixed;
 boundary="------------050701020702080501060008"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050701020702080501060008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch changes the compare functions for user/boolean/iface/seuser 
(and a fixme for ports), to support ordering of records (by returning 
-1, 1, or 0, and not just 0 or -1). This is necessary to sort records in 
a reasonable amount of time, which I need to do to support a join operation.


--------------050701020702080501060008
Content-Type: text/x-patch;
 name="libsemanage4.libsepol.ordering.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage4.libsepol.ordering.diff"

diff -Naurp --exclude-from excludes old/libsemanage/src/database.h new/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2005-11-04 15:37:49.000000000 -0500
+++ new/libsemanage/src/database.h	2005-12-23 01:48:17.000000000 -0500
@@ -37,7 +37,9 @@ typedef struct record_table {
 	void (*key_free) (
 		record_key_t* key);
 
-	/* Return 0 if record can be matched against key, and 1 otherwise */
+	/* Return 0 if the record matches the key, 
+	 * -1 if the key represents a record that should
+	 * be ordered before this record, and 1 if vice-versa */
 	int (*compare) (
 		record_t* rec, 
 		record_key_t* key);
diff -Naurp --exclude-from excludes old/libsemanage/src/seuser_record.c new/libsemanage/src/seuser_record.c
--- old/libsemanage/src/seuser_record.c	2005-12-23 01:01:49.000000000 -0500
+++ new/libsemanage/src/seuser_record.c	2005-12-23 01:49:55.000000000 -0500
@@ -90,10 +90,8 @@ hidden_def(semanage_seuser_key_free)
 int semanage_seuser_compare(
 	semanage_seuser_t* seuser,
 	semanage_seuser_key_t* key) {
-	
-	if (!strcmp(seuser->name, key->name))
-		return 0;
-	return 1;
+
+	return strcmp(seuser->name, key->name);	
 }
 hidden_def(semanage_seuser_compare)
 
diff -Naurp --exclude-from excludes old/libsepol/src/boolean_record.c new/libsepol/src/boolean_record.c
--- old/libsepol/src/boolean_record.c	2005-11-01 17:32:58.000000000 -0500
+++ new/libsepol/src/boolean_record.c	2005-12-23 01:44:42.000000000 -0500
@@ -68,10 +68,8 @@ void sepol_bool_key_free(sepol_bool_key_
 int sepol_bool_compare(
 	sepol_bool_t* boolean,
 	sepol_bool_key_t* key) {
-	
-	if (!strcmp(boolean->name, key->name))
-		return 0;
-	return 1;
+
+	return strcmp(boolean->name, key->name);
 }
 
 /* Name */
diff -Naurp --exclude-from excludes old/libsepol/src/iface_record.c new/libsepol/src/iface_record.c
--- old/libsepol/src/iface_record.c	2005-11-01 17:32:59.000000000 -0500
+++ new/libsepol/src/iface_record.c	2005-12-23 01:45:04.000000000 -0500
@@ -73,10 +73,8 @@ void sepol_iface_key_free(sepol_iface_ke
 int sepol_iface_compare(
 	sepol_iface_t* iface, 
 	sepol_iface_key_t* key) {
-	
-	if (!strcmp(iface->name, key->name)) 
-		return 0;
-	return 1;
+
+	return strcmp(iface->name, key->name);
 }
 
 /* Create */
diff -Naurp --exclude-from excludes old/libsepol/src/port_record.c new/libsepol/src/port_record.c
--- old/libsepol/src/port_record.c	2005-11-01 17:32:59.000000000 -0500
+++ new/libsepol/src/port_record.c	2005-12-23 01:45:57.000000000 -0500
@@ -84,6 +84,8 @@ int sepol_port_compare(
 	sepol_port_t* port, 
 	sepol_port_key_t* key) {
 
+	/* FIXME: needs to support ordering of ports (-1, 0, 1) */
+
 	if ((port->low <= key->low) && 
 	    (port->high >= key->high) &&
 	    (port->proto == key->proto))
diff -Naurp --exclude-from excludes old/libsepol/src/user_record.c new/libsepol/src/user_record.c
--- old/libsepol/src/user_record.c	2005-12-05 15:00:37.000000000 -0500
+++ new/libsepol/src/user_record.c	2005-12-23 01:44:24.000000000 -0500
@@ -78,10 +78,8 @@ void sepol_user_key_free(sepol_user_key_
 int sepol_user_compare(
 	sepol_user_t* user,
 	sepol_user_key_t* key) {
-	
-	if (!strcmp(user->name, key->name))
-		return 0;
-	return 1;
+
+	return strcmp(user->name, key->name);
 }
 
 /* Name */

--------------050701020702080501060008--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
