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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C6DC433EF
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D90760F70
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhINMwF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbhINMwE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 08:52:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DFCC061574
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v24so13503550eda.3
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 05:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=s3Bxn0Hf+vSkpjFPS7SQn2Z9Hknp/vWbIBNPRs/iv1A=;
        b=OpETLL20moJdY7LRo4S0Ksr7rdr2pxwg3jQb5zRXn7pOR98wYACkgTXI5+V0rEqFZL
         mc83KoEOEfq8zM8XCIe9/RVDk65fhE+900wzYvjwD90w1rxVyUCpA2ak1SPPizSFl4tI
         J+SyRxP/5nwG4t9BYFrVZLzLiQsm22bA3VtuJGRv9u+SU17yx0Py7O5MCWNCw1s0T12/
         WEyzq58Wf/34+IoD757zcTHoOahFfJ1DGtqKJL9Pj67PS8nGc4KLuixG13esQh8tce4g
         AT1eQuhsYBvUM3VyoN2BkM2nMzolzf84TVK1abKH+lSOhb4ycFUk9/C5km+2DWJ6Y+dX
         99rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s3Bxn0Hf+vSkpjFPS7SQn2Z9Hknp/vWbIBNPRs/iv1A=;
        b=SmMde3kXDfBxm3KdL8hK2XOXMnG7qHu6D940ph4iiyMo23X8RKeqG+4OsPOOloRMVF
         6k1IG01oKTMIdCtEf5oK5eZoHT7Ur5VwxFE0xevAd7mkc0H4PXLSN4R7cFeZSGDXGVb8
         wwh2Vw+lBS+xTGz0aYa4pI2BARQmukDXl/qSbaQHlajEqBpfG0P4KpxKN/3QUXBFRjsn
         4fdZT4WWHccBwIGGCgSBJTas7WHKVgk2YLST561tib+k0SsNFi9QBycSQSYoQvUyTkDj
         +5FmkxJdsAge6xmlC9zWZS0cm+x6ZKFaRwr6bPu29WvmXGNU8024sDn0QiROW2tjUsY7
         n4Pg==
X-Gm-Message-State: AOAM532AMT7bGs29zVqqjzVoxrCjmouKM7IB4GrnbtCEy4NTnJTWuSj2
        iatDQjyzRS23Mxo3Lo4Xmt/U3cqs1vQ=
X-Google-Smtp-Source: ABdhPJwD1zpFjrXhNOV6Q82Zm7j4slnY+4o/vxpcCOCMA8usKiOcdYFysJximPrMFnHAEMvN5OFh7Q==
X-Received: by 2002:a05:6402:34c3:: with SMTP id w3mr19014218edc.335.1631623845962;
        Tue, 14 Sep 2021 05:50:45 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-237-250.77.3.pool.telefonica.de. [77.3.237.250])
        by smtp.gmail.com with ESMTPSA id r8sm5567865eds.39.2021.09.14.05.50.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:50:45 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 06/13] checkpolicy: mark read-only parameters in module compiler const
Date:   Tue, 14 Sep 2021 14:48:21 +0200
Message-Id: <20210914124828.19488-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914124828.19488-1-cgzones@googlemail.com>
References: <20210914124828.19488-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Make it more obvious which parameters are read-only and not being
modified and allow callers to pass const pointers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/module_compiler.c | 26 +++++++++++++-------------
 checkpolicy/module_compiler.h |  4 ++--
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index ada7cb2a..e8f15f4e 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -1104,14 +1104,14 @@ int require_cat(int pass)
 	return 0;
 }
 
