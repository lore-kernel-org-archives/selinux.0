Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C13F7A8C
	for <selinux@vger.kernel.org>; Wed,  6 May 2026 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069883; cv=none; b=lAwT1zD6Rrn4iRygmrckgR+7X5E8yz7FzZqBkAhbJ6PGWuKTup9wwM7zPSW4mCHYHF+VUdYIiN7W+/kJezP8Z2ebKsoK65anQ9B7N0guNujrkV1Ms2iGHA8ZmbV6WBSCNNoQJEqWdqtYNpKJjTB2e+1YqFgdNicxC7yPvHvbTdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069883; c=relaxed/simple;
	bh=xIlKVlTVhnf4YoM/5tt/+cjNyH5Ybj6J+NB22FylHlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AnEoQrB/+1AE0UJXXes1EqURNX48+e015dnc64cOd5E/gdfRCGi0m5c/pUeg97o8SffdpQTiOMJiZXrzr+o5XaMOQXKXDQQJSQnF3x4+c1eHwd1A+xBjtNswaP3Hx567tBXGzfurpahVaBZ54xsC/Y5z+JjumSy3k164Ayi0j2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUUh5VEW; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUUh5VEW"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cbc593a67aso565555485a.2
        for <selinux@vger.kernel.org>; Wed, 06 May 2026 05:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778069880; x=1778674680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c3Yb5agpPb4IBeFuX14ExkGcg3iWoEZUFma+iAeJy3o=;
        b=dUUh5VEWDDexd9ZLdaAvNq4q9z1tf8EnGGVdMEeUO68X8djcX3XSD6ySGls8BF7L77
         DlbBCmRgs25KV+CPypJOlszSrCVekf8L1sffxIQBVUpn0US5lZdNKx6IXi+dC3O++6+D
         6bl2aOu0nS8YLOFbavDluZDDnC2nKJquEOclcT8yuNlPlMMhwBblQLyGqBad9Dr2lWVB
         CjMaG5803vPZYcQZLjt8cKQ8rxEbDb1kQvr3C3YkmgoX5cZRI3biFqL3d6DJf8Y+tSgm
         vF3jT0PqSY2zHbEBxy3h0TZ1sHPE36eM9zzsgMaM5gw5GHX06Lx0cCn9rAtDpZamRTj+
         P/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778069880; x=1778674680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3Yb5agpPb4IBeFuX14ExkGcg3iWoEZUFma+iAeJy3o=;
        b=mPzhhyTMEmYsYc/uUnXAfYE7HsiwzF860Um45lJItKwRYOthoEqInbHTUQME4nDLux
         YntQNprY7QTZ0PxExaiqdU93xbK0PnJ8QKjYi6KFJXk2vjiGyypMjnHkrFA+rq/RdcOD
         j8VgAsB2tBiD8jTxWZG+XeOCbARduyLj7RCvnkFj6a8c4XfuVy4XOaEvnCn3mwT/Js1n
         bHtqokl/99HLu8+wbR2aYBxPi2/NdcjDXuK4nE4bgLBGEGGKVnwoF/Qpih2aIjxMF4u0
         I55TgRgeZ9DjC8McFIWpxhsB7TxESs7/Mu2DmwDzhei58Ri3aQgg4iqdMGxupMQK8lBu
         Wisg==
X-Gm-Message-State: AOJu0YzEd+3aVpNfZEjGYQWDUUox/EtweOLnpzf5SOOFPEZVgOkQxInU
	PB4au/oTokxnd2ywqcy3THW1CQD6qSi8K2TA984snhr/cfzK2sOjjiUwZ+yojQ==
