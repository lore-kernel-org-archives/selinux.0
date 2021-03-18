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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ACAC433DB
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 13:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105C864F1B
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 13:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCRNu2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 09:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbhCRNt7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 09:49:59 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28970C06174A
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 06:49:59 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 130so1962680qkh.11
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 06:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ew6hB9Jh+pe89VYaqsAAJagp5sC4Hw1LeXJwiZ+zzuI=;
        b=AOD1JAUp4kbEicZoLCY99uKOujTVmdYS33bIek5iDNt+nobfFwsK1UzT4aBWZ1FI2w
         +Ll5USOd2A/qod5TmQpm2zaTMArngFMt9fFl/LWD0k4iAz9mVkFr1qF0KjnwmQKzYYmR
         ceUqTSkgydY/bTmcu8nKChTbHzjwe1rr/varoDeraOlG8Q2qNZFTAHXSIYUTd1lrBoUS
         t9+yM4wliSOZifl9abWkPGGqdVL6hFyNX9aoBV7dC5SBPWfONApl3ylfnqFQzXAByTal
         +zyL+3fymRNCpp7Ibge4mIl5zTA7n+8GuxpqcBptcdobJ8C5KoJBGRShTJ2VqQAwk9H/
         Sczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ew6hB9Jh+pe89VYaqsAAJagp5sC4Hw1LeXJwiZ+zzuI=;
        b=lyEDSNVXOVNfZ4ADwh1VACsayxTl0cz5Tomm0rUnzheWeTrc9CrXCgv+kThAZnK508
         8/y7LRcIs45muy3hhk8wWVMg6/o5F6iR9cRFux1zvXS34UBFacvEGLYHsdbm1t6tt5VF
         aE0Zq5UYdXfomHjbJGrHgS2ogvji8cFqJiaaWkapBBQzYHK4zyB0d2iRXOM3HLKUDLAg
         5IfMlEk1G+IpX/c9ukMCezosGpR+OZpg0pWGHjxyZyhIwI9DmQWMg7zcUhU1xcZqQ/xD
         JdygHBdJi1YI/97p9VFaSE1l5QWLqPJXOkk6mIF6A+Yl+nY3qewF97LdYLNiXuNweC7z
         uOQA==
X-Gm-Message-State: AOAM530hlVIkYPr0TAntn7SNKk0eUaIDf9HBf57XHtm4DdWnZButeGt2
        rFx/dH2tx1218Ha8pM2Fza5kBCNj0QOIxw==
X-Google-Smtp-Source: ABdhPJzUg2pvsTHEJl+dXoSYKwXR+Dl+yEdusJ6B+7nYe+WmzItXONzbAcTbnH1Jprpm2UxVPYo41Q==
X-Received: by 2002:a37:589:: with SMTP id 131mr4413042qkf.97.1616075398247;
        Thu, 18 Mar 2021 06:49:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id p186sm1827785qka.66.2021.03.18.06.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 06:49:57 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: cil_reset_classperms_set() should not reset classpermission
Date:   Thu, 18 Mar 2021 09:49:55 -0400
Message-Id: <20210318134955.128187-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In struct cil_classperms_set, the set field is a pointer to a
struct cil_classpermission which is looked up in the symbol table.
Since the cil_classperms_set does not create the cil_classpermission,
it should not reset it.

Set the set field to NULL instead of resetting the classpermission
that it points to.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_reset_ast.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index db70a535..0c74deeb 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -59,7 +59,11 @@ static void cil_reset_classpermission(struct cil_classpermission *cp)
 
 static void cil_reset_classperms_set(struct cil_classperms_set *cp_set)
 {
-	cil_reset_classpermission(cp_set->set);
+	if (cp_set == NULL) {
+		return;
+	}
+
+	cp_set->set = NULL;
 }
 
 static inline void cil_reset_classperms_list(struct cil_list *cp_list)
-- 
2.26.2

