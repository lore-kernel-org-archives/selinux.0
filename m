Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C8C431E5D
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572192; cv=none; b=cCo7+55zJpGUHJU6afHPwJymtSQTpenpgImVWRFUgPdrkOITfM9QGLN+eCoVSTyaFHU2taU1eau41gSVtUyRHChj5oYnILCSaPdTZsWFagPwWq1KnM7wz7hWG+RcqBHrrQh17zZboCEyqC8roz2Cl5yBmbxnrmmKySiiCcO5RKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572192; c=relaxed/simple;
	bh=3xEczBn0Oq5eEJEUYpOvZ2KwYWokMDsu6pAaQ/47q+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/8+iNupAQFDEcLZvlp3aa80EUK6eE2hXeM7ttGiJgcl4LPdZBXEr6GKoLQ+Hawii2Ur+LJi1qX6mq3awddRXu8vug9UasWKXZSNtJ8YtpVPyCbbbDP0gdmnMwmqWsE/F1cOQMWRX+m4ldHJoWdDUXvseyA0tzqidxvo05qoDmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZz561g+; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZz561g+"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e5c92c389so684251085a.3
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784572190; x=1785176990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k/sIXPbgs68Vv2fA0JCr576rJYtKPaDAlTvBBlg76nM=;
        b=FZz561g+iUxpXMO5kKV9ZWyQLGvHOfWq9uo8/S5NRV/IoV2fO/+EjgTP2fbljzmhZi
         o3jJz4L4uzBAZ05fGv4WvQ5Q69WEE9Q0iRQmqKRSC5ONRj3jxDHEKbIF+leSc10e2NWM
         hRpZ4UKr5aVtRVMLU5se21a10UfY8BIizhTEHddIKw3+b6kuLjiN4UU49/FdstHV+eYi
         S3iX/+3/eb1NY+d194ONp3Nmpa1AUOf4DDnjSe8mxEWLypHdOHxcHUEcdMD23lqqdnHH
         TuIXZidqAyJmpbQu/Js+RfoI/gb97LBPGlGhPoSdIBiM7NP0dw2ILEgNJxNKtXxnCu8I
         xKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784572190; x=1785176990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k/sIXPbgs68Vv2fA0JCr576rJYtKPaDAlTvBBlg76nM=;
        b=s/8ue5A3P53uicQABEUocxEN3U6c6j/ecLYoMJf6YuO62s22d2DXTSEmmue5uJpID1
         0TkxuVBdbMYVGbq4oXCyCBfx6iRrgHfK8ea2ePRyj2lN77vYD3tHhpOvXoQD+P/pRMUR
         tyUBPNN27AbW3UkbMlrSxhnD7n4s5JM3JTjbC7gTlo7kR+PZEXlpE8DASxtjmOVHmd/G
         XW/GYPC24onMNSnnKEN67c6YWJgnY6PhX4T8Eonjo7ZQzpdYlYi+aaUi63vzMDy33fr8
         YZ74gvc5fDPPUGGEIF7edvVJWSn6RBVSBb6piKFcRpc1eWT8kl3kDUnYvQwJx6/a/7q0
         hSCw==
X-Gm-Message-State: AOJu0YxJRNz2jBwb2oqEtqddL3O/rJnZiFS8Dl5wKpFlW3voXpqJqxH8
	e4j0Coci8PCPydVpKseH2Z7io0vC4zHt91TXTIrkBdCaGJdr08vRgeAmZfkZgg==
X-Gm-Gg: AfdE7cn3448VTDUZqb/kbsfQcxMS67OV5s7WZY9vLX56Q4G5GI+smR2QZ42+edDowBp
	SPOtUtBNjF6zKUBsVSQWW0E6ixJsCcNry7KES8OBIFreYrVPbLBl5h2oVX3IFQ+uWsxTmioTqRI
	vK9wL3aUY6OJUC63ko7eti9T941SfqcMAKP/pjgTjRrDwixpLFumKiUmVf60gZ8BuOApnHQpEbq
	0zDUSCfazcPaPCEJzDhNBu4jUJU180ik9emcnt5WmtJrKVdWEUkhC65LTX5eTmocJ7p5cMJJzrh
	u6Vm/dZKg85iDK6Kt4NJyLU1glWRWhvRhh/TXlZOvBpTF2C9x4YQlh16Cp1aXrcm/xQMY+UspgW
	4rF7UCd6ESPLM1qoI2oi2gLtR2BIEk7IkpGbKctnrqKnoH9fz1xFhNEVEMIF6MUwcFXmiJXbWJB
	Fuc3YfJmhUNWBmmjsZrpK/SdVolV7I5yhon0qnF1R9VV7feb27GbZn1c4RjdmDLEXmouI6pbmvP
	/nO6r5C+4QtFU3v
