Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73791586C8
	for <selinux@vger.kernel.org>; Sat,  5 Apr 2025 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743872105; cv=none; b=j4fpCN8sx88mOxNKceRMpc/pyoQnu8m6Od2FoVf77+MgX59eZcyT7BazzkSovI8leSES+ioy1fnXcMXPl0QIblGbX/Lk8hdE3ZGKT9DPSsRfeBvjnRb2RO/0YmG9j5CCq4Z6gUnnwVsEvAanf9s4S4IND03ZPGMXE1k//k2hefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743872105; c=relaxed/simple;
	bh=ibpUuLO+81o+HmRRJ9ZOo6Uq6kNuH5C9qXv6srCAi3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hZvOvhfgFxhpqLzLqEG7mk4+MNkRvw0weE0TzwZVzPkU7hec+ajHg2HW+DG1mIFDgGF+OSi9kR/xc/0sD3B9p6Tu9I2jzE/e/dW/gSNB92wPluyEo9wZ53CbCdIEtoR+T8EKJIBEZU16Aq+LsR5EWkQ5io+BzsXWaM5J1BFYo7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=bZgQhQne; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="bZgQhQne"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1743871561;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=MiaMXumGfkye2J1VfAvXGxt+vGHFEJXJn99MRnvTAYM=;
	b=bZgQhQnebtj/molqmt1yJkrb307BmvYBPsrSHq0ub8CWCPVSzrGlGG5jIsPi+6SswSJshN
	yWO7URkfQwvGsjiiS6/lirgP5NRyPAqigF2ca14rhTd+nFUlVCxgRVvhJdFZv+TOgBD0tv
	U0I516sSW82DnScstans78gNa3m5al5xz+PMlEdbbCWLd5uOaApY1ic/Bt5YbOmxHwQzWO
	M5rjzteuVs1jastdGqvJ7mMn8kLzR/7RhLChTweYl1wLFv9EDdHfpkTp2bFpBRiFK62txX
	3/Rz0dTarjk1Vp848xkLT0Mw41GiR9zjEOatH+5Jd73OKaQY2OH99QBh6WILYQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libsemanage: fix handling errors during child execution
Date: Sat,  5 Apr 2025 18:45:56 +0200
Message-ID: <20250405164557.107583-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

* Continue on pipe handling errors in parent to wait on the child and
  collect possible error messages from it
* Always exit on errors in child, do not return from function
* Improve error reporting in semanage_compile_module() by hiding local
  errno value and stripping duplicate newline
* Use redirected stderr file descriptor in child error handling

With these changes execution failures change from

    libsemanage.semanage_pipe_data: Failed to write data to input pipe. (Broken pipe).
    libsemanage.semanage_direct_commit: Failed to compile hll files into cil files. (Broken pipe).
    /usr/sbin/semodule:  Failed!

to

    libsemanage.semanage_pipe_data: Failed to write data to input pipe. (Broken pipe).
    libsemanage.semanage_pipe_data: Child process /usr/libexec/selinux/hll2//pp failed with code: 1. (No data available).
    libsemanage.semanage_compile_module: accountsservice: libsemanage.semanage_pipe_data: Unable to execute /usr/libexec/selinux/hll2//pp. (No such file or directory)..
    libsemanage.semanage_direct_commit: Failed to compile hll files into cil files. (No data available).
    /tmp/destdir//usr/sbin/semodule:  Failed!

Improves: 76cdfa78 ("libsemanage: introduce write_full wrapper")
Fixes: cae4a4c9 ("libsemanage: add support for HLL to CIL compilers")
Related: https://github.com/SELinuxProject/selinux/issues/467
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/direct_api.c | 79 +++++++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 24 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 99cba7f7..d9540d53 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -621,6 +621,23 @@ static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_len, int
 	return 0;
 }
 
