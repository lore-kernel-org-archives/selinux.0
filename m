From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 04/13] libsemanage: split final files into /var/lib/selinux/tmp
Date: Wed, 23 Dec 2009 18:25:51 -0500
Message-Id: <1261610760-4724-5-git-send-email-ccase@tresys.com>
In-Reply-To: <1261610760-4724-4-git-send-email-ccase@tresys.com>
References: <1261610760-4724-1-git-send-email-ccase@tresys.com>
 <1261610760-4724-2-git-send-email-ccase@tresys.com>
 <1261610760-4724-3-git-send-email-ccase@tresys.com>
 <1261610760-4724-4-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch moves the final files from inside
/var/lib/selinux/<store>/[active|previous|tmp] to
/var/lib/selinux/tmp/<store>. The move is done to facilitate using
source control management on the /var/lib/selinux/<store> directory. If
these files remain in /var/lib/selinux/<store> they will pose a size
problem if an SCM like git is used as we'd be storing lots of binary
diffs. We are suggesting making this change now, rather than later when
source policy, SCM, and CIL[1] support are available, to ease the
migration burden.

These are the files that have been moved:

/var/lib/selinux/<store>/active/...	/var/lib/selinux/tmp/<store>/...

file_contexts				contexts/files/file_contexts
file_contexts.homedirs			contexts/files/file_contexts.homedirs
file_contexts.local			contexts/files/file_contexts.local
netfilter_contexts			contexts/netfilter_contexts
policy.kern				policy/policy.<policyversion>
seusers.final				seusers

The layout of these files in /var/lib/selinux/tmp/<store> is designed to
mirror their locations in /etc/selinux/<store>. This should help clarify
the relationship between these final files and the files installed in
etc.

One consequence of this move is that reverting to the previous policy
version requires a policy rebuild. Currently you can revert without
rebuilding.

[1] CIL RFC: http://marc.info/?l=selinux&m=124759244409438&w=2
---
 libsemanage/src/boolean_internal.h    |    4 +-
 libsemanage/src/booleans_file.c       |    7 +-
 libsemanage/src/booleans_policydb.c   |    6 +-
 libsemanage/src/database_file.c       |   45 +---
 libsemanage/src/database_file.h       |    3 +-
 libsemanage/src/database_policydb.c   |   37 +--
 libsemanage/src/database_policydb.h   |    3 +-
 libsemanage/src/direct_api.c          |   76 ++++-
 libsemanage/src/fcontext_internal.h   |    3 +-
 libsemanage/src/fcontexts_file.c      |    7 +-
 libsemanage/src/genhomedircon.c       |    3 +-
 libsemanage/src/iface_internal.h      |    4 +-
 libsemanage/src/interfaces_file.c     |    7 +-
 libsemanage/src/interfaces_policydb.c |    6 +-
 libsemanage/src/node_internal.h       |    4 +-
 libsemanage/src/nodes_file.c          |    7 +-
 libsemanage/src/nodes_policydb.c      |    6 +-
 libsemanage/src/port_internal.h       |    4 +-
 libsemanage/src/ports_file.c          |    7 +-
 libsemanage/src/ports_policydb.c      |    6 +-
 libsemanage/src/semanage_store.c      |  517 +++++++++++++++++++++++++--------
 libsemanage/src/semanage_store.h      |   31 ++-
 libsemanage/src/seuser_internal.h     |    4 +-
 libsemanage/src/seusers_file.c        |    7 +-
 libsemanage/src/user_internal.h       |    6 +-
 libsemanage/src/users_base_file.c     |    7 +-
 libsemanage/src/users_base_policydb.c |    6 +-
 libsemanage/src/users_extra_file.c    |    7 +-
 28 files changed, 585 insertions(+), 245 deletions(-)

diff --git a/libsemanage/src/boolean_internal.h b/libsemanage/src/boolean_internal.h
index 66e7f35..ad12b82 100644
--- a/libsemanage/src/boolean_internal.h
+++ b/libsemanage/src/boolean_internal.h
@@ -25,7 +25,9 @@ hidden_proto(semanage_bool_clone)
 extern record_table_t SEMANAGE_BOOL_RTABLE;
 
 extern int bool_file_dbase_init(semanage_handle_t * handle,
-				const char *fname, dbase_config_t * dconfig);
+				const char *path_ro,
+				const char *path_rw,
+				dbase_config_t * dconfig);
 
 extern void bool_file_dbase_release(dbase_config_t * dconfig);
 
