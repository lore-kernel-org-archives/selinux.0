Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8K8uXNs026814
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 04:56:33 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8K8qXZQ006304
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 08:52:33 GMT
Received: from [192.168.2.105] (cpe-24-59-125-231.twcny.res.rr.com [24.59.125.231])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j8K8qXxU009885
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 04:52:33 -0400 (EDT)
Message-ID: <432FCF8F.8070909@cornell.edu>
Date: Tue, 20 Sep 2005 04:59:59 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [ SEMANAGE ] Stub record handlers
Content-Type: multipart/mixed;
 boundary="------------010401060107080505080204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010401060107080505080204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch stubs out most of the record handlers, and has the 
dbase_* routines fill out parts of the config structure.

--------------010401060107080505080204
Content-Type: text/x-patch;
 name="libsemanage.record_handlers.stub.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.record_handlers.stub.diff"

diff -Naur libsemanage.new/src/database_file.c libsemanage/src/database_file.c
--- libsemanage.new/src/database_file.c	2005-09-20 02:55:29.000000000 -0400
+++ libsemanage/src/database_file.c	2005-09-20 04:51:20.000000000 -0400
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include "database.h"
 #include "record_file.h"
+#include "record_file_handlers.h"
 #include "users_file.h"
 #include "ports_file.h"
 
@@ -42,11 +43,23 @@
 	record_t data) {
 
 	iterate_config_t config;
+	record_add_arg_t handler_arg;
+
+	handler_arg.rtable = dconfig->rtable;
+	handler_arg.key = key;
+	handler_arg.data = data;
+	/* handler_arg.derr_fatal =  */
+
 	config.rtable = dconfig->rtable;
+	/* config.filename = */
+	/* config.parse_arg = */
+	/* config.perr_fatal = */
+	config.modify = 1;
+	config.handler = record_add;
+	config.handler_arg = &handler_arg;
+	/* config.merr_fatal = */
 
 	/* Stub */
-	key = NULL;
-	data = NULL;
 	return -1;
 }
 
@@ -56,11 +69,23 @@
 	record_t data) {
 
 	iterate_config_t config;
+	record_modify_arg_t handler_arg;
+
+	handler_arg.rtable = dconfig->rtable;
+	handler_arg.key = key;
+	handler_arg.data = data;
+	/* handler_arg.merr_fatal = */
+	
 	config.rtable = dconfig->rtable;
+	/* config.filename = */
+	/* config.parse_arg = */
+	/* config.perr_fatal = */
+	config.modify = 1;
+	config.handler = record_modify;
+	config.handler_arg = &handler_arg;
+	/* config.merr_fatal = */
 
 	/* Stub */
-	key = NULL;
-	data = NULL;
 	return -1;
 }
 
@@ -69,10 +94,21 @@
 	record_key_t key) {
 
 	iterate_config_t config;
+	record_del_arg_t handler_arg;
+
+	handler_arg.rtable = dconfig->rtable;
+	handler_arg.key = key;
+
 	config.rtable = dconfig->rtable;
-	
+	/* config.filename = */
+	/* config.parse_arg = */
+	/* config.perr_fatal = */
+	config.modify = 1;
+	config.handler = record_add;
+	config.handler_arg = &handler_arg;
+	/* config.merr_fatal = */
+
 	/* Stub */
-	key = NULL;
 	return -1;
 }
 
@@ -82,11 +118,22 @@
 	record_t* response) {
 
 	iterate_config_t config;
+	record_query_arg_t handler_arg;
+
+	handler_arg.rtable = dconfig->rtable;
+	handler_arg.key = key;
+	handler_arg.response = response;
+
 	config.rtable = dconfig->rtable;
-	
+	/* config.filename = */
+	/* config.parse_arg = */
+	/* config.perr_fatal = */
+	config.modify = 0;
+	config.handler = record_add;
+	config.handler_arg = &handler_arg;
+	/* config.merr_fatal = */	
+
 	/* Stub */
-	key = NULL;
-	response = NULL;
 	return -1;
 }
 
