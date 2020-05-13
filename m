Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691F1C433DF
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 19:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07150206CC
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 19:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFqLM4yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390256AbgEMTed (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 15:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389392AbgEMTed (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 15:34:33 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A22DC061A0C
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 12:34:31 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t8so507313qvw.5
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=kuVVThiHOy9K0nfnDbIkFBUw8m4NnhFUKu3SVQBqTVA=;
        b=YFqLM4ypKAVP5BTAUHpNNbxsgYo9r4N+FqbUqnTuMH6A8UHc0WhJt0BHglBEg1A+df
         oM9CVzl1+nfdJnj4QKQjazz/fWd5fbRbJO08EVc2fHcWy1fR92PhUC96/6CV9R6w6nkM
         FnZYWv6ittdm24WdbStpoN7NsRxy9D7zhagmXRHRJ4/zX6bcX0Scp9EpEFxQebg9WUD8
         VbgHvFVXrtOZD58bHUQhLdNeYGqi38PwMLoJCOBTlYJH2aEpYyEnBycleX92HbZgfraJ
         coSXq5LLbTzueZAM6x1z+XQUxJcGL+zpTNmXEvh9pRfj/tdWgJHPRZszwOE3kS5ihWXs
         0ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:subject:date:mime-version
         :content-transfer-encoding;
        bh=kuVVThiHOy9K0nfnDbIkFBUw8m4NnhFUKu3SVQBqTVA=;
        b=cvi1qvyt6u8mhIvYsPb7b0q1+oQK68F0LOgCyX67C36J3esBeEhBbTR44Fa9NGO9Mw
         DxR4D0I7l4YZ3O61ScpxHkCjQL7be6kEP5A+NQ4ksEdsEf/ideeqYPAyfrtq1IONXiBO
         G0yqnPVXHmrM4izVmMUbPSGSaTdyrZi3eml1fWiIP9ncWRC4UwFyeB1mgOqVmXpwW0O7
         2JPto0K8wRQySBTzYs10efzeLAmQzOlIJ+j8C6IjuyXKr3W4ksZKmyYtMY7N0EsWgPEy
         pVnOaaK7GGe5kTsx7/tbToLf1Nbogxo5CKKDcgaxuQEITkThLh/Z4r8phhdyJGifQJkL
         rvVA==
X-Gm-Message-State: AOAM533zVVmU62vT9X5x2fHOqE67OD4EvM09R7KjlM7aUGqymr2YW/X6
        DOfiVBYex5pit9PXzHulKizUwBkh
X-Google-Smtp-Source: ABdhPJz+xj+l0+LKjpgunNAaNODIy1aohTFuKS+B3tEPy6iiXLEsDmsIKfBK0EQSAer4RQTyZYOaMg==
X-Received: by 2002:ad4:5624:: with SMTP id cb4mr1209842qvb.154.1589398470510;
        Wed, 13 May 2020 12:34:30 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id r128sm705296qke.109.2020.05.13.12.34.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 12:34:30 -0700 (PDT)
Message-ID: <5ebc4bc6.1c69fb81.a8850.464e@mx.google.com>
X-Google-Original-Message-ID: <20200513193419.19740-1-EVOFORGE\sdsmall@a-gady2p56i3do.evoforge.org>
From:   Smalley <stephen.smalley.work@gmail.com>
X-Google-Original-From: Smalley <EVOFORGE\sdsmall@a-gady2p56i3do.evoforge.org>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] libsemanage: fsync final files before rename
Date:   Wed, 13 May 2020 15:34:19 -0400
X-Mailer: git-send-email 2.23.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Stephen Smalley <stephen.smalley.work@gmail.com>

Prior to rename(2)'ing the final selinux policy files into place,
fsync(2) them to ensure the contents will be fully written prior to
rename.  While we are here, also fix checking of write(2) to detect
short writes and treat them as an error.  This code could be more
generally improved but keeping to the minimal changes required to fix
this bug.

Fixes: https://github.com/SELinuxProject/selinux/issues/237
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 falls back to EIO if errno is not set by a short write, and
only fsync's the final selinux policy files being created in
/etc/selinux, avoiding the overhead of fsync on every file copied
under /var/lib/selinux.

 libsemanage/src/direct_api.c     | 10 +++++-----
 libsemanage/src/semanage_store.c | 20 +++++++++++++++-----
 libsemanage/src/semanage_store.h |  4 +++-
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 1088a0ac..d2b91fb2 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1188,7 +1188,7 @@ cleanup:
  * overwrite it. If source doesn't exist then return success.
  * Returns 0 on success, -1 on error. */
 static int copy_file_if_exists(const char *src, const char *dst, mode_t mode){
-	int rc = semanage_copy_file(src, dst, mode);
+	int rc = semanage_copy_file(src, dst, mode, false);
 	return (rc < 0 && errno != ENOENT) ? rc : 0;
 }
 
@@ -1488,7 +1488,7 @@ rebuild:
 			retval = semanage_copy_file(path,
 						    semanage_path(SEMANAGE_TMP,
 								  SEMANAGE_STORE_SEUSERS),
-						    0);
+						    0, false);
 			if (retval < 0)
 				goto cleanup;
 			pseusers->dtable->drop_cache(pseusers->dbase);
