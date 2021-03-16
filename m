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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C740FC433DB
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 16:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899216510D
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 16:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhCPQw0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbhCPQvg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 12:51:36 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB52C06174A
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 09:51:35 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id m186so19284868qke.12
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 09:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/p9zQ7EXfwUekTTr1WZtY52mVFX3vhnt2Gy52+GPgSI=;
        b=K50nQS5ECxbvTOcsvJ6raB5A8Qj+nw69SI2WdjndMUdQstBEyP+b9ul0DusVK+uRlD
         NOo49ZGvyJXcuG40zVUj4N5HmhvxY5gPM+QIShZ2sGJoiQJ1/VleQA4C9+OA7hJCDsKU
         GLosaG9xj89ugqBbiuKFtL9Wqy7bha2uyAwTTtzE5S3CxNtw9ewqO4Ir1KUYwd1vKIgI
         EGBfSBNYoaxa2ayxyLXFBYonAkHTVOcjnKGZm+dcwahiaaKNN/m0ZGH18p3APfeAme8b
         YHPTo7BXav1YJx6T2C9mFWlOfJ6hNjNdeRO0ulDmSvnWVywzM/5PE2MS9Jhwz70LAESA
         7Bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/p9zQ7EXfwUekTTr1WZtY52mVFX3vhnt2Gy52+GPgSI=;
        b=UR4sLF3EbFBiTGl/tpfF71z+KkP08Ol0WRP1PiKuGR16aggIwtXbLxZ3+pcnJWbPcB
         MpYeWDU1lFQeY7pFyl/yJ6BQ8chYvb434NqD1hFwbZp0MKYEV8nzNV2RNZaeH+gqOEh9
         XS5lkwtJQe3nePIOBVHcUdBhUsHTaDRaVTPerd8n9HQhciDhkUtESS/yvSGrwZoEVb76
         GMNcHBVFPtqAW76yosByIl5JYhxJgfEk0Mn7VFrUQ/UsMAoIhx5CO/kKXMJXtW5jR2+i
         85S39+Fn6QAr1cthKrwji9mvEQgizjYRsw/MBq1Nd//XHCUBUATVAewsgKMxQIn4LdPx
         exeg==
X-Gm-Message-State: AOAM531JWjCl3CVSb3yNOX+l5skhNSYqQ+dBj5vkfWz6UHGKPEuM8KYI
        XrOpD5auSXSXSLwj2bYEa9p5e+XT1p8=
X-Google-Smtp-Source: ABdhPJw2AZL3rSZzlVsejJ/bCbi1/WIgW0u+2IH4cYVsMkr8jnaZv6m9iDPW2mTKMyGQsS6WkC3Tpg==
X-Received: by 2002:a37:a28e:: with SMTP id l136mr559134qke.172.1615913494866;
        Tue, 16 Mar 2021 09:51:34 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id x36sm13962790qte.1.2021.03.16.09.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:51:34 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Evgeny Vereshchagin <evvers@ya.ru>
Subject: [PATCH] libsepol/cil: Check for duplicate blocks, optionals, and macros
Date:   Tue, 16 Mar 2021 12:51:31 -0400
Message-Id: <20210316165131.37312-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In CIL, blocks, optionals, and macros share the same symbol table so
that the targets of "in" statements can be located. Because of this,
they cannot have the same name in the same namespace, but, because
they do not show up in the final policy, they can have the same name
as long as they are in different namespaces. Unfortunately, when
copying from one namespace to another, no check was being done to see
if there was a conflict.

When copying blocks, optionals, and macros, if a datum is found in
the destination namespace, then there is a conflict with a previously
declared block, optional, or macro, so exit with an error.

Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Reported-by: Evgeny Vereshchagin <evvers@ya.ru>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_copy_ast.c | 89 +++++++++------------------------
 1 file changed, 25 insertions(+), 64 deletions(-)

diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index c9aada9d..ed967861 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -100,16 +100,17 @@ int cil_copy_block(__attribute__((unused)) struct cil_db *db, void *data, void *
 	struct cil_block *orig = data;
 	char *key = orig->datum.name;
 	struct cil_symtab_datum *datum = NULL;
+	struct cil_block *new;
 
 	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum == NULL) {
-		struct cil_block *new;
-		cil_block_init(&new);
-		*copy = new;
-	} else {
-		*copy = datum;;
+	if (datum != NULL) {
+		cil_tree_log(NODE(datum), CIL_ERR, "Re-declaration of %s %s", cil_node_to_string(NODE(datum)), key);
+		return SEPOL_ERR;
 	}
 
+	cil_block_init(&new);
+	*copy = new;
+
 	return SEPOL_OK;
 }
 
@@ -1509,64 +1510,22 @@ int cil_copy_macro(__attribute__((unused)) struct cil_db *db, void *data, void *
 	struct cil_macro *orig = data;
 	char *key = orig->datum.name;
 	struct cil_symtab_datum *datum = NULL;
+	struct cil_macro *new;
 
 	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum == NULL) {
-		struct cil_macro *new;
-		cil_macro_init(&new);
-		if (orig->params != NULL) {
-			cil_copy_list(orig->params, &new->params);
-		}
-
-		*copy = new;
-
-	} else {
-		struct cil_list_item *curr_orig = NULL;
-		struct cil_list_item *curr_new = NULL;
-		struct cil_param *param_orig = NULL;
-		struct cil_param *param_new = NULL;
-
-		if (((struct cil_macro*)datum)->params != NULL) {
-			curr_new = ((struct cil_macro*)datum)->params->head;
-		}
-
-		if (orig->params != NULL) {
-			curr_orig = orig->params->head;
-		}
-
-		if (curr_orig != NULL && curr_new != NULL) {
-			while (curr_orig != NULL) {
-				if (curr_new == NULL) {
-					goto exit;
-				}
-
-				param_orig = (struct cil_param*)curr_orig->data;
-				param_new = (struct cil_param*)curr_new->data;
-				if (param_orig->str != param_new->str) {
-					goto exit;
-				} else if (param_orig->flavor != param_new->flavor) {
-					goto exit;
-				}
-
-				curr_orig = curr_orig->next;
-				curr_new = curr_new->next;
-			}
-
-			if (curr_new != NULL) {
-				goto exit;
-			}
-		} else if (!(curr_orig == NULL && curr_new == NULL)) {
-			goto exit;
-		}
+	if (datum != NULL) {
+		cil_tree_log(NODE(datum), CIL_ERR, "Re-declaration of %s %s", cil_node_to_string(NODE(datum)), key);
+		return SEPOL_ERR;
+	}
 
-		*copy = datum;
+	cil_macro_init(&new);
+	if (orig->params != NULL) {
+		cil_copy_list(orig->params, &new->params);
 	}
 
-	return SEPOL_OK;
+	*copy = new;
 
-exit:
-	cil_log(CIL_INFO, "cil_copy_macro: macro cannot be redefined\n");
-	return SEPOL_ERR;
+	return SEPOL_OK;
 }
 
 int cil_copy_optional(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
@@ -1574,16 +1533,17 @@ int cil_copy_optional(__attribute__((unused)) struct cil_db *db, void *data, voi
 	struct cil_optional *orig = data;
 	char *key = orig->datum.name;
 	struct cil_symtab_datum *datum = NULL;
+	struct cil_optional *new;
 
 	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum == NULL) {
-		struct cil_optional *new;
-		cil_optional_init(&new);
-		*copy = new;
-	} else {
-		*copy = datum;
+	if (datum != NULL) {
+		cil_tree_log(NODE(datum), CIL_ERR, "Re-declaration of %s %s", cil_node_to_string(NODE(datum)), key);
+		return SEPOL_ERR;
 	}
 
+	cil_optional_init(&new);
+	*copy = new;
+
 	return SEPOL_OK;
 }
 
@@ -2122,6 +2082,7 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
 			args->dest = new;
 		}
 	} else {
+		cil_tree_log(orig, CIL_ERR, "Problem copying %s node", cil_node_to_string(orig));
 		goto exit;
 	}
 
-- 
2.26.2