X-Received: by 2002:a05:620a:8805:b0:915:e670:4021 with SMTP id af79cd13be357-930b41b2442mr1452356185a.45.1784572189523;
        Mon, 20 Jul 2026 11:29:49 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52fb1fdsm944152485a.13.2026.07.20.11.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 11:29:48 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] libsemanage: semanage_pipe_data(): multiplex the compiler pipes
Date: Mon, 20 Jul 2026 14:29:10 -0400
Message-ID: <20260720182909.46833-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parent writes the entire input to the compiler's stdin, then
drains stdout to EOF, then drains stderr. If the child writes more
than a pipe buffer to a stream the parent is not yet reading, both
sides block. With hll/pp the input phase is safe (fp_to_buffer()
drains stdin before any output), but sepol_module_package_to_cil() can
emit stderr warnings while writing CIL to stdout, so a module that
produces enough warnings fills the stderr pipe and semodule -i
hanges. A streaming HLL that writes diagnostics while reading would
deadlock in the input phase too.

Replace the serial write/read with a poll() loop over all three pipes,
feeding input while draining stdout and stderr as they become
ready. read_from_pipe_to_data() is folded into an incremental append
helper.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 fixing the formatting.

 libsemanage/src/direct_api.c | 191 +++++++++++++++++++++++------------
 1 file changed, 124 insertions(+), 67 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 6c84b23c..132e2a2a 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -27,6 +27,7 @@
 #include <assert.h>
 #include <fcntl.h>
 #include <libgen.h>
+#include <poll.h>
 #include <stdio.h>
 #include <stdio_ext.h>
 #include <stdlib.h>
@@ -565,48 +566,135 @@ cleanup:
 	return retval;
 }
 
