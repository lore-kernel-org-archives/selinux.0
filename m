Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5634C43470
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9330761242
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhDMMZl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhDMMZk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Apr 2021 08:25:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53177C06138E
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ba6so19157755edb.1
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MgvCKJ37i42BE1ZMeTgDI4apdlhCMlBt+U/OESjm7Zk=;
        b=bn7esjzyuvW98nTNX9euvQ36fAqpO3G7Q0LgJXgta58LXklmhifOXbEvNLBonof76T
         hqqENDt/6j+GLlH4Qxs/U4Gp3dCkfCx0UNubTptmbmcvSQL83impQWmwitPPbou5KKmX
         TT2lwrDHgR+UEmdr0gu7OteO8h2zuOqBJ1DNdkws3Jz9llW2qynK/UmfKw8HUWl213qr
         5VdGCKH4Q31+rTZA54Q6XQ1Ls2N2Iy79T62XT7Wt0DDtJ2i7TQQ0TH2FmAW6N6DPO5Sc
         ABUVy0Q4sVu0mY/rR3aJ6eFofq0DaBE10LbkEbfN8bzs8BWU26ZUr3fqlt8MsSLr7Wl1
         1IQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MgvCKJ37i42BE1ZMeTgDI4apdlhCMlBt+U/OESjm7Zk=;
        b=JCJX01Uh1HIHpBQhvKLufQ6B1fJGbJtx877REUquRwRjGnC2O9gV+BdT5WWn+zNY2z
         0e2dwBovTy9ippH6R5dKiGOJ3csBmH8YZtmtAQdrL3rIl2gD+BTQS6mg3vx6/Rl0k7cZ
         slOxXSh/SDWSKUm3Sk9jSInaRVJsfQzt00PgRXUhx42orPJ1YTKOD40wWydqON52FfOs
         fp8NY4SIv44E8g2gJc9Hh1aOhws+5g2JfBxJJs67S5D3JTCMQjg14w89fvjZ8yohFAR6
         xD+5WV3MHupuvBqHRbuoo01ZD+RYQlt/yPkYePiY7YNVovgH+FYYiSK82ffABVXiyAEQ
         S1ZQ==
X-Gm-Message-State: AOAM530YU6SgdO3FZIXHCM0BsT6ABbUQMFLwyQVTFWbw1nji7SHxSAZx
        akhJadLO8KEIBdpXcSLFasU+hOniUC0=
X-Google-Smtp-Source: ABdhPJzB2ya/QEwq2Y/Hjrasp34YtchxGlISroFRoqPQiHn2sAlvXJEt1O6wmpI/k7JLQEZDkbjzlQ==
X-Received: by 2002:aa7:d688:: with SMTP id d8mr27926029edr.294.1618316716026;
        Tue, 13 Apr 2021 05:25:16 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-170-158.77.1.pool.telefonica.de. [77.1.170.158])
        by smtp.gmail.com with ESMTPSA id mp36sm7594438ejc.48.2021.04.13.05.25.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:25:15 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC SHADOW PATCH 5/7] selinux.c: use modern selabel interface instead of deprecated matchpathcon
Date:   Tue, 13 Apr 2021 14:25:06 +0200
Message-Id: <20210413122508.24745-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210413122508.24745-1-cgzones@googlemail.com>
References: <20210413122508.24745-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

matchpathcon(3) is deprecated in favor of selabel_lookup(3).
---
 lib/selinux.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/lib/selinux.c b/lib/selinux.c
index a2ea91c8..41f4371d 100644
--- a/lib/selinux.c
+++ b/lib/selinux.c
@@ -35,7 +35,7 @@
 #include "defines.h"
 
 #include <selinux/selinux.h>
-#include <selinux/context.h>
+#include <selinux/label.h>
 #include "prototypes.h"
 
 static bool selinux_checked = false;
@@ -53,8 +53,6 @@ static bool selinux_enabled;
  */
 int set_selinux_file_context (const char *dst_name)
 {
-	/*@null@*/char *scontext = NULL;
-
 	if (!selinux_checked) {
 		selinux_enabled = is_selinux_enabled () > 0;
 		selinux_checked = true;
@@ -62,19 +60,33 @@ int set_selinux_file_context (const char *dst_name)
 
 	if (selinux_enabled) {
 		/* Get the default security context for this file */
-		if (matchpathcon (dst_name, 0, &scontext) < 0) {
-			if (security_getenforce () != 0) {
-				return 1;
+
+		/*@null@*/char *fcontext_raw = NULL;
+		struct selabel_handle *hnd;
+		int r;
+
+		hnd = selabel_open(SELABEL_CTX_FILE, NULL, 0);
+		if (hnd == NULL) {
+			return security_getenforce () != 0;
+		}
+
+		r = selabel_lookup_raw(hnd, &fcontext_raw, dst_name, 0);
+		selabel_close(hnd);
+		if (r < 0) {
+			/* No context specified for the searched path */
+			if (errno == ENOENT) {
+				return 0;
 			}
+
+			return security_getenforce () != 0;
 		}
+
 		/* Set the security context for the next created file */
-		if (setfscreatecon (scontext) < 0) {
-			if (security_getenforce () != 0) {
-				freecon (scontext);
-				return 1;
-			}
+		r = setfscreatecon_raw (fcontext_raw);
+		freecon (fcontext_raw);
+		if (r < 0) {
+			return security_getenforce () != 0;
 		}
-		freecon (scontext);
 	}
 	return 0;
 }
-- 
2.31.0

