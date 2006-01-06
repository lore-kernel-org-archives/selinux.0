Message-ID: <43BDBE46.6050504@cornell.edu>
Date: Thu, 05 Jan 2006 19:48:06 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: [SEPOL][SEMANAGE] Compare2 functions
Content-Type: multipart/mixed;
 boundary="------------000200080900050607050802"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000200080900050607050802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, the following patch adds compare2 functions, which compare record 
<--> record, instead of record <--> key.
Yes, the name is rather annoying. I wanted compare for records, and 
compare_key for the key, but that would be an api change. This seems 
like the next best thing.

The compare2 function is necessary, because otherwise to compare two 
records you need to extract a key, which does a malloc, which is 
inefficient, and a pain. More importantly, it may fail, so it takes a 
handle, and qsort() can't pass in a void* arg to comparator, so it can't 
pass a handle (unless you wrap each port in an additional structure or 
something crazy like that).

Sorting is necessary to check for overlapping port ranges in a 
reasonable amount of time. It is also a prerequisite for a join 
operation (which I am still not clear how to do properly without adding 
lots of complexity).

--------------000200080900050607050802
Content-Type: text/x-patch;
 name="libsemanage.libsepol.compare2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.libsepol.compare2.diff"

diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/boolean_record.h new/libsemanage/include/semanage/boolean_record.h
--- old/libsemanage/include/semanage/boolean_record.h	2006-01-05 14:41:08.000000000 -0500
+++ new/libsemanage/include/semanage/boolean_record.h	2006-01-05 19:33:09.000000000 -0500
@@ -30,6 +30,10 @@ extern void semanage_bool_key_free(
 extern int semanage_bool_compare(
 	const semanage_bool_t* boolean, 
 	const semanage_bool_key_t* key);
+
+extern int semanage_bool_compare2(
+	const semanage_bool_t* boolean,
+	const semanage_bool_t* boolean2);
 	
 /* Name */
 extern const char* semanage_bool_get_name(
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/fcontext_record.h new/libsemanage/include/semanage/fcontext_record.h
--- old/libsemanage/include/semanage/fcontext_record.h	2006-01-05 14:41:08.000000000 -0500
+++ new/libsemanage/include/semanage/fcontext_record.h	2006-01-05 19:33:59.000000000 -0500
@@ -19,6 +19,10 @@ extern int semanage_fcontext_compare(
 	const semanage_fcontext_t* fcontext, 
 	const semanage_fcontext_key_t* key);
 
+extern int semanage_fcontext_compare2(
+	const semanage_fcontext_t* fcontext,
+	const semanage_fcontext_t* fcontext2);
+
 extern int semanage_fcontext_key_create(
 	semanage_handle_t* handle,
 	const char* expr,
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/iface_record.h new/libsemanage/include/semanage/iface_record.h
--- old/libsemanage/include/semanage/iface_record.h	2006-01-05 14:41:08.000000000 -0500
+++ new/libsemanage/include/semanage/iface_record.h	2006-01-05 19:34:20.000000000 -0500
@@ -19,6 +19,10 @@ extern int semanage_iface_compare(
 	const semanage_iface_t* iface, 
 	const semanage_iface_key_t* key);
 
+extern int semanage_iface_compare2(
+	const semanage_iface_t* iface,
+	const semanage_iface_t* iface2);
+
 extern int semanage_iface_key_create(
 	semanage_handle_t* handle,
 	const char* name,
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/port_record.h new/libsemanage/include/semanage/port_record.h
--- old/libsemanage/include/semanage/port_record.h	2006-01-05 14:41:08.000000000 -0500
+++ new/libsemanage/include/semanage/port_record.h	2006-01-05 19:34:42.000000000 -0500
@@ -22,6 +22,10 @@ extern int semanage_port_compare(
 	const semanage_port_t* port, 
 	const semanage_port_key_t* key);
 
+extern int semanage_port_compare2(
+	const semanage_port_t* port,
+	const semanage_port_t* port2);
+
 extern int semanage_port_key_create(
 	semanage_handle_t* handle, 
 	int low, int high, int proto, 
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/seuser_record.h new/libsemanage/include/semanage/seuser_record.h
--- old/libsemanage/include/semanage/seuser_record.h	2006-01-05 14:41:08.000000000 -0500
+++ new/libsemanage/include/semanage/seuser_record.h	2006-01-05 19:35:08.000000000 -0500
@@ -27,6 +27,10 @@ extern void semanage_seuser_key_free(
 extern int semanage_seuser_compare(
 	const semanage_seuser_t* seuser, 
 	const semanage_seuser_key_t* key);
+
+extern int semanage_seuser_compare2(
+	const semanage_seuser_t* seuser,
+	const semanage_seuser_t* seuser2);
 	
 /* Name */
 extern const char* semanage_seuser_get_name(
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/include/semanage/user_record.h new/libsemanage/include/semanage/user_record.h
--- old/libsemanage/include/semanage/user_record.h	2006-01-05 14:41:08.000000000 -0500
+++ new/libsemanage/include/semanage/user_record.h	2006-01-05 19:35:29.000000000 -0500
@@ -31,6 +31,10 @@ extern void semanage_user_key_free(
 extern int semanage_user_compare(
 	const semanage_user_t* user, 
 	const semanage_user_key_t* key);
+
+extern int semanage_user_compare2(
+	const semanage_user_t* user,
+	const semanage_user_t* user2);
 	
 /* Name */
 extern const char* semanage_user_get_name(
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/boolean_record.c new/libsemanage/src/boolean_record.c
--- old/libsemanage/src/boolean_record.c	2006-01-05 14:41:09.000000000 -0500
+++ new/libsemanage/src/boolean_record.c	2006-01-05 19:36:51.000000000 -0500
@@ -51,6 +51,13 @@ int semanage_bool_compare(
 	return sepol_bool_compare(boolean, key);
 }
 hidden_def(semanage_bool_compare)
+
+int semanage_bool_compare2(
+	const semanage_bool_t* boolean,
+	const semanage_bool_t* boolean2) {
+
+	return sepol_bool_compare2(boolean, boolean2);
+}
 	
 /* Name */
 const char* semanage_bool_get_name(
@@ -117,5 +124,6 @@ record_table_t SEMANAGE_BOOL_RTABLE = {
 	.key_free    = semanage_bool_key_free,
 	.clone       = semanage_bool_clone,
 	.compare     = semanage_bool_compare,
+	.compare2    = semanage_bool_compare2,
 	.free        = semanage_bool_free,
 };
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/database.h new/libsemanage/src/database.h
--- old/libsemanage/src/database.h	2006-01-05 14:41:09.000000000 -0500
+++ new/libsemanage/src/database.h	2006-01-05 19:36:29.000000000 -0500
@@ -44,6 +44,13 @@ typedef struct record_table {
 		const record_t* rec, 
 		const record_key_t* key);
 
+	/* Return 0 if the record matches record2,
+	 * -1 if record2 should be ordered before this record,
+	 * and 1 if vice-versa */
+	int (*compare2) (
+		const record_t* rec,
+		const record_t* rec2);
+
 	/* Deep-copy clone of this record */
 	int (*clone) (
 		struct semanage_handle* handle,
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/fcontext_record.c new/libsemanage/src/fcontext_record.c
--- old/libsemanage/src/fcontext_record.c	2006-01-05 14:41:09.000000000 -0500
+++ new/libsemanage/src/fcontext_record.c	2006-01-05 19:37:07.000000000 -0500
@@ -82,6 +82,14 @@ int semanage_fcontext_compare(
 		(fcontext->type == key->type);
 }
 
+int semanage_fcontext_compare2(
+	const semanage_fcontext_t* fcontext,
+	const semanage_fcontext_t* fcontext2) {
+
+	return strcmp(fcontext->expr, fcontext2->expr) &&
+		(fcontext->type == fcontext2->type);
+}
+
 /* Create */
 int semanage_fcontext_create(
 	semanage_handle_t* handle,
@@ -227,5 +235,6 @@ record_table_t SEMANAGE_FCONTEXT_RTABLE 
 	.key_free    = semanage_fcontext_key_free,
 	.clone       = semanage_fcontext_clone,
 	.compare     = semanage_fcontext_compare,
+	.compare2    = semanage_fcontext_compare2,
 	.free        = semanage_fcontext_free,
 };
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/fcontexts_local.c new/libsemanage/src/fcontexts_local.c
--- old/libsemanage/src/fcontexts_local.c	2006-01-05 17:04:32.000000000 -0500
+++ new/libsemanage/src/fcontexts_local.c	2006-01-05 19:11:19.000000000 -0500
@@ -145,4 +145,3 @@ int hidden semanage_fcontext_validate_lo
 	arg.policydb = policydb;
 	return semanage_fcontext_iterate_local(handle, validate_handler, &arg);
 }
-
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/iface_record.c new/libsemanage/src/iface_record.c
--- old/libsemanage/src/iface_record.c	2006-01-05 14:41:09.000000000 -0500
+++ new/libsemanage/src/iface_record.c	2006-01-05 19:37:21.000000000 -0500
@@ -32,6 +32,13 @@ int semanage_iface_compare(
 }
 hidden_def(semanage_iface_compare)
 
+int semanage_iface_compare2(
+	const semanage_iface_t* iface,
+	const semanage_iface_t* iface2) {
+
+	return sepol_iface_compare2(iface, iface2);
+}
+
 int semanage_iface_key_create(
 	semanage_handle_t* handle,
 	const char* name,
@@ -136,5 +143,6 @@ record_table_t SEMANAGE_IFACE_RTABLE = {
 	.key_free    = semanage_iface_key_free,
 	.clone       = semanage_iface_clone,
 	.compare     = semanage_iface_compare,
+	.compare2    = semanage_iface_compare2,
 	.free        = semanage_iface_free,
 };
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/port_record.c new/libsemanage/src/port_record.c
--- old/libsemanage/src/port_record.c	2006-01-05 14:41:09.000000000 -0500
+++ new/libsemanage/src/port_record.c	2006-01-05 19:37:34.000000000 -0500
@@ -31,6 +31,13 @@ int semanage_port_compare(
 	return sepol_port_compare(port, key);
 }
 
+int semanage_port_compare2(
+	const semanage_port_t* port,
+	const semanage_port_t* port2) {
+
+	return sepol_port_compare2(port, port2);
+}
+
 int semanage_port_key_create(
 	semanage_handle_t* handle,
 	int low, int high, int proto, 
@@ -143,5 +150,6 @@ record_table_t SEMANAGE_PORT_RTABLE = {
 	.key_free    = semanage_port_key_free,
 	.clone       = semanage_port_clone,
 	.compare     = semanage_port_compare,
+	.compare2    = semanage_port_compare2,
 	.free        = semanage_port_free,
 };
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/seuser_record.c new/libsemanage/src/seuser_record.c
--- old/libsemanage/src/seuser_record.c	2006-01-05 14:41:09.000000000 -0500
+++ new/libsemanage/src/seuser_record.c	2006-01-05 19:38:24.000000000 -0500
@@ -19,16 +19,6 @@ typedef struct semanage_seuser_key recor
 #include <semanage/handle.h>
 #include "database.h"
 
-/* Record base functions */
-record_table_t SEMANAGE_SEUSER_RTABLE = {
-	.create      = semanage_seuser_create,
-	.key_extract = semanage_seuser_key_extract,
-	.key_free    = semanage_seuser_key_free,
-	.clone       = semanage_seuser_clone,
-	.compare     = semanage_seuser_compare,
-	.free        = semanage_seuser_free,
-};
-
 struct semanage_seuser {
 	/* This user's name */
 	char* name;
@@ -97,6 +87,13 @@ int semanage_seuser_compare(
 }
 hidden_def(semanage_seuser_compare)
 
+int semanage_seuser_compare2(
+	const semanage_seuser_t* seuser,
+	const semanage_seuser_t* seuser2) {
+
+	return strcmp(seuser->name, seuser2->name);
+}
+
 /* Name */
 const char* semanage_seuser_get_name(
 	const semanage_seuser_t* seuser) {
@@ -235,3 +232,14 @@ void semanage_seuser_free(
 	free(seuser);
 }
 hidden_def(semanage_seuser_free)
+
+/* Record base functions */
+record_table_t SEMANAGE_SEUSER_RTABLE = {
+	.create      = semanage_seuser_create,
+	.key_extract = semanage_seuser_key_extract,
+	.key_free    = semanage_seuser_key_free,
+	.clone       = semanage_seuser_clone,
+	.compare     = semanage_seuser_compare,
+	.compare2    = semanage_seuser_compare2,
+	.free        = semanage_seuser_free,
+};
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsemanage/src/user_record.c new/libsemanage/src/user_record.c
--- old/libsemanage/src/user_record.c	2006-01-05 14:41:09.000000000 -0500
+++ new/libsemanage/src/user_record.c	2006-01-05 19:38:38.000000000 -0500
@@ -56,6 +56,13 @@ int semanage_user_compare(
 	return sepol_user_compare(user, key);
 }
 hidden_def(semanage_user_compare)
+
+int semanage_user_compare2(
+	const semanage_user_t* user,
+	const semanage_user_t* user2) {
+
+	return sepol_user_compare2(user, user2);
+}
 	
 /* Name */
 const char* semanage_user_get_name(
@@ -188,5 +195,6 @@ record_table_t SEMANAGE_USER_RTABLE = {
 	.key_free    = semanage_user_key_free,
 	.clone       = semanage_user_clone,
 	.compare     = semanage_user_compare,
+	.compare2    = semanage_user_compare2,
 	.free        = semanage_user_free,
 };
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/include/sepol/boolean_record.h new/libsepol/include/sepol/boolean_record.h
--- old/libsepol/include/sepol/boolean_record.h	2006-01-05 14:38:28.000000000 -0500
+++ new/libsepol/include/sepol/boolean_record.h	2006-01-05 19:26:48.000000000 -0500
@@ -30,6 +30,10 @@ extern void sepol_bool_key_free(
 extern int sepol_bool_compare(
 	const sepol_bool_t* boolean,
 	const sepol_bool_key_t* key);
+
+extern int sepol_bool_compare2(
+	const sepol_bool_t* boolean,
+	const sepol_bool_t* boolean2);
 	
 /* Name */
 extern const char* sepol_bool_get_name(
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/include/sepol/iface_record.h new/libsepol/include/sepol/iface_record.h
--- old/libsepol/include/sepol/iface_record.h	2006-01-05 14:38:28.000000000 -0500
+++ new/libsepol/include/sepol/iface_record.h	2006-01-05 19:28:06.000000000 -0500
@@ -14,6 +14,10 @@ extern int sepol_iface_compare(
 	const sepol_iface_t* iface, 
 	const sepol_iface_key_t* key);
 
+extern int sepol_iface_compare2(
+	const sepol_iface_t* iface,
+	const sepol_iface_t* iface2);
+
 extern void sepol_iface_key_unpack(
 	const sepol_iface_key_t* key,
 	const char** name);
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/include/sepol/port_record.h new/libsepol/include/sepol/port_record.h
--- old/libsepol/include/sepol/port_record.h	2006-01-05 14:38:28.000000000 -0500
+++ new/libsepol/include/sepol/port_record.h	2006-01-05 19:27:45.000000000 -0500
@@ -17,6 +17,10 @@ extern int sepol_port_compare(
 	const sepol_port_t* port, 
 	const sepol_port_key_t* key);
 
+extern int sepol_port_compare2(
+	const sepol_port_t* port,
+	const sepol_port_t* port2);
+
 extern int sepol_port_key_create(
 	sepol_handle_t* handle,
 	int low, int high, int proto,
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/include/sepol/user_record.h new/libsepol/include/sepol/user_record.h
--- old/libsepol/include/sepol/user_record.h	2006-01-05 14:38:29.000000000 -0500
+++ new/libsepol/include/sepol/user_record.h	2006-01-05 19:27:14.000000000 -0500
@@ -30,6 +30,10 @@ extern void sepol_user_key_free(
 extern int sepol_user_compare(
 	const sepol_user_t* user,
 	const sepol_user_key_t* key);
+
+extern int sepol_user_compare2(
+	const sepol_user_t* user,
+	const sepol_user_t* user2);
 	
 /* Name */
 extern const char* sepol_user_get_name(
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/src/boolean_record.c new/libsepol/src/boolean_record.c
--- old/libsepol/src/boolean_record.c	2006-01-05 14:38:29.000000000 -0500
+++ new/libsepol/src/boolean_record.c	2006-01-05 19:25:43.000000000 -0500
@@ -73,6 +73,13 @@ int sepol_bool_compare(
 	return strcmp(boolean->name, key->name);
 }
 
+int sepol_bool_compare2(
+	const sepol_bool_t* boolean,
+	const sepol_bool_t* boolean2) {
+
+	return strcmp(boolean->name, boolean2->name);
+}
+
 /* Name */
 const char* sepol_bool_get_name(
 	const sepol_bool_t* boolean) {
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/src/iface_record.c new/libsepol/src/iface_record.c
--- old/libsepol/src/iface_record.c	2006-01-05 14:38:29.000000000 -0500
+++ new/libsepol/src/iface_record.c	2006-01-05 19:26:18.000000000 -0500
@@ -78,6 +78,13 @@ int sepol_iface_compare(
 	return strcmp(iface->name, key->name);
 }
 
+int sepol_iface_compare2(
+	const sepol_iface_t* iface,
+	const sepol_iface_t* iface2) {
+
+	return strcmp(iface->name, iface2->name);
+}
+
 /* Create */
 int sepol_iface_create(
 	sepol_handle_t* handle,
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/src/port_record.c new/libsepol/src/port_record.c
--- old/libsepol/src/port_record.c	2006-01-05 14:38:29.000000000 -0500
+++ new/libsepol/src/port_record.c	2006-01-05 19:24:43.000000000 -0500
@@ -109,6 +109,34 @@ int sepol_port_compare(
 		return 1;
 }
 
+int sepol_port_compare2(
+	const sepol_port_t* port,
+	const sepol_port_t* port2) {
+
+	if ((port->low == port2->low) &&
+	    (port->high == port2->high) &&
+	    (port->proto == port2->proto))
+		return 0;
+
+	if (port->low < port2->low)
+		return -1;
+
+	else if (port2->low < port->low)
+		return 1;
+
+	else if (port->high < port2->high)
+		return -1;
+
+	else if (port2->high < port->high)
+		return 1;
+
+	else if (port->proto < port2->proto)
+		return -1;
+
+	else
+		return 1;
+}
+
 /* Port */
 int sepol_port_get_low(
 	const sepol_port_t* port) {
diff -Naurp --exclude ports_local.c --exclude-from excludes old/libsepol/src/user_record.c new/libsepol/src/user_record.c
--- old/libsepol/src/user_record.c	2006-01-05 14:38:29.000000000 -0500
+++ new/libsepol/src/user_record.c	2006-01-05 19:25:13.000000000 -0500
@@ -83,6 +83,13 @@ int sepol_user_compare(
 	return strcmp(user->name, key->name);
 }
 
+int sepol_user_compare2(
+	const sepol_user_t* user,
+	const sepol_user_t* user2) {
+
+	return strcmp(user->name, user2->name);
+}
+
 /* Name */
 const char* sepol_user_get_name(
 	const sepol_user_t* user) {

--------------000200080900050607050802--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
