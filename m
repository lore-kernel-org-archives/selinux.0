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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D758C433E0
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 20:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F2264F80
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 20:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhCPUj7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 16:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhCPUjs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 16:39:48 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB1EC06174A
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 13:39:47 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 130so36707756qkh.11
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ceJ37/1FP8Gvs21ihux28c5Tl+kr75Ym3HTclM5+Yw=;
        b=Bs5+jGlFokj+VGrFCSDfCmZtKUY87/6so1QXjc4iYl8jXeS6cjqdZUwaK3L4eF2zkV
         6C4OKMw7wFdRHWwND/oFJSSTdI9Rmiy0GsNODIqsuq7rUTUWX4OpygrK9GF3/ktSGt+c
         DZiLc/b0aaRX7vsE3LJkIfTPelVBgGbcnw+g6tBC2PptscNdVxQE+rXz5B91QxoIoqOU
         J0U74vYd6k9dam8FEjkzUA5DtHTMBSV8vg1ofYeLCp4woiN/6443QTNzFIya+w0dK8Cv
         ZDBGYnmcV5J9LLiXQmEClZG5XRABmT5q7fywWs19HTTNikHp3cal2WL2mIVV8LQa8aK/
         JmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ceJ37/1FP8Gvs21ihux28c5Tl+kr75Ym3HTclM5+Yw=;
        b=fI2ZGOwRORjWqQkdUVtt42PSaPVldidhc6vJj+0pn9H4WJoyzPtWmmbNxcVWV4HQpA
         T4zNVy3xlt6MDCA12+UiU3S3H+7iF3lH2Jd2obZzNoksplpj81w9hPNXqCEg4m5eSXrs
         3Eriw/J6CuC/OZv2vGVI2jO/tOgjMWJAurbRokcAMsVAKZPbDcCnyl25cbJ6Haym1iko
         Fc9vNvn6mqbK7rGHL9sn2kbj1UNWy/Ib9rv71oJP/CxzRjMBvQx1L2ajgMisnINhc+DC
         jkwHO452bpU8+WUEqm9PX36GOoFljkLpC7urw7ExK+WlW/w9speKXL+0nJ1M3pDwts3Y
         hDug==
X-Gm-Message-State: AOAM532SMYMuf95xyqYmVWQw11MfcbG1zj28LEg1+eDcinT04i4bhuxD
        wTQ/6gUhZRlveWNqI2MNENMdUM+d3y4=
X-Google-Smtp-Source: ABdhPJzw6zmPen9BPz++4WCrx5TNhSfLGCP/USK2npCZ/k3ryPxWHTrxlVLjQsYuNqCu4s/tEyWORg==
X-Received: by 2002:a05:620a:e:: with SMTP id j14mr936491qki.117.1615927186729;
        Tue, 16 Mar 2021 13:39:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d3sm6242313qke.27.2021.03.16.13.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 13:39:46 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol: Write "NO_IDENTIFIER" for empty constraint expression
Date:   Tue, 16 Mar 2021 16:39:42 -0400
Message-Id: <20210316203943.47733-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If a role attribute with no roles associated with it is used in a
constraint expression, then the role bitmap will be empty. This is
not a problem for the kernel, but does cause problems when
converting a kernel policy to policy.conf.

When creating a policy.conf from a kernel policy, if an empty bitmap
is encountered, use the string "NO_IDENTIFIER". An error will occur
if an attempt is made to compile the resulting policy, but this is
better than exiting with an error without creating a policy.conf.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_conf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index a22f196d..263f9639 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -186,7 +186,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 					names = ebitmap_to_str(&curr->names, pdb->p_role_val_to_name, 1);
 				}
 				if (!names) {
-					goto exit;
+					names = strdup("NO_IDENTIFIER");
 				}
 				new_val = create_str("%s %s %s", 3, attr1, op, names);
 				free(names);
-- 
2.26.2

