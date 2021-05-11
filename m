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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663E2C43461
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 20:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3426561433
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 20:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhEKUEV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 May 2021 16:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhEKUEV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 May 2021 16:04:21 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD776C061574
        for <selinux@vger.kernel.org>; Tue, 11 May 2021 13:03:13 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id v18so721706qvx.10
        for <selinux@vger.kernel.org>; Tue, 11 May 2021 13:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nRv4lluFvEhFuCRxbLh2jT6/HShoE4a4pAjtmzmzleI=;
        b=SB44Q+q1FGfZc78i3AUIEvv7W1fSwrUzPVIf2RlAU+IfI/A1yrQf+T8vP5xtLgoFbx
         w6VuU/O7+D3W8vPruil1dggSHBnefeZ6/XYCqfv5IDcCGX11k9y/+/3qHyRdctj09GoU
         YPOwtO0ItsPfCj/r3oaupGDYYfXWnvKEUrO/b0O4lyfmcSr1S3Tv1tIeglagte4mQtXh
         lnFIXKuC/B/nwR6C6QlGihmAQ9MLvBjtUgIylhf3iMyTzaaTMt/2DVG++v7qQAMvWbCk
         C2Jo8Hjoj+Qi8K3XoHtkV2n7cS1XpB7YuX2b+JMzLpKDlU84Meho+xSYC3Wv7D1qK1nh
         vNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nRv4lluFvEhFuCRxbLh2jT6/HShoE4a4pAjtmzmzleI=;
        b=t6GRZfnPv7D985gfR3+yx18zkktT/YlJR1oj6qy2OhPU4U4M/LEPNBcUb7fOHCuDo9
         TiOrff/hwm1zp1ewqFeIGz6EmvrSvP9/JOCV026iLxQnDG8X78NRu18RmDMgUEIti/FG
         zhyK601Cra6YgDJPXck0AJmA7VQVsu0A+/MEZOwvp5VpZ4Yu2a6eUcsWt8+9pY/rKh64
         y1JGRVw2wN3UlUm9G4kCUYHQa2C+dm60yIBCR8wVxXelUt89tB5MI18+aazhCYyuWKe6
         8s4VXjUSO3+DXmcgrge3Zc16pP7d9oqiSpjzEG6J7ceZAHwmqIq+E13XXBYkcBVIlw13
         9gMA==
X-Gm-Message-State: AOAM5303NsuHDPduGxzmOnj+VBkcH236Hd1OFZFTn5uomc4B2OIuc+Of
        dXRBAT1q62JzRrN9pcvvv58zJjkY89ZhBw==
X-Google-Smtp-Source: ABdhPJyHoIhN3os6FKpjxv9kXlECVkVRmpl/BTFfCcHw9j+tr/WGkWyQuXfKy6XEjoaWKz0vDVm5XQ==
X-Received: by 2002:ad4:4729:: with SMTP id l9mr31470185qvz.30.1620763392852;
        Tue, 11 May 2021 13:03:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id z9sm4642533qtf.10.2021.05.11.13.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:03:12 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/5 v2] libsepol/cil: Do not add NULL node when inserting key into symtab
Date:   Tue, 11 May 2021 16:02:58 -0400
Message-Id: <20210511200301.407855-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210511200301.407855-1-jwcart2@gmail.com>
References: <20210511200301.407855-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Allow inserting a key without providing a node.

This will make it easier to properly resolve call arguments where
a key might need to be temporarily removed to search for a datum
that is not declared within the call. Since the node is already
in the node list, re-inserting the key without this option would
add another link to the node and cause problems.

Also, do not add the node to the datum's node list if the result
of the call to hashtab_insert() is SEPOL_EEXIST because the datum
is a duplicate and will be destroyed.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_symtab.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/src/cil_symtab.c b/libsepol/cil/src/cil_symtab.c
index 579a888e..c1951560 100644
--- a/libsepol/cil/src/cil_symtab.c
+++ b/libsepol/cil/src/cil_symtab.c
@@ -93,10 +93,10 @@ int cil_symtab_insert(symtab_t *symtab, hashtab_key_t key, struct cil_symtab_dat
 		datum->fqn = key;
 		datum->symtab = symtab;
 		symtab->nprim++;
-		cil_list_append(datum->nodes, CIL_NODE, node);
-	} else if (rc == SEPOL_EEXIST) {
-		cil_list_append(datum->nodes, CIL_NODE, node);
-	} else {
+		if (node) {
+			cil_list_append(datum->nodes, CIL_NODE, node);
+		}
+	} else if (rc != SEPOL_EEXIST) {
 		cil_symtab_error("Failed to insert datum into hashtab\n");
 	}
 
-- 
2.26.3

