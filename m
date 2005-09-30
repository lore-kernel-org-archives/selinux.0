Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8U347Ns023701
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 23:04:07 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8U2wGS2016776
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 02:58:16 GMT
Message-ID: <433CABE5.7040006@cornell.edu>
Date: Thu, 29 Sep 2005 23:07:17 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: dwalsh@redhat.com
Subject: Re: [ 6/9 ] [ SEMANAGE ] Database Initialization Stage 2
References: <433CA7CA.6000207@cornell.edu>
In-Reply-To: <433CA7CA.6000207@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------020507020701080503040905"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020507020701080503040905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch passes the handle down to the dbase_* functions, and selects 
the correct database in users.c/ports.c. I need to add debugging 
eventually, that will make use of the handle, but for now it's set to 
NULL to block unused warning. Also, it may need to be forwarded deeper 
into the call stack, but I'll leave that for later.

--------------020507020701080503040905
Content-Type: text/x-patch;
 name="libsemanage.05.init2_handle.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.05.init2_handle.diff"

diff -Naur libsemanage/include/semanage/ports.h libsemanage.new2/include/semanage/ports.h
--- libsemanage/include/semanage/ports.h	2005-09-23 10:37:40.000000000 -0400
+++ libsemanage.new2/include/semanage/ports.h	2005-09-29 18:13:45.000000000 -0400
@@ -3,35 +3,44 @@
 
 #include <stddef.h>
 #include <semanage/port_record.h>
+#include <semanage/handle.h>
 
 extern int semanage_port_add(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	semanage_port_t data);
 
 extern int semanage_port_modify(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	semanage_port_t data);
 
 extern int semanage_port_del(
+	semanage_handle_t* handle,
 	semanage_port_key_t key);
 
 extern int semanage_port_query(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	semanage_port_t* response);
 
 extern int semanage_port_exists(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	int* response);
 
 extern int semanage_port_count(
+	semanage_handle_t* handle,
 	int* response);
 
 extern int semanage_port_iterate(
+	semanage_handle_t* handle,
 	int (*handler) (semanage_port_t record,
 	                void* varg),
 	void* handler_arg);
 
 extern int semanage_port_list(
+	semanage_handle_t* handle,
 	semanage_port_t** records,
 	size_t* count);
 
diff -Naur libsemanage/include/semanage/users.h libsemanage.new2/include/semanage/users.h
--- libsemanage/include/semanage/users.h	2005-09-23 10:37:40.000000000 -0400
+++ libsemanage.new2/include/semanage/users.h	2005-09-29 18:13:41.000000000 -0400
@@ -3,35 +3,44 @@
 
 #include <stddef.h>
 #include <semanage/user_record.h>
+#include <semanage/handle.h>
 
 extern int semanage_user_add(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	semanage_user_t data);
 
 extern int semanage_user_modify(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	semanage_user_t data);
 
 extern int semanage_user_del(
+	semanage_handle_t* handle,
 	semanage_user_key_t key);
 
 extern int semanage_user_query(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	semanage_user_t* response);
 
 extern int semanage_user_exists(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	int* response);
 
 extern int semanage_user_count(
+	semanage_handle_t* handle,
 	int* response);
 
 extern int semanage_user_iterate(
+	semanage_handle_t* handle,
 	int (*handler) (semanage_user_t record,
 	                void* varg),
 	void* handler_arg);
 
 extern int semanage_user_list(
+	semanage_handle_t* handle,
 	semanage_user_t** records,
 	size_t* count);
 
diff -Naur libsemanage/src/database.c libsemanage.new2/src/database.c
--- libsemanage/src/database.c	2005-09-29 18:06:33.000000000 -0400
+++ libsemanage.new2/src/database.c	2005-09-29 18:29:54.000000000 -0400
@@ -6,8 +6,7 @@
 #include "debug.h"
 #include "database.h"
 #include "interfaces.h"
-#include "users_file.h"
-#include "ports_file.h"
+#include "handle.h"
 
 /* Representation of the database once loaded in memory */
 typedef struct cache_entry {
@@ -183,7 +182,7 @@
 
 static int dbase_cache_locate(
 	dbase_t* dbase,
-	record_key_t key, 
+	record_key_t key,
 	cache_entry_t** entry) {
 	
 	cache_entry_t* ptr;
@@ -205,6 +204,7 @@
 }
 
 int dbase_add(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	record_key_t key,
 	record_t data) {
@@ -214,7 +214,7 @@
 	if (dbase_cache_fill(dbase) < 0)
 		goto err;
 
-	if (dbase_exists(dbase, key, &exists) < 0)
+	if (dbase_exists(handle, dbase, key, &exists) < 0)
 		goto err;
 
 	else if (exists) { 
@@ -228,11 +228,13 @@
 	return STATUS_SUCCESS;
 
 	err:
+	handle = NULL;
 	/* FIXME: handle error condition */
 	return STATUS_ERR;
 }
 
 int dbase_modify(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	record_key_t key,
 	record_t data) {
@@ -247,19 +249,20 @@
 	if (status < 0)
 		goto err;
 	if (status == STATUS_NODATA)
-		return dbase_add(dbase,key,data);
+		return dbase_add(handle, dbase, key, data);
 	else
 		entry->data = data;
 
 	return STATUS_SUCCESS;
 
 	err:
+	handle = NULL;
 	/* FIXME: handle error condition */
 	return STATUS_ERR;
-
 }
 
 int dbase_del(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	record_key_t key) {
 
@@ -282,15 +285,17 @@
 		}
 		else
 			prev = ptr;
-        }
+	}
 
 	return STATUS_SUCCESS;
 	err:
