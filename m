Message-ID: <43258D48.80702@cornell.edu>
Date: Mon, 12 Sep 2005 10:14:32 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: dwalsh@redhat.com, jbrindle@tresys.com
Subject: Re: [ SEMANAGE ] Introduce record table
References: <43256F48.7060909@cornell.edu>
In-Reply-To: <43256F48.7060909@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------080006040403030406000300"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080006040403030406000300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch applies on top of the other one.
It introduces the record table as the first thing
which will be stored in the database config (a database config
stores parameters specific to a database (a.k.a. file))

To clarify how this works - there's two sets of files here - one
that works with generic record_t/record_key_t objects (treated as void*),
and one that works with specific types that replace record_t/record_key_t.
This essentially implements inheritance, which allows sharing of a lot of
code (not yet merged). It's also a bit tricky to get it working, because we
must keep track of where the specific types are defined.

The record table stores a set of functions which correspond
to the record headers previously merged. It defines how certain
operations are done for each particular type of record. In addition, it 
provides
some functions specific to the FILE backend. This table will
be used by the file engine for polymorphism - it will work with
the generic record types, but will be invoking the specific functions for
each record based on what the table says.

Regarding database_init/close - those need to be integrated somewhere.. 
likely
on CONNECT/DISCONNECT...but I haven't done that yet..and it might change
once semanage_handle_t appears.

--------------080006040403030406000300
Content-Type: text/x-patch;
 name="libsemanage.rtable.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.rtable.diff"

diff -Naur libsemanage/src/database_file.c libsemanage.new/src/database_file.c
--- libsemanage/src/database_file.c	2005-09-12 09:56:33.000000000 -0400
+++ libsemanage.new/src/database_file.c	2005-09-12 09:49:33.000000000 -0400
@@ -1,13 +1,41 @@
 #include <stdlib.h>
 #include <stddef.h>
 #include "database.h"
+#include "record_file.h"
+#include "users_file.h"
+#include "ports_file.h"
 
 struct dbase_config {
-	/* Stub */
+	record_table_t* rtable;
 };
 
 dbase_config_t* dbase[DBASE_COUNT];
 