X-Gm-Gg: AeBDieuouDF6s14AkscP14cWi+eLWmI7Dy2c9uiCj1q7CgSnaLFr2Mhj2Zeu3LaEk9a
	gxhwLmkfofFYQFz2/FBT6ScDG/xlKFysBuXs5OGREzGIDebDDq3ow8t4yVCy7aQeaD0BEO1dM4z
	kLamZK3IbMV4+Ic2v9B310HzEMG/AnRylTJslogmOopTrAp6pb1d0KQZgNu4EtS9lYUdfLAOGGP
	E4jHkIvVj3n2tBPOMBQ/r7RqMev74bzS/b30Jw+YwPwYa5ZKfPz9fs4Daa5vHEUV3Bql7Jrkyls
	qj6AxxWiKWci0wQxGlx6c7MC3R45xIOHmBpkcN0wgWjK/GfG/PABYK69OrZgXwu6A1mzyZS5tRU
	pLm/aQ6XIBR671/PyShBRpMaOtqFcTOqydVz6LiUugUYVmu8X97X9vqM0dJMUMr98gPCe14gnsm
	LKjvd2119G7xSV4WD4jvhW+kXHTlZT6gUrSax7ZB7XDD/3BDIO26K3cyiI6ir6injITCifyC1b2
	/qV0E4vW83WRjNWKFctcZmQBNZbOM9fQin/kpIdaNzSo4Qt1TUOv7UVVojKsjKhs/sb1NHRuVKh
X-Received: by 2002:a05:620a:2544:b0:900:8024:4f9f with SMTP id af79cd13be357-904d72c3be3mr423569485a.60.1778069879622;
        Wed, 06 May 2026 05:17:59 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c25324esm1890911685a.23.2026.05.06.05.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:17:58 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] libselinux: restorecon: revisit pinning files to avoid TOCTOU issues
Date: Wed,  6 May 2026 08:13:13 -0400
Message-ID: <20260506121312.29683-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

