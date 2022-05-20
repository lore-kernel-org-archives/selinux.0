Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA974C433F5
	for <selinux@archiver.kernel.org>; Fri, 20 May 2022 13:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349704AbiETNJC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 May 2022 09:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349694AbiETNI7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 May 2022 09:08:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365631632AC
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 06:08:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y13so14793597eje.2
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LF3QUQYE9OdQCax0pir/nh180w2c/4Uy4faBw5baxDg=;
        b=JiPkj0d4Cl5xHmXkypFja/xl50SsTZyAztT0cIFC9+tPZWb9pl9BLxMwuXggNSKNVt
         gitU3R8JLZs4Zv3CqXkreIAO7OC2HY4xKUUkCRUdSM59uY8FVRmOagmaeZs4TQwmNkdF
         jyOl22FZX1hveczJgr2H5LcNx7Uj/4p/5Q3jznliEc+WfTEKV13RIWbz921MLZWxIKFG
         hDWuh/sg2+JjBV2WZyrQ3yW9+S7ayphvb1GRHe5AhrBwF/udprmBEE+excde5L70KmlZ
         LQrkoS1C2bHPfNQRGYzBDfXcab2mgW7xiW3vbNvRU40xkyA5JtzYtSChEpq8tBOG75Wp
         EZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LF3QUQYE9OdQCax0pir/nh180w2c/4Uy4faBw5baxDg=;
        b=CdXhucKgS0j32JNvYpIcWeDDpd4gYheR62ujtLbqYyzj3oKyYDfoYY5WU/bF9AauPV
         CTKggtqhHSwkd1N8Y94KyQ8qLX1TMpNj1WEW+8WvBo2hHV6c8T7ZYvyKwRp/zB1hCVak
         CMn6ZcJ8hpauhZFwJkk4GCavLtBXRntKC0A4Ikc4kbKi97aKdNCt7a577dssJFKt4eQN
         0vvJf7r2hKFGUm44EpZT7EemBStV78IojowJAzsfJNsG17Z/1iHScR+m3ciizNsUdQE1
         VzEWSPc/PH7bxqGmXUObh0wHN0KoFClBs18ZTMZc3jd/wdLQEgigqORaiNKJWb3afDWd
         jWRg==
X-Gm-Message-State: AOAM531enD/2L0xD/m3LLZvqxiv9imbWQurk1OGw5XWHjW3PpYfwBmRw
        Hbk5ZWqCaQO0SWeBDRj54UWvgWCoZlE=
X-Google-Smtp-Source: ABdhPJxrwbZCDSEaOzYEXBLvzE3rtezwvcvngMwEnfzHNqesUOC0d7HNK9/mPqQFhNVrgdAOiSwiqQ==
X-Received: by 2002:a17:907:1c08:b0:6fe:8983:e192 with SMTP id nc8-20020a1709071c0800b006fe8983e192mr8650605ejc.444.1653052134733;
        Fri, 20 May 2022 06:08:54 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-251-125.77.8.pool.telefonica.de. [77.8.251.125])
        by smtp.gmail.com with ESMTPSA id hs33-20020a1709073ea100b006feb71acbb3sm160154ejc.105.2022.05.20.06.08.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 06:08:54 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 4/4] libselinux: declare parameter of security_load_policy(3) const
Date:   Fri, 20 May 2022 15:08:47 +0200
Message-Id: <20220520130847.10958-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520130847.10958-1-cgzones@googlemail.com>
References: <20220520130847.10958-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

security_load_policy(3) takes a read-only memory address for a binary
policy to be loaded.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/selinux.h       | 2 +-
 libselinux/man/man3/security_load_policy.3 | 2 +-
 libselinux/src/load_policy.c               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index ae98a92e..47af9953 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -279,7 +279,7 @@ extern int security_validatetrans_raw(const char *scon,
 				      const char *newcon);
 
 /* Load a policy configuration. */
-extern int security_load_policy(void *data, size_t len);
+extern int security_load_policy(const void *data, size_t len);
 
 /* Get the context of an initial kernel security identifier by name.  
    Caller must free via freecon */
diff --git a/libselinux/man/man3/security_load_policy.3 b/libselinux/man/man3/security_load_policy.3
index af561636..b2da0256 100644
--- a/libselinux/man/man3/security_load_policy.3
+++ b/libselinux/man/man3/security_load_policy.3
@@ -5,7 +5,7 @@ security_load_policy \- load a new SELinux policy
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int security_load_policy(void *" data ", size_t "len );
+.BI "int security_load_policy(const void *" data ", size_t "len );
 .sp
 .BI "int selinux_mkload_policy(int " preservebools ");"
 .sp
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index d8c715ed..17918e8b 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -23,7 +23,7 @@
 #define MNT_DETACH 2
 #endif
 
-int security_load_policy(void *data, size_t len)
+int security_load_policy(const void *data, size_t len)
 {
 	char path[PATH_MAX];
 	int fd, ret;
-- 
2.36.1

