Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BADAC63697
	for <selinux@archiver.kernel.org>; Mon, 16 Nov 2020 22:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48B69223C7
	for <selinux@archiver.kernel.org>; Mon, 16 Nov 2020 22:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUM3NoXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgKPWHQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgKPWHP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Nov 2020 17:07:15 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414D5C0613CF
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2020 14:07:14 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id f93so14229036qtb.10
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2020 14:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=anz3NyTiPtfor683RHrtK2coWqL3eEY13CqpeQS8bJQ=;
        b=sUM3NoXFgmueEyN9ySTHA7dNbb5tCcC5nX+QpTc91AeywWewQZR35pyK8I7Z5qfdSX
         cBXKG17JkY97nWLtWoWDN5Yq8gnY+BvaqodG7uyYd9ZVNLM3nUqB7MmF7Z2N4Cyethwv
         8HWwNs9uKFFxpYBGn12nziWIVqvnixBPS/BYilz/JPZiYCH8hVKVvrh6TFh6fgYlUjZl
         fJVFB/9BiBt45VEclK/37vrnP19MyC4rZW48IGwZ4wTkUlXMeJDe0oTekMhCWmkNnain
         AeSFSEnfcCv2Wi5bUxhmNAnCCfH7a+2GbYS0ct9yeu+EZe++wlVe08fuxgKWQpr3QCRV
         uB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=anz3NyTiPtfor683RHrtK2coWqL3eEY13CqpeQS8bJQ=;
        b=BfdrHrnLCXEgbuKt/bHV6NrFNuSKgjuaMFP0mDukwvmOj9K0rxxn5Pr2hUg/CowfqR
         QaYof/eCZhmQlm+ECuNpcp5SrgQFcNIB2gkxNY9rR+Grn5ei0hqtKeA6Ot6z42OqZ82C
         v2lmQTq1QTzhgrO/zDPx5zeNM4nBmO8l6BoFkmDcG3WdxNp7ve//D1cMtsDfA1tJLblt
         3N9rlDdTsl+eqyMFnZkaErrYmSbcD1ZjMUqoUTRagbBBUImdbK56tEtgAPyW1jIPkx8J
         7EA6cBvdZxssEQl/6rmUCNfSIkA22Ao5mcznd2Uhf9XsE5v6D3shh6mU67cNwO5XrxMx
         twUQ==
X-Gm-Message-State: AOAM532ne6DtBhrfcWWjFVpa/LEkZHGuepXB4hPVvvG8AE5M8+MmNYTM
        4xqnZhw6+F+wBTCnf/zn1XX5XxaWrYg=
X-Google-Smtp-Source: ABdhPJzrPv5zgDPexycjTumIiRcYiEhSR1riajYnAqhbrQeWXsrP4+Uk2633m0Uqqv8VbwkHqVJ9+g==
X-Received: by 2002:aed:3b7b:: with SMTP id q56mr17163892qte.377.1605564433404;
        Mon, 16 Nov 2020 14:07:13 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id q11sm12653330qtp.47.2020.11.16.14.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:07:12 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/6] libsepol/cil: cil_tree_walk() helpers should use CIL_TREE_SKIP_*
Date:   Mon, 16 Nov 2020 17:06:57 -0500
Message-Id: <20201116220702.174765-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201116220702.174765-1-jwcart2@gmail.com>
References: <20201116220702.174765-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The function cil_tree_walk() has an argument that can be used by
the process_node helper function to tell cil_tree_walk() to skip
the node's sub-tree or the rest of the current branch. The constants
CIL_TREE_SKIP_NOTHING, CIL_TREE_SKIP_NEXT and CIL_TREE_SKIP_HEAD are
defined to be used by that argument.

Fixed two instances in the function __cil_build_ast_node_helper()
where the value 1 is used instead of the more informative
CIL_TREE_SKIP_NEXT.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index a8955834..bb5bbc84 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -6387,10 +6387,10 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
 		rc = cil_gen_macro(db, parse_current, ast_node);
 	} else if (parse_current->data == CIL_KEY_CALL) {
 		rc = cil_gen_call(db, parse_current, ast_node);
-		*finished = 1;
+		*finished = CIL_TREE_SKIP_NEXT;
 	} else if (parse_current->data == CIL_KEY_POLICYCAP) {
 		rc = cil_gen_policycap(db, parse_current, ast_node);
-		*finished = 1;
+		*finished = CIL_TREE_SKIP_NEXT;
 	} else if (parse_current->data == CIL_KEY_OPTIONAL) {
 		rc = cil_gen_optional(db, parse_current, ast_node);
 	} else if (parse_current->data == CIL_KEY_IPADDR) {
-- 
2.25.4

