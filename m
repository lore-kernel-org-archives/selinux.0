Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DA3C433FE
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343585AbiAKVzI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245624AbiAKVzC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:55:02 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA64C061756
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:54:59 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id q14so818557qtx.10
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jPkVQCcebJo7Yq9WhSxtz3V4v3wlvtz3YCm1gFtNgv4=;
        b=bbtRkp1MX7gCaAgMwiJLoXgozORa0isW1OtOQU8JCsyaHNN9c8djOag+v/v2kxgYqE
         UNXAHeCX/YRgwH0Zyr4VcLEia6BkfP6eMAW8UbUr3FGTlTVH29MLD9UIqA+D/EC1qIaT
         OwRQOdipY8fqNqouGlSzc06EkJKV2zp8+4GaxsU8a2o2Zwfme57c+oGlvyHY7f4CEBrZ
         lm23WxfyJ9xYLVu4ccE1WyVGpCSsz4aZfPTkQbCJ0hW1XLGCiZGA2rD3D+TmbHTZgBAz
         IN1fmgnWV/2eDWinn0ObvVyfond2QEftFP1SzLFX1N3XCxWWtBdPYZZBW8i7ro7p1D5P
         WXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPkVQCcebJo7Yq9WhSxtz3V4v3wlvtz3YCm1gFtNgv4=;
        b=KuYh0Xu1Vx62ExRq1a6DDXbrN679mSlyvFft0XYOfQdfzQRcHlKLyGp3q3xNSkeVY7
         lumjQStNJvDFtbkP+sKhWhLPFDGdtnmPNT3knSpVl7Sqxp679l+pwnSoRgdX19jiH27s
         G/bOd8nGPASII7aRZ3PO3iSD9SHvt6JnAMcaD5wZ3qs6aXn+s9R4DvmwuJdbtgfASrcX
         94kS9NykLFs94TCY3Y6yup27KKHyd72Acahy4/blgjIWi4F40KMsUBYZD2ywwKEvKbEA
         kn3M7foYtFjegu/54korS4tjxlMhjrg/RGVytX5Vst1HBJP949aYG6Zwz7tJW5PRzkpR
         DYqA==
X-Gm-Message-State: AOAM531jDeRHH78iIwNeyTEOPsgX1Zhpp8/VD1wbudPwIMh2lllNplwv
        TKyWgCPL9MWGH0n3HA+dBCEhA2bEcLg=
X-Google-Smtp-Source: ABdhPJyz4IONZtyydPHJMHCIp/sCEiub5kYV32LMrUk0S1NhzgOTFMDOubHn5f1YCJN566RnaXhxow==
X-Received: by 2002:a05:622a:164b:: with SMTP id y11mr5395237qtj.621.1641938099039;
        Tue, 11 Jan 2022 13:54:59 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:54:58 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 04/16 v2] libsepol: Check for error from check_assertion_extended_permissions()
Date:   Tue, 11 Jan 2022 16:54:34 -0500
Message-Id: <20220111215446.595516-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Return an error if check_assertion_extended_permissions() returns
an error instead of treating it as an assertion violation.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 832d3749..a2cbb74d 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -481,6 +481,8 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 
 	if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
 		rc = check_assertion_extended_permissions(avrule, avtab, k, p);
+		if (rc < 0)
+			goto oom;
 		if (rc == 0)
 			goto nomatch;
 	}
-- 
2.31.1

