Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388010;
	b=BJqo5roOKiihaeMUZ3fIC/WiLLwq7nZLMRtWfOyGhVdHQ/9EsfYLZzucsfoK8SC3am/M
	 7dxRs19spVv9SUv27lgLI5Hi6UEliHHHuNi+PpqjsfGmF1LaoF8DRMInVbAP273RY9yrP
	 NrpZ5wnBobLg4nm/IDbeCa9BSryKCddys+6CKJXYYqcxo7O8Fh7jyyQLxfiRs2Gao8LRt
	 e+yzawfk3hEyF6r/IAsnyF/Knzxgjwgc29JtwTCWwR3QwKqRrDGuBo+EVmzRWg/35XznA
	 PhNlN8e6Pbtav98np7Du55NTrIjkdYpuPx97H9TO1qsahIwIKI7SduDNbRTEl7IDDJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DgtGiaphREdWJTY5e/+bFzAhoLtp0f0/l23Df/CaQbk=;
	b=aiD/V8Am4Cpql73T0NuhCUW++IzVMzJ6+vY1XFYCzw60apt1Qr4vDsDbhX1HaOxZkeKd
	 5DcZj7OUDt2cMXZTz2xWRTQUgdV3+nA/R9qXmbPpWygl2psZC7lArnKFNSKLi2P64sQNF
	 1+Bf/2Tm4X9XGOvQTArk6ikxf8z6a7mlSul6KKKcuYWqOqC8a2HRJvMPbQmHhhUHUFjqS
	 UlGzydBPQ4Gn0zSKh6WJhOaw86B2AG8vqANxvst+RZLdqVwk9fRGShebM0XdQPBJGhumO
	 wnuvtWYU85PmGn5lE7ArD6Ca0BWWy9c85C5UKQXV/KdKc5OSFcUwRJoVowF5Ir2XN2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E5N6BTUt;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FB0606A320
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86FB0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E5N6BTUt
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91c76540d0bso12207996d6.0
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388008; x=1793992808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DgtGiaphREdWJTY5e/+bFzAhoLtp0f0/l23Df/CaQbk=;
        b=E5N6BTUtCSQTRH5a1npsAJrmLyL/hVF6zWo9ErpG5stu/LUz+zoszCFe6oRHKIjDAJ
         ADu/Onu3k9abW924col33mZi4K8RaOuD/DYj+RPL6p9oGVVwntEfgqU2XxVScSo4x/Sb
         2yV4bWz5meFp11Ayp45VGxfDQsNn60kmGWNrMJTglhcJGXyid6L261Ok6eP3AXp28I60
         siVieMGPgMasRGr6mTYJD9pKBxN6p6N+6zxZ5eXIUksfeWUVTYrKiuHPDItMMR9b2Qnk
         rbL6LRdaQZb0PmgAW8kYuqh0CM6C4r5gTbbtRy1Rsilu+3kyvzV/f28iFHoy8KXQjQE2
         9jmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388008; x=1793992808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DgtGiaphREdWJTY5e/+bFzAhoLtp0f0/l23Df/CaQbk=;
        b=DM3DfkD6L2FmI8tvZs3clcIb4lm2AH1bex1Zj58kRkYr9hB/QPBBKgVkdLS/56nOqA
         UPxit4JsFxy+jr8T0BVtQpzO5JkC8sEyPUNdkRxZVLfn3X1o2Sl6cm072cgF6XU9mdKw
         4wGhewGroU2+ysEBKLT9GZgObIVMQ34ZlOAegLRC12tdA41JFKV1vSIaLw6kYtjye5Z/
         yxl7FKZAoVDFUGwQYjboJEAZ23eAheWldg9Y3KgjGnUYVIQYXEBY9RyWTTIqOexnxgUc
         6dJqM50SGjL8cRtYncXf51JZS9FOeOGrnmSNltmNTgILUfpTf5o8vSohq8ZCMfTxs4oi
         1/qw==
X-Gm-Message-State: AFq9FYI+AaIqSrMWSyT0uAKTF70Bg55poZ+M7e4nYnf/Wbrnc6u5CE6w
	9+d+B1oY55Qzrk+vy2Dj68FyRYrMFWDdqTab0NbcnL+ZtCI27uUQZpGMrW1idtrx
