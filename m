Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA038C433F5
	for <selinux@archiver.kernel.org>; Wed,  5 Jan 2022 21:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244379AbiAEVQQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Jan 2022 16:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244378AbiAEVQP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Jan 2022 16:16:15 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AC4C061245
        for <selinux@vger.kernel.org>; Wed,  5 Jan 2022 13:16:15 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id m2so711369qkd.8
        for <selinux@vger.kernel.org>; Wed, 05 Jan 2022 13:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0lMY/kihy1HYhLdDNz3DdawjvP54+9gnZ5vo0C1c+R0=;
        b=VGj++Ny7aU5NCmp/IrDd4rUFMenFlYBhzpgb8o0Ympy20a44x+fcLMbDlvRytHOKql
         M/XNclFDI7ptGVqBlUJWoG8SA/LphkWVrUExMK788VYp7Y5kDMDksFmBbB2Q5T5lcNgZ
         QKxYMrniLZMoMPJ6YtgAAt6BPmun88KgK+saiX9FDYAn+QAmeZq1aZ6HDMF+arDvK8AB
         ufjhyMwE8dDeKazdQhWqN3ndKPbEyCnoO4WqhjqUQl5FeT0kvWHKktDGke+r48gUzSTL
         1hUMLvCzDrg26jG+UJAtt9nqx0tuvIedqsBuHrLu+3svJFyW5Cb1nt90u/8FTbz94Wc8
         olow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0lMY/kihy1HYhLdDNz3DdawjvP54+9gnZ5vo0C1c+R0=;
        b=4cYg0LDLNy6aqM69Cf4H7r+C5SYuaeSOH/jnurLsSilStTEel5XLelk7Gmj+YIeB2c
         BqZOTGnAiZ7WSPkQogw453o6y3fZTQYCm9ufPo/G4uIvaNT8GWeXQokrESuAEJdpvHoL
         RIRpK6ZPbsDn0Lj9huVMmcd4wBeKzsRpwBQvysIDi6QvYMZY7auxGt2o14GMQlUs+fM2
         mPXAiHS5NraSfspJZKyUuRuHtDX6JBHrKfOYJIkUgKmdiPlaj9H4992BQRQTYSZtUTxO
         NdQcJvUmbfkF1VBeMtdxUIYSKv79kyTZZe6lNaW7wwHdJSFiXZ313WuIZHcgZgwqK8ji
         m7LQ==
X-Gm-Message-State: AOAM532O3oCCem5jfKfvqDnhC7buTxYpZoXpO1nm3iAmy9tIF7kFg7Sp
        0c2lAdV2wfeQBMkY6CCystXey/3xdD8=
X-Google-Smtp-Source: ABdhPJy5hzzb7JE3qoWaW1Ol1bbZhD9fWduv4Nlnu0yL4XOwIOTmTR8Og9nr+0gymMkpN/3ebpuPQg==
X-Received: by 2002:a05:620a:2905:: with SMTP id m5mr40262929qkp.598.1641417374313;
        Wed, 05 Jan 2022 13:16:14 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id m1sm36148502qkn.115.2022.01.05.13.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 13:16:13 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/3] libsepol/cil: Do not resolve names to declarations in abstract blocks
Date:   Wed,  5 Jan 2022 16:16:02 -0500
Message-Id: <20220105211602.359300-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105211602.359300-1-jwcart2@gmail.com>
References: <20220105211602.359300-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since abstract blocks will not appear in the final policy, do not
resolve names to a declaration inside one.

When resolving blockabstract rules, they must be collected in a list
and processed at the end of the pass because if a parent block is
marked as abstract, then a blockabstract rule for a sub-block will
fail to resolve.

Found by oss-fuzz (#42981)

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 0288b7dc..73115c55 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -65,6 +65,7 @@ struct cil_args_resolve {
 	struct cil_list *sensitivityorder_lists;
 	struct cil_list *in_list_before;
 	struct cil_list *in_list_after;
+	struct cil_list *abstract_blocks;
 };
 
 static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key, struct cil_tree_node *ast_node)
@@ -2397,6 +2398,7 @@ int cil_resolve_blockabstract(struct cil_tree_node *current, void *extra_args)
 	struct cil_blockabstract *abstract = current->data;
 	struct cil_symtab_datum *block_datum = NULL;
 	struct cil_tree_node *block_node = NULL;
+	struct cil_args_resolve *args = extra_args;
 	int rc = SEPOL_ERR;
 
 	rc = cil_resolve_name(current, abstract->block_str, CIL_SYM_BLOCKS, extra_args, &block_datum);
@@ -2411,7 +2413,7 @@ int cil_resolve_blockabstract(struct cil_tree_node *current, void *extra_args)
 		goto exit;
 	}
 
-	cil_mark_subtree_abstract(block_node);
+	cil_list_append(args->abstract_blocks, CIL_NODE, block_node);
 
 	return SEPOL_OK;
 
@@ -4097,6 +4099,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 	extra_args.sensitivityorder_lists = NULL;
 	extra_args.in_list_before = NULL;
 	extra_args.in_list_after = NULL;
+	extra_args.abstract_blocks = NULL;
 
 	cil_list_init(&extra_args.to_destroy, CIL_NODE);
 	cil_list_init(&extra_args.sidorder_lists, CIL_LIST_ITEM);
@@ -4106,6 +4109,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 	cil_list_init(&extra_args.sensitivityorder_lists, CIL_LIST_ITEM);
 	cil_list_init(&extra_args.in_list_before, CIL_IN);
 	cil_list_init(&extra_args.in_list_after, CIL_IN);
+	cil_list_init(&extra_args.abstract_blocks, CIL_NODE);
 
 	for (pass = CIL_PASS_TIF; pass < CIL_PASS_NUM; pass++) {
 		extra_args.pass = pass;
@@ -4129,6 +4133,13 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 			cil_list_destroy(&extra_args.in_list_after, CIL_FALSE);
 		}
 
+		if (pass == CIL_PASS_BLKABS) {
+			struct cil_list_item *item;
+			cil_list_for_each(item, extra_args.abstract_blocks) {
+				cil_mark_subtree_abstract(item->data);
+			}
+		}
+
 		if (pass == CIL_PASS_BLKIN_LINK) {
 			rc = cil_check_for_bad_inheritance(current);
 			if (rc != SEPOL_OK) {
@@ -4247,6 +4258,7 @@ exit:
 	cil_list_destroy(&extra_args.to_destroy, CIL_FALSE);
 	cil_list_destroy(&extra_args.in_list_before, CIL_FALSE);
 	cil_list_destroy(&extra_args.in_list_after, CIL_FALSE);
+	cil_list_destroy(&extra_args.abstract_blocks, CIL_FALSE);
 
 	return rc;
 }
@@ -4268,9 +4280,13 @@ static int __cil_resolve_name_with_parents(struct cil_tree_node *node, char *nam
 		case CIL_ROOT:
 			goto exit;
 			break;
-		case CIL_BLOCK:
-			symtab = &((struct cil_block*)node->data)->symtab[sym_index];
-			rc = cil_symtab_get_datum(symtab, name, datum);
+		case CIL_BLOCK: {
+			struct cil_block *block = node->data;
+			if (!block->is_abstract) {
+				symtab = &block->symtab[sym_index];
+				rc = cil_symtab_get_datum(symtab, name, datum);
+			}
+		}
 			break;
 		case CIL_BLOCKINHERIT: {
 			struct cil_blockinherit *inherit = node->data;
-- 
2.31.1