+	handle = NULL;
 	/* FIXME: Handle error condition */
 	return STATUS_ERR;
 }
 
 int dbase_query(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	record_key_t key,
 	record_t* response) {
@@ -310,11 +315,13 @@
 
 	return STATUS_SUCCESS;
 	err:
+	handle = NULL;
 	/* FIXME: Handle error condition */
 	return STATUS_ERR;
 }
 
 int dbase_exists(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	record_key_t key,
 	int* response) {
@@ -333,11 +340,13 @@
 	return STATUS_SUCCESS;
 
 	err:
+	handle = NULL;
 	/* FIXME: handle error condition */
 	return STATUS_ERR;
 }
 
 int dbase_count(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	int* response) {
 
@@ -348,11 +357,13 @@
 	return STATUS_SUCCESS;
 
 	err:
+	handle = NULL;
 	/* FIXME: Handle error condition */
 	return STATUS_ERR;
 }
 
 int dbase_iterate(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	int (*fn) (record_t record, void* varg),
 	void* fn_arg) {
@@ -375,11 +386,13 @@
 	return STATUS_SUCCESS;
 
 	err:
+	handle = NULL;
 	/* FIXME: Handle error condition */
 	return STATUS_ERR;
 }
 
 int dbase_list(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	record_t** records,	
 	size_t* count) {
@@ -410,6 +423,7 @@
 	return STATUS_SUCCESS;	
 
 	omem:
+	handle = NULL;
 	/* FIXME: handle error condition */
 
 	err:
diff -Naur libsemanage/src/database.h libsemanage.new2/src/database.h
--- libsemanage/src/database.h	2005-09-29 17:54:40.000000000 -0400
+++ libsemanage.new2/src/database.h	2005-09-29 18:29:28.000000000 -0400
@@ -8,6 +8,7 @@
 #endif
 
 #include <stddef.h>
+#include "handle.h"
 #include "interfaces.h"
 
 struct dbase;
@@ -32,40 +33,48 @@
 	dbase_t* dbase);
 
 extern int dbase_add(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	record_key_t key,
 	record_t data);
 
 extern int dbase_modify(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	record_key_t key,
 	record_t data);
 
 extern int dbase_del(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	record_key_t key);
 
 extern int dbase_query(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	record_key_t key,
 	record_t* response);
 
 extern int dbase_exists(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	record_key_t key,
 	int* response);
 
 extern int dbase_count(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	int* response);
 
 extern int dbase_iterate(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	int (*fn) (record_t record,
 	           void* varg),
 	void* fn_arg);
 
 extern int dbase_list(
+	semanage_handle_t* handle,
 	dbase_t* dbase,
 	record_t** records,	
 	size_t* count);
diff -Naur libsemanage/src/ports.c libsemanage.new2/src/ports.c
--- libsemanage/src/ports.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage.new2/src/ports.c	2005-09-29 18:31:19.000000000 -0400
@@ -1,64 +1,86 @@
-#include <stddef.h>
-#include <stdlib.h>
+/* 
+ * Common code for manipulating port DATA backends
+ */
+
 #include <semanage/port_record.h>
-#include <semanage/ports.h>
 
 typedef semanage_port_key_t record_key_t;
 typedef semanage_port_t record_t;
 #define RECORD_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <semanage/ports.h>
 #include "database.h"