X-Gm-Gg: AYBFou2QURPA33SNYzYi+XHZ2bexwKT8TpTkPjySNH2TWMHMQXxS27jNnT/gO9IMp9r
	ppn2VWh54I0YWs6DLiluoJ1fJPUKfZg8M5+LSTN8OhcSmE0eoTiXPboSgFRJU6wzdOhlne7Nsor
	xxhcdR1E2vdb+sWLCtO2VgKlaewbefuCIu4Ak0pfViz/NwXhGP2tneUvQGHi+5Cam3FBoWcp2g/
	lGFNWkp+NWpIaz+IQvArEzGHD3BD3/A/a5ekyuH7XXiNKCyJrldlLn23Ii252QTSFL792h5zgHs
	2Hkwx/6I6c4O7ke+uRtluk4Enh1v8YAgjmqdhtc0GC0lrFI+ynqwfG1WkcUhiXf6xxS/npTGwop
	gEwI4u5vQN6Nybcp7ure5Wk6BhgWWff0+6FGPi7c6MZDfcZqe4Q/DrZMOUZN92MJJ454s7vu4aT
	5IO4cKXOlakEOSO8jJ630oODR2r8o0+q05Zd8KvfaD+ZTr8/jXZ8ypWWzmOQXjCZGzLEQ2sARta
	d8UCAGzV/RoQMv+u6QnI/JuoLPpd7b2ekAPaG3rLfATIMMjXP343aM43j5DTmZqTwxXtG6sgKq6
	Z2xTiEspLu+3MQ3C5eaj6EtFjSiywJx0IRcY1JtZcdxQ+hf59xr5drQaMUqz6HWDyezAZHB1buE
	+Nst//Wlt1J0lupXlNplDtS8LD18NOcJDkVFvnem0T7Ip9C2y9hug65kqSKFAvIAH79PGEC5NSr
	LcQNO7MoX1SZQkxi1dU+MLofd6IE7G/fCdsLk/ynYl/S9qmBv9Op9Zgpn7/Se7KorQV4Q38zE5
X-Received: by 2002:a05:6214:4346:b0:919:860d:3df9 with SMTP id 6a1803df08f44-91ca4b59509mr56366316d6.16.1793388008231;
        Fri, 30 Oct 2026 12:20:08 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca805be18sm22501076d6.31.2026.10.30.12.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:20:07 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 03/10] libselinux: preserve restorecon failure errno through traversal and cleanup
Date: Fri, 30 Oct 2026 15:19:17 -0400
Message-ID: <20261030191924.150495-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030191924.150495-1-stephen.smalley.work@gmail.com>
References: <20261030191924.150495-1-stephen.smalley.work@gmail.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Capture the first unmasked traversal or relabel error while holding the
walk mutex instead of saving ambient errno when a worker exits. Later
readdir calls can clear errno, and successful workers can otherwise
publish an unrelated value before a failing worker finishes.

Preserve failure errno across descriptor cleanup, nonrecursive relabels,
and final walk teardown. Retain the actual walk_push failure instead of
unconditionally reporting ENOMEM when fdopendir fails.

Add fault-injection coverage for label reads and writes, directory reads
and opens, fdopendir, statfs, root and child stat, and stack allocation.
Exercise serial and parallel traversal, abort and counted-error modes,
cleanup errno clobbering, and successful reuse after each failure.

