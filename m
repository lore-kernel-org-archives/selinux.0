From: Caleb Case <ccase@tresys.com>
To: selinux@tycho.nsa.gov
Cc: csellers@tresys.com, kmacmillan@tresys.com, jwcart2@tycho.nsa.gov,
        jbrindle@tresys.com, sds@tycho.nsa.gov, Caleb Case <ccase@tresys.com>
Subject: [PATCH 06/15] [src-policy] libsemanage: compile hll module
Date: Tue, 26 Jan 2010 17:08:12 -0500
Message-Id: <1264543701-20638-7-git-send-email-ccase@tresys.com>
In-Reply-To: <1264543701-20638-6-git-send-email-ccase@tresys.com>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com>
 <1264543701-20638-2-git-send-email-ccase@tresys.com>
 <1264543701-20638-3-git-send-email-ccase@tresys.com>
 <1264543701-20638-4-git-send-email-ccase@tresys.com>
 <1264543701-20638-5-git-send-email-ccase@tresys.com>
 <1264543701-20638-6-git-send-email-ccase@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This provides the basic compilation function semanage_compile_hll that
is called during module installation. semanage_exec is a helper function
which sets up the redirected io for the child process, executes it,
waits for the child to exit, and then propagates the child's exit
status. An additional helper function semanage_fd_to_data reads a given
file descriptor into a buffer (unzipping it if necessary). The
compilation messages are stored in
/var/lib/selinux/.../modules/<priority>/<module>/log.
---
 libsemanage/src/direct_api.c     |    9 +-
 libsemanage/src/modules.c        |    7 +-
 libsemanage/src/modules.h        |    3 +-
 libsemanage/src/semanage_store.c |  354 ++++++++++++++++++++++++++++++++++++++
 libsemanage/src/semanage_store.h |   29 +++
 5 files changed, 398 insertions(+), 4 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 9bbe96d..61e5b92 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1,7 +1,7 @@
 /* Author: Jason Tang	  <jtang@tresys.com>
  *         Christopher Ashworth <cashworth@tresys.com>
  *
- * Copyright (C) 2004-2006 Tresys Technology, LLC
+ * Copyright (C) 2004-2006,2010 Tresys Technology, LLC
  * Copyright (C) 2005 Red Hat, Inc.
  * 
  *  This library is free software; you can redistribute it and/or
@@ -2486,6 +2486,13 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
 		goto cleanup;
 	}
 
+	/* compile hll to cil */
+	ret = semanage_compile_hll(sh, modinfo);
+	if (ret != 0) {
+		status = -3;
+		goto cleanup;
+	}
+
 cleanup:
 	semanage_module_key_destroy(sh, &higher_key);
 	semanage_module_info_destroy(sh, higher_info);
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index 6f6f8b1..be30517 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -2,7 +2,7 @@
  *	   Jason Tang	  <jtang@tresys.com>
  *	   Caleb Case	  <ccase@tresys.com>
  *
- * Copyright (C) 2004-2005,2009 Tresys Technology, LLC
+ * Copyright (C) 2004-2005,2009-2010 Tresys Technology, LLC
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -666,6 +666,8 @@ int semanage_module_get_path(semanage_handle_t *sh,
 			if (file == NULL) file = "lang_ext";
 		case SEMANAGE_MODULE_PATH_VERSION:
 			if (file == NULL) file = "version";
+		case SEMANAGE_MODULE_PATH_LOG:
+			if (file == NULL) file = "log";
 
 			/* verify priority and name */
 			ret = semanage_module_validate_priority(modinfo->priority);
@@ -989,10 +991,11 @@ int semanage_module_validate_name(const char * name)
 	}
 
 	if (strcmp(name, "_base") == 0) {
+		status = -1;
 		goto exit;
 	}
 
