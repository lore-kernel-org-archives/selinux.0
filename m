Return-Path: <SRS0=vGri=CY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBA3C43461
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 18:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8197820B1F
	for <selinux@archiver.kernel.org>; Tue, 15 Sep 2020 18:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOJbBucO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgIOSsp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Sep 2020 14:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbgIOSsM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Sep 2020 14:48:12 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71818C06178A
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 11:48:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q5so5395554qkc.2
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2020 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCwLNex/ljZWWWmy7H/MFzCnwq3a445JMfhNA/pIiic=;
        b=jOJbBucO/AfGXUGoBifhyk64gTiDoV6BsZFz/aeg9FN9TxgCubSnOgDZOZO/66HVCH
         xTqcgLLrlMTdZZXzHf9bBB42r26R7Ki0+7fuYg91rKlVRSA3LR5JtbeAJrMeIIxcMC3s
         REYMkTK5kqoo6tOW/4UOk2dvsBgdXnGGiSAfotPtKtyG066TpxaEg9pCZv5YP0wZt6ZO
         Wwj9P27sKPP2I11uoWEYI5n5sx/8ENr+ARm6wEvZYcnXTODsjD/GSklq3PITLUh1KOJz
         4D1lwjoTR7bMtZNxqDWbWBC1GeBiKUPxy1axdVzBaEi+aES0w8YEipdhR84PET8MCKOy
         AVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jCwLNex/ljZWWWmy7H/MFzCnwq3a445JMfhNA/pIiic=;
        b=ROwkEW9syfsNB1gGEEW0Sc+UFlkvzYDqTdQ0tD5SOWnzx64Jz3VqInZysKV2jCSL5G
         8lIqYVzMXZ5+zrGiuIGhLco+qrPCwv8CQtXwzDU2zpuBH67qnqBrvh7PF7mBePGPlAYA
         orJT1SwgXaE6HgzK9SvodPCUcH4I5TgNu/fyUTl2bgxMUKJchA225apESyNDVFc1Fe89
         7+cwqPeHf61wr1S/m51uctcTddNZjUpk/Ijwp/X1r4ZxPn37EVFsaVMz+pTqhm3ROENN
         vlo4Vg0IWpMrXpKUIWrXp+XrVeaE1TYNM7BrMcvmilG8CY1SIjyfLJKqQBqhJS3p/ubD
         ynbA==
X-Gm-Message-State: AOAM532T8hWOIFPQJS5x7gzH5XRRrooxEPyUh87jUdPoOJqz3LV9ks0M
        Sn1qhBnNiIlwSv5DM7fdEskwtQXUW/g=
X-Google-Smtp-Source: ABdhPJwCaopIgzj3YqhcSFr/2OwSscZ4yctP1FQNcACOrKC2gyW3EkcXCCJ5/Jl91YA4wKql37draQ==
X-Received: by 2002:a05:620a:1275:: with SMTP id b21mr18247791qkl.135.1600195690557;
        Tue, 15 Sep 2020 11:48:10 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id b13sm17608379qkl.46.2020.09.15.11.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 11:48:10 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Jonathan Hettwer <j2468h@gmail.com>
Subject: [PATCH] libsepol/cil: Fix neverallow checking involving classmaps
Date:   Tue, 15 Sep 2020 14:48:06 -0400
Message-Id: <20200915184806.396309-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When classmaps used in a neverallow were being expanded during CIL
neverallow checking, an empty classmapping in the list of
classmappings for a classmap would cause the classmap expansion to
stop and the rest of the classmapping of the classmap to be ignored.
This would mean that not all of the classes and permissions associated
with the classmap would be used to check for a neverallow violation.

Do not end the expansion of a classmap when one classmapping is empty.

Reported-by: Jonathan Hettwer <j2468h@gmail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_binary.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 50cc7f75..36720eda 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4363,15 +4363,13 @@ static int __cil_rule_to_sepol_class_perms(policydb_t *pdb, struct cil_list *cla
 
 				rc = __cil_perms_to_datum(cp->perms, sepol_class, &data);
 				if (rc != SEPOL_OK) goto exit;
-				if (data == 0) {
-					/* No permissions */
-					return SEPOL_OK;
+				if (data != 0) { /* Only add if there are permissions */
+					cpn = cil_malloc(sizeof(class_perm_node_t));
+					cpn->tclass = sepol_class->s.value;
+					cpn->data = data;
+					cpn->next = *sepol_class_perms;
+					*sepol_class_perms = cpn;
 				}
-				cpn = cil_malloc(sizeof(class_perm_node_t));
-				cpn->tclass = sepol_class->s.value;
-				cpn->data = data;
-				cpn->next = *sepol_class_perms;
-				*sepol_class_perms = cpn;
 			} else { /* MAP */
 				struct cil_list_item *j = NULL;
 				cil_list_for_each(j, cp->perms) {
-- 
2.25.4

