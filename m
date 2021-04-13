Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00509C43600
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD866128E
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhDMMZl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhDMMZk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Apr 2021 08:25:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6ACC06138C
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z1so19153426edb.8
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YEMbbGivcd3OpKh6jUYTQGnAYvRg9+PDWYg9GFikNjc=;
        b=VB/vnupC3nHGrx/xslZd+DWjA4f6AYZHFmitAZ+5ghiBRaS+HNSEeiF1EjfwSpq7a9
         n2S4pZ+tMCGXCnioMSy+tIvMdHE8aDdfuvv7R2ljZmmk2YENLYMM756XMhbZmW7/k46p
         Oso4FeZPvcCsJZiIQ/Tj0t2kvNDUeT6pYgX8LfYrIc3dL8o0ldId1kLtGAMP5ADf7eZK
         1/KS40Rz6S9XI7o//LB6o92iRnZ+F4AJg4ge/E1tdnXN6Wt1RW0JNExlzJj9qq34STlN
         csJUh8SUJ0ZK0vVebZmhlU4C3ZMbhBEzza6JYV+zKqRq18E2qimoNN7jVCh9m8V0BibF
         jWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEMbbGivcd3OpKh6jUYTQGnAYvRg9+PDWYg9GFikNjc=;
        b=N+XFg4XSzZ1Z9lt9kvmmD4agT2pAG/9dbwKXZ4nygZAA1R3lPCkXW+BgOLro7wZaBA
         NrTwSLYBaD55Q8cToV6wyYHStPwDqP+alVrCdBsNBfOIzTUvQi2LN1gTNzi9I8owLsAi
         WdzNEEoIJdl4tqRa8pTJRSDOADINFL21j2qqOfxgskOdw7zSzlrmEulQBhY2KZZY8dLJ
         skT4xoikioxeWDKxxv04SZhBkha1lsmkoYsyhs007EWHQ4Sq828HmkQ9NQcpovp7Q2Lt
         gzVm6YVw3I3RVeTAktNS3XLjaOgDitwuLVlAgZWZDns4Hi3yy6jrOSUHoz8Nz59Fj7f5
         lFsg==
X-Gm-Message-State: AOAM531PARuHbGkhjQpWolD64nu8XUxzTLFZMifvRrRvVEYcHQI8rB55
        W+FwBZYDiF0nzcHjl/vLnYc5Yi+Xst8=
X-Google-Smtp-Source: ABdhPJwZArQSCqVpsGkndjnBOkgsUHPq7xxXAOR+PAVWedp81OX+f3SX9xpZs2uSaZVCkcqU/+wyBg==
X-Received: by 2002:aa7:c746:: with SMTP id c6mr20089831eds.90.1618316715270;
        Tue, 13 Apr 2021 05:25:15 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-170-158.77.1.pool.telefonica.de. [77.1.170.158])
        by smtp.gmail.com with ESMTPSA id mp36sm7594438ejc.48.2021.04.13.05.25.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:25:15 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC SHADOW PATCH 3/7] selinux.c: do not use deprecated typedef and skip context translation
Date:   Tue, 13 Apr 2021 14:25:04 +0200
Message-Id: <20210413122508.24745-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210413122508.24745-1-cgzones@googlemail.com>
References: <20210413122508.24745-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These retrieved contexts are just passed to libselinux functions and not
printed or otherwise made available to the outside, so a context
translation to human readable MCS/MLS labels is not needed.
(see man:setrans.conf(5))

The typedef security_context_t is deprecated, see
https://github.com/SELinuxProject/selinux/commit/9eb9c9327563014ad6a807814e7975424642d5b9
---
 lib/selinux.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/selinux.c b/lib/selinux.c
index c60cbed5..e31a5f92 100644
--- a/lib/selinux.c
+++ b/lib/selinux.c
@@ -53,7 +53,7 @@ static bool selinux_enabled;
  */
 int set_selinux_file_context (const char *dst_name)
 {
-	/*@null@*/security_context_t scontext = NULL;
+	/*@null@*/char *scontext = NULL;
 
 	if (!selinux_checked) {
 		selinux_enabled = is_selinux_enabled () > 0;
@@ -93,7 +93,7 @@ int reset_selinux_file_context (void)
 		selinux_checked = true;
 	}
 	if (selinux_enabled) {
-		if (setfscreatecon (NULL) != 0) {
+		if (setfscreatecon_raw (NULL) != 0) {
 			return 1;
 		}
 	}
@@ -175,7 +175,7 @@ skip_syslog:
  */
 int check_selinux_permit (const char *perm_name)
 {
-	char *user_context_str;
+	char *user_context_raw;
 	int r;
 
 	if (0 == is_selinux_enabled ()) {
@@ -184,7 +184,7 @@ int check_selinux_permit (const char *perm_name)
 
 	selinux_set_callback (SELINUX_CB_LOG, (union selinux_callback) selinux_log_cb);
 
-	if (getprevcon (&user_context_str) != 0) {
+	if (getprevcon_raw (&user_context_raw) != 0) {
 		fprintf (stderr,
 		    _("%s: can not get previous SELinux process context: %s\n"),
 		    Prog, strerror (errno));
@@ -194,8 +194,8 @@ int check_selinux_permit (const char *perm_name)
 		return (security_getenforce () != 0);
 	}
 
-	r = selinux_check_access (user_context_str, user_context_str, "passwd", perm_name, NULL);
-	freecon (user_context_str);
+	r = selinux_check_access (user_context_raw, user_context_raw, "passwd", perm_name, NULL);
+	freecon (user_context_raw);
 	return r;
 }
 
-- 
2.31.0

