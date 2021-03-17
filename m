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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DD4C43331
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 19:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237C664F5E
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 19:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhCQTAX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Mar 2021 15:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhCQTAI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Mar 2021 15:00:08 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193ECC06174A
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 12:00:08 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id 73so2211136qtg.13
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/eyXo5/AXt68vDrIptMQQy+zPWF47nPL4n//7APaJYw=;
        b=H4ucaoKg7siR5PFYhQE+KisT+FHW7x2ciwTI3WxYrxN+jTM/85aAB70Dyyg47QFlIk
         bCL35b5TzSdtg+IarZmKrd2NtA6os9rHOIVdvI1E6ZHyBrQZGfyPO5lxAXxv6KIGiJ4R
         AfXgUmfGZ8+3iTG7GGmU6nonwIoeaBT1FjVGTRb3qSXQCouNfuwSaGaHvHoO3LLtCP7w
         ql9bbro4nKJMNtle4ngeKffw24YvK95T/YG/Mm3982usxLxzTQJnG3+jSGtcH6w6cilr
         3r8m0PO0DGw1bMY3bhdnUt6Ra6c8w8llg3gMLry8nq/GmWZsxvfAT9A+cGGh5xmTgyKU
         olAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/eyXo5/AXt68vDrIptMQQy+zPWF47nPL4n//7APaJYw=;
        b=N1jZVIfCbmHoLxyuj+9j7JvgJW6ZI9P5ZFdcb/cruTXrcoAbZTkAFn5M5HPVmIpJmC
         Nu/lm4SE1lW9hzhLk5upvrQV4+Cc0o75qD0N6kKPPcXzmQDixd5NzyS+mScevCfl9rSV
         p5CvL9zczGoFeaPntW0MUFvDyntEe3Tb6GINmEeSNtcegHApR2HFvGNDxmQTRSPu5pVx
         04IWBOb64SPDufZh6E1f4T6FvQuajzoSnID1qIGikhUmqFPsczTo8Ekv1w+5af1S3765
         GPydW/CD3HQzdOqT4+jPjnVG6eQZ122moqgN97reSSGGuWazr7fCa6SiTI3PGY6lubA0
         MdXQ==
X-Gm-Message-State: AOAM532XW8lUtQnpatC/02zPJJFryeYArFrZ6j64S72w8pKVtYLud/pv
        iXRApj89o4snxKBpO9Dafrszr15lOtM=
X-Google-Smtp-Source: ABdhPJyh8QLw6/z+CZFgapSmWLHJh8UplIRnRzNw7ehxwCDujXzDK2Hlz2y0WcOcb3kQAsGTxU0Qnw==
X-Received: by 2002:ac8:6746:: with SMTP id n6mr496528qtp.236.1616007607146;
        Wed, 17 Mar 2021 12:00:07 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d84sm18222873qke.53.2021.03.17.12.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 12:00:06 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: [PATCH] libsepol/cil: Destroy classperms list when resetting classpermission
Date:   Wed, 17 Mar 2021 15:00:02 -0400
Message-Id: <20210317190002.81465-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss reports:
  A few months ago, OSS-Fuzz found a crash in the CIL compiler, which
  got reported as
  https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28648 (the title
  is misleading, or is caused by another issue that conflicts with the
  one I report in this message). Here is a minimized CIL policy which
  reproduces the issue:

  (class CLASS (PERM))
  (classorder (CLASS))
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

  (classpermission CLAPERM)

  (optional OPT
      (roletype nonexistingrole nonexistingtype)
      (classpermissionset CLAPERM (CLASS (PERM)))
  )

  The CIL policy fuzzer (which mimics secilc built with clang Address
  Sanitizer) reports:

  ==36541==ERROR: AddressSanitizer: heap-use-after-free on address
  0x603000004f98 at pc 0x56445134c842 bp 0x7ffe2a256590 sp
  0x7ffe2a256588
  READ of size 8 at 0x603000004f98 thread T0
      #0 0x56445134c841 in __cil_verify_classperms
  /selinux/libsepol/src/../cil/src/cil_verify.c:1620:8
      #1 0x56445134a43e in __cil_verify_classpermission
  /selinux/libsepol/src/../cil/src/cil_verify.c:1650:9
      #2 0x56445134a43e in __cil_pre_verify_helper
  /selinux/libsepol/src/../cil/src/cil_verify.c:1715:8
      #3 0x5644513225ac in cil_tree_walk_core
  /selinux/libsepol/src/../cil/src/cil_tree.c:272:9
      #4 0x564451322ab1 in cil_tree_walk
  /selinux/libsepol/src/../cil/src/cil_tree.c:316:7
      #5 0x5644513226af in cil_tree_walk_core
  /selinux/libsepol/src/../cil/src/cil_tree.c:284:9
      #6 0x564451322ab1 in cil_tree_walk
  /selinux/libsepol/src/../cil/src/cil_tree.c:316:7
      #7 0x5644512b88fd in cil_pre_verify
  /selinux/libsepol/src/../cil/src/cil_post.c:2510:7
      #8 0x5644512b88fd in cil_post_process
  /selinux/libsepol/src/../cil/src/cil_post.c:2524:7
      #9 0x5644511856ff in cil_compile
  /selinux/libsepol/src/../cil/src/cil.c:564:7

The classperms list of a classpermission rule is created and filled
in when classpermissionset rules are processed, so it doesn't own any
part of the list and shouldn't retain any of it when it is reset.

Destroy the classperms list (without destroying the data in it)  when
resetting a classpermission rule.

Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_reset_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 3da1b9a6..db70a535 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -54,7 +54,7 @@ static void cil_reset_classpermission(struct cil_classpermission *cp)
 		return;
 	}
 
-	cil_reset_classperms_list(cp->classperms);
+	cil_list_destroy(&cp->classperms, CIL_FALSE);
 }
 
 static void cil_reset_classperms_set(struct cil_classperms_set *cp_set)
-- 
2.26.2

