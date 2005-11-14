Message-ID: <437903B8.4040701@cornell.edu>
Date: Mon, 14 Nov 2005 16:38:00 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Stub kernel booleans API
Content-Type: multipart/mixed;
 boundary="------------000002010708010302090302"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000002010708010302090302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm not sure if I'll be layering those on top of dbase... maybe..
 

--------------000002010708010302090302
Content-Type: text/x-patch;
 name="libsemanage.stub_kernel_booleans.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.stub_kernel_booleans.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsemanage/include/semanage/booleans_kernel.h new/libsemanage/include/semanage/booleans_kernel.h
--- old/libsemanage/include/semanage/booleans_kernel.h	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/include/semanage/booleans_kernel.h	2005-11-14 16:24:18.000000000 -0500
@@ -0,0 +1,40 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+#ifndef _SEMANAGE_BOOLEANS_KERNEL_H_
+#define _SEMANAGE_BOOLEANS_KERNEL_H_
+
+#include <stddef.h>
+#include <semanage/handle.h> 
+#include <semanage/boolean_record.h>
+
+extern int semanage_bool_set_kernel(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data);
+
+extern int semanage_bool_query_kernel(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t** response);
+
+extern int semanage_bool_exists_kernel(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	int* response);
+
+extern int semanage_bool_count_kernel(
+	semanage_handle_t* handle,
+	unsigned int* response);
+
+extern int semanage_bool_iterate_kernel(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_bool_t* record,
+	                void* varg),
+	void* handler_arg);
+
+extern int semanage_bool_list_kernel(
+	semanage_handle_t* handle,
+	semanage_bool_t*** records,
+	size_t* size);
+
+#endif
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION old/libsemanage/src/booleans_kernel.c new/libsemanage/src/booleans_kernel.c
--- old/libsemanage/src/booleans_kernel.c	1969-12-31 19:00:00.000000000 -0500
+++ new/libsemanage/src/booleans_kernel.c	2005-11-14 16:28:22.000000000 -0500
@@ -0,0 +1,78 @@
+/* Copyright (C) 2005 Red Hat, Inc. */
+
+#include "boolean_internal.h"
+
+#include <stddef.h>
+#include <semanage/booleans_kernel.h>
+#include "debug.h"
+#include "handle.h"
+
+int semanage_bool_set_kernel(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t* data) {
+
+	/* Stub */
+	handle = NULL;
+	key = NULL;
+	data = NULL;
+	return STATUS_ERR;
+}
+
+int semanage_bool_query_kernel(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	semanage_bool_t** response) {
+	
+	/* Stub */
+	handle = NULL;
+	key = NULL;
+	response = NULL;
+	return STATUS_ERR;
+}
+
+int semanage_bool_exists_kernel(
+	semanage_handle_t* handle,
+	semanage_bool_key_t* key,
+	int* response) {
+
+	/* Stub */
+	handle = NULL;
+	key = NULL;
+	response = NULL;
+	return STATUS_ERR;
+}
+
+int semanage_bool_count_kernel(
+	semanage_handle_t* handle,
+	unsigned int* response) {
+
+	/* Stub */
+	handle = NULL;
+	response = NULL;
+	return STATUS_ERR;
+}
+
+int semanage_bool_iterate_kernel(
+	semanage_handle_t* handle,
+	int (*handler) (semanage_bool_t* record,
+	                void* varg),
+	void* handler_arg) {
+
+	/* Stub */
+	handle = NULL;
+	handler = NULL;
+	handler_arg = NULL;
+	return STATUS_ERR;
+}
+
+int semanage_bool_list_kernel(
+	semanage_handle_t* handle,
+	semanage_bool_t*** records,
+	size_t* count) {
+
+	handle = NULL;
+	records = NULL;
+	count = NULL;
+	return STATUS_ERR;
+}

--------------000002010708010302090302--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
