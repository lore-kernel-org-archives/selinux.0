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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B5CC433EA
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 16:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29AB61998
	for <selinux@archiver.kernel.org>; Mon, 22 Mar 2021 16:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhCVQrY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhCVQrJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Mar 2021 12:47:09 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347AEC061574
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 09:47:09 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r14so12811481qtt.7
        for <selinux@vger.kernel.org>; Mon, 22 Mar 2021 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2ZTiqFfxa9/9i99WHWkJ3orKJFSRIjNhM0k6RaTL+o=;
        b=BRuOfbAdgINGU8SaeSvum26dQWL8fCr6zryg8J0+dNfAQpBBUwBKUPSnxpFMdOE5oq
         n9n8WXdDX2Ex0C9fbTq76S93O3OlErnpxf4vt5gb6bmr+PPXuMA/0nvkrK2AzLJ02oEw
         SGwizCQffVfgWrZwUDfX+wNZ46p4V/5unNsDiZ1UJtbkAAtIoNiv9Kg4vGzUN4imEzIY
         rZsBxd8s/2MELEZb4YUpl5ITHlJOf0J4COgsctpBq0D2XFgkXfFdBA3VBt6Fn+L3BqY9
         fA+wQr+VP61kMyHVeD2+fPFS9Esf97F75JfX85BN7CkMvjClAX94vnF1PX3ZznUYjD7t
         5+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2ZTiqFfxa9/9i99WHWkJ3orKJFSRIjNhM0k6RaTL+o=;
        b=bMVdgHG8aOje0EOjLzvBKuj0e0QMOL1p3vMbq2w7pj4tJSnbi1QbfDPa4AanSIn5Vh
         rJX7D3sG4+ko/aw7Ns5TV5g18NyPwU7YEkShem2UPNErx/oXIP7m4MU3lIU++/XRSE4V
         2dPTaC4sqWH/dBBYQSobLCfydFzBmYA3BWZJW7U4y5N3VoD8JGNXYqsup7RVkKQa/CV9
         hZnXFUHIp1ZFeDTmyynRaCy2oaQTjEEnvq/s7K4Z/34nUSshitLWmM74n688PrLXhJAz
         rL/OvxvVfYelvg/g1CCu5rGe60AydMv5dvR2VACxSqyLOzjMHLslKBOVq39x8FA3rcyi
         6eTg==
X-Gm-Message-State: AOAM530j0uhTKBCmvDS2ZtU1Mss30O5TkmtCo5y2XjoVrCG5xmLhd4kS
        iK75Lb5s+WMi5NuMmyiIDfQT5P+cZEl+6w==
X-Google-Smtp-Source: ABdhPJzoGsZhz4NCRNo014fbLSkSEeBJa7qwtjvPTt7+XuR1FyFQJ3hZ14LOM3Q6XGg/uFpKFyniJg==
X-Received: by 2002:ac8:7c8d:: with SMTP id y13mr742958qtv.294.1616431627458;
        Mon, 22 Mar 2021 09:47:07 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id f9sm10964106qkk.115.2021.03.22.09.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:47:05 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Allow permission expressions when using map classes
Date:   Mon, 22 Mar 2021 12:47:00 -0400
Message-Id: <20210322164703.29564-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The following policy will cause a segfault:
  (class CLASS (PERM))
  (class C (P1 P2 P3))
  (classorder (CLASS C))
  (sid SID)
  (sidorder (SID))
  (user USER)
  (role ROLE)
  (type TYPE)
  (category CAT)
  (categoryorder (CAT))
  (sensitivity SENS)
  (sensitivityorder (SENS))
  (sensitivitycategory SENS (CAT))
  (allow TYPE self (CLASS (PERM)))
  (roletype ROLE TYPE)
  (userrole USER ROLE)
  (userlevel USER (SENS))
  (userrange USER ((SENS)(SENS (CAT))))
  (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))

  (classmap CM (PM1 PM2 PM3))
  (classmapping CM PM1 (C (P1)))
  (classmapping CM PM2 (C (P2)))
  (classmapping CM PM3 (C (P3)))
  (allow TYPE self (CM (and (all) (not PM2))))

The problem is that, while permission expressions are allowed for
normal classes, map classes are expected to only have permission
lists and no check is done to verify that only a permission list
is being used.

When the above policy is parsed, the "and" and "all" are seen as
expression operators, but when the map permissions are converted to
normal class and permissions, the permission expression is assumed
to be a list of datums and since the operators are not datums a
segfault is the result.

There is no reason to limit map classes to only using a list of
permissions and, in fact, it would be better to be able to use them
in the same way normal classes are used.

Allow permissions expressions to be used for map classes by first
evaluating the permission expression and then converting the
resulting list to normal classes and permissions.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_post.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index d2ecbd43..6990fc07 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -2130,6 +2130,10 @@ static int __evaluate_classperms_list(struct cil_list *classperms, struct cil_db
 				}
 			} else { /* MAP */
 				struct cil_list_item *i = NULL;
+				rc = __evaluate_classperms(cp, db);
+				if (rc != SEPOL_OK) {
+					goto exit;
+				}				
 				cil_list_for_each(i, cp->perms) {
 					struct cil_perm *cmp = i->data;
 					rc = __evaluate_classperms_list(cmp->classperms, db);
-- 
2.26.2

