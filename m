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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33A2C433EF
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 13:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC88B61263
	for <selinux@archiver.kernel.org>; Wed, 15 Sep 2021 13:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhIONVT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Sep 2021 09:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhIONVT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Sep 2021 09:21:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBF0C061768
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 06:20:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i6so4347979edu.1
        for <selinux@vger.kernel.org>; Wed, 15 Sep 2021 06:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tPTA0jiUuV1I+kYvgXc0X+kLx7Bg2CCrrJlWbG4TWj4=;
        b=FdZL9zHAZ2wA5dVMA/WCcTI4wDRwCzmHiwiaMQB64PyA3nUiLdi3MYm51JVddYN0FQ
         K/GvwlD7z4igO2xbEFaZkusTMjN12eCDY2gfwkmDOkU9SYSNJIYfMKyv3YCUqzJLghOK
         mFwJExnwl4NjM/ei8jC5X4i+3pEEW6Y+Ygdr8l/oewoncVDbXvDd0JrNobeO4QMHno1z
         598xNbphMT2iI5upSVk79zsnpIBw97f5mHkOKycWTc29JPFZRkQrmfHw86Qrox681U8/
         8xNusqcrGD9rw7sX5wORUkip5n9iJD+cVNvnJas2HMo9RUmTNfiUYjUFhYDNDMuineGj
         GfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPTA0jiUuV1I+kYvgXc0X+kLx7Bg2CCrrJlWbG4TWj4=;
        b=Buq1kcOQf0XJInmmqxVJeYa/9SITNciJ1mAeDf+tMxpeeAGO/ijnDN5cRybJsZenkY
         uYiRuuuzp7ZJ2DoiJBrIDgAASWqx7W0fnV6e1ESdpEJPfQ5H3J4vLr2VvHSIjucp6Hfn
         z3383R67BPoqAAfW8fwXkT0Ygt3QzPa3hwB1I9tcA2lx7mcxt5k5p0LKfAsRuw+4Tpeg
         LA0v99q1gqkF/NNvZPgBKMwzqkBx+XA8MOkYiIqRgwOogoH9HHymTk+vjl1+ZQK6MzJk
         pRzRQYhua9t6Ps694F52yDFCe/QiJH/ymOOoDbXDZLjQLCHiVVH8uN5PSE47pwqgcKjN
         i1Cw==
X-Gm-Message-State: AOAM5325I6oOR7sCSUfeupSBkNTNzUWicsVFoGVDOZ/CsekE5/uApxMR
        F4Y0N8zkKacuQFJ4nIkM9DBPw0pYVPE=
X-Google-Smtp-Source: ABdhPJxlAbohALepUUY7xw5SQ1K9ztCiolvf7x8FShG3958Gl5W1BqkZGgnJ75OY+mfmdaXTBqjCOA==
X-Received: by 2002:a50:bae6:: with SMTP id x93mr11584744ede.232.1631711998587;
        Wed, 15 Sep 2021 06:19:58 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-239-251.95.112.pool.telefonica.de. [95.112.239.251])
        by smtp.gmail.com with ESMTPSA id o22sm7258379edi.89.2021.09.15.06.19.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 06:19:58 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v3 02/13] libsepol: free memory after policy validation
Date:   Wed, 15 Sep 2021 15:19:52 +0200
Message-Id: <20210915131952.26767-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915131109.25114-1-cgzones@googlemail.com>
References: <20210915131109.25114-1-cgzones@googlemail.com>
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
v3:
  - fix indentation
v2:
  - name function validate_array_destroy(), similar to the allocating
    validate_array_init()


 libsepol/src/policydb_validate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 246aa6e3..5804d247 100644
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
 
+	validate_array_destroy(flavors);
+
 	return 0;
 
 bad:
 	ERR(handle, "Invalid policydb");
+	validate_array_destroy(flavors);
 	return -1;
 }
-- 
2.33.0

