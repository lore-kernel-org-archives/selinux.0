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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E62C432BE
	for <selinux@archiver.kernel.org>; Wed,  1 Sep 2021 20:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAE46101B
	for <selinux@archiver.kernel.org>; Wed,  1 Sep 2021 20:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhIAUn4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Sep 2021 16:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhIAUnz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Sep 2021 16:43:55 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BFFC061575
        for <selinux@vger.kernel.org>; Wed,  1 Sep 2021 13:42:58 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id e18so643151qvo.1
        for <selinux@vger.kernel.org>; Wed, 01 Sep 2021 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBdo6BIoWnUCgTbxazMexOgxpUKVdyGWCV36lfgA5qQ=;
        b=oJuTX5xgMPRQGqgBL/d8Q+ftmhEBpIBgxAm3Kxkg5Dij1GP/qLyMCs/VuV39gwkJ7F
         f1wc7qm4xEXvxoxEzJi3NsPVL4o8jYOef04DqzobijG/YA9D2h0Px9SiDZH24o5enIj3
         du9+D6JV9EtClexYeAlaGyt8x2LGLWsgrfv/yMHjhqHqgfs33+0dMXv1TDrG675eH8hJ
         Vzlt5kqV2TzS798ekQ6Rq0UkyzZXcTFJStpgocxu6tUfAwRtnSEYqYtvuzKE59qd+pQC
         1yItDMI04qd1KllWuliKekrScj7VIqatX77u6TaeGJ86fINRwrZz0muGJ3AVV1aaHZ3n
         5EJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oBdo6BIoWnUCgTbxazMexOgxpUKVdyGWCV36lfgA5qQ=;
        b=emg1PZedS+BJ2o+UWH5FbrEG93sKE/Ic4S79omxKSuEAzzpDMjowkkJLYl2NIgk8ub
         u1udxYRXqFJAzPXCwUxos0O03CAFqMvCkaRMwdfRRoqDq0d+fqHbf2IYq4n3Dv8FyXIw
         Aa2CRHO/VB8JeV5asXIh24gxinrhiDBtdFsTLaG1K6M6DrjYcMbN7OdH994Ij0eo27qZ
         8tTKKTYpKOe139i9HjHR3BR8nY6X2ETz6eJFOi4BX5++fziO68oh80Zhe0C6gf4fpjDO
         AXZEHzY4hxxwfNqqYvCPAb3GqJByM+b/Yce10TiVPcq8DbiyIZC1STjiWR07b3+wYU+h
         A2Jg==
X-Gm-Message-State: AOAM533KYut5/RcJyZ8fvedkCCB1hPKlqZvBVsSq+vwK/4lQhctj4ckL
        m+QHBLzwAWpbIBVgzrV9PhQvq4e44Ug=
X-Google-Smtp-Source: ABdhPJzM5tMteuiy3Km0eJZjfAA9IGBzn049qWGfHY18kzeROgCFf1r4yRFnfHfaTCa1LMkvzvUGjA==
X-Received: by 2002:a0c:e803:: with SMTP id y3mr1762772qvn.39.1630528977404;
        Wed, 01 Sep 2021 13:42:57 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id x23sm500098qkn.29.2021.09.01.13.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 13:42:57 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3 v2] libsepol/cil: Remove redundant syntax checking
Date:   Wed,  1 Sep 2021 16:42:50 -0400
Message-Id: <20210901204252.635570-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For every call to cil_fill_classperms_list(), the syntax of the
whole rule, including the class permissions, has already been
checked. There is no reason to check it again. Also, because the
class permissions appear in the middle of some rules, like
constraints, the syntax array does not end with CIL_SYN_END. This
is the only case where the syntax array does not end with CIL_SYN_END.
This prevents __cil_verify_syntax() from requiring that the syntax
array ends with CIL_SYN_END.

Remove the redundant syntax checking in cil_fill_classperms_list().

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Same as v1

 libsepol/cil/src/cil_build_ast.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index a5afc267..f0bb8c0c 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -736,20 +736,11 @@ int cil_fill_classperms_list(struct cil_tree_node *parse_current, struct cil_lis
 {
 	int rc = SEPOL_ERR;
 	struct cil_tree_node *curr;
-	enum cil_syntax syntax[] = {
-		CIL_SYN_STRING | CIL_SYN_LIST,
-	};
-	int syntax_len = sizeof(syntax)/sizeof(*syntax);
 
 	if (parse_current == NULL || cp_list == NULL) {
 		goto exit;
 	}
 
-	rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
-	if (rc != SEPOL_OK) {
-		goto exit;
-	}
-
 	cil_list_init(cp_list, CIL_CLASSPERMS);
 
 	curr = parse_current->cl_head;
-- 
2.31.1