diff --git a/libsemanage/src/booleans_file.c b/libsemanage/src/booleans_file.c
index af5b1b3..f79d0b4 100644
--- a/libsemanage/src/booleans_file.c
+++ b/libsemanage/src/booleans_file.c
@@ -107,11 +107,14 @@ record_file_table_t SEMANAGE_BOOL_FILE_RTABLE = {
 };
 
 int bool_file_dbase_init(semanage_handle_t * handle,
-			 const char *fname, dbase_config_t * dconfig)
+			 const char *path_ro,
+			 const char *path_rw,
+			 dbase_config_t * dconfig)
 {
 
 	if (dbase_file_init(handle,
-			    fname,
+			    path_ro,
+			    path_rw,
 			    &SEMANAGE_BOOL_RTABLE,
 			    &SEMANAGE_BOOL_FILE_RTABLE, &dconfig->dbase) < 0)
 		return STATUS_ERR;
diff --git a/libsemanage/src/booleans_policydb.c b/libsemanage/src/booleans_policydb.c
index 925940c..74af2a3 100644
--- a/libsemanage/src/booleans_policydb.c
+++ b/libsemanage/src/booleans_policydb.c
@@ -33,6 +33,7 @@ typedef struct dbase_policydb dbase_t;
 #include "boolean_internal.h"
 #include "debug.h"
 #include "database_policydb.h"
+#include "semanage_store.h"
 
 /* BOOLEAN RECRORD (SEPOL): POLICYDB extension: method table */
 record_policydb_table_t SEMANAGE_BOOL_POLICYDB_RTABLE = {
@@ -54,7 +55,10 @@ int bool_policydb_dbase_init(semanage_handle_t * handle,
 {
 
 	if (dbase_policydb_init(handle,
-				"policy.kern",
+				semanage_final_path(SEMANAGE_FINAL_SELINUX,
+						    SEMANAGE_KERNEL),
+				semanage_final_path(SEMANAGE_FINAL_TMP,
+						    SEMANAGE_KERNEL),
 				&SEMANAGE_BOOL_RTABLE,
 				&SEMANAGE_BOOL_POLICYDB_RTABLE,
 				&dconfig->dbase) < 0)
diff --git a/libsemanage/src/database_file.c b/libsemanage/src/database_file.c
index 2b53521..a21b3ee 100644
--- a/libsemanage/src/database_file.c
+++ b/libsemanage/src/database_file.c
@@ -30,34 +30,13 @@ struct dbase_file {
 	 * a linked list to store the records */
 	dbase_llist_t llist;
 
-	/* Backing file suffix */
-	const char *suffix;
+	/* Backing path for read-only[0] and transaction[1] */
+	const char *path[2];
 
 	/* FILE extension */
 	record_file_table_t *rftable;
 };
 
-static int construct_filename(semanage_handle_t * handle,
-			      dbase_file_t * dbase, char **filename)
-{
-
-	const char *path = (handle->is_in_transaction) ?
-	    semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL) :
-	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
-
-	size_t fname_length = strlen(path) + strlen(dbase->suffix) + 2;
-
-	char *fname = malloc(fname_length);
-	if (!fname) {
-		ERR(handle, "out of memory, could not construct filename");
-		return STATUS_ERR;
-	}
-	snprintf(fname, fname_length, "%s/%s", path, dbase->suffix);
-
-	*filename = fname;
-	return STATUS_SUCCESS;
-}
-
 static int dbase_file_cache(semanage_handle_t * handle, dbase_file_t * dbase)
 {
 
@@ -68,7 +47,7 @@ static int dbase_file_cache(semanage_handle_t * handle, dbase_file_t * dbase)
 	int pstatus = STATUS_SUCCESS;
 
 	parse_info_t *parse_info = NULL;
-	char *fname = NULL;
+	const char *fname = NULL;
 
 	/* Already cached */
 	if (!dbase_llist_needs_resync(handle, &dbase->llist))
@@ -79,8 +58,7 @@ static int dbase_file_cache(semanage_handle_t * handle, dbase_file_t * dbase)
 	if (dbase_llist_set_serial(handle, &dbase->llist) < 0)
 		goto err;
 
-	if (construct_filename(handle, dbase, &fname) < 0)
-		goto err;
+	fname = dbase->path[handle->is_in_transaction];
 
 	if (parse_init(handle, fname, NULL, &parse_info) < 0)
 		goto err;
@@ -119,7 +97,6 @@ static int dbase_file_cache(semanage_handle_t * handle, dbase_file_t * dbase)
 	rtable->free(process_record);
 	parse_close(parse_info);
 	parse_release(parse_info);
-	free(fname);
 	return STATUS_SUCCESS;
 
       err:
@@ -130,7 +107,6 @@ static int dbase_file_cache(semanage_handle_t * handle, dbase_file_t * dbase)
 		parse_release(parse_info);
 	}
 	dbase_llist_drop_cache(&dbase->llist);
-	free(fname);
 	return STATUS_ERR;
 }
 
@@ -141,14 +117,13 @@ static int dbase_file_flush(semanage_handle_t * handle, dbase_file_t * dbase)
 	record_file_table_t *rftable = dbase->rftable;
 
 	cache_entry_t *ptr;
-	char *fname = NULL;
+	const char *fname = NULL;
 	FILE *str = NULL;
 
 	if (!dbase_llist_is_modified(&dbase->llist))
 		return STATUS_SUCCESS;
 
-	if (construct_filename(handle, dbase, &fname) < 0)
-		goto err;
+	fname = dbase->path[handle->is_in_transaction];
 
 	str = fopen(fname, "w");
 	if (!str) {
@@ -172,7 +147,6 @@ static int dbase_file_flush(semanage_handle_t * handle, dbase_file_t * dbase)
 
 	dbase_llist_set_modified(&dbase->llist, 0);
 	fclose(str);
-	free(fname);
 	return STATUS_SUCCESS;
 
       err:
@@ -180,12 +154,12 @@ static int dbase_file_flush(semanage_handle_t * handle, dbase_file_t * dbase)
 		fclose(str);
 
 	ERR(handle, "could not flush database to file");
-	free(fname);
 	return STATUS_ERR;
 }
 
 int dbase_file_init(semanage_handle_t * handle,
-		    const char *suffix,
+		    const char *path_ro,
+		    const char *path_rw,
 		    record_table_t * rtable,
 		    record_file_table_t * rftable, dbase_file_t ** dbase)
 {
@@ -195,7 +169,8 @@ int dbase_file_init(semanage_handle_t * handle,
 	if (!tmp_dbase)
 		goto omem;
 
-	tmp_dbase->suffix = suffix;
+	tmp_dbase->path[0] = path_ro;
+	tmp_dbase->path[1] = path_rw;
 	tmp_dbase->rftable = rftable;
 	dbase_llist_init(&tmp_dbase->llist, rtable, &SEMANAGE_FILE_DTABLE);
 
diff --git a/libsemanage/src/database_file.h b/libsemanage/src/database_file.h
index 717e349..dbd11bc 100644
--- a/libsemanage/src/database_file.h
+++ b/libsemanage/src/database_file.h
@@ -28,7 +28,8 @@ typedef struct record_file_table {
 
 /* FILE - initialization */
 extern int dbase_file_init(semanage_handle_t * handle,
-			   const char *suffix,
+			   const char *path_ro,
+			   const char *path_rw,
 			   record_table_t * rtable,
 			   record_file_table_t * rftable,
 			   dbase_file_t ** dbase);
diff --git a/libsemanage/src/database_policydb.c b/libsemanage/src/database_policydb.c
index 839dcbe..fb2fe48 100644
--- a/libsemanage/src/database_policydb.c
+++ b/libsemanage/src/database_policydb.c
@@ -25,8 +25,8 @@ typedef struct dbase_policydb dbase_t;
 /* POLICYDB dbase */
 struct dbase_policydb {
 
-	/* Backing file suffix */
-	const char *suffix;
+        /* Backing path for read-only[0] and transaction[1] */
+        const char *path[2];
 
 	/* Base record table */
 	record_table_t *rtable;
@@ -86,26 +86,6 @@ static int dbase_policydb_needs_resync(semanage_handle_t * handle,
 	return 0;
 }
 
-static int construct_filename(semanage_handle_t * handle,
-			      dbase_policydb_t * dbase, char **filename)
-{
-
-	const char *path = (handle->is_in_transaction) ?
-	    semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL) :
-	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
-	size_t fname_length = strlen(path) + strlen(dbase->suffix) + 2;
-
-	char *fname = malloc(fname_length);
-	if (!fname) {
-		ERR(handle, "out of memory, could not construct database name");
-		return STATUS_ERR;
-	}
-	snprintf(fname, fname_length, "%s/%s", path, dbase->suffix);
-
-	*filename = fname;
-	return STATUS_SUCCESS;
-}
-
 static int dbase_policydb_cache(semanage_handle_t * handle,
 				dbase_policydb_t * dbase)
 {
@@ -113,7 +93,7 @@ static int dbase_policydb_cache(semanage_handle_t * handle,
 	FILE *fp = NULL;
 	sepol_policydb_t *policydb = NULL;
 	sepol_policy_file_t *pf = NULL;
-	char *fname = NULL;
+	const char *fname = NULL;
 
 	/* Check if cache is needed */
 	if (dbase->attached)
@@ -122,8 +102,7 @@ static int dbase_policydb_cache(semanage_handle_t * handle,
 	if (!dbase_policydb_needs_resync(handle, dbase))
 		return STATUS_SUCCESS;
 
-	if (construct_filename(handle, dbase, &fname) < 0)
-		goto err;
+	fname = dbase->path[handle->is_in_transaction];
 
 	if (sepol_policydb_create(&policydb) < 0) {
 		ERR(handle, "could not create policydb object");
@@ -164,7 +143,6 @@ static int dbase_policydb_cache(semanage_handle_t * handle,
 
 	/* Update the database policydb */
 	dbase->policydb = policydb;
-	free(fname);
 	return STATUS_SUCCESS;
 
       err:
@@ -173,7 +151,6 @@ static int dbase_policydb_cache(semanage_handle_t * handle,
 		fclose(fp);
 	sepol_policydb_free(policydb);
 	sepol_policy_file_free(pf);
-	free(fname);
 	return STATUS_ERR;
 }
 
@@ -199,7 +176,8 @@ static int dbase_policydb_is_modified(dbase_policydb_t * dbase)
 }
 
 int dbase_policydb_init(semanage_handle_t * handle,
-			const char *suffix,
+			const char *path_ro,
+			const char *path_rw,
 			record_table_t * rtable,
 			record_policydb_table_t * rptable,
 			dbase_policydb_t ** dbase)
@@ -211,7 +189,8 @@ int dbase_policydb_init(semanage_handle_t * handle,
 	if (!tmp_dbase)
 		goto omem;
 
-	tmp_dbase->suffix = suffix;
+	tmp_dbase->path[0] = path_ro;
+	tmp_dbase->path[1] = path_rw;
 	tmp_dbase->rtable = rtable;
 	tmp_dbase->rptable = rptable;
 	tmp_dbase->policydb = NULL;
diff --git a/libsemanage/src/database_policydb.h b/libsemanage/src/database_policydb.h
index 88cde5e..f782e0d 100644
--- a/libsemanage/src/database_policydb.h
+++ b/libsemanage/src/database_policydb.h
@@ -86,7 +86,8 @@ typedef struct record_policydb_table {
 
 /* Initialize database */
 extern int dbase_policydb_init(semanage_handle_t * handle,
-			       const char *suffix,
+			       const char *path_ro,
+			       const char *path_rw,
 			       record_table_t * rtable,
 			       record_policydb_table_t * rptable,
 			       dbase_policydb_t ** dbase);
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 5fb4523..e438b87 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -126,13 +126,18 @@ int semanage_direct_connect(semanage_handle_t * sh)
 
 	/* Object databases: local modifications */
 	if (user_base_file_dbase_init(sh,
-				      semanage_fname(SEMANAGE_USERS_BASE_LOCAL),
+				      semanage_path(SEMANAGE_ACTIVE,
+						    SEMANAGE_USERS_BASE_LOCAL),
+				      semanage_path(SEMANAGE_TMP,
+						    SEMANAGE_USERS_BASE_LOCAL),
 				      semanage_user_base_dbase_local(sh)) < 0)
 		goto err;
 
 	if (user_extra_file_dbase_init(sh,
-				       semanage_fname
-				       (SEMANAGE_USERS_EXTRA_LOCAL),
+				       semanage_path(SEMANAGE_ACTIVE,
+						     SEMANAGE_USERS_EXTRA_LOCAL),
+				       semanage_path(SEMANAGE_TMP,
+						     SEMANAGE_USERS_EXTRA_LOCAL),
 				       semanage_user_extra_dbase_local(sh)) < 0)
 		goto err;
 
@@ -143,32 +148,50 @@ int semanage_direct_connect(semanage_handle_t * sh)
 		goto err;
 
 	if (port_file_dbase_init(sh,
-				 semanage_fname(SEMANAGE_PORTS_LOCAL),
+				 semanage_path(SEMANAGE_ACTIVE,
+					       SEMANAGE_PORTS_LOCAL),
+				 semanage_path(SEMANAGE_TMP,
+					       SEMANAGE_PORTS_LOCAL),
 				 semanage_port_dbase_local(sh)) < 0)
 		goto err;
 
 	if (iface_file_dbase_init(sh,
-				  semanage_fname(SEMANAGE_INTERFACES_LOCAL),
+				  semanage_path(SEMANAGE_ACTIVE,
+						SEMANAGE_INTERFACES_LOCAL),
+				  semanage_path(SEMANAGE_TMP,
+						SEMANAGE_INTERFACES_LOCAL),
 				  semanage_iface_dbase_local(sh)) < 0)
 		goto err;
 
 	if (bool_file_dbase_init(sh,
-				 semanage_fname(SEMANAGE_BOOLEANS_LOCAL),
+				 semanage_path(SEMANAGE_ACTIVE,
+					       SEMANAGE_BOOLEANS_LOCAL),
+				 semanage_path(SEMANAGE_TMP,
+					       SEMANAGE_BOOLEANS_LOCAL),
 				 semanage_bool_dbase_local(sh)) < 0)
 		goto err;
 
 	if (fcontext_file_dbase_init(sh,
-				     semanage_fname(SEMANAGE_FC_LOCAL),
+				     semanage_final_path(SEMANAGE_FINAL_SELINUX,
+							 SEMANAGE_FC_LOCAL),
+				     semanage_final_path(SEMANAGE_FINAL_TMP,
+							 SEMANAGE_FC_LOCAL),
 				     semanage_fcontext_dbase_local(sh)) < 0)
 		goto err;
 
 	if (seuser_file_dbase_init(sh,
-				   semanage_fname(SEMANAGE_SEUSERS_LOCAL),
+				   semanage_path(SEMANAGE_ACTIVE,
+						 SEMANAGE_SEUSERS_LOCAL),
+				   semanage_path(SEMANAGE_TMP,
+						 SEMANAGE_SEUSERS_LOCAL),
 				   semanage_seuser_dbase_local(sh)) < 0)
 		goto err;
 
 	if (node_file_dbase_init(sh,
-				 semanage_fname(SEMANAGE_NODES_LOCAL),
+				 semanage_path(SEMANAGE_ACTIVE,
+					       SEMANAGE_NODES_LOCAL),
+				 semanage_path(SEMANAGE_TMP,
+					       SEMANAGE_NODES_LOCAL),
 				 semanage_node_dbase_local(sh)) < 0)
 		goto err;
 
@@ -179,7 +202,10 @@ int semanage_direct_connect(semanage_handle_t * sh)
 		goto err;
 
 	if (user_extra_file_dbase_init(sh,
-				       semanage_fname(SEMANAGE_USERS_EXTRA),
+				       semanage_path(SEMANAGE_ACTIVE,
+						     SEMANAGE_USERS_EXTRA),
+				       semanage_path(SEMANAGE_TMP,
+						     SEMANAGE_USERS_EXTRA),
 				       semanage_user_extra_dbase_policy(sh)) <
 	    0)
 		goto err;
@@ -200,12 +226,18 @@ int semanage_direct_connect(semanage_handle_t * sh)
 		goto err;
 
 	if (fcontext_file_dbase_init(sh,
-				     semanage_fname(SEMANAGE_FC),
+				     semanage_final_path(SEMANAGE_FINAL_SELINUX,
+							 SEMANAGE_FC),
+				     semanage_final_path(SEMANAGE_FINAL_TMP,
+							 SEMANAGE_FC),
 				     semanage_fcontext_dbase_policy(sh)) < 0)
 		goto err;
 
 	if (seuser_file_dbase_init(sh,
-				   semanage_fname(SEMANAGE_SEUSERS),
+				   semanage_final_path(SEMANAGE_FINAL_SELINUX,
+						       SEMANAGE_SEUSERS),
+				   semanage_final_path(SEMANAGE_FINAL_TMP,
+						       SEMANAGE_SEUSERS),
 				   semanage_seuser_dbase_policy(sh)) < 0)
 		goto err;
 
@@ -247,6 +279,14 @@ static int semanage_direct_disconnect(semanage_handle_t * sh)
 			    semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL));
 			return -1;
 		}
+		if (semanage_remove_directory
+		    (semanage_final_path(SEMANAGE_FINAL_TMP,
+					 SEMANAGE_FINAL_TOPLEVEL)) < 0) {
+			ERR(sh, "Could not cleanly remove tmp %s.",
+			    semanage_final_path(SEMANAGE_FINAL_TMP,
+						SEMANAGE_FINAL_TOPLEVEL));
+			return -1;
+		}
 		semanage_release_trans_lock(sh);
 	}
 
@@ -290,6 +330,9 @@ static int semanage_direct_begintrans(semanage_handle_t * sh)
 	if ((semanage_make_sandbox(sh)) < 0) {
 		return -1;
 	}
+	if ((semanage_make_final(sh)) < 0) {
+		return -1;
+	}
 	return 0;
 }
 
@@ -639,7 +682,8 @@ static int semanage_direct_update_seuser(semanage_handle_t * sh, sepol_module_pa
 	dbase_config_t *pseusers = semanage_seuser_dbase_policy(sh);
 
 	if (sepol_module_package_get_seusers_len(base)) {
-		ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS);
+		ofilename = semanage_final_path(SEMANAGE_FINAL_TMP,
+						SEMANAGE_SEUSERS);
 		if (ofilename == NULL) {
 			return -1;
 		}
@@ -840,7 +884,8 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		/* Write the contexts to a single file.  The buffer returned by
 		 * the sort function has a trailing \0 character, which we do
 		 * NOT want to write out to disk, so we pass sorted_fc_buffer_len-1. */
-		ofilename = semanage_path(SEMANAGE_TMP, SEMANAGE_NC);
+		ofilename = semanage_final_path(SEMANAGE_FINAL_TMP,
+						SEMANAGE_NC);
 		retval = write_file
 		    (sh, ofilename, sorted_nc_buffer, sorted_nc_buffer_len - 1);
 
@@ -995,6 +1040,9 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	   sandbox if it is still there */
 	semanage_remove_directory(semanage_path
 				  (SEMANAGE_TMP, SEMANAGE_TOPLEVEL));
+	semanage_remove_directory(semanage_final_path
+				  (SEMANAGE_FINAL_TMP,
+				   SEMANAGE_FINAL_TOPLEVEL));
 	return retval;
 }
 
diff --git a/libsemanage/src/fcontext_internal.h b/libsemanage/src/fcontext_internal.h
index 4f45fa6..a6008ea 100644
--- a/libsemanage/src/fcontext_internal.h
+++ b/libsemanage/src/fcontext_internal.h
@@ -30,7 +30,8 @@ hidden_proto(semanage_fcontext_key_create)
 extern record_table_t SEMANAGE_FCONTEXT_RTABLE;
 
 extern int fcontext_file_dbase_init(semanage_handle_t * handle,
-				    const char *fname,
+				    const char *path_ro,
+				    const char *path_rw,
 				    dbase_config_t * dconfig);
 
 extern void fcontext_file_dbase_release(dbase_config_t * dconfig);
diff --git a/libsemanage/src/fcontexts_file.c b/libsemanage/src/fcontexts_file.c
index b1a2f82..1e59651 100644
--- a/libsemanage/src/fcontexts_file.c
+++ b/libsemanage/src/fcontexts_file.c
@@ -165,11 +165,14 @@ record_file_table_t SEMANAGE_FCONTEXT_FILE_RTABLE = {
 };
 
 int fcontext_file_dbase_init(semanage_handle_t * handle,
-			     const char *fname, dbase_config_t * dconfig)
+			     const char *path_ro,
+			     const char *path_rw,
+			     dbase_config_t * dconfig)
 {
 
 	if (dbase_file_init(handle,
-			    fname,
+			    path_ro,
+			    path_rw,
 			    &SEMANAGE_FCONTEXT_RTABLE,
 			    &SEMANAGE_FCONTEXT_FILE_RTABLE,
 			    &dconfig->dbase) < 0)
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 8a7d5e2..94ddfbe 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -964,7 +964,8 @@ int semanage_genhomedircon(semanage_handle_t * sh,
 
 	s.homedir_template_path =
 	    semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL);
-	s.fcfilepath = semanage_path(SEMANAGE_TMP, SEMANAGE_FC_HOMEDIRS);
+	s.fcfilepath = semanage_final_path(SEMANAGE_FINAL_TMP,
+					   SEMANAGE_FC_HOMEDIRS);
 
 	s.fallback_user = strdup(FALLBACK_USER);
 	s.fallback_user_prefix = strdup(FALLBACK_USER_PREFIX);
diff --git a/libsemanage/src/iface_internal.h b/libsemanage/src/iface_internal.h
index 7fe80fd..1f67836 100644
--- a/libsemanage/src/iface_internal.h
+++ b/libsemanage/src/iface_internal.h
@@ -31,7 +31,9 @@ extern int iface_policydb_dbase_init(semanage_handle_t * handle,
 extern void iface_policydb_dbase_release(dbase_config_t * dconfig);
 
 extern int iface_file_dbase_init(semanage_handle_t * handle,
-				 const char *fname, dbase_config_t * dconfig);
+				 const char *path_ro,
+				 const char *path_rw,
+				 dbase_config_t * dconfig);
 
 extern void iface_file_dbase_release(dbase_config_t * dconfig);
 
diff --git a/libsemanage/src/interfaces_file.c b/libsemanage/src/interfaces_file.c
index 78871a2..1478af9 100644
--- a/libsemanage/src/interfaces_file.c
+++ b/libsemanage/src/interfaces_file.c
@@ -152,11 +152,14 @@ record_file_table_t SEMANAGE_IFACE_FILE_RTABLE = {
 };
 
 int iface_file_dbase_init(semanage_handle_t * handle,
-			  const char *fname, dbase_config_t * dconfig)
+			  const char *path_ro,
+			  const char *path_rw,
+			  dbase_config_t * dconfig)
 {
 
 	if (dbase_file_init(handle,
-			    fname,
+			    path_ro,
+			    path_rw,
 			    &SEMANAGE_IFACE_RTABLE,
 			    &SEMANAGE_IFACE_FILE_RTABLE, &dconfig->dbase) < 0)
 		return STATUS_ERR;
diff --git a/libsemanage/src/interfaces_policydb.c b/libsemanage/src/interfaces_policydb.c
index b67963d..6a42eed 100644
--- a/libsemanage/src/interfaces_policydb.c
+++ b/libsemanage/src/interfaces_policydb.c
@@ -33,6 +33,7 @@ typedef struct dbase_policydb dbase_t;
 #include "iface_internal.h"
 #include "debug.h"
 #include "database_policydb.h"
+#include "semanage_store.h"
 
 /* INTERFACE RECRORD (SEPOL): POLICYDB extension: method table */
 record_policydb_table_t SEMANAGE_IFACE_POLICYDB_RTABLE = {
@@ -50,7 +51,10 @@ int iface_policydb_dbase_init(semanage_handle_t * handle,
 {
 
 	if (dbase_policydb_init(handle,
-				"policy.kern",
+				semanage_final_path(SEMANAGE_FINAL_SELINUX,
+						    SEMANAGE_KERNEL),
+				semanage_final_path(SEMANAGE_FINAL_TMP,
+						    SEMANAGE_KERNEL),
 				&SEMANAGE_IFACE_RTABLE,
 				&SEMANAGE_IFACE_POLICYDB_RTABLE,
 				&dconfig->dbase) < 0)
diff --git a/libsemanage/src/node_internal.h b/libsemanage/src/node_internal.h
index 7653af8..5817560 100644
--- a/libsemanage/src/node_internal.h
+++ b/libsemanage/src/node_internal.h
@@ -34,7 +34,9 @@ hidden_proto(semanage_node_create)
 extern record_table_t SEMANAGE_NODE_RTABLE;
 
 extern int node_file_dbase_init(semanage_handle_t * handle,
-				const char *fname, dbase_config_t * dconfig);
+				const char *path_ro,
+				const char *path_rw,
+				dbase_config_t * dconfig);
 
 extern void node_file_dbase_release(dbase_config_t * dconfig);
 
diff --git a/libsemanage/src/nodes_file.c b/libsemanage/src/nodes_file.c
index b80de2d..f6c8895 100644
--- a/libsemanage/src/nodes_file.c
+++ b/libsemanage/src/nodes_file.c
@@ -161,11 +161,14 @@ record_file_table_t SEMANAGE_NODE_FILE_RTABLE = {
 };
 
 int node_file_dbase_init(semanage_handle_t * handle,
-			 const char *fname, dbase_config_t * dconfig)
+			 const char *path_ro,
+			 const char *path_rw,
+			 dbase_config_t * dconfig)
 {
 
 	if (dbase_file_init(handle,
-			    fname,
+			    path_ro,
+			    path_rw,
 			    &SEMANAGE_NODE_RTABLE,
 			    &SEMANAGE_NODE_FILE_RTABLE, &dconfig->dbase) < 0)
 		return STATUS_ERR;
diff --git a/libsemanage/src/nodes_policydb.c b/libsemanage/src/nodes_policydb.c
index e732e0e..56012fb 100644
--- a/libsemanage/src/nodes_policydb.c
+++ b/libsemanage/src/nodes_policydb.c
@@ -32,6 +32,7 @@ typedef struct dbase_policydb dbase_t;
 #include "node_internal.h"
 #include "debug.h"
 #include "database_policydb.h"
+#include "semanage_store.h"
 
 /* NODE RECORD (SEPOL): POLICYDB extension : method table */
 record_policydb_table_t SEMANAGE_NODE_POLICYDB_RTABLE = {
@@ -49,7 +50,10 @@ int node_policydb_dbase_init(semanage_handle_t * handle,
 {
 
 	if (dbase_policydb_init(handle,
-				"policy.kern",
+				semanage_final_path(SEMANAGE_FINAL_SELINUX,
+						    SEMANAGE_KERNEL),
+				semanage_final_path(SEMANAGE_FINAL_TMP,
+						    SEMANAGE_KERNEL),
 				&SEMANAGE_NODE_RTABLE,
 				&SEMANAGE_NODE_POLICYDB_RTABLE,
 				&dconfig->dbase) < 0)
diff --git a/libsemanage/src/port_internal.h b/libsemanage/src/port_internal.h
index b3d36ce..ebd2bc8 100644
--- a/libsemanage/src/port_internal.h
+++ b/libsemanage/src/port_internal.h
@@ -30,7 +30,9 @@ hidden_proto(semanage_port_create)
 extern record_table_t SEMANAGE_PORT_RTABLE;
 
 extern int port_file_dbase_init(semanage_handle_t * handle,
-				const char *fname, dbase_config_t * dconfig);
+				const char *path_ro,
+				const char *path_rw,
+				dbase_config_t * dconfig);
 
 extern void port_file_dbase_release(dbase_config_t * dconfig);
 
diff --git a/libsemanage/src/ports_file.c b/libsemanage/src/ports_file.c
index 41d2f60..46ee2f0 100644
--- a/libsemanage/src/ports_file.c
+++ b/libsemanage/src/ports_file.c
@@ -164,11 +164,14 @@ record_file_table_t SEMANAGE_PORT_FILE_RTABLE = {
 };
 
 int port_file_dbase_init(semanage_handle_t * handle,
-			 const char *fname, dbase_config_t * dconfig)
+			 const char *path_ro,
+			 const char *path_rw,
+			 dbase_config_t * dconfig)
 {
 
 	if (dbase_file_init(handle,
-			    fname,
+			    path_ro,
+			    path_rw,
 			    &SEMANAGE_PORT_RTABLE,
 			    &SEMANAGE_PORT_FILE_RTABLE, &dconfig->dbase) < 0)
 		return STATUS_ERR;
diff --git a/libsemanage/src/ports_policydb.c b/libsemanage/src/ports_policydb.c
index 429ed72..b9600f0 100644
--- a/libsemanage/src/ports_policydb.c
+++ b/libsemanage/src/ports_policydb.c
@@ -32,6 +32,7 @@ typedef struct dbase_policydb dbase_t;
 #include "port_internal.h"
 #include "debug.h"
 #include "database_policydb.h"
+#include "semanage_store.h"
 
 /* PORT RECORD (SEPOL): POLICYDB extension : method table */
 record_policydb_table_t SEMANAGE_PORT_POLICYDB_RTABLE = {
@@ -49,7 +50,10 @@ int port_policydb_dbase_init(semanage_handle_t * handle,
 {
 
 	if (dbase_policydb_init(handle,
-				"policy.kern",
+				semanage_final_path(SEMANAGE_FINAL_SELINUX,
+						    SEMANAGE_KERNEL),
+				semanage_final_path(SEMANAGE_FINAL_TMP,
+						    SEMANAGE_KERNEL),
 				&SEMANAGE_PORT_RTABLE,
 				&SEMANAGE_PORT_POLICYDB_RTABLE,
 				&dconfig->dbase) < 0)
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 049818a..62779b3 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -94,10 +94,8 @@ static const char *semanage_store_paths[SEMANAGE_NUM_STORES] = {
 static const char *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
 	"",
 	"/modules",
-	"/policy.kern",
 	"/base.pp",
 	"/base.linked",
-	"/file_contexts",
 	"/homedir_template",
 	"/file_contexts.template",
 	"/commit_num",
@@ -105,17 +103,23 @@ static const char *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
 	"/interfaces.local",
 	"/nodes.local",
 	"/booleans.local",
-	"/file_contexts.local",
-	"/seusers",
+	"/seusers.local",
 	"/users.local",
 	"/users_extra.local",
-	"/seusers.final",
 	"/users_extra",
-	"/netfilter_contexts",
-	"/file_contexts.homedirs",
 	"/disable_dontaudit",
+	"/modules/disabled",
 };
 
+static char const * const semanage_final_prefix[SEMANAGE_FINAL_NUM] = {
+	"/tmp",
+	"",
+};
+
+static char *semanage_final[SEMANAGE_FINAL_NUM] = { NULL };
+static char *semanage_final_suffix[SEMANAGE_FINAL_PATH_NUM] = { NULL };
+static char *semanage_final_paths[SEMANAGE_FINAL_NUM][SEMANAGE_FINAL_PATH_NUM] = {{ NULL }};
+
 /* A node used in a linked list of file contexts; used for sorting.
  */
 typedef struct semanage_file_context_node {
@@ -208,6 +212,184 @@ static int semanage_init_store_paths(const char *root)
 	return 0;
 }
 
+static int semanage_init_final(semanage_handle_t *sh, const char *prefix)
+{
+	assert(sh);
+	assert(prefix);
+
+	int status = 0;
+	size_t len;
+	const char *store_path = sh->conf->store_path;
+	size_t store_len = strlen(store_path);
+
+	/* SEMANAGE_FINAL_TMP */
+	len = strlen(prefix) +
+	      strlen(semanage_final_prefix[SEMANAGE_FINAL_TMP]) +
+	      store_len;
+	semanage_final[SEMANAGE_FINAL_TMP] = malloc(len + 2);
+	if (semanage_final[SEMANAGE_FINAL_TMP] == NULL) {
+		status = -1;
+		goto cleanup;
+	}
+
+	sprintf(semanage_final[SEMANAGE_FINAL_TMP],
+		"%s%s/%s",
+		prefix,
+		semanage_final_prefix[SEMANAGE_FINAL_TMP],
+		store_path);
+
+	/* SEMANAGE_FINAL_SELINUX */
+	const char *selinux_root = selinux_path();
+	len = strlen(selinux_root) +
+	      strlen(semanage_final_prefix[SEMANAGE_FINAL_SELINUX]) +
+	      store_len;
+	semanage_final[SEMANAGE_FINAL_SELINUX] = malloc(len + 1);
+	if (semanage_final[SEMANAGE_FINAL_SELINUX] == NULL) {
+		status = -1;
+		goto cleanup;
+	}
+
+	sprintf(semanage_final[SEMANAGE_FINAL_SELINUX],
+		"%s%s%s",
+		selinux_root,
+		semanage_final_prefix[SEMANAGE_FINAL_SELINUX],
+		store_path);
+
+cleanup:
+	if (status != 0) {
+		int i;
+		for (i = 0; i < SEMANAGE_FINAL_NUM; i++) {
+			free(semanage_final[i]);
+			semanage_final[i] = NULL;
+		}
+	}
+
+	return status;
+}
+
+static int semanage_init_final_suffix(semanage_handle_t *sh)
+{
+	int ret = 0;
+	int status = 0;
+	char path[PATH_MAX];
+	size_t offset = strlen(selinux_policy_root());
+
+	semanage_final_suffix[SEMANAGE_FINAL_TOPLEVEL] = strdup("");
+	if (semanage_final_suffix[SEMANAGE_FINAL_TOPLEVEL] == NULL) {
+		ERR(sh, "Unable to allocate space for policy top level path.");
+		status = -1;
+		goto cleanup;
+	}
+
+	semanage_final_suffix[SEMANAGE_FC] =
+		strdup(selinux_file_context_path() + offset);
+	if (semanage_final_suffix[SEMANAGE_FC] == NULL) {
+		ERR(sh, "Unable to allocate space for file context path.");
+		status = -1;
+		goto cleanup;
+	}
+
+	semanage_final_suffix[SEMANAGE_FC_HOMEDIRS] =
+		strdup(selinux_file_context_homedir_path() + offset);
+	if (semanage_final_suffix[SEMANAGE_FC_HOMEDIRS] == NULL) {
+		ERR(sh, "Unable to allocate space for file context home directory path.");
+		status = -1;
+		goto cleanup;
+	}
+
+	semanage_final_suffix[SEMANAGE_FC_LOCAL] =
+		strdup(selinux_file_context_local_path() + offset);
+	if (semanage_final_suffix[SEMANAGE_FC_LOCAL] == NULL) {
+		ERR(sh, "Unable to allocate space for local file context path.");
+		status = -1;
+		goto cleanup;
+	}
+
+	semanage_final_suffix[SEMANAGE_NC] =
+		strdup(selinux_netfilter_context_path() + offset);
+	if (semanage_final_suffix[SEMANAGE_NC] == NULL) {
+		ERR(sh, "Unable to allocate space for netfilter context path.");
+		status = -1;
+		goto cleanup;
+	}
+
+	semanage_final_suffix[SEMANAGE_SEUSERS] =
+		strdup(selinux_usersconf_path() + offset);
+	if (semanage_final_suffix[SEMANAGE_SEUSERS] == NULL) {
+		ERR(sh, "Unable to allocate space for userconf path.");
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = snprintf(path,
+		       sizeof(path),
+		       "%s.%d",
+		       selinux_binary_policy_path() + offset,
+		       sh->conf->policyvers);
+	if (ret < 0 || ret >= (int)sizeof(path)) {
+		ERR(sh, "Unable to compose policy binary path.");
+		status = -1;
+		goto cleanup;
+	}
+
+	semanage_final_suffix[SEMANAGE_KERNEL] = strdup(path);
+	if (semanage_final_suffix[SEMANAGE_KERNEL] == NULL) {
+		ERR(sh, "Unable to allocate space for policy binary path.");
+		status = -1;
+		goto cleanup;
+	}
+
+cleanup:
+	if (status != 0) {
+		int i;
+		for (i = 0; i < SEMANAGE_FINAL_PATH_NUM; i++) {
+			free(semanage_final_suffix[i]);
+			semanage_final_suffix[i] = NULL;
+		}
+	}
+
+	return status;
+}
+
+/* Initialize final paths. */
+static int semanage_init_final_paths(semanage_handle_t *sh)
+{
+	int status = 0;
+	int i, j;
+	size_t len;
+
+	for (i = 0; i < SEMANAGE_FINAL_NUM; i++) {
+		for (j = 0; j < SEMANAGE_FINAL_PATH_NUM; j++) {
+			len = 	  strlen(semanage_final[i])
+				+ strlen(semanage_final_suffix[j]);
+
+			semanage_final_paths[i][j] = malloc(len + 1);
+			if (semanage_final_paths[i][j] == NULL) {
+				ERR(sh, "Unable to allocate space for policy final path.");
+				status = -1;
+				goto cleanup;
+			}
+
+			sprintf(semanage_final_paths[i][j],
+				"%s%s",
+				semanage_final[i],
+				semanage_final_suffix[j]);
+		}
+	}
+
+cleanup:
+	if (status != 0) {
+		for (i = 0; i < SEMANAGE_FINAL_NUM; i++) {
+			for (j = 0; j < SEMANAGE_FINAL_PATH_NUM; j++) {
+				free(semanage_final_paths[i][j]);
+				semanage_final_paths[i][j] = NULL;
+			}
+		}
+	}
+
+	return status;
+}
+
 /* THIS MUST BE THE FIRST FUNCTION CALLED IN THIS LIBRARY.  If the
  * library has nnot been initialized yet then call the functions that
  * initialize the path variables.  This function does nothing if it
@@ -238,6 +420,18 @@ int semanage_check_init(semanage_handle_t *sh, const char *prefix)
 		if (rc)
 			return rc;
 
+		rc = semanage_init_final(sh, prefix);
+		if (rc)
+			return rc;
+
+		rc = semanage_init_final_suffix(sh);
+		if (rc)
+			return rc;
+
+		rc = semanage_init_final_paths(sh);
+		if (rc)
+			return rc;
+
 		semanage_paths_initialized = 1;
 	}
 	return 0;
@@ -264,6 +458,21 @@ const char *semanage_path(enum semanage_store_defs store,
 	return semanage_paths[store][path_name];
 }
 
+/* Given a store location (tmp or selinux) and a definition
+ * number, return a fully-qualified path to that file or directory.
+ * The caller must not alter the string returned (and hence why this
+ * function return type is const).
+ *
+ * This function shall never return a NULL, assuming that
+ * semanage_check_init() was previously called.
+ */
+const char *semanage_final_path(enum semanage_final_defs store,
+				enum semanage_final_path_defs path_name)
+{
+	assert(semanage_final_paths[store][path_name]);
+	return semanage_final_paths[store][path_name];
+}
+
 /* Return the root of the semanage store. */
 const char *semanage_root_path(void)
 {
@@ -493,10 +702,20 @@ out:
 	return retval;
 }
 
+static int semanage_copy_dir_flags(const char *src, const char *dst, int flag);
+
 /* Copies all of the files from src to dst, recursing into
  * subdirectories.  Returns 0 on success, -1 on error. */
 static int semanage_copy_dir(const char *src, const char *dst)
 {
+	return semanage_copy_dir_flags(src, dst, 1);
+}
+
+/* Copies all of the dirs from src to dst, recursing into
+ * subdirectories. If flag == 1, then copy regular files as
+ * well. Returns 0 on success, -1 on error. */
+static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
+{
 	int i, len = 0, retval = -1;
 	struct stat sb;
 	struct dirent **names = NULL;
@@ -505,6 +724,13 @@ static int semanage_copy_dir(const char *src, const char *dst)
 	if ((len = scandir(src, &names, semanage_filename_select, NULL)) == -1) {
 		return -1;
 	}
+
+	if (stat(dst, &sb) != 0) {
+		if (mkdir(dst, S_IRWXU) != 0) {
+			goto cleanup;
+		}
+	}
+
 	for (i = 0; i < len; i++) {
 		snprintf(path, sizeof(path), "%s/%s", src, names[i]->d_name);
 		/* stat() to see if this entry is a file or not since
@@ -515,11 +741,11 @@ static int semanage_copy_dir(const char *src, const char *dst)
 		snprintf(path2, sizeof(path2), "%s/%s", dst, names[i]->d_name);
 		if (S_ISDIR(sb.st_mode)) {
 			if (mkdir(path2, 0700) == -1 ||
-			    semanage_copy_dir(path, path2) == -1) {
+			    semanage_copy_dir_flags(path, path2, flag) == -1) {
 				goto cleanup;
 			}
-		} else if (S_ISREG(sb.st_mode)) {
-			if (semanage_copy_file(path, path2, sb.st_mode) == -1) {
+		} else if (S_ISREG(sb.st_mode) && flag == 1) {
+			if (semanage_copy_file(path, path2, sb.st_mode) < 0) {
 				goto cleanup;
 			}
 		}
@@ -569,6 +795,34 @@ int semanage_remove_directory(const char *path)
 	return 0;
 }
 
+int semanage_mkdir(semanage_handle_t *sh, const char *path)
+{
+	int status = 0;
+	struct stat sb;
+
+	/* check if directory already exists */
+	if (stat(path, &sb) != 0) {
+		/* make the modules directory */
+		if (mkdir(path, S_IRWXU) != 0) {
+			ERR(sh, "Cannot make directory at %s", path);
+			status = -1;
+			goto cleanup;
+
+		}
+	}
+	else {
+		/* check that it really is a directory */
+		if (!S_ISDIR(sb.st_mode)) {
+			ERR(sh, "Directory path taken by non-directory file at %s.", path);
+			status = -1;
+			goto cleanup;
+		}
+	}
+
+cleanup:
+	return status;
+}
+
 /********************* sandbox management routines *********************/
 
 /* Creates a sandbox for a single client. Returns 0 if a
@@ -610,6 +864,69 @@ int semanage_make_sandbox(semanage_handle_t * sh)
 	return -1;
 }
 
+/* Create final temporary space. Returns -1 on error 0 on success. */
+int semanage_make_final(semanage_handle_t *sh)
+{
+	int status = 0;
+	int ret = 0;
+	char fn[PATH_MAX];
+
+	/* Create tmp dir if it does not exist. */
+	ret = snprintf(fn,
+		       sizeof(fn),
+		       "%s%s",
+		       semanage_root_path(),
+		       semanage_final_prefix[SEMANAGE_FINAL_TMP]);
+	if (ret < 0 || ret >= (int)sizeof(fn)) {
+		ERR(sh, "Unable to compose the final tmp path.");
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_mkdir(sh, fn);
+	if (ret != 0) {
+		ERR(sh, "Unable to create temporary directory for final files at %s", fn);
+		status = -1;
+		goto cleanup;
+	}
+
+	/* Delete store specific dir if it exists. */
+	ret = semanage_remove_directory(
+		semanage_final_path(SEMANAGE_FINAL_TMP,
+				    SEMANAGE_FINAL_TOPLEVEL));
+	if (ret < -1) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* Copy dir format of selinux store in. */
+	ret = semanage_copy_dir_flags(
+		semanage_final_path(SEMANAGE_FINAL_SELINUX,
+				    SEMANAGE_FINAL_TOPLEVEL),
+		semanage_final_path(SEMANAGE_FINAL_TMP,
+				    SEMANAGE_FINAL_TOPLEVEL),
+		0);
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* Copy in exported databases.
+	 * i = 1 to avoid copying the top level directory.
+	 */
+	int i;
+	for (i = 1; i < SEMANAGE_FINAL_PATH_NUM; i++) {
+		semanage_copy_file(
+			semanage_final_path(SEMANAGE_FINAL_SELINUX, i),
+			semanage_final_path(SEMANAGE_FINAL_TMP, i),
+			sh->conf->file_mode);
+		/* ignore errors, these files may not exist */
+	}
+
+cleanup:
+	return status;
+}
+
 /* Scans the modules directory for the current semanage handler.  This
  * might be the active directory or sandbox, depending upon if the
  * handler has a transaction lock.  Allocates and fills in *filenames
@@ -978,16 +1295,16 @@ int semanage_split_fc(semanage_handle_t * sh)
 		goto cleanup;
 	}
 
-	fc = open(semanage_path(SEMANAGE_TMP, SEMANAGE_FC),
+	fc = open(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC),
 		  O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
-	if (!fc) {
+	if (fc < 0) {
 		ERR(sh, "Could not open %s for writing.",
-		    semanage_path(SEMANAGE_TMP, SEMANAGE_FC));
+		    semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC));
 		goto cleanup;
 	}
 	hd = open(semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL),
 		  O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
-	if (!hd) {
+	if (hd < 0) {
 		ERR(sh, "Could not open %s for writing.",
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL));
 		goto cleanup;
@@ -1007,7 +1324,8 @@ int semanage_split_fc(semanage_handle_t * sh)
 		} else {
 			if (write(fc, buf, strlen(buf)) < 0) {
 				ERR(sh, "Write to %s failed.",
-				    semanage_path(SEMANAGE_TMP, SEMANAGE_FC));
+				    semanage_final_path(SEMANAGE_FINAL_TMP,
+							SEMANAGE_FC));
 				goto cleanup;
 			}
 		}
@@ -1026,118 +1344,53 @@ int semanage_split_fc(semanage_handle_t * sh)
 
 }
 
-/* Actually load the contents of the current active directory into the
- * kernel.  Return 0 on success, -3 on error. */
-static int semanage_install_active(semanage_handle_t * sh)
+/* Load the contexts of the final tmp into the final selinux directory.
+ * Return 0 on success, -3 on error.
+ */
+static int semanage_install_final_tmp(semanage_handle_t * sh)
 {
-	int retval = -3, r, len;
-	char *storepath = NULL;
-	struct stat astore, istore;
-	const char *active_kernel =
-	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_KERNEL);
-	const char *active_fc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC);
-	const char *active_fc_loc =
-	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC_LOCAL);
-	const char *active_seusers =
-	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_SEUSERS);
-	const char *active_nc = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_NC);
-	const char *active_fc_hd =
-	    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC_HOMEDIRS);
-
-	const char *running_fc = selinux_file_context_path();
-	const char *running_fc_loc = selinux_file_context_local_path();
-	const char *running_fc_hd = selinux_file_context_homedir_path();
-	const char *running_hd = selinux_homedir_context_path();
-	const char *running_policy = selinux_binary_policy_path();
-	const char *running_seusers = selinux_usersconf_path();
-	const char *running_nc = selinux_netfilter_context_path();
-	const char *really_active_store = selinux_policy_root();
-
-	/* This is very unelegant, the right thing to do is export the path 
-	 * building code in libselinux so that you can get paths for a given 
-	 * POLICYTYPE and should probably be done in the future. */
-	char store_fc[PATH_MAX];
-	char store_fc_loc[PATH_MAX];
-	char store_pol[PATH_MAX];
-	char store_seusers[PATH_MAX];
-	char store_nc[PATH_MAX];
-	char store_fc_hd[PATH_MAX];
-
-	len = strlen(really_active_store);
-	running_fc += len;
-	running_fc_loc += len;
-	running_fc_hd += len;
-	running_hd += len;
-	running_policy += len;
-	running_seusers += len;
-	running_nc += len;
-
-	len = strlen(selinux_path()) + strlen(sh->conf->store_path) + 1;
-	storepath = (char *)malloc(len);
-	if (!storepath)
-		goto cleanup;
-	snprintf(storepath, PATH_MAX, "%s%s", selinux_path(),
-		 sh->conf->store_path);
-
-	snprintf(store_pol, PATH_MAX, "%s%s.%d", storepath,
-		 running_policy, sh->conf->policyvers);
-	if (semanage_copy_file(active_kernel, store_pol, sh->conf->file_mode) ==
-	    -1) {
-		ERR(sh, "Could not copy %s to %s.", active_kernel, store_pol);
-		goto cleanup;
-	}
-
-	if (!sh->conf->disable_genhomedircon) {
-		snprintf(store_fc_hd, PATH_MAX, "%s%s", storepath, running_fc_hd);
-		if (semanage_copy_file(active_fc_hd, store_fc_hd, sh->conf->file_mode)
-			== -1) {
-			ERR(sh, "Could not copy %s to %s.", active_fc_hd, store_fc_hd);
-			goto cleanup;
-		}
-	}
+	int status = -3;
+	int ret = 0;
+	int i = 0;
+	const char *src = NULL;
+	const char *dst = NULL;
+	struct stat sb;
 
-	snprintf(store_fc, PATH_MAX, "%s%s", storepath, running_fc);
-	if (semanage_copy_file(active_fc, store_fc, sh->conf->file_mode) == -1) {
-		ERR(sh, "Could not copy %s to %s.", active_fc, store_fc);
-		goto cleanup;
-	}
+	/* For each of the final files install it if it exists.
+	 * i = 1 to avoid copying the top level directory.
+	 */
+	for (i = 1; i < SEMANAGE_FINAL_PATH_NUM; i++) {
+		src = semanage_final_path(SEMANAGE_FINAL_TMP, i);
+		dst = semanage_final_path(SEMANAGE_FINAL_SELINUX, i);
 
-	snprintf(store_fc_loc, PATH_MAX, "%s%s", storepath, running_fc_loc);
-	if (semanage_copy_file(active_fc_loc, store_fc_loc, sh->conf->file_mode)
-	    == -1 && errno != ENOENT) {
-		ERR(sh, "Could not copy %s to %s.", active_fc_loc,
-		    store_fc_loc);
-		goto cleanup;
-	}
-	errno = 0;
+		/* skip file if src doesn't exist */
+		if (stat(src, &sb) != 0) continue;
 
-	snprintf(store_seusers, PATH_MAX, "%s%s", storepath, running_seusers);
-	if (semanage_copy_file
-	    (active_seusers, store_seusers, sh->conf->file_mode) == -1
-	    && errno != ENOENT) {
-		ERR(sh, "Could not copy %s to %s.", active_seusers,
-		    store_seusers);
-		goto cleanup;
-	}
-	errno = 0;
+		/* skip genhomedircon if configured */
+		if (sh->conf->disable_genhomedircon &&
+		    i == SEMANAGE_FC_HOMEDIRS) continue;
 
-	snprintf(store_nc, PATH_MAX, "%s%s", storepath, running_nc);
-	if (semanage_copy_file(active_nc, store_nc, sh->conf->file_mode) == -1
-	    && errno != ENOENT) {
-		ERR(sh, "Could not copy %s to %s.", active_nc, store_nc);
-		goto cleanup;
+		ret = semanage_copy_file(src, dst, sh->conf->file_mode);
+		if (ret < 0) {
+			ERR(sh, "Could not copy %s to %s.", src, dst);
+			goto cleanup;
+		}
 	}
-	errno = 0;
 
 	if (!sh->do_reload)
 		goto skip_reload;
 
 	/* This stats what libselinux says the active store is (according to config)
 	 * and what we are installing to, to decide if they are the same store. If
-	 * they are not then we do not reload policy */
+	 * they are not then we do not reload policy.
+	 */
+	const char *really_active_store = selinux_policy_root();
+	struct stat astore;
+	struct stat istore;
+	const char *storepath = semanage_final_path(SEMANAGE_FINAL_SELINUX,
+						    SEMANAGE_FINAL_TOPLEVEL);
 
 	if (stat(really_active_store, &astore) == 0) {
-
 		if (stat(storepath, &istore)) {
 			ERR(sh, "Could not stat store path %s.", storepath);
 			goto cleanup;
@@ -1158,19 +1411,24 @@ static int semanage_install_active(semanage_handle_t * sh)
 		goto cleanup;
 	}
 
-      skip_reload:
-
-	if (sh->do_check_contexts && (r =
-	     semanage_exec_prog(sh, sh->conf->setfiles, store_pol,
-				store_fc)) != 0) {
-		ERR(sh, "setfiles returned error code %d.", r);
-		goto cleanup;
+skip_reload:
+	if (sh->do_check_contexts) {
+		ret = semanage_exec_prog(
+			sh,
+			sh->conf->setfiles,
+			semanage_final_path(SEMANAGE_FINAL_SELINUX,
+					    SEMANAGE_KERNEL),
+			semanage_final_path(SEMANAGE_FINAL_SELINUX,
+					    SEMANAGE_FC));
+		if (ret != 0) {
+			ERR(sh, "setfiles returned error code %d.", ret);
+			goto cleanup;
+		}
 	}
 
-	retval = 0;
-      cleanup:
-	free(storepath);
-	return retval;
+	status = 0;
+cleanup:
+	return status;
 }
 
 /* Prepare the sandbox to be installed by making a backup of the
@@ -1252,7 +1510,7 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 		retval = -1;
 		goto cleanup;
 	}
-	if (semanage_install_active(sh) != 0) {
+	if (semanage_install_final_tmp(sh) != 0) {
 		/* note that if an error occurs during the next three
 		 * function then the store will be left in an
 		 * inconsistent state */
@@ -1264,7 +1522,7 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 			ERR(sh, "Error while renaming %s back to %s.", backup,
 			    active);
 		else
-			semanage_install_active(sh);
+			semanage_install_final_tmp(sh);
 		errno = errsv;
 		retval = -1;
 		goto cleanup;
@@ -1721,7 +1979,8 @@ int semanage_read_policydb(semanage_handle_t * sh, sepol_policydb_t * in)
 	FILE *infile = NULL;
 
 	if ((kernel_filename =
-	     semanage_path(SEMANAGE_ACTIVE, SEMANAGE_KERNEL)) == NULL) {
+	     semanage_final_path(SEMANAGE_FINAL_SELINUX,
+				 SEMANAGE_KERNEL)) == NULL) {
 		goto cleanup;
 	}
 	if ((infile = fopen(kernel_filename, "r")) == NULL) {
@@ -1762,7 +2021,7 @@ int semanage_write_policydb(semanage_handle_t * sh, sepol_policydb_t * out)
 	FILE *outfile = NULL;
 
 	if ((kernel_filename =
-	     semanage_path(SEMANAGE_TMP, SEMANAGE_KERNEL)) == NULL) {
+	     semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_KERNEL)) == NULL) {
 		goto cleanup;
 	}
 	if ((outfile = fopen(kernel_filename, "wb")) == NULL) {
@@ -1847,7 +2106,7 @@ int semanage_verify_kernel(semanage_handle_t * sh)
 {
 	int retval = -1;
 	const char *kernel_filename =
-	    semanage_path(SEMANAGE_TMP, SEMANAGE_KERNEL);
+	    semanage_path(SEMANAGE_FINAL_TMP, SEMANAGE_KERNEL);
 	semanage_conf_t *conf = sh->conf;
 	external_prog_t *e;
 	if (conf->kernel_prog == NULL) {
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index c76ecfe..d3fd554 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -39,10 +39,8 @@ enum semanage_store_defs {
 enum semanage_sandbox_defs {
 	SEMANAGE_TOPLEVEL,
 	SEMANAGE_MODULES,
-	SEMANAGE_KERNEL,
 	SEMANAGE_BASE,
 	SEMANAGE_LINKED,
-	SEMANAGE_FC,
 	SEMANAGE_HOMEDIR_TMPL,
 	SEMANAGE_FC_TMPL,
 	SEMANAGE_COMMIT_NUM_FILE,
@@ -50,18 +48,32 @@ enum semanage_sandbox_defs {
 	SEMANAGE_INTERFACES_LOCAL,
 	SEMANAGE_NODES_LOCAL,
 	SEMANAGE_BOOLEANS_LOCAL,
-	SEMANAGE_FC_LOCAL,
 	SEMANAGE_SEUSERS_LOCAL,
 	SEMANAGE_USERS_BASE_LOCAL,
 	SEMANAGE_USERS_EXTRA_LOCAL,
-	SEMANAGE_SEUSERS,
 	SEMANAGE_USERS_EXTRA,
-	SEMANAGE_NC,
-	SEMANAGE_FC_HOMEDIRS,
 	SEMANAGE_DISABLE_DONTAUDIT,
+	SEMANAGE_MODULES_DISABLED,
 	SEMANAGE_STORE_NUM_PATHS
 };
 
+enum semanage_final_defs {
+	SEMANAGE_FINAL_TMP,
+	SEMANAGE_FINAL_SELINUX,
+	SEMANAGE_FINAL_NUM
+};
+
+enum semanage_final_path_defs {
+	SEMANAGE_FINAL_TOPLEVEL,
+	SEMANAGE_FC,
+	SEMANAGE_FC_HOMEDIRS,
+	SEMANAGE_FC_LOCAL,
+	SEMANAGE_KERNEL,
+	SEMANAGE_NC,
+	SEMANAGE_SEUSERS,
+	SEMANAGE_FINAL_PATH_NUM
+};
+
 const char *semanage_root_path(void);
 
 /* FIXME: this needs to be made a module store specific init and the
@@ -76,14 +88,21 @@ extern const char *semanage_fname(enum semanage_sandbox_defs file_enum);
 extern const char *semanage_path(enum semanage_store_defs store,
 				 enum semanage_sandbox_defs file);
 
+extern const char *semanage_final_path(enum semanage_final_defs root,
+				       enum semanage_final_path_defs suffix);
+
 int semanage_create_store(semanage_handle_t * sh, int create);
 
 int semanage_store_access_check(semanage_handle_t * sh);
 
 int semanage_remove_directory(const char *path);
 
+int semanage_mkdir(semanage_handle_t *sh, const char *path);
+
 int semanage_make_sandbox(semanage_handle_t * sh);
 
+int semanage_make_final(semanage_handle_t * sh);
+
 int semanage_get_modules_names(semanage_handle_t * sh,
 			       char ***filenames, int *len);
 
diff --git a/libsemanage/src/seuser_internal.h b/libsemanage/src/seuser_internal.h
index e6f2972..bf9cab0 100644
--- a/libsemanage/src/seuser_internal.h
+++ b/libsemanage/src/seuser_internal.h
@@ -30,7 +30,9 @@ hidden_proto(semanage_seuser_clone)
 extern record_table_t SEMANAGE_SEUSER_RTABLE;
 
 extern int seuser_file_dbase_init(semanage_handle_t * handle,
-				  const char *fname, dbase_config_t * dconfig);
+				  const char *path_ro,
+				  const char *path_rw,
+				  dbase_config_t * dconfig);
 
 extern void seuser_file_dbase_release(dbase_config_t * dconfig);
 
diff --git a/libsemanage/src/seusers_file.c b/libsemanage/src/seusers_file.c
index b5c8075..910bedf 100644
--- a/libsemanage/src/seusers_file.c
+++ b/libsemanage/src/seusers_file.c
@@ -115,11 +115,14 @@ record_file_table_t SEMANAGE_SEUSER_FILE_RTABLE = {
 };
 
 int seuser_file_dbase_init(semanage_handle_t * handle,
-			   const char *fname, dbase_config_t * dconfig)
+			   const char *path_ro,
+			   const char *path_rw,
+			   dbase_config_t * dconfig)
 {
 
 	if (dbase_file_init(handle,
-			    fname,
+			    path_ro,
+			    path_rw,
 			    &SEMANAGE_SEUSER_RTABLE,
 			    &SEMANAGE_SEUSER_FILE_RTABLE, &dconfig->dbase) < 0)
 		return STATUS_ERR;
diff --git a/libsemanage/src/user_internal.h b/libsemanage/src/user_internal.h
index 5c86418..ce1ac31 100644
--- a/libsemanage/src/user_internal.h
+++ b/libsemanage/src/user_internal.h
@@ -41,14 +41,16 @@ extern record_table_t SEMANAGE_USER_EXTRA_RTABLE;
 
 /* USER BASE record, FILE backend */
 extern int user_base_file_dbase_init(semanage_handle_t * handle,
-				     const char *fname,
+				     const char *path_ro,
+				     const char *path_rw,
 				     dbase_config_t * dconfig);
 
 extern void user_base_file_dbase_release(dbase_config_t * dconfig);
 
 /* USER EXTRA record, FILE backend */
 extern int user_extra_file_dbase_init(semanage_handle_t * handle,
-				      const char *fname,
+				      const char *path_ro,
+				      const char *path_rw,
 				      dbase_config_t * dconfig);
 
 extern void user_extra_file_dbase_release(dbase_config_t * dconfig);
diff --git a/libsemanage/src/users_base_file.c b/libsemanage/src/users_base_file.c
index affde51..0f0a8fd 100644
--- a/libsemanage/src/users_base_file.c
+++ b/libsemanage/src/users_base_file.c
@@ -202,11 +202,14 @@ record_file_table_t SEMANAGE_USER_BASE_FILE_RTABLE = {
 };
 
 int user_base_file_dbase_init(semanage_handle_t * handle,
-			      const char *fname, dbase_config_t * dconfig)
+			      const char *path_ro,
+			      const char *path_rw,
+			      dbase_config_t * dconfig)
 {
 
 	if (dbase_file_init(handle,
-			    fname,
+			    path_ro,
+			    path_rw,
 			    &SEMANAGE_USER_BASE_RTABLE,
 			    &SEMANAGE_USER_BASE_FILE_RTABLE,
 			    &dconfig->dbase) < 0)
diff --git a/libsemanage/src/users_base_policydb.c b/libsemanage/src/users_base_policydb.c
index 6bf6bb0..0a6ab9c 100644
--- a/libsemanage/src/users_base_policydb.c
+++ b/libsemanage/src/users_base_policydb.c
@@ -32,6 +32,7 @@ typedef struct dbase_policydb dbase_t;
 #include "user_internal.h"
 #include "debug.h"
 #include "database_policydb.h"
+#include "semanage_store.h"
 
 /* USER BASE record: POLICYDB extension: method table */
 record_policydb_table_t SEMANAGE_USER_BASE_POLICYDB_RTABLE = {
@@ -49,7 +50,10 @@ int user_base_policydb_dbase_init(semanage_handle_t * handle,
 {
 
 	if (dbase_policydb_init(handle,
-				"policy.kern",
+				semanage_final_path(SEMANAGE_FINAL_SELINUX,
+						    SEMANAGE_KERNEL),
+				semanage_final_path(SEMANAGE_FINAL_TMP,
+						    SEMANAGE_KERNEL),
 				&SEMANAGE_USER_BASE_RTABLE,
 				&SEMANAGE_USER_BASE_POLICYDB_RTABLE,
 				&dconfig->dbase) < 0)
diff --git a/libsemanage/src/users_extra_file.c b/libsemanage/src/users_extra_file.c
index 5f7eb1a..8f2bebd 100644
--- a/libsemanage/src/users_extra_file.c
+++ b/libsemanage/src/users_extra_file.c
@@ -106,11 +106,14 @@ record_file_table_t SEMANAGE_USER_EXTRA_FILE_RTABLE = {
 };
 
 int user_extra_file_dbase_init(semanage_handle_t * handle,
-			       const char *fname, dbase_config_t * dconfig)
+			       const char *path_ro,
+			       const char *path_rw,
+			       dbase_config_t * dconfig)
 {
 
 	if (dbase_file_init(handle,
-			    fname,
+			    path_ro,
+			    path_rw,
 			    &SEMANAGE_USER_EXTRA_RTABLE,
 			    &SEMANAGE_USER_EXTRA_FILE_RTABLE,
 			    &dconfig->dbase) < 0)
-- 
1.6.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
