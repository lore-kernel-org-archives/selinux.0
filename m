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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72106C433B4
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 17:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0FE61469
	for <selinux@archiver.kernel.org>; Fri,  7 May 2021 17:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhEGRit (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 May 2021 13:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhEGRis (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 May 2021 13:38:48 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D4CC061574
        for <selinux@vger.kernel.org>; Fri,  7 May 2021 10:37:48 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id o5so9291033qkb.0
        for <selinux@vger.kernel.org>; Fri, 07 May 2021 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6sTiAwv2m1hvS3tWmgbGDvK+yUsIAboN9EEOmEZL710=;
        b=ou2qT7gQIHFJN2/7O/5VPZ6IIpk1xa9Re9HMSrZC0KxtUkyxm3LkQsnuFGSWcqbcql
         ggRD189a8MYYtmvc/vQ/odvlhZ3PSPeKVyFUacGLeBtj75XmF/mk52bCvg3l4+Q9r6/m
         ccfYl8S+s+YjSBjkYXD/wVioQVTzk+bW+9wPNjwkM3uUKV76YrCNOl/kcnnJfzq9PMVi
         yeS57l6VQZGUx+VQMLw949DxBsMOl/8vOIsOs9mjXLSf0kYjdYM8Yef9oZQFzvHr+/Cd
         A22Ivh8k5u1dJubmTCC5UVszsCYT08xIphmia3dtlbQgCLWyPkKAwUVGwwbWLW09pAXD
         pcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6sTiAwv2m1hvS3tWmgbGDvK+yUsIAboN9EEOmEZL710=;
        b=CYfByrnXYzOYIgJAKeFpOjBYB3Os2F6L4dNQk/lItJzrt2nF9dOvIlIEAVajS1Bwsc
         7xzQNqaMZlZE36dH7HALnHmS1zXCULQyPW8c6e7eT4EIPxuGNCSdt7mulF11+NpWuP4H
         TS0d0vxGWS9QKXdz49jMvcsE0qfhJhmLU3+VMo0KJ7Oe4rxbkMxj0e+ks9beHZj0iBWw
         teXCGtPuh7+AIna3/MnkRDMDV9VtQVc4gI4vSnQyA1vnayiWL2vmNPMc7RY2CeEONfF9
         vQdE0NTve6DjMIEgR8orh613AJ6uwVsLYPx8+sBpefdv4FU2RjY4aG/UDfSCR0CwrU+O
         ptOQ==
X-Gm-Message-State: AOAM532jidJKuPvADoFzKiUgWogbEs27WgFDvR14k+v2zjRl/zaZCPc4
        HiKsJMBQuxrHw90AXb1EZQDLcRfDErfxfg==
X-Google-Smtp-Source: ABdhPJzmqq2Ds5ccxvQs5Z5cNFTFxd3kyh952jKFxmzp2BQxhwL5CG6qPTIJAHtR6A33dddbkPHB8g==
X-Received: by 2002:a37:de16:: with SMTP id h22mr10734971qkj.351.1620409068113;
        Fri, 07 May 2021 10:37:48 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id f26sm5386475qtg.17.2021.05.07.10.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 10:37:47 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3] libsepol/cil: Make name resolution in macros work as documented
Date:   Fri,  7 May 2021 13:37:42 -0400
Message-Id: <20210507173744.198858-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The CIL Reference Guide specifies how name resolution is suppose
to work within an expanded macro.
  1. Items defined inside the macro
  2. Items passed into the macro as arguments
  3. Items defined in the same namespace of the macro
  4. Items defined in the caller's namespace
  5. Items defined in the global namespace

But Lorenzo Ceragioli <lorenzo.ceragioli@phd.unipi.it> found
that the first step is not done.

So the following policy:
  (block A
    (type a)
    (macro m ()
      (type a)
      (allow a self (CLASS (PERM)))
    )
  )
  (block B
    (call A.m)
  )
will result in:
  (allow A.a self (CLASS (PERM)))
instead of the expected:
  (allow B.a self (CLASS (PERM)))

Now when an expanded call is found, the macro's namespace is
checked first. If the name is found, then the name was declared
in the macro and it is declared in the expanded call, so only the
namespace of the call up to and including the global namespace
will be searched. If the name is not found in the macro's namespace
then name resolution continues with steps 2-5 above.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index f251ed15..bbe86e22 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -4224,10 +4224,18 @@ static int __cil_resolve_name_with_parents(struct cil_tree_node *node, char *nam
 			break;
 		case CIL_CALL: {
 			struct cil_call *call = node->data;
-			rc = cil_resolve_name_call_args(call, name, sym_index, datum);
-			if (rc != SEPOL_OK) {
-				/* Continue search in macro's parent */
-				rc = __cil_resolve_name_with_parents(NODE(call->macro)->parent, name, sym_index, datum);
+			struct cil_macro *macro = call->macro;
+			symtab = &macro->symtab[sym_index];
+			rc = cil_symtab_get_datum(symtab, name, datum);
+			if (rc == SEPOL_OK) {
+				/* If the name was declared in the macro, just look on the call side */
+				rc = SEPOL_ERR;
+			} else {
+				rc = cil_resolve_name_call_args(call, name, sym_index, datum);
+				if (rc != SEPOL_OK) {
+					/* Continue search in macro's parent */
+					rc = __cil_resolve_name_with_parents(NODE(call->macro)->parent, name, sym_index, datum);
+				}
 			}
 		}
 			break;
-- 
2.26.3

