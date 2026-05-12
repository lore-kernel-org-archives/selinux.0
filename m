Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6BC3A05FC
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594344; cv=none; b=uMEr9prpvcPrrhZH7NXe3O8TAsRJKEPOrjkWAgoSSTh4zIFSpUnaU/7XpTD8M4FAUyX7tveQ9g6ZjC/hbzEVXyneT+j7XCLehLrBLJ1S0yUN0rmLsmZKkBaWn0p5RX/XlbGeRK+YJSK+EtUkhUVqudZVHPzdpiz/pXj1SPkovgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594344; c=relaxed/simple;
	bh=cguTPdMNL/I91+9wXcZi4/YlJW7MhIcDiEQRfQ+YIt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FwwzmYektc+TZgfzLMk5idecqd19NLIBWKybpCrGSheqA/EN8MRzNryhxQ92PZp9H2JP7RoSHo25USlzfgyV7YBVsKgTd/F0xbqydqFVmm3DNqsvypEvmpONdBfafdtz6kXbYQQ9FR2nUwSxeIUbHoyBYuDRKJE7letlQjXTVB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKmB4wRl; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKmB4wRl"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-90ca6f20872so117107885a.0
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778594341; x=1779199141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vDrHl7xHrzvVdG9TwhsFgOs6raIe+RcI7u75cXsNZX0=;
        b=iKmB4wRl94AyUMbGIWZPnZLxfTw6rh9JkobeGdtK7ZusimpYEvk9bA8yUIKdwNqMTH
         7Tu+wRCTtg/ytLnkv0WRN69N7DmaCka+41l7pC9LG55rzByluPs5Syiwh5KHgzlAL3Ks
         w6fXN7m11nfv6tjSw8Qi/KIG+cjj4MAJdQJg5NSmvAtipHzq/YyfgRAAk/zs4YGWtVkK
         4gd+yAoEWPyWywfmAtCcfxAUko6PBDLE3a3o4/7zQOi3Czxa/19z3AKwfPmUcl4V1jF5
         +M3zN0Uu1lhhMOJkPukr5HkAnQtuClbtUX5DW/n4VhykLGUIWUTN1yxHu5i5hXLbgAFO
         8ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778594341; x=1779199141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDrHl7xHrzvVdG9TwhsFgOs6raIe+RcI7u75cXsNZX0=;
        b=cLMYfjo8yGTAzzIOhJIsSQurGiChMHAEK61AErGvQZ9Q/CrEXjlKUjdPjHc13C2FyN
         TnseR/gYHYpWm5GkXxj1HwrxcVfG+We4wzlhFG4GdCjTcZM30XnsRYldru/g9tgENDHc
         +3XI2OLSauRV5A/gLxE/mFDDPRYtvY6fCn5A9fpSiffhVFJ0SdyoLuOI9uYnyGUklESa
         EZZH1051HQ2TEJqjM0wds0HR7MrLC/4JIuWZ25OdaSp/wbJN5dBccNfaWtb9Ukj1RtuX
         jt0PMkn8NuyR+ih/aitC4K+Ozzn4Jp0ByV+JLn3tnTzl68h90UvCjwhlSVQsxa46JZ4u
         kh1A==
X-Gm-Message-State: AOJu0YwmjST2D/lZ+qSkoaGCOUFHvAZ1HUoslzrrwSwy+/7puYmATAu5
	mVaiptzJSdv5XhRNYQtvraY4yR42P59QVrihUzizu1SXm092CpCIN3y+YHlFQg==
X-Gm-Gg: Acq92OGMDffpQhZ+4Dl5dOyWbYs3yD0UFwJmh81DmjLJ9X1/gMJEddOuoQV2MCh3isP
	rCA43tejgMtFtUV1P2nfYiCU4pI2Z7eKLMz2fAlZcgBRqaDg0JU4E0UxNybH+MQ3hULOpraXo5C
	Q4Qna6A4e5KEshXyQ5gMjHS+9wtyBo82KAc8cQgS7qfyxdTS3cDULFu/iIJFHMIZFI61uSw+i3A
	Wdxd99oYU0gdryMfcDPMMdnsTYi6hgqgnL00o6dm2IqbIIb2ql37YTI+1huM7V5fgTpCFDXRdgd
	M6D7Vl+woccysvIRKtpxIZnkaZfMYCAXTWff0VgYkUOerBSftwHp+koA3XEe9Yt9a94NLS2nI5k
	I0svpIX2NmEtnEU9fJblPdJ6fwO7kO+m2iTRQCwS9y33girAAga3PTuvOzTFO+qXWap8UJVDctg
	F/km2EFkINQ1bG3TD0zv04RH4oLl43bV3U/g0wtOf/mGoi9GR6IZm9RHM5Y45cjSpdUcXVLNXd3
	MSZOE0sl+KcMJsTJxRnTwJBYiDuSooEmaaqp4ya9zdeGfa6GGm2gnI=
X-Received: by 2002:a05:620a:2596:b0:8d5:6e92:5b0c with SMTP id af79cd13be357-90cb64f9fb8mr528227585a.5.1778594341178;
        Tue, 12 May 2026 06:59:01 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b986aeccsm1327068385a.4.2026.05.12.06.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:59:00 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] restorecond: do not follow symlinks and do not relabel hard links