@@ -96,11 +143,22 @@
 	int* response) {
 
 	iterate_config_t config;
+	record_exists_arg_t handler_arg;
+
+	handler_arg.rtable = dconfig->rtable;
+	handler_arg.key = key;
+	handler_arg.response = response;
+
 	config.rtable = dconfig->rtable;
-	
+	/* config.filename = */
+	/* config.parse_arg = */
+	/* config.perr_fatal = */
+	config.modify = 0;
+	config.handler = record_exists;
+	config.handler_arg = &handler_arg;
+	/* config.merr_fatal = */	
+
 	/* Stub */
-	key = NULL;
-	response = NULL;
 	return -1;
 }
 
@@ -109,26 +167,48 @@
 	int* response) {
 	
 	iterate_config_t config;
+	record_count_arg_t handler_arg;
+
+	handler_arg.rtable = dconfig->rtable;
+	handler_arg.response = response;
+
 	config.rtable = dconfig->rtable;
+	/* config.filename = */
+	/* config.parse_arg = */
+	/* config.perr_fatal = */
+	config.modify = 0;
+	config.handler = record_count;
+	config.handler_arg = &handler_arg;
+	/* config.merr_fatal = */
 
 	/* Stub */
-	response = NULL;
 	return -1;
 }
 
 int dbase_iterate(
 	dbase_config_t* dconfig,
-	int (*handler) (record_key_t key,
-	                record_t record,
-	                void* varg),
-	void* handler_arg) {
-
-	iterate_config_t config;
-	config.rtable = dconfig->rtable;
+	int (*fn) (record_key_t key,
+	           record_t record,
+	           void* varg),
+	void* fn_arg) {
+
+	iterate_config_t config;
+	record_iterate_arg_t handler_arg;
+
+	handler_arg.rtable = dconfig->rtable;
+	handler_arg.fn = fn;
+	handler_arg.fn_arg = fn_arg;
+
+	config.rtable = dconfig->rtable;
+	/* config.filename = */
+	/* config.parse_arg = */
+	/* config.perr_fatal = */
+	config.modify = 0;
+	config.handler = record_iterate;
+	config.handler_arg = &handler_arg;
+	/* config.merr_fatal = */
 
 	/* Stub */
-	handler = NULL;
-	handler_arg = NULL;
 	return -1;
 }
 
@@ -140,6 +220,13 @@
 
 	iterate_config_t config;
 	config.rtable = dconfig->rtable;
+	/* config.filename = */
+	/* config.parse_arg = */
+	/* config.perr_fatal = */
+	config.modify = 0;
+	/* config.handler = */
+	/* config.handler_arg = */
+	/* config.merr_fatal = */
 
 	/* Stub */
 	keyset = NULL;
