Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF243161AD
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211672; cv=none; b=hOAIEsX+4ccgTsIPRuwsnAxP+U+80+hzjSm1yD642fBTk6e11okvsS3Dd3ohxxd0mTct1KDCZQUtV5CbziWInUrSwo4iuaLD4ZaQMUoZGvmxYXnKE8yVmyagPiFjWDVA+eE2Anvuetrmgb//II1M4Rr6K4zEb5p47zagQJ3kwZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211672; c=relaxed/simple;
	bh=06K6pfFvqeUt0xq3U6Y+kwgCrvcpb8qlimjLwIKA8Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W80FKKwAOOVYOhyTJlHRDuM41Bx61Uq7hv1SeMcbvF3OLu93JAnE5yAQRQrOTyHRcTW6WVW4CIFezcjXfMU4W9jyVH/y63PNTToYb+tQR5s+IUIFzIrKFGPWHkg1MaUDeU9G56QuU0EyuMr6sO9QWl6jFte7itke/Et6+6dvPYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYR8knEp; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYR8knEp"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c2808dbc3so40723771cf.1
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784211670; x=1784816470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=06J7r7bUHzIuEv+a4aTYnd/qeirMAArAOFtTLIa6GJ4=;
        b=UYR8knEp+URUGkg9j9MVmHUzxIX2axtqc9RLkDiEsHfC0F8DlDZa679e6g6A029M9x
         RqLeinirxXFL8mskZZsi5Lc8Yb8f2Wy/Er3+Yzhr9b4aGm6idedSUpzsWgnPx21ky4vB
         +pYPKt4oZ5veo0WDrsK8w0txK8aUrm8KM+5Fhduvje/Pi3mfaScLGN6VB/O36dqTRnwQ
         Bf2SVtloGHRFwwII4ZvOzG4KZ9E7eRNUSSzEwaWvvLFdapoCCZyPZs5gAmFQFKMuwm5R
         poNlIBuOTDht0v+KFy+eEckIwNn3vjjaDY4oAqyhbZgHhUmGTAU9qFYe/oi7HSTmTvri
         /ZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784211670; x=1784816470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=06J7r7bUHzIuEv+a4aTYnd/qeirMAArAOFtTLIa6GJ4=;
        b=Se+OOvu682j2EqL99vX3Gvj8Sdt1Q5CPsILehtTFVihxqTevLNyOSRU8SfMkd5Jrgi
         5IAOX1dSXV/CjeMpKR2KB9V9FWO91bVxXm9ZQnc3uCJm6pBnFJ2WRdY6FYMLdGNA0FPx
         CP/5kG6Fg/4ZDZx5cAsRbLGinWmczPELcMeQMmVlK72a4WRrlyZe0JoQ1qM6cmXrVeiO
         3biQp1JalEasglZVKQusZr3TGL+NcWDa6Bip/zvBc/gOsg76s/Wm29IdAn5/HxCRdZsk
         YtOo2SU5YpLuAGv+BXqxhHsxdBtj0Sv96gUGgm7QvMrS11HWfFIWIUFN8A2A2mNdnr9Y
         sgMw==
X-Gm-Message-State: AOJu0Yw+d9PgKFw81c0RtIT83xgjfBv0F7WXY1LyOr2uQf3iF3FP/XsS
	5kEGSOjFC+gAQscEjarIcoR/8inYsGrb8uvbdUDc0FjqOi/KI18AmtyWPj3XEA==
X-Gm-Gg: AfdE7clyzUEBS7904G0YgutNp/qSlNr31AgOAftSYl+LkzdymK+zUPZZaxNd5RDHp+J
	pCK/qBNbtmrvIYGNVszxjzT4pDp4sMccoIZ1o5lj4+MlqNvqzKKWf0ivloLhIQW8j8YqrNqFlkW
	FCCFRyBAhSmI8wumNz+JCh2KdUtpEPAAh9GAP3QJF5MT1+0qMkxZjQvOVYfpfBgLVRwSnYI7PHj
	J4BTG6EMBMLJSxLCcuDsNt5dOynxM3ETx3OHn2U+jMJX1ftVOfa7bsPZKsHWSIv7+wGBQ5W4uvI
	VCv5FFkqTUHcgUctbtBBJeEaWxgrf7V1+ouEktdxseIjkzfj0UUZGd+AeOabO6fv2PCHFC3Eh8A
	KKs3FNj38vxoWD3WqdO4A0IJPELKeWQcGRDT45mnOPEyycBKiqtQ/h62ENWU7F/2yE4WSWyOnM6
	w9ZXAB9p8ClFRDX6nG7mJymYFmvwsIlL4kQYCp+R08Si4C4EhNGzn2yUXkoPgDqzkgM6XhnVHzE
	pKZrA==
X-Received: by 2002:ac8:5d56:0:b0:51c:257c:8164 with SMTP id d75a77b69052e-51e4237d2bamr115913121cf.25.1784211669535;
        Thu, 16 Jul 2026 07:21:09 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae5e91dsm159671571cf.21.2026.07.16.07.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:21:06 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsemanage: semanage_pipe_data(): multiplex the compiler pipes
Date: Thu, 16 Jul 2026 10:20:42 -0400
Message-ID: <20260716142042.8162-1-stephen.smalley.work@gmail.com>
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
 libsemanage/src/direct_api.c | 190 +++++++++++++++++++++++------------
 1 file changed, 123 insertions(+), 67 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 6c84b23c..ca8173ea 100644
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
@@ -747,46 +834,15 @@ child_err:
 			any_err = 1;
 		}
 
-		retval = write_full(input_fd[PIPE_WRITE], in_data, in_data_len);
-		if (retval == -1) {
-			ERR(sh, "Failed to write data to input pipe.");
-			any_err = 1;
-		}
-		retval = close(input_fd[PIPE_WRITE]);
+		retval = pump_pipes(sh, input_fd[PIPE_WRITE], output_fd[PIPE_READ],
+				err_fd[PIPE_READ], in_data, in_data_len,
+				&data_read, &data_read_len, &err_data_read,
+				&err_data_read_len);
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

