Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32591A0AFB
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334648; cv=none; b=LWY75HlaYz+ok5IyutUyRdXFFjQgRbwDZeUigsE9vn1jADjU3LJoZuafIuedvfsoVy5ZDoqMyeQ5JRwucCpRbecYPX5zkKeliRg4pQaQsloOkbqgZgsjHKzvtTVorFe3x+t9bPbTmgfiH74yCRGpZu5wfPpk3j9ILWPsR47yp1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334648; c=relaxed/simple;
	bh=o3KrUK6aW+v016qS7aEi7It8VBXwDNfEeopZlhR44vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOEWnVwyw2YvV4X9wOjpp87E3Au2bxMv1RESqPbt63n5RT+8TBn1Wwt7SLyU7r5kXwijlGq4ybsdKdjwlIx1z/Z65/6VSu87uSLj9xiruhQi5FyM39qbyFQ0G+i2cYUQkCJyVCV2tyh7pUYbWrFAV/opG4ELk6/NIIV7O3cBs8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=dXLePPcU; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="dXLePPcU"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334640;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KXVFez3Q0O+ZX/hnSaqWVigvr4yWb/g2D8IoYp4pVss=;
	b=dXLePPcUojyvf3jHldvdyR/bNzEb84QKhBrpK2uDJEVo5SuqddMQVqDSRXkt3bwbZ8sYHZ
	ylEChAQutUNGUQY+FVl2tXTEcJsV6aJfCV5V9xBjeWluZLn0BlwlKkHZJSzR8/9k9Bjp6f
	EuDGWoSAJMNXbZnmKP2IDP/LgTUCA6sC5mLPKLQQJLNbfqSDEb6RM9Zo7tscBbMe/y4QDn
	DHuXO65Te5+KyAR+JKX9Nt5XgdAonndjwRor1kKm/+lZYbUxz5WSzKpoAv2bYXNos9sxgj
	/Z/Ob/mlfFR29wCFVwijERM7XmsNUJ+us8ZJi87rvufxuIW1w00kYc1c6isqOQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 39/47] libsemanage: avoid writing directly to stderr
Date: Mon, 11 Nov 2024 15:16:58 +0100
Message-ID: <20241111141706.38039-39-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The client application might have redirected the error output via
semanage_msg_set_callback(3), so use the logging macros.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/direct_api.c     | 17 ++++++------
 libsemanage/src/semanage_store.c | 44 ++++++++++++++++----------------
 libsemanage/src/semanage_store.h |  6 ++---
 3 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index b10e5c8f..d9cefff5 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1135,8 +1135,8 @@ static const int semanage_computed_files[] = {
 /* Copies a file from src to dst. If dst already exists then
  * overwrite it. If source doesn't exist then return success.
  * Returns 0 on success, -1 on error. */
-static int copy_file_if_exists(const char *src, const char *dst, mode_t mode){
-	int rc = semanage_copy_file(src, dst, mode, false);
+static int copy_file_if_exists(semanage_handle_t *sh, const char *src, const char *dst, mode_t mode){
+	int rc = semanage_copy_file(sh, src, dst, mode, false);
 	return (rc < 0 && errno != ENOENT) ? rc : 0;
 }
 
@@ -1432,7 +1432,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 		path = semanage_path(SEMANAGE_TMP, SEMANAGE_SEUSERS_LINKED);
 		if (stat(path, &sb) == 0) {
-			retval = semanage_copy_file(path,
+			retval = semanage_copy_file(sh, path,
 						    semanage_path(SEMANAGE_TMP,
 								  SEMANAGE_STORE_SEUSERS),
 						    0, false);
@@ -1450,7 +1450,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 		path = semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA_LINKED);
 		if (stat(path, &sb) == 0) {
-			retval = semanage_copy_file(path,
+			retval = semanage_copy_file(sh, path,
 						    semanage_path(SEMANAGE_TMP,
 								  SEMANAGE_USERS_EXTRA),
 						    0, false);
@@ -1559,28 +1559,28 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	if (retval < 0)
 		goto cleanup;
 
-	retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_KERNEL),
+	retval = semanage_copy_file(sh, semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_KERNEL),
 			semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_KERNEL),
 			sh->conf->file_mode, false);
 	if (retval < 0) {
 		goto cleanup;
 	}
 
-	retval = copy_file_if_exists(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
+	retval = copy_file_if_exists(sh, semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
 						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
 						sh->conf->file_mode);
 	if (retval < 0) {
 		goto cleanup;
 	}
 
-	retval = copy_file_if_exists(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
+	retval = copy_file_if_exists(sh, semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
 						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC),
 						sh->conf->file_mode);
 	if (retval < 0) {
 		goto cleanup;
 	}
 
-	retval = copy_file_if_exists(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS),
+	retval = copy_file_if_exists(sh, semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS),
 						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_SEUSERS),
 						sh->conf->file_mode);
 	if (retval < 0) {
@@ -1598,6 +1598,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 			}
 			/* file_contexts.homedirs was created in SEMANAGE_TMP store */
 			retval = semanage_copy_file(
+						sh,
 						semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_HOMEDIRS),
 						semanage_final_path(SEMANAGE_FINAL_TMP,	SEMANAGE_FC_HOMEDIRS),
 						sh->conf->file_mode, false);
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 68bc8c41..47205148 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -656,7 +656,7 @@ int semanage_store_access_check(void)
 
 /********************* other I/O functions *********************/
 
