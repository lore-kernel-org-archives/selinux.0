Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n67HWuZ7020356
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 13:32:56 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n67HXZlO007329
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 17:33:36 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n67HWt3I007664
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 13:32:55 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n67HWsng032076
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 13:32:54 -0400
Received: from [10.16.3.86] (dhcp-100-3-86.bos.redhat.com [10.16.3.86])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n67HWrXA013543
	for <selinux@tycho.nsa.gov>; Tue, 7 Jul 2009 13:32:53 -0400
Message-ID: <4A5386C0.8070802@redhat.com>
Date: Tue, 07 Jul 2009 13:32:48 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [Patch 2/2 v7] libsemanage: maintain disable dontaudit state between
 handle commits
Content-Type: multipart/mixed;
 boundary="------------020502070103040406050205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020502070103040406050205
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Currently any changes made to the policy which require committing a handle cause dontaudit rules to be re-enabled. This is confusing, and frustrating for users who want to edit policy with dontaudit rules turned off. This patch allows semanage to remember the last state of the dontaudit rules and apply them as default whenever a handle is connected. Additionally other functions may check for the file semanage creates to determine if dontaudit rules are turned on. This knowledge can be useful for tools like SETroubleshoot which may want to change their behavior depending on the state of the dontaudit rules. In the event that a the file cannot be created a call to commit will fail.
   
Signed-off-by: Christopher Pardy <cpardy@redhat.com>

---
 libsemanage/include/semanage/handle.h |    3 +++
 libsemanage/src/direct_api.c          |   32 +++++++++++++++++++++++++++++++-
 libsemanage/src/handle.c              |    9 ++++++++-
 libsemanage/src/libsemanage.map       |    2 +-
 libsemanage/src/semanage_store.c      |    1 +
 libsemanage/src/semanage_store.h      |    1 +
 6 files changed, 45 insertions(+), 3 deletions(-)


