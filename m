Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1747C43214
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32FB60F25
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbhHEO0d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Aug 2021 10:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241656AbhHEO0c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Aug 2021 10:26:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB85C061765
        for <selinux@vger.kernel.org>; Thu,  5 Aug 2021 07:26:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hs10so10006037ejc.0
        for <selinux@vger.kernel.org>; Thu, 05 Aug 2021 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HezgqQJs9piSFDdwHakcJEJ8nXgCd17RF/ghRfp549c=;
        b=YtJydpCOqFpd2lqfx3dEG5eKy6fCQyUoWkj5v1SxnvqVjSRqdR17RNy8BmXo7bcOCk
         8fpTKcCml0RasU3/w/CM/eJBewrPSyRv27HJ6xplCMoHkyoEQTiE3wgrZw43tUaaJuM2
         H29QPeJE5e6f3YQoIQEJ4M0/pa+UEhPc0kYzANdpmZ/pJcBoxuPsRPsueLLo5MYCDoHW
         phzw96TJseStWjZVIh+Za9R1YZZBszK1esqjQ0fUOqmjRDa/tqZh4TfgSlBa2hl0mzGi
         KqYWYOfd9NENQIzln8UyuVBlJE9gWsZy9PlcSdQlpvMdmJNLjFH8vaToCplWDC+2YyP5
         /xEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HezgqQJs9piSFDdwHakcJEJ8nXgCd17RF/ghRfp549c=;
        b=qpKPwF32wN7lf1eV+iAu2KnZvkRZSXGsIFWvkSlzv1xW3SKIaA1ecwrtUaryRYr+V3
         2F9NPDynKIdweVoE65IcyDTCHpRBphRkth2/vvaPoBRdmVLBlVHUPGx6XlTXCm2XgX7T
         WDwdWOrmAjq5gvaXEppzFeNmT3ofYIrhQZZuuPZTPDotCJN/OA1zjP+oRZCRWjv/Vxlx
         DAHnluIIfbXpgEBehdae/u7vpjxDNHhpjgXRfndKg6hU8J1tluMbpT9dsnamYtM0CiRN
         MG8CIeUge7rDs+jOn3GAP/MSc5i9pvrCAyQLhDa7QqJN3dfI1h/9/OTXnSDMQ7r8gLVS
         yExw==
X-Gm-Message-State: AOAM533gzgbf/CNyDRXLsHxvbbV0ATY+jbOOhoprD9vdPnVW/gAQBOJK
        B8lAWQJB0RX9SBSESFJqPVguIGWPuWg=
X-Google-Smtp-Source: ABdhPJwHhABHnyAtVbhSCeLQ08kxdky88SzxVldu5+oEvRCCHuUnkwrv88fOlUOdmIdWA9tsqRt8NA==
X-Received: by 2002:a17:906:af02:: with SMTP id lx2mr5032338ejb.133.1628173576674;
        Thu, 05 Aug 2021 07:26:16 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-149-099.77.8.pool.telefonica.de. [77.8.149.99])
        by smtp.gmail.com with ESMTPSA id f15sm1768887ejt.75.2021.08.05.07.26.15
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 07:26:16 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH SYSTEMD 3/7] selinux: mark _mac_selinux_generic_access_check with leading underscore
Date:   Thu,  5 Aug 2021 16:24:41 +0200
Message-Id: <20210805142445.61725-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805142445.61725-1-cgzones@googlemail.com>
References: <20210805142445.61725-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

`mac_selinux_generic_access_check()` should not be called directly, only
via the wrapper macros `mac_selinux_access_check` and
`mac_selinux_unit_access_check`.
---
 src/core/selinux-access.c |  4 ++--
 src/core/selinux-access.h | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/core/selinux-access.c b/src/core/selinux-access.c
index e40fd937a6..180fe22773 100644
--- a/src/core/selinux-access.c
+++ b/src/core/selinux-access.c
@@ -177,7 +177,7 @@ static int access_init(sd_bus_error *error) {
    If the machine is in permissive mode it will return ok.  Audit messages will
    still be generated if the access would be denied in enforcing mode.
 */
-int mac_selinux_generic_access_check(
+int _mac_selinux_generic_access_check(
                 sd_bus_message *message,
                 const char *path,
                 const char *permission,
@@ -286,7 +286,7 @@ int mac_selinux_generic_access_check(
 
 #else /* HAVE_SELINUX */
 
-int mac_selinux_generic_access_check(
+int _mac_selinux_generic_access_check(
                 sd_bus_message *message,
                 const char *path,
                 const char *permission,
diff --git a/src/core/selinux-access.h b/src/core/selinux-access.h
index 8931e998d0..8a5582997a 100644
--- a/src/core/selinux-access.h
+++ b/src/core/selinux-access.h
@@ -5,14 +5,14 @@
 
 #include "manager.h"
 
-int mac_selinux_generic_access_check(sd_bus_message *message,
-                                     const char *path,
-                                     const char *permission,
-                                     sd_bus_error *error,
-                                     const char *func);
+int _mac_selinux_generic_access_check(sd_bus_message *message,
+                                      const char *path,
+                                      const char *permission,
+                                      sd_bus_error *error,
+                                      const char *func);
 
 #define mac_selinux_access_check(message, permission, error) \
-        mac_selinux_generic_access_check((message), NULL, (permission), (error), __func__)
+        _mac_selinux_generic_access_check((message), NULL, (permission), (error), __func__)
 
 #define mac_selinux_unit_access_check(unit, message, permission, error) \
-        mac_selinux_generic_access_check((message), unit_label_path(unit), (permission), (error), __func__)
+        _mac_selinux_generic_access_check((message), unit_label_path(unit), (permission), (error), __func__)
-- 
2.32.0

