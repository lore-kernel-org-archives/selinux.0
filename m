From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: vmojzis@redhat.com, richard_c_haines@btinternet.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsemanage: validate and compile file contexts before
 installing
Date: Wed, 17 Aug 2016 16:43:31 -0400
Message-Id: <1471466611-17131-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

libsemanage presently runs setfiles -c to validate the file_contexts
files and sefcontext_compile to compile them to file_contexts.bin
after installing the final files under /etc/selinux.  As a result,
any error that occurs during this processing may leave invalid files
in /etc/selinux.  Move this processing before installing the files
to their final location, and then copy the .bin files that were
generated.

This prevents an error like:
semanage fcontext -a -t httpd_exec_t "/foo["
from reaching the /etc/selinux directory at all, e.g.

$ sudo semanage fcontext -a -t httpd_exec_t "/foo["
/var/lib/selinux/final/targeted/contexts/files/file_contexts.local:  line 4 has invalid regex /foo[:  missing terminating ] for character class
/var/lib/selinux/final/targeted/contexts/files/file_contexts: Invalid argument
libsemanage.semanage_validate_and_compile_fcontexts: setfiles returned error code 1.
OSError: Error

Reported-by: Vit Mojzis <vmojzis@redhat.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsemanage/src/semanage_store.c | 92 +++++++++++++++++++++++++++-------------
 libsemanage/src/semanage_store.h |  3 ++
 2 files changed, 66 insertions(+), 29 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index fa0876f..ca29257 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -292,6 +292,13 @@ static int semanage_init_final_suffix(semanage_handle_t *sh)
 		goto cleanup;
 	}
 
+	if (asprintf(&semanage_final_suffix[SEMANAGE_FC_BIN], "%s.bin",
+		     semanage_final_suffix[SEMANAGE_FC]) < 0) {
+		ERR(sh, "Unable to allocate space for file context path.");
+		status = -1;
+		goto cleanup;
+	}
+
 	semanage_final_suffix[SEMANAGE_FC_HOMEDIRS] =
 		strdup(selinux_file_context_homedir_path() + offset);
 	if (semanage_final_suffix[SEMANAGE_FC_HOMEDIRS] == NULL) {
@@ -300,6 +307,13 @@ static int semanage_init_final_suffix(semanage_handle_t *sh)
 		goto cleanup;
 	}
 
+	if (asprintf(&semanage_final_suffix[SEMANAGE_FC_HOMEDIRS_BIN], "%s.bin",
+		     semanage_final_suffix[SEMANAGE_FC_HOMEDIRS]) < 0) {
+		ERR(sh, "Unable to allocate space for file context home directory path.");
+		status = -1;
+		goto cleanup;
+	}
+
 	semanage_final_suffix[SEMANAGE_FC_LOCAL] =
 		strdup(selinux_file_context_local_path() + offset);
 	if (semanage_final_suffix[SEMANAGE_FC_LOCAL] == NULL) {
@@ -308,6 +322,13 @@ static int semanage_init_final_suffix(semanage_handle_t *sh)
 		goto cleanup;
 	}
 
+	if (asprintf(&semanage_final_suffix[SEMANAGE_FC_LOCAL_BIN], "%s.bin",
+		     semanage_final_suffix[SEMANAGE_FC_LOCAL]) < 0) {
+		ERR(sh, "Unable to allocate space for local file context path.");
+		status = -1;
+		goto cleanup;
+	}
+
 	semanage_final_suffix[SEMANAGE_NC] =
 		strdup(selinux_netfilter_context_path() + offset);
 	if (semanage_final_suffix[SEMANAGE_NC] == NULL) {
@@ -1491,6 +1512,45 @@ static int sefcontext_compile(semanage_handle_t * sh, const char *path) {
 	return 0;
 }
 
+static int semanage_validate_and_compile_fcontexts(semanage_handle_t * sh)
+{
+	int status = -1;
+
+	if (sh->do_check_contexts) {
+		int ret;
+		ret = semanage_exec_prog(
+			sh,
+			sh->conf->setfiles,
+			semanage_final_path(SEMANAGE_FINAL_TMP,
+					    SEMANAGE_KERNEL),
+			semanage_final_path(SEMANAGE_FINAL_TMP,
+					    SEMANAGE_FC));
+		if (ret != 0) {
+			ERR(sh, "setfiles returned error code %d.", ret);
+			goto cleanup;
+		}
+	}
+
+	if (sefcontext_compile(sh,
+		    semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC)) != 0) {
+		goto cleanup;
+	}
+
+	if (sefcontext_compile(sh,
+		    semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL)) != 0) {
+		goto cleanup;
+	}
+
+	if (sefcontext_compile(sh,
+		    semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_HOMEDIRS)) != 0) {
+		goto cleanup;
+	}
+
+	status = 0;
+cleanup:
+	return status;
+}
+
 /* Load the contexts of the final tmp into the final selinux directory.
  * Return 0 on success, -3 on error.
  */
@@ -1566,35 +1626,6 @@ static int semanage_install_final_tmp(semanage_handle_t * sh)
 	}
 
 skip_reload:
-	if (sh->do_check_contexts) {
-		ret = semanage_exec_prog(
-			sh,
-			sh->conf->setfiles,
-			semanage_final_path(SEMANAGE_FINAL_SELINUX,
-					    SEMANAGE_KERNEL),
-			semanage_final_path(SEMANAGE_FINAL_SELINUX,
-					    SEMANAGE_FC));
-		if (ret != 0) {
-			ERR(sh, "setfiles returned error code %d.", ret);
-			goto cleanup;
-		}
-	}
-
-	if (sefcontext_compile(sh,
-		    semanage_final_path(SEMANAGE_FINAL_SELINUX, SEMANAGE_FC)) != 0) {
-		goto cleanup;
-	}
-
-	if (sefcontext_compile(sh,
-		    semanage_final_path(SEMANAGE_FINAL_SELINUX, SEMANAGE_FC_LOCAL)) != 0) {
-		goto cleanup;
-	}
-
-	if (sefcontext_compile(sh,
-		    semanage_final_path(SEMANAGE_FINAL_SELINUX, SEMANAGE_FC_HOMEDIRS)) != 0) {
-		goto cleanup;
-	}
-
 	status = 0;
 cleanup:
 	return status;
@@ -1737,6 +1768,9 @@ int semanage_install_sandbox(semanage_handle_t * sh)
 		goto cleanup;
 	}
 
+	if (semanage_validate_and_compile_fcontexts(sh) < 0)
+		goto cleanup;
+
 	if ((commit_num = semanage_commit_sandbox(sh)) < 0) {
 		retval = commit_num;
 		goto cleanup;
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index acb6e3f..c5b33c8 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -71,8 +71,11 @@ enum semanage_final_defs {
 enum semanage_final_path_defs {
 	SEMANAGE_FINAL_TOPLEVEL,
 	SEMANAGE_FC,
+	SEMANAGE_FC_BIN,
 	SEMANAGE_FC_HOMEDIRS,
+	SEMANAGE_FC_HOMEDIRS_BIN,
 	SEMANAGE_FC_LOCAL,
+	SEMANAGE_FC_LOCAL_BIN,
 	SEMANAGE_KERNEL,
 	SEMANAGE_NC,
 	SEMANAGE_SEUSERS,
-- 
2.7.4
