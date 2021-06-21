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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A207BC49EA4
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 19:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880A761040
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 19:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhFUTVA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhFUTU7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 15:20:59 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD65C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 12:18:44 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q64so26985866qke.7
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 12:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J+9V/oOcCyNF4Rtzxy+MS9gurKu16Ed+6uLPweXPw/I=;
        b=tp4/ygQmAtnqyjM2fwhZjZzwrK1LiSY+bRANWR8vjDFltrOrtzRbobE7NXjwh37vdX
         CQ/2S64duKcnVyTxTSQ2NQB16Nbpuf5FFGp5xRd1PR4kwM7mKJSHtYBuEsH0EMMSUDZF
         rcKn66hmIZXN4zShHAbjEDdHuaCDMp8KRrT0XKPLCuHqPDRssxuagvQsc9yp74uwg59Q
         fejcEt+u6nHqOqYlx629FwBHocks5S7j9Na3DjLhfNVX3awgdDZaFAM5SAy+ykYArrXP
         KRhkJE1ILWPXLl0QytU8BOf8zNOYfFXAUZtxcV2zFbJ510jHmPaOBbzD1gqFY4WcO247
         wKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J+9V/oOcCyNF4Rtzxy+MS9gurKu16Ed+6uLPweXPw/I=;
        b=tEWIM83aGWpDptgu7S0tYLvB7geHammkv0hvqwMv+I4bnw03BL9RgrIxp6R3G8hcDA
         Tn4IviVMjcvoEpjbsoQ2j0WuqHlUzKr+qkbjrn31xlif64Jgs4retxs9pOiVhfuKtHxO
         hcN6tjvIMdMQGyKtme3xL7+Bgr/7UyAl11aXhMZ3sOLAwDjenw10944mKdmcr1GIMDwy
         YV9BbOlHlARwAy+E41shTUFqnSb/TDqrb0AKphjG0OMuVImKueNMlgHe4m8uM7N5hdQu
         4/tp2fLGDB3ddW3S8jJsmeAmnfdhYqGQDZMev4s8luyTxsgzw6fUlT9KBVloSXE7TTCi
         s5/w==
X-Gm-Message-State: AOAM531elumD+I8WkAtFU0hZUmO+uW/EHBk7lfuNF12uMmH2hjV2LQ1T
        MLzZ6yECw23NVPUbS6KOTU/gHkDnx2bnIQ==
X-Google-Smtp-Source: ABdhPJyAPXg3rEVQCv6WfTKL21D/RoH+v8i07L3c6OOcqkwJfljqzKURfq0hB9dgjrK2iiZFVfqyyg==
X-Received: by 2002:a05:620a:91c:: with SMTP id v28mr173513qkv.249.1624303123470;
        Mon, 21 Jun 2021 12:18:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o5sm10449124qkl.25.2021.06.21.12.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 12:18:43 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/5 v2] libsepol/cil: Fix syntax checking of defaultrange rule
Date:   Mon, 21 Jun 2021 15:18:30 -0400
Message-Id: <20210621191833.282874-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210621191833.282874-1-jwcart2@gmail.com>
References: <20210621191833.282874-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When "glblub" was added as a default for the defaultrange rule, the
syntax array was updated because the "glblub" default does not need
to specify a range of "low", "high", or "low-high". Unfortunately,
additional checking was not added for the "source" and "target"
defaults to make sure they specified a range. This means that using
the "source" or "target" defaults without specifying the range will
result in a segfault.

When the "source" or "target" defaults are used, check that the rule
specifies a range as well.

This bug was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Take the glblub option into account and fix the syntax checking a different way

 libsepol/cil/src/cil_build_ast.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 71f14e20..178ec2e5 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -5886,6 +5886,11 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
 
 	object = parse_current->next->next->data;
 	if (object == CIL_KEY_SOURCE) {
+		if (!parse_current->next->next->next) {
+			cil_log(CIL_ERR, "Missing 'low', 'high', or 'low-high'\n");
+			rc = SEPOL_ERR;
+			goto exit;
+		}
 		range = parse_current->next->next->next->data;
 		if (range == CIL_KEY_LOW) {
 			def->object_range = CIL_DEFAULT_SOURCE_LOW;
@@ -5899,6 +5904,11 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
 			goto exit;
 		}
 	} else if (object == CIL_KEY_TARGET) {
+		if (!parse_current->next->next->next) {
+			cil_log(CIL_ERR, "Missing 'low', 'high', or 'low-high'\n");
+			rc = SEPOL_ERR;
+			goto exit;
+		}
 		range = parse_current->next->next->next->data;
 		if (range == CIL_KEY_LOW) {
 			def->object_range = CIL_DEFAULT_TARGET_LOW;
-- 
2.26.3

