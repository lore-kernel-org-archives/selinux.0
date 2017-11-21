Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vALF7QeR030472
 for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2017 10:07:26 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC14.oob.disa.mil (Postfix) with SMTP id 3yh7dH1VqWzJ3Cb
 for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2017 14:44:03 +0000 (UTC)
Received: from UPDC3CPA04.eemsg.mil (unknown [192.168.18.11])
 by UPDCF3IC14.oob.disa.mil (Postfix) with ESMTP id 3yh7dG6rJpzJ3CL
 for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2017 14:44:02 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C9D381DEB
 for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2017 14:19:52 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 21 Nov 2017 15:19:40 +0100
Message-Id: <20171121141940.24371-1-plautrba@redhat.com>
Subject: [PATCH] libsemanage: Use umask(0077) for fopen() write
 operations
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When a calling process uses umask(0) some files in the SELinux module
store can be created to be world writeable. With this patch, libsemanage
sets umask(0077) before fopen() operations and restores the original
umask value when it's done.

Fixes:
drwx------. /var/lib/selinux/targeted/active
-rw-rw-rw-. /var/lib/selinux/targeted/active/booleans.local
-rw-rw-rw-. /var/lib/selinux/targeted/active/policy.linked
-rw-rw-rw-. /var/lib/selinux/targeted/active/seusers.local

drwx------. /var/lib/selinux/targeted/active/modules/400/permissive_sshd_t
-rw-rw-rw-. /var/lib/selinux/targeted/active/modules/400/permissive_sshd_t/cil
-rw-rw-rw-. /var/lib/selinux/targeted/active/modules/400/permissive_sshd_t/lang_ext
drwx------. /var/lib/selinux/targeted/active/modules/disabled
-rw-rw-rw-. /var/lib/selinux/targeted/active/modules/disabled/zosremote

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsemanage/src/database_file.c  |  3 +++
 libsemanage/src/direct_api.c     | 15 +++++++++++++++
 libsemanage/src/semanage_store.c |  4 ++++
 3 files changed, 22 insertions(+)

diff --git a/libsemanage/src/database_file.c b/libsemanage/src/database_file.c
index a21b3eeb..d0172e73 100644
--- a/libsemanage/src/database_file.c
+++ b/libsemanage/src/database_file.c
@@ -119,13 +119,16 @@ static int dbase_file_flush(semanage_handle_t * handle, dbase_file_t * dbase)
 	cache_entry_t *ptr;
 	const char *fname = NULL;
 	FILE *str = NULL;
+	mode_t mask = 0;
 
 	if (!dbase_llist_is_modified(&dbase->llist))
 		return STATUS_SUCCESS;
 
 	fname = dbase->path[handle->is_in_transaction];
 
+	mask = umask(0077);
 	str = fopen(fname, "w");
+	umask(mask);
 	if (!str) {
 		ERR(handle, "could not open %s for writing: %s",
 		    fname, strerror(errno));
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 00ad8201..46072f92 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1176,6 +1176,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	sepol_policydb_t *out = NULL;
 	struct cil_db *cildb = NULL;
 	semanage_module_info_t *modinfos = NULL;
+	mode_t mask = 0;
 
 	int do_rebuild, do_write_kernel, do_install;
 	int fcontexts_modified, ports_modified, seusers_modified,
@@ -1212,6 +1213,8 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	/* Rebuild if explicitly requested or any module changes occurred. */
 	do_rebuild = sh->do_rebuild | sh->modules_modified;
 
+	mask = umask(0077);
+
 	/* Create or remove the disable_dontaudit flag file. */
 	path = semanage_path(SEMANAGE_TMP, SEMANAGE_DISABLE_DONTAUDIT);
 	if (access(path, F_OK) == 0)
@@ -1645,6 +1648,10 @@ cleanup:
 	semanage_remove_directory(semanage_final_path
 				  (SEMANAGE_FINAL_TMP,
 				   SEMANAGE_FINAL_TOPLEVEL));
+	if (mask) {
+		umask(mask);
+	}
+
 	return retval;
 }
 
@@ -2016,6 +2023,7 @@ static int semanage_direct_set_enabled(semanage_handle_t *sh,
 	const char *path = NULL;
 	FILE *fp = NULL;
 	semanage_module_info_t *modinfo = NULL;
+	mode_t mask = 0;
 
 	/* check transaction */
 	if (!sh->is_in_transaction) {
@@ -2076,7 +2084,9 @@ static int semanage_direct_set_enabled(semanage_handle_t *sh,
 
 	switch (enabled) {
 		case 0: /* disable the module */
+			mask = umask(0077);
 			fp = fopen(fn, "w");
+			umask(mask);
 
 			if (fp == NULL) {
 				ERR(sh,
@@ -2722,7 +2732,9 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
 	int type;
 
 	char path[PATH_MAX];
+	mode_t mask = 0;
 
+	mask = umask(0077);
 	semanage_module_info_t *higher_info = NULL;
 	semanage_module_key_t higher_key;
 	ret = semanage_module_key_init(sh, &higher_key);
@@ -2834,6 +2846,9 @@ cleanup:
 	semanage_module_info_destroy(sh, higher_info);
 	free(higher_info);
 
+	if (mask) {
+		umask(mask);
+	}
 	return status;
 }
 
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 63c80b04..74fbb677 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -2099,11 +2099,13 @@ int semanage_write_policydb(semanage_handle_t * sh, sepol_policydb_t * out,
 	const char *kernel_filename = NULL;
 	struct sepol_policy_file *pf = NULL;
 	FILE *outfile = NULL;
+	mode_t mask = 0;
 
 	if ((kernel_filename =
 	     semanage_path(SEMANAGE_TMP, file)) == NULL) {
 		goto cleanup;
 	}
+	mask = umask(0077);
 	if ((outfile = fopen(kernel_filename, "wb")) == NULL) {
 		ERR(sh, "Could not open kernel policy %s for writing.",
 		    kernel_filename);
@@ -2127,6 +2129,8 @@ int semanage_write_policydb(semanage_handle_t * sh, sepol_policydb_t * out,
 	if (outfile != NULL) {
 		fclose(outfile);
 	}
+	if (mask != 0)
+		umask(mask);
 	sepol_policy_file_free(pf);
 	return retval;
 }
-- 
2.15.0
