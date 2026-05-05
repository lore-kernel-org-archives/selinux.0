Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE5F346AC0
	for <selinux@vger.kernel.org>; Tue,  5 May 2026 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007045; cv=none; b=k7YVTFe6/oVWFLgtCrl5FskVEp5cBNdGlkj+bdr5sJwh5z6YCneJT/66iD+LV/isRFRY3a/vGXLUF/MPOGJzvfV/3jBGaozA87qXpGcUFBegu/3bcsEbO8eE8BJJ37LbT8oDO2yWKxXt9jJkh6GJK2GH7537A3HxqEySQUDqYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007045; c=relaxed/simple;
	bh=F/WLavOdPlQldrSzNHBv4Rt/vEixI6aF01mFI38lCno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQZRxdgag8vuUAX8pfgy86p+MIVkvkaLuHJzrmRi9VE46wS+2ehtflZfX8zYA2K46x1KoCvpfw5SsW8sVHalTOF+cYBomvUGq9EkKmRRRLlIjGlEUeY+wAhmzbo7Iox3+2RugRmPs6My9uKMfhm4jA6DORe+4zIp8R2euRNv2Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4XHYyEE; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4XHYyEE"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8eae9229110so904959985a.1
        for <selinux@vger.kernel.org>; Tue, 05 May 2026 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778007043; x=1778611843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DA6YJataZd8hUVQendVD0CrmtngJXZywZfuekyBK05g=;
        b=J4XHYyEE8HGd/u43ur42BycBmmu7/+6IPxfmMaRYkDDzkIGqmmTi20BoZ3Aee1Fv8j
         ARUgTkeI3ESmGnivaIo43KABr2UGrZO51qQpvInlcwlC9FlLO9EHq2KtoC5z83afQk5v
         cCzqxsAWArr6I5Xl8qhexwWx6iqQ6kWbitxpcPCXBFptyeQRL+cXEQmQyspS6vWdxMX5
         uhvu5Pq7Cysa3SR6ZHOxevfYRlN5K632216I3uu7+GyeSEdA2E3RXj5i4lKeEtBSG+0a
         nVl01z236BbmSoTlGC4Ag792vu+s+t5cQ+K2jKGpjMC1/EqInra9JQ3Lu3PhlV1KKktx
         RfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778007043; x=1778611843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA6YJataZd8hUVQendVD0CrmtngJXZywZfuekyBK05g=;
        b=bTM2Tytvy/wLKrk1O2k18gAw9rjMzWmk0llYb6mLi/vRKkccBF8JotGcI1pKxxCNOs
         IKa6Pxo5SUzkZ4VUTGoQFnrPEBhvKvQdxj4Qf/J1D63rkmi6q+S0bvVWybuWtsqhIdOp
         wAHcWSbrHZfXEnTg6o1Q8fRr2oJ9uNF39oCiZYBnna/5Ffzthp498/mz9eikD3jskVKF
         A8/idwgz1wplAG7qxiQ7elCphyYAEF47LX754YIVfunHILQnR+jRvPmE9an/DNESw31R
         24cP1trva8t3eLfo9g0PgzcDBOgX9gxDwp8KpGaXDIAUkuyn8Skaqf2hbNkMc8fMBPZn
         NLnw==
X-Gm-Message-State: AOJu0YwOKx144R9e3sFsw1qTQXFMoOAk4RXYFVvEC8xlyL3jA8r+t65C
	c+4JuACjMHkE99nOxysbukjnPOLUYhpsRegd4UuGkEZn4kDcUVsAKyP3Ar63yQ==
X-Gm-Gg: AeBDieupxWvHfRwioZ0klO1OvOk72EgOUYG6YN0LEvxAMW81vbjleryf0DPAKezpQyR
	4NWtujta0a6SBGyr2eyg9vt7hL91zUdlKOhy4clFaP48sCU669gFBDQ0/O3wSnW8Z+f81wRxloV
	mX0CXH/S+Fe1d/Ie4IDTcd9KW0STUgAYozSjyg6Ab6VK4nPwTwNH+XcaDuL0ShLcdWppNsQwuZ1
	uxVmgaAvEljhbdxXxG4mSiRmvwmfMc/3y3SLpMkgZAqZI5yTH0sYriSvahcHArNKIxrGgZUil3c
	9UmeIoDvyjSMGmBY9KHctR0QRnkfaxWReAIVJlHr29mK2dW/h0SgHntCdRdmPFSsDAeFuefsYfM
	NG2xB9TtXilNcb5SRwaTQdmKPVJ03ZVe20z9MFVxwWe9SBN8FtEv18UawFTBA8CnjTKXFGUTyPj
	rGMvRbOzZurQ3sAsBlahQackUdj/VDfX5fkJq+8X+IAG3FJUBDUgYqGG+qZbYdI9zbV46GTVAnm
	ezvyExJeZBBw1uhFiynqjlxs3oyB6iPmAfd5c3TVfRGzbzlK6Ypawf2lVSGwJDcHg==
