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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F2DC433B4
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 18:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4A7610F8
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 18:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhEMS4A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 14:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEMSz7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 14:55:59 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED9AC06174A
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 11:54:49 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i67so26518536qkc.4
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rqmsuvoI/H5T5WiC2gfKicvCrFKxV98JgJrMCP9Fxlk=;
        b=vQQFIhHHOltGb5o6Awl8DAxwOBxXeOauYAc7ILV0lg1h/zHrC5K0gR+6KcvVXZOAlc
         m9VTmy59ghcQrqYwsnCMFuIdRw03QrVKJyknq+IOgTuibEZFXK2srtE85jYIP+Q/0xJX
         PGPKmWI8IM/zSQ4U9qgt2ZkH5XJ12GTIS29YomgOBxwbskVxyaw5dTVAs1GKHwUMNgWt
         JhEH9tJxSbJT74kGhDhU2SebJ5w732hYW7rAis38lIjEVOYufQ2VZrKVlfmYU3IwPPc5
         O0NpexXKxiIPo7UfvxN4CA8MwedZAXAf3pTITrwyuI8tLxO5Gk/PZeGYt3As6h1RChhE
         XIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rqmsuvoI/H5T5WiC2gfKicvCrFKxV98JgJrMCP9Fxlk=;
        b=HGNahp1fi03ljKfqSQgafJnPe4O7qy4gVkvN+wcgMGIvCz/huWjzN2ELFiOx3X4FTo
         XPhsXaqL17811ksZWK5nE2V8kJvGwubhRexkIvfX+6e2mGFmM9kQOtdUXSyWkpclHO0+
         O/ffi1m06C30NM+/QJFqa02iw+TcbM9sGr7g8UjZXcdkvPwUZSXGwfzedbNjYG1ZkATc
         Ef72TAY4U4eMoHBWK+afRBaeqtM8HUcP8bTexCcHvm3dZ49Tuf+cCX+12ESTiAc0TC9K
         G09ib9JYJH8NZnzZK+EI+8Jance1dSdvUssKJ5EwvXVllRD1NbUdR/lVm+sXUUpK/9wF
         bKMg==
X-Gm-Message-State: AOAM532Dt8FBqDQtTl8IcvDCTnu19zzs9xRwMl8AmeiUFbxCWJRtthBw
        bD1Ddnt7Py6UA+KVI8qYmBScHT+zVYRS6g==
X-Google-Smtp-Source: ABdhPJyiSjzi26vvz1thsS5gJjuj/1MnlKwsyjvU264sf8A+sj9wow08hB621Loc0kXDLEGs22EauA==
X-Received: by 2002:ae9:ed54:: with SMTP id c81mr39755631qkg.251.1620932088804;
        Thu, 13 May 2021 11:54:48 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id h188sm1713767qkf.133.2021.05.13.11.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 11:54:48 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/6] libsepol/cil: Resolve anonymous class permission sets only once
Date:   Thu, 13 May 2021 14:52:52 -0400
Message-Id: <20210513185254.559588-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210513185254.559588-1-jwcart2@gmail.com>
References: <20210513185254.559588-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Anonymous class permission sets can be passed as call arguments.
Anonymous call arguments are resolved when they are used in a
rule. [This is because all the information might not be present
(like common permissions being added to a class) when the call
itself is resolved.] If there is more than one rule using an
anonymous class permission set, then a memory leak will occur
when a new list for the permission datum expression is created
without destroying the old one.

When resolving the class and permissions, check if the class has
already been resolved. If it has, then the permissions have been
as well.

This bug was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 242aea4a..865297fb 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -158,6 +158,10 @@ int cil_resolve_classperms(struct cil_tree_node *current, struct cil_classperms
 	symtab_t *common_symtab = NULL;
 	struct cil_class *class;
 
+	if (cp->class) {
+		return SEPOL_OK;
+	}
+
 	rc = cil_resolve_name(current, cp->class_str, CIL_SYM_CLASSES, extra_args, &datum);
 	if (rc != SEPOL_OK) {
 		goto exit;
-- 
2.26.3

