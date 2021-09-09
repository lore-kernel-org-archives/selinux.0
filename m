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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B97C433EF
	for <selinux@archiver.kernel.org>; Thu,  9 Sep 2021 21:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F035E6103E
	for <selinux@archiver.kernel.org>; Thu,  9 Sep 2021 21:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbhIIV3Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Sep 2021 17:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347274AbhIIV3P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Sep 2021 17:29:15 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94F7C061574
        for <selinux@vger.kernel.org>; Thu,  9 Sep 2021 14:28:05 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id p4so3549128qki.3
        for <selinux@vger.kernel.org>; Thu, 09 Sep 2021 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGlKTO867McaEsMRzKlL2tLDkukIIVnduGcseNojlIM=;
        b=AMYFezUwXfTqLHieGkZDndqi3Bw9fVJ/x02WGdDVZxOvuib4X9smHB2gfOj5x9NTaW
         P5CfU5qsDQjIuw/EKs9TcIXyX2YVq0+R14tCGco6lBc+RkKU6OCMP3TDFrxXHHL0vbi6
         6/puR8i5AxJH0i5VPptfdY0OEFODJaL56JitxqCwT7+XzI1A8Spyc6Pz3V/yj7DcNYsW
         nH1QkapQ5HrN0y/dvYEG4gWao5dU6MKG9/gfAF86XpCPWNJt2MT7hE6iGfPrDv/zfVTf
         yt02a9Ui+0OM8N/mi7XVf40CcmDSPAcW5JCamGEJYVIdYtCRyMx33hN1mAeEXhuzjSdp
         FQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oGlKTO867McaEsMRzKlL2tLDkukIIVnduGcseNojlIM=;
        b=PSd2mUPPoKhEcnBDpmx2bQsO/J8D1m3BoiF3K3EbPNn5LwT7UxgsbBhflwoxe8bcYs
         qEtKzkDV9q6WJC/t4oblUH6SHgdF4MTExh1L5kiOpeAVqY+Stdy/8+dbbisafLqCOHQX
         0JrkPa6u/ICD9mqabFHzD5++Sb7FUZTCoaikyT9zi5nkf9JTIA9amp2xiidoKUzQJa89
         01t6MiaBII+8VCMrKfCiS7bTejlzS6s2YMP41rOnj9YLfHOxRCsaAr6EQI+CyoeIgqbX
         R4ggMrP3dqLNJwSeNkNU2zY5HNQp7MB6K4WWFjeO+OqwaEo43IXjexFGXJFrmDo6bnko
         SVLw==
X-Gm-Message-State: AOAM531ymuUiBGRwe5TMAqli063eV77CkGjnjf74MAdEeFQbG5StJdnv
        d+R5ZkJ3YMfRv0XEKSpqKdGfZl0Du90=
X-Google-Smtp-Source: ABdhPJzM/ZuqhMiphjuSv37wibUg+l3OvtqEAIUODgSEhz9RSQMtMB+Phhyq6a33cX16jEJl790Yvg==
X-Received: by 2002:a05:620a:166d:: with SMTP id d13mr4676105qko.491.1631222884851;
        Thu, 09 Sep 2021 14:28:04 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id g5sm2194758qkl.48.2021.09.09.14.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 14:28:04 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     plautrba@redhat.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Free duplicate datums in original calling function
Date:   Thu,  9 Sep 2021 17:27:59 -0400
Message-Id: <20210909212759.894402-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Duplicate declarations are allowed for type, typeattribute, and
optional statements. When an allowed duplicate declaration is found,
the duplicate datum is free'd in cil_add_decl_to_symtab() and SEPOL_OK
is returned. This works for all the rules where a duplicate declaration
is allowed, but it confuses scanning tools.

When cil_add_decl_to_symtab() finds an allowed duplicate declaration,
return SEPOL_EEXIST and free the duplicate datum in the original
calling function.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_build_ast.c | 27 +++++++++++++++++++++------
 libsepol/cil/src/cil_copy_ast.c  |  9 ++++++++-
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index f1f09f11..9c34be23 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -134,8 +134,7 @@ int cil_add_decl_to_symtab(struct cil_db *db, symtab_t *symtab, hashtab_key_t ke
 		/* multiple_decls is enabled and works for this datum type, add node */
 		cil_list_append(prev->nodes, CIL_NODE, node);
 		node->data = prev;
-		cil_symtab_datum_destroy(datum);
-		free(datum);
+		return SEPOL_EEXIST;
 	}
 
 	return SEPOL_OK;
@@ -2367,7 +2366,12 @@ int cil_gen_type(struct cil_db *db, struct cil_tree_node *parse_current, struct
 	key = parse_current->next->data;
 	rc = cil_gen_node(db, ast_node, (struct cil_symtab_datum*)type, (hashtab_key_t)key, CIL_SYM_TYPES, CIL_TYPE);
 	if (rc != SEPOL_OK) {
-		goto exit;
+		if (rc == SEPOL_EEXIST) {
+			cil_destroy_type(type);
+			type = NULL;
+		} else {
+			goto exit;
+		}
 	}
 
 	return SEPOL_OK;
@@ -2415,7 +2419,12 @@ int cil_gen_typeattribute(struct cil_db *db, struct cil_tree_node *parse_current
 	key = parse_current->next->data;
 	rc = cil_gen_node(db, ast_node, (struct cil_symtab_datum*)attr, (hashtab_key_t)key, CIL_SYM_TYPES, CIL_TYPEATTRIBUTE);
 	if (rc != SEPOL_OK) {
-		goto exit;
+		if (rc == SEPOL_EEXIST) {
+			cil_destroy_typeattribute(attr);
+			attr = NULL;
+		} else {
+			goto exit;
+		}
 	}
 
 	return SEPOL_OK;
@@ -5480,8 +5489,14 @@ int cil_gen_optional(struct cil_db *db, struct cil_tree_node *parse_current, str
 	key = parse_current->next->data;
 
 	rc = cil_gen_node(db, ast_node, (struct cil_symtab_datum*)optional, (hashtab_key_t)key, CIL_SYM_BLOCKS, CIL_OPTIONAL);
-	if (rc != SEPOL_OK)
-		goto exit;
+	if (rc != SEPOL_OK) {
+		if (rc == SEPOL_EEXIST) {
+			cil_destroy_optional(optional);
+			optional = NULL;
+		} else {
+			goto exit;
+		}
+	}
 
 	return SEPOL_OK;
 
diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index cdbc84e7..7c5ae9e1 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -2056,7 +2056,14 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *finished, void
 
 			rc = cil_add_decl_to_symtab(db, symtab, DATUM(orig->data)->name, DATUM(data), new);
 			if (rc != SEPOL_OK) {
-				goto exit;
+				if (rc == SEPOL_EEXIST) {
+					cil_symtab_datum_destroy(data);
+					free(data);
+					data = NULL;
+					rc = SEPOL_OK;
+				} else {
+					goto exit;
+				}
 			}
 
 			namespace = new;
-- 
2.31.1

