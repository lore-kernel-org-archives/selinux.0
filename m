Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388550;
	b=tQHBfWADRkoraYtXNLGBi0OP7wkKUL+aY7PPUefCY1u7RkJVU3k4V59rAgcMYkxlPXP5
	 JZZL7UF4tydv8Vi5speABYg8/Ax0TjuNAl+9LHyD9mH3B2Ld32OmYkE0dU3Sk9YygpTmR
	 3e6+muw1v5UFmDPoq3e2dvqVLGenMnEyG3ReJGoxpwfYZr8wpD1ZY6suunDUEkqcqYN7h
	 GJmH0VMhqHnGnMSi2zSk9OUsflP8gkcU3zHnEC5k0sha0+YEEb+oYfKMagk9pYfyK0Q1K
	 j6ZMAZ0HRplpRAe0zOCHMrjokwHtwmRyyVrF9a4emi8omLbNZ63bk7J4ifPfT8SEj+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388550;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hD7ADE/39S4SfcFOe0wxEVDMWtRRERELC9L/952glP4=;
	b=PHdfCnC2sx2cdwC904IGz0INSsIsvyvE2qYWvfb+icoJo3pw5HxWQPWxfeVFkNlup4t9
	 /0r+3jdCxUogQGpDwLUP9ya7aReB/WEwIYGCAGaVvJSNixJtSNMAojt4Q1tYtzwlyxvxa
	 MgVP5s4EIiMKRQjR2GcqXfM54b1f5P7kLN0dI8HaphZOjQJT/6flzJx+oU9W21XrL1kyT
	 AKU/30jDqGFI2qbDgLrylRRVb17rif7QjyQftxZ9bZjJghIZkBhhhIZmRHDW3i4vJmuQ6
	 tN7pt1mi42Nbrqklqm6z2rwOQFoF4V87OnCUVowMU3TcbJ/AgRVZnCxAkAxOEoKGBnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JhZTQWup;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE6B606A31C
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FE6B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JhZTQWup
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5365f9a04c5so15752001cf.1
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388548; x=1793993348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hD7ADE/39S4SfcFOe0wxEVDMWtRRERELC9L/952glP4=;
        b=JhZTQWupRw3gtX+xqDut3YfBpgnBoD37fHxrWpjSYn2nUAgf4G9f56X+BAScVsPgp/
         xMxst2NOS5MBEhrSgP8PMat+0ZL+v+2xB+vCE318AniDD8Tzckjgeu8FvHJBAcr4Y3lO
         D0Wcn9XEUBmckHNnlqMwPL5AdF5/K5L+UXeImfJ90SLVpjyjJR+coXEj0bDiSeAwmxfK
         FZr9GjqOt5DKhR6+tpYEFzJj0oLHE8IPBgyQAfZVJF4JMsDo02T63WUXD1Fxewncmv3f
         p1BZ+7y3xAG9W2BCb4TSEcr/SdMAiR45T6mXOVdG6hWHPJ5COG1pcUUcJ+slWBQ10qKW
         Yb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388548; x=1793993348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hD7ADE/39S4SfcFOe0wxEVDMWtRRERELC9L/952glP4=;
        b=zeCZ/SYhR9vH5AmDbLLQjMslcOrAfFHfIkqe71CSLrK51aoj5YrUlBFGC6gmInbXq9
         5c+y5hUwug3U6pd8XMiVkvzOzRMj1nnrgZYAtwAhDwe73+yGufYV1/jRVrlu4pXtVnrd
         f1gTehEygMNo1V0fxpMiJGryu+SOmJQea+i/ElzkJ1u7NHiWWJZdvSDDyrGyLdBO+jKZ
         gOpMjWarJMEBdBJ+Y2avjcLbNk1rEupfj4byojMf3jrzLsB+nkiSz/6EQQMxpGk0VmXe
         dJcO5cPa0AXXEc8wWBx+ZzKBVZTJmfOboI1Om0YyUL9GaFwUEmc0ql4FF9hT1zaOfpEh
         Ghnw==
X-Gm-Message-State: AFq9FYKDORYOcyMkusSi1u9isFkHq2kjoJaD2RaxMcLlAxJ7nELhhdqA
	foztmRQO4L8e6XwfS7kn88Cy6+7hkjnVSqKaFPS43pIAETW8scKXT616nyZcjyhJ
X-Gm-Gg: AYBFou2Wvozm01EZdn8Z4Wv8vD9/47GKPFDQ08XLkcytNm5xXPw39WGxcPobSQ1RMcR
	Wfw1iXfA0pJQQIkRBCBvxRxhdCXoGLS8RFZstUE1MMhDGve6w8Sol/j/LrQGL9bpR3EgYojdSIi
	f+N0RHupwmbdCHIC/oNePtKhDUUKsBVqGjy11MuQgcQQekEqzJ17kyXbeCr7LRuHATCT+BWLvKG
	ch/r1PTJzEOuL7rYiNKaG6jLgQQcn3/j1+x+sgf7q3Lnl4i3iqadAp2r9zOsA4XWEgqcgzGTUJb
	K0igKrczF63LVmGwA9RVufteiY8jAdU5W4FI3HiqfQ6c89MuTwKqbJOuPOfSWZAAaWVb+wuUwRi
	gkl/LmZPdfp1laHUu655Fj8b3DWThV6+athLofiOPf5ix429Blw8ix6oiIziDh2aGsBTxwBe1hD
	4K3yZNeF7CeAvZ00HQ+rkH6ReVroB6iDVZTOSxUOuIZfGlZgcLzAfc5nawpXMHg5iLV4parEBSY
	8UlX8c1SbDd4BPHXrrRYHJt/tMDAOtqE5ig3LmeUAT0KdxWGkrWeIw/TXRUNMjjJY1O3WK6l5HO
	gD+FEwZDjUsUOheYplM5+E0E8CBsZfiKN3rXjdf5gUCxHDnUtmcETB8wX7C54orkC0PoyI9CV0w
	Fwn0AeSj1AriHSxSi2bgjanxXfpHrcnf1AtopyWhbCKntbee+r+NuSgpmKe6+PAVaM8A0Yf5tyo
	hmn2LFFLdckEFAeYO93+qu8aticczEd2qc64zcyMfRTdK9yFyapmA=
