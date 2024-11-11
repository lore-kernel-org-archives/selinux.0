Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDDF1A00D6
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334641; cv=none; b=M4SRDstXy2kKU9EuHVqCZkKlAlO6VWCJzeku5o3pxEJSE2hxKOCS5eiHlDfT8ulfPcN/BMsiIScSfZJYuY9WTk5hq6LDHO5AnUwcPx4YHxlBgugYtNru718ZlcT9SR8k6OPoiEzXoy7n7vU3A7jidfm1dIBbUN96ELsFui+ZNgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334641; c=relaxed/simple;
	bh=GgYNpBzgsEow3FC7aWWulenS2YkQMQbxELJP9q3WtbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nI6Apw83wUsRttk/FmPoplofCfOrCvwAz2ac71N3gnP4pm/+M2qych26OC8BMiH2KgyE9W/V4N3oiAnFoLNEixm3a3w1bjLoCxM2IY2ngeqBa3kx5zRF/Bdwi3vJPHJehQlDHlQcfegAQlbZitTLWlTApBGk/ROjvFxREPY894E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=VCxcvi9B; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="VCxcvi9B"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334634;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TiS5LBzFs6Dh/8Zd2sA+tJWS4qXQUXYfJoXeJY6e5V4=;
	b=VCxcvi9BDteHEYiZHMS/srM8fgJf6qxEUXeYNYpqQwz3ZtdBtGEBXsav0yDajuvzmlkC62
	7JM5WLepbqt/a5Qg3TPAS2M8YvwtBXqDaWdanLqoDnbziO77z/YVqtiUcJ43iiDna/xS+l
	XNbW7AG+0JgxOALklhanq3BaP+WB5KlirQw6vDRzTaeTK06O32Nx3xJTWrCNMyE5Y0pRew
	6C34Gi0nW/8eTpVbk6poSWySGpMvxj4F5p+G+GVj0a92iLTHgsc0SF6vJJ8wOu3nTKQUnm
	tyusqPiZXsDXhK0tErzNAGMVz7UOdKC5jueWR/ms6qg8VzdGazXAlK+NtgkpRA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 10/47] libsemanage: set O_CLOEXEC flag for file descriptors
Date: Mon, 11 Nov 2024 15:16:29 +0100
Message-ID: <20241111141706.38039-10-cgoettsche@seltendoof.de>
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

Close internal managed file descriptors in case of an concurrent execve.

Also avoid leaking file descriptors in get_shell_list().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/compressed_file.c   |  4 ++--
 libsemanage/src/conf-parse.y        |  2 +-
 libsemanage/src/database_file.c     |  2 +-
 libsemanage/src/database_policydb.c |  2 +-
 libsemanage/src/direct_api.c        | 20 ++++++++++----------
 libsemanage/src/genhomedircon.c     |  8 +++++---
 libsemanage/src/parse_utils.c       |  2 +-
 libsemanage/src/semanage_store.c    | 28 ++++++++++++++--------------
 libsemanage/src/utilities.c         |  2 +-
 9 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/libsemanage/src/compressed_file.c b/libsemanage/src/compressed_file.c
