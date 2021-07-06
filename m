Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C3EC07E9E
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2DCB61C3C
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhGFR5X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhGFR5W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 13:57:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F282EC06175F
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 10:54:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ch27so2767742edb.10
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 10:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=P4Aiz6aw5htaYbHyxgXtTHKQ+qZhc6sA3FUyO23yQQ4=;
        b=OJm1wIgDGPyLLdaS5IZQxVPevxSuKNONirNm84BL4WuLFlR0+3m98WloLYoktlxn5c
         cSULeD1Utq2hxsEGE8aTTyA91kHybUKSiYVUJ1c6SUZkO5aBCZCKHOPWcU7pTQwSnoqv
         BNdZZ8HjxSYpYq9fd1mYQuzj+to8/9zDSDy+dbw0EvMLnTR8wdcV5U3HSM/9DQNBwCFy
         ahDeIAHR9YoQ43RluSzFDVlVI4Rsx2p167vsI7Jvyj2RVaVlTDA7pD/dIGmvjiaKAruE
         a5J44DaQCIDf/YzxKwN4JwO2yKlBGVe6DoxvhXH2/+OYhp++9AwUyT+/m3xQHKLpsgSK
         QDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P4Aiz6aw5htaYbHyxgXtTHKQ+qZhc6sA3FUyO23yQQ4=;
        b=nnpEySVl5zVBPy7jPKr8cFRTZVqA22HQhs48J5PIsKXEwZbaS40xe/BtWmmbBxfueh
         +ZVZDby11fUzD5FlbmMbyc3frJsZSzk/r77djp6jKiK2RJ4tKe1q1Rm2bVAlItiyNzlX
         hg9d2mvtJJ3yLnVR6zOhi/aPfjp4tWB4WJZpIi8B/9BdoUWVZiTonUzLhtKMK+jh0WFq
         jNCr4M+eDnAdvtS2BVng2IlSt8tQdpr6BIo1j9uG6NWkph2p6ddo1RjtoxKyDDs/lAak
         kGHCHdwbecARMc/1Pz5sdR0s2WchH9zaCBjD2OpEe4NZlo1MsSfg6ADG5YFRQvIFU5Ul
         93Tg==
X-Gm-Message-State: AOAM5316KF7hh5pm3H7T2cD3kY9bPqc0P5LAvcdT+E0jN1WMc1yhm204
        I4yrDvW/q4+Y8oVWIBlqwZ8wu6aL6+Y=
X-Google-Smtp-Source: ABdhPJw9d1ml7L3UXJ84C5nPyXatIz1/7sXTP2cF9Y+NQ0TXBREZ0tA/4yGhqjGC3emRWkfb4pvTgA==
X-Received: by 2002:aa7:cb84:: with SMTP id r4mr24211085edt.205.1625594082500;
        Tue, 06 Jul 2021 10:54:42 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-100-174.95.116.pool.telefonica.de. [95.116.100.174])
        by smtp.gmail.com with ESMTPSA id lg16sm6050950ejb.69.2021.07.06.10.54.42
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:54:42 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 05/13] checkpolicy: use correct format specifier for unsigned
Date:   Tue,  6 Jul 2021 19:54:25 +0200
Message-Id: <20210706175433.29270-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706175433.29270-1-cgzones@googlemail.com>
References: <20210706175433.29270-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    test/dispol.c:288:4: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
       snprintf(buf, sizeof(buf), "unknown (%d)", i);
       ^
    test/dismod.c:830:4: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
       snprintf(buf, sizeof(buf), "unknown (%d)", i);
       ^

Found by Cppcheck.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/test/dismod.c | 2 +-
 checkpolicy/test/dispol.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 3408e9b6..fadbc8d1 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -827,7 +827,7 @@ static void display_policycaps(policydb_t * p, FILE * fp)
 	ebitmap_for_each_positive_bit(&p->policycaps, node, i) {
 		capname = sepol_polcap_getname(i);
 		if (capname == NULL) {
-			snprintf(buf, sizeof(buf), "unknown (%d)", i);
+			snprintf(buf, sizeof(buf), "unknown (%u)", i);
 			capname = buf;
 		}
 		fprintf(fp, "\t%s\n", capname);
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 8785b725..37f71842 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -285,7 +285,7 @@ static void display_policycaps(policydb_t * p, FILE * fp)
 	ebitmap_for_each_positive_bit(&p->policycaps, node, i) {
 		capname = sepol_polcap_getname(i);
 		if (capname == NULL) {
-			snprintf(buf, sizeof(buf), "unknown (%d)", i);
+			snprintf(buf, sizeof(buf), "unknown (%u)", i);
 			capname = buf;
 		}
 		fprintf(fp, "\t%s\n", capname);
-- 
2.32.0

