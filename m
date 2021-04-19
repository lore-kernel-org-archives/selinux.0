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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B88C43460
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA6861007
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbhDSPQ5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbhDSPQx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 11:16:53 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812CAC06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:23 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o5so36134587qkb.0
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNVjxbwsKrqwRb8jBBJOfCRPJrEs0SiZcbQRvn8IZOU=;
        b=GrKzMU6AsvWpjqvixiJdXiAb7LsATq/amo1dt40TEkTFHCCTQqGDKYWPZSvRV0VCwJ
         V6pSL8uXuf7NsXwzhvYQLNXLVzHQgU54pcPR7rEonrS+Qmzk/gisVXuvjyOgbVFT8Drs
         aD4SYq4ql/MlZZd9H+FYGYyqTpNg5ZbBUlZwW+FckQLgxkk7ShYJqtSFBoimMVKBZbhR
         tXUmM4uoqsYaeSNtC5hRd0Oz4344GiZ3jqj+u8N7ysYZyGb7Ga2Mzu5xpJL+Sj8AexuP
         pl6CRVAmsWKfQeOwE+Rh+V+0skytFcoMvJseIwRm9fCmPxWBbTolwcaj1e/fUtkIkDer
         R9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNVjxbwsKrqwRb8jBBJOfCRPJrEs0SiZcbQRvn8IZOU=;
        b=DwbnXn97DLL/kMwYPs5FFQhLFxK0XzvOb4kx4dnUry/rtjwk+rf6EsKC8XzDqr6pCz
         IMnG9w1jVZBxcdbfCJElJzc9CiVKgGUrXkxTwhd6U7iGelIvSdwkuvosl72+u5hoITYc
         1nzHrI52qqy5gN95vXafY6Dbt60qHQgRikppe90K7qapCDD0r3pYk5t7AtXVWDWAKgdW
         w783bE21kCxmCToMPIKKTJkH007xguBTQLek7C3PXpL7XcqddPxQRGELfE6YdIfbEeEm
         LBlWjW0/O+v02ZSFQbEPuxHi3WbmItJmWsjLBOJek1PiUO2cRFgHqxkpPQd63qgYOdrn
         kn+g==
X-Gm-Message-State: AOAM5315o79f/hv7rVh4N3SXCfoP2LBUcmoajd6EUlS2WPYmfeviLQIC
        eQjKVGzvvVnSdGRt/5kt1rzcs4FFAA6eww==
X-Google-Smtp-Source: ABdhPJxO26o82rQAcYrvvAt4bc9hM6FcWTtnbcjBZcE6u65RPZ7KjcOsJRUfUUloow/BVH3DYugtZA==
X-Received: by 2002:a37:7685:: with SMTP id r127mr11997334qkc.359.1618845382641;
        Mon, 19 Apr 2021 08:16:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d68sm9840584qkf.93.2021.04.19.08.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:16:22 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 08/11 v2] libsepol/cil: Allow permission expressions when using map classes
Date:   Mon, 19 Apr 2021 11:15:54 -0400
Message-Id: <20210419151557.87561-9-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210419151557.87561-1-jwcart2@gmail.com>
References: <20210419151557.87561-1-jwcart2@gmail.com>
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
index fd4758dc..05842b64 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -2137,6 +2137,10 @@ static int __evaluate_classperms_list(struct cil_list *classperms, struct cil_db
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
2.26.3

