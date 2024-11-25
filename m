Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB21957F4
	for <selinux@vger.kernel.org>; Mon, 25 Nov 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533528; cv=none; b=OnTcQeeqxpF59OlaI6MPbfWAW835Xc7w84/JpaXtNY5ee0vXhnkMIbYu8XfbKM1mDi4fX/JoJr9i6vBjIjE15EfuWx5lgDfohphmxry8a5UtKZfB4SPM5z5eN0DO/ay43eIiF9zTMpsj2Ag6ErH1h8c0gPaXAU3ze44lPaZhHAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533528; c=relaxed/simple;
	bh=yA4zYpLIRF9wBjamTMo85hSMBWtrFjZ251BqWvhmDp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z27673BFgKb6Z7rnqARDctcYVbWgCNHFxsenqvzk9w5CkxHcdBS+uP8eNltPknk90Wv27RsWSfABolbPH+k4WJm4+7A0ZkSF3D+yvAhk1d7n3dC+JzmLLEDfAvN+CwF0SaJ5xjxbr8vzk5MYgVgiYIgT60t0Ct3IBp7yVzpGT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=t6tmU3Xm; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="t6tmU3Xm"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732533524;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=O5JXb33srMViKxdGk82E6jSz/58pI075e6DiJWIdNjY=;
	b=t6tmU3XmaMqfkMVnCaUE/Qz72JNSF5s8MGbKYnt5dL0zcZk/ChYgm9+OebsthvtT8KH0Lw
	58LvrDxbp3Atxfqus9iTL7qIoYOr0l8vqdiUL9yv+NUYX9el4hxtuul2zQwcP3azRrSl+F
	qpIwRX6hwHiw9Je7dwyhJWXiahdgxHwHIjXrluLY4x1o/fatUBFsNJ2EY1kuSoOFXdnTCg
	QZQOsbfSlWUbH02MQBIOVZvwn7Xidv9sjuockzaXn2JIn7tuB6oCtC4VxxLeRBTB5DBhUW
	5dyCG1m7ce1aLAmXlWgmpD5kp3zR8z77YGnUrm+a4Quo+upOv/4c7jCo/6DkFA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 1/9] libsemanage: set O_CLOEXEC flag for file descriptors
Date: Mon, 25 Nov 2024 12:18:32 +0100
Message-ID: <20241125111840.63845-1-cgoettsche@seltendoof.de>
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
 libsemanage/src/semanage_store.c    | 26 +++++++++++++-------------
 libsemanage/src/utilities.c         |  2 +-
 9 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/libsemanage/src/compressed_file.c b/libsemanage/src/compressed_file.c
index e62d2a18..e4a1efb0 100644
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
index d6481359..b2b84892 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -468,7 +468,7 @@ semanage_conf_t *semanage_conf_parse(const char *config_filename)
 	if (semanage_conf_init(current_conf) == -1) {
 		goto cleanup;
 	}