X-Received: by 2002:a05:622a:54d:b0:536:6701:213b with SMTP id d75a77b69052e-542b83f552bmr55108681cf.75.1793388547995;
        Fri, 30 Oct 2026 12:29:07 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f75ff5sm21187321cf.10.2026.10.30.12.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:29:07 -0700 (PDT)
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
Subject: [PATCH 08/11] libsemanage: restore saved runtime files after failed publication
Date: Fri, 30 Oct 2026 15:28:45 -0400
Message-ID: <20261030192849.151830-8-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030192849.151830-1-stephen.smalley.work@gmail.com>
References: <20261030192849.151830-1-stephen.smalley.work@gmail.com>
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

Back up all selected runtime destinations before publication or the active
store rename. Preserve original inodes with hard links in private sibling
directories, and record prior absence in recovery manifests. Abort before
publication if any backup fails.

On publication failure, restore the saved runtime files instead of
reinstalling the rejected output. Retry a failed policy reload only after
file restoration and active-store rollback succeed. Retain backups and
manifests if restoration or the rollback reload fails. If store rollback
fails, runtime files are restored while the store may remain inconsistent;
retain recovery artifacts and do not reload in that state.

After successful publication and any required reload, sweep retained
backups only for destinations published by this transaction. Match each
manifest to its destination, skip current backups, and unlink saved
symlinks without following their targets. Report cleanup errors without
failing the commit; leave backups for unpublished destinations intact.

Hard-link support and permission on runtime files are required. This does
not isolate old inodes from external in-place writers or provide
crash-atomic publication of multiple files.

Add offline regressions for runtime-file fsync failures, backup and
manifest failures, store publication and rollback errors, restoration
failures, loader recovery, prior absence, symlinks and successful commits.
Check contents, inode metadata, store serial, lock release, retained
recovery artifacts and successful-retry cleanup. Cover skipped paths,
malformed manifests and best-effort cleanup failures. Test loaders never
load kernel policy.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/semanage_store.c              | 330 +++++++++-
 libsemanage/tests/.gitignore                  |   1 +
 libsemanage/tests/Makefile                    |   9 +-
 libsemanage/tests/README                      |   5 +
 .../tests/regression/test_final_rollback.c    | 598 ++++++++++++++++++
 5 files changed, 909 insertions(+), 34 deletions(-)
 create mode 100644 libsemanage/tests/regression/test_final_rollback.c

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index d904e698..2b6e4c41 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -46,6 +46,7 @@ typedef struct dbase_policydb dbase_t;
 #include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <glob.h>
 #include <stdio.h>
 #include <stdio_ext.h>
 #include <stdlib.h>
@@ -1885,18 +1886,278 @@ cleanup:
 	return status;
 }
 
-/* Load the contexts of the final tmp into the final selinux directory.
- * Return 0 on success, -3 on error.
+struct final_backup {
+	char *directory;
+	char *original;
+	char *restore;
+	char *manifest;
+	bool selected;
+	bool existed;
+	bool attempted;
+};
+
+static void semanage_free_final_backups(semanage_handle_t *sh,
+					struct final_backup *backups, bool keep)
+{
+	int i, errsv = errno;
+
+	for (i = 1; i < SEMANAGE_FINAL_PATH_NUM; i++) {
+		struct final_backup *b = &backups[i];
+
+		if (b->directory) {
+			if (keep) {
+				ERR(sh, "Recovery for %s retained in %s (%s).",
+				    semanage_final_path(SEMANAGE_FINAL_SELINUX,
+							i),
+				    b->directory,
+				    b->existed ? "original saved" :
+						 "previously absent");
+			} else {
+				if (b->restore)
+					unlink(b->restore);
+				if (b->original)
+					unlink(b->original);
+				if (b->manifest)
+					unlink(b->manifest);
+				if (rmdir(b->directory) < 0)
+					ERR(sh,
+					    "Could not remove backup directory %s.",
+					    b->directory);
+			}
+		}
+		free(b->restore);
+		free(b->original);
+		free(b->directory);
+		free(b->manifest);
+	}
+	errno = errsv;
+}
+
+/* Back up every destination before publishing any file. The hard link
+ * preserves the original inode (including symlinks) across replacement.
  */
