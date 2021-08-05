Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF39C4320A
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A8360F25
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbhHEO0c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Aug 2021 10:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241054AbhHEO0c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Aug 2021 10:26:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7356C0613D5
        for <selinux@vger.kernel.org>; Thu,  5 Aug 2021 07:26:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hs10so10005915ejc.0
        for <selinux@vger.kernel.org>; Thu, 05 Aug 2021 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1PiZzGZGuxauORAnr31QWFuKPLWWlnans+lOtR5Pkik=;
        b=RtenZebPGeYb71aTS89QYcEciswarusP5CKSjA5VuPtdGUsiS1/GghACT0GE9bpfCd
         HEFLHvDfskrRYGpYiEosctUrnF4Ee8+9+YrgiNvl+VyREilWuMfZGD8dArHr72miNK4s
         uGizIWaKwT6KYeAWi7+8e5vkFWG2xJMIUSF6m4ChzrmMwhwmNaIdM3lYRivWGVrEQr1j
         bXcMvJKrAc63qSPj8A9QbiWC/2HhTg/6huN8ujduUC/ewYiIt7q2DkIXSzbmiUqXz2iz
         OYFvwUufc8EqJdMA1qZbqsoAhffvHyTeZv5FwoPoCf4q5ZilvbJdwVK5bttCeIiNJArJ
         MElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1PiZzGZGuxauORAnr31QWFuKPLWWlnans+lOtR5Pkik=;
        b=on51sbXn0fscLuu0r9ZzOVE2c2AZb4k18njq1hDur/KA4VQ1aSsw7ZFrOdgKYRPin0
         KatGraTr2uZVKoMHKW78/ayPYkOxoXsoGTiQzFiisuOJB015E27H3slokReFZ3raO1CN
         Cy0EAZfOqu0R5zRvfpieHyI1mhTl3qqzZy9cNdwQJ5iABUGLgRetyyMvpg/uwypMYEcm
         Cxr+G1jHbE5pokVl4tmyroS3v4dGwZ077nSTVLX9IF44KhBalnUdyVExuEiprLlXV256
         Gf57RQNdHWcHEOtS89aQBB+Nb9H7xNV6BEZC9vWHJ0Va82L9EQxh8BQ13L8ew30Zzedx
         mZLw==
X-Gm-Message-State: AOAM533/d3Jpt1XC7MwNqZ9EhDYcofIODrEI3qz3oSC6ZQSBre9ba/Hu
        mxYmrRaR9qre3sqDD1HBwh+YWObUvLk=
X-Google-Smtp-Source: ABdhPJwqv0t3oZTRs3+cdSSE8EWdp1OQtwUiz2mjHsKHlKifhJe/9nx6G+zYwyAqFPhmV6T5/iknMg==
X-Received: by 2002:a17:907:98c1:: with SMTP id kd1mr5173748ejc.51.1628173575313;
        Thu, 05 Aug 2021 07:26:15 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-149-099.77.8.pool.telefonica.de. [77.8.149.99])
        by smtp.gmail.com with ESMTPSA id f15sm1768887ejt.75.2021.08.05.07.26.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 07:26:15 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH SYSTEMD 1/7] selinux: add function name to audit data
