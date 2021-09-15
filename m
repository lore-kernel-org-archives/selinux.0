Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22A9C433EF
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 13:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A38F66121F
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 13:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhIONMh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Sep 2021 09:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhIONMh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Sep 2021 09:12:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CF3C061574
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 06:11:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i21so6100422ejd.2
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 06:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Qjceff96Sn2+3Jyu/y/ZW4CMJAWqJxMoWfyBvGgL/Qg=;
        b=iTdggq5XtKXuHyRyKpMvRKJn4rUgXscIteGMGQSIqO472wL9vk1ENsAXhZjBD152lT
         2sfNmAuNoQbwxDzmWmWrqLQ2ysk05acXCEaU5fYVAmFmrpfCIt5QylJGvzBQDMAUk51R
         kiq9qkH6DFy19NLAIf/MmAAqYB3oIGunHMqbQYvC00oIiN83JyZkW/118tzqYuCgjrTX
         xf8H71d6yKZmInMKgBXqCtQpGK4SCF4duXw/nFttVNeBCZBCi8P6W2+Kd0TDx6mKzjAS
         kcNXJFI8isjb/o3HttLL86jdqzdLYtEWC/0IjIxkzlCcUVBNV6SIdTI58v4mMKjy6AzA
         poMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qjceff96Sn2+3Jyu/y/ZW4CMJAWqJxMoWfyBvGgL/Qg=;
        b=bt5xflLGBOMo52QwVVyD41nCmO7O6np8oxUSma+fGYCryW7BtsqRxpKt0pWFGX7nYY
         XZZB/uGrs8FYwndsxHbYwq8wEa90zgE11tgUMPSJvAI5CGx0TpOeyqENltHW0kqkS31Y
         WrOxScbuw6wR34fK/KGJxFXBq+zuI/lPd0AtbAVGx06Qj5YYdOQ+dvpOt9g0Oqxx/HoP
         A/irhrtQQw3av63D6JncwUc1AxhgxyKxRSwUTW1nuf8CcRP0nHNbTP7UlyOgToDMwgpO
         ndfVo51n7NJO0Y+IaqQcZxHV4yzLVVOjpsNnMNYIQ4h5TjQdxm8DszHXwv+BBTRhhHKO
         5mjw==
X-Gm-Message-State: AOAM530FrpIoKlR7nCC8IJ1MlPs1yrD+ty8yKA3CB6Hdhii7vZT+uVhL
        Qwci7PO9H9m7FKanJn3Ez9c907Ma7OE=
X-Google-Smtp-Source: ABdhPJw0N+HgO0eDRQnk1/zdToiCKiFl/xpEw70W/dTOTwfawCme2jrRx3oEOJ4/WIBr3S0TXSso7A==
X-Received: by 2002:a17:906:6b0c:: with SMTP id q12mr25074549ejr.0.1631711475643;
        Wed, 15 Sep 2021 06:11:15 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-239-251.95.112.pool.telefonica.de. [95.112.239.251])
        by smtp.gmail.com with ESMTPSA id z97sm7013323ede.72.2021.09.15.06.11.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 06:11:15 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 02/13] libsepol: free memory after policy validation
Date:   Wed, 15 Sep 2021 15:11:09 +0200
Message-Id: <20210915131109.25114-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914124828.19488-3-cgzones@googlemail.com>
References: <20210914124828.19488-3-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Found while running the checkpolicy/test/dispol binary.

    Direct leak of 24 byte(s) in 1 object(s) allocated from:
        #0 0x49bacd in __interceptor_malloc (./checkpolicy/test/dispol+0x49bacd)
        #1 0x5551e1 in ebitmap_set_bit ./libsepol/src/ebitmap.c:326:27
        #2 0x517873 in create_gap_ebitmap ./libsepol/src/policydb_validate.c:23:8
        #3 0x517873 in validate_init ./libsepol/src/policydb_validate.c:34:6
        #4 0x50fa47 in validate_array_init ./libsepol/src/policydb_validate.c:44:6
        #5 0x50fa47 in validate_policydb ./libsepol/src/policydb_validate.c:732:6
        #6 0x4f22df in policydb_read ./libsepol/src/policydb.c:4538:6
        #7 0x4cddb3 in main ./checkpolicy/test/dispol.c:437:8
        #8 0x7f5980e47e49 in __libc_start_main csu/../csu/libc-start.c:314:16

    Indirect leak of 48 byte(s) in 2 object(s) allocated from:
        #0 0x49bacd in __interceptor_malloc (./checkpolicy/test/dispol+0x49bacd)
        #1 0x5551e1 in ebitmap_set_bit ./libsepol/src/ebitmap.c:326:27
        #2 0x517873 in create_gap_ebitmap ./libsepol/src/policydb_validate.c:23:8
        #3 0x517873 in validate_init ./libsepol/src/policydb_validate.c:34:6
        #4 0x50fa47 in validate_array_init ./libsepol/src/policydb_validate.c:44:6
        #5 0x50fa47 in validate_policydb ./libsepol/src/policydb_validate.c:732:6
        #6 0x4f22df in policydb_read ./libsepol/src/policydb.c:4538:6
        #7 0x4cddb3 in main ./checkpolicy/test/dispol.c:437:8
        #8 0x7f5980e47e49 in __libc_start_main csu/../csu/libc-start.c:314:16

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - name function validate_array_destroy(), similar to the allocating
    validate_array_init()


 libsepol/src/policydb_validate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 246aa6e3..3ab072a8 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -722,12 +722,21 @@ bad:
 	return -1;
 }
 
+static void validate_array_destroy(validate_t flavors[])
+{
+	unsigned int i;
+
+	for (i = 0; i < SYM_NUM; i++) {
+		ebitmap_destroy(&flavors[i].gaps);
+	}
+}
+
 /*
  * Validate policydb
  */
 int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 {
-	validate_t flavors[SYM_NUM];
+	validate_t flavors[SYM_NUM] = {};
 
 	if (validate_array_init(p, flavors))
 		goto bad;
@@ -756,9 +765,12 @@ int validate_policydb(sepol_handle_t *handle, policydb_t *p)
 	if (validate_datum_arrays(handle, p, flavors))
 		goto bad;
 
+        validate_array_destroy(flavors);
+
 	return 0;
 
 bad:
 	ERR(handle, "Invalid policydb");
+        validate_array_destroy(flavors);
 	return -1;
 }
-- 
2.33.0

