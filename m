Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E995C001DD
	for <selinux@archiver.kernel.org>; Thu, 13 Jul 2023 18:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjGMSI3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jul 2023 14:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGMSI2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jul 2023 14:08:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EFF26AF
        for <selinux@vger.kernel.org>; Thu, 13 Jul 2023 11:08:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98e39784a85so486173366b.1
        for <selinux@vger.kernel.org>; Thu, 13 Jul 2023 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689271706; x=1691863706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lchxOczmm5cZB2cVIOEYHs4c/47r6m/AH5EZQgn+3ps=;
        b=PKILVafPl39bDJMrafsdka23s5QWHPPCenGrqDy3KM4Rchmi8dzxYpQmtUbqkTb0/Z
         1hHTVRSrtarRY0NclkxQnuaNJmid+ODL+KrK7/MZ03HQKgrMKhayjq82ZI9tFTX2jt0Y
         cvtV9x+7vc7JXRkdJQw92iRaHXfs9+IldmNBCbJtcWaCVlZwO/YNGtDCOZXKnLtZxcvR
         l/Xda6BS8w1R9MuLpuJUD4ky6U5/e9JrjkwPAfUWBDzvb7e3+NELNI4vqR41dK1VqkGz
         5xQMtlfPqel7fyUsnMnZlntIS2go8HmW/sw79HpiTRbqLIg59/9ybvmEp5BqdpYkUZqP
         XgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271706; x=1691863706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lchxOczmm5cZB2cVIOEYHs4c/47r6m/AH5EZQgn+3ps=;
        b=ah2bmmk9dBRaqESOP4YZlSDESelIhugn9oYuezSg+FdJeKxXccNWPL1+9Zl+vTR1K4
         AK7KX7osgpwoaWZf5XpNTZMHoXO/p/jVBB6HDyXv7N/JzWjr/iyWcQbgS9sdG5VGlrQC
         F3VP/wneTkG1OV6U1aAcl+0a1LPJfbq0YBWJUArSd8PwMm/IzO+dS0RJOl7w/RV7oJQ0
         l1/IQPqlEB4k+A4mPFutf6FEOGkf+vdAAIUEJCDt2y3+4pvEFLjJVKU8C65RYYLRB1eM
         zfHOeIaDKwPigKeSmTXweKBC5am+4iEK/O2CE19lQVx13+eFLGLHkpuMgY2hluiIAG6h
         AFng==
X-Gm-Message-State: ABy/qLZqXVbPU58Ow9oOHMyQw0ZyEuuD2T8i5VgJ+ebifMsPceTs3L1e
        llvlmyW9u6puoya1uNVz/gabI3TS/eA14rQX
X-Google-Smtp-Source: APBJJlFjF0X0mk9D5Xnmy+6+eYPHlAYX18yrfyuUvmkYPkMqjefxf+KtYF4JVGOA0ItWwpzYXzXQRA==
X-Received: by 2002:a17:907:ea6:b0:96a:2dd7:2ee0 with SMTP id ho38-20020a1709070ea600b0096a2dd72ee0mr685004ejc.5.1689271706153;
        Thu, 13 Jul 2023 11:08:26 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-010-190-210.77.10.pool.telefonica.de. [77.10.190.210])
        by smtp.gmail.com with ESMTPSA id q11-20020a170906940b00b00992d70f8078sm4270014ejx.106.2023.07.13.11.08.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:08:25 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/5] libsepol: reject avtab entries with invalid specifier
Date:   Thu, 13 Jul 2023 20:08:13 +0200
Message-Id: <20230713180816.101924-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713180816.101924-1-cgzones@googlemail.com>
References: <20230713180816.101924-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Neverallow avtab entries are not supported (normal and extended). Reject
them to avoid lookup confusions via avtab_search(), e.g. when searching
for a invalid key of AVTAB_TRANSITION|AVTAB_NEVERALLOW and the result of
only AVTAB_NEVERALLOW has no transition value.

Simplify the check for the number of specifiers by using the compiler
popcount builtin (already used in libsepol).

Reported-by: oss-fuzz (issue 60568)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/avtab.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index 5c76fe12..7b85519b 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -564,7 +564,6 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 	avtab_datum_t datum;
 	avtab_trans_t trans;
 	avtab_extended_perms_t xperms;
-	unsigned set;
 	unsigned int i;
 	int rc;
 
@@ -666,13 +665,13 @@ int avtab_read_item(struct policy_file *fp, uint32_t vers, avtab_t * a,
 	key.target_class = le16_to_cpu(buf16[items++]);
 	key.specified = le16_to_cpu(buf16[items++]);
 
-	set = 0;
-	for (i = 0; i < ARRAY_SIZE(spec_order); i++) {
-		if (key.specified & spec_order[i])
-			set++;
+	if (key.specified & ~(AVTAB_AV | AVTAB_TYPE | AVTAB_XPERMS | AVTAB_ENABLED)) {
+		ERR(fp->handle, "invalid specifier");
+		return -1;
 	}
-	if (!set || set > 1) {
-		ERR(fp->handle, "more than one specifier");
+
+	if (__builtin_popcount(key.specified & ~AVTAB_ENABLED) != 1) {
+		ERR(fp->handle, "not exactly one specifier");
 		return -1;
 	}
 
-- 
2.40.1

