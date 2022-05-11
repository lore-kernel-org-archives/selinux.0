Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE813C433F5
	for <selinux@archiver.kernel.org>; Wed, 11 May 2022 18:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346449AbiEKSmi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 May 2022 14:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346306AbiEKSmh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 May 2022 14:42:37 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDE062109
        for <selinux@vger.kernel.org>; Wed, 11 May 2022 11:42:36 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y21so3629801edo.2
        for <selinux@vger.kernel.org>; Wed, 11 May 2022 11:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OYnGhqBkWK3YCzBC1rPyCC1CVX/TAKhA2r8wx1STzSk=;
        b=fUe6a4s4CMAq//ZbF72RiD1xa61g7A6cHDIooM5JSEdpA4OWvfxPlfhRuOWcwRnTvm
         TljycibZ6CMfQ5XMXoWtjSmQcmNz4xL/m5fLbLUep1ZqjXghnnPx1FONoa5p6MPmqLzO
         2gsJlsa0+j/uYPQLs4nWZBZmpUJ9CZgGeKvhkpxrryPYtTVG2TVk/YvdAB6CjOHAMQZK
         QHvkhKdrJCxunoSTkujOsD7YEUIOaMWmADYbYLyhCFUZuE2//r7Fu8627aAkhoUTmzWr
         k7+f2OzqIt97X0RPReKWjs90MOPFcJvRENbV1KysBVaNOc2TZyBtrnpwq8pBqJoPOGYv
         Eiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OYnGhqBkWK3YCzBC1rPyCC1CVX/TAKhA2r8wx1STzSk=;
        b=t0cSlgN/n5r/VlW3JU295uNIpSFucPtxsE6xw0C3Tv59ZI7UR6UctnfVic3ZgNrU/W
         8PjBVbvECwOyRQO5pLFzms09J4MrFRuSYLOSnuiiavQrnyFD+NloJfKqHE+gn0jy0p9F
         VkttaieVnESeYsw3iWb+vxrPf9PAaJiwzFeQsfms6fx2HMyHNcTH1uCXN3Yfo/WudNL6
         zGRhW3fxUZW0ILh2Y255lR1sg940x/3L4yRgitfxwFL+hluNS8hgxQV21X+RKnQDDNfh
         q+41/B32I1k8EhAZ8NXGgg5Ct7Zixv7X1smPH/4hw7FLfj2cF9275zESpfqL5dlJMTrB
         JftA==
X-Gm-Message-State: AOAM531SXeGB7Xj9p5te89Ars1WruAoCmgT5OYuOPwfFXO5O6ScAcbT+
        O4G8dIe0yv2l660hI7wR5EEGKz8TEz8=
X-Google-Smtp-Source: ABdhPJyaBDv+qvCqEaZLj+pLOw9RFWtzIIhJ3AuV2jY+us3LNNj8XGmLaunY8YcSHSXvSnFVJ2o6fA==
X-Received: by 2002:a05:6402:e99:b0:41d:11f2:85e0 with SMTP id h25-20020a0564020e9900b0041d11f285e0mr30222477eda.339.1652294554728;
        Wed, 11 May 2022 11:42:34 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-140-049.95.112.pool.telefonica.de. [95.112.140.49])
        by smtp.gmail.com with ESMTPSA id y25-20020aa7ca19000000b0042617ba639dsm1535788eds.39.2022.05.11.11.42.33
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 11:42:33 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 4/4] libselinux: restorecon: pin file to avoid TOCTOU issues
Date:   Wed, 11 May 2022 20:42:25 +0200
Message-Id: <20220511184225.218062-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511184225.218062-1-cgzones@googlemail.com>
References: <20220505174420.24537-1-cgzones@googlemail.com>
 <20220511184225.218062-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Pin the file to operate on in restorecon_sb() to prevent symlink attacks
in between the label database lookup, the current context query and the
final context write.  Also don't use the file information from
fts_read(3), which might also be out of sync.

Due to querying file information twice, one in fts_read(3) needed for
the cross device check and one on the pinned file descriptor for the
database lookup, there is a slight slowdown:

    [current]
    Time (mean ± σ):     14.456 s ±  0.306 s    [User: 45.863 s, System: 4.463 s]
    Range (min … max):   14.275 s … 15.294 s    10 runs

    [changed]
    Time (mean ± σ):     15.843 s ±  0.045 s    [User: 46.274 s, System: 9.495 s]
    Range (min … max):   15.787 s … 15.916 s    10 runs

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 43 +++++++++++++++++------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 42ef30cb..12b85101 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -621,13 +621,13 @@ out:
 	return rc;
 }
 