diff -urpN selinux.orig2/libsemanage/include/semanage/handle.h selinux.orig3/libsemanage/include/semanage/handle.h
--- selinux.orig2/libsemanage/include/semanage/handle.h	2009-07-01 21:15:17.224235939 -0400
+++ selinux.orig3/libsemanage/include/semanage/handle.h	2009-07-07 13:27:46.543350374 -0400
@@ -69,6 +69,9 @@ void semanage_set_rebuild(semanage_handl
  * 1 for yes, 0 for no (default) */
 void semanage_set_create_store(semanage_handle_t * handle, int create_store);
 
+/*Get whether or not to dontaudits will be disabled upon commit */
+int semanage_get_disable_dontaudit(semanage_handle_t * handle);
+
 /* Set whether or not to disable dontaudits upon commit */
 void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
 
diff -urpN selinux.orig2/libsemanage/src/direct_api.c selinux.orig3/libsemanage/src/direct_api.c
--- selinux.orig2/libsemanage/src/direct_api.c	2009-07-01 21:15:17.264236347 -0400
+++ selinux.orig3/libsemanage/src/direct_api.c	2009-07-07 13:26:25.135320503 -0400
@@ -20,6 +20,7 @@
  */
 
 #include <sepol/module.h>
+#include <sepol/handle.h>
 #include <selinux/selinux.h>
 
 #include <assert.h>
@@ -111,6 +112,7 @@ int semanage_direct_is_managed(semanage_
 int semanage_direct_connect(semanage_handle_t * sh)
 {
 	char polpath[PATH_MAX];
+	const char *path;
 
 	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(),
 		 sh->conf->store_path);
@@ -223,6 +225,13 @@ int semanage_direct_connect(semanage_han
 	if (bool_activedb_dbase_init(sh, semanage_bool_dbase_active(sh)) < 0)
 		goto err;
 
+	/* set the disable dontaudit value */
+	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT);
+	if(access(path,F_OK) == 0)
+		sepol_set_disable_dontaudit(sh->sepolh,1);
+	else
+		sepol_set_disable_dontaudit(sh->sepolh,0);
+
 	return STATUS_SUCCESS;
 
       err:
@@ -645,7 +654,7 @@ static int semanage_direct_commit(semana
 	char **mod_filenames = NULL;
 	char *sorted_fc_buffer = NULL, *sorted_nc_buffer = NULL;
 	size_t sorted_fc_buffer_len = 0, sorted_nc_buffer_len = 0;
-	const char *linked_filename = NULL, *ofilename = NULL;
+	const char *linked_filename = NULL, *ofilename = NULL, *path;
 	sepol_module_package_t *base = NULL;
 	int retval = -1, num_modfiles = 0, i;
 	sepol_policydb_t *out = NULL;
@@ -669,6 +678,27 @@ static int semanage_direct_commit(semana
 	dbase_config_t *pfcontexts = semanage_fcontext_dbase_policy(sh);
 	dbase_config_t *seusers = semanage_seuser_dbase_local(sh);
 
+	/* Immediently create the disable_dontaudit flag */
+	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT);
+	if (sepol_get_disable_dontaudit(sh->sepolh) == 1) {
+		FILE *touch;
+		touch = fopen(path,"w");
+		if (touch != NULL) {
+			if (fclose(touch) != 0) {
+				ERR(sh,"Error attempting to create disable_dontaudit flag.");
+				goto cleanup;
+			}
+		} else {
+			ERR(sh,"Error attempting to create disable_dontaudit flag.");
+			goto cleanup;
+		}
+	} else {
+		if (remove(path) == -1 && errno != ENOENT) {
+			ERR(sh,"Error removing the disable_dontaudit flag.");
+			goto cleanup;
+		}
+	}
+
 	/* Before we do anything else, flush the join to its component parts.
 	 * This *does not* flush to disk automatically */
 	if (users->dtable->is_modified(users->dbase)) {
diff -urpN selinux.orig2/libsemanage/src/handle.c selinux.orig3/libsemanage/src/handle.c
--- selinux.orig2/libsemanage/src/handle.c	2009-07-01 21:15:17.288238017 -0400
+++ selinux.orig3/libsemanage/src/handle.c	2009-07-07 12:05:02.964347072 -0400
@@ -110,6 +110,13 @@ void semanage_set_create_store(semanage_
 	return;
 }
 
+int semanage_get_disable_dontaudit(semanage_handle_t * sh)
+{
+	assert(sh != NULL);
+
+	return sepol_get_disable_dontaudit(sh->sepolh);
+}
+
 void semanage_set_disable_dontaudit(semanage_handle_t * sh, int disable_dontaudit)
 {
 	assert(sh != NULL);
@@ -264,7 +271,7 @@ int semanage_commit(semanage_handle_t * 
 	assert(sh != NULL && sh->funcs != NULL && sh->funcs->commit != NULL);
 	if (!sh->is_in_transaction) {
 		ERR(sh,
-		    "Will not commit because caller does not have a tranaction lock yet.");
+		    "Will not commit because caller does not have a transaction lock yet.");
 		return -1;
 	}
 	retval = sh->funcs->commit(sh);
diff -urpN selinux.orig2/libsemanage/src/libsemanage.map selinux.orig3/libsemanage/src/libsemanage.map
--- selinux.orig2/libsemanage/src/libsemanage.map	2009-07-01 21:15:17.290237650 -0400
+++ selinux.orig3/libsemanage/src/libsemanage.map	2009-07-06 13:26:53.591167982 -0400
@@ -15,7 +15,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
 	  semanage_node_*;
 	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
-	  semanage_is_connected; semanage_set_disable_dontaudit;
+	  semanage_is_connected; semanage_get_disable_dontaudit; semanage_set_disable_dontaudit;
 	  semanage_mls_enabled;
   local: *;
 };
diff -urpN selinux.orig2/libsemanage/src/semanage_store.c selinux.orig3/libsemanage/src/semanage_store.c
--- selinux.orig2/libsemanage/src/semanage_store.c	2009-07-01 21:15:17.271236564 -0400
+++ selinux.orig3/libsemanage/src/semanage_store.c	2009-07-06 13:26:53.598164077 -0400
@@ -114,6 +114,7 @@ static const char *semanage_sandbox_path
 	"/users_extra",
 	"/netfilter_contexts",
 	"/file_contexts.homedirs",
+	"/disable_dontaudit",
 };
 
 /* A node used in a linked list of file contexts; used for sorting.
diff -urpN selinux.orig2/libsemanage/src/semanage_store.h selinux.orig3/libsemanage/src/semanage_store.h
--- selinux.orig2/libsemanage/src/semanage_store.h	2009-07-01 21:15:17.262235597 -0400
+++ selinux.orig3/libsemanage/src/semanage_store.h	2009-07-06 13:26:53.626166474 -0400
@@ -58,6 +58,7 @@ enum semanage_sandbox_defs {
 	SEMANAGE_USERS_EXTRA,
 	SEMANAGE_NC,
 	SEMANAGE_FC_HOMEDIRS,
+	SEMANAGE_DISABLE_DONTAUDIT,
 	SEMANAGE_STORE_NUM_PATHS
 };


--------------020502070103040406050205
Content-Type: text/plain;
 name="selinux.patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="selinux.patch2"

diff -urpN selinux.orig2/libsemanage/include/semanage/handle.h selinux.orig3/libsemanage/include/semanage/handle.h
--- selinux.orig2/libsemanage/include/semanage/handle.h	2009-07-01 21:15:17.224235939 -0400
+++ selinux.orig3/libsemanage/include/semanage/handle.h	2009-07-07 13:27:46.543350374 -0400
@@ -69,6 +69,9 @@ void semanage_set_rebuild(semanage_handl
  * 1 for yes, 0 for no (default) */
 void semanage_set_create_store(semanage_handle_t * handle, int create_store);
 
+/*Get whether or not to dontaudits will be disabled upon commit */
+int semanage_get_disable_dontaudit(semanage_handle_t * handle);
+
 /* Set whether or not to disable dontaudits upon commit */
 void semanage_set_disable_dontaudit(semanage_handle_t * handle, int disable_dontaudit);
 
diff -urpN selinux.orig2/libsemanage/src/direct_api.c selinux.orig3/libsemanage/src/direct_api.c
--- selinux.orig2/libsemanage/src/direct_api.c	2009-07-01 21:15:17.264236347 -0400
+++ selinux.orig3/libsemanage/src/direct_api.c	2009-07-07 13:26:25.135320503 -0400
@@ -20,6 +20,7 @@
  */
 
 #include <sepol/module.h>
+#include <sepol/handle.h>
 #include <selinux/selinux.h>
 
 #include <assert.h>
@@ -111,6 +112,7 @@ int semanage_direct_is_managed(semanage_
 int semanage_direct_connect(semanage_handle_t * sh)
 {
 	char polpath[PATH_MAX];
+	const char *path;
 
 	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(),
 		 sh->conf->store_path);
@@ -223,6 +225,13 @@ int semanage_direct_connect(semanage_han
 	if (bool_activedb_dbase_init(sh, semanage_bool_dbase_active(sh)) < 0)
 		goto err;
 
+	/* set the disable dontaudit value */
+	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT);
+	if(access(path,F_OK) == 0)
+		sepol_set_disable_dontaudit(sh->sepolh,1);
+	else
+		sepol_set_disable_dontaudit(sh->sepolh,0);
+
 	return STATUS_SUCCESS;
 
       err:
@@ -645,7 +654,7 @@ static int semanage_direct_commit(semana
 	char **mod_filenames = NULL;
 	char *sorted_fc_buffer = NULL, *sorted_nc_buffer = NULL;
 	size_t sorted_fc_buffer_len = 0, sorted_nc_buffer_len = 0;
-	const char *linked_filename = NULL, *ofilename = NULL;
+	const char *linked_filename = NULL, *ofilename = NULL, *path;
 	sepol_module_package_t *base = NULL;
 	int retval = -1, num_modfiles = 0, i;
 	sepol_policydb_t *out = NULL;
@@ -669,6 +678,27 @@ static int semanage_direct_commit(semana
 	dbase_config_t *pfcontexts = semanage_fcontext_dbase_policy(sh);
 	dbase_config_t *seusers = semanage_seuser_dbase_local(sh);
 
+	/* Immediently create the disable_dontaudit flag */
+	path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT);
+	if (sepol_get_disable_dontaudit(sh->sepolh) == 1) {
+		FILE *touch;
+		touch = fopen(path,"w");
+		if (touch != NULL) {
+			if (fclose(touch) != 0) {
+				ERR(sh,"Error attempting to create disable_dontaudit flag.");
+				goto cleanup;
+			}
+		} else {
+			ERR(sh,"Error attempting to create disable_dontaudit flag.");
+			goto cleanup;
+		}
+	} else {
+		if (remove(path) == -1 && errno != ENOENT) {
+			ERR(sh,"Error removing the disable_dontaudit flag.");
+			goto cleanup;
+		}
+	}
+
 	/* Before we do anything else, flush the join to its component parts.
 	 * This *does not* flush to disk automatically */
 	if (users->dtable->is_modified(users->dbase)) {
diff -urpN selinux.orig2/libsemanage/src/handle.c selinux.orig3/libsemanage/src/handle.c
--- selinux.orig2/libsemanage/src/handle.c	2009-07-01 21:15:17.288238017 -0400
+++ selinux.orig3/libsemanage/src/handle.c	2009-07-07 12:05:02.964347072 -0400
@@ -110,6 +110,13 @@ void semanage_set_create_store(semanage_
 	return;
 }
 
+int semanage_get_disable_dontaudit(semanage_handle_t * sh)
+{
+	assert(sh != NULL);
+
+	return sepol_get_disable_dontaudit(sh->sepolh);
+}
+
 void semanage_set_disable_dontaudit(semanage_handle_t * sh, int disable_dontaudit)
 {
 	assert(sh != NULL);
@@ -264,7 +271,7 @@ int semanage_commit(semanage_handle_t * 
 	assert(sh != NULL && sh->funcs != NULL && sh->funcs->commit != NULL);
 	if (!sh->is_in_transaction) {
 		ERR(sh,
-		    "Will not commit because caller does not have a tranaction lock yet.");
+		    "Will not commit because caller does not have a transaction lock yet.");
 		return -1;
 	}
 	retval = sh->funcs->commit(sh);
diff -urpN selinux.orig2/libsemanage/src/libsemanage.map selinux.orig3/libsemanage/src/libsemanage.map
--- selinux.orig2/libsemanage/src/libsemanage.map	2009-07-01 21:15:17.290237650 -0400
+++ selinux.orig3/libsemanage/src/libsemanage.map	2009-07-06 13:26:53.591167982 -0400
@@ -15,7 +15,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_iface_*; semanage_port_*; semanage_context_*;
 	  semanage_node_*;
 	  semanage_fcontext_*; semanage_access_check; semanage_set_create_store;
-	  semanage_is_connected; semanage_set_disable_dontaudit;
+	  semanage_is_connected; semanage_get_disable_dontaudit; semanage_set_disable_dontaudit;
 	  semanage_mls_enabled;
   local: *;
 };
diff -urpN selinux.orig2/libsemanage/src/semanage_store.c selinux.orig3/libsemanage/src/semanage_store.c
--- selinux.orig2/libsemanage/src/semanage_store.c	2009-07-01 21:15:17.271236564 -0400
+++ selinux.orig3/libsemanage/src/semanage_store.c	2009-07-06 13:26:53.598164077 -0400
@@ -114,6 +114,7 @@ static const char *semanage_sandbox_path
 	"/users_extra",
 	"/netfilter_contexts",
 	"/file_contexts.homedirs",
+	"/disable_dontaudit",
 };
 
 /* A node used in a linked list of file contexts; used for sorting.
diff -urpN selinux.orig2/libsemanage/src/semanage_store.h selinux.orig3/libsemanage/src/semanage_store.h
--- selinux.orig2/libsemanage/src/semanage_store.h	2009-07-01 21:15:17.262235597 -0400
+++ selinux.orig3/libsemanage/src/semanage_store.h	2009-07-06 13:26:53.626166474 -0400
@@ -58,6 +58,7 @@ enum semanage_sandbox_defs {
 	SEMANAGE_USERS_EXTRA,
 	SEMANAGE_NC,
 	SEMANAGE_FC_HOMEDIRS,
+	SEMANAGE_DISABLE_DONTAUDIT,
 	SEMANAGE_STORE_NUM_PATHS
 };
 


--------------020502070103040406050205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
