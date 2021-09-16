Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD53C433EF
	for <selinux@archiver.kernel.org>; Thu, 16 Sep 2021 20:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84EE60FBF
	for <selinux@archiver.kernel.org>; Thu, 16 Sep 2021 20:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhIPUa3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Sep 2021 16:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhIPUa2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Sep 2021 16:30:28 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50261C061574
        for <selinux@vger.kernel.org>; Thu, 16 Sep 2021 13:29:07 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id s15so6769232qta.10
        for <selinux@vger.kernel.org>; Thu, 16 Sep 2021 13:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VlffJO7/GZKVv1zcXAh2oqtlwJf6ik+d398CSaDNNT4=;
        b=KzM9z7PFvNi8UYAJfz2nQgcpSBG50+yMcz7IkDTyJI7i0tUVOwZEvXQrZm6bLRAnr9
         bTzr58EbNWdGabJFPumUlTP31QkCFfD7wfd1cPgK5ISXcfYxXPwV1yO5ZstCfBmQHUS+
         PP0kmIsrYk4/oXYss02wEgoeW6/hyrPOPSdX1dvFOKz2hFGXNX0WXFVqg6l0LcN8bdGo
         2JnxN3LfLWCfs+COUf07/CbNyEW2SotmDLe9aqL79BzRDonK224U/D8nftl2Nb//qshu
         e7lOnSsjyBbhuyvEXjwPV2IEd6ScC3K5oazkeV+Tn019SOu+jiFsYMnw/JN2QpcyhbbE
         wE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VlffJO7/GZKVv1zcXAh2oqtlwJf6ik+d398CSaDNNT4=;
        b=juRx6POCABvQskzvoHlYNZAtGuf18TgY0F/3uMi8nbMRrRtK06en5+LN8eXO8aspeq
         O1ivBJRKdFddCwvc2NsggfTfU+Tu+kChcU4OsOmoSaL8yhuBH9MyXozHM0T4fv/cq4YC
         d6XAy5fN8hYRmpdBMaoq6recMP+R2/cEv4wMnpS8BjVOi3rmMOKX2iMIKBZknEdYnzn9
         XzPs2fHc/C58VsvqZYRYsTn6HJ+OwImJTwdWrh/mm4jf41UE65W9I4YkzOMBvzo5zz5r
         wTi9TXKtunTzQgc/4MIw7bNjL2pm0hofhpqJevYzPlggq7JKcVjOe0fnGLr0upFPItpQ
         2Xag==
X-Gm-Message-State: AOAM532v+3ITe8Mkoy6v6F4cjPVyfDda5Lkd6ayia91NlBG2BBymY2Iq
        nn3/DyH8rYOiIe0OXpx9DzG4JhDkuE0=
X-Google-Smtp-Source: ABdhPJxBk/qD0dDdbfklLoxzoG0JNRi8iw6aTH4OAild0PDQFSpzo7P0+DTzbH8D8g+Agae2jbS2+g==
X-Received: by 2002:ac8:3b51:: with SMTP id r17mr6995833qtf.139.1631824146247;
        Thu, 16 Sep 2021 13:29:06 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id c10sm2927472qtb.20.2021.09.16.13.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:29:05 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Handle operations in a class mapping when verifying
Date:   Thu, 16 Sep 2021 16:29:00 -0400
Message-Id: <20210916202900.1157917-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When checking for circular class permission declarations and a class
mapping is encountered, the class permissions for each map permission
must be checked. An assumption was made that there were no operators
in the class permissions. An operator in the class permissions would
cause a segfault.

Example causing segault:
  (classmap cm1 (mp1))
  (classmapping cm1 mp1 (CLASS (PERM)))
  (classpermission cp1)
  (classpermissionset cp1 (cm1 (all)))

For map class permissions, check each item in the permission list to
see if it is an operator. If it is not, then verify the class
permissions associated with the map permission. If it is an operator
and the operator is "all", then create a list of all permissions for
that map class and verify the class permissions associated with each
map permission. If it is a different operator, then it can be skipped.

This bug was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_verify.c | 40 ++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 5502c4d5..dc29ea66 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1689,6 +1689,15 @@ exit:
 	return rc;
 }
 
+static int __add_perm_to_list(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
+{
+	struct cil_list *perm_list = (struct cil_list *)args;
+
+	cil_list_append(perm_list, CIL_DATUM, d);
+
+	return SEPOL_OK;
+}
+
 static int __cil_verify_classperms(struct cil_list *classperms,
 				   struct cil_symtab_datum *orig,
 				   struct cil_symtab_datum *parent,
@@ -1730,13 +1739,34 @@ static int __cil_verify_classperms(struct cil_list *classperms,
 			if (FLAVOR(cp->class) != CIL_CLASS) { /* MAP */
 				struct cil_list_item *i = NULL;
 				cil_list_for_each(i, cp->perms) {
-					struct cil_perm *cmp = i->data;
-					rc = __cil_verify_classperms(cmp->classperms, orig, &cp->class->datum, &cmp->datum, CIL_MAP_PERM, steps, limit);
-					if (rc != SEPOL_OK) {
-						goto exit;
+					if (i->flavor != CIL_OP) {
+						struct cil_perm *cmp = i->data;
+						rc = __cil_verify_classperms(cmp->classperms, orig, &cp->class->datum, &cmp->datum, CIL_MAP_PERM, steps, limit);
+						if (rc != SEPOL_OK) {
+							goto exit;
+						}
+					} else {
+						enum cil_flavor op = (enum cil_flavor)i->data;
+						if (op == CIL_ALL) {
+							struct cil_class *mc = cp->class;
+							struct cil_list *perm_list;
+							struct cil_list_item *j = NULL;
+
+							cil_list_init(&perm_list, CIL_MAP_PERM);
+							cil_symtab_map(&mc->perms, __add_perm_to_list, perm_list);
+							cil_list_for_each(j, perm_list) {
+								struct cil_perm *cmp = j->data;
+								rc = __cil_verify_classperms(cmp->classperms, orig, &cp->class->datum, &cmp->datum, CIL_MAP_PERM, steps, limit);
+								if (rc != SEPOL_OK) {
+									cil_list_destroy(&perm_list, CIL_FALSE);
+									goto exit;
+								}
+							}
+							cil_list_destroy(&perm_list, CIL_FALSE);
+						}
 					}
 				}
-			}	
+			}
 		} else { /* SET */
 			struct cil_classperms_set *cp_set = curr->data;
 			struct cil_classpermission *cp = cp_set->set;
-- 
2.31.1