selinux_restorecon(3) is currently susceptible to TOCTOU issues since
it looks up pathnames multiple times when getting and setting the
SELinux contexts. Commit 7e979b56fd2cee ("libselinux: restorecon: pin
file to avoid TOCTOU issues") tried to fix this problem by opening an
O_PATH descriptor for each directory/file once and using this
descriptor for all subsequent operations on the file. However, this
commit was reverted by commit de285252a1801 ('Revert "libselinux:
restorecon: pin file to avoid TOCTOU issues"') due to it breaking
setfiles (and any other user of selinux_restorecon) when it is run
from a chroot (or mount namespace) without /proc mounted. The
dependency on /proc is a side effect of the fact that
fgetxattr/fsetxattr cannot be used with O_PATH descriptors, so glibc
internally falls back to trying to call getxattr/setxattr on
/proc/self/fd/<n> instead, which works iff /proc is mounted.

This change revives the earlier commit with the following changes:
1. Explicitly test once for /proc to decide which approach to use.
2. If /proc is mounted, directly construct the /proc/self/fd/<n> path
and call [gs]etfilecon() on this path.
3. If /proc is not mounted, continue using the path-based
l[gs]etfilecon calls as before.
4. Added helpers for safely opening each component during the file
tree walk and changed to use throughout, such that any swapping of
intermediate directories with symlinks during the tree walk and
any intermediate symlinks in the original pathname passed to
selinux_restorecon(3) are safely handled.

NB I also tried using getxattrat/setxattrat(2) but these also seem
to fail with EBADF on the O_PATH descriptors.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 switches from using f[gs]etfilecon() to directly constructing
the /proc/self/fd/<n> paths and using [gs]etfilecon() on those
paths. This avoids always trying f[gs]etxattr() and failing
with EBADF before falling back to the proc-based interface.
However, safe_open() still imposes a significant performance
overhead on every directory/file due to re-looking up every
component of every absolute pathname. I do not see a way to
access dirfds via the fts(3) interface, so I think the
next step will be to replace use of fts(3) with an open-coded
file tree walk implementation using openat() with dirfds so
that we only need to lookup each component once.

 libselinux/src/selinux_restorecon.c | 176 ++++++++++++++++++++++++++--
 1 file changed, 165 insertions(+), 11 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 35dd6441..40e2d674 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -94,6 +94,49 @@ struct rest_flags {
 	bool count_relabeled;
 };
 
+static int have_proc;
+
+static int probe_proc(void)
+{
+	struct statfs sb;
+
+	if (statfs("/proc", &sb) < 0)
+		return 0;
+	if (sb.f_type != PROC_SUPER_MAGIC)
+		return 0;
+	return 1;
+}
+
+static int fd_path_getfilecon(int fd, const char *pathname, char **con)
+{
+	char proc_path[32];
+	int rc;
+
+	if (have_proc) {
+		rc = snprintf(proc_path, sizeof(proc_path), "/proc/self/fd/%d", fd);
+		if (rc < 0 || (size_t)rc >= sizeof(proc_path))
+			return -1;
+		return getfilecon_raw(proc_path, con);
+	}
+
+	return lgetfilecon_raw(pathname, con);
+}
+
+static int fd_path_setfilecon(int fd, const char *pathname, char *con)
+{
+	char proc_path[32];
+	int rc;
+
+	if (have_proc) {
+		rc = snprintf(proc_path, sizeof(proc_path), "/proc/self/fd/%d", fd);
+		if (rc < 0 || (size_t)rc >= sizeof(proc_path))
+			return -1;
+		return setfilecon_raw(proc_path, con);
+	}
+
+	return lsetfilecon_raw(pathname, con);
+}
+
 static void restorecon_init(void)
 {
 	struct selabel_handle *sehandle = NULL;
@@ -106,6 +149,8 @@ static void restorecon_init(void)
 	efile_count = 0;
 	if (!ignore_mounts)
 		efile_count = exclude_non_seclabel_mounts();
+
+	have_proc = probe_proc();
 }
 
 static pthread_once_t fc_once = PTHREAD_ONCE_INIT;
@@ -646,8 +691,9 @@ out:
 	return rc;
 }
 
-static int restorecon_sb(const char *pathname, const struct stat *sb,
-			    const struct rest_flags *flags, bool first, bool *updated_out)
+static int restorecon_sb(int fd, const char *pathname, const struct stat *sb,
+			 const struct rest_flags *flags, bool first,
+			 bool *updated_out)
 {
 	char *newcon = NULL;
 	char *curcon = NULL;
@@ -723,7 +769,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		selinux_log(SELINUX_INFO, "%s matched by %s\n",
 			    pathname, newcon);
 
-	if (lgetfilecon_raw(pathname, &curcon) < 0) {
+	if (fd_path_getfilecon(fd, pathname, &curcon) < 0) {
 		/* Ignore files removed during relabeling if ignore_noent is set */
 		if (flags->ignore_noent && errno == ENOENT)
 			goto out;
@@ -765,7 +811,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		}
 
 		if (!flags->nochange) {
-			if (lsetfilecon(pathname, newcon) < 0) {
+			if (fd_path_setfilecon(fd, pathname, newcon) < 0) {
 				/* Ignore files removed during relabeling if ignore_noent is set */
 				if (flags->ignore_noent && errno == ENOENT)
 					goto out;
@@ -894,6 +940,87 @@ struct rest_state {
 	pthread_mutex_t mutex;
 };
 
+static int open_final(int dfd, const char *name, struct stat *sb)
+{
+	int fd;
+
+	if (name)
+		fd = openat(dfd, name, O_PATH | O_NOFOLLOW | O_CLOEXEC);
+	else
+		fd = fcntl(dfd, F_DUPFD_CLOEXEC, 0);
+	if (fd < 0)
+		return -1;
+
+	if (fstat(fd, sb) < 0) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+static int safe_open(const char *path, struct stat *sb)
+{
+	char *copy, *cur, *slash;
+	int dfd, nfd;
+
+	if (!path || path[0] == '\0') {
+		errno = ENOENT;
+		return -1;
+	}
+
+	copy = strdup(path);
+	if (!copy)
+		return -1;
+
+	if (copy[0] == '/') {
+		dfd = open("/", O_PATH | O_DIRECTORY | O_CLOEXEC);
+		cur = copy + 1;
+	} else {
+		dfd = open(".", O_PATH | O_DIRECTORY | O_CLOEXEC);
+		cur = copy;
+	}
+	if (dfd < 0) {
+		free(copy);
+		return -1;
+	}
+
+	while (*cur == '/')
+		cur++;
+
+	while (*cur != '\0') {
+		slash = strchr(cur, '/');
+		if  (slash) {
+			*slash = '\0';
+			char *next = slash + 1;
+			while (*next == '/')
+				next++;
+			if (*next != '\0') {
+				nfd = openat(dfd, cur, O_PATH | O_NOFOLLOW |
+					O_DIRECTORY | O_CLOEXEC);
+				close(dfd);
+				if (nfd < 0) {
+					free(copy);
+					return -1;
+				}
+				dfd = nfd;
+				cur = next;
+				continue;
+			}
+		}
+
+		nfd = open_final(dfd, cur, sb);
+		close(dfd);
+		free(copy);
+		return nfd;
+	}
+
+	nfd = open_final(dfd, NULL, sb);
+	close(dfd);
+	free(copy);
+	return nfd;
+}
+
 static void *selinux_restorecon_thread(void *arg)
 {
 	struct rest_state *state = arg;
@@ -1010,13 +1137,34 @@ loop_body:
 				goto finish;
 			}
 
-			ent_st = *ftsent->fts_statp;
+			int ent_fd = safe_open(ent_path, &ent_st);
+			if (ent_fd < 0) {
+				fts_set(fts, ftsent, FTS_SKIP);
+				if (state->flags.ignore_noent && errno == ENOENT)
+					continue;
+				selinux_log(SELINUX_ERROR, "Could not safely open %s: %m.\n", ent_path);
+				if (state->flags.count_errors)
+					state->skipped_errors++;
+				else
+					state->error = -1;
+				continue;
+			}
+
+			if (ent_st.st_ino != ftsent->fts_statp->st_ino ||
+				ent_st.st_dev != ftsent->fts_statp->st_dev) {
+				selinux_log(SELINUX_WARNING, "Skipping %s: changed inodes during relabel.\n", ent_path);
+				close(ent_fd);
+				fts_set(fts, ftsent, FTS_SKIP);
+				continue;
+			}
+
 			if (state->parallel)
 				__pthread_mutex_unlock(&state->mutex);
 
 			bool updated = false;
-			error = restorecon_sb(ent_path, &ent_st, &state->flags,
-					      first, &updated);
+			error = restorecon_sb(ent_fd, ent_path, &ent_st,
+					      &state->flags, first, &updated);
+			close(ent_fd);
 
 			if (state->parallel) {
 				__pthread_mutex_lock(&state->mutex);
@@ -1056,6 +1204,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
 				     size_t nthreads)
 {
 	struct rest_state state;
+	int top_fd;
 
 	state.flags.nochange = (restorecon_flags &
 		    SELINUX_RESTORECON_NOCHANGE) ? true : false;
@@ -1201,14 +1350,15 @@ static int selinux_restorecon_common(const char *pathname_orig,
 
 	paths[0] = pathname;
 
-	if (lstat(pathname, &sb) < 0) {
+	top_fd = safe_open(pathname, &sb);
+	if (top_fd < 0) {
 		if (state.flags.ignore_noent && errno == ENOENT) {
 			free(pathdnamer);
 			free(pathname);
 			return 0;
 		} else {
 			selinux_log(SELINUX_ERROR,
-				    "lstat(%s) failed: %m\n",
+				    "open(%s) failed: %m\n",
 				    pathname);
 			error = -1;
 			goto cleanup;
@@ -1221,27 +1371,31 @@ static int selinux_restorecon_common(const char *pathname_orig,
 
 	if (!state.flags.recurse) {
 		if (check_excluded(pathname)) {
+			close(top_fd);
 			error = 0;
 			goto cleanup;
 		}
 
 		bool updated = false;
-		error = restorecon_sb(pathname, &sb, &state.flags, true, &updated);
+		error = restorecon_sb(top_fd, pathname, &sb, &state.flags,
+				      true, &updated);
 		if (updated && state.flags.count_relabeled) {
 			state.relabeled_files++;
 		}
+		close(top_fd);
 		goto cleanup;
 	}
 
 	/* Obtain fs type */
 	memset(&state.sfsb, 0, sizeof(state.sfsb));
-	if (!S_ISLNK(sb.st_mode) && statfs(pathname, &state.sfsb) < 0) {
+	if (!S_ISLNK(sb.st_mode) && fstatfs(top_fd, &state.sfsb) < 0) {
 		selinux_log(SELINUX_ERROR,
 			    "statfs(%s) failed: %m\n",
 			    pathname);
 		error = -1;
 		goto cleanup;
 	}
+	close(top_fd);
 
 	/* Skip digest on in-memory filesystems and /sys */
 	if ((uint32_t)state.sfsb.f_type == (uint32_t)RAMFS_MAGIC ||
-- 
2.54.0

