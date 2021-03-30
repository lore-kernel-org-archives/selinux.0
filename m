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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75647C433E8
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54533619B1
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhC3RkI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbhC3Rjn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 13:39:43 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B55C061574
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:43 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o5so16706976qkb.0
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X00LfgVu1NPDynyWs585bitxzMaqOJepRFpelFgqTpA=;
        b=cGF0EPyyBtGDRTWL5tCgDNmrJzb2LyifNGKzKYBEF2jgRP7wTuwoEBuvshE4t86hmM
         ikZcooshxa3l0KX9gUgvOhYV67kRAQ43/+7c7J/CHLNINXispcMsKdZJVecWmm/V52DT
         C3RTpZxcFAyvl7KZzYNur99ZDxTnaxUYvqtKAgwG4EAJUAfG+0nirBBTZZPCxwG25skm
         0c0A+aFYCfE8LZq51OG9+HPGRI/kC9QYloaUzwZ0F77wvPEaP9ghHfmfxZben7Pe/r+N
         96OY7GcN01tbDB8rdhTwGaXuzZP8FodSzabfqkLTmfnL1kvGEXRsGKvgdFx0o8+Eze99
         lxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X00LfgVu1NPDynyWs585bitxzMaqOJepRFpelFgqTpA=;
        b=mZc6gi12l/Ypjeh2bP4prd60vKx1saEvB+GX479BK5A4i6IPLE2HBhXSmfKPRpbwNZ
         XIQ/ifshDPnKNgZqn0HDcvNrn52ouhaKaprksj+TC/yUrYfOq6INjUwlO64nw01A+7IH
         DXNFN8bZFeGehvmdqxauTWMcH/6qq7zvL3mOl2N30kmgqRPiUrcJK6J085g1513dSk51
         uMmi9w+4UVcmxdKADbQDD5/AjJ6YwwoYqkBo2pQ/vUgnzCsGWgtHkIK2yObjPAftIXP/
         nrnQr+1ip0gA9h3U8lUdWL1t4FntnZneEB6D7iG1m+t4BIBDp9j6IthZrmKH71K0OlWO
         vInQ==
X-Gm-Message-State: AOAM533zgmrAyoBlju5TLL3chp69GRcSvTRfD5/rnddlTOaHQDzeNPYE
        kkgOc/Xtu1MvAmGkS5wR94POitqqL4e/Iw==
X-Google-Smtp-Source: ABdhPJz+aLhsUeHAxQ0O3uiEfWJS7fuNYRFC3+tM88xIdXEcfXwFezVN4J6BNzYrDjedGtkhS3kekg==
X-Received: by 2002:ae9:f10b:: with SMTP id k11mr31997104qkg.62.1617125982778;
        Tue, 30 Mar 2021 10:39:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id r7sm13507482qtm.88.2021.03.30.10.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:39:42 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 08/12] libsepol/cil: Sync checks for invalid rules in macros
Date:   Tue, 30 Mar 2021 13:39:19 -0400
Message-Id: <20210330173920.281531-9-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330173920.281531-1-jwcart2@gmail.com>
References: <20210330173920.281531-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When resolving the AST, tunable and in-statements are not considered
to be invalid in macros. This is inconsistent with the checks when
building the AST.

Add checks to make tunable and in-statments invalid in macros when
resolving the AST.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index efff0f2e..7229a3b4 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3796,7 +3796,9 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
 	}
 
 	if (macro != NULL) {
-		if (node->flavor == CIL_BLOCK ||
+		if (node->flavor == CIL_TUNABLE ||
+			node->flavor == CIL_IN ||
+			node->flavor == CIL_BLOCK ||
 		    node->flavor == CIL_BLOCKINHERIT ||
 		    node->flavor == CIL_BLOCKABSTRACT ||
 		    node->flavor == CIL_MACRO) {
-- 
2.26.3