-	if ((semanage_in = fopen(config_filename, "r")) == NULL) {
+	if ((semanage_in = fopen(config_filename, "re")) == NULL) {
 		/* configuration file does not exist or could not be
 		 * read.  THIS IS NOT AN ERROR.  just rely on the
 		 * defaults. */
diff --git a/libsemanage/src/database_file.c b/libsemanage/src/database_file.c
index 42e308d5..a54c5aee 100644
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
index da64a3ad..62467d15 100644
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
index d5299796..85876676 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -457,7 +457,7 @@ static int write_file(semanage_handle_t * sh,
 	int out;
 
 	if ((out =
-	     open(filename, O_WRONLY | O_CREAT | O_TRUNC,
+	     open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC,
 		  S_IRUSR | S_IWUSR)) == -1) {
 		ERR(sh, "Could not open %s for writing.", filename);
 		return -1;
@@ -644,17 +644,17 @@ static int semanage_pipe_data(semanage_handle_t *sh, const char *path, const cha
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
@@ -826,7 +826,7 @@ static int semanage_direct_write_langext(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
-	fp = fopen(fn, "w");
+	fp = fopen(fn, "we");
 	if (fp == NULL) {
 		ERR(sh, "Unable to open %s module ext file.", modinfo->name);
 		ret = -1;
@@ -1077,7 +1077,7 @@ static int semanage_compare_checksum(semanage_handle_t *sh, const char *referenc
 	int fd, retval;
 	char *data;
 
-	fd = open(path, O_RDONLY);
+	fd = open(path, O_RDONLY | O_CLOEXEC);
 	if (fd == -1) {
 		if (errno != ENOENT) {
 			ERR(sh, "Unable to open %s: %s\n", path, strerror(errno));
@@ -1218,7 +1218,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	}
 	if (sepol_get_disable_dontaudit(sh->sepolh) == 1) {
 		FILE *touch;
-		touch = fopen(path, "w");
+		touch = fopen(path, "we");
 		if (touch != NULL) {
 			if (fclose(touch) != 0) {
 				ERR(sh, "Error attempting to create disable_dontaudit flag.");
@@ -1250,7 +1250,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 	if (sepol_get_preserve_tunables(sh->sepolh) == 1) {
 		FILE *touch;
-		touch = fopen(path, "w");
+		touch = fopen(path, "we");
 		if (touch != NULL) {
 			if (fclose(touch) != 0) {
 				ERR(sh, "Error attempting to create preserve_tunable flag.");
@@ -2109,7 +2109,7 @@ static int semanage_direct_set_enabled(semanage_handle_t *sh,
 	switch (enabled) {
 		case 0: /* disable the module */
 			mask = umask(0077);
-			fp = fopen(fn, "w");
+			fp = fopen(fn, "we");
 			umask(mask);
 
 			if (fp == NULL) {
@@ -2296,7 +2296,7 @@ static int semanage_direct_get_module_info(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
-	fp = fopen(fn, "r");
+	fp = fopen(fn, "re");
 
 	if (fp == NULL) {
 		ERR(sh,
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index fd2f8a89..53673645 100644
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
@@ -1413,7 +1415,7 @@ int semanage_genhomedircon(semanage_handle_t * sh,
 	s.h_semanage = sh;
 	s.policydb = policydb;
 
-	if (!(out = fopen(s.fcfilepath, "w"))) {
+	if (!(out = fopen(s.fcfilepath, "we"))) {
 		/* couldn't open output file */
 		ERR(sh, "Could not open the file_context file for writing");
 		retval = STATUS_ERR;
diff --git a/libsemanage/src/parse_utils.c b/libsemanage/src/parse_utils.c
index 2f33f629..d1d6e930 100644
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
index 5cd2d219..d75aab68 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -585,7 +585,7 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 	if (stat(path, &sb) == -1) {
 		if (errno == ENOENT && create) {
 			mask = umask(0077);
-			if ((fd = creat(path, S_IRUSR | S_IWUSR)) == -1) {
+			if ((fd = open(path, O_CREAT | O_WRONLY | O_TRUNC | O_CLOEXEC, S_IRUSR | S_IWUSR)) == -1) {
 				umask(mask);
 				ERR(sh, "Could not create lock file at %s.",
 				    path);
@@ -682,7 +682,7 @@ int semanage_copy_file(semanage_handle_t *sh, const char *src, const char *dst,
 	if (n < 0 || n >= PATH_MAX)
 		return -1;
 
-	if ((in = open(src, O_RDONLY)) == -1) {
+	if ((in = open(src, O_RDONLY | O_CLOEXEC)) == -1) {
 		return -1;
 	}
 
@@ -690,7 +690,7 @@ int semanage_copy_file(semanage_handle_t *sh, const char *src, const char *dst,
 		mode = S_IRUSR | S_IWUSR;
 
 	mask = umask(0);
-	if ((out = open(tmp, O_WRONLY | O_CREAT | O_TRUNC, mode)) == -1) {
+	if ((out = open(tmp, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, mode)) == -1) {
 		umask(mask);
 		errsv = errno;
 		close(in);
@@ -1489,7 +1489,7 @@ int semanage_split_fc(semanage_handle_t * sh)
 	char buf[PATH_MAX] = { 0 };
 
 	/* I use fopen here instead of open so that I can use fgets which only reads a single line */
-	file_con = fopen(semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL), "r");
+	file_con = fopen(semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL), "re");
 	if (!file_con) {
 		ERR(sh, "Could not open %s for reading.",
 		    semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL));
@@ -1497,14 +1497,14 @@ int semanage_split_fc(semanage_handle_t * sh)
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
@@ -1719,7 +1719,7 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 	memset(write_buf, 0, sizeof(write_buf));
 	snprintf(write_buf, sizeof(write_buf), "%d", commit_number);
 	if ((fd =
-	     open(commit_filename, O_WRONLY | O_CREAT | O_TRUNC,
+	     open(commit_filename, O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC,
 		  S_IRUSR | S_IWUSR)) == -1) {
 		ERR(sh, "Could not open commit number file %s for writing.",
 		    commit_filename);
@@ -1735,7 +1735,7 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 	close(fd);
 
 	/* sync changes in sandbox to filesystem */
-	fd = open(sandbox, O_DIRECTORY);
+	fd = open(sandbox, O_DIRECTORY | O_CLOEXEC);
 	if (fd == -1) {
 		ERR(sh, "Error while opening %s for syncfs(): %d", sandbox, errno);
 		return -1;
@@ -1869,7 +1869,7 @@ static int semanage_get_lock(semanage_handle_t * sh,
 	int got_lock = 0;
 
 	if ((fd =
-	     open(lock_file, O_RDWR | O_CREAT | O_TRUNC,
+	     open(lock_file, O_RDWR | O_CREAT | O_TRUNC | O_CLOEXEC,
 		  S_IRUSR | S_IWUSR)) == -1) {
 		ERR(sh, "Could not open direct %s at %s.", lock_name,
 		    lock_file);
@@ -2013,7 +2013,7 @@ int semanage_direct_get_serial(semanage_handle_t * sh)
 		    semanage_path(SEMANAGE_ACTIVE, SEMANAGE_COMMIT_NUM_FILE);
 	}
 
-	if ((fd = open(commit_filename, O_RDONLY)) == -1) {
+	if ((fd = open(commit_filename, O_RDONLY | O_CLOEXEC)) == -1) {
 		if (errno == ENOENT) {
 			/* the commit number file does not exist yet,
 			 * so assume that the number is 0 */
@@ -2093,7 +2093,7 @@ int semanage_read_policydb(semanage_handle_t * sh, sepol_policydb_t * in,
 	     semanage_path(SEMANAGE_ACTIVE, file)) == NULL) {
 		goto cleanup;
 	}
-	if ((infile = fopen(kernel_filename, "r")) == NULL) {
+	if ((infile = fopen(kernel_filename, "re")) == NULL) {
 		ERR(sh, "Could not open kernel policy %s for reading.",
 		    kernel_filename);
 		goto cleanup;
@@ -2136,7 +2136,7 @@ int semanage_write_policydb(semanage_handle_t * sh, sepol_policydb_t * out,
 	     semanage_path(SEMANAGE_TMP, file)) == NULL) {
 		goto cleanup;
 	}
-	if ((outfile = fopen(kernel_filename, "wb")) == NULL) {
+	if ((outfile = fopen(kernel_filename, "wbe")) == NULL) {
 		ERR(sh, "Could not open kernel policy %s for writing.",
 		    kernel_filename);
 		goto cleanup;
@@ -3003,7 +3003,7 @@ void semanage_setfiles(semanage_handle_t * sh, const char *path){
 
 	/* Make sure "path" is owned by root */
 	if ((geteuid() != 0 || getegid() != 0) &&
-	    ((fd = open(path, O_RDONLY)) != -1)){
+	    ((fd = open(path, O_RDONLY | O_CLOEXEC)) != -1)){
 		/* Skip files with the SUID or SGID bit set -- abuse protection */
 		if ((fstat(fd, &sb) != -1) &&
 		    !(S_ISREG(sb.st_mode) &&
diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index 77b948fa..70b5b677 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -38,7 +38,7 @@ char *semanage_findval(const char *file, const char *var, const char *delim)
 	assert(file);
 	assert(var);
 
-	if ((fd = fopen(file, "r")) == NULL)
+	if ((fd = fopen(file, "re")) == NULL)
 		return NULL;
 
 	while (getline(&buff, &buff_len, fd) > 0) {
-- 
2.45.2

