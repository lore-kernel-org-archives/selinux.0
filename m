Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADFA42EEC0
	for <selinux@vger.kernel.org>; Mon, 11 May 2026 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517096; cv=none; b=Zy2TReLPxTWjbY5xJXvHoiuim/G28uhYJU+KnV1CHnHHFC65AbcAKAL4Q7jS2w1fG0fk9NLQZ1nEOWUlmPzlrNGpjkzILFomSV5XwRFhhSKGPxqIaWbci6xbNDOPnEGDZYHvgSAdEelqoFaJVhwMGXVlk3o3dGkLPgLuVtV65rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517096; c=relaxed/simple;
	bh=Lr7avo90sYdqQQs2F7DKz7lk+1u6GHQX1f5dr3U/dVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3XFeHHoSYFIMqGitMqTshg/qHjVHIV5ZEBzhhaItIez8CdngYYqLwTAVj1FOYMT2RSl5abNEiW5fLEZfY9bD5ffqodUPKPmTj6MltM6o86M013BIhsNdDHj4+pojrDFUW3HGsO8L0XXihvV20hTZaSiO2EJVGcBUCe7sT+ovoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6m/Twq6; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6m/Twq6"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56f70865797so2392928e0c.1
        for <selinux@vger.kernel.org>; Mon, 11 May 2026 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778517092; x=1779121892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7GOe+UpkE/pe0HarpapKuipo4jPPgabOj3pph8w+ZHY=;
        b=K6m/Twq6Q+9yFhtXIeDRp7jFOtMm7nwcsKYj1sWowgHl7cnozzZy5MF7zQ8P8YHTp3
         Iv+wMRS5ifwWlt9WxD/jZlmd0VCM/y5Fo7fbV5dDJXSdRLGPkvl6L8dwGWnu5u75xaWX
         K5ZFAP3y5TMcqS2jzd0RC9nrYTU+D4zX8mF4a6vx+HYnqnJB/cmI6od8C9SzmJ+6th/Y
         VP24zHfTi6MNXWYlzs0+QJqQIJOulzhdidWmLOrVhl7lQHpcBFy7ymn/WXtJiR+pDBIf
         GYsYArwCwZllJbaaZgj6t9v8miib41gSKsRClG/d4FYYw2pD3YHEUVMm+7WGTis2qTW7
         wtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517092; x=1779121892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GOe+UpkE/pe0HarpapKuipo4jPPgabOj3pph8w+ZHY=;
        b=G+2dfgEkzE6tmxcQnqHZr4ZPxOwQiwDGW+isImvHQmo6v9Q9TlWAzoCU8AQuAytU+l
         k3GgKqjB1SiNR0RHnxq5LYsPtw6aYoSoVw63+ybS7jjYYed0y8k+naj4ptekPzObpkrg
         TC1p2p9TT09Do1g8p/eDkQhcq6ap/Kjg5/2HGNl+QzyuPhz5oi6jc3BMe7iVxhwf4zBl
         +7jxtTCXPajWSj7BrsNlgNXd89nTSTmacRIiZZ7pUI8b8hztxCKtlmmaF8MdoCH5MBOb
         LVszQxxaLnpW4rZiCCqdxwW3x+k4B70YYTpFIYX3ByAA6minlIrdvBwnvVR63O7iEK9m
         35tQ==
X-Gm-Message-State: AOJu0YzOr8jzcXx1atmrFToEweO1s+2HdlRyf7xEB+tt1WrM6rTQVF+2
	HRdF1rZJUAxHU+0dysqWN+ERRAd3SZilpzi6X2f3mj4SU6V4oe0ezzgHnx/GgQ==
