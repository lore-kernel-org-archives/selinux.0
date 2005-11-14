Message-ID: <437907D7.8090002@cornell.edu>
Date: Mon, 14 Nov 2005 16:55:35 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Stub pserver backend
Content-Type: multipart/mixed;
 boundary="------------090607010404000608030909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090607010404000608030909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The purpose of stubs is to reduce size of future patches, and to point 
to the right place to add functionality (if people want to help 
implement it).

Changes: stub the pserver dbase backend.

--------------090607010404000608030909
Content-Type: text/x-patch;
 name="libsemanage.stub_pserver_backend.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.stub_pserver_backend.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsemanage/src/database_pserver.c new/libsemanage/src/database_pserver.c
--- old/libsemanage/src/database_pserver.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/database_pserver.c	2005-11-14 16:51:36.000000000 -0500
@@ -0,0 +1,214 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+struct dbase_pserver;
+typedef struct dbase_pserver dbase_t;
+#define DBASE_DEFINED
+
+#include "debug.h"
+#include "handle.h"
+#include "database_pserver.h"
+
+/* PSERVER dbase */ 
+struct dbase_pserver {
+
+	/* Base record table */
+	record_table_t* rtable;
+
+	/* Stub */
+};
+
+static int dbase_pserver_cache(
+	semanage_handle_t* handle,
+	dbase_pserver_t* dbase) {
+
+	/* Stub */
+	handle = NULL;
+	dbase = NULL;
+	return STATUS_ERR;
+}
+
+static void dbase_pserver_drop_cache(
+	dbase_pserver_t* dbase) {
+}	
+
+/* Flush database to pserver */
+static int dbase_pserver_flush(
+	semanage_handle_t* handle,
+	dbase_pserver_t* dbase) {
+
+	/* Stub */
+	handle = NULL;
+	dbase = NULL;
+	return STATUS_ERR;
+}
+
+/* Check if modified */
+static int dbase_pserver_is_modified(
+	dbase_pserver_t* dbase) {
+
+	/* Stub */
+	return 0;
+}
+
+/* Release dbase resources */
+void dbase_pserver_release(
+	dbase_pserver_t* dbase) {
+
+	/* Stub */
+	dbase = NULL;
+}
+
+static int dbase_pserver_exists(
+	semanage_handle_t* handle,
+	dbase_pserver_t* dbase,
+	record_key_t* key,
+	int* response) {
+
+	/* Stub */
+	handle = NULL;
+	dbase = NULL;
+	key = NULL;
+	response = NULL;
+	return STATUS_ERR;
+}
+
+static int dbase_pserver_add(
+	semanage_handle_t* handle,
+	dbase_pserver_t* dbase,
+	record_key_t* key,
+	record_t* data) {
+
+	/* Stub */
+	handle = NULL;
+	dbase = NULL;
+	key = NULL;
+	data = NULL;
+	return STATUS_ERR;
+}
+
+static int dbase_pserver_set(
+	semanage_handle_t* handle,
+	dbase_pserver_t* dbase,
+	record_key_t* key,
+	record_t* data) {
+	
+	/* Stub */
+	handle = NULL;
+	dbase = NULL;
+	key = NULL;
+	data = NULL;
+	return STATUS_ERR;
+}
+
+
+static int dbase_pserver_modify(
+	semanage_handle_t* handle,
+	dbase_pserver_t* dbase,
+	record_key_t* key,
+	record_t* data) {
+
+	/* Stub */
+	handle = NULL;
+	dbase = NULL;
+	key = NULL;
+	data = NULL;
+	return STATUS_ERR;
+}
+
+static int dbase_pserver_count(
+        semanage_handle_t* handle,
+        dbase_pserver_t* dbase,
+        unsigned int* response) {
+
+	/* Stub */
+	handle = NULL;
+	dbase = NULL;
+	response = NULL;
+	return STATUS_ERR;
+}
+
+static int dbase_pserver_query(
+	semanage_handle_t* handle,
+	dbase_pserver_t* dbase,
+	record_key_t* key,
+	record_t** response) {
+
+	/* Stub */
+	handle = NULL;
+	dbase = NULL;
+	key = NULL;
+	response = NULL;
+	return STATUS_ERR;
+}
+
+static int dbase_pserver_iterate(
+	semanage_handle_t* handle,
+	dbase_pserver_t* dbase, 
+	int (*fn) (record_t* record, void* fn_arg),
+	void* arg) {
+
+	/* Stub */
+	handle = NULL;
+	dbase = NULL;
+	fn = NULL;
+	arg = NULL;
+	return STATUS_ERR;
+}
+
+static int dbase_pserver_del(
+	semanage_handle_t* handle,
+	dbase_pserver_t* dbase,
+	record_key_t* key) {
+
+	/* Stub */
+	handle = NULL;
+	dbase = NULL;
+	key = NULL;
+	return STATUS_ERR;
+}
+
+static int dbase_pserver_list(
+	semanage_handle_t* handle,
+	dbase_pserver_t* dbase,
+	record_t*** records,
+	size_t* count) {
+
+	/* Stub */
+	handle = NULL;
+	dbase = NULL;
+	records = NULL;
+	count = NULL;
+	return STATUS_ERR;
+}
+
+static record_table_t* dbase_pserver_get_rtable(
+	dbase_pserver_t* dbase) {
+
+	/* Stub */
+	return NULL;
+}
+
+
+/* PSERVER dbase - method table implementation */
+dbase_table_t SEMANAGE_PSERVER_DTABLE = {
+
+	/* Cache/Transactions */
+	.cache = dbase_pserver_cache,
+	.drop_cache = dbase_pserver_drop_cache,
+	.flush = dbase_pserver_flush,
+	.is_modified = dbase_pserver_is_modified,
+
+	/* Database API */
+	.iterate = dbase_pserver_iterate,
+	.exists = dbase_pserver_exists, 
+	.list = dbase_pserver_list,   
+	.add = dbase_pserver_add,
+	.set = dbase_pserver_set,
+	.del = dbase_pserver_del, 
+	.modify = dbase_pserver_modify, 
+	.query = dbase_pserver_query, 
+	.count = dbase_pserver_count, 
+
+	/* Polymorphism */
+	.get_rtable = dbase_pserver_get_rtable
+};
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsemanage/src/database_pserver.h new/libsemanage/src/database_pserver.h
--- old/libsemanage/src/database_pserver.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/database_pserver.h	2005-11-14 16:51:26.000000000 -0500
@@ -0,0 +1,15 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+#ifndef _SEMANAGE_DATABASE_PSERVER_INTERNAL_H_
+#define _SEMANAGE_DATABASE_PSERVER_INTERNAL_H_
+
+#include "database.h"
+#include "handle.h"
+
+struct dbase_pserver;
+typedef struct dbase_pserver dbase_pserver_t;
+
+/* PSERVER - method table implementation */
+extern dbase_table_t SEMANAGE_PSERVER_DTABLE;
+
+#endif

--------------090607010404000608030909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
