Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0284C197A9F
	for <selinux@vger.kernel.org>; Mon, 25 Nov 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533529; cv=none; b=d8qPt4HHZ8KKL1jjA5S5PvFEv++vhvlH81IfC6LPywMk++PgZtUiHn3roTm9JmGgFxTIjmh74ioNQ6PKexbT8h5EWum8pE0c3Q/LXj95YilA979QKw9brMFzLVvTKQg9baTrWSzUT8DALGMf35VK2orBIqJfruaYi5DMacTQLEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533529; c=relaxed/simple;
	bh=zuJAzZTkWMct2ypY8fP89yDYUcV/sRiCKbf8H7Nkpok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhlbePH+kvXLVBKR8cazxnXLfl/weihKO7ruYA4UNIlwHjlWRBdcv+w5qxHOfaoaQex/29oq3uTArE2470uuNLyNwCs354DySAnIi044H9bJSJi755aYyzsKFST+qGNa3iCDwm0CWmxkRWs+wE/CBAINo337OZlt5Me1h419URQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=bHTfhsW6; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="bHTfhsW6"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1732533525;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+yMpsxxplNo2nXRMWgSEJnTJRQq8yo5sKNzkvd7fZU=;
	b=bHTfhsW6Qn2wyhu2NoMLQwhK5QGMliqP3Cu27uq94IiNkAZTG27Q8SK4WtVmlWNWiTHD/y
	uH2K/Zs7hKP9smPamUuLyMUaNu3bzbFWl2W2hVHzceJNAnOdSyGeBXqcLZ2ZvHYvai9NyQ
	viXbfrgPAQLPkmuYpVwvxD/CTO59xLAOaFFpu1/8HW5v+5vhpwFir2GSM5I+oADZx6f7T3
	nsbpU9p1Nsbm8TME91xt/xkdWXnge8VaNcXUNptUe6/PoMRHBmDZD7+YmmV/F783eJJGMR
	wueAtluWSpWe6OlzIWym50+n0Hw4H+aLPVlnONOe4NptyR/loY6WIFSegNxX8g==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 4/9] libsemanage: drop duplicate newlines and error descriptions in error messages
Date: Mon, 25 Nov 2024 12:18:35 +0100
Message-ID: <20241125111840.63845-4-cgoettsche@seltendoof.de>
In-Reply-To: <20241125111840.63845-1-cgoettsche@seltendoof.de>
References: <20241125111840.63845-1-cgoettsche@seltendoof.de>
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

The ERR macro already appends the errno description and a trailing
newline.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/compressed_file.c   |   4 +-
 libsemanage/src/database_file.c     |   4 +-
 libsemanage/src/database_policydb.c |   4 +-
 libsemanage/src/direct_api.c        | 100 +++++++++++++---------------
 libsemanage/src/genhomedircon.c     |   2 +-
 libsemanage/src/handle.c            |   2 +-
 libsemanage/src/parse_utils.c       |   4 +-
 libsemanage/src/semanage_store.c    |   6 +-
 8 files changed, 61 insertions(+), 65 deletions(-)