X-Gm-Gg: Acq92OEr4aztqHr4TIsoNG8PRkUaUpkjrG45gk9kqsfLmb7hRWmGvWUW5ytTRK3Sd8s
	HxY9rF85EIZBZGGO3z4aoxpVRVmSp4V/GTdZgwUnK2f8NWz7HKwqn51D3y2NF1LSL0+PUZrSLQX
	zdTOWLFog/zvJ3D2RnW2Sgp9KzYT2/1zhT5f4R4MxybT1cdVwfE6aCO5xVHQQlARipBg2dpZX8n
	uTxyb1u/K/ka9R9GzKOG5xrkj+Xh8bRXZBmjgqIXn1bFkuV0OCF4Hsm3KR7SOVXjkfJvPcI7QAN
	QvyDxJdGLCkl7QjXF42BFc5jbqyCRFufuW0MxuiEuRPeLjgOAR6/PBj6i4aqqq6brEfPeeKm4pI
	CcJ68h48bTMFmgPt9Q7K/STeVKdDbWmjYBUPR0kqZ0J8PN69Ag8PaZddApWaxolRWubQA3GCt5e
	8UaaOt0LqcwblSPF3J/RNNY47paHgLwyD2s1Uy307uWoj4+CabqfXL2+8cetclkD/iYYZ3iTazN
	AZbhM4fQT3MoaYcskhzVKdsJhAT4oQNum6A0jc8n0XjJpBWEVL9JEbntPXvrdzHcZ/zDLGetCNo
X-Received: by 2002:a05:6102:290b:b0:631:7781:fe91 with SMTP id ada2fe7eead31-631778225d8mr5469522137.9.1778517091924;
        Mon, 11 May 2026 09:31:31 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8d9ea06sm1087621885a.20.2026.05.11.09.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:31:31 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	cgzones@googlemail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4] libselinux: restorecon: revisit pinning files to avoid TOCTOU issues
Date: Mon, 11 May 2026 12:30:28 -0400
Message-ID: <20260511163027.370968-2-stephen.smalley.work@gmail.com>
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
dependency on /proc is a side effect of the fact that f[gs]etxattr
cannot be used with O_PATH descriptors, so f[gs]etfilecon internally
fall back to trying to call getxattr/setxattr on /proc/self/fd/<n>
instead, which works iff /proc is mounted.

This change revives the earlier commit with the following changes:
1. Explicitly test once for /proc to decide which approach to use.
2. If /proc is mounted, directly construct the /proc/self/fd/<n> path
and call [gs]etfilecon() on this path.
3. If /proc is not mounted, continue using the path-based
l[gs]etfilecon calls as before.
4. Introduce a safe_open() helper for safely opening a pathname
without following any symlinks and changed selinux_restorecon() to use
when opening the initial pathname. NB This occurs after any use
of realpath(3) when SELINUX_RESTORECON_REALPATH is specified by
the caller, which will follow symlinks.
5. Re-implement the file tree walk without using fts(3) or nftw(3) so
that we can avoid having to re-lookup the entire pathname at each
node.

NB I also tried using getxattrat/setxattrat(2) but these also seem
to fail with EBADF on the O_PATH descriptors.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v4 fixes some inaccuracies in the patch description but is otherwise
unchanged from v3.

 libselinux/src/selinux_restorecon.c | 601 +++++++++++++++++++++-------
 1 file changed, 458 insertions(+), 143 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 35dd6441..ca36b7de 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -15,6 +15,7 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <fts.h>
+#include <dirent.h>
 #include <inttypes.h>
 #include <limits.h>
 #include <stdint.h>
@@ -94,6 +95,49 @@ struct rest_flags {
 	bool count_relabeled;
 };
 
+static bool have_proc;
+
+static bool probe_proc(void)
+{
+	struct statfs sb;
+
+	if (statfs("/proc", &sb) < 0)
+		return false;
+	if (sb.f_type != PROC_SUPER_MAGIC)
+		return false;
+	return true;
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
@@ -106,6 +150,8 @@ static void restorecon_init(void)
 	efile_count = 0;
 	if (!ignore_mounts)
 		efile_count = exclude_non_seclabel_mounts();
+
+	have_proc = probe_proc();
 }
 
 static pthread_once_t fc_once = PTHREAD_ONCE_INIT;
