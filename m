Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724F3C43217
	for <selinux@archiver.kernel.org>; Mon, 14 Nov 2022 20:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiKNULH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237534AbiKNUKx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Nov 2022 15:10:53 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675AD1A380
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 12:10:52 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n12so31016489eja.11
        for <selinux@vger.kernel.org>; Mon, 14 Nov 2022 12:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0C74CZiuMElJreyNyS91XeoLenbmQLJo3IkjwDNBW8=;
        b=WaRHhgoKsbVkQiHlAbIUhSK/c+Zt9Tp0T7yo5TPfUHSGopWP0GMlPovglqZibCB9N6
         iuGdudmxe4MEeD50SoUckqzDNpHkEXUg7cny+/RJ8XWK3VLAd0s2BlKu1BOHrRWtRfIo
         zV0ZYnaS2iZmZb+H1V7tvwJT6a7A4zKmH/34zk/lH/p0p+Fsv80pHDW7Wk2gLN6kEVgd
         OHnWGj1SaqZ7nGeTqM2t4P5qpf1dx9lnFes1puuFAUUuZrRq1tJoCbHlLRegXfBkQjKR
         hV+Mv+7qxXOQFggvSO2MLOQbOLit0O1Xky5GaUrcuV33S0RRxrGcHIxGb5IUAaaOqQ4s
         eJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0C74CZiuMElJreyNyS91XeoLenbmQLJo3IkjwDNBW8=;
        b=6MOSNEy2jfO2XeLED3Cs3l+IUql1wzz1RXA5Kui9kKFDvtekIXt/H6EOpN6DdKmP3P
         ufOXuPrPwtQ60aCt7tBX+1C0b4+YORZ4w2vB97o28a8jHq2AUHAul1SNYo9qI6nTR08m
         0JTfx9ZQroZ+FLEOMOQ4kIu66Mf4DmxVjf89HxODhrGmq8VNnjDsxBA/ba2LP/QhlLGm
         Ix/DEMCTKKmqaTH+1NEfTJRqNPGoNwe+emorHccoPiOo6/4CXuTzvNEVLblJTWJrLNo6
         q0SUJsvCOOU7az+7DQRKbXJKGexqOEWCwUynrEI1nJ/vqwlxH/Q2WcRn7ntDGwCb0ow6
         bCUw==
X-Gm-Message-State: ANoB5pk20L1VI84VJnojXmga9XkvxFV+NuyOIh2kk8taRFbEvFAzlDKy
        i056AXd9yLw5HJroqe1qkTgb13R/2K8=
X-Google-Smtp-Source: AA0mqf4Vx+D7reuKLvJH/jd1vnpysmGDZsMMa4LiXgw7uf14EP8Ky57oyrgIhnSCHMV3huCJ1d2bJQ==
X-Received: by 2002:a17:907:8c06:b0:78d:f3f4:b1a0 with SMTP id ta6-20020a1709078c0600b0078df3f4b1a0mr11428948ejc.489.1668456650966;
        Mon, 14 Nov 2022 12:10:50 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-003-090-138.77.3.pool.telefonica.de. [77.3.90.138])
        by smtp.gmail.com with ESMTPSA id cb13-20020a170906a44d00b007abafe43c3bsm4558377ejb.86.2022.11.14.12.10.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:10:50 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 5/6] libsepol: rename bool identifiers
