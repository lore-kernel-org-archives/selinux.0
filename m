Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4203C433ED
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 20:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C26061376
	for <selinux@archiver.kernel.org>; Tue, 11 May 2021 20:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhEKUEU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 May 2021 16:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhEKUEU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 May 2021 16:04:20 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A89C06175F
        for <selinux@vger.kernel.org>; Tue, 11 May 2021 13:03:13 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id f8so11406318qth.6
        for <selinux@vger.kernel.org>; Tue, 11 May 2021 13:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6sTiAwv2m1hvS3tWmgbGDvK+yUsIAboN9EEOmEZL710=;
        b=iRfRnyOVO52pFy6+0IVQeS6VTVWX93JQbwce4fuiwbxvzS3OTixTqKxydQfKloSVPJ
         xIfNFhkUS/5ymned6pYtOUK6QGeos2SAs8GEqOTfcZ3/9ALNHJoSQRQThYnT3GbO7DHh
         D/k61eYgSGHcD1OBBtO3Gw6dbo1RoXQVvaDtMUr58YXEJWLN93Itxx+3uwr6J0naqw0c
         nr9TrdbaYDxzGroU0jlD6jcyXgJ0rBME1xtxAJx0VXL5EupEaT0+y4kNzjK46C4AXFQZ
         HhGeiWbf/kHGGI2lsBjkxHinUJhMsvrF5UYsu0MwoPksdMkNzKqSoxEllaS92Xe6n52R
         GiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6sTiAwv2m1hvS3tWmgbGDvK+yUsIAboN9EEOmEZL710=;
        b=L6bCViCUEXEIfABGQxRkcCcby5eapA0oEbBQO/dN7YQu2VMYJhH943S021uQ5x6SxC
         Riiax/8ePdpdHxXW0sy2EjzCTx2ho/RiK0oJV8LgdFJEE6833qJhn5By0ol830SEQ16S
         64xnZR1ZWjfChFfsXzJUUmh5iOsrYjN/ENzrxbqnGvH79mphaDah+CUUoxoU0vyUNw0s
         793iJipngCqfKaAvqeu006FV9sBFTBAAqYah3w3jKNTll5KP5i04F8rg40oC2I49z4Zd
         P2lvIGAlR6y2gI8ICR2kCVAEd81+LOI+LohbMLNzGt53RUFqKtz1dH9DbivAS/inIMXT
         BrKg==
X-Gm-Message-State: AOAM530cDDjEKxlAQWmKQNnS41Uh+54yZfCMrS+AtrPUIZSQxLyShNeI
        Js4wIrK/sJyLaAFOHECGyb+8/Lf84CDNmA==
X-Google-Smtp-Source: ABdhPJw6+riWyM6eiZULmAPAISks18AVXmcQG8UF5beVY7onwFy4KrCyhaQqvU4qObFuVJddj5rumw==
X-Received: by 2002:ac8:6c22:: with SMTP id k2mr28890627qtu.303.1620763392306;
        Tue, 11 May 2021 13:03:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id z9sm4642533qtf.10.2021.05.11.13.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:03:11 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/5 v2] libsepol/cil: Make name resolution in macros work as documented
Date:   Tue, 11 May 2021 16:02:57 -0400
Message-Id: <20210511200301.407855-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210511200301.407855-1-jwcart2@gmail.com>
References: <20210511200301.407855-1-jwcart2@gmail.com>
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