-static int is_scope_in_stack(scope_datum_t * scope, scope_stack_t * stack)
+static int is_scope_in_stack(const scope_datum_t * scope, const scope_stack_t * stack)
 {
 	uint32_t i;
 	if (stack == NULL) {
 		return 0;	/* no matching scope found */
 	}
 	if (stack->type == 1) {
-		avrule_decl_t *decl = stack->decl;
+		const avrule_decl_t *decl = stack->decl;
 		for (i = 0; i < scope->decl_ids_len; i++) {
 			if (scope->decl_ids[i] == decl->decl_id) {
 				return 1;
@@ -1126,9 +1126,9 @@ static int is_scope_in_stack(scope_datum_t * scope, scope_stack_t * stack)
 	return is_scope_in_stack(scope, stack->parent);
 }
 
-int is_id_in_scope(uint32_t symbol_type, hashtab_key_t id)
+int is_id_in_scope(uint32_t symbol_type, const_hashtab_key_t id)
 {
-	scope_datum_t *scope =
+	const scope_datum_t *scope =
 	    (scope_datum_t *) hashtab_search(policydbp->scope[symbol_type].
 					     table, id);
 	if (scope == NULL) {
@@ -1138,7 +1138,7 @@ int is_id_in_scope(uint32_t symbol_type, hashtab_key_t id)
 }
 
 static int is_perm_in_scope_index(uint32_t perm_value, uint32_t class_value,
-				  scope_index_t * scope)
+				  const scope_index_t * scope)
 {
 	if (class_value > scope->class_perms_len) {
 		return 1;
@@ -1151,7 +1151,7 @@ static int is_perm_in_scope_index(uint32_t perm_value, uint32_t class_value,
 }
 
 static int is_perm_in_stack(uint32_t perm_value, uint32_t class_value,
-			    scope_stack_t * stack)
+			    const scope_stack_t * stack)
 {
 	if (stack == NULL) {
 		return 0;	/* no matching scope found */
@@ -1173,12 +1173,12 @@ static int is_perm_in_stack(uint32_t perm_value, uint32_t class_value,
 	return is_perm_in_stack(perm_value, class_value, stack->parent);
 }
 
-int is_perm_in_scope(hashtab_key_t perm_id, hashtab_key_t class_id)
+int is_perm_in_scope(const_hashtab_key_t perm_id, const_hashtab_key_t class_id)
 {
-	class_datum_t *cladatum =
+	const class_datum_t *cladatum =
 	    (class_datum_t *) hashtab_search(policydbp->p_classes.table,
 					     class_id);
-	perm_datum_t *perdatum;
+	const perm_datum_t *perdatum;
 	if (cladatum == NULL) {
 		return 1;
 	}
@@ -1361,17 +1361,17 @@ int begin_optional_else(int pass)
 	return 0;
 }
 
-static int copy_requirements(avrule_decl_t * dest, scope_stack_t * stack)
+static int copy_requirements(avrule_decl_t * dest, const scope_stack_t * stack)
 {
 	uint32_t i;
 	if (stack == NULL) {
 		return 0;
 	}
 	if (stack->type == 1) {
-		scope_index_t *src_scope = &stack->decl->required;
+		const scope_index_t *src_scope = &stack->decl->required;
 		scope_index_t *dest_scope = &dest->required;
 		for (i = 0; i < SYM_NUM; i++) {
-			ebitmap_t *src_bitmap = &src_scope->scope[i];
+			const ebitmap_t *src_bitmap = &src_scope->scope[i];
 			ebitmap_t *dest_bitmap = &dest_scope->scope[i];
 			if (ebitmap_union(dest_bitmap, src_bitmap)) {
 				yyerror("Out of memory!");
@@ -1397,7 +1397,7 @@ static int copy_requirements(avrule_decl_t * dest, scope_stack_t * stack)
 			    src_scope->class_perms_len;
 		}
 		for (i = 0; i < src_scope->class_perms_len; i++) {
-			ebitmap_t *src_bitmap = &src_scope->class_perms_map[i];
+			const ebitmap_t *src_bitmap = &src_scope->class_perms_map[i];
 			ebitmap_t *dest_bitmap =
 			    &dest_scope->class_perms_map[i];
 			if (ebitmap_union(dest_bitmap, src_bitmap)) {
diff --git a/checkpolicy/module_compiler.h b/checkpolicy/module_compiler.h
index 72c2d9bb..29b824b4 100644
--- a/checkpolicy/module_compiler.h
+++ b/checkpolicy/module_compiler.h
@@ -65,12 +65,12 @@ int require_cat(int pass);
 /* Check if an identifier is within the scope of the current
  * declaration or any of its parents.  Return 1 if it is, 0 if not.
  * If the identifier is not known at all then return 1 (truth).  */
-int is_id_in_scope(uint32_t symbol_type, hashtab_key_t id);
+int is_id_in_scope(uint32_t symbol_type, const_hashtab_key_t id);
 
 /* Check if a particular permission is within the scope of the current
  * declaration or any of its parents.  Return 1 if it is, 0 if not.
  * If the identifier is not known at all then return 1 (truth).  */
-int is_perm_in_scope(hashtab_key_t perm_id, hashtab_key_t class_id);
+int is_perm_in_scope(const_hashtab_key_t perm_id, const_hashtab_key_t class_id);
 
 /* Search the current avrules block for a conditional with the same
  * expression as 'cond'.  If the conditional does not exist then
-- 
2.33.0