-static int semanage_install_final_tmp(semanage_handle_t *sh)
+static int semanage_backup_final(semanage_handle_t *sh,
+				 struct final_backup *backups)
+{
+	int i;
+	struct stat sb;
+	char parent[PATH_MAX];
+
+	for (i = 1; i < SEMANAGE_FINAL_PATH_NUM; i++) {
+		struct final_backup *b = &backups[i];
+		const char *src = semanage_final_path(SEMANAGE_FINAL_TMP, i);
+		const char *dst =
+			semanage_final_path(SEMANAGE_FINAL_SELINUX, i);
+		char *directory = NULL;
+
+		if (sh->conf->disable_genhomedircon &&
+		    i == SEMANAGE_FC_HOMEDIRS)
+			continue;
+		if (stat(src, &sb) < 0) {
+			if (errno == ENOENT)
+				continue;
+			ERR(sh, "Could not inspect staged file %s.", src);
+			return -1;
+		}
+		if (strlen(dst) >= sizeof(parent)) {
+			errno = ENAMETOOLONG;
+			return -1;
+		}
+		strcpy(parent, dst);
+		if (semanage_mkpath(sh, dirname(parent)) < 0)
+			return -1;
+		if (lstat(dst, &sb) == 0) {
+			if (!S_ISREG(sb.st_mode) && !S_ISLNK(sb.st_mode)) {
+				errno = EINVAL;
+				ERR(sh,
+				    "Cannot back up non-file destination %s.",
+				    dst);
+				return -1;
+			}
+			b->existed = true;
+		} else if (errno != ENOENT) {
+			return -1;
+		}
+		if (asprintf(&directory, "%s/.semanage-backup-XXXXXX", parent) <
+		    0)
+			return -1;
+		if (!mkdtemp(directory)) {
+			free(directory);
+			return -1;
+		}
+		b->directory = directory;
+		if (asprintf(&b->original, "%s/original", directory) < 0) {
+			b->original = NULL;
+			return -1;
+		}
+		if (asprintf(&b->restore, "%s/restore", directory) < 0) {
+			b->restore = NULL;
+			return -1;
+		}
+		if (b->existed && link(dst, b->original) < 0) {
+			ERR(sh, "Could not back up %s.", dst);
+			return -1;
+		}
+		b->selected = true;
+		if (asprintf(&b->manifest, "%s/destination", directory) < 0) {
+			b->manifest = NULL;
+			return -1;
+		}
+		int fd = open(b->manifest,
+			      O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC,
+			      S_IRUSR | S_IWUSR);
+		if (fd < 0)
+			return -1;
+		int rc = dprintf(fd, "%s\n%s\n",
+				 b->existed ? "present" : "absent", dst);
+		if (rc < 0 || fsync(fd) < 0) {
+			int errsv = errno;
+			close(fd);
+			errno = errsv;
+			return -1;
+		}
+		if (close(fd) < 0)
+			return -1;
+	}
+	return 0;
+}
+
+static int semanage_restore_final(semanage_handle_t *sh,
+				  struct final_backup *backups)
+{
+	int i, rc = 0;
+
+	for (i = 1; i < SEMANAGE_FINAL_PATH_NUM; i++) {
+		struct final_backup *b = &backups[i];
+		const char *dst =
+			semanage_final_path(SEMANAGE_FINAL_SELINUX, i);
+
+		if (!b->attempted)
+			continue;
+		if (b->existed) {
+			/* Keep original available even if another restore or reload fails. */
+			if (link(b->original, b->restore) == 0 &&
+			    rename(b->restore, dst) == 0)
+				continue;
+		} else if (unlink(dst) == 0 || errno == ENOENT) {
+			continue;
+		}
+		ERR(sh, "Could not restore runtime file %s.", dst);
+		rc = -1;
+	}
+	return rc;
+}
+
+static void semanage_sweep_final_backups(semanage_handle_t *sh,
+					 struct final_backup *backups)
+{
+	int errsv = errno;
+
+	for (int i = 1; i < SEMANAGE_FINAL_PATH_NUM; i++) {
+		const char *dst =
+			semanage_final_path(SEMANAGE_FINAL_SELINUX, i);
+		char parent[PATH_MAX], pattern[2 * PATH_MAX + 40], *p = pattern;
+		glob_t matches = { 0 };
+		int rc;
+
+		if (!backups[i].selected)
+			continue;
+		strcpy(parent, dst); /* Validated by semanage_backup_final(). */
+		/* The configured parent is a literal path, not a glob pattern. */
+		for (const char *s = dirname(parent); *s; s++) {
+			if (strchr("\\*?[", *s))
+				*p++ = '\\';
+			*p++ = *s;
+		}
+		strcpy(p, "/.semanage-backup-*/destination");
+		rc = glob(pattern, GLOB_ERR, NULL, &matches);
+		if (rc != 0 && rc != GLOB_NOMATCH) {
+			errno = rc == GLOB_NOSPACE ? ENOMEM : EIO;
+			ERR(sh, "Could not find stale backups for %s.", dst);
+			globfree(&matches);
+			continue;
+		}
+		for (size_t j = 0; j < matches.gl_pathc; j++) {
+			char *directory = matches.gl_pathv[j];
+			char state[16], destination[PATH_MAX + 2];
+			struct stat sb;
+			FILE *fp;
+			int dirfd, fd, saved;
+			size_t len = strlen(dst);
+
+			*strrchr(directory, '/') = '\0';
+			if (!strcmp(directory, backups[i].directory))
+				continue;
+			dirfd = open(directory, O_RDONLY | O_DIRECTORY |
+							O_NOFOLLOW | O_CLOEXEC);
+			if (dirfd < 0)
+				goto report;
+			fd = openat(dirfd, "destination",
+				    O_RDONLY | O_NOFOLLOW | O_NONBLOCK |
+					    O_CLOEXEC);
+			if (fd < 0)
+				goto close_directory;
+			if (fstat(fd, &sb) < 0 || !S_ISREG(sb.st_mode)) {
+				close(fd);
+				errno = EINVAL;
+				goto close_directory;
+			}
+			fp = fdopen(fd, "r");
+			if (!fp) {
+				saved = errno;
+				close(fd);
+				errno = saved;
+				goto close_directory;
+			}
+			bool valid =
+				fgets(state, sizeof(state), fp) &&
+				(!strcmp(state, "present\n") ||
+				 !strcmp(state, "absent\n")) &&
+				fgets(destination, sizeof(destination), fp);
+			if (fclose(fp) != 0 || !valid) {
+				errno = EINVAL;
+				goto close_directory;
+			}
+			if (strlen(destination) != len + 1 ||
+			    memcmp(destination, dst, len) ||
+			    destination[len] != '\n') {
+				close(dirfd);
+				continue;
+			}
+			/* Never follow an original/restore symlink into its target. */
+			if ((unlinkat(dirfd, "original", 0) < 0 &&
+			     errno != ENOENT) ||
+			    (unlinkat(dirfd, "restore", 0) < 0 &&
+			     errno != ENOENT) ||
+			    unlinkat(dirfd, "destination", 0) < 0)
+				goto close_directory;
+			close(dirfd);
+			if (rmdir(directory) == 0)
+				continue;
+			goto report;
+
+close_directory:
+			saved = errno;
+			close(dirfd);
+			errno = saved;
+report:
+			ERR(sh, "Could not remove stale backup %s.", directory);
+		}
+		globfree(&matches);
+	}
+	errno = errsv;
+}
+
+/* Load the staged files, using the same selection that was backed up. */
+static int semanage_install_final_tmp(semanage_handle_t *sh,
+				      struct final_backup *backups,
+				      bool *reload_attempted)
 {
 	int status = -3;
 	int ret = 0;
 	int i = 0;
 	const char *src = NULL;
 	const char *dst = NULL;
-	struct stat sb;
-	char fn[PATH_MAX];
 
 	/* For each of the final files install it if it exists.
 	 * i = 1 to avoid copying the top level directory.
@@ -1905,26 +2166,9 @@ static int semanage_install_final_tmp(semanage_handle_t *sh)
 		src = semanage_final_path(SEMANAGE_FINAL_TMP, i);
 		dst = semanage_final_path(SEMANAGE_FINAL_SELINUX, i);
 
-		/* skip file if src doesn't exist */
-		if (stat(src, &sb) != 0)
+		if (!backups[i].selected)
 			continue;
-
-		/* skip genhomedircon if configured */
-		if (sh->conf->disable_genhomedircon &&
-		    i == SEMANAGE_FC_HOMEDIRS)
-			continue;
-
-		if (strlen(dst) >= sizeof(fn)) {
-			ERR(sh, "Unable to compose the final paths.");
-			status = -1;
-			goto cleanup;
-		}
-		strcpy(fn, dst);
-		ret = semanage_mkpath(sh, dirname(fn));
-		if (ret < 0) {
-			goto cleanup;
-		}
-
+		backups[i].attempted = true;
 		ret = semanage_copy_file(sh, src, dst, sh->conf->file_mode,
 					 true);
 		if (ret < 0) {
@@ -1963,6 +2207,7 @@ static int semanage_install_final_tmp(semanage_handle_t *sh)
 		goto skip_reload;
 	}
 
+	*reload_attempted = true;
 	if (semanage_reload_policy(sh)) {
 		goto cleanup;
 	}
@@ -1990,6 +2235,8 @@ static int semanage_commit_sandbox(semanage_handle_t *sh)
 	const char *sandbox = semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL);
 	struct stat buf;
 	struct selabel_handle *sehandle;