Date: Tue, 12 May 2026 09:58:50 -0400
Message-ID: <20260512135850.727406-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that restorecond does not follow symlinks and that it
does not relabel files with multiple hard links to prevent
any misdirection if applied to user-writable directories.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/utmpwatcher.c |   3 +-
 restorecond/watch.c       | 150 +++++++++++++++++++++++++++++++++++---
 2 files changed, 142 insertions(+), 11 deletions(-)

diff --git a/restorecond/utmpwatcher.c b/restorecond/utmpwatcher.c
index 86605203..ef4c4447 100644
--- a/restorecond/utmpwatcher.c
+++ b/restorecond/utmpwatcher.c
@@ -68,7 +68,8 @@ unsigned int utmpwatcher_handle(int inotify_fd, int wd)
 		inotify_rm_watch(inotify_fd, utmp_wd);
 
 	utmp_wd =
-	    inotify_add_watch(inotify_fd, utmp_path, IN_MOVED_FROM | IN_MODIFY);
+	    inotify_add_watch(inotify_fd, utmp_path,
+			      IN_MOVED_FROM | IN_MODIFY | IN_DONT_FOLLOW);
 	if (utmp_wd == -1)
 		exitApp("Error watching utmp file.");
 
diff --git a/restorecond/watch.c b/restorecond/watch.c
index 98ff797b..466fc1b6 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -15,6 +15,7 @@
 #include <string.h>
 #include <stdio.h>
 #include <fcntl.h>
+#include <dirent.h>
 #include <selinux/selinux.h>
 #include "restorecond.h"
 #include "stringslist.h"
@@ -45,6 +46,124 @@ int watch_list_isempty(void) {
 	return firstDir == NULL;
 }
 
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
+static void *nofollow_opendir(const char *name)
+{
+	struct stat sb;
+	int fd, rdfd;
+
+	fd = safe_open(name, &sb);
+	if (fd < 0)
+		return NULL;
+
+	if (!S_ISDIR(sb.st_mode)) {
+		close(fd);
+		errno = ENOTDIR;
+		return NULL;
+	}
+
+	rdfd = openat(fd, ".", O_RDONLY | O_DIRECTORY | O_NOFOLLOW | O_CLOEXEC);
+	close(fd);
+	if (rdfd < 0)
+		return NULL;
+	return fdopendir(rdfd);
+}
+
+static struct dirent *nofollow_readdir(void *d)
+{
+	return readdir((DIR *)d);
+}
+
+static void nofollow_closedir(void *d)
+{
+	closedir((DIR *)d);
+}
+
+static int nofollow_lstat(const char *path, struct stat *sb)
+{
+	return lstat(path, sb);
+}
+
 void watch_list_add(int fd, const char *path)
 {
 	struct watchList *ptr = NULL;
@@ -58,21 +177,30 @@ void watch_list_add(int fd, const char *path)
 	ptr = firstDir;
 	int len;
 
+	memset(&globbuf, 0, sizeof(globbuf));
+	globbuf.gl_opendir = nofollow_opendir;
+	globbuf.gl_readdir = nofollow_readdir;
+	globbuf.gl_closedir = nofollow_closedir;
+	globbuf.gl_lstat = nofollow_lstat;
+	globbuf.gl_stat = nofollow_lstat; /* never follow symlinks */
 	globbuf.gl_offs = 1;
 	if (glob(path,
-		 GLOB_TILDE | GLOB_PERIOD,
+		 GLOB_TILDE | GLOB_PERIOD | GLOB_ALTDIRFUNC,
 		 NULL,
 		 &globbuf) >= 0) {
 		for (i = 0; i < globbuf.gl_pathc; i++) {
-			len = strlen(globbuf.gl_pathv[i]) - 2;
-			if (len > 0 &&
-			    strcmp(&globbuf.gl_pathv[i][len--], "/.") == 0)
+			struct stat sb;
+			const char *p = globbuf.gl_pathv[i];
+
+			len = strlen(p) - 2;
+			if (len > 0 && strcmp(&p[len--], "/.") == 0)
+				continue;
+			if (len > 0 && strcmp(&p[len], "/..") == 0)
 				continue;
-			if (len > 0 &&
-			    strcmp(&globbuf.gl_pathv[i][len], "/..") == 0)
+			if (lstat(p, &sb) == 0 && S_ISREG(sb.st_mode) &&
+				sb.st_nlink > 1)
 				continue;
-			selinux_restorecon(globbuf.gl_pathv[i],
-					   r_opts.restorecon_flags);
+			selinux_restorecon(p, r_opts.restorecon_flags);
 		}
 		globfree(&globbuf);
 	}
@@ -89,7 +217,8 @@ void watch_list_add(int fd, const char *path)
 
 	if (!ptr) exitApp("Out of Memory");
 
-	ptr->wd = inotify_add_watch(fd, dir, IN_CREATE | IN_MOVED_TO);
+	ptr->wd = inotify_add_watch(fd, dir,
+				    IN_CREATE | IN_MOVED_TO |IN_DONT_FOLLOW);
 	if (ptr->wd == -1) {
 		free(ptr);
 		if (! run_as_user)
@@ -281,7 +410,8 @@ void read_config(int fd, const char *watch_file_path)
 
 	inotify_rm_watch(fd, master_wd);
 	master_wd =
-	    inotify_add_watch(fd, watch_file_path, IN_MOVED_FROM | IN_MODIFY);
+	    inotify_add_watch(fd, watch_file_path,
+			      IN_MOVED_FROM | IN_MODIFY | IN_DONT_FOLLOW);
 	if (master_wd == -1)
 		exitApp("Error watching config file.");
 }
-- 
2.54.0

