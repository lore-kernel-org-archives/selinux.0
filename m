Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C9FC433DB
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 20:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD41364F21
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 20:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhCQU6m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhCQU6h (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Mar 2021 16:58:37 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB105C06174A
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 13:58:37 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b130so40415019qkc.10
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 13:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZDQ8A5VWHE1J9M00ZvmaE2qoCB2tDWQ5Ppncm8M3Qpw=;
        b=aKfuZQD2FmxGfFy0wuIxfrDy+petmi/MWXygzN87w5Zsi3R2S6HwNa9c63u4DoWx+G
         PHRoCvtSh6hODwdqSqL01wcmMu688ykCmkMfNDl+Ux1ojp7wY2h+SQ0nznY5NG+n5Z6N
         CMnSC4C9pMQTevNRd5esYv1D71Ze5K7sZAL6vBTlRhcGHYXQ/IlLJL7EIjPenJ7XwGB2
         EVtT87E4+zvzT0mIyuZIc5YWBEH4xEMVTnCvkbTMPGYUfsGIAEDumL69QOP+cUNknXZS
         +3JLV3j4aLD8xa7XhAWW889rLkKs3lPcUIDdWHLugPHvyUQ6GVqYH9ntVlruyF5XN3kf
         KPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZDQ8A5VWHE1J9M00ZvmaE2qoCB2tDWQ5Ppncm8M3Qpw=;
        b=GxYQqnbAgdLt505T4fIFQ7gbfVHKV15I0hnkx/sWTa+UsaxKoc6yfy4o/Ls6B2sTns
         t+QZv/Pkt1iV0VXWPdu3MZTZM/o3M9kh+hlhtte2Mnf45nWDYU5Esug700WI2eaQhgGl
         oDVmC+b3GF8KVsIxvva/JIOslJIVcnL4oXUsMR9xRkXI/uKpOScOPmRjbXl11B9TQxFu
         2IT36VAA+wxBsGgmScO6uOruXIUZZYiQqxYDNlrXvy73UfUNhn94NrzeHgz/nCHLaKmj
         iprtHMlNC9wrfeMNZL5cwwCQstd6jGi1rtdnIPWBP1Y0RNvhWLL1BoaKEGAIi65wGvQQ
         13ng==
X-Gm-Message-State: AOAM531hAKpvBRkVw4Edvl/QVqkEp/sOepQD7y1EqhONuPmj4WyIuTLo
        iM6gPEMKG2DewsZHsXubLAdn4qk14ik=
X-Google-Smtp-Source: ABdhPJwqwRgzJCv1EXmlGF5JWSnkwFtziwDpeIRYBrxGMaMVA2xrFx9N1L00ygOFny7a3eUkEulLBg==
X-Received: by 2002:a37:bb02:: with SMTP id l2mr1161508qkf.391.1616014716803;
        Wed, 17 Mar 2021 13:58:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id z5sm16464319qtc.42.2021.03.17.13.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:58:36 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Destroy classperm list when resetting map perms
Date:   Wed, 17 Mar 2021 16:58:32 -0400
Message-Id: <20210317205832.104545-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Map perms share the same struct as regular perms, but only the
map perms use the classperms field. This field is a pointer to a
list of classperms that is created and added to when resolving
classmapping rules, so the map permission doesn't own any of the
data in the list and this list should be destroyed when the AST is
reset.

When resetting a perm, destroy the classperms list without destroying
the data in the list.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_reset_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 3da1b9a6..47138dc4 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -36,7 +36,7 @@ static void cil_reset_class(struct cil_class *class)
 
 static void cil_reset_perm(struct cil_perm *perm)
 {
-	cil_reset_classperms_list(perm->classperms);
+	cil_list_destroy(&perm->classperms, CIL_FALSE);
 }
 
 static inline void cil_reset_classperms(struct cil_classperms *cp)
-- 
2.26.2