Fixes: 67bc978bfaf9 ("libselinux: restorecon: revisit pinning files to avoid TOCTOU issues")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_restorecon.c      |  65 ++++--
 libselinux/tests/.gitignore              |   1 +
 libselinux/tests/Makefile                |   9 +-
 libselinux/tests/test_restorecon_errno.c | 279 +++++++++++++++++++++++
 4 files changed, 329 insertions(+), 25 deletions(-)
 create mode 100644 libselinux/tests/test_restorecon_errno.c

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 9755409e..416695b4 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -714,6 +714,7 @@ static int restorecon_sb(int fd, const char *pathname, const struct stat *sb,
 	char *curcon = NULL;
 	int rc;
 	bool updated = false;
+	int saved_errno;
 	const char *lookup_path = pathname;
 
 	if (flags->skip_multilink && !S_ISDIR(sb->st_mode) &&
@@ -885,8 +886,10 @@ out:
 		*updated_out = updated;
 	rc = 0;
 out1:
+	saved_errno = errno;
 	freecon(curcon);
 	freecon(newcon);
+	errno = saved_errno;
 	return rc;
 err:
 	selinux_log(SELINUX_ERROR, "Could not set context for %s:  %m\n",
@@ -979,7 +982,9 @@ static int walk_push(struct rest_state *st, int rdfd, dev_t dev, ino_t ino,
 		struct walk_level *n =
 			reallocarray(st->stack, ncap, sizeof(*st->stack));
 		if (!n) {
+			int saved_errno = errno;
 			close(rdfd);
+			errno = saved_errno;
 			return -1;
 		}
 		st->stack = n;
@@ -988,7 +993,9 @@ static int walk_push(struct rest_state *st, int rdfd, dev_t dev, ino_t ino,
 
 	dirp = fdopendir(rdfd);
 	if (!dirp) {
+		int saved_errno = errno;
 		close(rdfd);
+		errno = saved_errno;
 		return -1;
 	}
 
@@ -1051,8 +1058,11 @@ static bool walk_is_cycle(const struct rest_state *st, dev_t dev, ino_t ino)
 	return false;
 }
 
-static bool note_walk_error(struct rest_state *state)
+static bool note_walk_error(struct rest_state *state, int error)
 {
+	if ((state->flags.abort_on_error || !state->flags.count_errors) &&
+	    !state->saved_errno)
+		state->saved_errno = error;
 	if (state->flags.abort_on_error) {
 		state->error = -1;
 		state->abort = true;
@@ -1103,7 +1113,9 @@ static int open_final(int dfd, const char *name, struct stat *sb)
 		return -1;
 
 	if (fstat(fd, sb) < 0) {
+		int saved_errno = errno;
 		close(fd);
+		errno = saved_errno;
 		return -1;
 	}
 
@@ -1129,7 +1141,9 @@ static int safe_open(const char *path, struct stat *sb)
 	nfd = syscall(__NR_openat2, AT_FDCWD, path, &how, sizeof(how));
 	if (nfd >= 0) {
 		if (fstat(nfd, sb) < 0) {
+			int saved_errno = errno;
 			close(nfd);
+			errno = saved_errno;
 			return -1;
 		}
 		return nfd;
@@ -1200,21 +1214,25 @@ static int safe_open(const char *path, struct stat *sb)
 		}
 
 		nfd = open_final(dfd, cur, sb);
+		int saved_errno = errno;
 		close(dfd);
 		free(copy);
+		errno = saved_errno;
 		return nfd;
 	}
 
 	nfd = open_final(dfd, NULL, sb);
+	int saved_errno = errno;
 	close(dfd);
 	free(copy);
+	errno = saved_errno;
 	return nfd;
 }
 
 /*
  * Returns 1 if we successfully filled ent_* with the next entry
- * to process, 0 on clean end-of-walk, -1 with errno set on
- * fatal failure from readdir() or path too long.
+ * to process, 0 on end-of-walk, or -1 after recording an aborting
+ * traversal error in state.
  */
 static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 		     struct stat *ent_sb, char *ent_path, size_t ent_path_sz,
@@ -1241,7 +1259,7 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 				selinux_log(SELINUX_ERROR,
 					    "Could not read %s: %m\n",
 					    state->pathbuf);
-				note_walk_error(state);
+				note_walk_error(state, errno);
 			}
 		}
 		return 1;
@@ -1259,12 +1277,13 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 		de = readdir(top->dirp);
 		if (!de) {
 			if (errno) {
+				int saved_errno = errno;
 				selinux_log(
 					SELINUX_ERROR,
 					"Could not read directory %s: %m.\n",
 					state->pathbuf);
 				walk_pop(state);
-				if (note_walk_error(state))
+				if (note_walk_error(state, saved_errno))
 					return -1;
 				continue;
 			}
@@ -1303,7 +1322,7 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 				"Path name too long under %.*s, skipping.\n",
 				(int)top->pathlen, state->pathbuf);
 			errno = ENAMETOOLONG;
-			if (note_walk_error(state))
+			if (note_walk_error(state, ENAMETOOLONG))
 				return -1;
 			continue;
 		}
@@ -1316,7 +1335,7 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 					    "Could not open %s: %m.\n",
 					    state->pathbuf);
 				state->pathbuf[top->pathlen] = '\0';
