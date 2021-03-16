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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65999C433E9
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 20:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421D564E42
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 20:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhCPUsc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 16:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhCPUrF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 16:47:05 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1713BC061764
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 13:47:05 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a9so36714918qkn.13
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 13:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Y3ZtjVdB7S6Ir5KZsOcBYwZ4O3gd3WI1L5QfaZ+bSs=;
        b=mV9+4uTPgnTyW6MlxQMFS5k/LguRBIIJEhFu96PhMniQGZEDKcMLt1SNa0WHlLOQUR
         AIYO83U5m4SaIh8mFBBp1lZrX35BzbNgMa0WC85zrZH7pcN1F1JzEP7xEYqGXqK8TprZ
         spcq+5moyu1rBZTI4C6JCWYdR4nuPyW5qdO44y62erlFFBTHticMv9kCfYdEtNQeDKhc
         NZRD7gafDRhGn8iI1p20H46eVt7yBvlHKibLP3qeGDiMjwTrpxg3JPzSzpkiTbq0gGtP
         Q77ZriNuySvTakFEPLs/ofg+oXwuF8GOUkYyjsyTvG/FOmN4vp+/bHVTV0hjgQL2YDoa
         TB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Y3ZtjVdB7S6Ir5KZsOcBYwZ4O3gd3WI1L5QfaZ+bSs=;
        b=Z7H61HDtA07oIeUKx3qUjBJZwFO1Zgw+mNMp6NJkngQ5uOkxgstbeeIyqcw25WIsEZ
         4px9PqvDHUNAjAbAvwaXzX+4jVRJDIGhg4HQF4/vRn2RtXgfW5c1/uoX8erkuRFEohbm
         OUUhevV/rcxGUjWlH3zfxI1d9KjiMjnPjcJgVmL5pB0H2vPqryTz7tUM6ZRM7Mm68BOr
         RLSUIvwHganFUdCrEmiQP8TUOYMCkjvLsaU3HNk42Hq2OyfrtYdrG1NFUexH5aST3k3B
         6Nj3O1txY+Vo1FQS7fkHvlGiT/U4oXweiaXCezu5wdDm5CrJHjx7gs5MxQFZ/v02GWVk
         LcqA==
X-Gm-Message-State: AOAM533RFGK7JmjRzS0yl08FYMoXMw6QBTHDBMzATxEA8fZgYbbhc4WH
        jsCuWNtKiLnKgRv6FAtmr6uZnWNKhy4=
X-Google-Smtp-Source: ABdhPJxfn0QYscJzk7ugH4JFv7/7RjW5Q0M47C4GlJiR4a2Ye+27lJeBcnPlY+TtusAz6e6WB0pb0g==
X-Received: by 2002:a05:620a:16ad:: with SMTP id s13mr1027547qkj.68.1615927624143;
        Tue, 16 Mar 2021 13:47:04 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v4sm13905687qte.18.2021.03.16.13.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 13:47:03 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 4/4] libsepol: Write "NO_IDENTIFIER" for empty CIL constraint expression
Date:   Tue, 16 Mar 2021 16:46:46 -0400
Message-Id: <20210316204646.52060-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210316204646.52060-1-jwcart2@gmail.com>
References: <20210316204646.52060-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If a role or user attribute with nothing associated with it is used
in a constraint expression, then the bitmap will be empty. This is
not a problem for the kernel, but does cause problems when converting
a kernel policy or module to CIL.

When creating a CIL policy from a kernel policy or module, if an
empty bitmap is encountered, use the string "NO_IDENTIFIER". An
error will occur if an attempt is made to compile the resulting
policy, but a valid policy was not being produced before anyway.
Treat types the same way even though empty bitmaps are not expected.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_cil.c |  2 +-
 libsepol/src/module_to_cil.c | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 96e0f5d3..c6dd2e12 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -189,7 +189,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 					names = ebitmap_to_str(&curr->names, pdb->p_role_val_to_name, 1);
 				}
 				if (!names) {
-					goto exit;
+					names = strdup("NO_IDENTIFIER");
 				}
 				if (strchr(names, ' ')) {
 					new_val = create_str("(%s %s (%s))", 3, op, attr1, names);
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 3cc75b42..2a794f57 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1793,9 +1793,13 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 						goto exit;
 					}
 				}
-				rc = name_list_to_string(name_list, num_names, &names);
-				if (rc != 0) {
-					goto exit;
+				if (num_names == 0) {
+					names = strdup("NO_IDENTIFIER");
+				} else {
+					rc = name_list_to_string(name_list, num_names, &names);
+					if (rc != 0) {
+						goto exit;
+					}
 				}
 
 				// length of values/oper + 2 spaces + 2 parens + null terminator
-- 
2.26.2