@@ -646,8 +692,9 @@ out:
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
@@ -723,7 +770,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		selinux_log(SELINUX_INFO, "%s matched by %s\n",
 			    pathname, newcon);
 
-	if (lgetfilecon_raw(pathname, &curcon) < 0) {
+	if (fd_path_getfilecon(fd, pathname, &curcon) < 0) {
 		/* Ignore files removed during relabeling if ignore_noent is set */
 		if (flags->ignore_noent && errno == ENOENT)
 			goto out;
@@ -765,7 +812,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		}
 
 		if (!flags->nochange) {
-			if (lsetfilecon(pathname, newcon) < 0) {
+			if (fd_path_setfilecon(fd, pathname, newcon) < 0) {
 				/* Ignore files removed during relabeling if ignore_noent is set */
 				if (flags->ignore_noent && errno == ENOENT)
 					goto out;
@@ -875,6 +922,13 @@ oom:
 	goto free;
 }
 
+struct walk_level {
+	DIR *dirp;
+	dev_t dev;
+	ino_t ino;
+	size_t pathlen;
+};
+
 struct rest_state {
 	struct rest_flags flags;
 	dev_t dev_num;
@@ -883,8 +937,14 @@ struct rest_state {
 	bool setrestorecondigest;
 	bool parallel;
 
-	FTS *fts;
-	FTSENT *ftsent_first;
+	struct walk_level *stack;
+	size_t depth;
+	size_t stack_cap;
+	char pathbuf[PATH_MAX];
+
+	int root_fd;
+	struct stat root_sb;
+
 	struct dir_hash_node *head, *current;
 	bool abort;
 	int error;
@@ -894,97 +954,357 @@ struct rest_state {
 	pthread_mutex_t mutex;
 };
 
+static int walk_push(struct rest_state *st, int rdfd, dev_t dev, ino_t ino,
+		     size_t pathlen)
+{
+	struct walk_level *wl;
+	DIR *dirp;
+
+	if (st->depth == st->stack_cap) {
+		size_t ncap = st->stack_cap ? st->stack_cap * 2 : 16;
+		struct walk_level *n = reallocarray(st->stack, ncap,
+						    sizeof(*st->stack));
+		if (!n) {
+			close(rdfd);
+			return -1;
+		}
+		st->stack = n;
+		st->stack_cap = ncap;
+	}
+
+	dirp = fdopendir(rdfd);
+	if (!dirp) {
+		close(rdfd);
+		return -1;
+	}
+
+	wl = &st->stack[st->depth];
+	wl->dirp = dirp;
+	wl->dev = dev;
+	wl->ino = ino;
+	wl->pathlen = pathlen;
+	st->depth++;
+	return 0;
+}
+
+static inline void prune_pathbuf(struct rest_state *st)
+{
+	if (st->depth)
+		st->pathbuf[st->stack[st->depth - 1].pathlen] = '\0';
+}
+
+static void walk_pop(struct rest_state *st)
+{
+	if (st->depth == 0)
+		return;
+	st->depth--;
+	closedir(st->stack[st->depth].dirp);
+	prune_pathbuf(st);
+}
+
+static void walk_free(struct rest_state *st)
+{
+	while (st->depth)
+		walk_pop(st);
+	free(st->stack);
+	st->stack = NULL;
+	st->stack_cap = 0;
+}
+
+static size_t walk_path_append(struct rest_state *st, const char *name)
+{
+	size_t base = st->stack[st->depth - 1].pathlen;
+	size_t nlen = strlen(name);
+	bool need_slash = (base > 0 && st->pathbuf[base - 1] != '/');
+	size_t total = base + (need_slash ? 1 : 0) + nlen;
+
+	if (total >= sizeof(st->pathbuf))
+		return (size_t)-1;
+
+	if (need_slash)
+		st->pathbuf[base++] = '/';
+	memcpy(st->pathbuf + base, name, nlen);
+	st->pathbuf[base + nlen] = '\0';
+	return base + nlen;
+}
+
+static bool walk_is_cycle(const struct rest_state *st, dev_t dev, ino_t ino)
+{
+	for (size_t i = 0; i < st->depth; i++)
+		if (st->stack[i].dev == dev && st->stack[i].ino == ino)
+			return true;
+	return false;
+}
+
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
+/*
+ * Returns 1 if we successfully filled ent_* with the next entry
+ * to process, 0 on clean end-of-walk, -1 with errno set on
+ * fatal failure from readdir() or path too long.
+ */
+static int walk_next(struct rest_state *state, int *ent_fd, int *rd_fd,
+		     struct stat *ent_sb, char *ent_path, size_t ent_path_sz,
+		     size_t *ent_pathlen)
+{
+	if (state->root_fd >= 0) {
+		int fd = state->root_fd;
+
+		state->root_fd = -1;
+		*ent_fd = fd;
+		*ent_sb = state->root_sb;
+		*ent_pathlen = strlen(state->pathbuf);
+		strlcpy(ent_path, state->pathbuf, ent_path_sz);
+		*rd_fd = -1;
+		if (S_ISDIR(state->root_sb.st_mode)) {
+			*rd_fd = openat(fd, ".", O_RDONLY | O_DIRECTORY |
+					O_NOFOLLOW | O_CLOEXEC);
+			if (*rd_fd < 0 &&
+			    (!state->flags.ignore_noent || errno != ENOENT))
+				selinux_log(SELINUX_ERROR,
+					"Could not read %s: %m\n",
+					state->pathbuf);
+		}
+		return 1;
+	}
+
+	while (state->depth) {
+		struct walk_level *top = &state->stack[state->depth - 1];
+		int pdfd = dirfd(top->dirp);
+		struct dirent *de;
+
+		errno = 0;
+		de = readdir(top->dirp);
+		if (!de) {
+			if (errno)
+				return -1;
+			walk_pop(state);
+			continue;
+		}
+
+		if (de->d_name[0] == '.' &&
+		    (de->d_name[1] == '\0' ||
+		     (de->d_name[1] == '.' && de->d_name[2] == '\0')))
+			continue;
+
+		size_t plen = walk_path_append(state, de->d_name);
+		if (plen == (size_t)-1) {
+			selinux_log(SELINUX_ERROR,
+				"Path name too long under %.*s.\n",
+				(int)top->pathlen, state->pathbuf);
+			errno = ENAMETOOLONG;
+			return -1;
+		}
+
+		int fd = openat(pdfd, de->d_name,
+				O_PATH | O_NOFOLLOW | O_CLOEXEC);
+		if (fd < 0) {
+			if (!state->flags.ignore_noent || errno != ENOENT)
+				selinux_log(SELINUX_ERROR,
+					    "Could not open %s: %m.\n",
+					    state->pathbuf);
+			state->pathbuf[top->pathlen] = '\0';
+			continue;
+		}
+		if (fstat(fd, ent_sb) < 0) {
+			selinux_log(SELINUX_ERROR,
+				    "Could not stat %s: %m.\n",
+				    state->pathbuf);
+			close(fd);
+			state->pathbuf[top->pathlen] = '\0';
+			continue;
+		}
+
+		int rdfd = -1;
+		if (S_ISDIR(ent_sb->st_mode)) {
+			rdfd = openat(fd, ".",
+				      O_RDONLY | O_DIRECTORY |
+				      O_NOFOLLOW | O_CLOEXEC);
+			if (rdfd < 0) {
+				if (!state->flags.ignore_noent || errno != ENOENT)
+					selinux_log(SELINUX_ERROR,
+						"Could not open %s: %m.\n",
+						state->pathbuf);
+			}
+		}
+
+		strlcpy(ent_path, state->pathbuf, ent_path_sz);
+		*ent_pathlen = plen;
+		*ent_fd = fd;
+		*rd_fd = rdfd;
+
+		if (rdfd < 0)
+			state->pathbuf[top->pathlen] = '\0';
+
+		return 1;
+	}
+
+	return 0;
+}
+
 static void *selinux_restorecon_thread(void *arg)
 {
 	struct rest_state *state = arg;
-	FTS *fts = state->fts;
-	FTSENT *ftsent;
-	int error;
+	int error, rc;
+	int ent_fd, rd_fd;
+	struct stat ent_sb;
+	size_t ent_pathlen;
 	char ent_path[PATH_MAX];
-	struct stat ent_st;
 	bool first = false;
 
 	if (state->parallel)
 		__pthread_mutex_lock(&state->mutex);
 
-	if (state->ftsent_first) {
-		ftsent = state->ftsent_first;
-		state->ftsent_first = NULL;
+	if (state->root_fd >= 0)
 		first = true;
-		goto loop_body;
-	}
 
-	while (((void)(errno = 0), ftsent = fts_read(fts)) != NULL) {
-loop_body:
-		/* If the FTS_XDEV flag is set and the device is different */
-		if (state->flags.set_xdev &&
-		    ftsent->fts_statp->st_dev != state->dev_num)
-			continue;
+	while ((rc = walk_next(state, &ent_fd, &rd_fd, &ent_sb,
+			       ent_path, sizeof(ent_path),
+			       &ent_pathlen)) == 1) {
+		if (state->abort) {
+			close(ent_fd);
+			if (rd_fd >= 0)
+				close(rd_fd);
+			goto unlock;
+		}
 
-		switch (ftsent->fts_info) {
-		case FTS_DC:
-			selinux_log(SELINUX_ERROR,
-				    "Directory cycle on %s.\n",
-				    ftsent->fts_path);
-			errno = ELOOP;
-			state->error = -1;
-			state->abort = true;
-			goto finish;
-		case FTS_DP:
-			continue;
-		case FTS_DNR:
-			error = errno;
-			errno = ftsent->fts_errno;
-			if (!state->flags.ignore_noent || errno != ENOENT)
-				selinux_log(SELINUX_ERROR,
-					    "Could not read %s: %m.\n",
-					    ftsent->fts_path);
-			errno = error;
-			fts_set(fts, ftsent, FTS_SKIP);
+		bool is_dir = S_ISDIR(ent_sb.st_mode);
+		bool descend = (rd_fd >= 0);
+
+		/* Emulate FTS_XDEV behavior */
+		if (state->flags.set_xdev && ent_sb.st_dev != state->dev_num) {
+			close(ent_fd);
+			if (rd_fd >= 0)
+				close(rd_fd);
+			prune_pathbuf(state);
 			continue;
-		case FTS_NS:
-			error = errno;
-			errno = ftsent->fts_errno;
-			if (!state->flags.ignore_noent || errno != ENOENT)
+		}
+
+		if (is_dir) {
+			if (descend &&
+			    walk_is_cycle(state, ent_sb.st_dev,
+				          ent_sb.st_ino)) {
 				selinux_log(SELINUX_ERROR,
-					    "Could not stat %s: %m.\n",
-					    ftsent->fts_path);
-			errno = error;
-			fts_set(fts, ftsent, FTS_SKIP);
-			continue;
-		case FTS_ERR:
-			error = errno;
-			errno = ftsent->fts_errno;
-			selinux_log(SELINUX_ERROR,
-				    "Error on %s: %m.\n",
-				    ftsent->fts_path);
-			errno = error;
-			fts_set(fts, ftsent, FTS_SKIP);
-			continue;
-		case FTS_D:
+					    "Directory cycle on %s.\n",
+					    ent_path);
+				close(ent_fd);
+				close(rd_fd);
+				errno = ELOOP;
+				state->error = -1;
+				state->abort = true;
+				goto finish;
+			}
+
 			if (state->sfsb.f_type == SYSFS_MAGIC &&
-			    !selabel_partial_match(fc_sehandle,
-			    ftsent->fts_path)) {
-				fts_set(fts, ftsent, FTS_SKIP);
+			    !selabel_partial_match(fc_sehandle, ent_path)) {
+				close(ent_fd);
+				if (rd_fd >= 0)
+					close(rd_fd);
+				prune_pathbuf(state);
 				continue;
 			}
 
-			if (check_excluded(ftsent->fts_path)) {
-				fts_set(fts, ftsent, FTS_SKIP);
+			if (check_excluded(ent_path)) {
+				close(ent_fd);
+				if (rd_fd >= 0)
+					close(rd_fd);
+				prune_pathbuf(state);
 				continue;
 			}
 
 			if (state->setrestorecondigest) {
 				struct dir_hash_node *new_node = NULL;
 
-				if (check_context_match_for_dir(ftsent->fts_path,
+				if (check_context_match_for_dir(ent_path,
 								&new_node,
 								state->error) &&
 								!state->ignore_digest) {
 					selinux_log(SELINUX_INFO,
 						"Skipping restorecon on directory(%s)\n",
-						    ftsent->fts_path);
-					fts_set(fts, ftsent, FTS_SKIP);
+						    ent_path);
+					close(ent_fd);
+					if (rd_fd >= 0)
+						close(rd_fd);
+					prune_pathbuf(state);
 					continue;
 				}
 
@@ -998,48 +1318,52 @@ loop_body:
 					}
 				}
 			}
-			/* fall through */
-		default:
-			if (strlcpy(ent_path, ftsent->fts_path, sizeof(ent_path)) >= sizeof(ent_path)) {
-				selinux_log(SELINUX_ERROR,
-					    "Path name too long on %s.\n",
-					    ftsent->fts_path);
-				errno = ENAMETOOLONG;
-				state->error = -1;
-				state->abort = true;
-				goto finish;
-			}
 
-			ent_st = *ftsent->fts_statp;
-			if (state->parallel)
-				__pthread_mutex_unlock(&state->mutex);
-
-			bool updated = false;
-			error = restorecon_sb(ent_path, &ent_st, &state->flags,
-					      first, &updated);
-
-			if (state->parallel) {
-				__pthread_mutex_lock(&state->mutex);
-				if (state->abort)
-					goto unlock;
-			}
-
-			first = false;
-			if (error) {
-				if (state->flags.abort_on_error) {
-					state->error = error;
+			if (descend) {
+				if (walk_push(state, rd_fd, ent_sb.st_dev,
+					      ent_sb.st_ino, ent_pathlen) < 0) {
+					close(ent_fd);
+					errno = ENOMEM;
+					state->error = -1;
 					state->abort = true;
 					goto finish;
 				}
-				if (state->flags.count_errors)
-					state->skipped_errors++;
-				else
-					state->error = error;
-			} else if (updated && state->flags.count_relabeled) {
-				state->relabeled_files++;
 			}
-			break;
 		}
+
+		if (state->parallel)
+			__pthread_mutex_unlock(&state->mutex);
+
+		bool updated = false;
+		error = restorecon_sb(ent_fd, ent_path, &ent_sb,
+				      &state->flags, first, &updated);
+		close(ent_fd);
+
+		if (state->parallel) {
+			__pthread_mutex_lock(&state->mutex);
+			if (state->abort)
+				goto unlock;
+		}
+
+		first = false;
+		if (error) {
+			if (state->flags.abort_on_error) {
+				state->error = error;
+				state->abort = true;
+				goto finish;
+			}
+			if (state->flags.count_errors)
+				state->skipped_errors++;
+			else
+				state->error = error;
+		} else if (updated && state->flags.count_relabeled) {
+			state->relabeled_files++;
+		}
+	}
+
+	if (rc < 0) {
+		state->error = -1;
+		state->abort = true;
 	}
 
 finish:
@@ -1056,6 +1380,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
 				     size_t nthreads)
 {
 	struct rest_state state;
+	int top_fd;
 
 	state.flags.nochange = (restorecon_flags &
 		    SELINUX_RESTORECON_NOCHANGE) ? true : false;
@@ -1105,11 +1430,14 @@ static int selinux_restorecon_common(const char *pathname_orig,
 	state.skipped_errors = 0;
 	state.relabeled_files = 0;
 	state.saved_errno = 0;
+	state.stack = NULL;
+	state.depth = 0;
+	state.stack_cap = 0;
+	state.root_fd = -1;
 
 	struct stat sb;
 	char *pathname = NULL, *pathdnamer = NULL, *pathdname, *pathbname;
-	char *paths[2] = { NULL, NULL };
-	int fts_flags, error;
+	int error;
 	struct dir_hash_node *current = NULL;
 
 	if (state.flags.verbose && state.flags.progress)
@@ -1199,16 +1527,15 @@ static int selinux_restorecon_common(const char *pathname_orig,
 			goto oom;
 	}
 
-	paths[0] = pathname;
-
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
@@ -1221,25 +1548,29 @@ static int selinux_restorecon_common(const char *pathname_orig,
 
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
+		close(top_fd);
 		goto cleanup;
 	}
 
@@ -1248,29 +1579,19 @@ static int selinux_restorecon_common(const char *pathname_orig,
 		state.sfsb.f_type == TMPFS_MAGIC || state.sfsb.f_type == SYSFS_MAGIC)
 		state.setrestorecondigest = false;
 
-	if (state.flags.set_xdev)
-		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR | FTS_XDEV;
-	else
-		fts_flags = FTS_PHYSICAL | FTS_NOCHDIR;
-
-	state.fts = fts_open(paths, fts_flags, NULL);
-	if (!state.fts)
-		goto fts_err;
-
-	state.ftsent_first = fts_read(state.fts);
-	if (!state.ftsent_first)
-		goto fts_err;
+	state.dev_num = sb.st_dev;
 
-	/*
-	 * Keep the inode of the first device. This is because the FTS_XDEV
-	 * flag tells fts not to descend into directories with different
-	 * device numbers, but fts will still give back the actual directory.
-	 * By saving the device number of the directory that was passed to
-	 * selinux_restorecon() and then skipping all actions on any
-	 * directories with a different device number when the FTS_XDEV flag
-	 * is set (from http://marc.info/?l=selinux&m=124688830500777&w=2).
-	 */
-	state.dev_num = state.ftsent_first->fts_statp->st_dev;
+	if (strlcpy(state.pathbuf, pathname, sizeof(state.pathbuf)) >=
+		    sizeof(state.pathbuf)) {
+		selinux_log(SELINUX_ERROR, "Path name too long: %s.\n",
+			    pathname);
+		close(top_fd);
+		errno = ENAMETOOLONG;
+		error = -1;
+		goto cleanup;
+	}
+	state.root_fd = top_fd;
+	state.root_sb = sb;
 
 	if (nthreads == 1) {
 		state.parallel = false;
@@ -1326,7 +1647,6 @@ static int selinux_restorecon_common(const char *pathname_orig,
 
 	/*
 	 * Labeling successful. Write partial match digests for subdirectories.
-	 * TODO: Write digest upon FTS_DP if no error occurs in its descents.
 	 * Note: we can't ignore errors here that we've masked due to
 	 * SELINUX_RESTORECON_COUNT_ERRORS.
 	 */
@@ -1352,9 +1672,11 @@ out:
 	if (state.flags.progress && state.flags.mass_relabel)
 		fprintf(stdout, "\r%s 100.0%%\n", pathname);
 
-	(void) fts_close(state.fts);
 	errno = state.saved_errno;
 cleanup:
+	if (state.root_fd >= 0)
+		close(state.root_fd);
+	walk_free(&state);
 	relabeled_files = state.relabeled_files;
 	if (state.flags.add_assoc) {
 		if (state.flags.verbose)
@@ -1385,13 +1707,6 @@ realpatherr:
 		    pathname_orig);
 	error = -1;
 	goto cleanup;
-
-fts_err:
-	selinux_log(SELINUX_ERROR,
-		    "fts error while labeling %s: %m\n",
-		    paths[0]);
-	error = -1;
-	goto cleanup;
 }
 
 
-- 
2.54.0

