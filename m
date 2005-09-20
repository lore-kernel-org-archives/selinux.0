Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8K9IwNs027001
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 05:18:59 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8K9EwZQ007663
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 09:14:58 GMT
Received: from [192.168.2.105] (cpe-24-59-125-231.twcny.res.rr.com [24.59.125.231])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j8K9EvxU017413
	for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2005 05:14:57 -0400 (EDT)
Message-ID: <432FD4D1.5000604@cornell.edu>
Date: Tue, 20 Sep 2005 05:22:25 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] Fix record handlers, add status codes
References: <432FCF8F.8070909@cornell.edu>
In-Reply-To: <432FCF8F.8070909@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------080003020503060201050300"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080003020503060201050300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch applies on top of the previous one, and fixes
several bugs. It also adds a header with status codes which I need...
the debug system should go into this header IMHO, once we decide
what the debug system should be.



--------------080003020503060201050300
Content-Type: text/x-patch;
 name="libsemanage.fixup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.fixup.diff"

diff -Naur libsemanage.new/src/database_file.c libsemanage/src/database_file.c
--- libsemanage.new/src/database_file.c	2005-09-20 05:11:44.000000000 -0400
+++ libsemanage/src/database_file.c	2005-09-20 05:18:12.000000000 -0400
@@ -1,5 +1,6 @@
 #include <stdlib.h>
 #include <stddef.h>
+#include "debug.h"
 #include "database.h"
 #include "record_file.h"
 #include "record_file_handlers.h"
@@ -23,12 +24,12 @@
 	dbase[DBASE_USERS]->rtable = &RTABLE_USER;
 	dbase[DBASE_PORTS]->rtable = &RTABLE_PORT; 	
 
-	return 0;
+	return STATUS_SUCCESS;
 	
 	err:
 	for (i--; i >= 0; i--) 
 		free(dbase[i]);
-	return -1;
+	return STATUS_ERR;
 }	
 
 void dbase_close() {
@@ -60,7 +61,7 @@
 	/* config.merr_fatal = */
 
 	/* Stub */
-	return -1;
+	return STATUS_SUCCESS;
 }
 
 int dbase_modify(
@@ -86,7 +87,7 @@
 	/* config.merr_fatal = */
 
 	/* Stub */
-	return -1;
+	return STATUS_SUCCESS;
 }
 
 int dbase_del(
@@ -104,12 +105,12 @@
 	/* config.parse_arg = */
 	/* config.perr_fatal = */
 	config.modify = 1;
-	config.handler = record_add;
+	config.handler = record_del;
 	config.handler_arg = &handler_arg;
 	/* config.merr_fatal = */
 
 	/* Stub */
-	return -1;
+	return STATUS_SUCCESS;
 }
 
 int dbase_query(
@@ -129,12 +130,12 @@
 	/* config.parse_arg = */
 	/* config.perr_fatal = */
 	config.modify = 0;
-	config.handler = record_add;
+	config.handler = record_query;
 	config.handler_arg = &handler_arg;
 	/* config.merr_fatal = */	
 
 	/* Stub */
-	return -1;
+	return STATUS_SUCCESS;
 }
 
 int dbase_exists(
@@ -159,7 +160,7 @@
 	/* config.merr_fatal = */	
 
 	/* Stub */
-	return -1;
+	return STATUS_SUCCESS;
 }
 
 int dbase_count(
@@ -182,7 +183,7 @@
 	/* config.merr_fatal = */
 
 	/* Stub */
-	return -1;
+	return STATUS_SUCCESS;
 }
 
 int dbase_iterate(
@@ -209,7 +210,7 @@
 	/* config.merr_fatal = */
 
 	/* Stub */
-	return -1;
+	return STATUS_SUCCESS;
 }
 
 int dbase_list(
@@ -232,5 +233,5 @@
 	keyset = NULL;
 	dataset = NULL;
 	count = NULL;
-	return -1;
+	return STATUS_SUCCESS;
 }
diff -Naur libsemanage.new/src/debug.h libsemanage/src/debug.h
--- libsemanage.new/src/debug.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/debug.h	2005-09-20 05:08:22.000000000 -0400
@@ -0,0 +1,10 @@
+#ifndef _SEPOL_INTERNAL_DEBUG_H_
+#define _SEPOL_INTERNAL_DEBUG_H_
+
+#define STATUS_SUCCESS 0
+#define STATUS_ERR -1
+#define STATUS_NODATA 1
+
+/* Define debug system in this header */
+
+#endif 
diff -Naur libsemanage.new/src/record_file.c libsemanage/src/record_file.c
--- libsemanage.new/src/record_file.c	2005-09-19 15:31:28.000000000 -0400
+++ libsemanage/src/record_file.c	2005-09-20 05:14:24.000000000 -0400
@@ -1,8 +1,9 @@
+#include "debug.h"
 #include "record_file.h"
 
 int record_iterate_file(iterate_config_t* config) {
 
 	/* Stub */
 	config = NULL;
-	return 0;
+	return STATUS_SUCCESS;
 }
diff -Naur libsemanage.new/src/record_file_handlers.c libsemanage/src/record_file_handlers.c
--- libsemanage.new/src/record_file_handlers.c	2005-09-20 05:11:44.000000000 -0400
+++ libsemanage/src/record_file_handlers.c	2005-09-20 05:18:40.000000000 -0400
@@ -1,3 +1,4 @@
+#include "debug.h"
 #include "record_file.h"
 #include "record_file_handlers.h"
 
@@ -7,7 +8,7 @@
 #define RECORD_DEFINED
 #endif
 
-int record_query(record_t process_rec, record_t unused, void* varg) {
+int record_query(record_t process_rec, record_t* unused, void* varg) {
 
 	/* Stub */
 	process_rec = NULL;
@@ -16,7 +17,7 @@
 	return RECORD_HANDLER_SIGEXIT;
 }
 
-int record_exists(record_t process_rec, record_t unused, void* varg) {
+int record_exists(record_t process_rec, record_t* unused, void* varg) {
 
 	/* Stub */
 	process_rec = NULL;
diff -Naur libsemanage.new/src/record_file_handlers.h libsemanage/src/record_file_handlers.h
--- libsemanage.new/src/record_file_handlers.h	2005-09-20 05:11:44.000000000 -0400
+++ libsemanage/src/record_file_handlers.h	2005-09-20 05:17:31.000000000 -0400
@@ -51,8 +51,8 @@
 	void* fn_arg;
 } record_iterate_arg_t;
 
-extern int record_query(record_t rec, record_t unused, void* varg);
-extern int record_exists(record_t rec, record_t unused, void* varg);
+extern int record_query(record_t rec, record_t* unused, void* varg);
+extern int record_exists(record_t rec, record_t* unused, void* varg);
 extern int record_add(record_t rec, record_t* new_rec, void* varg);
 extern int record_modify (record_t rec, record_t* new_rec, void* varg);
 extern int record_del(record_t rec, record_t* unused, void* varg);

--------------080003020503060201050300--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