+#include "handle.h"
 
 int semanage_port_add(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	semanage_port_t data) {
-	
-	return dbase_add(NULL /* FIXME */, key, data);
+
+	dbase_t* dbase = semanage_port_dbase(handle);	
+	return dbase_add(handle, dbase, key, data);
 }
 
 int semanage_port_modify(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	semanage_port_t data) {
 	
-	return dbase_modify(NULL /* FIXME */, key, data);
+	dbase_t* dbase = semanage_port_dbase(handle);
+	return dbase_modify(handle, dbase, key, data);
 }
 
 int semanage_port_del(
+	semanage_handle_t* handle,
 	semanage_port_key_t key) {
 
-	return dbase_del(NULL /* FIXME */, key);
+	dbase_t* dbase = semanage_port_dbase(handle);
+	return dbase_del(handle, dbase, key);
 }
 
 int semanage_port_query(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	semanage_port_t* response) {
 
-	return dbase_query(NULL /* FIXME */, key, response);
+	dbase_t* dbase = semanage_port_dbase(handle);
+	return dbase_query(handle, dbase, key, response);
 }
 
 int semanage_port_exists(
+	semanage_handle_t* handle,
 	semanage_port_key_t key,
 	int* response) {
 
-	return dbase_exists(NULL /* FIXME */, key, response);
+	dbase_t* dbase = semanage_port_dbase(handle);
+	return dbase_exists(handle, dbase, key, response);
 }
 
 int semanage_port_count(
+	semanage_handle_t* handle,
 	int* response) {
 
-	return dbase_count(NULL /*FIXME */, response);
+	dbase_t* dbase = semanage_port_dbase(handle);
+	return dbase_count(handle, dbase, response);
 }
 
 int semanage_port_iterate(
+	semanage_handle_t* handle,
 	int (*handler) (semanage_port_t record,
 	                void* varg),
 	void* handler_arg) {
 
-	return dbase_iterate(NULL /* FIXME */, handler, handler_arg);
+	dbase_t* dbase = semanage_port_dbase(handle);
+	return dbase_iterate(handle, dbase, handler, handler_arg);
 }
 
 int semanage_port_list(
+	semanage_handle_t* handle,
 	semanage_port_t** records,
 	size_t* count) {
 
-	return dbase_list(NULL /* FIXME */, records, count);
+	dbase_t* dbase = semanage_port_dbase(handle);
+	return dbase_list(handle, dbase, records, count);
 }
diff -Naur libsemanage/src/users.c libsemanage.new2/src/users.c
--- libsemanage/src/users.c	2005-09-23 10:38:06.000000000 -0400
+++ libsemanage.new2/src/users.c	2005-09-29 18:24:27.000000000 -0400
@@ -1,64 +1,86 @@
-#include <stddef.h>
-#include <stdlib.h>
+/*
+ * Common code for manipulating user DATA backends
+ */
+
 #include <semanage/user_record.h>
-#include <semanage/users.h>
 
 typedef semanage_user_key_t record_key_t;
 typedef semanage_user_t record_t;
 #define RECORD_DEFINED
+
+#include <stddef.h>
+#include <stdlib.h>
+#include <semanage/users.h>
+#include "handle.h"
 #include "database.h"
 
 int semanage_user_add(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	semanage_user_t data) {
-	
-	return dbase_add(NULL /*FIXME */, key, data);
+
+	dbase_t* dbase = semanage_user_dbase(handle);
+	return dbase_add(handle, dbase, key, data);
 }
 
 int semanage_user_modify(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	semanage_user_t data) {
-	
-	return dbase_modify(NULL /* FIXME */, key, data);
+
+	dbase_t* dbase = semanage_user_dbase(handle);	
+	return dbase_modify(handle, dbase, key, data);
 }
 
 int semanage_user_del(
+	semanage_handle_t* handle,
 	semanage_user_key_t key) {
 
-	return dbase_del(NULL /* FIXME */, key);
+	dbase_t* dbase = semanage_user_dbase(handle);
+	return dbase_del(handle, dbase, key);
 }
 
 int semanage_user_query(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	semanage_user_t* response) {
 
-	return dbase_query(NULL /* FIXME */, key, response);
+	dbase_t* dbase = semanage_user_dbase(handle);
+	return dbase_query(handle, dbase, key, response);
 }
 
 int semanage_user_exists(
+	semanage_handle_t* handle,
 	semanage_user_key_t key,
 	int* response) {
 
-	return dbase_exists(NULL /* FIXME */, key, response);
+	dbase_t* dbase = semanage_user_dbase(handle);
+	return dbase_exists(handle, dbase, key, response);
 }
 
 int semanage_user_count(
+	semanage_handle_t* handle,
 	int* response) {
 
-	return dbase_count(NULL /* FIXME */, response);
+	dbase_t* dbase = semanage_user_dbase(handle);
+	return dbase_count(handle, dbase, response);
 }
 
 int semanage_user_iterate(
+	semanage_handle_t* handle,
 	int (*handler) (semanage_user_t record,
 	                void* varg),
 	void* handler_arg) {
 
-	return dbase_iterate(NULL /* FIXME */, handler, handler_arg);
+	dbase_t* dbase = semanage_user_dbase(handle);
+	return dbase_iterate(handle, dbase, handler, handler_arg);
 }
 
 int semanage_user_list(
+	semanage_handle_t* handle,
 	semanage_user_t** records,
 	size_t* count) {
 
-	return dbase_list(NULL /* FIXME */, records, count);
+	dbase_t* dbase = semanage_user_dbase(handle);
+	return dbase_list(handle, dbase, records, count);
 }

--------------020507020701080503040905--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
