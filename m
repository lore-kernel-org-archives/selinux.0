Message-ID: <435527D2.6050301@cornell.edu>
Date: Tue, 18 Oct 2005 12:50:26 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Default database 
Content-Type: multipart/mixed;
 boundary="------------060104020109060605030309"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060104020109060605030309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds a default database, so that when the dbase functions are 
called, and the dbase is not initialized (which occurs if not connected, 
currently), the user will get a warning, instead of a crash.

--------------060104020109060605030309
Content-Type: text/x-patch;
 name="libsemanage.default.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.default.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/database_default.c new/libsemanage/src/database_default.c
--- old/libsemanage/src/database_default.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/database_default.c	2005-10-18 12:44:00.000000000 -0400
@@ -0,0 +1,141 @@
+typedef void* dbase_default_t;
+typedef dbase_default_t dbase_t;
+#define DBASE_DEFINED
+
+#include "handle.h"
+#include "debug.h"
+#include "database_default.h"
+
+static inline int err_uninitialized(
+	semanage_handle_t* handle) {
+	
+	ERR(handle, 
+		"A direct or server connection is needed "
+		"to use this function - please call "
+		"the corresponding connect() method");
+
+	return STATUS_ERR;
+}
+
+static int dbase_default_flush(
+	semanage_handle_t* handle,	
+	dbase_default_t* dbase) {
+
+	dbase = NULL;
+	return err_uninitialized(handle);
+}
+
+
+static void dbase_default_drop_cache(
+	semanage_handle_t* handle,       
+	dbase_default_t* dbase) {
+
+	dbase = NULL;
+	err_uninitialized(handle);
+}
+
+static int dbase_default_add (
+	semanage_handle_t* handle,
+	dbase_default_t* dbase,
+	record_key_t* key,
+	record_t* data) {
+	
+	key = NULL;
+	data = NULL;
+	dbase = NULL;
+	return err_uninitialized(handle);
+}
+
+static int dbase_default_modify (
+	semanage_handle_t* handle,
+	dbase_default_t* dbase,
+	record_key_t* key,
+	record_t* data) {
+
+	key = NULL;
+	data = NULL;	
+	dbase = NULL;
+	return err_uninitialized(handle);
+}
+
+static int dbase_default_del (
+	semanage_handle_t* handle,
+	dbase_default_t* dbase,
+	record_key_t* key) {
+
+	key = NULL;
+	dbase = NULL;
+	return err_uninitialized(handle);
+}
+
+static int dbase_default_query (
+	semanage_handle_t* handle,
+	dbase_default_t* dbase,
+	record_key_t* key,
+	record_t** response) {
+
+	key = NULL;
+	response = NULL;
+	dbase = NULL;
+	return err_uninitialized(handle);
+}
+
+static int dbase_default_exists (
+	semanage_handle_t* handle,
+	dbase_default_t* dbase,
+	record_key_t* key,
+	int* response) {
+
+	key = NULL;
+	response = NULL;
+	dbase = NULL;
+	return err_uninitialized(handle);
+}
+
+static int dbase_default_count (
+	semanage_handle_t* handle,
+	dbase_default_t* dbase,
+	int* response) {
+
+	response = NULL;
+	dbase = NULL;
+	return err_uninitialized(handle);
+}
+
+static int dbase_default_iterate(
+	semanage_handle_t* handle,
+	dbase_default_t* dbase,
+	int (*fn) (record_t* record, void* fn_arg),
+	void* fn_arg) {
+
+	fn = NULL;
+	fn_arg = NULL;
+	dbase = NULL;
+	return err_uninitialized(handle);
+}
+
+static int dbase_default_list (
+	semanage_handle_t* handle,
+	dbase_t* dbase,
+	record_t*** records,
+	size_t* count) {
+
+	records = NULL;
+	count = NULL;
+	dbase = NULL;
+	return err_uninitialized(handle);
+}
+
+/* DEFAULT dbase - method table implementation */
+dbase_table_t SEMANAGE_DEFAULT_DTABLE = {
+	.drop_cache = dbase_default_drop_cache,
+	.flush = dbase_default_flush,
+	.iterate = dbase_default_iterate,
+	.exists = dbase_default_exists,
+	.list = dbase_default_list,
+	.add = dbase_default_add,
+	.del = dbase_default_del,
+	.modify = dbase_default_modify, 
+	.query = dbase_default_query,
+	.count = dbase_default_count,
+};
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/database_default.h new/libsemanage/src/database_default.h
--- old/libsemanage/src/database_default.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/database_default.h	2005-10-18 12:44:03.000000000 -0400
@@ -0,0 +1,14 @@
+#ifndef _SEMANAGE_DATABASE_DEFAULT_INTERNAL_H_
+#define _SEMANAGE_DATABASE_DEFAULT_INTERNAL_H_
+
+#include "database.h"
+
+/* DEFAULT database - method table implementation */
+extern dbase_table_t SEMANAGE_DEFAULT_DTABLE;
+
+static inline void semanage_default_dconfig(dbase_config_t* dconfig) {
+	dconfig->dbase = NULL;
+	dconfig->dtable = &SEMANAGE_DEFAULT_DTABLE;
+}
+
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'semanage_store*' --exclude 'module_record*' --exclude 'database_directory*' old/libsemanage/src/handle.c new/libsemanage/src/handle.c
--- old/libsemanage/src/handle.c	2005-10-18 10:53:30.000000000 -0400
+++ new/libsemanage/src/handle.c	2005-10-18 12:45:09.000000000 -0400
@@ -34,12 +34,14 @@
 #include "debug.h"
 #include "semanage_conf.h"
 #include "semanage_store.h"
+#include "database_default.h"
 
 #define SEMANAGE_COMMIT_READ_WAIT 5
 
 semanage_handle_t *semanage_handle_create(void) {
 	semanage_handle_t *sh = NULL;
 	const char *conf_name = NULL;
+	int i;
 
 	/* Allocate handle */
 	if ((sh = calloc(1, sizeof(semanage_handle_t))) == NULL)
@@ -67,6 +69,10 @@ semanage_handle_t *semanage_handle_creat
 	sh->msg_callback = semanage_msg_default_handler;
 	sh->msg_callback_arg = NULL;
 
+	/* Initialize databases */
+	for (i = 0; i < DBASE_COUNT; i++)
+		semanage_default_dconfig(&sh->dbase[i]);
+
         return sh;
 
  err:

--------------060104020109060605030309--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
