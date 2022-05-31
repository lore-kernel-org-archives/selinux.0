Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22AAC433F5
	for <selinux@archiver.kernel.org>; Tue, 31 May 2022 12:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344425AbiEaM6j (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 May 2022 08:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343774AbiEaM6i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 31 May 2022 08:58:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 643337B9D3
        for <selinux@vger.kernel.org>; Tue, 31 May 2022 05:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654001916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XG97VB7hkcAS0779oqLugRQQ3suUOuK79GbgeoytqEg=;
        b=ejumiPCMEAfOpQ7cQdskfVI3cHcSMJUnAu0ZwfH5RIREDfXhyr7cDQFFWf//XkNua0yE8v
        HPBQhvwSvlIqB9nVDem0XE3Zc9dX+LfC7kzkILO6jr7PvUTKUjLTqCUn9EkAC17ZECD0FB
        CSNyHPiAO03ozLwd3dvf3PrLPyzeSlo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-eXugqzIfPLmL5g4Ncevacw-1; Tue, 31 May 2022 08:58:33 -0400
X-MC-Unique: eXugqzIfPLmL5g4Ncevacw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94A36824063;
        Tue, 31 May 2022 12:58:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 565C540CFD0A;
        Tue, 31 May 2022 12:58:30 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] Revert "libselinux: restorecon: pin file to avoid TOCTOU issues"
Date:   Tue, 31 May 2022 14:57:51 +0200
Message-Id: <20220531125750.278211-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This reverts commit 7e979b56fd2cee28f647376a7233d2ac2d12ca50.

The reverted commit broke `setfiles` when it's run from a chroot
without /proc mounted, e.g.

    # chroot /mnt/sysimage

    chroot# setfiles -e /proc -e /sys /sys /etc/selinux/targeted/contexts/files/file_contexts /
    [strace]
    openat(AT_FDCWD, "/", O_RDONLY|O_EXCL|O_NOFOLLOW|O_PATH) = 3
    newfstatat(3, "", {st_mode=S_IFDIR|0555, st_size=4096, ...}, AT_EMPTY_PATH) = 0
    mmap(NULL, 2101248, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f1697c91000
    fgetxattr(3, "security.selinux", 0x55be8881d3f0, 255) = -1 EBADF (Bad file descriptor)
    fcntl(3, F_GETFL)                       = 0x220000 (flags O_RDONLY|O_NOFOLLOW|O_PATH)
    getxattr("/proc/self/fd/3", "security.selinux", 0x55be8881d3f0, 255) = -1 ENOENT (No such file or directory)
    [/strace]
    setfiles: Could not set context for /:  No such file or directory

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libselinux/src/selinux_restorecon.c | 43 ++++++++++++-----------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 9dd6be817832..9f5b326c19ec 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -623,13 +623,13 @@ out:
 	return rc;
 }
 
-static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool first)
+static int restorecon_sb(const char *pathname, const struct stat *sb,
+			    struct rest_flags *flags, bool first)
 {
 	char *newcon = NULL;
 	char *curcon = NULL;
 	char *newtypecon = NULL;
-	int fd = -1, rc;
-	struct stat stat_buf;
+	int rc;
 	bool updated = false;
 	const char *lookup_path = pathname;
 	float pc;
@@ -644,21 +644,13 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
 		lookup_path += rootpathlen;
 	}
 
-	fd = open(pathname, O_PATH | O_NOFOLLOW | O_EXCL);
-	if (fd < 0)
-		goto err;
-
-	rc = fstat(fd, &stat_buf);
-	if (rc < 0)
-		goto err;
-
 	if (rootpath != NULL && lookup_path[0] == '\0')
 		/* this is actually the root dir of the alt root. */
 		rc = selabel_lookup_raw(fc_sehandle, &newcon, "/",
-						    stat_buf.st_mode);
+						    sb->st_mode);
 	else
 		rc = selabel_lookup_raw(fc_sehandle, &newcon, lookup_path,
-						    stat_buf.st_mode);
+						    sb->st_mode);
 
 	if (rc < 0) {
 		if (errno == ENOENT) {
@@ -667,10 +659,10 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
 					    "Warning no default label for %s\n",
 					    lookup_path);
 
-			goto out; /* no match, but not an error */
+			return 0; /* no match, but not an error */
 		}
 
-		goto err;
+		return -1;
 	}
 
 	if (flags->progress) {
@@ -690,17 +682,19 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
 	}
 
 	if (flags->add_assoc) {
-		rc = filespec_add(stat_buf.st_ino, newcon, pathname, flags);
+		rc = filespec_add(sb->st_ino, newcon, pathname, flags);
 
 		if (rc < 0) {
 			selinux_log(SELINUX_ERROR,
 				    "filespec_add error: %s\n", pathname);
-			goto out1;
+			freecon(newcon);
+			return -1;
 		}
 
 		if (rc > 0) {
 			/* Already an association and it took precedence. */
-			goto out;
+			freecon(newcon);
+			return 0;
 		}
 	}
 
@@ -708,7 +702,7 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
 		selinux_log(SELINUX_INFO, "%s matched by %s\n",
 			    pathname, newcon);
 
-	if (fgetfilecon_raw(fd, &curcon) < 0) {
+	if (lgetfilecon_raw(pathname, &curcon) < 0) {
 		if (errno != ENODATA)
 			goto err;
 
@@ -741,7 +735,7 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
 		}
 
 		if (!flags->nochange) {
-			if (fsetfilecon(fd, newcon) < 0)
+			if (lsetfilecon(pathname, newcon) < 0)
 				goto err;
 			updated = true;
 		}
@@ -766,8 +760,6 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
 out:
 	rc = 0;
 out1:
-	if (fd >= 0)
-		close(fd);
 	freecon(curcon);
 	freecon(newcon);
 	return rc;
@@ -865,6 +857,7 @@ static void *selinux_restorecon_thread(void *arg)
 	FTSENT *ftsent;
 	int error;
 	char ent_path[PATH_MAX];
+	struct stat ent_st;
 	bool first = false;
 
 	if (state->parallel)
@@ -962,11 +955,11 @@ loop_body:
 			/* fall through */
 		default:
 			strcpy(ent_path, ftsent->fts_path);
-
+			ent_st = *ftsent->fts_statp;
 			if (state->parallel)
 				pthread_mutex_unlock(&state->mutex);
 
-			error = restorecon_sb(ent_path, &state->flags,
+			error = restorecon_sb(ent_path, &ent_st, &state->flags,
 					      first);
 
 			if (state->parallel) {
@@ -1162,7 +1155,7 @@ static int selinux_restorecon_common(const char *pathname_orig,
 			goto cleanup;
 		}
 
-		error = restorecon_sb(pathname, &state.flags, true);
+		error = restorecon_sb(pathname, &sb, &state.flags, true);
 		goto cleanup;
 	}
 
-- 
2.36.1

