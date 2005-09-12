Message-ID: <43256F48.7060909@cornell.edu>
Date: Mon, 12 Sep 2005 08:06:32 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: dwalsh@redhat.com, jbrindle@tresys.com
Subject: [ SEMANAGE ] Stub out user/port functionality
Content-Type: multipart/mixed;
 boundary="------------000307030703050302020401"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000307030703050302020401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch for libsemanage stubs out the functionality for managing
user and port records. This means simply editing the config files...
As discussed with Joshua, loading the users and ports into policy needs
to be accomplished at commit time, after linking in modules.

I'm still not entirely clear how all the pieces will fit together, but
I think it would be good to merge a stubbed-out skeleton...later we could
change it to make use of the planned semanage_handle_t.

The second patch fixes sepol headers to include stddef.h whenever size_t 
is used.


--------------000307030703050302020401
Content-Type: text/x-patch;
 name="libsemanage.stub.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.stub.diff"

diff -Naur libsemanage/include/semanage/ports.h libsemanage.new/include/semanage/ports.h
--- libsemanage/include/semanage/ports.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/include/semanage/ports.h	2005-09-12 07:58:00.000000000 -0400
@@ -0,0 +1,40 @@
+#ifndef _SEMANAGE_PORTS_H_
+#define _SEMANAGE_PORTS_H_
+
+#include <stddef.h>
+#include <semanage/port_record.h>
+
+extern int semanage_port_add(
+	semanage_port_key_t key,
+	semanage_port_t data);
+
+extern int semanage_port_modify(
+	semanage_port_key_t key,
+	semanage_port_t data);
+
+extern int semanage_port_del(
+	semanage_port_key_t key);
+
+extern int semanage_port_query(
+	semanage_port_key_t key,
+	semanage_port_t* response);
+
+extern int semanage_port_exists(
+	semanage_port_key_t key,
+	int* response);
+
+extern int semanage_port_count(
+	int* response);
+
+extern int semanage_port_iterate(
+	int (*handler) (semanage_port_key_t key,
+	                semanage_port_t record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_port_list(
+	semanage_port_key_t** keyset,
+	semanage_port_t** dataset,
+	size_t* count);
+
+#endif 
diff -Naur libsemanage/include/semanage/users.h libsemanage.new/include/semanage/users.h
--- libsemanage/include/semanage/users.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/include/semanage/users.h	2005-09-12 07:57:40.000000000 -0400
@@ -0,0 +1,40 @@
+#ifndef _SEMANAGE_USERS_H_
+#define _SEMANAGE_USERS_H_
+
+#include <stddef.h>
+#include <semanage/user_record.h>
+
+extern int semanage_user_add(
+	semanage_user_key_t key,
+	semanage_user_t data);
+
+extern int semanage_user_modify(
+	semanage_user_key_t key,
+	semanage_user_t data);
+
+extern int semanage_user_del(
+	semanage_user_key_t key);
+
+extern int semanage_user_query(
+	semanage_user_key_t key,
+	semanage_user_t* response);
+
+extern int semanage_user_exists(
+	semanage_user_key_t key,
+	int* response);
+
+extern int semanage_user_count(
+	int* response);
+
+extern int semanage_user_iterate(
+	int (*handler) (semanage_user_key_t key,
+	                semanage_user_t record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_user_list(
+	semanage_user_key_t** keyset,
+	semanage_user_t** dataset,
+	size_t* count);
+
+#endif 
diff -Naur libsemanage/src/database_file.c libsemanage.new/src/database_file.c
--- libsemanage/src/database_file.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/database_file.c	2005-09-12 07:59:48.000000000 -0400
@@ -0,0 +1,106 @@
+#include <stdlib.h>
+#include <stddef.h>
+#include "database.h"
+
+struct dbase_config {
+	/* Stub */
+};
+
+dbase_config_t* dbase[DBASE_COUNT];
+
+int dbase_add(
+	dbase_config_t* dconfig,
+	record_key_t key,
+	record_t data) {
+
+	/* Stub */
+	dconfig = NULL;
+	key = NULL;
+	data = NULL;
+	return -1;
+}
+
+int dbase_modify(
+	dbase_config_t* dconfig,
+	record_key_t key,
+	record_t data) {
+
+	/* Stub */
+	dconfig = NULL;
+	key = NULL;
+	data = NULL;
+	return -1;
+}
+
+int dbase_del(
+	dbase_config_t* dconfig,
+	record_key_t key) {
+	
+	/* Stub */
+	dconfig = NULL;
+	key = NULL;
+	return -1;
+}
+
+int dbase_query(
+	dbase_config_t* dconfig,
+	record_key_t key,
+	record_t* response) {
+	
+	/* Stub */
+	dconfig = NULL;
+	key = NULL;
+	response = NULL;
+	return -1;
+}
+
+int dbase_exists(
+	dbase_config_t* dconfig,
+	record_key_t key,
+	int* response) {
+	
+	/* Stub */
+	dconfig = NULL;
+	key = NULL;
+	response = NULL;
+	return -1;
+}
+
+int dbase_count(
+	dbase_config_t* dconfig,
+	int* response) {
+	
+	/* Stub */
+	dconfig = NULL;
+	response = NULL;
+	return -1;
+}
+
+int dbase_iterate(
+	dbase_config_t* dconfig,
+	int (*handler) (record_key_t key,
+	                record_t record,
+	                void* varg),
+	void* handler_arg) {
+
+	/* Stub */
+	dconfig = NULL;
+	handler = NULL;
+	handler_arg = NULL;
+	return -1;
+}
+
+int dbase_list(
+	dbase_config_t* dconfig,
+	record_key_t** keyset,
+	record_t** dataset,	
+	size_t* count) {
+
+	
+	/* Stub */
+	dconfig = NULL;
+	keyset = NULL;
+	dataset = NULL;
+	count = NULL;
+	return -1;
+}
diff -Naur libsemanage/src/database.h libsemanage.new/src/database.h
--- libsemanage/src/database.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/database.h	2005-09-12 07:58:35.000000000 -0400
@@ -0,0 +1,61 @@
+#ifndef _SEMANAGE_DATABASE_H_
+#define _SEMANAGE_DATABASE_H_
+
+#include <stddef.h>
+
+#ifndef RECORD_DEFINED
+typedef void* record_t;
+typedef void* record_key_t;
+#define RECORD_DEFINED
+#endif
+
+struct dbase_config;
+typedef struct dbase_config dbase_config_t;
+
+#define DBASE_COUNT 2
+#define DBASE_USERS 0
+#define DBASE_PORTS 1
+extern dbase_config_t* dbase[DBASE_COUNT];
+
+extern int dbase_add(
+	dbase_config_t* dconfig,
+	record_key_t key,
+	record_t data);
+
+extern int dbase_modify(
+	dbase_config_t* dconfig,
+	record_key_t key,
+	record_t data);
+
+extern int dbase_del(
+	dbase_config_t* dconfig,
+	record_key_t key);
+
+extern int dbase_query(
+	dbase_config_t* dconfig,
+	record_key_t key,
+	record_t* response);
+
+extern int dbase_exists(
+	dbase_config_t* dconfig,
+	record_key_t key,
+	int* response);
+
+extern int dbase_count(
+	dbase_config_t* dconfig,
+	int* response);
+
+extern int dbase_iterate(
+	dbase_config_t* dconfig,
+	int (*handler) (record_key_t key,
+	                record_t record,
+	                void* varg),
+	void* handler_arg);
+
+extern int dbase_list(
+	dbase_config_t* dconfig,
+	record_key_t** keyset,
+	record_t** dataset,	
+	size_t* count);
+
+#endif 
diff -Naur libsemanage/src/ports.c libsemanage.new/src/ports.c
--- libsemanage/src/ports.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/ports.c	2005-09-12 07:59:27.000000000 -0400
@@ -0,0 +1,65 @@
+#include <stddef.h>
+#include <semanage/port_record.h>
+#include <semanage/ports.h>
+
+typedef semanage_port_key_t record_key_t;
+typedef semanage_port_t record_t;
+#define RECORD_DEFINED
+#include "database.h"
+
+int semanage_port_add(
+	semanage_port_key_t key,
+	semanage_port_t data) {
+	
+	return dbase_add(dbase[DBASE_PORTS], key, data);
+}
+
+int semanage_port_modify(
+	semanage_port_key_t key,
+	semanage_port_t data) {
+	
+	return dbase_modify(dbase[DBASE_PORTS], key, data);
+}
+
+int semanage_port_del(
+	semanage_port_key_t key) {
+
+	return dbase_del(dbase[DBASE_PORTS], key);
+}
+
+int semanage_port_query(
+	semanage_port_key_t key,
+	semanage_port_t* response) {
+
+	return dbase_query(dbase[DBASE_PORTS], key, response);
+}
+
+int semanage_port_exists(
+	semanage_port_key_t key,
+	int* response) {
+
+	return dbase_exists(dbase[DBASE_PORTS], key, response);
+}
+
+int semanage_port_count(
+	int* response) {
+
+	return dbase_count(dbase[DBASE_PORTS], response);
+}
+
+int semanage_port_iterate(
+	int (*handler) (semanage_port_key_t key,
+	                semanage_port_t record,
+	                void* varg),
+	void* handler_arg) {
+
+	return dbase_iterate(dbase[DBASE_PORTS], handler, handler_arg);
+}
+
+int semanage_port_list(
+	semanage_port_key_t** keyset,
+	semanage_port_t** dataset,
+	size_t* count) {
+
+	return dbase_list(dbase[DBASE_PORTS], keyset, dataset, count);
+}
diff -Naur libsemanage/src/users.c libsemanage.new/src/users.c
--- libsemanage/src/users.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/users.c	2005-09-12 07:59:04.000000000 -0400
@@ -0,0 +1,65 @@
+#include <stddef.h>
+#include <semanage/user_record.h>
+#include <semanage/users.h>
+
+typedef semanage_user_key_t record_key_t;
+typedef semanage_user_t record_t;
+#define RECORD_DEFINED
+#include "database.h"
+
+int semanage_user_add(
+	semanage_user_key_t key,
+	semanage_user_t data) {
+	
+	return dbase_add(dbase[DBASE_USERS], key, data);
+}
+
+int semanage_user_modify(
+	semanage_user_key_t key,
+	semanage_user_t data) {
+	
+	return dbase_modify(dbase[DBASE_USERS], key, data);
+}
+
+int semanage_user_del(
+	semanage_user_key_t key) {
+
+	return dbase_del(dbase[DBASE_USERS], key);
+}
+
+int semanage_user_query(
+	semanage_user_key_t key,
+	semanage_user_t* response) {
+
+	return dbase_query(dbase[DBASE_USERS], key, response);
+}
+
+int semanage_user_exists(
+	semanage_user_key_t key,
+	int* response) {
+
+	return dbase_exists(dbase[DBASE_USERS], key, response);
+}
+
+int semanage_user_count(
+	int* response) {
+
+	return dbase_count(dbase[DBASE_USERS], response);
+}
+
+int semanage_user_iterate(
+	int (*handler) (semanage_user_key_t key,
+	                semanage_user_t record,
+	                void* varg),
+	void* handler_arg) {
+
+	return dbase_iterate(dbase[DBASE_USERS], handler, handler_arg);
+}
+
+int semanage_user_list(
+	semanage_user_key_t** keyset,
+	semanage_user_t** dataset,
+	size_t* count) {
+
+	return dbase_list(dbase[DBASE_USERS], keyset, dataset, count);
+}

--------------000307030703050302020401
Content-Type: text/x-patch;
 name="libsepol.stddef.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.stddef.diff"

diff -Naur libsepol/include/sepol/context.h libsepol.new/include/sepol/context.h
--- libsepol/include/sepol/context.h	2005-08-21 12:56:15.000000000 -0400
+++ libsepol.new/include/sepol/context.h	2005-09-12 07:40:39.000000000 -0400
@@ -19,6 +19,7 @@
 #ifndef _SEPOL_CONTEXT_H_
 #define _SEPOL_CONTEXT_H_
 
+#include <stddef.h>
 #include <sepol/ebitmap.h>
 #include <sepol/mls_types.h>
 #include <sepol/context_record.h>
diff -Naur libsepol/include/sepol/expand.h libsepol.new/include/sepol/expand.h
--- libsepol/include/sepol/expand.h	2005-08-21 12:56:16.000000000 -0400
+++ libsepol.new/include/sepol/expand.h	2005-09-12 07:40:34.000000000 -0400
@@ -22,6 +22,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <stddef.h>
 #include <sepol/conditional.h>
 
 #ifndef _SEPOL_EXPAND_H
diff -Naur libsepol/include/sepol/interfaces.h libsepol.new/include/sepol/interfaces.h
--- libsepol/include/sepol/interfaces.h	2005-08-21 12:56:16.000000000 -0400
+++ libsepol.new/include/sepol/interfaces.h	2005-09-12 07:40:13.000000000 -0400
@@ -1,5 +1,6 @@
 #include <sepol/policydb.h>
 #include <sepol/context_record.h>
+#include <stddef.h>
 
 /* High level representation of an interface */
 typedef struct sepol_iface {
diff -Naur libsepol/include/sepol/link.h libsepol.new/include/sepol/link.h
--- libsepol/include/sepol/link.h	2005-07-13 15:42:37.000000000 -0400
+++ libsepol.new/include/sepol/link.h	2005-09-12 07:40:23.000000000 -0400
@@ -23,6 +23,7 @@
  */
 
 #include <sepol/policydb.h>
+#include <stddef.h>
 
 #ifndef _SEPOL_LINK_H
 #define _SEPOL_LINK_H
diff -Naur libsepol/include/sepol/module.h libsepol.new/include/sepol/module.h
--- libsepol/include/sepol/module.h	2005-08-02 15:41:19.000000000 -0400
+++ libsepol.new/include/sepol/module.h	2005-09-12 07:40:19.000000000 -0400
@@ -21,6 +21,7 @@
 #define _SEPOL_MODULE_H_
 
 #include <stdlib.h>
+#include <stddef.h>
 
 #include <sepol/policydb.h>
 #include <sepol/conditional.h>
diff -Naur libsepol/include/sepol/policydb.h libsepol.new/include/sepol/policydb.h
--- libsepol/include/sepol/policydb.h	2005-08-21 12:56:16.000000000 -0400
+++ libsepol.new/include/sepol/policydb.h	2005-09-12 07:39:43.000000000 -0400
@@ -52,6 +52,7 @@
 #define _POLICYDB_H_
 
 #include <stdio.h>
+#include <stddef.h>
 
 #include <sepol/flask_types.h>
 #include <sepol/symtab.h>
diff -Naur libsepol/include/sepol/ports.h libsepol.new/include/sepol/ports.h
--- libsepol/include/sepol/ports.h	2005-08-21 12:56:16.000000000 -0400
+++ libsepol.new/include/sepol/ports.h	2005-09-12 07:39:29.000000000 -0400
@@ -3,6 +3,7 @@
 
 #include <sepol/policydb.h>
 #include <sepol/port_record.h>
+#include <stddef.h>
 
 /* Create a port structure from high level representation */
 extern int sepol_port_struct_create(
diff -Naur libsepol/include/sepol/sepol.h libsepol.new/include/sepol/sepol.h
--- libsepol/include/sepol/sepol.h	2005-04-13 10:56:10.000000000 -0400
+++ libsepol.new/include/sepol/sepol.h	2005-09-12 07:39:15.000000000 -0400
@@ -1,7 +1,7 @@
 #ifndef _SEPOL_H_
 #define _SEPOL_H_
 
-#include <sys/types.h>
+#include <stddef.h>
 #include <stdio.h>
 
 /* Given an existing binary policy (starting at 'data', with length 'len')
diff -Naur libsepol/include/sepol/services.h libsepol.new/include/sepol/services.h
--- libsepol/include/sepol/services.h	2005-07-13 15:42:37.000000000 -0400
+++ libsepol.new/include/sepol/services.h	2005-09-12 07:37:54.000000000 -0400
@@ -14,6 +14,7 @@
 
 #include <sepol/flask_types.h>
 #include <sepol/policydb.h>
+#include <stddef.h>
 
 /* Set the policydb and sidtab structures to be used by
    the service functions.  If not set, then these default
diff -Naur libsepol/include/sepol/user_record.h libsepol.new/include/sepol/user_record.h
--- libsepol/include/sepol/user_record.h	2005-08-02 09:16:53.000000000 -0400
+++ libsepol.new/include/sepol/user_record.h	2005-09-12 07:36:40.000000000 -0400
@@ -1,6 +1,8 @@
 #ifndef _SEPOL_USER_RECORD_H_
 #define _SEPOL_USER_RECORD_H_
 
+#include <stddef.h>
+
 struct sepol_user;
 struct sepol_user_key;
 typedef struct sepol_user* sepol_user_t;
diff -Naur libsepol/include/sepol/users.h libsepol.new/include/sepol/users.h
--- libsepol/include/sepol/users.h	2005-08-21 12:56:16.000000000 -0400
+++ libsepol.new/include/sepol/users.h	2005-09-12 07:36:45.000000000 -0400
@@ -3,7 +3,7 @@
 
 #include <sepol/policydb.h>
 #include <sepol/user_record.h>
-#include <sys/types.h>
+#include <stddef.h>
 
 /* Clear unused users */
 extern void sepol_clear_unused_users(

--------------000307030703050302020401--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