@@ -1506,7 +1506,7 @@ rebuild:
 			retval = semanage_copy_file(path,
 						    semanage_path(SEMANAGE_TMP,
 								  SEMANAGE_USERS_EXTRA),
-						    0);
+						    0, false);
 			if (retval < 0)
 				goto cleanup;
 			pusers_extra->dtable->drop_cache(pusers_extra->dbase);
@@ -1595,7 +1595,7 @@ rebuild:
 
 	retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_KERNEL),
 			semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_KERNEL),
-			sh->conf->file_mode);
+			sh->conf->file_mode, false);
 	if (retval < 0) {
 		goto cleanup;
 	}
@@ -1634,7 +1634,7 @@ rebuild:
 			retval = semanage_copy_file(
 						semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_HOMEDIRS),
 						semanage_final_path(SEMANAGE_FINAL_TMP,	SEMANAGE_FC_HOMEDIRS),
-						sh->conf->file_mode);
+						sh->conf->file_mode, false);
 			if (retval < 0) {
 				goto cleanup;
 			}
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 859c0a22..cd5e46bb 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -707,7 +707,8 @@ static int semanage_filename_select(const struct dirent *d)
 
 /* Copies a file from src to dst.  If dst already exists then
  * overwrite it.  Returns 0 on success, -1 on error. */
-int semanage_copy_file(const char *src, const char *dst, mode_t mode)
+int semanage_copy_file(const char *src, const char *dst, mode_t mode,
+		bool syncrequired)
 {
 	int in, out, retval = 0, amount_read, n, errsv = errno;
 	char tmp[PATH_MAX];
@@ -735,8 +736,11 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode)
 	}
 	umask(mask);
 	while (retval == 0 && (amount_read = read(in, buf, sizeof(buf))) > 0) {
-		if (write(out, buf, amount_read) < 0) {
-			errsv = errno;
+		if (write(out, buf, amount_read) != amount_read) {
+			if (errno)
+				errsv = errno;
+			else
+				errsv = EIO;
 			retval = -1;
 		}
 	}
@@ -745,6 +749,10 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode)
 		retval = -1;
 	}
 	close(in);
+	if (syncrequired && fsync(out) < 0) {
+		errsv = errno;
+		retval = -1;
+	}
 	if (close(out) < 0) {
 		errsv = errno;
 		retval = -1;
@@ -811,7 +819,8 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
 			umask(mask);
 		} else if (S_ISREG(sb.st_mode) && flag == 1) {
 			mask = umask(0077);
-			if (semanage_copy_file(path, path2, sb.st_mode) < 0) {
+			if (semanage_copy_file(path, path2, sb.st_mode,
+						false) < 0) {
 				umask(mask);
 				goto cleanup;
 			}
@@ -1639,7 +1648,8 @@ static int semanage_install_final_tmp(semanage_handle_t * sh)
 			goto cleanup;
 		}
 
-		ret = semanage_copy_file(src, dst, sh->conf->file_mode);
+		ret = semanage_copy_file(src, dst, sh->conf->file_mode,
+					true);
 		if (ret < 0) {
 			ERR(sh, "Could not copy %s to %s.", src, dst);
 			goto cleanup;
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index 34bf8523..b9ec5664 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -24,6 +24,7 @@
 #ifndef SEMANAGE_MODULE_STORE_H
 #define SEMANAGE_MODULE_STORE_H
 
+#include <stdbool.h>
 #include <sys/time.h>
 #include <sepol/module.h>
 #include <sepol/cil/cil.h>
@@ -162,6 +163,7 @@ int semanage_nc_sort(semanage_handle_t * sh,
 		     size_t buf_len,
 		     char **sorted_buf, size_t * sorted_buf_len);
 
-int semanage_copy_file(const char *src, const char *dst, mode_t mode);
+int semanage_copy_file(const char *src, const char *dst, mode_t mode,
+		bool syncrequired);
 
 #endif
-- 
2.23.3

