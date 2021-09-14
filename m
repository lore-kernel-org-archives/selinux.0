Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADF0C4332F
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44AC060F58
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhINMwC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhINMwC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 08:52:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1768DC061760
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v5so19712982edc.2
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0WjwCzQgBKZD7tXonFIJXydSihUgcjVDMEH63M2fMKE=;
        b=VJyH035mCxPTPFV7sR7Y0umFZPnTzJxwp9QS/HsXicyKYKfmH2swvYDiH6jD7gkZu3
         pkg5IJe0ICZvzwji7AA45kGc4Yql7Cdxd8HBKmezV1+NGn3YqQ2COFW/nNHD2L8BZWyn
         NBtybFaqgC6c4SUZ39ofYezEXpdZjzsSFpC6I+5E6dclY8zMi1hxZild8j91ur3BPWyN
         KRMvpyzbFSc/++76YCnsdw9cK1Sh+Byct+91GG6EmSttUfTl4EtWJ4Vte0rwBcdQ31ct
         PMeQxF5qt22zeOIeSzRAMhoa8utEtu3v8Jhwf9Z8qg+rpoGR/MmFCc/QeVcRiDN4FyZV
         LWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0WjwCzQgBKZD7tXonFIJXydSihUgcjVDMEH63M2fMKE=;
        b=vTOfi5u1hBe5FhQCBS8insWDUUQzbHrC5LTnlLBmoMWD8bXX+YU7qO9q3OHcACccA/
         MfKEHjTUnL117ZeC36+yWCqueGAUVwbvflU0z2B+rT0gX7/9b+NBTLZue0kYe3OlMdNY
         5LbQr4cVEitvLeH+eBBrGfUFQYp3KSrPVUEBAB0kKVO6s/L1sTMXINxIR8BPnJ6rJ2Pd
         olTkeJ6/CuAJiIMCjF+wt6zUulKx8EAp5hm8VAqMvqrTTTPGfEay/7jcbG8WzCMpRTVI
         W2IsNmjljGjPc3uS8zc6WZIOLiuWejEnFUuJiUhUKa+CKI1blPIznqStpfWZ7qNvbk+M
         Dp5A==
X-Gm-Message-State: AOAM530/1x8Q4vbA6PpVtutx/f0WmoIO+yNhgV30f5kj7x70kVZVu9v0
        +172gVkyJpb5AS2Kq6zjUC4bE21IGQc=
X-Google-Smtp-Source: ABdhPJzZSQGVMbCZ8C659Bd39kFiDx9ayU2qpRSpflTPfpmtyIaFyrUC0uAfmNGlxUTHKbc3vu1jAA==
X-Received: by 2002:a50:bb09:: with SMTP id y9mr15016018ede.89.1631623843693;
        Tue, 14 Sep 2021 05:50:43 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-237-250.77.3.pool.telefonica.de. [77.3.237.250])
        by smtp.gmail.com with ESMTPSA id r8sm5567865eds.39.2021.09.14.05.50.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:50:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 02/13] libsepol: free memory after policy validation
Date:   Tue, 14 Sep 2021 14:48:17 +0200
Message-Id: <20210914124828.19488-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914124828.19488-1-cgzones@googlemail.com>
References: <20210914124828.19488-1-cgzones@googlemail.com>
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
 libsepol/src/policydb_validate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 246aa6e3..f9a4b942 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -722,12 +722,21 @@ bad:
 	return -1;
 }
 
+static void validate_destroy(validate_t flavors[])
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
 
+	validate_destroy(flavors);
+
 	return 0;
 
 bad:
 	ERR(handle, "Invalid policydb");
+	validate_destroy(flavors);
 	return -1;
 }
-- 
2.33.0

