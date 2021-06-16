Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458D8C48BE5
	for <selinux@archiver.kernel.org>; Wed, 16 Jun 2021 14:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D5261057
	for <selinux@archiver.kernel.org>; Wed, 16 Jun 2021 14:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhFPOu5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbhFPOu5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Jun 2021 10:50:57 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46677C061574
        for <selinux@vger.kernel.org>; Wed, 16 Jun 2021 07:48:50 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id z4so2068596qts.4
        for <selinux@vger.kernel.org>; Wed, 16 Jun 2021 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sl4kYGdIbz76gButhWhdrRogKnveh+LkAvhLrJV1P2w=;
        b=L6Y70BGhJz5S1WgCKEAqxuYlinMh7x7xrnEHSj75FNIRLWKwBbiML5u8QVFGaUIbDn
         sXwVn5YOB5mzxVOrpOCAOu2H+dYNUUSVXOM2q+E2gZ2ql6fwM41ILy+cwgb3nMrK8qlL
         D7a9eyXXeoMZtG1vQp3Ht/qpSTHBid9bS27nC3Cre41zc0oAR9qCIfcrFvJ2pZReUMbK
         Sx+Sc5hZPdfUCeQBXymQf1ddxhQUQXkMg6L7j9XSghQjkmB4ep7S2CguhCb0n/NQeLv4
         LMRUg43kShxKNbTt5BX5QUvv+CXOw1pMMh6KmNiw4EEDiiaq8+TtDrJ5dT1/ZtESMRlc
         D6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sl4kYGdIbz76gButhWhdrRogKnveh+LkAvhLrJV1P2w=;
        b=V6XhbmTMBU76jPf8pLrDOIU2mPliKv0pHsTPZBLdUFJy1scbyJHGPHwazkkq+Rbjnn
         yC7IXVsVFKuiKoTIaouWNYgZEO3rTnBxdT/+fyU6dOqIjgZYW4tPCulz7oMEpnRYfJnu
         swfbfmiWqPFoFBs7EtFGt7+0x7SDIRuRat97sqIstlNDFe/lZ9Xsl8qVS0dmBwVROQ40
         +uSfHLI2c1Z8hIvsZs+iqAToM8+zHHFT/qZ/b892PXS6Tf0YHVZTlw2XblY920AMVzuC
         12FdKON2VaLLID4qkX3kqPec5kRF9CslMNrzO5BVFhGFF/bQb/KadchJM3l3Cp/FBUmU
         EMtg==
X-Gm-Message-State: AOAM530jS2NJUB0xEWAWBMFtXRKgVcNC0EY6FUQGkV/FH/QJwLEOLwcg
        3egmO3UgZbN07kt9qNGUvjFiR7YGPJj2pA==
X-Google-Smtp-Source: ABdhPJzW4vuCE81V/SNSk3TbPaY6iFbUOYE0XN+Y94jPRns0J8T9qwgggkvf+3cjjNaWV6svFPftpg==
X-Received: by 2002:ac8:4f03:: with SMTP id b3mr266611qte.162.1623854927419;
        Wed, 16 Jun 2021 07:48:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id p7sm1651065qkk.104.2021.06.16.07.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 07:48:46 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Quote paths when generating policy.conf from binary policy
Date:   Wed, 16 Jun 2021 10:48:43 -0400
Message-Id: <20210616144843.79344-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian Göttsche <cgzones@googlemail.com> submitted a similar patch
to quote paths when generating CIL policy from a binary policy.

Since genfscon and devicetreecon rules have paths which are allowed
to contain spaces, always quote the path when writing out these rules.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_conf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 5db47fe4..ffdf179a 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -2527,7 +2527,7 @@ static int write_genfscon_rules_to_conf(FILE *out, struct policydb *pdb)
 				goto exit;
 			}
 
-			rc = strs_create_and_add(strs, "genfscon %s %s %s", 3,
+			rc = strs_create_and_add(strs, "genfscon %s \"%s\" %s", 3,
 						 fstype, name, ctx);
 			free(ctx);
 			if (rc != 0) {
@@ -2992,7 +2992,7 @@ static int write_xen_devicetree_rules_to_conf(FILE *out, struct policydb *pdb)
 			goto exit;
 		}
 
-		sepol_printf(out, "devicetreecon %s %s\n", name, ctx);
+		sepol_printf(out, "devicetreecon \"%s\" %s\n", name, ctx);
 
 		free(ctx);
 	}
-- 
2.26.3

