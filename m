Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804979;
	b=kKPLvDN0KS+ZW635C95c7AI8lb1BmxD7OWnRAbK1i5uN1fixWp+OlydMYegnO/uNXX18
	 dD/2AL+9S0qTJdbiRbZgInhYQPHqhPNQpjiUYCjw3y1QihP+0RHDFcfL0YVscqQuXGyxm
	 JHKxwcSVpPXSFsFElTMDh5tjlYBKXFFVcCjLNlilPvM2Tw++QEaJeHuXeqsGD0Yi1FQoV
	 Do1QDDyTae4f+4ZzZCEKPcpJ/8/Q49N41PWFvU3CYkkqlv/+49GdnjIFQJ8oPCe1bG4gq
	 8+1RtZIOiYgbWSpaeJKiA45+vwZwLldW/PSh2SRKZHlswMqzUYMiT5afNIKqtXqv9ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DgtGiaphREdWJTY5e/+bFzAhoLtp0f0/l23Df/CaQbk=;
	b=bksoCEokmNHlt6FMRihZskWcMvEFRDHd3N0wW62ZqzssSJpsiiYDVL5FwiFLerGHl0on
	 Kp2gLL7Hvwec1fQyUEtzBCGiEeGGYtt+cAp4djOtO9G8IK0rQT88sYKwz94GPa+na2ATM
	 wqUmkPAEdILim8pXwSLmyCq5xA2lWAYKSGdL+6e8fUoE4GPIJCmdgWbh6Ujy1JxYo5weS
	 UoXJZA+Tbdn6Wx+OQhaiL472LRO9tb7mry3To64SXQhgf8I2LBYhQ460sebpxf/9KrOGf
	 HF14bBvIcRi3MfcnKhBL15Rcl+BDpGF2Fxmq+ZeizuN3e09GMFY8p2CAM02/SwYTRFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Lc5OQIH;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809EE606A337
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 809EE606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Lc5OQIH
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5363316fa0cso8641591cf.3
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804977; x=1794409777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DgtGiaphREdWJTY5e/+bFzAhoLtp0f0/l23Df/CaQbk=;
        b=0Lc5OQIHuw0W283JPkzpV5LuaGMC8rEKpOcfOWvtB9Jp6XlsN6dL6URItYxAjDTJhK
         V7iE72SY2qrU/v7gLBuUS6DbRx6ajpX/CXVPG7pXnGgT4priM3raHeHKY0hzXd0A+fnO
         XyfaM2Rt5yXM3K7eZt2z+JJ83G9ITJnLGgzS2aDCHt/nwSZztt0GNKaOxE+nHthmj6GG
         tRaQDjC76dRihxE9um/9lJqu6bcrRE1WgkTbo/bWD9JqY7fPE6Zn1KAYZrflj0CgHbnr
         DjNsPQGlPhV88nNUphvb3CX68vc+571cXsQdd1ROMu+3Bl3vefKiNzlQ0/9ygjUKZtRV
         MvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804977; x=1794409777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DgtGiaphREdWJTY5e/+bFzAhoLtp0f0/l23Df/CaQbk=;
        b=zumDzEyR/87aX41rpJQPjyYTJ4ssnDd3qqXLI/xLjmVEEYHfi1uvE6jTYAga7NHhxn
         WQj72/r//STvdXoautqgjzu/Gr91Kv/yvEUWgVcJBak9UIxRvfuPO7HdKidddUV/w0RL
         fcNA/lpaiqoSuwv93mKYSCu1MRCqW7J5ReKtl9GCwA0gHkiJ/H21CA2FBw4Y8yL5HV/M
         uJ8U8oOBE5C8Zg3K1xSKr2ZhEvm6MZ2hFUa5aWqUY29gea+c1/K7pQ+9cPk7+V9z1sBr
         gZT4y7z5ftBLHjQMDlfCmObk5xUQpxxRjUkfToLbT8J8B3u7JvbTa0SrvzcSLU7QTa+H
         IwBw==
X-Gm-Message-State: APuU4Z+iDS9ObOmBlkh9S8x6AiE/mPdBpnDYN7sCyvHYYlNU/Cz5OCz7
	J8yiX/pD0DoSw7YU7d6XTtkTq21MGJFgYEjOfsgMO/gJ+EtX4QwMpjPMh+AIHHNS
X-Gm-Gg: AYBFou1omOWUGxacd65s1mhBmKUBLTGtq1WljxKbfSj2JCvNoEw1ogpPsImpr+m44XI
	Pqmb/NlUZzEjZQSgJNTRtoWpldoctdtbNws71jvmdKgVoNDG7pQzvG3BnbRnQGb62jkrzLLqCW8
	NUKXm55yDtwZhL7qHBqlhrnm3Wzs71K8Rc0cysw+gNCOSVVJm2JOOrJHCMaAIYfhn1kcW1zTyEw
	Dc2ZcjTVIcEgKdRX+AlXOyb0cWbNjNvhNSvRUaurwf83N+txMYTKWS12vTSqJbPqplqJYT81+Fu
	AKothD5BJIcGeacEqEFaQ2jyEMHvaTRcKrj2Gva1Drn3QVcd8GOdqMin3Km2HjyUQ/uvGI0lIWL
	vtROrVZapThfXD7+1+DvCrMveMTgg9ERgW50QgGhCH20YiZPv3O3+DJa6l4EgPL+NYLtrHc4kCf
	QB6vR3TQJW9e63NSLjdx5vxgZO2Mnu/icfWNjJ8W5FGPnGMUaND8zrSiN8DMt9KxjdLJ7oAQ/6i
	7f/r+b+9x0d8UbK9y8B8FiebZt2rWTJaUQjgX0hq+y1pVtPd5ep/qgHtkjT0bNmxrumdm6/61ZD
	X3Ac2Rd0DPL2OOhceWENj83FrHOgAn5DnreTUHpIlkp343hdK5ia/BbzlhxOhNUyODaSR4YIr6x
	8WnWQA0UAHC9FaAVLZiALYbP+IVMXh38JdzFIK/B52okSfl+y98USmrLmNTkqAEMoCfR78Erovj
	TsCoYqE3auntb1n3WY4mPHDpGbAVr/RTn9BlXmcGbWVPF8xs8OT7o=
X-Received: by 2002:a05:622a:114b:b0:536:7525:1a57 with SMTP id d75a77b69052e-542b3e68d7dmr280610671cf.3.1793804977283;
        Wed, 04 Nov 2026 07:09:37 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:37 -0800 (PST)
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
Subject: [PATCH v3 03/20] libselinux: preserve restorecon failure errno through traversal and cleanup
Date: Wed,  4 Nov 2026 10:08:58 -0500
Message-ID: <20261104150915.175923-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104150915.175923-1-stephen.smalley.work@gmail.com>
References: <20261104150915.175923-1-stephen.smalley.work@gmail.com>
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