index 067f54d7..74185c92 100644
--- a/libsemanage/src/compressed_file.c
+++ b/libsemanage/src/compressed_file.c
@@ -48,7 +48,7 @@ static int bzip(semanage_handle_t *sh, const char *filename, void *data,
 	size_t len;
 	FILE *f;
 
-	if ((f = fopen(filename, "wb")) == NULL) {
+	if ((f = fopen(filename, "wbe")) == NULL) {
 		return -1;
 	}
 
@@ -177,7 +177,7 @@ int map_compressed_file(semanage_handle_t *sh, const char *path,
 	int ret = 0, fd = -1;
 	FILE *file = NULL;
 
-	fd = open(path, O_RDONLY);
+	fd = open(path, O_RDONLY | O_CLOEXEC);
 	if (fd == -1) {
 		ERR(sh, "Unable to open %s\n", path);
 		return -1;
diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index 8cfbd580..9e58345a 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -429,7 +429,7 @@ semanage_conf_t *semanage_conf_parse(const char *config_filename)
 	if (semanage_conf_init(current_conf) == -1) {
 		goto cleanup;
 	}
-	if ((semanage_in = fopen(config_filename, "r")) == NULL) {
+	if ((semanage_in = fopen(config_filename, "re")) == NULL) {
 		/* configuration file does not exist or could not be
 		 * read.  THIS IS NOT AN ERROR.  just rely on the
 		 * defaults. */
diff --git a/libsemanage/src/database_file.c b/libsemanage/src/database_file.c
index a7773fb5..6fe2ddf3 100644
--- a/libsemanage/src/database_file.c
+++ b/libsemanage/src/database_file.c
@@ -127,7 +127,7 @@ static int dbase_file_flush(semanage_handle_t * handle, dbase_file_t * dbase)
 	fname = dbase->path[handle->is_in_transaction];
 
 	mask = umask(0077);
-	str = fopen(fname, "w");
+	str = fopen(fname, "we");
 	umask(mask);
 	if (!str) {
 		ERR(handle, "could not open %s for writing: %s",
diff --git a/libsemanage/src/database_policydb.c b/libsemanage/src/database_policydb.c
index 95418365..19d90de5 100644
--- a/libsemanage/src/database_policydb.c
+++ b/libsemanage/src/database_policydb.c
@@ -111,7 +111,7 @@ static int dbase_policydb_cache(semanage_handle_t * handle,
 
 	/* Try opening file
 	 * ENOENT is not fatal - we just create an empty policydb */
-	fp = fopen(fname, "rb");
+	fp = fopen(fname, "rbe");
 	if (fp == NULL && errno != ENOENT) {
 		ERR(handle, "could not open %s for reading: %s",
 		    fname, strerror(errno));
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 104dbd40..3fa24331 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -456,7 +456,7 @@ static int write_file(semanage_handle_t * sh,
 	int out;
 
 	if ((out =
-	     open(filename, O_WRONLY | O_CREAT | O_TRUNC,
+	     open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC,
 		  S_IRUSR | S_IWUSR)) == -1) {
 		ERR(sh, "Could not open %s for writing.", filename);
 		return -1;
@@ -639,17 +639,17 @@ static int semanage_pipe_data(semanage_handle_t *sh, char *path, char *in_data,
 	 */
 	sigaction(SIGPIPE, &new_signal, &old_signal);
 
-	retval = pipe(input_fd);
+	retval = pipe2(input_fd, O_CLOEXEC);
 	if (retval == -1) {
 		ERR(sh, "Unable to create pipe for input pipe: %s\n", strerror(errno));
 		goto cleanup;
 	}
-	retval = pipe(output_fd);
+	retval = pipe2(output_fd, O_CLOEXEC);
 	if (retval == -1) {
 		ERR(sh, "Unable to create pipe for output pipe: %s\n", strerror(errno));
 		goto cleanup;
 	}
-	retval = pipe(err_fd);
+	retval = pipe2(err_fd, O_CLOEXEC);
 	if (retval == -1) {
 		ERR(sh, "Unable to create pipe for error pipe: %s\n", strerror(errno));
 		goto cleanup;
@@ -821,7 +821,7 @@ static int semanage_direct_write_langext(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
-	fp = fopen(fn, "w");
+	fp = fopen(fn, "we");
 	if (fp == NULL) {
 		ERR(sh, "Unable to open %s module ext file.", modinfo->name);
 		ret = -1;
@@ -1072,7 +1072,7 @@ static int semanage_compare_checksum(semanage_handle_t *sh, const char *referenc
 	int fd, retval;
 	char *data;
 
-	fd = open(path, O_RDONLY);
+	fd = open(path, O_RDONLY | O_CLOEXEC);
 	if (fd == -1) {
 		if (errno != ENOENT) {
 			ERR(sh, "Unable to open %s: %s\n", path, strerror(errno));
@@ -1213,7 +1213,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	}
 	if (sepol_get_disable_dontaudit(sh->sepolh) == 1) {
 		FILE *touch;
-		touch = fopen(path, "w");
+		touch = fopen(path, "we");
 		if (touch != NULL) {
 			if (fclose(touch) != 0) {
 				ERR(sh, "Error attempting to create disable_dontaudit flag.");
@@ -1245,7 +1245,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 	if (sepol_get_preserve_tunables(sh->sepolh) == 1) {
 		FILE *touch;
-		touch = fopen(path, "w");
+		touch = fopen(path, "we");
 		if (touch != NULL) {
 			if (fclose(touch) != 0) {
 				ERR(sh, "Error attempting to create preserve_tunable flag.");
@@ -2107,7 +2107,7 @@ static int semanage_direct_set_enabled(semanage_handle_t *sh,
 	switch (enabled) {
 		case 0: /* disable the module */
 			mask = umask(0077);
-			fp = fopen(fn, "w");
+			fp = fopen(fn, "we");
 			umask(mask);
 
 			if (fp == NULL) {
@@ -2294,7 +2294,7 @@ static int semanage_direct_get_module_info(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
-	fp = fopen(fn, "r");
+	fp = fopen(fn, "re");
 
 	if (fp == NULL) {
 		ERR(sh,
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index ede2d67d..9e2fe453 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -218,7 +218,7 @@ static semanage_list_t *get_shell_list(void)
 	size_t buff_len = 0;
 	ssize_t len;
 
-	shells = fopen(PATH_SHELLS_FILE, "r");
+	shells = fopen(PATH_SHELLS_FILE, "re");
 	if (!shells)
 		return default_shell_list();
 	while ((len = getline(&temp, &buff_len, shells)) > 0) {
@@ -227,11 +227,13 @@ static semanage_list_t *get_shell_list(void)
 			if (semanage_list_push(&list, temp)) {
 				free(temp);
 				semanage_list_destroy(&list);
+				fclose(shells);
 				return default_shell_list();
 			}
 		}
 	}
 	free(temp);
+	fclose(shells);
 
 	return list;
 }
@@ -503,7 +505,7 @@ static semanage_list_t *make_template(genhomedircon_settings_t * s,
 	FILE *template_file = NULL;
 	semanage_list_t *template_data = NULL;
 
-	template_file = fopen(s->homedir_template_path, "r");
+	template_file = fopen(s->homedir_template_path, "re");
 	if (!template_file)
 		return NULL;
 	template_data = semanage_slurp_file_filter(template_file, pred);
@@ -1410,7 +1412,7 @@ int semanage_genhomedircon(semanage_handle_t * sh,
 	s.h_semanage = sh;
 	s.policydb = policydb;
 
-	if (!(out = fopen(s.fcfilepath, "w"))) {
+	if (!(out = fopen(s.fcfilepath, "we"))) {
 		/* couldn't open output file */
 		ERR(sh, "Could not open the file_context file for writing");
 		retval = STATUS_ERR;
diff --git a/libsemanage/src/parse_utils.c b/libsemanage/src/parse_utils.c
index 918dee43..13837c87 100644
--- a/libsemanage/src/parse_utils.c
+++ b/libsemanage/src/parse_utils.c
@@ -45,7 +45,7 @@ void parse_release(parse_info_t * info)
 int parse_open(semanage_handle_t * handle, parse_info_t * info)
 {
 
-	info->file_stream = fopen(info->filename, "r");
+	info->file_stream = fopen(info->filename, "re");
 	if (!info->file_stream && (errno != ENOENT)) {
 		ERR(handle, "could not open file %s: %s",
 		    info->filename, strerror(errno));
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 08e6fc1b..7c9f5b2a 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -625,7 +625,7 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 	if (stat(path, &sb) == -1) {
 		if (errno == ENOENT && create) {
 			mask = umask(0077);
-			if ((fd = creat(path, S_IRUSR | S_IWUSR)) == -1) {
+			if ((fd = open(path, O_CREAT | O_WRONLY | O_TRUNC | O_CLOEXEC, S_IRUSR | S_IWUSR)) == -1) {
 				umask(mask);
 				ERR(sh, "Could not create lock file at %s.",
 				    path);
@@ -722,7 +722,7 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode,
 	if (n < 0 || n >= PATH_MAX)
 		return -1;
 
-	if ((in = open(src, O_RDONLY)) == -1) {
+	if ((in = open(src, O_RDONLY | O_CLOEXEC)) == -1) {
 		return -1;
 	}
 
@@ -730,7 +730,7 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode,
 		mode = S_IRUSR | S_IWUSR;
 
 	mask = umask(0);
-	if ((out = open(tmp, O_WRONLY | O_CREAT | O_TRUNC, mode)) == -1) {
+	if ((out = open(tmp, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, mode)) == -1) {
 		umask(mask);
 		errsv = errno;
 		close(in);
@@ -1516,7 +1516,7 @@ int semanage_split_fc(semanage_handle_t * sh)
 	char buf[PATH_MAX] = { 0 };
 
 	/* I use fopen here instead of open so that I can use fgets which only reads a single line */
-	file_con = fopen(semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL), "r");
+	file_con = fopen(semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL), "re");
 	if (!file_con) {
 		ERR(sh, "Could not open %s for reading.",
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL));
@@ -1524,14 +1524,14 @@ int semanage_split_fc(semanage_handle_t * sh)
 	}
 
 	fc = open(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
-		  O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
+		  O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, S_IRUSR | S_IWUSR);
 	if (fc < 0) {
 		ERR(sh, "Could not open %s for writing.",
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC));
 		goto cleanup;
 	}
 	hd = open(semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL),
-		  O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
+		  O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, S_IRUSR | S_IWUSR);
 	if (hd < 0) {
 		ERR(sh, "Could not open %s for writing.",
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL));
@@ -1746,7 +1746,7 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 	memset(write_buf, 0, sizeof(write_buf));
 	snprintf(write_buf, sizeof(write_buf), "%d", commit_number);
 	if ((fd =
-	     open(commit_filename, O_WRONLY | O_CREAT | O_TRUNC,
+	     open(commit_filename, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC,
 		  S_IRUSR | S_IWUSR)) == -1) {
 		ERR(sh, "Could not open commit number file %s for writing.",
 		    commit_filename);
@@ -1762,7 +1762,7 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 	close(fd);
 
 	/* sync changes in sandbox to filesystem */
-	fd = open(sandbox, O_DIRECTORY);
+	fd = open(sandbox, O_DIRECTORY | O_CLOEXEC);
 	if (fd == -1) {
 		ERR(sh, "Error while opening %s for syncfs(): %d", sandbox, errno);
 		return -1;
@@ -1895,9 +1895,9 @@ static int semanage_get_lock(semanage_handle_t * sh,
 	struct timeval origtime, curtime;
 	int got_lock = 0;
 
-	if ((fd = open(lock_file, O_RDONLY)) == -1) {
+	if ((fd = open(lock_file, O_RDONLY | O_CLOEXEC)) == -1) {
 		if ((fd =
-		     open(lock_file, O_RDWR | O_CREAT | O_TRUNC,
+		     open(lock_file, O_RDWR | O_CREAT | O_TRUNC | O_CLOEXEC,
 			  S_IRUSR | S_IWUSR)) == -1) {
 			ERR(sh, "Could not open direct %s at %s.", lock_name,
 			    lock_file);
@@ -2042,7 +2042,7 @@ int semanage_direct_get_serial(semanage_handle_t * sh)
 		    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_COMMIT_NUM_FILE);
 	}
 
-	if ((fd = open(commit_filename, O_RDONLY)) == -1) {
+	if ((fd = open(commit_filename, O_RDONLY | O_CLOEXEC)) == -1) {
 		if (errno == ENOENT) {
 			/* the commit number file does not exist yet,
 			 * so assume that the number is 0 */
@@ -2122,7 +2122,7 @@ int semanage_read_policydb(semanage_handle_t * sh, sepol_policydb_t * in,
 	     semanage_path(SEMANAGE_ACTIVE, file)) == NULL) {
 		goto cleanup;
 	}
-	if ((infile = fopen(kernel_filename, "r")) == NULL) {
+	if ((infile = fopen(kernel_filename, "re")) == NULL) {
 		ERR(sh, "Could not open kernel policy %s for reading.",
 		    kernel_filename);
 		goto cleanup;
@@ -2165,7 +2165,7 @@ int semanage_write_policydb(semanage_handle_t * sh, sepol_policydb_t * out,
 	     semanage_path(SEMANAGE_TMP, file)) == NULL) {
 		goto cleanup;
 	}
-	if ((outfile = fopen(kernel_filename, "wb")) == NULL) {
+	if ((outfile = fopen(kernel_filename, "wbe")) == NULL) {
 		ERR(sh, "Could not open kernel policy %s for writing.",
 		    kernel_filename);
 		goto cleanup;
@@ -3032,7 +3032,7 @@ void semanage_setfiles(const char *path){
 
 	/* Make sure "path" is owned by root */
 	if ((geteuid() != 0 || getegid() != 0) &&
-	    ((fd = open(path, O_RDONLY)) != -1)){
+	    ((fd = open(path, O_RDONLY | O_CLOEXEC)) != -1)){
 		/* Skip files with the SUID or SGID bit set -- abuse protection */
 		if ((fstat(fd, &sb) != -1) &&
 		    !(S_ISREG(sb.st_mode) &&
diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index 24284d65..3702cbe1 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -40,7 +40,7 @@ char *semanage_findval(const char *file, const char *var, const char *delim)
 	assert(file);
 	assert(var);
 
-	if ((fd = fopen(file, "r")) == NULL)
+	if ((fd = fopen(file, "re")) == NULL)
 		return NULL;
 
 	while (getline(&buff, &buff_len, fd) > 0) {
-- 
2.45.2

