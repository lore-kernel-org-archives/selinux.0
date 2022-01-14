Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38D2C4332F
	for <selinux@archiver.kernel.org>; Fri, 14 Jan 2022 19:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiANTUP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jan 2022 14:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiANTUO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jan 2022 14:20:14 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E126C06161C
        for <selinux@vger.kernel.org>; Fri, 14 Jan 2022 11:20:14 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id o135so948795qke.8
        for <selinux@vger.kernel.org>; Fri, 14 Jan 2022 11:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNVr1vz1Mf0/ObYD0mxo9CPAEiCOJTtZOfIyyz2KQp0=;
        b=OnCHfT6tmk4zLOp2GaQDhFlrXauJq1L6o/GkaIfaqBqv0fXw9aSLps4aBUItHop/ID
         y/0sIr0Jzus/LL27BmXmghhzHpOEkzksm6DvEUDvkT/D29PmFqr1hhz67Tb4VP1wwxSH
         Fga1Xd+b5I4KS3pjt1fcLtjEhswZ6PWUAew0lP551AdSMqCGqozp/o4IS4ysw+l5hZT5
         lxHTQjy/w9Zr+w3f5cT+8NLOIOaGhS+PQv9RS9TkTmBI0d7gpGDd6SMsRCix8khJjoBm
         yjJOKV1f8q2IpM5nj0gL84P7QIHECV5j1zKt6LLFPrPdH7mbDrblkO4h0JjHuLVwijlR
         gkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNVr1vz1Mf0/ObYD0mxo9CPAEiCOJTtZOfIyyz2KQp0=;
        b=RyjIHOu7ZyYfINZnQ+nDlOfUSmKTeuwVLWwYh08BRRDSaocdMCgM+rUTHqZxXzLGuv
         OWWZ2Dgh3/fp8eFYo15eKVGlWIiUk2v7VONZe1xPgIMwPEA56h2o4xd7FN2+Z9Lb2DGs
         A8EiEhjvKf4uQqOINu9dAobkgXLdhCuwUC9ZyF6fJjdqGx+Rs3S6iZTAr3oL0Pvyoj7L
         I7REpKbcsQ92/J9zFBr3e+RBT8IVvSJ6LdtnL15bWg0ixTjMy7aotqijOluGCNAJ3ans
         uoVX81vT+ipxhRNSEkZi0xW/vHd11qS2bet+QBmpeQLg9Xq8lJK43ahYGi26uPn2pH9f
         LOUA==
X-Gm-Message-State: AOAM532431bt3JSLPKCgTrctUZWnItQ3Vyo514UYE3hl6Kuw7ks6gbhb
        UD3nlhAev3kFQSqaxlOXoM27tDcvgUA=
X-Google-Smtp-Source: ABdhPJwiFFDHb3HZ/aKPk516gAzmejmyYAe7F8j7YuVg9SWwqBuXkCdGVAskfuv71LKomdyF9bhkaA==
X-Received: by 2002:a05:620a:21dd:: with SMTP id h29mr7546251qka.80.1642188012686;
        Fri, 14 Jan 2022 11:20:12 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id t21sm3447676qtc.46.2022.01.14.11.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 11:20:12 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol/cil: Limit the amount of reporting for neverallow violations
Date:   Fri, 14 Jan 2022 14:20:01 -0500
Message-Id: <20220114192002.730773-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When there is a neverallow violation, a search is made for all of
the rules that violate the neverallow. The violating rules as well
as their parents are written out to make it easier to find these
rules.

If there is a lot of rules that violate a neverallow, then this
amount of reporting is too much. Instead, only print out the first
two rules (with their parents) that match the violated neverallow
rule along with the total number of rules that violate the
neverallow.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_binary.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 4ac8ce8d..04a5d053 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4640,6 +4640,8 @@ static int __cil_print_neverallow_failure(const struct cil_db *db, struct cil_tr
 	char *neverallow_str;
 	char *allow_str;
 	enum cil_flavor avrule_flavor;
+	int num_matching = 0;
+	int count_matching = 0;
 
 	target.rule_kind = CIL_AVRULE_ALLOWED;
 	target.is_extended = cil_rule->is_extended;
@@ -4666,11 +4668,19 @@ static int __cil_print_neverallow_failure(const struct cil_db *db, struct cil_tr
 		goto exit;
 	}
 
+	cil_list_for_each(i2, matching) {
+		num_matching++;
+	}
 	cil_list_for_each(i2, matching) {
 		n2 = i2->data;
 		r2 = n2->data;
 		__cil_print_parents("    ", n2);
 		__cil_print_rule("      ", allow_str, r2);
+		count_matching++;
+		if (count_matching >= 2) {
+			cil_log(CIL_ERR, "    Only first 2 of %d matching rules shown\n", num_matching);
+			break;
+		}
 	}
 	cil_log(CIL_ERR,"\n");
 	cil_list_destroy(&matching, CIL_FALSE);
-- 
2.31.1

