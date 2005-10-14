Message-ID: <434FEA78.3090406@cornell.edu>
Date: Fri, 14 Oct 2005 13:27:20 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>,
   Karl MacMillan <kmacmillan@tresys.com>
Subject: [ SEMANAGE ] Seuser record
Content-Type: multipart/mixed;
 boundary="------------070209050300050705090506"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070209050300050705090506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add seuser record to semanage. A seuser record is a mapping from the 
seusers file.
I am still expecting objections from Tresys, based on previous 
discussion of this,
but if there are none, please merge.

This code was copied straight out of sepol/user_record.c.
I deleted roles, mls_level, and added sename.
Also modified to pass in the handle and use it, where failures occur.

--------------070209050300050705090506
Content-Type: text/x-patch;
 name="libsemanage.seuser_record.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.seuser_record.diff"

diff -Naur libsemanage/include/semanage/seuser_record.h libsemanage.new/include/semanage/seuser_record.h
--- libsemanage/include/semanage/seuser_record.h	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/include/semanage/seuser_record.h	2005-10-14 13:19:03.000000000 -0400
@@ -0,0 +1,69 @@
+#ifndef _SEMANAGE_SEUSER_RECORD_H_
+#define _SEMANAGE_SEUSER_RECORD_H_
+
+#include <stddef.h>
+#include <semanage/handle.h>
+
+struct semanage_seuser;
+struct semanage_seuser_key;
+typedef struct semanage_seuser semanage_seuser_t;
+typedef struct semanage_seuser_key semanage_seuser_key_t;
+
+/* Key */
+extern int semanage_seuser_key_create(
+	semanage_handle_t* handle,
+	const char* name, 
+	semanage_seuser_key_t** key);
+
+extern int semanage_seuser_key_extract(
+	semanage_handle_t* handle,
+	semanage_seuser_t* seuser, 
+	semanage_seuser_key_t** key);
+
+extern void semanage_seuser_key_free(
+	semanage_seuser_key_t* key);
+
+extern int semanage_seuser_compare(
+	semanage_seuser_t* seuser, 
+	semanage_seuser_key_t* key);
+	
+/* Name */
+extern const char* semanage_seuser_get_name(
+	semanage_seuser_t* seuser);
+
+extern int semanage_seuser_set_name(
+	semanage_handle_t* handle,
+	semanage_seuser_t* seuser, 
+	const char* name);
+
+/* Selinux Name */
+extern const char* semanage_seuser_get_sename(
+	semanage_seuser_t* seuser);
+
+extern int semanage_seuser_set_sename(
+	semanage_handle_t* handle,
+	semanage_seuser_t* seuser,
+	const char* sename);
+
+/* MLS */
+extern const char* semanage_seuser_get_mlsrange(
+	semanage_seuser_t* seuser);
+
+extern int semanage_seuser_set_mlsrange(
+	semanage_handle_t* handle,
+	semanage_seuser_t* seuser, 
+	const char* mls_range);
+
+/* Create/Clone/Destroy */
+extern int semanage_seuser_create(
+	semanage_handle_t* handle,
+	semanage_seuser_t** seuser_ptr);
+
+extern int semanage_seuser_clone(
+	semanage_handle_t* handle,
+	semanage_seuser_t* seuser, 
+	semanage_seuser_t** seuser_ptr);
+
+extern void semanage_seuser_free(
+	semanage_seuser_t* seuser);
+#endif
diff -Naur libsemanage/src/seuser_record.c libsemanage.new/src/seuser_record.c
--- libsemanage/src/seuser_record.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage.new/src/seuser_record.c	2005-10-14 13:19:26.000000000 -0400
@@ -0,0 +1,195 @@
+#include <stdlib.h>
+#include <string.h>
+
+#include <semanage/seuser_record.h>
+#include "debug.h"
+#include "handle.h"
+
+struct semanage_seuser {
+	/* This user's name */
+	char* name;
+
+	/* This user's corresponding 
+	 * seuser ("role set") */
+	char* sename;
+
+	/* This user's mls range (only required for mls) */
+	char* mls_range;
+};
+
+struct semanage_seuser_key {
+	/* This user's name */
+	const char* name;
+};
+
+int semanage_seuser_key_create(
+	semanage_handle_t* handle,
+	const char* name,
+	semanage_seuser_key_t** key_ptr) {
+
+	semanage_seuser_key_t* tmp_key = 
+		(semanage_seuser_key_t*) 
+		malloc(sizeof (semanage_seuser_key_t));
+
+	if (!tmp_key) {
+		ERR(handle, "out of memory, could not create seuser key");
+		return STATUS_ERR;
+	}
+	tmp_key->name = name;
+
+	*key_ptr = tmp_key;
+	return STATUS_SUCCESS;
+}
+
+int semanage_seuser_key_extract(
+	semanage_handle_t* handle,
+	semanage_seuser_t* seuser, 
+	semanage_seuser_key_t** key_ptr) {
+
+	if (semanage_seuser_key_create(handle, seuser->name, key_ptr) < 0) {
+		ERR(handle, "could not extract key from seuser %s",
+			seuser->name);
+		return STATUS_ERR;
+	}
+
+	return STATUS_SUCCESS;
+}	
+
+void semanage_seuser_key_free(semanage_seuser_key_t* key) {
+	free(key);
+}
+
+int semanage_seuser_compare(
+	semanage_seuser_t* seuser,
+	semanage_seuser_key_t* key) {
+	
+	if (!strcmp(seuser->name, key->name))
+		return 0;
+	return 1;
+}
+
+/* Name */
+const char* semanage_seuser_get_name(
+	semanage_seuser_t* seuser) {
+
+	return seuser->name;
+}
+
+int semanage_seuser_set_name(
+	semanage_handle_t* handle, 
+	semanage_seuser_t* seuser, 
+	const char* name) {
+
+	seuser->name = strdup(name);
+	if (!seuser->name) {
+		ERR(handle,  "out of memory, could not set name");
+		return STATUS_ERR;
+	}
+	return STATUS_SUCCESS;
+}
+
+/* Selinux Name */
+const char* semanage_seuser_get_sename(
+	semanage_seuser_t* seuser) {
+
+	return seuser->sename;
+}
+
+int semanage_seuser_set_sename(
+	semanage_handle_t* handle,
+	semanage_seuser_t* seuser,
+	const char* sename) {
+
+	seuser->sename = strdup(sename);
+	if (!seuser->sename) {
+		ERR(handle,  "out of memory, could not set name");
+		return STATUS_ERR;
+	}
+	return STATUS_SUCCESS;
+}
+
+/* MLS Range */
+const char* semanage_seuser_get_mlsrange(
+	semanage_seuser_t* seuser) {
+
+	return seuser->mls_range;
+}
+
+int semanage_seuser_set_mlsrange(
+	semanage_handle_t* handle, 
+	semanage_seuser_t* seuser, 
+	const char* mls_range) {
+
+	seuser->mls_range = strdup(mls_range);
+	if (!seuser->mls_range) {
+		ERR(handle, "out of memory, could not set "
+			"MLS allowed range");
+		return STATUS_ERR;
+	}
+	return STATUS_SUCCESS;
+}
+
+/* Create */
+int semanage_seuser_create(
+	semanage_handle_t* handle,
+	semanage_seuser_t** seuser_ptr) {
+
+	semanage_seuser_t* seuser = 
+		(semanage_seuser_t*) malloc(sizeof (semanage_seuser_t));
+
+        if (!seuser) {
+		ERR(handle, "out of memory, "
+			"could not create seuser record"); 
+		return STATUS_ERR;
+	}
+
+        seuser->name = NULL;
+	seuser->sename = NULL;
+	seuser->mls_range = NULL;
+	
+	*seuser_ptr = seuser;
+	return STATUS_SUCCESS;
+}
+
+/* Deep copy clone */
+int semanage_seuser_clone(
+	semanage_handle_t* handle,
+	semanage_seuser_t* seuser, 
+	semanage_seuser_t** seuser_ptr) {
+
+	semanage_seuser_t* new_seuser = NULL;
+
+	if (semanage_seuser_create(handle, &new_seuser) < 0)
+		goto err;
+
+	if (semanage_seuser_set_name(handle, new_seuser, seuser->name) < 0)
+		goto err;
+
+	if (semanage_seuser_set_sename(handle, new_seuser, seuser->sename) < 0)
+		goto err;
+
+	if (seuser->mls_range &&
+	   (semanage_seuser_set_mlsrange(handle, new_seuser, seuser->mls_range) < 0))
+		goto err;
+
+	*seuser_ptr = new_seuser;
+	return STATUS_SUCCESS;
+
+	err:
+	ERR(handle, "could not clone seuser record");
+	semanage_seuser_free(new_seuser);
+	return STATUS_ERR;
+}
+
+/* Destroy */
+void semanage_seuser_free(
+	semanage_seuser_t* seuser) {
+
+	if (!seuser)
+		return;
+	
+	free(seuser->name);
+	free(seuser->sename);
+	free(seuser->mls_range);
+	free(seuser);
+}

--------------070209050300050705090506--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