Date:   Mon, 14 Nov 2022 21:10:41 +0100
Message-Id: <20221114201042.17773-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114201042.17773-1-cgzones@googlemail.com>
References: <20221114201042.17773-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Avoid using the identifier `bool` to improve support with future C
standards.  C23 is about to make `bool` a predefined macro (see N2654).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_binary.c |  8 ++++----
 libsepol/cil/src/cil_policy.c | 12 ++++++------
 libsepol/src/expand.c         | 12 ++++++------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index ef7f4d70..c4ee2380 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4170,13 +4170,13 @@ static int __cil_user_val_array_insert(hashtab_key_t key, hashtab_datum_t datum,
 static int __cil_bool_val_array_insert(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
 	policydb_t *pdb = data;
-	cond_bool_datum_t *bool = (cond_bool_datum_t *)datum;
+	cond_bool_datum_t *boolean = (cond_bool_datum_t *)datum;
 
-	if (bool->s.value < 1 || bool->s.value > pdb->p_bools.nprim) {
+	if (boolean->s.value < 1 || boolean->s.value > pdb->p_bools.nprim) {
 		return -EINVAL;
 	}
-	pdb->p_bool_val_to_name[bool->s.value - 1] = (char *)key;
-	pdb->bool_val_to_struct[bool->s.value - 1] = bool;
+	pdb->p_bool_val_to_name[boolean->s.value - 1] = (char *)key;
+	pdb->bool_val_to_struct[boolean->s.value - 1] = boolean;
 
 	return 0;
 }
diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_policy.c
index 7c543c47..feb97868 100644
--- a/libsepol/cil/src/cil_policy.c
+++ b/libsepol/cil/src/cil_policy.c
@@ -1008,13 +1008,13 @@ static void cil_validatetrans_to_policy(FILE *out, struct cil_db *db, struct cil
 static void cil_bools_to_policy(FILE *out, struct cil_list *bools)
 {
 	struct cil_list_item *i1;
-	struct cil_bool *bool;
+	struct cil_bool *boolean;
 	const char *value;
 
 	cil_list_for_each(i1, bools) {
-		bool = i1->data;
-		value = bool->value ? "true" : "false";
-		fprintf(out, "bool %s %s;\n", bool->datum.fqn, value);
+		boolean = i1->data;
+		value = boolean->value ? "true" : "false";
+		fprintf(out, "bool %s %s;\n", boolean->datum.fqn, value);
 	}
 }
 
@@ -1437,12 +1437,12 @@ static int __cil_te_rules_to_policy_helper(struct cil_tree_node *node, uint32_t
 		*finished = CIL_TREE_SKIP_HEAD;
 		break;
 	case CIL_BOOLEANIF: {
-		struct cil_booleanif *bool = node->data;
+		struct cil_booleanif *boolean = node->data;
 		struct cil_tree_node *n;
 		struct cil_condblock *cb;
 
 		fprintf(args->out, "if ");
-		cil_cond_expr_to_policy(args->out, bool->datum_expr, CIL_TRUE);
+		cil_cond_expr_to_policy(args->out, boolean->datum_expr, CIL_TRUE);
 		fprintf(args->out," {\n");
 		n = node->cl_head;
 		cb = n != NULL ? n->data : NULL;
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 1337c32f..c08d3a35 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1106,11 +1106,11 @@ static int bool_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 {
 	int ret;
 	expand_state_t *state;
-	cond_bool_datum_t *bool, *new_bool;
+	cond_bool_datum_t *boolean, *new_bool;
 	char *id, *new_id;
 
 	id = key;
-	bool = (cond_bool_datum_t *) datum;
+	boolean = (cond_bool_datum_t *) datum;
 	state = (expand_state_t *) data;
 
 	if (!is_id_enabled(id, state->base, SYM_BOOLS)) {
@@ -1118,7 +1118,7 @@ static int bool_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		return 0;
 	}
 
-	if (bool->flags & COND_BOOL_FLAGS_TUNABLE) {
+	if (boolean->flags & COND_BOOL_FLAGS_TUNABLE) {
 		/* Skip tunables */
 		return 0;
 	}
@@ -1152,10 +1152,10 @@ static int bool_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		return -1;
 	}
 
-	state->boolmap[bool->s.value - 1] = new_bool->s.value;
+	state->boolmap[boolean->s.value - 1] = new_bool->s.value;
 
-	new_bool->state = bool->state;
-	new_bool->flags = bool->flags;
+	new_bool->state = boolean->state;
+	new_bool->flags = boolean->flags;
 
 	return 0;
 }
-- 
2.38.1