-static int read_from_pipe_to_data(semanage_handle_t *sh, size_t initial_len,
-				  int fd, char **out_data_read,
-				  size_t *out_read_len)
+static int append_read(semanage_handle_t *sh, int fd, char **buf, size_t *len,
+		       size_t *cap)
 {
-	size_t max_len = initial_len;
-	ssize_t read_len;
-	size_t data_read_len = 0;
-	char *data_read = NULL;
+	ssize_t r;
 
-	if (max_len <= 0) {
-		max_len = 1;
+	if (*len == *cap) {
+		ssize_t ncap;
+		char *tmp;
+
+		if (__builtin_mul_overflow(*cap ? *cap : 4096, 2, &ncap)) {
+			ERR(sh, "Overflow");
+			return -1;
+		}
+		tmp = realloc(*buf, ncap);
+		if (!tmp) {
+			ERR(sh, "Out of memory.");
+			return -1;
+		}
+		*buf = tmp;
+		*cap = ncap;
 	}
-	data_read = malloc(max_len * sizeof(*data_read));
-	if (data_read == NULL) {
-		ERR(sh, "Failed to malloc, out of memory.");
+
+	r = read(fd, *buf + *len, *cap - *len);
+	if (r < 0) {
+		if (errno == EINTR || errno == EAGAIN)
+			return 1;
+		ERR(sh, "Failed to read from pipe.");
 		return -1;
 	}
+	if (r == 0)
+		return 0;
+	*len += (size_t)r;
+	return 1;
+}
+
+static int pump_pipes(semanage_handle_t *sh, int in_fd, int out_fd, int err_fd,
+		      const char *in_data, size_t in_len, char **out_data,
+		      size_t *out_len, char **err_data, size_t *err_len)
+{
+	size_t in_off = 0, out_cap = 0, err_cap = 0;
+	int rc = 0;
+
+	*out_data = NULL;
+	*out_len = 0;
+	*err_data = NULL;
+	*err_len = 0;
+
+	while (in_fd >= 0 || out_fd >= 0 || err_fd >= 0) {
+		struct pollfd pfd[3];
+
+		int n = 0, i_in = -1, i_out = -1, i_err = -1;
+
+		if (in_fd >= 0) {
+			pfd[n].fd = in_fd;
+			pfd[n].events = POLLOUT;
+			i_in = n++;
+		}
+		if (out_fd >= 0) {
+			pfd[n].fd = out_fd;
+			pfd[n].events = POLLIN;
+			i_out = n++;
+		}
+		if (err_fd >= 0) {
+			pfd[n].fd = err_fd;
+			pfd[n].events = POLLIN;
+			i_err = n++;
+		}
+
+		if (poll(pfd, n, -1) < 0) {
+			if (errno == EINTR)
+				continue;
+			ERR(sh, "poll() failed.");
+			rc = -1;
+			break;
+		}
+
+		if (i_in >= 0 && (pfd[i_in].revents & (POLLOUT | POLLERR))) {
+			ssize_t w =
+				write(in_fd, in_data + in_off, in_len - in_off);
+			if (w < 0) {
+				if (errno != EINTR && errno != EAGAIN) {
+					ERR(sh,
+					    "Failed to write to input pipe.");
+					rc = -1;
+					close(in_fd);
+					in_fd = -1;
+				}
+			} else {
+				in_off += (size_t)w;
+				if (in_off == in_len) {
+					close(in_fd);
+					in_fd = -1;
+				}
+			}
+		}
 
-	while ((read_len = read(fd, data_read + data_read_len,
-				max_len - data_read_len)) > 0) {
-		data_read_len += read_len;
-		if (data_read_len == max_len) {
-			char *tmp;
-			if (__builtin_mul_overflow(max_len, 2, &max_len)) {
-				ERR(sh, "Overflow");
-				free(data_read);
-				return -1;
+		if (i_out >= 0 &&
+		    (pfd[i_out].revents & (POLLIN | POLLHUP | POLLERR))) {
+			int r = append_read(sh, out_fd, out_data, out_len,
+					    &out_cap);
+			if (r <= 0) {
+				if (r < 0)
+					rc = -1;
+				close(out_fd);
+				out_fd = -1;
 			}
-			tmp = realloc(data_read, max_len);
-			if (tmp == NULL) {
-				ERR(sh, "Failed to realloc, out of memory.");
-				free(data_read);
-				return -1;
+		}
+
+		if (i_err >= 0 &&
+		    (pfd[i_err].revents & (POLLIN | POLLHUP | POLLERR))) {
+			int r = append_read(sh, err_fd, err_data, err_len,
+					    &err_cap);
+			if (r <= 0) {
+				if (r < 0)
+					rc = -1;
+				close(err_fd);
+				err_fd = -1;
 			}
-			data_read = tmp;
 		}
 	}
 
-	*out_read_len = data_read_len;
-	*out_data_read = data_read;
+	if (in_fd >= 0)
+		close(in_fd);
+	if (out_fd >= 0)
+		close(out_fd);
+	if (err_fd >= 0)
+		close(err_fd);
 
-	return 0;
+	return rc;
 }
 
 // Forward error messages to redirected stderr pipe
@@ -649,7 +737,6 @@ static int semanage_pipe_data(semanage_handle_t *sh, const char *path,
 	char *err_data_read = NULL;
 	int retval;
 	int status = 0;
-	size_t initial_len;
 	size_t data_read_len = 0;
 	size_t err_data_read_len = 0;
 	struct sigaction old_signal;
@@ -747,46 +834,16 @@ child_err:
 			any_err = 1;
 		}
 
-		retval = write_full(input_fd[PIPE_WRITE], in_data, in_data_len);
-		if (retval == -1) {
-			ERR(sh, "Failed to write data to input pipe.");
-			any_err = 1;
-		}
-		retval = close(input_fd[PIPE_WRITE]);
+		retval = pump_pipes(sh, input_fd[PIPE_WRITE],
+				    output_fd[PIPE_READ], err_fd[PIPE_READ],
+				    in_data, in_data_len, &data_read,
+				    &data_read_len, &err_data_read,
+				    &err_data_read_len);
 		input_fd[PIPE_WRITE] = -1;
-		if (retval == -1) {
-			ERR(sh, "Unable to close write end of input pipe.");
-			any_err = 1;
-		}
-
-		initial_len = 1 << 17;
-		retval = read_from_pipe_to_data(sh, initial_len,
-						output_fd[PIPE_READ],
-						&data_read, &data_read_len);
-		if (retval != 0) {
-			any_err = 1;
-		}
-		retval = close(output_fd[PIPE_READ]);
 		output_fd[PIPE_READ] = -1;
-		if (retval == -1) {
-			ERR(sh, "Unable to close read end of output pipe.");
-			any_err = 1;
-		}
-
-		initial_len = 1 << 9;
-		retval = read_from_pipe_to_data(sh, initial_len,
-						err_fd[PIPE_READ],
-						&err_data_read,
-						&err_data_read_len);
-		if (retval != 0) {
-			any_err = 1;
-		}
-		retval = close(err_fd[PIPE_READ]);
 		err_fd[PIPE_READ] = -1;
-		if (retval == -1) {
-			ERR(sh, "Unable to close read end of error pipe.");
+		if (retval != 0)
 			any_err = 1;
-		}
 
 		errno = ENODATA;
 		if (waitpid(pid, &status, 0) == -1 || !WIFEXITED(status)) {
-- 
2.55.0

