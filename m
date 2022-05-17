Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AFCC433F5
	for <selinux@archiver.kernel.org>; Tue, 17 May 2022 14:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242968AbiEQOH4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 May 2022 10:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiEQOHz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 May 2022 10:07:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9385C45AD3
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 07:07:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id p26so6359381eds.5
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 07:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wYrjwfOPCfPrzRRr8AZzmJR+KMvh3y2QXEJjHDR3yXE=;
        b=M16oS2ETdSaKykQelwBnTeOiH7IHA1sAVi1Ia+XSYIw56KkjmmavRDKd/qC21Uim4A
         Qy4yJzbiG3x6RxKj8iWXXJ96TnFUbIcR4EkX0+sl0c0qi83VGs8nlro7oFlMH7J4CDkc
         VdSAqSstdIRhBrdKVIrNiqPpMOIoMQQxfe8eMFq9FyDfcCPBD7Ll1zwT2lhHVCGdx1IL
         LObYgA2uZuUTrciiMSfzdZ1WQQMMrI6SXbNzUjXbgPFdpjvpgzstEtohoQXK7nQ8EQTi
         dGhIL8ZFWchYQCKg6+Nud7GEByvq1wkuI27zbBEbLUDV/UOadH24+LpxTeVqFXY5uqSX
         K05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wYrjwfOPCfPrzRRr8AZzmJR+KMvh3y2QXEJjHDR3yXE=;
        b=vSmvWQYagJ51ZwyGES806NT4LZd6auOP/VaBHQ2RYhvQofxeUbNREKMB76Q1BL4VFq
         NtNhf3UUxNYrnxi6kj831iDxEzH4JDp8eLiG7v5IREiXMOdgrNp5BD7ziynzQBY8ZFvj
         9rPiafxZxk31Embsa3Gzr4uPDfLRL1arqcI6bKq71bMVUG/mmo1jaRJN5xcjYstdKyLK
         povsHDfWgJMtFoBggu3QRBFg4qq2gOIVGhdtcCYuYhXkxpY9KcIqrb5u6FaN2rvdWlRk
         vSANGjtDrIeWKvsC+SyDQXOwBG8Hp2voxcoduNVR8sWR0cJrzsZPoozrCU1AYvA4oCr+
         0tqg==
X-Gm-Message-State: AOAM531jK3289tnCgViQr9X9sgI973Fmg9HAaRnlFwlmWG/VbxDlVbuo
        amKHjlT/xTb4VFAadUVCV57GzB+xtvw=
X-Google-Smtp-Source: ABdhPJz/RZJCX1Lj5hdrB0bhUZV1zDDurmU+XPWDYk0JLDw3a9THRRwcb4b/vHZ4DafLLXcIrP7fIg==
X-Received: by 2002:a05:6402:5242:b0:427:cade:4737 with SMTP id t2-20020a056402524200b00427cade4737mr18952834edd.398.1652796473117;
        Tue, 17 May 2022 07:07:53 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-065-249.95.112.pool.telefonica.de. [95.112.65.249])
        by smtp.gmail.com with ESMTPSA id p19-20020a17090664d300b006f3ef214e1csm1089714ejn.130.2022.05.17.07.07.52
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:07:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libselinux: restorecon: add fallback for pre 3.6 Linux
Date:   Tue, 17 May 2022 16:07:47 +0200
Message-Id: <20220517140748.24238-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

fstat(2) on file descriptors obtained via O_PATH is supported since
Linux 3.6. Fallback on older systems to lstat(2).

Fixes: 7e979b56 ("libselinux: restorecon: pin file to avoid TOCTOU issues")

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/selinux_restorecon.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 9dd6be81..1a185ced 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -89,10 +89,22 @@ struct rest_flags {
 	bool count_errors;
 };
 
+/* Linux version for availability tests. */
+static struct utsname uts;
+
 static void restorecon_init(void)
 {
 	struct selabel_handle *sehandle = NULL;
 
+	if (uname(&uts) < 0) {
+		/*
+		 * utsname(2) should never fail, but assume oldest supported
+		 * LTS release as backup
+		 */
+		strncpy(uts.release, "4.9", sizeof(uts.release));
+		uts.release[sizeof(uts.release) - 1] = '\0';
+	}
+
 	if (!fc_sehandle) {
 		sehandle = selinux_restorecon_default_handle();
 		selinux_restorecon_set_sehandle(sehandle);
@@ -238,7 +250,6 @@ static uint64_t file_system_count(const char *name)
  */
 static uint64_t exclude_non_seclabel_mounts(void)
 {
-	struct utsname uts;
 	FILE *fp;
 	size_t len;
 	int index = 0, found = 0;
@@ -247,7 +258,7 @@ static uint64_t exclude_non_seclabel_mounts(void)
 	char *buf = NULL, *item;
 
 	/* Check to see if the kernel supports seclabel */
-	if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.30") < 0)
+	if (strverscmp(uts.release, "2.6.30") < 0)
 		return 0;
 	if (is_selinux_enabled() <= 0)
 		return 0;
@@ -648,9 +659,19 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
 	if (fd < 0)
 		goto err;
 
+	/*
+	 * fstat(2) on file descriptors obtained via O_PATH are supported
+	 * since Linux 3.6, see man:open(2).
+	 * Test fstat(2) first, support might have been backported.
+	 */
 	rc = fstat(fd, &stat_buf);
-	if (rc < 0)
-		goto err;
+	if (rc < 0) {
+		if (errno == EBADF && strverscmp(uts.release, "3.6") < 0)
+			rc = lstat(pathname, &stat_buf);
+
+		if (rc < 0)
+			goto err;
+	}
 
 	if (rootpath != NULL && lookup_path[0] == '\0')
 		/* this is actually the root dir of the alt root. */
-- 
2.36.1