diff --git a/libsemanage/src/compressed_file.c b/libsemanage/src/compressed_file.c
index e4a1efb0..4fa5b3e0 100644
--- a/libsemanage/src/compressed_file.c
+++ b/libsemanage/src/compressed_file.c
@@ -179,13 +179,13 @@ int map_compressed_file(semanage_handle_t *sh, const char *path,
 
 	fd = open(path, O_RDONLY | O_CLOEXEC);
 	if (fd == -1) {
-		ERR(sh, "Unable to open %s\n", path);
+		ERR(sh, "Unable to open %s.", path);
 		return -1;
 	}
 
 	file = fdopen(fd, "r");
 	if (file == NULL) {
-		ERR(sh, "Unable to open %s\n", path);
+		ERR(sh, "Unable to open %s.", path);
 		close(fd);
 		return -1;
 	}
diff --git a/libsemanage/src/database_file.c b/libsemanage/src/database_file.c
index a54c5aee..47814254 100644
--- a/libsemanage/src/database_file.c
+++ b/libsemanage/src/database_file.c
@@ -130,8 +130,8 @@ static int dbase_file_flush(semanage_handle_t * handle, dbase_file_t * dbase)
 	str = fopen(fname, "we");
 	umask(mask);
 	if (!str) {
-		ERR(handle, "could not open %s for writing: %s",
-		    fname, strerror(errno));
+		ERR(handle, "could not open %s for writing",
+		    fname);
 		goto err;
 	}
 	__fsetlocking(str, FSETLOCKING_BYCALLER);
diff --git a/libsemanage/src/database_policydb.c b/libsemanage/src/database_policydb.c
index 62467d15..3c346ad7 100644
--- a/libsemanage/src/database_policydb.c
+++ b/libsemanage/src/database_policydb.c
@@ -113,8 +113,8 @@ static int dbase_policydb_cache(semanage_handle_t * handle,
 	 * ENOENT is not fatal - we just create an empty policydb */
 	fp = fopen(fname, "rbe");
 	if (fp == NULL && errno != ENOENT) {
-		ERR(handle, "could not open %s for reading: %s",
-		    fname, strerror(errno));
+		ERR(handle, "could not open %s for reading",
+		    fname);
 		goto err;
 	}
 
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index a271a576..0e7ef4da 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -313,7 +313,7 @@ int semanage_direct_connect(semanage_handle_t * sh)
 		/* The file does not exist */
 		sepol_set_disable_dontaudit(sh->sepolh, 0);
 	} else {
-		ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+		ERR(sh, "Unable to access %s.", path);
 		goto err;
 	}
 
@@ -592,7 +592,7 @@ static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_len, int
 	}
 	data_read = malloc(max_len * sizeof(*data_read));
 	if (data_read == NULL) {
-		ERR(sh, "Failed to malloc, out of memory.\n");
+		ERR(sh, "Failed to malloc, out of memory.");
 		return -1;
 	}
 
@@ -604,7 +604,7 @@ static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_len, int
 			max_len *= 2;
 			tmp = realloc(data_read, max_len);
 			if (tmp == NULL) {
-				ERR(sh, "Failed to realloc, out of memory.\n");
+				ERR(sh, "Failed to realloc, out of memory.");
 				free(data_read);
 				return -1;
 			}