Date:   Thu,  5 Aug 2021 16:24:39 +0200
Message-Id: <20210805142445.61725-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805142445.61725-1-cgzones@googlemail.com>
References: <20210805142445.61725-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Include the systemd C function name in the audit message to improve the
debug ability on denials.
Similar like kernel denial messages include the syscall name.
---
 src/core/selinux-access.c | 18 ++++++++++++------
 src/core/selinux-access.h | 10 +++++++---
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/src/core/selinux-access.c b/src/core/selinux-access.c
index d077d5dea7..e8e73a5951 100644
--- a/src/core/selinux-access.c
+++ b/src/core/selinux-access.c
@@ -31,6 +31,7 @@ struct audit_info {
         sd_bus_creds *creds;
         const char *path;
         const char *cmdline;
+        const char *function;
 };
 
 /*
@@ -58,10 +59,11 @@ static int audit_callback(
                 xsprintf(gid_buf, GID_FMT, gid);
 
         snprintf(msgbuf, msgbufsize,
-                 "auid=%s uid=%s gid=%s%s%s%s%s%s%s",
+                 "auid=%s uid=%s gid=%s%s%s%s%s%s%s%s%s%s",
                  login_uid_buf, uid_buf, gid_buf,
                  audit->path ? " path=\"" : "", strempty(audit->path), audit->path ? "\"" : "",
-                 audit->cmdline ? " cmdline=\"" : "", strempty(audit->cmdline), audit->cmdline ? "\"" : "");
+                 audit->cmdline ? " cmdline=\"" : "", strempty(audit->cmdline), audit->cmdline ? "\"" : "",
+                 audit->function ? " function=\"" : "", strempty(audit->function), audit->function ? "\"" : "");
 
         return 0;
 }
@@ -179,7 +181,8 @@ int mac_selinux_generic_access_check(
                 sd_bus_message *message,
                 const char *path,
                 const char *permission,
-                sd_bus_error *error) {
+                sd_bus_error *error,
+                const char *func) {
 
         _cleanup_(sd_bus_creds_unrefp) sd_bus_creds *creds = NULL;
         const char *tclass, *scon;
@@ -192,6 +195,7 @@ int mac_selinux_generic_access_check(
         assert(message);
         assert(permission);
         assert(error);
+        assert(func);
 
         r = access_init(error);
         if (r <= 0)
@@ -263,6 +267,7 @@ int mac_selinux_generic_access_check(
                 .creds = creds,
                 .path = path,
                 .cmdline = cl,
+                .function = func,
         };
 
         r = selinux_check_access(scon, fcon, tclass, permission, &audit_info);
@@ -274,8 +279,8 @@ int mac_selinux_generic_access_check(
         }
 
         log_full_errno_zerook(LOG_DEBUG, r,
-                              "SELinux access check scon=%s tcon=%s tclass=%s perm=%s state=%s path=%s cmdline=%s: %m",
-                              scon, fcon, tclass, permission, enforce ? "enforcing" : "permissive", path, cl);
+                              "SELinux access check scon=%s tcon=%s tclass=%s perm=%s state=%s func=%s path=%s cmdline=%s: %m",
+                              scon, fcon, tclass, permission, enforce ? "enforcing" : "permissive", func, path, cl);
         return enforce ? r : 0;
 }
 
@@ -285,7 +290,8 @@ int mac_selinux_generic_access_check(
                 sd_bus_message *message,
                 const char *path,
                 const char *permission,
-                sd_bus_error *error) {
+                sd_bus_error *error,
+                const char *func) {
 
         return 0;
 }
diff --git a/src/core/selinux-access.h b/src/core/selinux-access.h
index c6bfb32544..8931e998d0 100644
--- a/src/core/selinux-access.h
+++ b/src/core/selinux-access.h
@@ -5,10 +5,14 @@
 
 #include "manager.h"
 
-int mac_selinux_generic_access_check(sd_bus_message *message, const char *path, const char *permission, sd_bus_error *error);
+int mac_selinux_generic_access_check(sd_bus_message *message,
+                                     const char *path,
+                                     const char *permission,
+                                     sd_bus_error *error,
+                                     const char *func);
 
 #define mac_selinux_access_check(message, permission, error) \
-        mac_selinux_generic_access_check((message), NULL, (permission), (error))
+        mac_selinux_generic_access_check((message), NULL, (permission), (error), __func__)
 
 #define mac_selinux_unit_access_check(unit, message, permission, error) \
-        mac_selinux_generic_access_check((message), unit_label_path(unit), (permission), (error))
+        mac_selinux_generic_access_check((message), unit_label_path(unit), (permission), (error), __func__)
-- 
2.32.0

