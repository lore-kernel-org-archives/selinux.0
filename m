Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9A8C433EF
	for <selinux@archiver.kernel.org>; Fri, 11 Feb 2022 18:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiBKSrF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Feb 2022 13:47:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiBKSrE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Feb 2022 13:47:04 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9E6338
        for <selinux@vger.kernel.org>; Fri, 11 Feb 2022 10:47:03 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id c189so9025274qkg.11
        for <selinux@vger.kernel.org>; Fri, 11 Feb 2022 10:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eoR2YH5tbQH+EU/rWRLndsquDyZ5lUN1Re0063fNjZs=;
        b=NxB4Xn9RbDDY6+rPnE4Yys46WfhDA/ihZJ8VD01DfI0s1H/nckiMjhXYUxcZhhZruv
         ep8xreWGez7NWmZbDCBNTXGVW184lCtM6MOqot0ZumgLhRER+E48rGKDs6m7AHOvrBia
         QLlFXj7YBlHlaV5w69FOE+Yx86ttK6Uf9b8qV3mz7JBV8+FCQzhWti8cshUwWaqBaJ1O
         2xk7a6CbsfedivlR2dvIsLm1JNHlwlFejkkPs4rHczePESqGlsPMuRTCura3ILWDSTnm
         EwfQkz9l3EPO2gxgnCM2gJHE3H2l4OCozzTfax23Ic/QuI5hMX9wGCJV5O14PbNsOfyn
         M2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eoR2YH5tbQH+EU/rWRLndsquDyZ5lUN1Re0063fNjZs=;
        b=wp2h5OWRjncyj+sENR4oEYTYCfQ0YmmYmfQvasiXXPfBTWFuKyfH0xEn5Wd6bPLKan
         0T5L+sGQeLKZuKmfaRcOv9gulJysNiXn6CNYNs3u/lpDTo9W/lSpADHU3t8C92IYZMUU
         kYDxJNOHX2+0FA+05C2K+ppUhtM20AdYiAZ/0R7EBROp3NnbpybMBYGmdCDdhA7RC5FC
         r86HIDSiWOziyuILB8D0hJ55x1mZC3qDGV8X1BioJ3Elw+9BNQgy4xVQfOVeypq04U6l
         bVMPazzqwuWDfPnF8a8hw1tAU9UZFDFhZq7zWJT8SkVKhgM7/CmhO+PpWc2OMPPKRP0G
         MsYA==
X-Gm-Message-State: AOAM530YnmwiK+ts5AZS/xtheGPaztOhGL7xstT6BFAEiRcPNijlu82N
        qE5aR7QEWzr2A84heQiONDbHXbcA5k8=
X-Google-Smtp-Source: ABdhPJzZRq+xOn1WniwXwkhtfML8j0emVTfJ5FLIlhAxE14AUnLKOS6dPUsLeDGbcOEpBWvWW5DWbQ==
X-Received: by 2002:a05:620a:b42:: with SMTP id x2mr1455220qkg.362.1644605222416;
        Fri, 11 Feb 2022 10:47:02 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id t1sm13668767qtc.48.2022.02.11.10.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 10:47:01 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol: Don't write out constraint if it has no permissions
Date:   Fri, 11 Feb 2022 13:46:50 -0500
Message-Id: <20220211184650.535016-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211184650.535016-1-jwcart2@gmail.com>
References: <20220211184650.535016-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When writing a conf file or CIL policy out from a kernel binary,
do not write out a constraint rule if it has no permissions.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_cil.c  | 3 +++
 libsepol/src/kernel_to_conf.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 693206d2..869f6940 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -282,6 +282,9 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 	struct strs *strs;
 
 	for (curr = constraint_rules; curr != NULL; curr = curr->next) {
+		if (curr->permissions == 0) {
+			continue;
+		}
 		expr = constraint_expr_to_str(pdb, curr->expr, &is_mls);
 		if (!expr) {
 			rc = -1;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 52b6c60f..3544f73d 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -277,6 +277,9 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 	int rc = 0;
 
 	for (curr = constraint_rules; curr != NULL; curr = curr->next) {
+		if (curr->permissions == 0) {
+			continue;
+		}
 		expr = constraint_expr_to_str(pdb, curr->expr, &is_mls);
 		if (!expr) {
 			rc = -1;
-- 
2.34.1

