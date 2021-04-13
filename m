Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459D3C43462
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A14E61278
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhDMMZl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhDMMZi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Apr 2021 08:25:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEECC06138F
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e7so19109565edu.10
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BQ6l1tDcOIFoUZt+0RghRFSnSpEKvxG6TsGX7pjC8OU=;
        b=spJLgGg9acYurVRGGFi9LURumjVOwaZ1a5awVFVIjUmqOQLh9fGGZEofjDfn6n4J6u
         1nC0fO5bwBfLWyaNOEcwxvC7WuD12+lDfQbM4C+XNFGaNijTp2cFT09SZHtxPVKIEAt6
         EtHIrSDdfcuFQ4Y3cWA2ORzKZeX8zbdzN7y4KHjktWJYogaotFwg16U43s0UNmdrnypU
         6pIuOnH+tPOj6OsGKz735MZ21m4UTw1fSVu6vJiwu50Td3Z3B1PkkfuXBWUtKyt3oicO
         Auq5DVx63We6/4t3NwqnrINsLsoLmmsdzACp+7RuJBPG0IZDER2XuF4AWgHI/pm11b3m
         oMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQ6l1tDcOIFoUZt+0RghRFSnSpEKvxG6TsGX7pjC8OU=;
        b=pko65i2h5+/Ntwsu00AOmSeXu6oB/LKCA1K+HbxFnFhVNdhPm64IGx16OIm76ILGD8
         W+1gbhlEq7bK5FyIzII+Z8ZTkjLjM6vXz6RtkVanxAB32CmFfKNnKSlnaw5Co2OKotuX
         o4WKGET85VromnNME5BWHUIpVtdDHbz4upbH+QDBCsg0RDU3Wudy67Sdvti6hFFQNW+R
         OZ0LgnTRsFWNzbeZxAJqDBhU4RT7ZuqB2TXDlWMfwOYjLfxcfu1v4DwZE+z2Rq0kjxFC
         17tBXDu2SscuYwRF63JmzTu4Wk3tL2fQEzw0xStSMrouiZUJGkiL7uVoAbwlIQmfbEXo
         jVAA==
X-Gm-Message-State: AOAM53356Naq/CAvxFG8ovR+oQ6DNqJA3qPGXStE/JOGd0Ya3DmF0qg2
        x283LP73DGzd2vuud98Yl280Ni0D/js=
X-Google-Smtp-Source: ABdhPJwDy3Zp23sKvWG1Rr4xnbMyzu2MwruzWPyYR86s8UIoW6Lgq7KPupgGKU/j7owMnjrU9CVNrQ==
X-Received: by 2002:a05:6402:2752:: with SMTP id z18mr34854675edd.275.1618316716372;
        Tue, 13 Apr 2021 05:25:16 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-170-158.77.1.pool.telefonica.de. [77.1.170.158])
        by smtp.gmail.com with ESMTPSA id mp36sm7594438ejc.48.2021.04.13.05.25.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:25:16 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC SHADOW PATCH 6/7] set_selinux_file_context(): prepare context for actual file type
Date:   Tue, 13 Apr 2021 14:25:07 +0200
Message-Id: <20210413122508.24745-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210413122508.24745-1-cgzones@googlemail.com>
References: <20210413122508.24745-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Search the SELinux selabel database for the file type to be created.
Not specifying the file mode can cause an incorrect file context to be
returned.

Also prepare contexts in commonio_close() for the generic database
filename, not with the backup suffix appended, to ensure the desired
file context after the final rename.

Closes: #322
---
 lib/commonio.c    | 4 ++--
 lib/prototypes.h  | 2 +-
 lib/selinux.c     | 4 ++--
 libmisc/copydir.c | 8 ++++----
 src/useradd.c     | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/commonio.c b/lib/commonio.c
index c5b3d104..3c81c796 100644
--- a/lib/commonio.c
+++ b/lib/commonio.c
@@ -974,7 +974,7 @@ int commonio_close (struct commonio_db *db)
 		snprintf (buf, sizeof buf, "%s-", db->filename);
 
 #ifdef WITH_SELINUX