+int dbase_init() {
+	int i;
+	for (i = 0; i < DBASE_COUNT; i++) {
+		dbase[i] = (dbase_config_t*) malloc(sizeof(dbase_config_t));
+		if (dbase[i] == NULL) 
+			goto err;
+	}
+
+	dbase[DBASE_USERS]->rtable = &RTABLE_USER;
+	dbase[DBASE_PORTS]->rtable = &RTABLE_PORT; 	
+
+	return 0;
+	
+	err:
+	for (i--; i >= 0; i--) 
+		free(dbase[i]);
+	return -1;
+}	
+
+void dbase_close() {
+	int i;
+	for (i = 0; i < DBASE_COUNT; i++)
+		free(dbase[i]);
+}
+
 int dbase_add(
 	dbase_config_t* dconfig,
 	record_key_t key,
diff -Naur libsemanage/src/ports_file.c libsemanage.new/src/ports_file.c
--- libsemanage/src/ports_file.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/ports_file.c	2005-09-12 09:51:39.000000000 -0400
@@ -0,0 +1,42 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <semanage/port_record.h>
+
+typedef semanage_port_t record_t;
+typedef semanage_port_key_t record_key_t;
+#define RECORD_DEFINED
+#include "record_file.h"
+
+static int semanage_port_print(
+	semanage_port_t port, 
+	FILE* str) {
+
+	/* Stub */
+	port = NULL;
+	str = NULL;
+	return -1;
+}
+
+static int semanage_port_parse(
+	parse_info_t* info, 
+	semanage_port_t port) {
+
+	/* Stub */
+	info = NULL;
+	port = NULL;
+	return -1;	
+}
+
+record_table_t RTABLE_PORT = {
+	/* Record base functions */
+	.create      = semanage_port_create,
+	.key_extract = semanage_port_key_extract,
+	.key_free    = semanage_port_key_free,
+	.clone       = semanage_port_clone,
+	.compare     = semanage_port_compare,
+	.free        = semanage_port_free,
+
+	/* Record functions for FILE backend */
+	.parse       = semanage_port_parse,
+	.print       = semanage_port_print,
+};
diff -Naur libsemanage/src/ports_file.h libsemanage.new/src/ports_file.h
--- libsemanage/src/ports_file.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/ports_file.h	2005-09-12 09:51:10.000000000 -0400
@@ -0,0 +1,8 @@
+#ifndef _SEMANAGE_PORTS_FILE_H_
+#define _SEMANAGE_PORTS_FILE_H_
+
+#include "record_file.h"
+
+extern record_table_t RTABLE_PORT;
+
+#endif 
diff -Naur libsemanage/src/record_file.h libsemanage.new/src/record_file.h
--- libsemanage/src/record_file.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/record_file.h	2005-09-12 09:38:06.000000000 -0400
@@ -0,0 +1,47 @@
+#ifndef _SEMANAGE_RECORD_FILE_H_
+#define _SEMANAGE_RECORD_FILE_H_
+
+#include <stdio.h>
+
+#ifndef RECORD_DEFINED
+typedef void* record_t;
+typedef void* record_key_t;
+#define RECORD_DEFINED
+#endif
+
+/* Structure available during parsing (created internally) */
+typedef struct parse_info {
+	/* Stub */	
+} parse_info_t;
+
+/* Record table format - necessary during processing */
+typedef struct record_table {
+
+	/* Create a record */
+	int (*create) (record_t* rec);
+
+	/* Extract key from record */
+	int (*key_extract) (record_t rec, record_key_t* key);
+	
+	/* Free record key */
+	int (*key_free) (record_key_t key);
+
+	/* Return 0 if record can be matched against key,
+	 * and 1 otherwise */
+	int (*compare) (record_t rec, record_key_t key);
+
+	/* Deep-copy clone of this record */
+	int (*clone) (record_t rec, record_t* new_rec);
+
+	/* Fill record structuure based on supplied parse info */
+	int (*parse) (parse_info_t* info, record_t record);
+
+	/* Print record to stream */
+	int (*print) (record_t record, FILE* str);
+
+	/* Deallocate record resources. Must
+	 * sucessfully handle NULL. */
+	void (*free) (record_t rec);
+} record_table_t;
+
+#endif 
diff -Naur libsemanage/src/users_file.c libsemanage.new/src/users_file.c
--- libsemanage/src/users_file.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/users_file.c	2005-09-12 09:51:52.000000000 -0400
@@ -0,0 +1,42 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <semanage/user_record.h>
+
+typedef semanage_user_t record_t;
+typedef semanage_user_key_t record_key_t;
+#define RECORD_DEFINED
+#include "record_file.h"
+
+static int semanage_user_print(
+	semanage_user_t user, 
+	FILE* str) {
+
+	/* Stub */
+	user = NULL;
+	str = NULL;
+	return -1;
+}
+
+static int semanage_user_parse(
+	parse_info_t* info, 
+	semanage_user_t user) {
+
+	/* Stub */
+	info = NULL;
+	user = NULL;
+	return -1;	
+}
+
+record_table_t RTABLE_USER = {
+	/* Record base functions */
+	.create      = semanage_user_create,
+	.key_extract = semanage_user_key_extract,
+	.key_free    = semanage_user_key_free,
+	.clone       = semanage_user_clone,
+	.compare     = semanage_user_compare,
+	.free        = semanage_user_free,
+
+	/* Record functions for FILE backend */
+	.parse       = semanage_user_parse,
+	.print       = semanage_user_print,
+};
diff -Naur libsemanage/src/users_file.h libsemanage.new/src/users_file.h
--- libsemanage/src/users_file.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/users_file.h	2005-09-12 09:49:53.000000000 -0400
@@ -0,0 +1,8 @@
+#ifndef _SEMANAGE_USERS_FILE_H_
+#define _SEMANAGE_USERS_FILE_H_
+
+#include "record_file.h"
+
+extern record_table_t RTABLE_USER;
+
+#endif 

--------------080006040403030406000300--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