-static int semanage_copy_dir_flags(const char *src, const char *dst, int flag);
+static int semanage_copy_dir_flags(semanage_handle_t * sh, const char *src, const char *dst, int flag);
 
 /* Callback used by scandir() to select files. */
 static int semanage_filename_select(const struct dirent *d)
@@ -670,8 +670,8 @@ static int semanage_filename_select(const struct dirent *d)
 
 /* Copies a file from src to dst.  If dst already exists then
  * overwrite it.  Returns 0 on success, -1 on error. */
-int semanage_copy_file(const char *src, const char *dst, mode_t mode,
-		bool syncrequired)
+int semanage_copy_file(semanage_handle_t *sh, const char *src, const char *dst,
+		       mode_t mode, bool syncrequired)
 {
 	int in, out, retval = 0, amount_read, n, errsv = errno;
 	char tmp[PATH_MAX];
@@ -725,7 +725,7 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode,
 	if (!retval && rename(tmp, dst) == -1)
 		return -1;
 
-	semanage_setfiles(dst);
+	semanage_setfiles(sh, dst);
 out:
 	errno = errsv;
 	return retval;
@@ -741,7 +741,7 @@ static int semanage_rename(semanage_handle_t * sh, const char *src, const char *
 	/* we can't use rename() due to filesystem limitation, lets try to copy files manually */
 	WARN(sh, "WARNING: rename(%s, %s) failed: %m, fall back to non-atomic semanage_copy_dir_flags()",
 		 src, dst);
-	if (semanage_copy_dir_flags(src, dst, 1) == -1) {
+	if (semanage_copy_dir_flags(sh, src, dst, 1) == -1) {
 		return -1;
 	}
 	return semanage_remove_directory(src);
@@ -749,15 +749,15 @@ static int semanage_rename(semanage_handle_t * sh, const char *src, const char *
 
 /* Copies all of the files from src to dst, recursing into
  * subdirectories.  Returns 0 on success, -1 on error. */
-static int semanage_copy_dir(const char *src, const char *dst)
+static int semanage_copy_dir(semanage_handle_t * sh, const char *src, const char *dst)
 {
-	return semanage_copy_dir_flags(src, dst, 1);
+	return semanage_copy_dir_flags(sh, src, dst, 1);
 }
 
 /* Copies all of the dirs from src to dst, recursing into
  * subdirectories. If flag == 1, then copy regular files as
  * well. Returns 0 on success, -1 on error. */
-static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
+static int semanage_copy_dir_flags(semanage_handle_t * sh, const char *src, const char *dst, int flag)
 {
 	int i, len = 0, rc, retval = -1;
 	struct stat sb;
@@ -766,7 +766,7 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
 	mode_t mask;
 
 	if ((len = scandir(src, &names, semanage_filename_select, NULL)) == -1) {
-		fprintf(stderr, "Could not read the contents of %s: %s\n", src, strerror(errno));
+		ERR(sh, "Could not read the contents of %s.", src);
 		return -1;
 	}
 
@@ -774,12 +774,12 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
 		mask = umask(0077);
 		if (mkdir(dst, S_IRWXU) != 0) {
 			umask(mask);
-			fprintf(stderr, "Could not create %s: %s\n", dst, strerror(errno));
+			ERR(sh, "Could not create %s.", dst);
 			goto cleanup;
 		}
 		umask(mask);
 
-		semanage_setfiles(dst);
+		semanage_setfiles(sh, dst);
 	}
 
 	for (i = 0; i < len; i++) {
@@ -801,15 +801,15 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
 		if (S_ISDIR(sb.st_mode)) {
 			mask = umask(0077);
 			if (mkdir(path2, 0700) == -1 ||
-			    semanage_copy_dir_flags(path, path2, flag) == -1) {
+			    semanage_copy_dir_flags(sh, path, path2, flag) == -1) {
 				umask(mask);
 				goto cleanup;
 			}
 			umask(mask);
-			semanage_setfiles(path2);
+			semanage_setfiles(sh, path2);
 		} else if (S_ISREG(sb.st_mode) && flag == 1) {
 			mask = umask(0077);
-			if (semanage_copy_file(path, path2, sb.st_mode,
+			if (semanage_copy_file(sh, path, path2, sb.st_mode,
 						false) < 0) {
 				umask(mask);
 				goto cleanup;
@@ -912,7 +912,7 @@ int semanage_mkdir(semanage_handle_t *sh, const char *path)
 
 		}
 		umask(mask);
-		semanage_setfiles(path);
+		semanage_setfiles(sh, path);
 	}
 	else {
 		/* check that it really is a directory */
@@ -956,7 +956,7 @@ int semanage_make_sandbox(semanage_handle_t * sh)
 
 	mask = umask(0077);
 	if (mkdir(sandbox, S_IRWXU) == -1 ||
-	    semanage_copy_dir(semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL),
+	    semanage_copy_dir(sh, semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL),
 			      sandbox) == -1) {
 		umask(mask);
 		ERR(sh, "Could not copy files to sandbox %s.", sandbox);
@@ -1589,19 +1589,19 @@ static int semanage_validate_and_compile_fcontexts(semanage_handle_t * sh)
 		    semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC)) != 0) {
 		goto cleanup;
 	}
-	semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_BIN));
+	semanage_setfiles(sh, semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_BIN));
 
 	if (sefcontext_compile(sh,
 		    semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL)) != 0) {
 		goto cleanup;
 	}
-	semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL_BIN));
+	semanage_setfiles(sh, semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL_BIN));
 
 	if (sefcontext_compile(sh,
 		    semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_HOMEDIRS)) != 0) {
 		goto cleanup;
 	}