@@ -646,93 +646,93 @@ static int semanage_pipe_data(semanage_handle_t *sh, const char *path, const cha
 
 	retval = pipe2(input_fd, O_CLOEXEC);
 	if (retval == -1) {
-		ERR(sh, "Unable to create pipe for input pipe: %s\n", strerror(errno));
+		ERR(sh, "Unable to create pipe for input pipe.");
 		goto cleanup;
 	}
 	retval = pipe2(output_fd, O_CLOEXEC);
 	if (retval == -1) {
-		ERR(sh, "Unable to create pipe for output pipe: %s\n", strerror(errno));
+		ERR(sh, "Unable to create pipe for output pipe.");
 		goto cleanup;
 	}
 	retval = pipe2(err_fd, O_CLOEXEC);
 	if (retval == -1) {
-		ERR(sh, "Unable to create pipe for error pipe: %s\n", strerror(errno));
+		ERR(sh, "Unable to create pipe for error pipe.");
 		goto cleanup;
 	}
 
 	pid = fork();
 	if (pid == -1) {
-		ERR(sh, "Unable to fork from parent: %s.", strerror(errno));
+		ERR(sh, "Unable to fork from parent.");
 		retval = -1;
 		goto cleanup;
 	} else if (pid == 0) {
 		retval = dup2(input_fd[PIPE_READ], STDIN_FILENO);
 		if (retval == -1) {
-			ERR(sh, "Unable to dup2 input pipe: %s\n", strerror(errno));
+			ERR(sh, "Unable to dup2 input pipe.");
 			goto cleanup;
 		}
 		retval = dup2(output_fd[PIPE_WRITE], STDOUT_FILENO);
 		if (retval == -1) {
-			ERR(sh, "Unable to dup2 output pipe: %s\n", strerror(errno));
+			ERR(sh, "Unable to dup2 output pipe.");
 			goto cleanup;
 		}
 		retval = dup2(err_fd[PIPE_WRITE], STDERR_FILENO);
 		if (retval == -1) {
-			ERR(sh, "Unable to dup2 error pipe: %s\n", strerror(errno));
+			ERR(sh, "Unable to dup2 error pipe.");
 			goto cleanup;
 		}
 
 		retval = close(input_fd[PIPE_WRITE]);
 		if (retval == -1) {
-			ERR(sh, "Unable to close input pipe: %s\n", strerror(errno));
+			ERR(sh, "Unable to close input pipe.");
 			goto cleanup;
 		}
 		retval = close(output_fd[PIPE_READ]);
 		if (retval == -1) {
-			ERR(sh, "Unable to close output pipe: %s\n", strerror(errno));
+			ERR(sh, "Unable to close output pipe.");
 			goto cleanup;
 		}
 		retval = close(err_fd[PIPE_READ]);
 		if (retval == -1) {
-			ERR(sh, "Unable to close error pipe: %s\n", strerror(errno));
+			ERR(sh, "Unable to close error pipe.");
 			goto cleanup;
 		}
 		retval = execl(path, path, NULL);
 		if (retval == -1) {
-			ERR(sh, "Unable to execute %s : %s\n", path, strerror(errno));
+			ERR(sh, "Unable to execute %s.", path);
 			_exit(EXIT_FAILURE);
 		}
 	} else {
 		retval = close(input_fd[PIPE_READ]);
 		input_fd[PIPE_READ] = -1;
 		if (retval == -1) {
-			ERR(sh, "Unable to close read end of input pipe: %s\n", strerror(errno));
+			ERR(sh, "Unable to close read end of input pipe.");
 			goto cleanup;
 		}
 
 		retval = close(output_fd[PIPE_WRITE]);
 		output_fd[PIPE_WRITE] = -1;
 		if (retval == -1) {
-			ERR(sh, "Unable to close write end of output pipe: %s\n", strerror(errno));
+			ERR(sh, "Unable to close write end of output pipe.");
 			goto cleanup;
 		}
 
 		retval = close(err_fd[PIPE_WRITE]);
 		err_fd[PIPE_WRITE] = -1;
 		if (retval == -1) {
-			ERR(sh, "Unable to close write end of error pipe: %s\n", strerror(errno));
+			ERR(sh, "Unable to close write end of error pipe.");
 			goto cleanup;
 		}
 
 		retval = write_full(input_fd[PIPE_WRITE], in_data, in_data_len);
 		if (retval == -1) {
-			ERR(sh, "Failed to write data to input pipe: %s\n", strerror(errno));
+			ERR(sh, "Failed to write data to input pipe.");
 			goto cleanup;
 		}
 		retval = close(input_fd[PIPE_WRITE]);
 		input_fd[PIPE_WRITE] = -1;
 		if (retval == -1) {
-			ERR(sh, "Unable to close write end of input pipe: %s\n", strerror(errno));
+			ERR(sh, "Unable to close write end of input pipe.");
 			goto cleanup;
 		}
 
@@ -744,7 +744,7 @@ static int semanage_pipe_data(semanage_handle_t *sh, const char *path, const cha
 		retval = close(output_fd[PIPE_READ]);
 		output_fd[PIPE_READ] = -1;
 		if (retval == -1) {
-			ERR(sh, "Unable to close read end of output pipe: %s\n", strerror(errno));
+			ERR(sh, "Unable to close read end of output pipe.");
 			goto cleanup;
 		}
 
@@ -756,7 +756,7 @@ static int semanage_pipe_data(semanage_handle_t *sh, const char *path, const cha
 		retval = close(err_fd[PIPE_READ]);
 		err_fd[PIPE_READ] = -1;
 		if (retval == -1) {
-			ERR(sh, "Unable to close read end of error pipe: %s\n", strerror(errno));
+			ERR(sh, "Unable to close read end of error pipe.");
 			goto cleanup;
 		}
 
@@ -923,7 +923,7 @@ static int semanage_compile_module(semanage_handle_t *sh,
 
 	status = map_compressed_file(sh, hll_path, &hll_contents);
 	if (status < 0) {
-		ERR(sh, "Unable to read file %s\n", hll_path);
+		ERR(sh, "Unable to read file %s.", hll_path);
 		goto cleanup;
 	}
 
@@ -933,16 +933,13 @@ static int semanage_compile_module(semanage_handle_t *sh,
 	if (err_data_len > 0) {
 		for (start = end = err_data; end < err_data + err_data_len; end++) {
 			if (*end == '\n') {
-				fprintf(stderr, "%s: ", modinfo->name);
-				fwrite(start, 1, end - start + 1, stderr);
+				ERR(sh, "%s: %.*s.", modinfo->name, (int)(end - start + 1), start);
 				start = end + 1;
 			}
 		}
 
 		if (end != start) {
-			fprintf(stderr, "%s: ", modinfo->name);
-			fwrite(start, 1, end - start, stderr);
-			fprintf(stderr, "\n");
+			ERR(sh, "%s: %.*s.", modinfo->name, (int)(end - start), start);
 		}
 	}
 	if (status != 0) {
@@ -956,14 +953,14 @@ static int semanage_compile_module(semanage_handle_t *sh,
 
 	status = write_compressed_file(sh, cil_path, cil_data, cil_data_len);
 	if (status == -1) {
-		ERR(sh, "Failed to write %s\n", cil_path);
+		ERR(sh, "Failed to write %s.", cil_path);
 		goto cleanup;
 	}
 
 	if (sh->conf->remove_hll == 1) {
 		status = unlink(hll_path);
 		if (status != 0) {
-			ERR(sh, "Error while removing HLL file %s: %s", hll_path, strerror(errno));
+			ERR(sh, "Error while removing HLL file %s.", hll_path);
 			goto cleanup;
 		}
 
@@ -1054,8 +1051,7 @@ static int semanage_compile_hll_modules(semanage_handle_t *sh,
 				unmap_compressed_file(&contents);
 				continue;
 			} else if (errno != ENOENT) {
-				ERR(sh, "Unable to access %s: %s\n", cil_path,
-				    strerror(errno));
+				ERR(sh, "Unable to access %s.", cil_path);
 				return -1; //an error in the "stat" call
 			}
 		}
@@ -1080,7 +1076,7 @@ static int semanage_compare_checksum(semanage_handle_t *sh, const char *referenc
 	fd = open(path, O_RDONLY | O_CLOEXEC);
 	if (fd == -1) {
 		if (errno != ENOENT) {
-			ERR(sh, "Unable to open %s: %s\n", path, strerror(errno));
+			ERR(sh, "Unable to open %s.", path);
 			return -1;
 		}
 		/* Checksum file not present - force a rebuild. */
@@ -1088,21 +1084,21 @@ static int semanage_compare_checksum(semanage_handle_t *sh, const char *referenc
 	}
 
 	if (fstat(fd, &sb) == -1) {
-		ERR(sh, "Unable to stat %s\n", path);
+		ERR(sh, "Unable to stat %s.", path);
 		retval = -1;
 		goto out_close;
 	}
 
 	if (sb.st_size != (off_t)CHECKSUM_CONTENT_SIZE) {
 		/* Incompatible/invalid hash type - just force a rebuild. */
-		WARN(sh, "Module checksum invalid - forcing a rebuild\n");
+		WARN(sh, "Module checksum invalid - forcing a rebuild.");
 		retval = 1;
 		goto out_close;
 	}
 
 	data = mmap(NULL, CHECKSUM_CONTENT_SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (data == MAP_FAILED) {
-		ERR(sh, "Unable to mmap %s\n", path);
+		ERR(sh, "Unable to mmap %s.", path);
 		retval = -1;
 		goto out_close;
 	}
@@ -1212,7 +1208,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		/* The file does not exist */
 		do_rebuild |= (sepol_get_disable_dontaudit(sh->sepolh) == 1);
 	} else {
-		ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+		ERR(sh, "Unable to access %s.", path);
 		retval = -1;
 		goto cleanup;
 	}
@@ -1243,7 +1239,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		/* The file does not exist */
 		do_rebuild |= (sepol_get_preserve_tunables(sh->sepolh) == 1);
 	} else {
-		ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+		ERR(sh, "Unable to access %s.", path);
 		retval = -1;
 		goto cleanup;
 	}
@@ -1279,7 +1275,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		path = semanage_path(SEMANAGE_TMP, semanage_computed_files[i]);
 		if (stat(path, &sb) != 0) {
 			if (errno != ENOENT) {
-				ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+				ERR(sh, "Unable to access %s.", path);
 				retval = -1;
 				goto cleanup;
 			}
@@ -1309,7 +1305,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		retval = semanage_compile_hll_modules(sh, modinfos, num_modinfos,
 						      &extra, modules_checksum);
 		if (retval < 0) {
-			ERR(sh, "Failed to compile hll files into cil files.\n");
+			ERR(sh, "Failed to compile hll files into cil files.");
 			goto cleanup;
 		}
 
@@ -1322,7 +1318,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 
 		retval = semanage_write_modules_checksum(sh, modules_checksum);
 		if (retval < 0) {
-			ERR(sh, "Failed to write module checksum file.\n");
+			ERR(sh, "Failed to write module checksum file.");
 			goto cleanup;
 		}
 	}
@@ -1444,7 +1440,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 			/* The file does not exist */
 			pseusers->dtable->clear(sh, pseusers->dbase);
 		} else {
-			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+			ERR(sh, "Unable to access %s.", path);
 			retval = -1;
 			goto cleanup;
 		}
@@ -1462,7 +1458,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 			/* The file does not exist */
 			pusers_extra->dtable->clear(sh, pusers_extra->dbase);
 		} else {
-			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+			ERR(sh, "Unable to access %s.", path);
 			retval = -1;
 			goto cleanup;
 		}
@@ -1733,13 +1729,13 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 
 	retval = map_compressed_file(sh, install_filename, &contents);
 	if (retval < 0) {
-		ERR(sh, "Unable to read file %s\n", install_filename);
+		ERR(sh, "Unable to read file %s.", install_filename);
 		goto cleanup;
 	}
 
 	path = strdup(install_filename);
 	if (path == NULL) {
-		ERR(sh, "No memory available for strdup.\n");
+		ERR(sh, "No memory available for strdup.");
 		retval = -1;
 		goto cleanup;
 	}
@@ -1780,12 +1776,12 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 	if (module_name == NULL) {
 		module_name = strdup(filename);
 		if (module_name == NULL) {
-			ERR(sh, "No memory available for module_name.\n");
+			ERR(sh, "No memory available for module_name.");
 			retval = -1;
 			goto cleanup;
 		}
 	} else if (strcmp(module_name, filename) != 0) {
-		fprintf(stderr, "Warning: SELinux userspace will refer to the module from %s as %s rather than %s\n", install_filename, module_name, filename);
+		ERR(sh, "Warning: SELinux userspace will refer to the module from %s as %s rather than %s.", install_filename, module_name, filename);
 	}
 
 	retval = semanage_direct_install(sh, contents.data, contents.len,
@@ -1826,7 +1822,7 @@ static int semanage_direct_extract(semanage_handle_t * sh,
 	}
 
 	if (stat(module_path, &sb) != 0) {
-		ERR(sh, "Unable to access %s: %s\n", module_path, strerror(errno));
+		ERR(sh, "Unable to access %s.", module_path);
 		rc = -1;
 		goto cleanup;
 	}
@@ -1857,7 +1853,7 @@ static int semanage_direct_extract(semanage_handle_t * sh,
 
 	if (extract_cil == 1 && strcmp(_modinfo->lang_ext, "cil") && stat(input_file, &sb) != 0) {
 		if (errno != ENOENT) {
-			ERR(sh, "Unable to access %s: %s\n", input_file, strerror(errno));
+			ERR(sh, "Unable to access %s.", input_file);
 			rc = -1;
 			goto cleanup;
 		}
@@ -2017,7 +2013,7 @@ static int semanage_direct_get_enabled(semanage_handle_t *sh,
 
 	if (stat(path, &sb) < 0) {
 		if (errno != ENOENT) {
-			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+			ERR(sh, "Unable to access %s.", path);
 			status = -1;
 			goto cleanup;
 		}
@@ -2350,7 +2346,7 @@ static int semanage_direct_get_module_info(semanage_handle_t *sh,
 	/* set enabled/disabled status */
 	if (stat(fn, &sb) < 0) {
 		if (errno != ENOENT) {
-			ERR(sh, "Unable to access %s: %s\n", fn, strerror(errno));
+			ERR(sh, "Unable to access %s.", fn);
 			status = -1;
 			goto cleanup;
 		}
@@ -2779,7 +2775,7 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
 	/* validate module info */
 	ret = semanage_module_info_validate(modinfo);
 	if (ret != 0) {
-		ERR(sh, "%s failed module validation.\n", modinfo->name);
+		ERR(sh, "%s failed module validation.", modinfo->name);
 		status = -2;
 		goto cleanup;
 	}
@@ -2867,7 +2863,7 @@ static int semanage_direct_install_info(semanage_handle_t *sh,
 		if (stat(path, &sb) == 0) {
 			ret = unlink(path);
 			if (ret != 0) {
-				ERR(sh, "Error while removing cached CIL file %s: %s", path, strerror(errno));
+				ERR(sh, "Error while removing cached CIL file %s.", path);
 				status = -3;
 				goto cleanup;
 			}
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index c38d284b..4949bc75 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1117,7 +1117,7 @@ static int get_group_users(genhomedircon_settings_t * s,
 		goto cleanup;
 
 	if (group == NULL) {
-		ERR(s->h_semanage, "Can't find group named %s\n", grname);
+		ERR(s->h_semanage, "Can't find group named %s.", grname);
 		goto cleanup;
 	}
 
diff --git a/libsemanage/src/handle.c b/libsemanage/src/handle.c
index 2f4121db..faea0606 100644
--- a/libsemanage/src/handle.c
+++ b/libsemanage/src/handle.c
@@ -151,7 +151,7 @@ int semanage_get_hll_compiler_path(semanage_handle_t *sh,
 
 	lower_lang_ext = strdup(lang_ext);
 	if (lower_lang_ext == NULL) {
-		ERR(sh, "Could not create copy of lang_ext. Out of memory.\n");
+		ERR(sh, "Could not create copy of lang_ext. Out of memory.");
 		status = -1;
 		goto cleanup;
 	}
diff --git a/libsemanage/src/parse_utils.c b/libsemanage/src/parse_utils.c
index d1d6e930..cf6a91fa 100644
--- a/libsemanage/src/parse_utils.c
+++ b/libsemanage/src/parse_utils.c
@@ -47,8 +47,8 @@ int parse_open(semanage_handle_t * handle, parse_info_t * info)
 
 	info->file_stream = fopen(info->filename, "re");
 	if (!info->file_stream && (errno != ENOENT)) {
-		ERR(handle, "could not open file %s: %s",
-		    info->filename, strerror(errno));
+		ERR(handle, "could not open file %s.",
+		    info->filename);
 		return STATUS_ERR;
 	}
 	if (info->file_stream)
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index d75aab68..cdb495cb 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1551,7 +1551,7 @@ static int sefcontext_compile(semanage_handle_t * sh, const char *path) {
 
 	if (stat(path, &sb) < 0) {
 		if (errno != ENOENT) {
-			ERR(sh, "Unable to access %s: %s\n", path, strerror(errno));
+			ERR(sh, "Unable to access %s.", path);
 			return -1;
 		}
 
@@ -1737,11 +1737,11 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 	/* sync changes in sandbox to filesystem */
 	fd = open(sandbox, O_DIRECTORY | O_CLOEXEC);
 	if (fd == -1) {
-		ERR(sh, "Error while opening %s for syncfs(): %d", sandbox, errno);
+		ERR(sh, "Error while opening %s for syncfs().", sandbox);
 		return -1;
 	}
 	if (syncfs(fd) == -1) {
-		ERR(sh, "Error while syncing %s to filesystem: %d", sandbox, errno);
+		ERR(sh, "Error while syncing %s to filesystem.", sandbox);
 		close(fd);
 		return -1;
 	}
-- 
2.45.2

