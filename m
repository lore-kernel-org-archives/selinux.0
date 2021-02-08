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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C828C433E6
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 16:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C8C64E8A
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 16:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbhBHQYm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Feb 2021 11:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbhBHQYf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Feb 2021 11:24:35 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9BAC061786
        for <selinux@vger.kernel.org>; Mon,  8 Feb 2021 08:23:55 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id v19so2427882qvl.7
        for <selinux@vger.kernel.org>; Mon, 08 Feb 2021 08:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnXmfHDgxE9U/TZJigWS4aRSpH0dOH6y07K6hSA/L7c=;
        b=Hdniu98RHKzSI1bBecHrJj+xJsQkDXWrRWIBvdbmXCn79XP1z645C25uh1B3YPrVJe
         4X6ibBQ2h3Hm2EpwwY4Y8xv2JoCcDjqjuELZIpOWehq4VDwp3vwQ5c2nE3B4ePxFUpPY
         Jz/ZVUYX/CZ6SzkwLw0Q9FJnhNd8tGBt7DXb12IIlZ9QcY5n52lADSkewFKZKStCsxy9
         yPLBLFAqsBWpPQTsvDhPTMA1XtiOO0qdpZjL2X68aqlfyuSweEDLKyDIpeTa9/p++jtL
         CGtxL2yybeOgTRLsYJllKX7I4kGs+jPoTOYb8/K267XzB7VDYbEcVUx8TdRQ9bmQ90Ss
         T/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnXmfHDgxE9U/TZJigWS4aRSpH0dOH6y07K6hSA/L7c=;
        b=bJZoA8aAFbJ42sjF9cMWYw/qsWAwqGmtInbwIcOEUenc3ayFgwRtit1a0bFUyr8kEE
         dpm4HsgfKtqKFQFfLEuez7GcuziOT2R+XBrKD96R71wfvSrmhXqlK6GmUkdUgrc3eDdb
         u8VcSNxFVTl2HfXm5OWwyWScggTEyNwd97ywiT9kCg9hpmU3xoaS8gn4vCjl0W8afVcg
         PCoeBZUyckwdQ5TJRsvK4oPJ6MdjaB8rMsyyvlfP8OkVhdRgRIlgDbMREO2K4DVHNL9l
         GkT8/wov3ZUiwRKVduXm5+HRAewiejeuawbjLMTc1uuY549RILzB/HZ7knMMCe8qWDJG
         Tvcg==
X-Gm-Message-State: AOAM533gXDJ1zY+Cccgo8cyho838NZ9xmzBHJ7cTOwzsXYJODzntyOk9
        WN+6VtvGqo74r6v2crU5KiUUjP6WKcho2Q==
X-Google-Smtp-Source: ABdhPJxubncjsX7CmF44uhnZYRUQVMftOGtjDp7OSFP2Vkuiegb/EkZ7RQMJ/qjWZ57XzsUCj6HXcQ==
X-Received: by 2002:a0c:eb49:: with SMTP id c9mr16787897qvq.37.1612801434460;
        Mon, 08 Feb 2021 08:23:54 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id x7sm9009046qtv.58.2021.02.08.08.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 08:23:53 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Destroy disabled optional blocks after pass is complete
Date:   Mon,  8 Feb 2021 11:23:42 -0500
Message-Id: <20210208162342.410262-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss reports:
  I am continuing to investigate OSS-Fuzz crashes and the following one
  is quite complex. Here is a CIL policy which triggers a
  heap-use-after-free error in the CIL compiler:

  (class CLASS (PERM2))
  (classorder (CLASS))
  (classpermission CLSPRM)
  (optional o
      (mlsvalidatetrans x (domby l1 h1))
      (common CLSCOMMON (PERM1))
      (classcommon CLASS CLSCOMMON)
  )
  (classpermissionset CLSPRM (CLASS (PERM1)))

  The issue is that the mlsvalidatetrans fails to resolve in pass
  CIL_PASS_MISC3, which comes after the resolution of classcommon (in
  pass CIL_PASS_MISC2). So:

  * In pass CIL_PASS_MISC2, the optional block still exists, the
  classcommon is resolved and class CLASS is linked with common
  CLSCOMMON.
  * In pass CIL_PASS_MISC3, the optional block is destroyed, including
  the common CLSCOMMON.
  * When classpermissionset is resolved, function cil_resolve_classperms
  uses "common_symtab = &class->common->perms;", which has been freed.
  The use-after-free issue occurs in __cil_resolve_perms (in
  libsepol/cil/src/cil_resolve_ast.c):

    // common_symtab was freed
    rc = cil_symtab_get_datum(common_symtab, curr->data, &perm_datum);

The fundamental problem here is that when the optional block is
disabled it is immediately destroyed in the middle of the pass, so
the class has not been reset and still refers to the now destroyed
common when the classpermissionset is resolved later in the same pass.

Added a list, disabled_optionals, to struct cil_args_resolve which is
passed when resolving the tree. When optionals are disabled, they are
now added to this list and then are destroyed after the tree has been
reset between passes.

Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 0c85eabe..49a5d139 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -51,6 +51,7 @@ struct cil_args_resolve {
 	struct cil_db *db;
 	enum cil_pass pass;
 	uint32_t *changed;
+	struct cil_list *disabled_optionals;
 	struct cil_tree_node *optstack;
 	struct cil_tree_node *boolif;
 	struct cil_tree_node *macro;
@@ -3863,7 +3864,7 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
 
 		if (((struct cil_optional *)parent->data)->enabled == CIL_FALSE) {
 			*(args->changed) = CIL_TRUE;
-			cil_tree_children_destroy(parent);
+			cil_list_append(args->disabled_optionals, CIL_NODE, parent);
 		}
 
 		/* pop off the stack */
@@ -3926,6 +3927,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 	extra_args.in_list = NULL;
 	extra_args.blockstack = NULL;
 
+	cil_list_init(&extra_args.disabled_optionals, CIL_NODE);
 	cil_list_init(&extra_args.sidorder_lists, CIL_LIST_ITEM);
 	cil_list_init(&extra_args.classorder_lists, CIL_LIST_ITEM);
 	cil_list_init(&extra_args.unordered_classorder_lists, CIL_LIST_ITEM);
@@ -3993,6 +3995,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 		}
 
 		if (changed && (pass > CIL_PASS_CALL1)) {
+			struct cil_list_item *item;
 			/* Need to re-resolve because an optional was disabled that contained
 			 * one or more declarations. We only need to reset to the call1 pass 
 			 * because things done in the preceding passes aren't allowed in 
@@ -4021,6 +4024,11 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 				cil_log(CIL_ERR, "Failed to reset declarations\n");
 				goto exit;
 			}
+			cil_list_for_each(item, extra_args.disabled_optionals) {
+				cil_tree_children_destroy(item->data);
+			}
+			cil_list_destroy(&extra_args.disabled_optionals, CIL_FALSE);
+			cil_list_init(&extra_args.disabled_optionals, CIL_NODE);
 		}
 
 		/* reset the arguments */
@@ -4049,6 +4057,7 @@ exit:
 	__cil_ordered_lists_destroy(&extra_args.catorder_lists);
 	__cil_ordered_lists_destroy(&extra_args.sensitivityorder_lists);
 	__cil_ordered_lists_destroy(&extra_args.unordered_classorder_lists);
+	cil_list_destroy(&extra_args.disabled_optionals, CIL_FALSE);
 	cil_list_destroy(&extra_args.in_list, CIL_FALSE);
 
 	return rc;
-- 
2.26.2