-	semanage_setfiles(semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_HOMEDIRS_BIN));
+	semanage_setfiles(sh, semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_HOMEDIRS_BIN));
 
 	status = 0;
 cleanup:
@@ -1646,7 +1646,7 @@ static int semanage_install_final_tmp(semanage_handle_t * sh)
 			goto cleanup;
 		}
 
-		ret = semanage_copy_file(src, dst, sh->conf->file_mode,
+		ret = semanage_copy_file(sh, src, dst, sh->conf->file_mode,
 					true);
 		if (ret < 0) {
 			ERR(sh, "Could not copy %s to %s.", src, dst);
@@ -2996,7 +2996,7 @@ int semanage_nc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 
 /* Make sure the file context and ownership of files in the policy
  * store does not change */
-void semanage_setfiles(const char *path){
+void semanage_setfiles(semanage_handle_t * sh, const char *path){
 	struct stat sb;
 	int fd;
 	/* Fix the user and role portions of the context, ignore errors
@@ -3011,7 +3011,7 @@ void semanage_setfiles(const char *path){
 		    !(S_ISREG(sb.st_mode) &&
 		      (sb.st_mode & (S_ISUID | S_ISGID))) &&
 		    (fchown(fd, 0, 0) == -1))
-			fprintf(stderr, "Warning! Could not set ownership of %s to root\n", path);
+			ERR(sh, "Warning! Could not set ownership of %s to root", path);
 
 		close(fd);
 	}
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index e21dadeb..d9b116e2 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -124,7 +124,7 @@ int semanage_get_cil_paths(semanage_handle_t * sh, semanage_module_info_t *modin
 int semanage_get_active_modules(semanage_handle_t *sh,
 			       semanage_module_info_t **modinfo, int *num_modules);
 
-void semanage_setfiles(const char *path);
+void semanage_setfiles(semanage_handle_t * sh, const char *path);
 
 /* lock file routines */
 int semanage_get_trans_lock(semanage_handle_t * sh);
@@ -165,7 +165,7 @@ int semanage_nc_sort(semanage_handle_t * sh,
 		     size_t buf_len,
 		     char **sorted_buf, size_t * sorted_buf_len);
 
-int semanage_copy_file(const char *src, const char *dst, mode_t mode,
-		bool syncrequired);
+int semanage_copy_file(semanage_handle_t * sh, const char *src, const char *dst,
+		       mode_t mode, bool syncrequired);
 
 #endif
-- 
2.45.2

