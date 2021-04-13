Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8983BC43603
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A116128E
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhDMMZm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhDMMZk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Apr 2021 08:25:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF82C061342
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 18so19168001edx.3
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DgCblF0rG6OORy5R3TaYAHK2C3Y7EqzivoysmPQjD6A=;
        b=rz+J2Uah3uM+OXZxgYRNqWhNDmv+OFcwLLI5e+u163JFN7SASqs7sZd0ezsJHvXrVp
         17XiuOZN/4bh114rzJB+yfmtMh+NfKgdv4CddxiFWDqHcf4s1M9QEKwdTcOaviacWUcs
         jL7nhwrHKDRqOKiSxJzBUIF+mi/FMvhe+xJe9BF7h3apUs3HXSpB6lNIVMy0W9KBKVpy
         xka2/R5Ai0ANSkGb5z5fxhJU7mkSgyhsgGesAiSzlnbhpOGD8/4kD7wxvI+3u4n9Au9Z
         RZ4IqXn3JVzfaRBuHzC6Aq0x1lUI7786J8QJTls2PfeQuhIHjpl3UdaY/A7tFbkbyU8T
         2C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DgCblF0rG6OORy5R3TaYAHK2C3Y7EqzivoysmPQjD6A=;
        b=Enb1Y6XCHlis22Yxuaw/rsVMxftPJFlIiZN9DmRXMnwXCftr8SXbu2Jdb57hR9WskQ
         js653lgTwIZ3YnRV6fwOa66bJTieGtLz8icq1LvTP1dz5vauWAB+VnrKJnzu+Dasg2k1
         RInDVzCC9rF/6/n5nVOX1IouZjqVn5z6ZM6hcjqyV4lRuSTXgW1zqvJHIM5EbIJoZrLQ
         vOZ5UPufOUujimEM0d6eGwVvXZNGEWwAcAZ9mTS2NzMe0CkCoj5s/dcYdlEy4bO4vubm
         t5MmcTFUyh4L6lds8V1txULPYPuYeyWalLC3uvfcneTXLhcT6luIeZJND5vk9kcRoHY4
         m9Cw==
X-Gm-Message-State: AOAM53233yDQ0dCDINgjxYWeAJGph6raJcOVLNoy8ePZ6pJQ/onpWHxM
        EBxnYZWh9NI8KSaJsd8/P4+kJtTIELI=
X-Google-Smtp-Source: ABdhPJzbH9iyDt62cZ35VPF1ySr1BXqMfkaIOz2Jk3ApDRu2WZ+g0TUtAtpppV5ADJh3TII4UhzrfA==
X-Received: by 2002:a05:6402:22f9:: with SMTP id dn25mr19917508edb.171.1618316716741;
        Tue, 13 Apr 2021 05:25:16 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-170-158.77.1.pool.telefonica.de. [77.1.170.158])
        by smtp.gmail.com with ESMTPSA id mp36sm7594438ejc.48.2021.04.13.05.25.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:25:16 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC SHADOW PATCH 7/7] selinux: only open selabel database once
Date:   Tue, 13 Apr 2021 14:25:08 +0200
Message-Id: <20210413122508.24745-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210413122508.24745-1-cgzones@googlemail.com>
References: <20210413122508.24745-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Once opened, keep the selabel database open for further lookups.
Register an exit handler to close the database.
---
 lib/selinux.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/selinux.c b/lib/selinux.c
index 719acda3..28ca5fff 100644
--- a/lib/selinux.c
+++ b/lib/selinux.c
@@ -40,6 +40,15 @@
 
 static bool selinux_checked = false;
 static bool selinux_enabled;
+static /*@null@*/struct selabel_handle *selabel_hnd = NULL;
+
+static void cleanup(void)
+{
+	if (selabel_hnd) {
+		selabel_close(selabel_hnd);
+		selabel_hnd = NULL;
+	}
+}
 
 /*
  * set_selinux_file_context - Set the security context before any file or
@@ -62,16 +71,17 @@ int set_selinux_file_context (const char *dst_name, mode_t mode)
 		/* Get the default security context for this file */
 
 		/*@null@*/char *fcontext_raw = NULL;
-		struct selabel_handle *hnd;
 		int r;
 
-		hnd = selabel_open(SELABEL_CTX_FILE, NULL, 0);
-		if (hnd == NULL) {
-			return security_getenforce () != 0;
+		if (selabel_hnd == NULL) {
+			selabel_hnd = selabel_open(SELABEL_CTX_FILE, NULL, 0);
+			if (selabel_hnd == NULL) {
+				return security_getenforce () != 0;
+			}
+			(void) atexit(cleanup);
 		}
 
-		r = selabel_lookup_raw(hnd, &fcontext_raw, dst_name, mode);
-		selabel_close(hnd);
+		r = selabel_lookup_raw(selabel_hnd, &fcontext_raw, dst_name, mode);
 		if (r < 0) {
 			/* No context specified for the searched path */
 			if (errno == ENOENT) {
-- 
2.31.0