X-Received: by 2002:a05:620a:f0c:b0:8f8:8860:fbad with SMTP id af79cd13be357-904d72c3634mr37977585a.57.1778007042774;
        Tue, 05 May 2026 11:50:42 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c253bc9sm1583934885a.27.2026.05.05.11.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:50:42 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: restorecon: revisit pinning files to avoid TOCTOU issues
Date: Tue,  5 May 2026 14:50:17 -0400
Message-ID: <20260505185017.18428-1-stephen.smalley.work@gmail.com>
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
/proc/self/fd/<n> instead, which works iff /proc is mounted. This
change revives the earlier changes but provides a fallback for the
case where /proc is not mounted. This change also cover the handling
of the original pathname passed into selinux_restorecon(3).

NB I also tried using getxattrat/setxattrat(2) but these also seem
to fail with EBADF on the O_PATH descriptors.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_restorecon.c | 173 ++++++++++++++++++++++++++--
 1 file changed, 162 insertions(+), 11 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 35dd6441..12199200 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -21,6 +21,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/xattr.h>
+#include <sys/syscall.h>
 #include <sys/vfs.h>
 #include <sys/statvfs.h>
 #include <sys/utsname.h>
@@ -94,6 +95,45 @@ struct rest_flags {
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
+	int rc;
+
+	if (have_proc) {
+		rc = fgetfilecon_raw(fd, con);
+		if (rc >= 0 || errno != EBADF)
+			return rc;
+	}
+
+	return lgetfilecon_raw(pathname, con);
+}
+
+static int fd_path_setfilecon(int fd, const char *pathname, char *con)
+{
+	int rc;
+
+	if (have_proc) {
+		rc = fsetfilecon_raw(fd, con);
+		if (rc >= 0 || errno != EBADF)
+			return rc;
+	}
+
+	return lsetfilecon_raw(pathname, con);
+}
+
 static void restorecon_init(void)
 {
 	struct selabel_handle *sehandle = NULL;
@@ -106,6 +146,8 @@ static void restorecon_init(void)
 	efile_count = 0;
 	if (!ignore_mounts)
 		efile_count = exclude_non_seclabel_mounts();
+
+	have_proc = probe_proc();
 }
 
 static pthread_once_t fc_once = PTHREAD_ONCE_INIT;
@@ -646,8 +688,9 @@ out:
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
@@ -723,7 +766,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		selinux_log(SELINUX_INFO, "%s matched by %s\n",
 			    pathname, newcon);
 
-	if (lgetfilecon_raw(pathname, &curcon) < 0) {
+	if (fd_path_getfilecon(fd, pathname, &curcon) < 0) {
 		/* Ignore files removed during relabeling if ignore_noent is set */
 		if (flags->ignore_noent && errno == ENOENT)
 			goto out;
@@ -765,7 +808,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		}
 
 		if (!flags->nochange) {
-			if (lsetfilecon(pathname, newcon) < 0) {
+			if (fd_path_setfilecon(fd, pathname, newcon) < 0) {
 				/* Ignore files removed during relabeling if ignore_noent is set */
 				if (flags->ignore_noent && errno == ENOENT)
 					goto out;
@@ -894,6 +937,87 @@ struct rest_state {
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
@@ -1010,13 +1134,34 @@ loop_body:
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
@@ -1056,6 +1201,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
 				     size_t nthreads)
 {
 	struct rest_state state;
+	int top_fd;
 
 	state.flags.nochange = (restorecon_flags &
 		    SELINUX_RESTORECON_NOCHANGE) ? true : false;
@@ -1201,14 +1347,15 @@ static int selinux_restorecon_common(const char *pathname_orig,
 
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
@@ -1221,27 +1368,31 @@ static int selinux_restorecon_common(const char *pathname_orig,
 
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