diff -Naur libsemanage.new/src/database.h libsemanage/src/database.h
--- libsemanage.new/src/database.h	2005-09-14 11:44:44.000000000 -0400
+++ libsemanage/src/database.h	2005-09-20 04:49:25.000000000 -0400
@@ -47,10 +47,10 @@
 
 extern int dbase_iterate(
 	dbase_config_t* dconfig,
-	int (*handler) (record_key_t key,
-	                record_t record,
-	                void* varg),
-	void* handler_arg);
+	int (*fn) (record_key_t key,
+	           record_t record,
+	           void* varg),
+	void* fn_arg);
 
 extern int dbase_list(
 	dbase_config_t* dconfig,
diff -Naur libsemanage.new/src/record_file_handlers.c libsemanage/src/record_file_handlers.c
--- libsemanage.new/src/record_file_handlers.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/record_file_handlers.c	2005-09-20 04:54:00.000000000 -0400
@@ -0,0 +1,71 @@
+#include "record_file.h"
+#include "record_file_handlers.h"
+
+#ifndef RECORD_DEFINED
+typedef void* record_t;
+typedef void* record_key_t;
+#define RECORD_DEFINED
+#endif
+
+int record_query(record_t process_rec, record_t unused, void* varg) {
+
+	/* Stub */
+	process_rec = NULL;
+	unused = NULL;
+	varg = NULL;
+	return RECORD_HANDLER_SIGEXIT;
+}
+
+int record_exists(record_t process_rec, record_t unused, void* varg) {
+
+	/* Stub */
+	process_rec = NULL;
+	unused = NULL;
+	varg = NULL;
+	return RECORD_HANDLER_SIGEXIT;
+}
+
+int record_add(record_t process_rec, record_t* new_rec, void* varg) {
+	
+	/* Stub */
+	process_rec = NULL;
+	new_rec = NULL;
+	varg = NULL;
+	return RECORD_HANDLER_SIGEXIT;
+}
+
+int record_modify (record_t process_rec, record_t* new_rec, void* varg) {
+
+	/* Stub */
+	process_rec = NULL;
+	new_rec = NULL;
+	varg = NULL;
+	return RECORD_HANDLER_SIGEXIT;
+}
+
+int record_del(record_t process_rec, record_t* unused, void* varg) {
+
+	/* Stub */
+	process_rec = NULL;
+	unused = NULL;
+	varg = NULL;
+	return RECORD_HANDLER_SIGEXIT;
+}
+
+int record_count(record_t process_rec, record_t* unused, void* varg) {
+
+	/* Stub */
+	process_rec = NULL;
+	unused = NULL;
+	varg = NULL;
+	return RECORD_HANDLER_SIGEXIT;
+}
+
+int record_iterate(record_t process_rec, record_t* unused, void* varg) {
+
+	/* Stub */
+	process_rec = NULL;
+	unused = NULL;
+	varg = NULL;
+	return RECORD_HANDLER_SIGEXIT;
+}
diff -Naur libsemanage.new/src/record_file_handlers.h libsemanage/src/record_file_handlers.h
--- libsemanage.new/src/record_file_handlers.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/record_file_handlers.h	2005-09-20 04:53:26.000000000 -0400
@@ -0,0 +1,62 @@
+#ifndef _SEMANAGE_RECORD_FILE_HANDLERS_H_
+#define _SEMANAGE_RECORD_FILE_HANDLERS_H_
+
+#include "record_file.h"
+
+#ifndef RECORD_DEFINED
+typedef void* record_t;
+typedef void* record_key_t;
+#define RECORD_DEFINED
+#endif
+
+typedef struct record_query_arg {
+	record_table_t* rtable;
+	record_key_t key;
+	record_t* response;
+} record_query_arg_t;
+
+typedef struct record_del_arg {
+	record_table_t* rtable;
+	record_key_t key;
+} record_del_arg_t;
+
+typedef struct record_exists_arg {
+	record_table_t* rtable;
+	record_key_t key;
+	int* response;
+} record_exists_arg_t;
+
+typedef struct record_add_arg {
+	record_table_t* rtable;
+	record_key_t key;
+	record_t data;
+	int derr_fatal;
+} record_add_arg_t;
+
+typedef struct record_modify_arg {
+	record_table_t* rtable;
+	record_key_t key;
+	record_t data;
+	int merr_fatal;
+} record_modify_arg_t;
+
+typedef struct record_count_arg {
+	record_table_t* rtable;
+	int* response;
+} record_count_arg_t;
+
+typedef struct record_iterate_arg {
+	record_table_t* rtable;
+	int (*fn) (record_key_t key, record_t rec, void* varg);
+	void* fn_arg;
+} record_iterate_arg_t;
+
+extern int record_query(record_t rec, record_t unused, void* varg);
+extern int record_exists(record_t rec, record_t unused, void* varg);
+extern int record_add(record_t rec, record_t* new_rec, void* varg);
+extern int record_modify (record_t rec, record_t* new_rec, void* varg);
+extern int record_del(record_t rec, record_t* unused, void* varg);
+extern int record_count(record_t rec, record_t* unused, void* varg);
+extern int record_iterate(record_t rec, record_t* unused, void* varg);
+
+#endif

--------------010401060107080505080204--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