+// Forward error messages to redirected stderr pipe
+#define ERR_CHILD_STDERR(handle, ...) \
+	{ \
+		char buf[2048]; \
+		int errsv = errno, n; \
+		(void)! write_full(err_fd[PIPE_WRITE], "libsemanage.semanage_pipe_data: ", strlen("libsemanage.semanage_pipe_data: ")); \
+		n = snprintf(buf, sizeof(buf), __VA_ARGS__); \
+		(void)! write_full(err_fd[PIPE_WRITE], buf, n); \
+		if (errsv) { \
+			errno = errsv; \
+			n = snprintf(buf, sizeof(buf), " (%m)."); \
+			(void)! write_full(err_fd[PIPE_WRITE], buf, n); \
+		} \
+		(void)! write_full(err_fd[PIPE_WRITE], "\n", strlen("\n")); \
+		(void)! fsync(err_fd[PIPE_WRITE]); \
+	}
+
 static int semanage_pipe_data(semanage_handle_t *sh, const char *path, const char *in_data, size_t in_data_len, char **out_data, size_t *out_data_len, char **err_data, size_t *err_data_len)
 {
 	int input_fd[2] = {-1, -1};
@@ -672,97 +689,100 @@ static int semanage_pipe_data(semanage_handle_t *sh, const char *path, const cha
 		retval = dup2(input_fd[PIPE_READ], STDIN_FILENO);
 		if (retval == -1) {
 			ERR(sh, "Unable to dup2 input pipe.");
-			goto cleanup;
+			goto child_err;
 		}
 		retval = dup2(output_fd[PIPE_WRITE], STDOUT_FILENO);
 		if (retval == -1) {
 			ERR(sh, "Unable to dup2 output pipe.");
-			goto cleanup;
+			goto child_err;
 		}
 		retval = dup2(err_fd[PIPE_WRITE], STDERR_FILENO);
 		if (retval == -1) {
 			ERR(sh, "Unable to dup2 error pipe.");
-			goto cleanup;
+			goto child_err;
 		}
 
 		retval = close(input_fd[PIPE_WRITE]);
 		if (retval == -1) {
-			ERR(sh, "Unable to close input pipe.");
-			goto cleanup;
+			ERR_CHILD_STDERR(sh, "Unable to close input pipe.");
+			goto child_err;
 		}
 		retval = close(output_fd[PIPE_READ]);
 		if (retval == -1) {
-			ERR(sh, "Unable to close output pipe.");
-			goto cleanup;
+			ERR_CHILD_STDERR(sh, "Unable to close output pipe.");
+			goto child_err;
 		}
 		retval = close(err_fd[PIPE_READ]);
 		if (retval == -1) {
-			ERR(sh, "Unable to close error pipe.");
-			goto cleanup;
-		}
-		retval = execl(path, path, NULL);
-		if (retval == -1) {
-			ERR(sh, "Unable to execute %s.", path);
-			_exit(EXIT_FAILURE);
+			ERR_CHILD_STDERR(sh, "Unable to close error pipe.");
+			goto child_err;
 		}
+		execl(path, path, NULL);
+		ERR_CHILD_STDERR(sh, "Unable to execute %s.", path);
+
+child_err:
+		_exit(EXIT_FAILURE);
 	} else {
+		int any_err = 0;
+
 		retval = close(input_fd[PIPE_READ]);
 		input_fd[PIPE_READ] = -1;
 		if (retval == -1) {
 			ERR(sh, "Unable to close read end of input pipe.");
-			goto cleanup;
+			any_err = 1;
 		}
 
 		retval = close(output_fd[PIPE_WRITE]);
 		output_fd[PIPE_WRITE] = -1;
 		if (retval == -1) {
 			ERR(sh, "Unable to close write end of output pipe.");
-			goto cleanup;
+			any_err = 1;
 		}
 
 		retval = close(err_fd[PIPE_WRITE]);
 		err_fd[PIPE_WRITE] = -1;
 		if (retval == -1) {
 			ERR(sh, "Unable to close write end of error pipe.");
-			goto cleanup;
+			any_err = 1;
 		}
 
 		retval = write_full(input_fd[PIPE_WRITE], in_data, in_data_len);
 		if (retval == -1) {
 			ERR(sh, "Failed to write data to input pipe.");
-			goto cleanup;
+			any_err = 1;
 		}
 		retval = close(input_fd[PIPE_WRITE]);
 		input_fd[PIPE_WRITE] = -1;
 		if (retval == -1) {
 			ERR(sh, "Unable to close write end of input pipe.");
-			goto cleanup;
+			any_err = 1;
 		}
 
 		initial_len = 1 << 17;
 		retval = read_from_pipe_to_data(sh, initial_len, output_fd[PIPE_READ], &data_read, &data_read_len);
 		if (retval != 0) {
-			goto cleanup;
+			any_err = 1;
 		}
 		retval = close(output_fd[PIPE_READ]);
 		output_fd[PIPE_READ] = -1;
 		if (retval == -1) {
 			ERR(sh, "Unable to close read end of output pipe.");
-			goto cleanup;
+			any_err = 1;
 		}
 
 		initial_len = 1 << 9;
 		retval = read_from_pipe_to_data(sh, initial_len, err_fd[PIPE_READ], &err_data_read, &err_data_read_len);
 		if (retval != 0) {
-			goto cleanup;
+			any_err = 1;
 		}
 		retval = close(err_fd[PIPE_READ]);
 		err_fd[PIPE_READ] = -1;
 		if (retval == -1) {
 			ERR(sh, "Unable to close read end of error pipe.");
-			goto cleanup;
+			any_err = 1;
 		}
 
+		errno = ENODATA;
 		if (waitpid(pid, &status, 0) == -1 || !WIFEXITED(status)) {
 			ERR(sh, "Child process %s did not exit cleanly.", path);
 			retval = -1;
@@ -773,6 +793,11 @@ static int semanage_pipe_data(semanage_handle_t *sh, const char *path, const cha
 			retval = -1;
 			goto cleanup;
 		}
+
+		if (any_err) {
+			retval = -1;
+			goto cleanup;
+		}
 	}
 
 	retval = 0;
@@ -934,9 +959,13 @@ static int semanage_compile_module(semanage_handle_t *sh,
 				    hll_contents.len, &cil_data, &cil_data_len,
 				    &err_data, &err_data_len);
 	if (err_data_len > 0) {
+		int errsv = errno;
+
+		errno = 0;
+
 		for (start = end = err_data; end < err_data + err_data_len; end++) {
 			if (*end == '\n') {
-				ERR(sh, "%s: %.*s.", modinfo->name, (int)(end - start + 1), start);
+				ERR(sh, "%s: %.*s.", modinfo->name, (int)(end - start), start);
 				start = end + 1;
 			}
 		}
@@ -944,6 +973,8 @@ static int semanage_compile_module(semanage_handle_t *sh,
 		if (end != start) {
 			ERR(sh, "%s: %.*s.", modinfo->name, (int)(end - start), start);
 		}
+
+		errno = errsv;
 	}
 	if (status != 0) {
 		goto cleanup;
-- 
2.49.0

