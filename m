Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAGE3RMA026412
	for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2005 09:03:28 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAGDtKSu006419
	for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2005 13:55:20 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id jAGDtKHq018242
	for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2005 08:55:20 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id jAGDtKH8018241
	for selinux@tycho.nsa.gov; Wed, 16 Nov 2005 08:55:20 -0500
Message-ID: <437A7AD5.6040500@cornell.edu>
Date: Tue, 15 Nov 2005 19:18:29 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEMANAGE ] Clear obsoleted objects
Content-Type: multipart/mixed;
 boundary="------------090209000904000707020400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090209000904000707020400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Get from here:
Preparing...                ########################################### 
[100%]
   1:selinux-policy-targeted########################################### 
[100%]
Attempting to install base module '/usr/share/selinux/targeted/base.pp':
Ok: return value of 0.
Committing changes:
libsepol.bool_update: boolean i18n_input_disable_trans no longer in policy
libsepol.bool_update: could not update boolean i18n_input_disable_trans
libsepol.sepol_bool_set: could not set boolean i18n_input_disable_trans
libsemanage.dbase_policydb_set: could not set record value
libsemanage.dbase_file_iterate: could not iterate over records
libsemanage.semanage_base_merge_components: could not merge local 
modifications into policy
libsemanage.semanage_expand_sandbox: Unable to merge local modifications 
into policy.
Failed!

to here:

Preparing...                ########################################### 
[100%]
   1:selinux-policy-targeted########################################### 
[100%]
Attempting to install base module '/usr/share/selinux/targeted/base.pp':
Ok: return value of 0.
Committing changes:
Ok: transaction number 0.

I really need to add some functions to the rtable that print out each 
object (in a more sensible format than the one that's written to the 
storage file), so we can report to the user what's being 
obsoleted/changed - note that there's no messages in policy_components.c 
for that reason. The TODO is related to "make libsemanage less verbose".


--------------090209000904000707020400
Content-Type: text/x-patch;
 name="libsemanage.clear_obsolete.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.clear_obsolete.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'booleans_kernel.*' --exclude 'database_pserver.*' old/libsemanage/src/boolean_internal.h new/libsemanage/src/boolean_internal.h
--- old/libsemanage/src/boolean_internal.h	2005-11-08 09:32:57.000000000 -0500
+++ new/libsemanage/src/boolean_internal.h	2005-11-15 19:03:24.000000000 -0500
@@ -13,4 +13,3 @@ hidden_proto(semanage_bool_key_extract)
 hidden_proto(semanage_bool_key_free)
 hidden_proto(semanage_bool_set_name)
 hidden_proto(semanage_bool_set_value)
-
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'booleans_kernel.*' --exclude 'database_pserver.*' old/libsemanage/src/booleans_local.c new/libsemanage/src/booleans_local.c
--- old/libsemanage/src/booleans_local.c	2005-11-08 09:32:57.000000000 -0500
+++ new/libsemanage/src/booleans_local.c	2005-11-15 19:03:32.000000000 -0500
@@ -7,7 +7,6 @@ typedef semanage_bool_t record_t;
 #define DBASE_RECORD_DEFINED
 
 #include <stddef.h>
-#include <semanage/booleans_local.h>
 #include "handle.h" 
 #include "database.h"
 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'booleans_kernel.*' --exclude 'database_pserver.*' old/libsemanage/src/policy_components.c new/libsemanage/src/policy_components.c
--- old/libsemanage/src/policy_components.c	2005-11-10 08:42:41.000000000 -0500
+++ new/libsemanage/src/policy_components.c	2005-11-15 19:06:35.000000000 -0500
@@ -1,5 +1,6 @@
 /* Copyright (C) 2005 Red Hat, Inc. */
 
+#include <stdlib.h>
 #include "policy.h"
 #include "handle.h"
 #include "database.h"
@@ -10,6 +11,56 @@
 #define MODE_SET    1
 #define MODE_MODIFY 2
 
+static int clear_obsolete(
+	semanage_handle_t* handle,
+	dbase_config_t* src,
+	dbase_config_t* dst) {
+
+	record_key_t* key = NULL;
+	record_t** records = NULL;
+	size_t nrecords = 0;
+	size_t i;
+
+	dbase_table_t* src_dtable = src->dtable;
+	dbase_table_t* dst_dtable = dst->dtable;
+	record_table_t* rtable = src_dtable->get_rtable(src->dbase);	
+
+	if (src_dtable->list(handle, src->dbase, &records, &nrecords) < 0)
+		goto err;
+
+	for (i = 0; i < nrecords; i++) {
+		int exists;
+
+		if (rtable->key_extract(handle, records[i], &key) < 0)
+			goto err;
+
+		if (dst_dtable->exists(handle, dst->dbase, key, &exists) < 0)
+			goto err;
+
+		if (!exists) {
+			if (src_dtable->del(handle, src->dbase, key) < 0)
+				goto err;
+
+			/* FIXME: notice to user */	
+                        /* INFO(handle, "boolean %s is obsolete, unsetting configured value..."); */
+		}
+	}
+
+	for (i=0; i < nrecords; i++)	
+		rtable->free(records[i]);
+	free(records);
+	free(key);
+	return STATUS_SUCCESS;
+
+	err:
+	/* FIXME: handle error */
+	for (i=0; i < nrecords; i++)
+		rtable->free(records[i]);
+	free(records);
+	free(key);
+	return STATUS_ERR;
+}
+
 typedef struct load_handler_arg {
 	semanage_handle_t* handle;
 	dbase_config_t* dconfig;
@@ -65,15 +116,14 @@ typedef struct load_table {
 
 /* This function must be called AFTER all modules are loaded.
  * Modules could be represented as a database, in which case
- * they should be loaded first, before the other components. */
+ * they should be loaded at the beginning of this function */
+
 int semanage_base_merge_components(
 	semanage_handle_t* handle) {
 
 	int i;
 	load_table_t components[] = {
 
-		/* FIXME: modules */
-
 		{ semanage_user_dbase_local(handle),
 		  semanage_user_dbase_policy(handle), MODE_MODIFY },
 #if 0
@@ -104,6 +154,11 @@ int semanage_base_merge_components(
 
 		if (to->dtable->cache(handle, to->dbase) < 0) 
 			goto err;
+
+		/* Clear obsolete items for MODE_SET */
+		if (components[i].mode == MODE_SET)
+			if (clear_obsolete(handle, from, to) < 0)
+				goto err;
 		
 		/* Now iterate */
 		if (from->dtable->iterate(
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude 'booleans_kernel.*' --exclude 'database_pserver.*' old/libsemanage/src/semanage_store.c new/libsemanage/src/semanage_store.c
--- old/libsemanage/src/semanage_store.c	2005-11-15 08:06:18.000000000 -0500
+++ new/libsemanage/src/semanage_store.c	2005-11-15 19:03:42.000000000 -0500
@@ -1389,10 +1389,8 @@ int semanage_expand_sandbox(semanage_han
         dbase_policydb_detach(semanage_iface_dbase_policy(sh)->dbase);
         dbase_policydb_detach(semanage_bool_dbase_policy(sh)->dbase);
 
-	if (retval < 0) {
-		ERR(sh, "Unable to merge local modifications into policy.");
+	if (retval < 0) 
 		goto cleanup;
-	}
 
 	if ((kernel_filename = semanage_path(SEMANAGE_TMP, SEMANAGE_KERNEL)) == NULL) {
 		goto cleanup;

--------------090209000904000707020400--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
