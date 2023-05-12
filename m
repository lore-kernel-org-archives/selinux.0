Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B5AC7EE25
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 10:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbjELKOT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 06:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240635AbjELKOI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 06:14:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7701AD2E6
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:13:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96ab81aa68dso40499266b.3
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683886417; x=1686478417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=S0vVkpkm49sC2VB7E6iZxVtCWLFA5IgMx/iKIiKw/PI=;
        b=ozSiGmFDqAIVLbNlFIjjCPvHIFoloGoSy5RFGcZHVBk6fRjSxh1YpBZfXMRpxTZSTA
         2bMJTs5lz+G39fCEXmJHkbQV5yTytjJ+WZ6wr4LEku7wHVk90Xu0JUr30fptdl+xL5yn
         XxBFuBx093Kjlxzp0opTC4JayikdpH7261cTCPLDcAu4udfQw85hTG8jf5dXr3LROA7S
         /V5/BnmPLevBUaIHr5fQE6jk2Yd3RuRPuKHJ6+XwJF1LL28f5+XvDZLE4W22mhTMlkQl
         MnlCIIr2c1O5CFvDB2oqWMMs1qs4s1aWrg/e1S5nxVcSlwckTUSCOyGvEuzcMV0MHwc/
         sRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683886417; x=1686478417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S0vVkpkm49sC2VB7E6iZxVtCWLFA5IgMx/iKIiKw/PI=;
        b=JTrFqubdFHKHhRuDh2cRR+JZjsXj+Qcu4X6rBgJ56mAhrbEMZtk5CM2NSr8q5PNCiM
         e2zH2lNV5P9kvBnlO/S+k6BmCkKJz+Rr0vVDW5ruKpzDq3OFMjxR/l2BRM6jS+r7pesn
         calwtyYy2qPRLyBpcZTnY8seucihTzQq7Y0llCGQBKG1SGVxlZ+wUBRvjiqaWlGylWVw
         ydfAFYjykz2g8UVXeLI5ICJJ9WGEtRDPk/zfwOoMFq3x8hXkm7Gt+6tHPpixKorYlJMc
         OrRynwzU6uO9sQvdk7m28NxDp9+/nerESBhQ3BCmsVkiLkh0l+RcwBNgrGI1a9UYIFMd
         q88w==
X-Gm-Message-State: AC+VfDyS4Bt4Qrd+uYD0NpeQICl83TroFQWdji+x/91j11tiaPO9ukUD
        YtOjHdJhWaKhz+IeHMmoKSlCM+HCXjAaKA==
X-Google-Smtp-Source: ACHHUZ71KXiaMWh8CshPhoTjmQoblMGmWyf6iSqVVkAyZrhh/hjrrpyBl5hM2RXCQfJRyfQ4q+q97w==
X-Received: by 2002:a17:907:7fa7:b0:94f:553:6fd6 with SMTP id qk39-20020a1709077fa700b0094f05536fd6mr25474883ejc.24.1683886417424;
        Fri, 12 May 2023 03:13:37 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id n5-20020a1709065da500b0096616adc0d5sm5233551ejv.104.2023.05.12.03.13.36
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:13:37 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/4] libsepol: drop message for uncommon error cases
Date:   Fri, 12 May 2023 12:13:30 +0200
Message-Id: <20230512101333.67196-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Match surrounding code and the message were quite generic too.
---
 libsepol/src/kernel_to_conf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index c48a7114..cb7cb740 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -2886,7 +2886,6 @@ static int write_xen_pirq_rules_to_conf(FILE *out, struct policydb *pdb)
 	for (pirq = pdb->ocontexts[1]; pirq != NULL; pirq = pirq->next) {
 		rc = snprintf(pirq_str, 21, "%i", pirq->u.pirq);
 		if (rc < 0 || rc >= 21) {
-			fprintf(stderr,"error1\n");
 			rc = -1;
 			goto exit;
 		}
@@ -2894,7 +2893,6 @@ static int write_xen_pirq_rules_to_conf(FILE *out, struct policydb *pdb)
 		ctx = context_to_str(pdb, &pirq->context[0]);
 		if (!ctx) {
 			rc = -1;
-			fprintf(stderr,"error2\n");
 			goto exit;
 		}
 
-- 
2.40.1