-	if (!isalpha(*name)) {
+	if (!isalpha(*name) && *name != '_') {
 		status = -1;
 		goto exit;
 	}
diff --git a/libsemanage/src/modules.h b/libsemanage/src/modules.h
index 38e1e0c..3d2cc1a 100644
--- a/libsemanage/src/modules.h
+++ b/libsemanage/src/modules.h
@@ -2,7 +2,7 @@
  *         Jason Tang     <jtang@tresys.com>
  *         Caleb Case     <ccase@tresys.com>
  *
- * Copyright (C) 2005,2009 Tresys Technology, LLC
+ * Copyright (C) 2005,2009-2010 Tresys Technology, LLC
  *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
@@ -86,6 +86,7 @@ enum semanage_module_path_type {
 	SEMANAGE_MODULE_PATH_LANG_EXT,
 	SEMANAGE_MODULE_PATH_VERSION,
 	SEMANAGE_MODULE_PATH_DISABLED,
+	SEMANAGE_MODULE_PATH_LOG,
 };
 
 /* Get the module path for the given path @type.
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 2bda1e2..dd96a75 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -3034,3 +3034,357 @@ int semanage_nc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 
 	return 0;
 }
+
+/* Execute @cmd with @args and redirect the @io.
+ *
+ * @io is an array of fd's to redirect. Indices correspond to fds. The fds
+ * are not closed. Indices set to -1 are ignored, otherwise they are
+ * dup2'd.
+ *
+ * Returns:
+ * 	 0	success
+ * 	-1	failure, error outside HLL compiler
+ * 	+N	failure, HLL compiler exit status N
+ */
+static int semanage_exec(semanage_handle_t *sh,
+			 const char *cmd,
+			 char *argv[],
+			 int io[],
+			 int io_len)
+{
+	int status = 0;
+	int ret = 0;
+
+	char *env[] = { NULL };
+
+	ret = fork();
+	if (ret < 0) {
+		ERR(sh, "Failed to fork");
+		status = -1;
+		goto cleanup;
+	}
+
+	if (ret == 0) {		/* child */
+		int i;
+		for (i = 0; i < io_len; i++) {
+			if (io[i] >= 0) {
+				ret = dup2(io[i], i);
+				if (ret < 0) {
+					exit(EXIT_FAILURE);
+				}
+			}
+		}
+
+		execve(cmd, argv, env);
+
+		/* If we made it here, then something bad happened. */
+		ERR(sh, "Failed to execute %s.", cmd);
+		exit(EXIT_FAILURE);
+	}
+	else {			/* parent */
+		ret = wait(&status);
+		if (ret < 0) {
+			status = -1;
+			goto cleanup;
+		}
+
+		if (WIFEXITED(status)) {
+			status = WEXITSTATUS(status);
+		}
+		else {
+			status = -1;
+		}
+	}
+
+cleanup:
+	if (status != 0) {
+		ERR(sh, "Failed to execute %s (exit status %d).", cmd, status);
+	}
+
+	return status;
+}
+
+int semanage_fd_to_data(semanage_handle_t *sh,
+			int fd,
+			char **data,
+			size_t *data_len)
+{
+	assert(sh);
+	assert(data);
+	assert(data_len);
+
+	int status = 0;
+	int ret = 0;
+
+	*data = NULL;
+	*data_len = 0;
+
+	FILE *fp = NULL;
+	struct stat sb;
+	sb.st_size = 0;
+	ssize_t nread = 0;
+	char *data_tmp = NULL;
+
+	/* Find out how big it is. */
+	ret = fstat(fd, &sb);
+	if (ret != 0) {
+		ERR(sh, "Failed to stat file");
+		status = -2;
+		goto cleanup;
+	}
+	*data_len = sb.st_size;
+
+	/* Allocate a buffer for the file. */
+	*data = malloc(*data_len + 1);
+	if (*data == NULL) {
+		ERR(sh, "Out of memory!");
+		status = -1;
+		goto cleanup;
+	}
+	(*data)[*data_len] = '\0';
+
+	/* Read into the buffer. */
+	while((size_t)nread != *data_len) {
+		nread = read(fd, *data + nread, *data_len - nread);
+		if (nread < 0) {
+			ERR(sh, "Failed to read the file");
+			status = -1;
+			goto cleanup;
+		}
+	}
+
+	/* Try to bunzip. */
+	fp = fmemopen(*data, *data_len, "r");
+	if (fp == NULL) {
+		ERR(sh, "Failed to open file for reading");
+		status = -1;
+		goto cleanup;
+	}
+
+	nread = bunzip(sh, fp, &data_tmp);
+	if (nread > 0) {
+		free(*data);
+		*data = data_tmp;
+		*data_len = (size_t)nread;
+	}
+
+cleanup:
+	if (status != 0) {
+		free(*data);
+		*data = NULL;
+		*data_len = 0;
+	}
+
+	if (fp != NULL) fclose(fp);
+
+	return status;
+}
+
+int semanage_compile_hll(semanage_handle_t *sh,
+			 const semanage_module_info_t *modinfo)
+{
+	int status = 0;
+	int ret = 0;
+
+	char hll_path[PATH_MAX];
+	char cil_path[PATH_MAX];
+	char ver_path[PATH_MAX];
+	char log_path[PATH_MAX];
+
+	char tmp[] = "/tmp/libsemanage-XXXXXX";
+	int tmp_fd = -1;
+	ssize_t nwrite = 0;
+
+	int io[4];
+	int io_len = 4;
+
+	const semanage_lang_conf_t *conf = NULL;
+
+	int i;
+
+	char **argv = NULL;
+
+	char *data = NULL;
+	size_t data_len = 0;
+
+	/* determine paths and setup io:
+	 *
+	 * 0	hll
+	 * 1	cil
+	 * 2	log
+	 * 3	version
+	 */
+
+	/* 0	hll */
+	ret = semanage_module_get_path(sh,
+				       modinfo,
+				       SEMANAGE_MODULE_PATH_HLL,
+				       hll_path,
+				       sizeof(hll_path));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* open hll, read in (which will bunzip if necessary) */
+	tmp_fd = open(hll_path, O_RDONLY);
+	if (tmp_fd < 0) {
+		ERR(sh, "Failed to open %s", hll_path);
+		status = -1;
+		goto cleanup;
+	}
+
+	ret = semanage_fd_to_data(sh, tmp_fd, &data, &data_len);
+	if (ret != 0) {
+		ERR(sh, "Failed to read %s", hll_path);
+		status = -1;
+		goto cleanup;
+	}
+
+	close(tmp_fd);
+	tmp_fd = mkstemp(tmp);
+	if (tmp_fd < 0) {
+		ERR(sh,
+		    "Failed to create tmp file for module %s.",
+		    modinfo->name);
+		status = -1;
+		goto cleanup;
+	}
+
+	while((size_t)nwrite != data_len) {
+		nwrite = write(tmp_fd, data + nwrite, data_len - nwrite);
+		if (nwrite < 0) {
+			ERR(sh,
+			    "Failed to write data to tmp file for module %s.",
+			    modinfo->name);
+			status = -1;
+			goto cleanup;
+		}
+	}
+
+	ret = fsync(tmp_fd);
+	if (ret != 0) {
+		ERR(sh,
+		    "Failed to write data to tmp file for module %s.",
+		    modinfo->name);
+		status = -1;
+		goto cleanup;
+	}
+	close(tmp_fd);
+	tmp_fd = -1;
+
+	io[0] = open(tmp, O_RDONLY);
+	if (io[0] < 0) {
+		ERR(sh, "Failed to open tmp file %s", tmp);
+		status = -1;
+		goto cleanup;
+	}
+
+	/* 1	cil */
+	ret = semanage_module_get_path(sh,
+				       modinfo,
+				       SEMANAGE_MODULE_PATH_CIL,
+				       cil_path,
+				       sizeof(cil_path));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	io[1] = creat(cil_path, S_IRUSR | S_IWUSR);
+	if (io[1] < 0) {
+		ERR(sh, "Failed to create %s", cil_path);
+		status = -1;
+		goto cleanup;
+	}
+
+	/* 2	log */
+	ret = semanage_module_get_path(sh,
+				       modinfo,
+				       SEMANAGE_MODULE_PATH_LOG,
+				       log_path,
+				       sizeof(log_path));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	io[2] = creat(log_path, S_IRUSR | S_IWUSR);
+	if (io[2] < 0) {
+		ERR(sh, "Failed to create %s", log_path);
+		status = -1;
+		goto cleanup;
+	}
+
+	/* 3	version */
+	ret = semanage_module_get_path(sh,
+				       modinfo,
+				       SEMANAGE_MODULE_PATH_VERSION,
+				       ver_path,
+				       sizeof(ver_path));
+	if (ret != 0) {
+		status = -1;
+		goto cleanup;
+	}
+
+	io[3] = creat(ver_path, S_IRUSR | S_IWUSR);
+	if (io[3] < 0) {
+		ERR(sh, "Failed to create %s", ver_path);
+		status = -1;
+		goto cleanup;
+	}
+
+	/* get the lang conf for this language */
+	conf = semanage_get_lang_conf(sh, modinfo->lang_ext);
+	if (conf == NULL) {
+		status = -1;
+		goto cleanup;
+	}
+
+	/* setup argv */
+	argv = split_args(conf->compiler, conf->flags, "", "");
+	if (argv == NULL) {
+		ERR(sh, "Out of memory!");
+		status = -1;
+		goto cleanup;
+	}
+
+	/* exec the hll compiler */
+	status = semanage_exec(sh, conf->compiler, argv, io, io_len);
+	if (status > 0) {
+		ret = fsync(io[2]);
+		if (ret != 0) {
+			WARN(sh, "Failed to sync log to disk!");
+		}
+		close(io[2]);
+
+		io[2] = open(log_path, O_RDONLY);
+		if (io[2] < 0) {
+			ERR(sh, "Failed to open log file.");
+			goto cleanup;
+		}
+
+		ret = semanage_fd_to_data(sh, io[2], &data, &data_len);
+		if (ret != 0) {
+			ERR(sh, "Failed to read log.");
+			goto cleanup;
+		}
+
+		ERR(sh, "%s\n", data);
+	}
+
+cleanup:
+	free(data);
+
+	free_argv(argv);
+
+	for (i = 0; i < io_len; i++) {
+		if (io[i] >= 0) close(io[i]);
+	}
+
+	if (tmp_fd >= 0) close(tmp_fd);
+	unlink(tmp);
+
+	return status;
+}
+
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index 4ad0b21..f1b9675 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -160,4 +160,33 @@ int semanage_base_path(semanage_handle_t *sh,
 		       char *path,
 		       size_t len);
 
+/* Copy @fd into a the buffer @data with size @data_len.
+ * On call @data will be set to NULL and @data_len to 0.
+ * If @fd is bzip compressed, it will be uncompressed.
+ *
+ * fstat is called on @fd and hence only file based @fd's
+ * are supported (i.e., pipes will not work).
+ *
+ * Caller should free *data.
+ *
+ * Returns:
+ * 	 0	success
+ * 	-1	failure, out of memory
+ * 	-2	failure, invalid @fd
+ */
+int semanage_fd_to_data(semanage_handle_t *sh,
+			int fd,
+			char **data,
+			size_t *data_len);
+
+/* Compiles the modules HLL source into the CIL.
+ *
+ * Returns:
+ * 	 0	success
+ * 	-1	failure, error outside HLL compiler
+ * 	+N	failure, HLL compiler exit status N
+ */
+int semanage_compile_hll(semanage_handle_t *sh,
+			 const semanage_module_info_t *modinfo);
+
 #endif
-- 
1.6.3.3


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
