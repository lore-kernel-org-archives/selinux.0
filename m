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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D235C433DB
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 20:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70AF764F83
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 20:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhCPUkB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 16:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhCPUjt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 16:39:49 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40817C06174A
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 13:39:49 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id f124so36729571qkj.5
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zWdL3Iw5ocvl/KX4f90EnW9PTgLdQnkuVYuqvieZqDA=;
        b=DqxL1RRXH6Yi1vO6WKZD/DW3zCjB46M3VGNLRbvr3t34lIiWj00wRBWYO9MHchAGSi
         moLC8xugC9Q1GisU5Ihi0lC+J363ftfNTpjeE6B+AvlFu3bDo+DQ8CqfjwC9YyJbwvPO
         d9gIMjEbmrKwLepWtTdH6KWRkj44tneWSE5h5J/whmpM45mXRYJkw7MsJrs5BgegQ2zC
         cohPVMBUlnSANOnSAA84hXcXmEH8P8CBSxmM8Oq8nmjNnJ/PfEE2EMS88fPTyNQgVK/B
         EQH/bcE1cc5VV6xyEBZlBLFVlXzuesvzuZW1c3t3ZWhreGmlOuZB8gAjC/vMIR8Su+Jd
         KjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zWdL3Iw5ocvl/KX4f90EnW9PTgLdQnkuVYuqvieZqDA=;
        b=W5mbKZTdsC3SKFlKuRh1itDkfAOxg7OXsH90zfF6SiNnRTdBVBi8gZ9V7I6c8Omdfn
         To3aGt+ey4xSdaeBhFWdrJEi0P2VQhDC6Z18x33dMuvuzcwMLk3JuvGHmDwFmHflfrBJ
         P67hpHYxCvjDztloFTEnzfXHmu2jSMSMnkcEOjVZb2EJvzgTdvUcXugJ+tZSRweRlhv2
         ksGgbNXgATBPiV2VMNIoAvuwU4PCstPVjzKh1PgH+QE+poYDnlkq1FQTJHRV1WBk82XS
         UXlNv/4yboZrn8kq72hAE1lyDxC4ytp84Rs7zRTpesGKVRn89lkRqUCebDVClvfSHocS
         0/TQ==
X-Gm-Message-State: AOAM5310gYLzCggSQK45jWekRLabFpKMZNLbqoP4WqZOdOzxRxmgpUyN
        v53nDw/Z3KBaL5MO/KKSYSm0qs2JcJA=
X-Google-Smtp-Source: ABdhPJyeOVVkXXS7Y7xNmmg/BtR42HYxdgNSiXQWz0R0m20SN+TY3z7hYFFE1KQdBk6IIJqFkXdbfQ==
X-Received: by 2002:a37:b07:: with SMTP id 7mr904111qkl.437.1615927188417;
        Tue, 16 Mar 2021 13:39:48 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d3sm6242313qke.27.2021.03.16.13.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 13:39:48 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol: Enclose identifier lists in constraint expressions
Date:   Tue, 16 Mar 2021 16:39:43 -0400
Message-Id: <20210316203943.47733-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210316203943.47733-1-jwcart2@gmail.com>
References: <20210316203943.47733-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When writing a policy.conf from a kernel policy, if there are
multiple users, roles, or types, then the list needs to be enclosed
by "{" and "}".

When writing a constraint expression, check to see if there are
multiple identifiers in the names string and enclose the list
with "{" and "}" if there are.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_conf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 263f9639..d385819e 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -188,7 +188,11 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 				if (!names) {
 					names = strdup("NO_IDENTIFIER");
 				}
-				new_val = create_str("%s %s %s", 3, attr1, op, names);
+				if (strchr(names, ' ')) {
+					new_val = create_str("%s %s { %s }", 3, attr1, op, names);
+				} else {
+					new_val = create_str("%s %s %s", 3, attr1, op, names);
+				}
 				free(names);
 			}
 		} else {
-- 
2.26.2