-		if (set_selinux_file_context (buf) != 0) {
+		if (set_selinux_file_context (db->filename, S_IFREG) != 0) {
 			errors++;
 		}
 #endif
@@ -1007,7 +1007,7 @@ int commonio_close (struct commonio_db *db)
 	snprintf (buf, sizeof buf, "%s+", db->filename);
 
 #ifdef WITH_SELINUX
-	if (set_selinux_file_context (buf) != 0) {
+	if (set_selinux_file_context (db->filename, S_IFREG) != 0) {
 		errors++;
 	}
 #endif
diff --git a/lib/prototypes.h b/lib/prototypes.h
index ac9ad274..a3c4f7c2 100644
--- a/lib/prototypes.h
+++ b/lib/prototypes.h
@@ -334,7 +334,7 @@ extern /*@observer@*/const char *crypt_make_salt (/*@null@*//*@observer@*/const
 
 /* selinux.c */
 #ifdef WITH_SELINUX
-extern int set_selinux_file_context (const char *dst_name);
+extern int set_selinux_file_context (const char *dst_name, mode_t mode);
 extern int reset_selinux_file_context (void);
 extern int check_selinux_permit (const char *perm_name);
 #endif
diff --git a/lib/selinux.c b/lib/selinux.c
index 41f4371d..719acda3 100644
--- a/lib/selinux.c
+++ b/lib/selinux.c
@@ -51,7 +51,7 @@ static bool selinux_enabled;
  *	Callers may have to Reset SELinux to create files with default
  *	contexts with reset_selinux_file_context
  */
-int set_selinux_file_context (const char *dst_name)
+int set_selinux_file_context (const char *dst_name, mode_t mode)
 {
 	if (!selinux_checked) {
 		selinux_enabled = is_selinux_enabled () > 0;
@@ -70,7 +70,7 @@ int set_selinux_file_context (const char *dst_name)
 			return security_getenforce () != 0;
 		}
 
-		r = selabel_lookup_raw(hnd, &fcontext_raw, dst_name, 0);
+		r = selabel_lookup_raw(hnd, &fcontext_raw, dst_name, mode);
 		selabel_close(hnd);
 		if (r < 0) {
 			/* No context specified for the searched path */
diff --git a/libmisc/copydir.c b/libmisc/copydir.c
index e6aac6ec..1ca98b67 100644
--- a/libmisc/copydir.c
+++ b/libmisc/copydir.c
@@ -484,7 +484,7 @@ static int copy_dir (const char *src, const char *dst,
 	 */
 
 #ifdef WITH_SELINUX
-	if (set_selinux_file_context (dst) != 0) {
+	if (set_selinux_file_context (dst, S_IFDIR) != 0) {
 		return -1;
 	}
 #endif				/* WITH_SELINUX */
@@ -605,7 +605,7 @@ static int copy_symlink (const char *src, const char *dst,
 	}
 
 #ifdef WITH_SELINUX
-	if (set_selinux_file_context (dst) != 0) {
+	if (set_selinux_file_context (dst, S_IFLNK) != 0) {
 		free (oldlink);
 		return -1;
 	}
@@ -684,7 +684,7 @@ static int copy_special (const char *src, const char *dst,
 	int err = 0;
 
 #ifdef WITH_SELINUX
-	if (set_selinux_file_context (dst) != 0) {
+	if (set_selinux_file_context (dst, statp->st_mode & S_IFMT) != 0) {
 		return -1;
 	}
 #endif				/* WITH_SELINUX */
@@ -744,7 +744,7 @@ static int copy_file (const char *src, const char *dst,
 		return -1;
 	}
 #ifdef WITH_SELINUX
-	if (set_selinux_file_context (dst) != 0) {
+	if (set_selinux_file_context (dst, S_IFREG) != 0) {
 		return -1;
 	}
 #endif				/* WITH_SELINUX */
diff --git a/src/useradd.c b/src/useradd.c
index dcda3196..b3fff895 100644
--- a/src/useradd.c
+++ b/src/useradd.c
@@ -2177,7 +2177,7 @@ static void create_home (void)
 		++bhome;
 
 #ifdef WITH_SELINUX
-		if (set_selinux_file_context (prefix_user_home) != 0) {
+		if (set_selinux_file_context (prefix_user_home, S_IFDIR) != 0) {
 			fprintf (stderr,
 			         _("%s: cannot set SELinux context for home directory %s\n"),
 			         Prog, user_home);
@@ -2305,7 +2305,7 @@ static void create_mail (void)
 			sprintf (file, "%s/%s", spool, user_name);
 
 #ifdef WITH_SELINUX
-		if (set_selinux_file_context (file) != 0) {
+		if (set_selinux_file_context (file, S_IFREG) != 0) {
 			fprintf (stderr,
 			         _("%s: cannot set SELinux context for mailbox file %s\n"),
 			         Prog, file);
-- 
2.31.0