+	struct final_backup final_backups[SEMANAGE_FINAL_PATH_NUM] = { 0 };
+	bool keep_backups = false, reload_attempted = false;
 
 	/* update the commit number */
 	if ((commit_number = semanage_direct_get_serial(sh)) < 0) {
@@ -2036,6 +2283,12 @@ static int semanage_commit_sandbox(semanage_handle_t *sh)
 	if (semanage_get_active_lock(sh) < 0) {
 		return -1;
 	}
+	if (semanage_backup_final(sh, final_backups) < 0) {
+		ERR(sh,
+		    "Could not back up runtime files; publication aborted.");
+		retval = -1;
+		goto cleanup;
+	}
 	/* make the backup of the current active directory */
 	if (stat(backup, &buf) == 0) {
 		if (S_ISDIR(buf.st_mode) &&
@@ -2070,24 +2323,36 @@ static int semanage_commit_sandbox(semanage_handle_t *sh)
 		retval = -1;
 		goto cleanup;
 	}
-	if (semanage_install_final_tmp(sh) != 0) {
-		/* note that if an error occurs during the next three
-		 * function then the store will be left in an
-		 * inconsistent state */
+	if (semanage_install_final_tmp(sh, final_backups, &reload_attempted) !=
+	    0) {
+		/* Restore both namespaces; retain recovery files if either fails. */
 		int errsv = errno;
-		if (semanage_rename(sh, active, sandbox) < 0)
+		if (semanage_rename(sh, active, sandbox) < 0) {
 			ERR(sh, "Error while renaming %s back to %s.", active,
 			    sandbox);
-		else if (semanage_rename(sh, backup, active) < 0)
+			keep_backups = true;
+		} else if (semanage_rename(sh, backup, active) < 0) {
 			ERR(sh, "Error while renaming %s back to %s.", backup,
 			    active);
-		else
-			semanage_install_final_tmp(sh);
+			keep_backups = true;
+		}
+		if (semanage_restore_final(sh, final_backups) < 0)
+			keep_backups = true;
+		if (reload_attempted && !keep_backups) {
+			if (!final_backups[SEMANAGE_KERNEL].existed ||
+			    semanage_reload_policy(sh) != 0) {
+				ERR(sh,
+				    "Could not reload the restored runtime policy.");
+				keep_backups = true;
+			}
+		}
 		errno = errsv;
 		retval = -1;
 		goto cleanup;
 	}
 
+	semanage_sweep_final_backups(sh, final_backups);
+
 	if (!sh->conf->save_previous) {
 		int errsv = errno;
 		if (semanage_remove_directory(backup) != 0) {
@@ -2100,6 +2365,7 @@ static int semanage_commit_sandbox(semanage_handle_t *sh)
 	}
 
 cleanup:
+	semanage_free_final_backups(sh, final_backups, keep_backups);
 	semanage_release_active_lock(sh);
 
 	if (sh->conf->relabel_store) {
diff --git a/libsemanage/tests/.gitignore b/libsemanage/tests/.gitignore
index b7d39810..241a6783 100644
--- a/libsemanage/tests/.gitignore
+++ b/libsemanage/tests/.gitignore
@@ -1,4 +1,5 @@
 libsemanage-tests
+test-final-rollback
 test-user-join-transaction
 test-handle-lifecycle
 test-parse-read-error
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 2e4703ee..e312a283 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -5,6 +5,7 @@ CILS = $(sort $(wildcard *.cil))
 ###########################################################################
 
 EXECUTABLE = libsemanage-tests
+ROLLBACK_TEST = test-final-rollback
 USER_JOIN_TEST = test-user-join-transaction
 LIFECYCLE_TEST = test-handle-lifecycle
 ERROR_TESTS = test-read-lock-error test-user-delete-error test-parse-read-error
@@ -16,7 +17,10 @@ override LDLIBS += -lcunit -lbz2 -laudit -lselinux -lsepol
 OBJECTS = $(SOURCES:.c=.o)
 POLICIES = $(CILS:.cil=.policy)
 
-all: $(EXECUTABLE) $(POLICIES) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS) $(SERIAL_TESTS)
+all: $(EXECUTABLE) $(POLICIES) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS) $(SERIAL_TESTS) $(ROLLBACK_TEST)
+
+$(ROLLBACK_TEST): regression/test_final_rollback.c ../src/libsemanage.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,--wrap=fsync -Wl,--wrap=rename -Wl,--wrap=link -Wl,--wrap=unlinkat -Wl,--wrap=glob -o $@ $^ $(LDLIBS)
 
 test-cache-serial-file: SERIAL_BACKEND = FILE
 test-cache-serial-join: SERIAL_BACKEND = JOIN
@@ -51,7 +55,7 @@ $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 	../../secilc/secilc $*.cil -o $*.policy -f /dev/null
 
 clean distclean:
-	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS) $(SERIAL_TESTS)
+	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) $(USER_JOIN_TEST) $(LIFECYCLE_TEST) $(ERROR_TESTS) $(SERIAL_TESTS) $(ROLLBACK_TEST)
 
 test: all
 	./$(EXECUTABLE)
@@ -61,3 +65,4 @@ test: all
 	./test-read-lock-error
 	./test-user-delete-error
 	@for test in $(SERIAL_TESTS); do ./$$test || exit 1; done
+	./$(ROLLBACK_TEST)
diff --git a/libsemanage/tests/README b/libsemanage/tests/README
index 6e8e9c44..4430c6a8 100644
--- a/libsemanage/tests/README
+++ b/libsemanage/tests/README
@@ -1,5 +1,10 @@
 Notes on tests
 ============================
+The final rollback regression uses real store and runtime-file operations,
+injected write/rename/link failures, and an offline loader that records its
+loaded state. It never loads a kernel policy. Cases cover backup creation,
+publication, restoration, reload recovery, symlinks and prior absence.
+
 Commit tests require the CIL fixture sources as well as their compiled
 policies. They install those sources into an isolated store so that commit
 and reconnect checks exercise persistent changes rather than cached records.
diff --git a/libsemanage/tests/regression/test_final_rollback.c b/libsemanage/tests/regression/test_final_rollback.c
new file mode 100644
index 00000000..2760469e
--- /dev/null
+++ b/libsemanage/tests/regression/test_final_rollback.c
@@ -0,0 +1,598 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <glob.h>
+#include <libgen.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <sys/xattr.h>
+#include <unistd.h>
+#include <selinux/selinux.h>
+
+#include "handle.h"
+#include "semanage_store.h"
+
+int __real_fsync(int fd);
+int __wrap_fsync(int fd);
+int __real_rename(const char *from, const char *to);
+int __wrap_rename(const char *from, const char *to);
+int __real_link(const char *from, const char *to);
+int __wrap_link(const char *from, const char *to);
+int __real_unlinkat(int fd, const char *path, int flags);
+int __wrap_unlinkat(int fd, const char *path, int flags);
+int __real_glob(const char *pattern, int flags,
+		int (*errfunc)(const char *, int), glob_t *matches);
+int __wrap_glob(const char *pattern, int flags,
+		int (*errfunc)(const char *, int), glob_t *matches);
+
+static int sweep_mode = -1;
+static int sweep_injected;
+
+int __wrap_unlinkat(int fd, const char *path, int flags)
+{
+	if (sweep_mode >= 0) {
+		char proc[64], directory[PATH_MAX];
+		assert(snprintf(proc, sizeof(proc), "/proc/self/fd/%d", fd) <
+		       (int)sizeof(proc));
+		ssize_t n = readlink(proc, directory, sizeof(directory) - 1);
+		assert(n >= 0);
+		directory[n] = '\0';
+		/* A sweep must never consume the current transaction's backup. */
+		assert(strstr(directory, "/.semanage-backup-stale-"));
+		if (sweep_mode == 3 && !sweep_injected &&
+		    !strcmp(path, "original")) {
+			sweep_injected++;
+			errno = EACCES;
+			return -1;
+		}
+	}
+	return __real_unlinkat(fd, path, flags);
+}
+
+int __wrap_glob(const char *pattern, int flags,
+		int (*errfunc)(const char *, int), glob_t *matches)
+{
+	if (sweep_mode == 4) {
+		sweep_injected++;
+		return GLOB_NOSPACE;
+	}
+	return __real_glob(pattern, flags, errfunc, matches);
+}
+
+enum fault {
+	NONE,
+	BACKUP,
+	MANIFEST,
+	PUBLISH_STORE,
+	RESTORE_STORE,
+	RESTORE_PREVIOUS,
+	RESTORE_FILE,
+	RESTORE_LINK,
+	RELOAD,
+	SYMLINK,
+	STAGED_STAT
+};
+static enum fault fault;
+static int injected;
+static int manifest_count;
+static const char *active_path, *sandbox_path, *previous_path, *restore_path;
+
+static int fail_at;
+static int sync_count;
+
+int __wrap_fsync(int fd)
+{
+	char proc[64], path[PATH_MAX];
+	assert(snprintf(proc, sizeof(proc), "/proc/self/fd/%d", fd) <
+	       (int)sizeof(proc));
+	ssize_t n = readlink(proc, path, sizeof(path) - 1);
+	assert(n >= 0);
+	path[n] = '\0';
+	if (strstr(path, "/.semanage-backup-") &&
+	    strstr(path, "/destination")) {
+		manifest_count++;
+		if (fault == MANIFEST && !injected++) {
+			errno = ENOSPC;
+			return -1;
+		}
+		return __real_fsync(fd);
+	}
+	if (++sync_count == fail_at) {
+		errno = ENOSPC;
+		return -1;
+	}
+	return __real_fsync(fd);
+}
+
+int __wrap_link(const char *from, const char *to)
+{
+	if (!injected && ((fault == BACKUP && strstr(to, "/original")) ||
+			  (fault == RESTORE_LINK && strstr(to, "/restore")))) {
+		injected++;
+		errno = EIO;
+		return -1;
+	}
+	return __real_link(from, to);
+}
+
+int __wrap_rename(const char *from, const char *to)
+{
+	if (active_path && !injected &&
+	    ((fault == PUBLISH_STORE && !strcmp(from, sandbox_path) &&
+	      !strcmp(to, active_path)) ||
+	     (fault == RESTORE_STORE && !strcmp(from, active_path) &&
+	      !strcmp(to, sandbox_path)) ||
+	     (fault == RESTORE_PREVIOUS && !strcmp(from, previous_path) &&
+	      !strcmp(to, active_path)) ||
+	     (fault == RESTORE_FILE && strstr(from, "/restore") &&
+	      !strcmp(to, restore_path)))) {
+		injected++;
+		errno = EIO;
+		return -1;
+	}
+	return __real_rename(from, to);
+}
+
+static void write_file(semanage_handle_t *sh, const char *path,
+		       const char *data)
+{
+	char *parent = strdup(path);
+	FILE *fp;
+
+	assert(parent);
+	assert(semanage_mkpath(sh, dirname(parent)) == 0);
+	free(parent);
+	fp = fopen(path, "w");
+	assert(fp);
+	assert(fputs(data, fp) >= 0);
+	assert(fclose(fp) == 0);
+}
+
+static void check_file(const char *path, const char *expected)
+{
+	char buf[128] = { 0 };
+	FILE *fp = fopen(path, "r");
+
+	assert(fp);
+	assert(fread(buf, 1, sizeof(buf) - 1, fp) == strlen(expected));
+	assert(strcmp(buf, expected) == 0);
+	assert(fclose(fp) == 0);
+}
+
+static void set_program(external_prog_t *prog, const char *path)
+{
+	assert(prog);
+	free(prog->path);
+	free(prog->args);
+	prog->path = strdup(path);
+	prog->args = strdup("");
+	assert(prog->path && prog->args);
+}
+
+static int was_absent(int missing, int file)
+{
+	return missing == 2 ? file == SEMANAGE_KERNEL : missing && !(file % 2);
+}
+
+static void run_case(int failure, int missing, int reload_failure)
+{
+	char root[] = "/tmp/semanage-rollback-XXXXXX";
+	struct stat original[SEMANAGE_FINAL_PATH_NUM], current;
+	semanage_handle_t *sh;
+	const char *path;
+	int i, rc;
+	int failed = failure || reload_failure;
+	int keep = fault == RESTORE_STORE || fault == RESTORE_PREVIOUS ||
+		   fault == RESTORE_FILE || fault == RESTORE_LINK ||
+		   fault == RELOAD || (reload_failure && missing == 2);
+	char loader[PATH_MAX], loaded[PATH_MAX], calls[PATH_MAX],
+		script[PATH_MAX * 5];
+	char symlink_target[PATH_MAX];
+	int xattr_supported = 0;
+
+	assert(mkdtemp(root));
+	assert(semanage_set_root(root) == 0);
+	sh = semanage_handle_create_with_path("/dev/null");
+	assert(sh);
+	semanage_select_store(sh, "store", SEMANAGE_CON_DIRECT);
+	semanage_set_store_root(sh, "/store");
+	sh->conf->relabel_store = 0;
+	sh->conf->disable_genhomedircon = 0;
+	sh->do_check_contexts = 0;
+	sh->do_reload = reload_failure;
+	sh->u.direct.activelock_file_fd = -1;
+	sh->u.direct.translock_file_fd = -1;
+	set_program(sh->conf->sefcontext_compile, "/bin/true");
+	set_program(sh->conf->load_policy, "/bin/false");
+	assert(semanage_check_init(sh, sh->conf->store_root_path) == 0);
+	assert(semanage_create_store(sh, 1) == 0);
+	write_file(sh, semanage_path(SEMANAGE_ACTIVE, SEMANAGE_COMMIT_NUM_FILE),
+		   "41");
+	assert(semanage_make_sandbox(sh) == 0);
+	assert(semanage_make_final(sh) == 0);
+	active_path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
+	sandbox_path = semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL);
+	previous_path = semanage_path(SEMANAGE_PREVIOUS, SEMANAGE_TOPLEVEL);
+	restore_path = semanage_final_path(SEMANAGE_FINAL_SELINUX, 1);
+
+	for (i = 1; i < SEMANAGE_FINAL_PATH_NUM; i++) {
+		path = semanage_final_path(SEMANAGE_FINAL_SELINUX, i);
+		if (!was_absent(missing, i)) {
+			write_file(sh, path, "old runtime\n");
+			assert(chmod(path, 0640) == 0);
+			assert(lstat(path, &original[i]) == 0);
+		}
+		write_file(sh, semanage_final_path(SEMANAGE_FINAL_TMP, i),
+			   "new runtime\n");
+	}
+	if (fault == SYMLINK) {
+		assert(snprintf(symlink_target, sizeof(symlink_target),
+				"%s/symlink-target",
+				root) < (int)sizeof(symlink_target));
+		assert(rename(restore_path, symlink_target) == 0);
+		assert(symlink(symlink_target, restore_path) == 0);
+		assert(lstat(restore_path, &original[1]) == 0);
+	} else {
+		xattr_supported = setxattr(restore_path, "user.rollback-test",
+					   "old", 3, 0) == 0;
+	}
+	if (fault == STAGED_STAT) {
+		path = semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_NC);
+		assert(unlink(path) == 0);
+		assert(symlink(path, path) == 0);
+	}
+	if (reload_failure) {
+		const char *runtime = semanage_final_path(
+			SEMANAGE_FINAL_SELINUX, SEMANAGE_KERNEL);
+		assert(snprintf(loader, sizeof(loader), "%s/loader", root) <
+		       (int)sizeof(loader));
+		assert(snprintf(loaded, sizeof(loaded), "%s/loaded", root) <
+		       (int)sizeof(loaded));
+		assert(snprintf(calls, sizeof(calls), "%s/calls", root) <
+		       (int)sizeof(calls));
+		assert(snprintf(script, sizeof(script),
+				"#!/bin/sh\n/bin/cp '%s' '%s' || exit 2\n"
+				"if [ ! -e '%s' ]; then echo first > '%s'; exit 1; fi\n"
+				"echo restored >> '%s'\nexit %d\n",
+				runtime, loaded, calls, calls, calls,
+				fault == RELOAD ? 1 : 0) < (int)sizeof(script));
+		write_file(sh, loader, script);
+		assert(chmod(loader, 0700) == 0);
+		set_program(sh->conf->load_policy, loader);
+	}
+	assert(selinux_set_policy_root(semanage_final_path(
+		       SEMANAGE_FINAL_SELINUX, SEMANAGE_FINAL_TOPLEVEL)) == 0);
+	fail_at = failure;
+	sync_count = 0;
+	manifest_count = 0;
+	rc = semanage_install_sandbox(sh);
+	assert(failed ? rc < 0 : rc == 42);
+	if (failure && (fault == NONE || fault == SYMLINK ||
+			fault == RESTORE_FILE || fault == RESTORE_LINK)) {
+		assert(errno == ENOSPC);
+		assert(sync_count == failure);
+	}
+	if (fault == BACKUP || fault == MANIFEST || fault == PUBLISH_STORE ||
+	    fault == STAGED_STAT)
+		assert(sync_count == 0);
+	if (fault == NONE || fault == SYMLINK)
+		assert(manifest_count == SEMANAGE_FINAL_PATH_NUM - 1);
+	if (fault != NONE && fault != RELOAD && fault != SYMLINK &&
+	    fault != STAGED_STAT)
+		assert(injected);
+
+	for (i = 1; i < SEMANAGE_FINAL_PATH_NUM; i++) {
+		path = semanage_final_path(SEMANAGE_FINAL_SELINUX, i);
+		if ((fault == RESTORE_FILE || fault == RESTORE_LINK) &&
+		    i == 1) {
+			check_file(path, "new runtime\n");
+			continue;
+		}
+		if (failed && was_absent(missing, i)) {
+			assert(lstat(path, &current) < 0 && errno == ENOENT);
+			continue;
+		}
+		check_file(path, failed ? "old runtime\n" : "new runtime\n");
+		if (failed) {
+			assert(lstat(path, &current) == 0);
+			assert(current.st_ino == original[i].st_ino);
+			assert(current.st_mode == original[i].st_mode);
+			assert(current.st_uid == original[i].st_uid &&
+			       current.st_gid == original[i].st_gid);
+			assert(keep ? current.st_nlink > original[i].st_nlink :
+				      current.st_nlink == original[i].st_nlink);
+		}
+	}
+	if (failed && fault != RESTORE_STORE && fault != RESTORE_PREVIOUS)
+		check_file(semanage_path(SEMANAGE_ACTIVE,
+					 SEMANAGE_COMMIT_NUM_FILE),
+			   "41");
+	else if (!failed || fault == RESTORE_STORE)
+		assert(semanage_direct_get_serial(sh) == 42);
+	else
+		assert(access(active_path, F_OK) < 0 && errno == ENOENT);
+	if (failed && xattr_supported && fault != RESTORE_FILE &&
+	    fault != RESTORE_LINK) {
+		char value[3];
+		assert(getxattr(restore_path, "user.rollback-test", value,
+				sizeof(value)) == 3);
+		assert(!memcmp(value, "old", 3));
+	}
+	if (reload_failure) {
+		int retry = fault != RESTORE_STORE &&
+			    fault != RESTORE_PREVIOUS &&
+			    !was_absent(missing, SEMANAGE_KERNEL);
+		check_file(calls, retry ? "first\nrestored\n" : "first\n");
+		check_file(loaded, retry ? "old runtime\n" : "new runtime\n");
+		if (!retry)
+			keep = 1;
+	}
+	unsigned int backups = 0;
+	for (i = 1; i < SEMANAGE_FINAL_PATH_NUM; i++) {
+		char pattern[PATH_MAX], *parent;
+		glob_t matches = { 0 };
+		parent = strdup(semanage_final_path(SEMANAGE_FINAL_SELINUX, i));
+		assert(parent);
+		assert(snprintf(pattern, sizeof(pattern),
+				"%s/.semanage-backup-*/destination",
+				dirname(parent)) < (int)sizeof(pattern));
+		free(parent);
+		int grc = glob(pattern, 0, NULL, &matches);
+		assert(grc == 0 || grc == GLOB_NOMATCH);
+		backups += matches.gl_pathc;
+		for (size_t j = 0; j < matches.gl_pathc; j++) {
+			char original_path[PATH_MAX], destination[PATH_MAX],
+				state[16];
+			FILE *fp = fopen(matches.gl_pathv[j], "r");
+			assert(fp && fgets(state, sizeof(state), fp) &&
+			       fgets(destination, sizeof(destination), fp));
+			assert(fclose(fp) == 0);
+			destination[strcspn(destination, "\n")] = '\0';
+			assert(!strcmp(state, "present\n") ||
+			       !strcmp(state, "absent\n"));
+			char *dir = strdup(matches.gl_pathv[j]);
+			assert(dir);
+			assert(snprintf(original_path, sizeof(original_path),
+					"%s/original", dirname(dir)) <
+			       (int)sizeof(original_path));
+			free(dir);
+			if (!strcmp(state, "present\n"))
+				check_file(original_path, "old runtime\n");
+			else
+				assert(access(original_path, F_OK) < 0 &&
+				       errno == ENOENT);
+			if (!strcmp(destination, restore_path) &&
+			    (fault == RESTORE_FILE || fault == RESTORE_LINK)) {
+				assert(lstat(original_path, &current) == 0);
+				assert(current.st_ino == original[1].st_ino);
+			}
+		}
+		globfree(&matches);
+	}
+	assert(keep ? backups > 0 : backups == 0);
+	assert(sh->u.direct.activelock_file_fd == -1);
+	if (fault == RESTORE_FILE || fault == RELOAD) {
+		/* Exercise a real retained backup followed by successful publication. */
+		fault = NONE;
+		fail_at = 0;
+		sh->do_reload = 0;
+		assert(semanage_make_sandbox(sh) == 0);
+		assert(semanage_make_final(sh) == 0);
+		for (i = 1; i < SEMANAGE_FINAL_PATH_NUM; i++)
+			write_file(sh,
+				   semanage_final_path(SEMANAGE_FINAL_TMP, i),
+				   "retry runtime\n");
+		assert(semanage_install_sandbox(sh) == 42);
+		for (i = 1; i < SEMANAGE_FINAL_PATH_NUM; i++) {
+			char pattern[PATH_MAX], *parent;
+			glob_t matches = { 0 };
+			parent = strdup(
+				semanage_final_path(SEMANAGE_FINAL_SELINUX, i));
+			assert(parent);
+			assert(snprintf(pattern, sizeof(pattern),
+					"%s/.semanage-backup-*",
+					dirname(parent)) <
+			       (int)sizeof(pattern));
+			free(parent);
+			assert(glob(pattern, 0, NULL, &matches) ==
+			       GLOB_NOMATCH);
+			globfree(&matches);
+		}
+	}
+	printf("rollback: fault=%d write=%d absent=%d reload=%d retained=%d passed\n",
+	       fault, failure, missing, reload_failure, keep);
+	fflush(stdout);
+	if (fault == STAGED_STAT)
+		assert(unlink(semanage_final_path(SEMANAGE_FINAL_TMP,
+						  SEMANAGE_NC)) == 0);
+	semanage_handle_destroy(sh);
+	assert(semanage_remove_directory(root) == 0);
+}
+
+static void stale_backup(semanage_handle_t *sh, const char *directory,
+			 const char *state, const char *destination,
+			 int original)
+{
+	char path[PATH_MAX], manifest[PATH_MAX + 32];
+	assert(snprintf(path, sizeof(path), "%s/destination", directory) <
+	       (int)sizeof(path));
+	assert(snprintf(manifest, sizeof(manifest), "%s\n%s\n", state,
+			destination) < (int)sizeof(manifest));
+	write_file(sh, path, manifest);
+	if (original) {
+		assert(snprintf(path, sizeof(path), "%s/original", directory) <
+		       (int)sizeof(path));
+		write_file(sh, path, "stale runtime\n");
+	}
+}
+
+static void run_sweep_case(int mode)
+{
+	/* Exercise literal glob metacharacters in the configured path too. */
+	char root[] = "/tmp/semanage-sweep-[x]*?\\-XXXXXX";
+	char stale[SEMANAGE_FINAL_PATH_NUM][PATH_MAX], extra[6][PATH_MAX];
+	char path[PATH_MAX], target[PATH_MAX], *parent;
+	semanage_handle_t *sh;
+	struct stat sb;
+	int rc, remaining = 0;
+
+	assert(mkdtemp(root));
+	assert(semanage_set_root(root) == 0);
+	sh = semanage_handle_create_with_path("/dev/null");
+	assert(sh);
+	semanage_select_store(sh, "store", SEMANAGE_CON_DIRECT);
+	semanage_set_store_root(sh, "/store");
+	sh->conf->relabel_store = 0;
+	sh->conf->disable_genhomedircon = 1;
+	sh->conf->save_previous = mode % 2;
+	sh->do_check_contexts = 0;
+	sh->do_reload = 1;
+	sh->u.direct.activelock_file_fd = -1;
+	sh->u.direct.translock_file_fd = -1;
+	set_program(sh->conf->sefcontext_compile, "/bin/true");
+	set_program(sh->conf->load_policy,
+		    mode == 2 ? "/bin/false" : "/bin/true");
+	assert(semanage_check_init(sh, sh->conf->store_root_path) == 0);
+	assert(semanage_create_store(sh, 1) == 0);
+	write_file(sh, semanage_path(SEMANAGE_ACTIVE, SEMANAGE_COMMIT_NUM_FILE),
+		   "41");
+	assert(semanage_make_sandbox(sh) == 0);
+	assert(semanage_make_final(sh) == 0);
+	for (int i = 1; i < SEMANAGE_FINAL_PATH_NUM; i++) {
+		const char *dst =
+			semanage_final_path(SEMANAGE_FINAL_SELINUX, i);
+		write_file(sh, dst, "old runtime\n");
+		if (i != SEMANAGE_NC)
+			write_file(sh,
+				   semanage_final_path(SEMANAGE_FINAL_TMP, i),
+				   "new runtime\n");
+		parent = strdup(dst);
+		assert(parent);
+		assert(snprintf(stale[i], sizeof(stale[i]),
+				"%s/.semanage-backup-stale-%d", dirname(parent),
+				i) < (int)sizeof(stale[i]));
+		free(parent);
+		stale_backup(sh, stale[i], i % 2 ? "present" : "absent", dst,
+			     i % 2);
+	}
+	const char *dst =
+		semanage_final_path(SEMANAGE_FINAL_SELINUX, SEMANAGE_KERNEL);
+	parent = strdup(dst);
+	assert(parent);
+	char *dir = dirname(parent);
+	for (int i = 0; i < 6; i++) {
+		assert(snprintf(extra[i], sizeof(extra[i]),
+				"%s/.semanage-backup-stale-extra-%d", dir,
+				i) < (int)sizeof(extra[i]));
+		stale_backup(sh, extra[i], i == 1 ? "invalid" : "present",
+			     i == 0 ? "/another/destination" : dst, 1);
+	}
+	free(parent);
+	assert(snprintf(path, sizeof(path), "%s/destination", extra[2]) <
+	       (int)sizeof(path));
+	write_file(sh, path, "present\n");
+	assert(snprintf(target, sizeof(target), "%s/target", root) <
+	       (int)sizeof(target));
+	write_file(sh, target, "symlink target\n");
+	assert(snprintf(path, sizeof(path), "%s/original", extra[3]) <
+	       (int)sizeof(path));
+	assert(unlink(path) == 0 && symlink(target, path) == 0);
+	assert(snprintf(path, sizeof(path), "%s/destination", extra[4]) <
+	       (int)sizeof(path));
+	assert(unlink(path) == 0 && symlink(target, path) == 0);
+	assert(snprintf(path, sizeof(path), "%s/destination", extra[5]) <
+	       (int)sizeof(path));
+	assert(unlink(path) == 0 && mkfifo(path, 0600) == 0);
+	assert(selinux_set_policy_root(semanage_final_path(
+		       SEMANAGE_FINAL_SELINUX, SEMANAGE_FINAL_TOPLEVEL)) == 0);
+	fail_at = mode == 1 ? 2 : 0;
+	sweep_mode = mode;
+	rc = semanage_install_sandbox(sh);
+	sweep_mode = -1;
+	assert(mode == 1 || mode == 2 ? rc < 0 : rc == 42);
+	assert(sh->u.direct.activelock_file_fd == -1);
+	for (int i = 1; i < SEMANAGE_FINAL_PATH_NUM; i++) {
+		int keep = mode == 1 || mode == 2 || mode == 4 ||
+			   i == SEMANAGE_NC || i == SEMANAGE_FC_HOMEDIRS;
+		int exists = lstat(stale[i], &sb) == 0;
+		if (!keep && mode == 3)
+			remaining += exists;
+		else
+			assert(exists == keep);
+		check_file(semanage_final_path(SEMANAGE_FINAL_SELINUX, i),
+			   mode == 1 || mode == 2 || i == SEMANAGE_NC ||
+					   i == SEMANAGE_FC_HOMEDIRS ?
+				   "old runtime\n" :
+				   "new runtime\n");
+	}
+	assert(mode != 3 || (remaining == 1 && sweep_injected == 1));
+	assert(mode != 4 || sweep_injected > 0);
+	for (int i = 0; i < 6; i++) {
+		int keep = i != 3 || mode == 1 || mode == 2 || mode == 4;
+		assert((lstat(extra[i], &sb) == 0) == keep);
+	}
+	check_file(target, "symlink target\n");
+	semanage_handle_destroy(sh);
+	assert(semanage_remove_directory(root) == 0);
+	printf("backup sweep: mode=%d passed\n", mode);
+	fflush(stdout);
+}
+
+/* Each child gets fresh process-global store paths. No host policy is loaded. */
+static void run_child(int failure, int missing, int reload_failure,
+		      enum fault mode)
+{
+	pid_t pid = fork();
+	int status;
+
+	assert(pid >= 0);
+	if (pid == 0) {
+		fault = mode;
+		run_case(failure, missing, reload_failure);
+		_exit(0);
+	}
+	assert(waitpid(pid, &status, 0) == pid);
+	assert(WIFEXITED(status) && WEXITSTATUS(status) == 0);
+}
+
+int main(void)
+{
+	int i, missing;
+
+	for (missing = 0; missing < 2; missing++) {
+		for (i = 1; i < SEMANAGE_FINAL_PATH_NUM; i++)
+			run_child(i, missing, 0, NONE);
+		run_child(0, missing, 1, NONE);
+		run_child(0, missing, 0, NONE);
+	}
+	run_child(1, 0, 0, BACKUP);
+	run_child(1, 0, 0, MANIFEST);
+	run_child(1, 0, 0, PUBLISH_STORE);
+	run_child(0, 0, 1, RESTORE_STORE);
+	run_child(0, 0, 1, RESTORE_PREVIOUS);
+	run_child(2, 0, 0, RESTORE_FILE);
+	run_child(2, 0, 0, RESTORE_LINK);
+	run_child(0, 0, 1, RELOAD);
+	run_child(2, 0, 0, SYMLINK);
+	run_child(1, 0, 0, STAGED_STAT);
+	run_child(0, 1, 1, RESTORE_STORE);
+	run_child(0, 2, 1, NONE);
+	for (i = 0; i < 5; i++) {
+		pid_t pid = fork();
+		int status;
+		assert(pid >= 0);
+		if (pid == 0) {
+			run_sweep_case(i);
+			_exit(0);
+		}
+		assert(waitpid(pid, &status, 0) == pid);
+		assert(WIFEXITED(status) && WEXITSTATUS(status) == 0);
+	}
+	puts("Final-file rollback tests passed.");
+	return 0;
+}
-- 
2.56.0

