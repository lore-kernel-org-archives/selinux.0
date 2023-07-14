Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E28EB64DC
	for <selinux@archiver.kernel.org>; Fri, 14 Jul 2023 18:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbjGNS30 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbjGNS30 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jul 2023 14:29:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDC52733
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:29:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98df3dea907so286859466b.3
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689359362; x=1691951362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9L7z9OwZTA17ZnTK3k2GH/j3j1ZHKYlRhfwIRh65LUE=;
        b=b90SdLanf8/IkOMnGCtgFNsYeVeAXsPUxfrFoZEpL/unxgFjhvQ3L0ch8wal2gisi+
         KV+OQPr0e/RuoCo/dC9RB1KlQneEAvSZcl1o35jhjWa5VqNhI1bxKA8AQm1RXaJ7hbxl
         HHvDNAjdz04dNZxdkOgyab3DqTtMEnvSNb9XzHKIMaSTw1W2RgK2Pc05+sDHS2WXDsM/
         ITi3QqDhKdvA+VIMwCKQC0NZuCbSN5+iSylwfYoWjf5OaMRcSPc8nLVk8WCPalcvRULE
         HJLLWI4cFqPxZc04B6TU4Yy017RDoKE0tVI2hjYfMjy+YmFetuT+b5qn0TbFyb8bZHCz
         zgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689359362; x=1691951362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9L7z9OwZTA17ZnTK3k2GH/j3j1ZHKYlRhfwIRh65LUE=;
        b=Z2xxXLLaMfI/nnEiR2I3tBYCTzXHjWQyq5XkQ6xVcJPXjfF0OQr8hN7F2Vwac+vqny
         FZf9zYPdcwt0Nq7DVwPSQLz8q/oNolgulz9fWyJKIhCUEgjB+d3oV17xlpgfOmJEnXCc
         Hf0b7PlMiWLxBwcRMEBQjRTaxw/LnQ5hvL0svw35aidlXhlKmPfy+kEzHG9IMibkifmz
         czyDZ5pBNmweLpK2cDFUtv1WUoFcSYjhgmJlCKgiJegg+PCV/fmmWrWi9SdV/DExVtZr
         2irzCLGQ8e3gf4KOticWyccs/kLMr6IjLlniBOprFAjZIwY2th1QGJbToD3+UE0FOcen
         fdhw==
X-Gm-Message-State: ABy/qLZjf77MMYcvykI9vkh5Oip0NGuuzy/afqGT4qRhbN2lXR9P142G
        oENWWsE0qu1/4+brmvgmV/h9W+H5j9WxlA==
X-Google-Smtp-Source: APBJJlGuWBNBlbriL1jltjyF/vy/HxemP1H47QtmUbgDNmLaOlwFsEaf12ERlyTTvqf5QNfr+KaWgA==
X-Received: by 2002:a17:906:dfee:b0:991:e7c3:5712 with SMTP id lc14-20020a170906dfee00b00991e7c35712mr4421127ejc.30.1689359361848;
        Fri, 14 Jul 2023 11:29:21 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-078-050-124-229.78.50.pool.telefonica.de. [78.50.124.229])
        by smtp.gmail.com with ESMTPSA id gr10-20020a170906e2ca00b0098d25cbb899sm5688134ejb.41.2023.07.14.11.29.21
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 11:29:21 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: use explicit type for function parameters
Date:   Fri, 14 Jul 2023 20:29:18 +0200
Message-Id: <20230714182918.30917-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use a pointer to the explicit type struct policy_file instead of void
for increased type safety and readability.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/policydb/avtab.h | 2 +-
 libsepol/src/avtab.c                    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/libsepol/include/sepol/policydb/avtab.h b/libsepol/include/sepol/policydb/avtab.h
index 7d892879..2bb583f5 100644
--- a/libsepol/include/sepol/policydb/avtab.h
+++ b/libsepol/include/sepol/policydb/avtab.h
@@ -158,7 +158,7 @@ extern int avtab_insert_filename_trans(avtab_t *a, avtab_key_t *key,
 				       uint32_t otype, const char *name,
 				       uint8_t name_match,
 				       uint32_t *present_otype);
-extern int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a);
+extern int avtab_filename_trans_read(struct policy_file *fp, uint32_t vers, avtab_t *a);
 
 #ifdef __cplusplus
 }
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 99fdaa87..7a35fc17 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -843,7 +843,7 @@ bad:
 	return rc;
 }
 
-static int filename_trans_read_one(avtab_t *a, void *fp)
+static int filename_trans_read_one(avtab_t *a, struct policy_file *fp)
 {
 	int rc;
 	uint32_t buf[4], len, otype;
@@ -882,7 +882,7 @@ err:
 	return SEPOL_ERR;
 }
 
-static int filename_trans_comp_read_one(avtab_t *a, void *fp)
+static int filename_trans_comp_read_one(avtab_t *a, struct policy_file *fp)
 {
 	int rc;
 	uint32_t buf[3], len, ndatum, i, bit, otype;
@@ -941,7 +941,7 @@ err:
 	return rc;
 }
 
-int avtab_filename_trans_read(void *fp, uint32_t vers, avtab_t *a)
+int avtab_filename_trans_read(struct policy_file *fp, uint32_t vers, avtab_t *a)
 {
 	uint32_t buf[1], nel, i;
 	int rc;
-- 
2.40.1

