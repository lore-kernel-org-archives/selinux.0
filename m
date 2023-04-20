Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C738FC7EE20
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 15:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjDTPgJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjDTPgI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 11:36:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FC44C21
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:36:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id c9so7437824ejz.1
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682004965; x=1684596965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqmvBgNhmwPBoRhwUR3lqRV/49ryZPJXVYGqdgsKsj4=;
        b=saEXApb2kI4lHKbelWHypCAq6jPxD9y6BECCCZ5qoXtvXmvkyASOrJfNkXt0woh0RE
         uSGU8tVQV+DIh52C39/lOr7gwqDNQasXRV4hNDHSE+4wgWkwvljA7ORlYYJcJDZ9ZrS6
         KpFwmGFPp1jGhgIyf80bcYoUbx8SwVde+ycXr3P5m5GM/6mRDMSP0oK+b4Hjs5sFQtl6
         pW/gVzVv412l3f54pf+CF4WbNJKG4UAf5ot3ZblRO77zu5imtTwxlXLqgIbcesVq4d+e
         td4xC+6ndUn+sClifUhipm8TRkf7fOFRujGUqzUtzyItjJOpAfAvTHsRxgEo7v1gJ6Fq
         5coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682004965; x=1684596965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqmvBgNhmwPBoRhwUR3lqRV/49ryZPJXVYGqdgsKsj4=;
        b=SebwoB2go9qrJQsA/MgQ1UpK8eQJyUWIggYPgWSR21qPwJXppQSpPazssIFRiDlg+y
         LLBgsMI1JRLxiRI6vEhMQOTGzvi10DUTU2yiEdZfBMXbF4j9pMYRlmEdalQlwaebBKf0
         +Y2QwS4rNyqI82bOWmaEqn8D8QItQfj9urGW5LZ8FiLLygymnAv2Vm0FmRnF1NdM2eUo
         VqIrGYGy5D+XXIPk3ifTIXrErH4BbU/XJBrKBGHfFNX6suNfIIpqFhbOeFk1ljs2USqD
         kjKTvHR5GaHvzUzfmJa2muH10+CI5kLSYKIPbEmQ2pZwrc4yvOwUNjMoiy4iyEB9it8b
         Z8oA==
X-Gm-Message-State: AAQBX9dF9U7d75h08x8LRGIkC9XVJ1Wm6HB84L+L2w0N4p0uhTvs0+Fx
        ax+c70MAk9qNY/6l53vot7rN+WPgZd8=
X-Google-Smtp-Source: AKy350aJTyCExYYpd6z4yy6+lbuL1/MI9fOAKiRGiZS6PyNXnUF1vUbvcvlxTSac+bQjhHLTpOzLWQ==
X-Received: by 2002:a17:906:8245:b0:94f:6d10:ad9f with SMTP id f5-20020a170906824500b0094f6d10ad9fmr1829979ejx.42.1682004965024;
        Thu, 20 Apr 2023 08:36:05 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-119-201-251.95.119.pool.telefonica.de. [95.119.201.251])
        by smtp.gmail.com with ESMTPSA id r22-20020aa7cb96000000b0050696c2d2f6sm853013edt.88.2023.04.20.08.36.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 08:36:04 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 5/6] libsepol: rename bool identifiers
Date:   Thu, 20 Apr 2023 17:35:55 +0200
Message-Id: <20230420153556.32115-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420153556.32115-1-cgzones@googlemail.com>
References: <20230420153556.32115-1-cgzones@googlemail.com>
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
2.40.0

