Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CBF19F40B
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334644; cv=none; b=GYASPDIqwQsrx9qBIv8b8z8hUhvhKOCAfFDrniUcedcF9Cmd39QJyka21rvPyyjLHh3ntvm6WXudOPupuT0qPnJHGdsT4mWaAchV3N3EVbaHECV0y2fstbRnNZ/hNRF4rCgUUW4w0o6oR4qielhhi7ZRbdOqJgUzbIkFRBCtatc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334644; c=relaxed/simple;
	bh=J7cClXYUb42bTY6cfWKfzMv4BOMAKLmlAtGBT0ex4mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0jZshoUx3QRQ2/3ok+PJQ7xgCS5OY3dt8yFraf09KYG7UZVeG7g369e9J/bpSMn3e2DEChGXO/GghRfOzQeJzYBAk9cKLTp7rGjMjUYVc6/6ksxynoDFla+4sZ6bQJDVQaivf+xC7eAdIvqotey+iSZ4Jonk9b/miWdjHctuDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=fsrPfnoe; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="fsrPfnoe"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334637;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orNI8J48+YhCYxBBaTtNLr4E87A//lL/3P9E5bYyOIM=;
	b=fsrPfnoeCF8fYSirReVpkhwDPVXYaX2VvzrN8F2H2dtlaecW/P+bdGpSI5Ze7bWOuLenkd
	jbdxp3aNUynwxlgNeaw9HaI4Xar10AOdOqpT0OKqP8ymkj4YQPHWr0OEdvmKrZRwc/5DUY
	zskLnREvxXnUwNxcNOfupTce6doQzPuby/iEVaqapVJIVye80eLh22PeTv6NMcIPwRueCl
	mvz9V9GVylXErfM03Eo1FTEV4gXtg2+Wp1MJ7iiuVFSsS3KJxH61U3gWoGh7E4cR1XkxE0
	emqxAlI/O/TgPS5UxOaG4RFGVkpHffF36rfEoqcYr5+EBk71hzPH4OhX0ZR6PA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 25/47] libsemanage: introduce write_full wrapper
Date: Mon, 11 Nov 2024 15:16:44 +0100
Message-ID: <20241111141706.38039-25-cgoettsche@seltendoof.de>
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

write(2) can return early with the input buffer only partially written.
Add a wrapper to call write(2) until the full buffer has been written or
an error has occurred.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/direct_api.c     |  4 ++--
 libsemanage/src/semanage_store.c |  8 ++++----
 libsemanage/src/utilities.c      | 22 ++++++++++++++++++++++
 libsemanage/src/utilities.h      | 13 +++++++++++++
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index a262fe09..aa1485e3 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -462,7 +462,7 @@ static int write_file(semanage_handle_t * sh,
 		ERR(sh, "Could not open %s for writing.", filename);
 		return -1;
 	}
-	if (write(out, data, num_bytes) == -1) {
+	if (write_full(out, data, num_bytes) == -1) {
 		ERR(sh, "Error while writing to %s.", filename);
 		close(out);
 		return -1;
@@ -724,7 +724,7 @@ static int semanage_pipe_data(semanage_handle_t *sh, char *path, char *in_data,
 			goto cleanup;
 		}
 
-		retval = write(input_fd[PIPE_WRITE], in_data, in_data_len);
+		retval = write_full(input_fd[PIPE_WRITE], in_data, in_data_len);
 		if (retval == -1) {
 			ERR(sh, "Failed to write data to input pipe: %s\n", strerror(errno));
 			goto cleanup;
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index c9bb9c97..cb5bc149 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -739,7 +739,7 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode,
 	}
 	umask(mask);
 	while (retval == 0 && (amount_read = read(in, buf, sizeof(buf))) > 0) {
-		if (write(out, buf, amount_read) != amount_read) {
+		if (write_full(out, buf, amount_read) == -1) {
 			if (errno)
 				errsv = errno;
 			else
@@ -1555,14 +1555,14 @@ int semanage_split_fc(semanage_handle_t * sh)
 		    !strncmp(buf, "HOME_ROOT", 9) || strstr(buf, "ROLE") ||
 		    strstr(buf, "USER")) {
 			/* This contains one of the template variables, write it to homedir.template */
-			if (write(hd, buf, strlen(buf)) < 0) {
+			if (write_full(hd, buf, strlen(buf)) < 0) {
 				ERR(sh, "Write to %s failed.",
 				    semanage_path(SEMANAGE_TMP,
 						  SEMANAGE_HOMEDIR_TMPL));
 				goto cleanup;
 			}
 		} else {
-			if (write(fc, buf, strlen(buf)) < 0) {
+			if (write_full(fc, buf, strlen(buf)) < 0) {
 				ERR(sh, "Write to %s failed.",
 				    semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC));
 				goto cleanup;
@@ -1764,7 +1764,7 @@ static int semanage_commit_sandbox(semanage_handle_t * sh)
 		    commit_filename);
 		return -1;
 	}
-	amount_written = write(fd, write_buf, sizeof(write_buf));
+	amount_written = write_full(fd, write_buf, sizeof(write_buf));
 	if (amount_written == -1) {
 		ERR(sh, "Error while writing commit number to %s.",
 		    commit_filename);
diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index 3702cbe1..4beccb5b 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -25,6 +25,7 @@
 #include <ctype.h>
 #include <string.h>
 #include <sys/types.h>
+#include <unistd.h>
 #include <assert.h>
 
 #define TRUE 1
@@ -328,3 +329,24 @@ semanage_list_t *semanage_slurp_file_filter(FILE * file,
 
 	return head.next;
 }
+
+int write_full(int fd, const void *buf, size_t len)
+{
+	ssize_t w;
+	const unsigned char *p = buf;
+
+	while (len > 0) {
+		w = write(fd, p, len);
+		if (w == -1) {
+			if (errno == EINTR)
+				continue;
+
+			return -1;
+		}
+
+		p += w;
+		len -= (size_t)w;
+	}
+
+	return 0;
+}
diff --git a/libsemanage/src/utilities.h b/libsemanage/src/utilities.h
index 6bbe9f5b..78f1f96e 100644
--- a/libsemanage/src/utilities.h
+++ b/libsemanage/src/utilities.h
@@ -144,4 +144,17 @@ void semanage_keep_until_space(char *data);
 semanage_list_t *semanage_slurp_file_filter(FILE * file,
 					    int (*pred) (const char *))
     WARN_UNUSED;
+
+/**
+ * Wrapper around write(2), which retries on short writes.
+ *
+ * @param fd   file descriptor to write to
+ * @param buf  buffer to be written
+ * @param len  number of bytes to be written from buffer
+ *
+ * @return 0 on success, -1 else (with errno set)
+ */
+
+int write_full(int fd, const void *buf, size_t len) WARN_UNUSED;
+
 #endif
-- 
2.45.2