-static int restorecon_sb(const char *pathname, const struct stat *sb,
-			    struct rest_flags *flags, bool first)
+static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool first)
 {
 	char *newcon = NULL;
 	char *curcon = NULL;
 	char *newtypecon = NULL;
-	int rc;
+	int fd = -1, rc;
+	struct stat stat_buf;
 	bool updated = false;
 	const char *lookup_path = pathname;
 	float pc;
@@ -642,13 +642,21 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		lookup_path += rootpathlen;
 	}
 
+	fd = open(pathname, O_PATH | O_NOFOLLOW | O_EXCL);
+	if (fd < 0)
+		goto err;
+
+	rc = fstat(fd, &stat_buf);
+	if (rc < 0)
+		goto err;
+
 	if (rootpath != NULL && lookup_path[0] == '\0')
 		/* this is actually the root dir of the alt root. */
 		rc = selabel_lookup_raw(fc_sehandle, &newcon, "/",
-						    sb->st_mode);
+						    stat_buf.st_mode);
 	else
 		rc = selabel_lookup_raw(fc_sehandle, &newcon, lookup_path,
-						    sb->st_mode);
+						    stat_buf.st_mode);
 
 	if (rc < 0) {
 		if (errno == ENOENT) {
@@ -657,10 +665,10 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 					    "Warning no default label for %s\n",
 					    lookup_path);
 
-			return 0; /* no match, but not an error */
+			goto out; /* no match, but not an error */
 		}
 
-		return -1;
+		goto err;
 	}
 
 	if (flags->progress) {
@@ -680,19 +688,17 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 	}
 
 	if (flags->add_assoc) {
-		rc = filespec_add(sb->st_ino, newcon, pathname, flags);
+		rc = filespec_add(stat_buf.st_ino, newcon, pathname, flags);
 
 		if (rc < 0) {
 			selinux_log(SELINUX_ERROR,
 				    "filespec_add error: %s\n", pathname);
-			freecon(newcon);
-			return -1;
+			goto out1;
 		}
 
 		if (rc > 0) {
 			/* Already an association and it took precedence. */
-			freecon(newcon);
-			return 0;
+			goto out;
 		}
 	}
 
@@ -700,7 +706,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		selinux_log(SELINUX_INFO, "%s matched by %s\n",
 			    pathname, newcon);
 
-	if (lgetfilecon_raw(pathname, &curcon) < 0) {
+	if (fgetfilecon_raw(fd, &curcon) < 0) {
 		if (errno != ENODATA)
 			goto err;
 
@@ -733,7 +739,7 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 		}
 
 		if (!flags->nochange) {
-			if (lsetfilecon(pathname, newcon) < 0)
+			if (fsetfilecon(fd, newcon) < 0)
 				goto err;
 			updated = true;
 		}
@@ -758,6 +764,8 @@ static int restorecon_sb(const char *pathname, const struct stat *sb,
 out:
 	rc = 0;
 out1:
+	if (fd >= 0)
+		close(fd);
 	freecon(curcon);
 	freecon(newcon);
 	return rc;
@@ -855,7 +863,6 @@ static void *selinux_restorecon_thread(void *arg)
 	FTSENT *ftsent;
 	int error;
 	char ent_path[PATH_MAX];
-	struct stat ent_st;
 	bool first = false;
 
 	if (state->parallel)
@@ -953,11 +960,11 @@ loop_body:
 			/* fall through */
 		default:
 			strcpy(ent_path, ftsent->fts_path);
-			ent_st = *ftsent->fts_statp;
+
 			if (state->parallel)
 				pthread_mutex_unlock(&state->mutex);
 
-			error = restorecon_sb(ent_path, &ent_st, &state->flags,
+			error = restorecon_sb(ent_path, &state->flags,
 					      first);
 
 			if (state->parallel) {
@@ -1153,7 +1160,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
 			goto cleanup;
 		}
 
-		error = restorecon_sb(pathname, &sb, &state.flags, true);
+		error = restorecon_sb(pathname, &state.flags, true);
 		goto cleanup;
 	}
 
-- 
2.36.1

