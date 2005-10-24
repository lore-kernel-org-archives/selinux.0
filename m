Message-ID: <435D5173.2000301@cornell.edu>
Date: Mon, 24 Oct 2005 17:26:11 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL 2 ] Count functions
Content-Type: multipart/mixed;
 boundary="------------090107020805010501070103"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090107020805010501070103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

- implements count() for users, ports, booleans, and interfaces.

I think that completes the interface for now.
delete() ... won't be implemented at this time, since changes are done 
by modify or set on commit.
list() - I'll implement on top of iterate in semanage.

next:
- must pass the handle everywhere
- must fix the port modify() function to do the right thing

--------------090107020805010501070103
Content-Type: text/x-patch;
 name="libsepol.count.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.count.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/booleans.h new/libsepol/include/sepol/booleans.h
--- old/libsepol/include/sepol/booleans.h	2005-10-24 17:22:38.000000000 -0400
+++ new/libsepol/include/sepol/booleans.h	2005-10-24 17:10:43.000000000 -0400
@@ -33,6 +33,11 @@ extern int sepol_bool_set (
 	sepol_bool_key_t* key,
 	sepol_bool_t* data);
 
+/* Return the number of booleans */
+extern int sepol_bool_count(
+	sepol_policydb_t* p,
+	int* response);
+
 /* Check if the specified boolean exists */
 extern int sepol_bool_exists(
 	sepol_policydb_t* policydb,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/interfaces.h new/libsepol/include/sepol/interfaces.h
--- old/libsepol/include/sepol/interfaces.h	2005-10-24 17:22:38.000000000 -0400
+++ new/libsepol/include/sepol/interfaces.h	2005-10-24 17:11:22.000000000 -0400
@@ -5,6 +5,11 @@
 #include <sepol/iface_record.h>
 #include <stddef.h>
 
+/* Return the number of interfaces */
+extern int sepol_iface_count(
+	sepol_policydb_t* p,
+	int* response);
+
 /* Check if an interface exists */
 extern int sepol_iface_exists(
 	sepol_policydb_t* policydb,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/ports.h new/libsepol/include/sepol/ports.h
--- old/libsepol/include/sepol/ports.h	2005-10-24 17:22:38.000000000 -0400
+++ new/libsepol/include/sepol/ports.h	2005-10-24 17:11:02.000000000 -0400
@@ -5,6 +5,11 @@
 #include <sepol/port_record.h>
 #include <stddef.h>
 
+/* Return the number of ports */
+extern int sepol_port_count(
+	sepol_policydb_t* p,
+	int* response);
+
 /* Check if a port exists */
 extern int sepol_port_exists(
 	sepol_policydb_t* policydb,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/include/sepol/users.h new/libsepol/include/sepol/users.h
--- old/libsepol/include/sepol/users.h	2005-10-24 17:22:38.000000000 -0400
+++ new/libsepol/include/sepol/users.h	2005-10-24 17:06:56.000000000 -0400
@@ -29,6 +29,11 @@ extern int sepol_user_modify(
 	sepol_user_key_t* key,
 	sepol_user_t* data);
 
+/* Return the number of users */
+extern int sepol_user_count(
+	sepol_policydb_t* p,
+	int* response);
+
 /* Check if the specified user exists */
 extern int sepol_user_exists(
 	sepol_policydb_t* policydb,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/booleans.c new/libsepol/src/booleans.c
--- old/libsepol/src/booleans.c	2005-10-24 17:22:39.000000000 -0400
+++ new/libsepol/src/booleans.c	2005-10-24 17:05:48.000000000 -0400
@@ -102,6 +102,15 @@ int sepol_bool_set (
 	return STATUS_ERR;
 }
 
+int sepol_bool_count(
+	sepol_policydb_t* p,
+	int* response) {
+
+	policydb_t* policydb = &p->p;
+	*response = policydb->p_bools.nprim;
+	return STATUS_SUCCESS;
+}
+
 int sepol_bool_exists(
 	sepol_policydb_t* p,
 	sepol_bool_key_t* key,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/interfaces.c new/libsepol/src/interfaces.c
--- old/libsepol/src/interfaces.c	2005-10-24 17:22:39.000000000 -0400
+++ new/libsepol/src/interfaces.c	2005-10-24 17:11:53.000000000 -0400
@@ -201,6 +201,23 @@ int sepol_iface_modify(
 	return STATUS_ERR;
 }
 
+/* Return the number of interfaces */
+extern int sepol_iface_count(
+	sepol_policydb_t* p,
+	int* response) {
+
+	int count = 0;
+	ocontext_t *c, *head;
+	policydb_t* policydb = &p->p;
+
+	head = policydb->ocontexts[OCON_NETIF];
+	for (c =  head; c != NULL; c = c->next) 
+		count++;
+
+	*response = count;
+	return STATUS_SUCCESS;
+}
+
 int sepol_iface_iterate(
 	sepol_policydb_t* p,
 	int (*fn)(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2005-10-24 17:22:39.000000000 -0400
+++ new/libsepol/src/ports.c	2005-10-24 17:12:11.000000000 -0400
@@ -130,6 +130,23 @@ static int port_to_record (
 	return STATUS_ERR;
 }
 
+/* Return the number of ports */
+extern int sepol_port_count(
+	sepol_policydb_t* p,
+	int* response) {
+
+	int count = 0;
+	ocontext_t *c, *head;
+	policydb_t* policydb = &p->p;
+
+	head = policydb->ocontexts[OCON_PORT];
+	for (c =  head; c != NULL; c = c->next)
+		count++;
+
+	*response = count;
+	return STATUS_SUCCESS;
+}
+
 /* Check if a port exists */
 int sepol_port_exists (
 	sepol_policydb_t* p,
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude direct_api.c --exclude semanage_store.c --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2005-10-24 17:22:39.000000000 -0400
+++ new/libsepol/src/users.c	2005-10-24 17:05:08.000000000 -0400
@@ -312,6 +312,15 @@ int sepol_user_exists(
 	return STATUS_SUCCESS;
 }
 
+int sepol_user_count(
+	sepol_policydb_t* p,
+	int* response) {
+
+	policydb_t* policydb = &p->p;
+	*response = policydb->p_users.nprim;
+	return STATUS_SUCCESS;
+}
+
 int sepol_user_query(
 	sepol_policydb_t* p,
 	sepol_user_key_t* key,

--------------090107020805010501070103--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
