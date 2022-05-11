Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5495C433EF
	for <selinux@archiver.kernel.org>; Wed, 11 May 2022 18:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346446AbiEKSmg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 May 2022 14:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243972AbiEKSmf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 May 2022 14:42:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771EE61293
        for <selinux@vger.kernel.org>; Wed, 11 May 2022 11:42:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i19so5767434eja.11
        for <selinux@vger.kernel.org>; Wed, 11 May 2022 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oLv41upLn9lzvRODLU8/ka+NpA5IOCMt58nX/x+6gbQ=;
        b=b4FY6k8bdA/B00Ht7e9zoTNVJ1sS+VzZZDLoIvlkBSgplaY/lTBWelK8zmu5TuvK1T
         Ag90+HnzaQpYtYDpOogsE/k0vuihcEI9/H9wSq09WaDzhvyDWEPai2Hle8zsFpidN8r1
         CorA7D6UEbYPUWsT408yri+Uy96oryivASi3W54KoK1t+T/oMKzYPtFgTEk8S8FIMxsd
         e4ylQ7kKLaj1Hsu1lmk5OnU0LxS1ZQbf2IXJFgTZu9a1aVucPtesXjjgn/PwrOyaJlrU
         bT6mUOlnZdU6o/KhvnBd++2/tXfArCjUep4y3uJ0i6wrywrmUCFda8b18a95K4YH49Kw
         J7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLv41upLn9lzvRODLU8/ka+NpA5IOCMt58nX/x+6gbQ=;
        b=nX3MTsIeoQ7I04JhN/9126jTjYHg7ONjpkmGMWE3FJGnXv3t6I1A4WEhzkjVXde/7+
         bv+kTdJLraHBPZjhIjXC2CYhVjsPrJ/f17xDsN0whFzV6SnDHilri6qfQI0zRrxM1aOz
         5f2EaZ+VbgCWYceSvmD+4DDPkTtFKKt1rsc+UwIo5XXJwl6eQYPcl4O8Ul2058WC9SH3
         ex0HYmyJHZtUeKC07VT6wzcG86l0W1BirJ1hWKXVIoyuMbMDioAnCIeKV5zPMfl3pVI2
         8FKG8i6Wpqj291Sfhb6y/slTkH1QMoZnwzRZ+GeCQLLA812HhQAS1jlVGcUFAY3gb6zg
         GGzg==
X-Gm-Message-State: AOAM5327DSHZzk/5vFrhpcmp7ZZEq0Lcbx4h1FQ+rYSd7rkXCNGyGAHJ
        VkV2Cjo1JkPEed3Vb9J3Dhy6HuT/WPI=
X-Google-Smtp-Source: ABdhPJyTbetJ9qqWIxzYqEPMzd0AgQ2YkNauFmTecQth958yqyx9au7RQdlEQMtrcwJyIqeGgK/T5w==
X-Received: by 2002:a17:907:3da4:b0:6f4:ff2b:8299 with SMTP id he36-20020a1709073da400b006f4ff2b8299mr27482300ejc.109.1652294552962;
        Wed, 11 May 2022 11:42:32 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-140-049.95.112.pool.telefonica.de. [95.112.140.49])
        by smtp.gmail.com with ESMTPSA id y25-20020aa7ca19000000b0042617ba639dsm1535788eds.39.2022.05.11.11.42.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 11:42:32 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 2/4] libselinux: restorecon: misc tweaks
Date:   Wed, 11 May 2022 20:42:23 +0200
Message-Id: <20220511184225.218062-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220505174420.24537-1-cgzones@googlemail.com>
References: <20220505174420.24537-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

* mark read-only parameters const
* check for overflow when adding exclude directory
* use 64 bit integer for file counting
* avoid implicit conversions

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index e6192912..c158ead8 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -44,7 +44,7 @@
 static struct selabel_handle *fc_sehandle = NULL;
 static bool selabel_no_digest;
 static char *rootpath = NULL;
-static int rootpathlen;
+static size_t rootpathlen;
 
 /* Information on excluded fs and directories. */
 struct edir {
@@ -55,7 +55,7 @@ struct edir {
 };
 #define CALLER_EXCLUDED true
 static bool ignore_mounts;
-static int exclude_non_seclabel_mounts(void);
+static uint64_t exclude_non_seclabel_mounts(void);
 static int exclude_count = 0;
 static struct edir *exclude_lst = NULL;
 static uint64_t fc_count = 0;	/* Number of files processed so far */
@@ -169,6 +169,12 @@ static int add_exclude(const char *directory, bool who)
 		return -1;
 	}
 
+	if (exclude_count >= INT_MAX - 1) {
+		selinux_log(SELINUX_ERROR, "Too many directory excludes: %d.\n", exclude_count);
+		errno = EOVERFLOW;
+		return -1;
+	}
+
 	tmp_list = realloc(exclude_lst,
 			   sizeof(struct edir) * (exclude_count + 1));
 	if (!tmp_list)
@@ -211,10 +217,10 @@ static int check_excluded(const char *file)
 	return 0;
 }
 
-static int file_system_count(char *name)
+static uint64_t file_system_count(const char *name)
 {
 	struct statvfs statvfs_buf;
-	int nfile = 0;
+	uint64_t nfile = 0;
 
 	memset(&statvfs_buf, 0, sizeof(statvfs_buf));
 	if (!statvfs(name, &statvfs_buf))
@@ -230,12 +236,13 @@ static int file_system_count(char *name)
  * that support security labels have the seclabel option, return
  * approximate total file count.
  */
-static int exclude_non_seclabel_mounts(void)
+static uint64_t exclude_non_seclabel_mounts(void)
 {
 	struct utsname uts;
 	FILE *fp;
 	size_t len;
-	int index = 0, found = 0, nfile = 0;
+	int index = 0, found = 0;
+	uint64_t nfile = 0;
 	char *mount_info[4];
 	char *buf = NULL, *item;
 
@@ -300,7 +307,8 @@ static int add_xattr_entry(const char *directory, bool delete_nonmatch,
 {
 	char *sha1_buf = NULL;
 	size_t i, digest_len = 0;
-	int rc, digest_result;
+	int rc;
+	enum digest_result digest_result;
 	bool match;
 	struct dir_xattr *new_entry;
 	uint8_t *xattr_digest = NULL;
@@ -573,7 +581,7 @@ static void filespec_destroy(void)
  * Called if SELINUX_RESTORECON_SET_SPECFILE_CTX is not set to check if
  * the type components differ, updating newtypecon if so.
  */
-static int compare_types(char *curcon, char *newcon, char **newtypecon)
+static int compare_types(const char *curcon, const char *newcon, char **newtypecon)
 {
 	int types_differ = 0;
 	context_t cona;
@@ -1398,7 +1406,7 @@ void selinux_restorecon_set_exclude_list(const char **exclude_list)
 /* selinux_restorecon_set_alt_rootpath(3) sets an alternate rootpath. */
 int selinux_restorecon_set_alt_rootpath(const char *alt_rootpath)
 {
-	int len;
+	size_t len;
 
 	/* This should be NULL on first use */
 	if (rootpath)
-- 
2.36.1