-				if (note_walk_error(state))
+				if (note_walk_error(state, errno))
 					return -1;
 				continue;
 			}
@@ -1338,12 +1357,13 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 
 		if (need_fstat) {
 			if (fstat(fd, ent_sb) < 0) {
+				int saved_errno = errno;
 				selinux_log(SELINUX_ERROR,
 					    "Could not stat %s: %m.\n",
 					    state->pathbuf);
 				close(fd);
 				state->pathbuf[top->pathlen] = '\0';
-				if (note_walk_error(state))
+				if (note_walk_error(state, saved_errno))
 					return -1;
 				continue;
 			}
@@ -1367,7 +1387,7 @@ static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
 				 * reading, we want to relabel the directory
 				 * itself.
 				 */
-				(void)note_walk_error(state);
+				(void)note_walk_error(state, errno);
 			}
 		}
 
@@ -1471,11 +1491,12 @@ static void *selinux_restorecon_thread(void *arg)
 			if (descend) {
 				if (walk_push(state, rd_fd, ent_sb.st_dev,
 					      ent_sb.st_ino, ent_pathlen) < 0) {
+					if (!state->saved_errno)
+						state->saved_errno = errno;
 					close(ent_fd);
-					errno = ENOMEM;
 					state->error = -1;
 					state->abort = true;
-					goto finish;
+					goto unlock;
 				}
 
 				if (have_digest) {
@@ -1497,6 +1518,7 @@ static void *selinux_restorecon_thread(void *arg)
 		bool updated = false;
 		error = restorecon_sb(ent_fd, ent_path, &ent_sb, &state->flags,
 				      first, &updated);
+		int saved_errno = errno;
 		close(ent_fd);
 
 		if (state->parallel) {
@@ -1510,15 +1532,8 @@ static void *selinux_restorecon_thread(void *arg)
 
 		first = false;
 		if (error) {
-			if (state->flags.abort_on_error) {
-				state->error = error;
-				state->abort = true;
-				goto finish;
-			}
-			if (state->flags.count_errors)
-				state->skipped_errors++;
-			else
-				state->error = error;
+			if (note_walk_error(state, saved_errno))
+				goto unlock;
 		} else if (updated && state->flags.count_relabeled) {
 			state->relabeled_files++;
 		}
@@ -1529,9 +1544,6 @@ static void *selinux_restorecon_thread(void *arg)
 		state->abort = true;
 	}
 
-finish:
-	if (!state->saved_errno)
-		state->saved_errno = errno;
 unlock:
 	if (state->parallel)
 		__pthread_mutex_unlock(&state->mutex);
@@ -1544,6 +1556,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
 {
 	struct rest_state state;
 	int top_fd;
+	int saved_errno;
 
 	state.flags.nochange =
 		(restorecon_flags & SELINUX_RESTORECON_NOCHANGE) ? true : false;
@@ -1746,19 +1759,23 @@ static int selinux_restorecon_common(const char *pathname_orig,
 		bool updated = false;
 		error = restorecon_sb(top_fd, pathname, &sb, &state.flags, true,
 				      &updated);
+		saved_errno = errno;
 		if (updated && state.flags.count_relabeled) {
 			state.relabeled_files++;
 		}
 		close(top_fd);
+		errno = saved_errno;
 		goto cleanup;
 	}
 
 	/* Obtain fs type */
 	memset(&state.sfsb, 0, sizeof(state.sfsb));
 	if (!S_ISLNK(sb.st_mode) && fstatfs(top_fd, &state.sfsb) < 0) {
+		saved_errno = errno;
 		selinux_log(SELINUX_ERROR, "statfs(%s) failed: %m\n", pathname);
 		error = -1;
 		close(top_fd);
+		errno = saved_errno;
 		goto cleanup;
 	}
 
@@ -1854,6 +1871,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
 
 	errno = state.saved_errno;
 cleanup:
+	saved_errno = errno;
 	if (state.root_fd >= 0)
 		close(state.root_fd);
 	walk_free(&state);
@@ -1865,6 +1883,7 @@ cleanup:
 	}
 	free(pathdnamer);
 	free(pathname);
+	errno = saved_errno;
 	return error;
 
 oom:
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index e8790485..681a24f4 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -1,2 +1,3 @@
 test-restorecon-digest
 /test-restorecon-errors
+/test-restorecon-errno
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index d5155ebb..04967f36 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -3,6 +3,7 @@ CFLAGS ?= -O2 -g -Wall -Wextra -Werror
 override CFLAGS += -I../include -pthread
 WRAPS = getfilecon_raw setfilecon_raw getxattr fsetxattr pthread_cond_wait fstatfs fstatfs64
 ERROR_WRAPS = getfilecon_raw setfilecon_raw lgetfilecon_raw lsetfilecon_raw
+ERRNO_WRAPS = $(ERROR_WRAPS) close closedir fdopendir readdir readdir64 fstatfs fstatfs64 openat openat64 fstat fstat64 reallocarray
 
 test-restorecon-digest: test_restorecon_digest.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
@@ -12,10 +13,14 @@ COMMA := ,
 test-restorecon-errors: test_restorecon_errors.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERROR_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
+test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
+
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno
 	./test-restorecon-digest
 	./test-restorecon-errors
+	./test-restorecon-errno
 
 clean:
-	rm -f test-restorecon-digest test-restorecon-errors
+	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno
diff --git a/libselinux/tests/test_restorecon_errno.c b/libselinux/tests/test_restorecon_errno.c
new file mode 100644
index 00000000..bda290b2
--- /dev/null
+++ b/libselinux/tests/test_restorecon_errno.c
@@ -0,0 +1,279 @@
+/* SPDX-License-Identifier: CC0-1.0 */
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/vfs.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <selinux/label.h>
+#include <selinux/restorecon.h>
+
+enum fault {
+	LABEL_WRITE,
+	LABEL_READ,
+	DIRECTORY_READ,
+	DIRECTORY_STREAM,
+	FILESYSTEM_STAT,
+	DIRECTORY_OPEN,
+	CHILD_OPEN,
+	MISSING_ROOT,
+	ROOT_STAT,
+	CHILD_STAT,
+	STACK_ALLOC,
+	FAULT_COUNT
+};
+
+static enum fault fault;
+static bool inject, clobber;
+static unsigned int hits;
+
+static bool fail(enum fault at)
+{
+	if (!inject || fault != at)
+		return false;
+	__atomic_add_fetch(&hits, 1, __ATOMIC_RELAXED);
+	return true;
+}
+
+int __real_close(int fd);
+int __wrap_close(int fd);
+int __wrap_close(int fd)
+{
+	int rc = __real_close(fd);
+	if (clobber)
+		errno = EBADF;
+	return rc;
+}
+
+int __real_closedir(DIR *dir);
+int __wrap_closedir(DIR *dir);
+int __wrap_closedir(DIR *dir)
+{
+	int rc = __real_closedir(dir);
+	if (clobber)
+		errno = EBADF;
+	return rc;
+}
+
+DIR *__real_fdopendir(int fd);
+DIR *__wrap_fdopendir(int fd);
+DIR *__wrap_fdopendir(int fd)
+{
+	if (fail(DIRECTORY_STREAM)) {
+		errno = EMFILE;
+		return NULL;
+	}
+	return __real_fdopendir(fd);
+}
+
+#define WRAP_READDIR(name, type)            \
+	type *__real_##name(DIR *dir);      \
+	type *__wrap_##name(DIR *dir);      \
+	type *__wrap_##name(DIR *dir)       \
+	{                                   \
+		if (fail(DIRECTORY_READ)) { \
+			errno = EIO;        \
+			return NULL;        \
+		}                           \
+		return __real_##name(dir);  \
+	}
+WRAP_READDIR(readdir, struct dirent)
+WRAP_READDIR(readdir64, struct dirent64)
+
+#define WRAP_STATFS(name, type)                \
+	int __real_##name(int fd, type *buf);  \
+	int __wrap_##name(int fd, type *buf);  \
+	int __wrap_##name(int fd, type *buf)   \
+	{                                      \
+		if (fail(FILESYSTEM_STAT)) {   \
+			errno = EIO;           \
+			return -1;             \
+		}                              \
+		return __real_##name(fd, buf); \
+	}
+WRAP_STATFS(fstatfs, struct statfs)
+WRAP_STATFS(fstatfs64, struct statfs64)
+
+#define WRAP_STAT(name, type)                                               \
+	int __real_##name(int fd, type *buf);                               \
+	int __wrap_##name(int fd, type *buf);                               \
+	int __wrap_##name(int fd, type *buf)                                \
+	{                                                                   \
+		int rc = __real_##name(fd, buf);                            \
+		if (!rc && ((S_ISDIR(buf->st_mode) && fail(ROOT_STAT)) ||   \
+			    (S_ISREG(buf->st_mode) && fail(CHILD_STAT)))) { \
+			errno = EOVERFLOW;                                  \
+			return -1;                                          \
+		}                                                           \
+		return rc;                                                  \
+	}
+WRAP_STAT(fstat, struct stat)
+WRAP_STAT(fstat64, struct stat64)
+
+void *__real_reallocarray(void *ptr, size_t n, size_t size);
+void *__wrap_reallocarray(void *ptr, size_t n, size_t size);
+void *__wrap_reallocarray(void *ptr, size_t n, size_t size)
+{
+	if (fail(STACK_ALLOC)) {
+		errno = ENOMEM;
+		return NULL;
+	}
+	return __real_reallocarray(ptr, n, size);
+}
+
+/* Restorecon opens only existing paths; neither variant needs a mode. */
+#define WRAP_OPENAT(name)                                            \
+	int __real_##name(int fd, const char *path, int flags, ...); \
+	int __wrap_##name(int fd, const char *path, int flags, ...); \
+	int __wrap_##name(int fd, const char *path, int flags, ...)  \
+	{                                                            \
+		assert(!(flags & O_CREAT));                          \
+		if ((!strcmp(path, ".") && fail(DIRECTORY_OPEN)) ||  \
+		    (!strcmp(path, "child") && fail(CHILD_OPEN))) {  \
+			errno = EACCES;                              \
+			return -1;                                   \
+		}                                                    \
+		return __real_##name(fd, path, flags);               \
+	}
+WRAP_OPENAT(openat)
+WRAP_OPENAT(openat64)
+
+int __wrap_getfilecon_raw(const char *path, char **context);
+int __wrap_lgetfilecon_raw(const char *path, char **context);
+int __wrap_setfilecon_raw(const char *path, const char *context);
+int __wrap_lsetfilecon_raw(const char *path, const char *context);
+
+int __wrap_getfilecon_raw(const char *path, char **context)
+{
+	struct stat sb;
+	assert(stat(path, &sb) == 0);
+	*context = NULL;
+	if (S_ISREG(sb.st_mode) && fail(LABEL_READ)) {
+		errno = EACCES;
+		return -1;
+	}
+	errno = ENODATA;
+	return -1;
+}
+
+int __wrap_lgetfilecon_raw(const char *path, char **context)
+{
+	return __wrap_getfilecon_raw(path, context);
+}
+
+int __wrap_setfilecon_raw(const char *path, const char *context)
+{
+	struct stat sb;
+	(void)context;
+	assert(stat(path, &sb) == 0);
+	if (S_ISREG(sb.st_mode) && fail(LABEL_WRITE)) {
+		errno = ENOSPC;
+		return -1;
+	}
+	errno = ENODATA;
+	return 0;
+}
+
+int __wrap_lsetfilecon_raw(const char *path, const char *context)
+{
+	return __wrap_setfilecon_raw(path, context);
+}
+
+static void run_case(size_t threads, enum fault at, unsigned int extra,
+		     bool overwrite)
+{
+	char root[] = "/tmp/restorecon-errno-XXXXXX";
+	char file[256], fc[256], missing[256];
+	const int errors[] = { ENOSPC,	  EACCES,    EIO,    EMFILE,
+			       EIO,	  EACCES,    EACCES, ENOENT,
+			       EOVERFLOW, EOVERFLOW, ENOMEM };
+	unsigned int flags = SELINUX_RESTORECON_RECURSE |
+			     SELINUX_RESTORECON_IGNORE_MOUNTS |
+			     SELINUX_RESTORECON_SET_SPECFILE_CTX |
+			     SELINUX_RESTORECON_XDEV | extra;
+	bool counted = extra == SELINUX_RESTORECON_COUNT_ERRORS &&
+		       at != DIRECTORY_STREAM && at != FILESYSTEM_STAT &&
+		       at != MISSING_ROOT && at != ROOT_STAT &&
+		       at != STACK_ALLOC;
+	alarm(15);
+	assert(mkdtemp(root));
+	assert(snprintf(file, sizeof(file), "%s/child", root) > 0);
+	assert(snprintf(fc, sizeof(fc), "%s.fc", root) > 0);
+	assert(snprintf(missing, sizeof(missing), "%s/missing", root) > 0);
+	int fd = open(file, O_CREAT | O_EXCL | O_WRONLY, 0600);
+	assert(fd >= 0 && close(fd) == 0);
+	FILE *fp = fopen(fc, "w");
+	assert(fp);
+	assert(fprintf(fp, "%s(/.*)? system_u:object_r:test_t:s0\n", root) > 0);
+	assert(fclose(fp) == 0);
+	struct selinux_opt option = { SELABEL_OPT_PATH, fc };
+	struct selabel_handle *handle =
+		selabel_open(SELABEL_CTX_FILE, &option, 1);
+	assert(handle);
+	selinux_restorecon_set_sehandle(handle);
+	fault = at;
+	inject = true;
+	clobber = overwrite;
+	int rc = selinux_restorecon_parallel(
+		at == MISSING_ROOT ? missing : root, flags, threads);
+	int saved_errno = errno;
+	assert(rc == (counted ? 0 : -1));
+	assert(at == MISSING_ROOT || hits > 0);
+	if (!counted)
+		assert(saved_errno == errors[at]);
+	/* Neither the failure nor a worker's ambient errno may poison reuse. */
+	inject = false;
+	assert(selinux_restorecon_parallel(root, flags, threads) == 0);
+	if (at == LABEL_WRITE || at == LABEL_READ) {
+		inject = true;
+		assert(selinux_restorecon(
+			       file, flags & ~SELINUX_RESTORECON_RECURSE) ==
+		       -1);
+		assert(errno == errors[at]);
+	}
+	clobber = inject = false;
+	assert(unlink(file) == 0 && rmdir(root) == 0 && unlink(fc) == 0);
+	selinux_restorecon_set_sehandle(NULL);
+}
+
+int main(int argc, char **argv)
+{
+	const size_t threads[] = { 1, 2, 8 };
+	const unsigned int options[] = { 0, SELINUX_RESTORECON_ABORT_ON_ERROR,
+					 SELINUX_RESTORECON_COUNT_ERRORS };
+	unsigned int cases = 0;
+	for (size_t i = 0; i < sizeof(threads) / sizeof(threads[0]); i++) {
+		for (int at = 0; at < FAULT_COUNT; at++) {
+			if (argc > 1 && at != atoi(argv[1]))
+				continue;
+			for (size_t j = 0;
+			     j < sizeof(options) / sizeof(options[0]); j++) {
+				for (int overwrite = 0; overwrite < 2;
+				     overwrite++) {
+					pid_t pid = fork();
+					int status;
+					assert(pid >= 0);
+					if (!pid) {
+						run_case(threads[i], at,
+							 options[j], overwrite);
+						_exit(0);
+					}
+					assert(waitpid(pid, &status, 0) == pid);
+					assert(WIFEXITED(status) &&
+					       WEXITSTATUS(status) == 0);
+					cases++;
+				}
+			}
+		}
+	}
+	printf("Restorecon errno: %u cases passed.\n", cases);
+	return 0;
+}
-- 
2.56.0

