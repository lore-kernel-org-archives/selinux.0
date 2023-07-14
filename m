Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD090EB64DC
	for <selinux@archiver.kernel.org>; Fri, 14 Jul 2023 17:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjGNRct (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Jul 2023 13:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbjGNRcs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Jul 2023 13:32:48 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B398735A2
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 10:32:46 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7659db6339eso97918385a.1
        for <selinux@vger.kernel.org>; Fri, 14 Jul 2023 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689355965; x=1691947965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4aNEve6iXvKVhtvLh43REk6TUD0rh8axSunQI5L+Ro=;
        b=UrACZ0++Zpt7NiAZ57b8Xfp4EYPEKPKviukcZzhgB9+oDQapM4P+TOcMaz0/hAk7YS
         klGcR+q3iw0ikzLXPhFq6sX1kPJWQ9G7xsIs8PDDd3l3l2/eNJ5L3s8msMOVTYHBcLGB
         ZOmF0Pii8PDivIJo35F6RaaLg+FEZf/94VCu6i5EhnOeBerwK0pOELBqqYOrfw4qh3zd
         2hjpb/ixJu7n9BUNqaI29Vxd/57X1v1quz9wQOa7X4tVr4uLhqO233nJbwSsQDawGRz5
         eIpvMVtuniMOG8m63RNLQUVvOJRPWoutJO+fXSCS+SbpfebXhNMNZ4lkh/xKaCp663rF
         YeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355965; x=1691947965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4aNEve6iXvKVhtvLh43REk6TUD0rh8axSunQI5L+Ro=;
        b=jCE5YTbRY3cE6jpz4oS25DpjVDYJc83A0CThGsvw9ipu5kmyNbPtBiQsIofkIvginl
         d6D0ETXNES/cUY31XetQsBm37H4j4P3kATPpzQyz223RGJjRRLA+YGO/Oz/1JAUTlAT/
         KnzUxGf6owUQcyhRfdPk0eo4B/Ij/YFoyfsII2WLPKQnByk1wrkCR0l5qhHZmiKRNza5
         f6V5wUohFQS9NNlOvV4fc4aMENtZV3iX2IjYDrFzmKyCs/0NLlZe2tt0vr50zpcQVlx3
         7g8Fc5/iRW1+vWTlBvbDHg2m3R1s06+qZOPux2hE74/TWHPXKfUhZVzPL5L/QhVcGzCM
         dqsQ==
X-Gm-Message-State: ABy/qLY9ukDHpfBfMtCX2r85yHiAEGzoepttHjqB/BwZVvJmRFy0t/2R
        75UAl5qD++SUPtUfxLvow0FrRl2gBw8=
X-Google-Smtp-Source: APBJJlF6TcelFSKIbb1f/9xi96pMxLibPGNkCvptd/N7UEbTFM4I/7fFdfiVQYR47M66Wrk7lvCnQQ==
X-Received: by 2002:a05:620a:46a1:b0:767:f116:1b92 with SMTP id bq33-20020a05620a46a100b00767f1161b92mr3838849qkb.38.1689355965327;
        Fri, 14 Jul 2023 10:32:45 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id f22-20020ae9ea16000000b00767177a5bebsm3938965qkg.56.2023.07.14.10.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:32:44 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH] checkpolicy: Remove support for role dominance rules
Date:   Fri, 14 Jul 2023 13:32:40 -0400
Message-ID: <20230714173240.192987-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Role dominance has been deprecated for a very, very long time (since
at least August 2008) and has never been used in any widely deployed
policy.

Remove support for compiling role dominance rules.

Support will remain, for now, in libsepol for backwards compatibility.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 checkpolicy/policy_define.c | 184 ------------------------------------
 checkpolicy/policy_define.h |   2 -
 checkpolicy/policy_parse.y  |  14 ---
 3 files changed, 200 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 8421b253..23a65339 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2926,190 +2926,6 @@ int define_roleattribute(void)
 	return 0;
 }
 
-role_datum_t *merge_roles_dom(role_datum_t * r1, role_datum_t * r2)
-{
-	role_datum_t *new;
-
-	if (pass == 1) {
-		return (role_datum_t *) 1;	/* any non-NULL value */
-	}
-
-	new = malloc(sizeof(role_datum_t));
-	if (!new) {
-		yyerror("out of memory");
-		return NULL;
-	}
-	memset(new, 0, sizeof(role_datum_t));
-	new->s.value = 0;		/* temporary role */
-	if (ebitmap_or(&new->dominates, &r1->dominates, &r2->dominates)) {
-		yyerror("out of memory");
-		free(new);
-		return NULL;
-	}
-	if (ebitmap_or(&new->types.types, &r1->types.types, &r2->types.types)) {
-		yyerror("out of memory");
-		free(new);
-		return NULL;
-	}
-	if (!r1->s.value) {
-		/* free intermediate result */
-		type_set_destroy(&r1->types);
-		ebitmap_destroy(&r1->dominates);
-		free(r1);
-	}
-	if (!r2->s.value) {
-		/* free intermediate result */
-		yyerror("right hand role is temporary?");
-		type_set_destroy(&r2->types);
-		ebitmap_destroy(&r2->dominates);
-		free(r2);
-	}
-	return new;
-}
-
-/* This function eliminates the ordering dependency of role dominance rule */
-static int dominate_role_recheck(hashtab_key_t key __attribute__ ((unused)),
-				 hashtab_datum_t datum, void *arg)
-{
-	role_datum_t *rdp = (role_datum_t *) arg;
-	role_datum_t *rdatum = (role_datum_t *) datum;
-	ebitmap_node_t *node;
-	uint32_t i;
-
-	/* Don't bother to process against self role */
-	if (rdatum->s.value == rdp->s.value)
-		return 0;
-
-	/* If a dominating role found */
-	if (ebitmap_get_bit(&(rdatum->dominates), rdp->s.value - 1)) {
-		ebitmap_t types;
-		ebitmap_init(&types);
-		if (type_set_expand(&rdp->types, &types, policydbp, 1)) {
-			ebitmap_destroy(&types);
-			return -1;
-		}
-		/* raise types and dominates from dominated role */
-		ebitmap_for_each_positive_bit(&rdp->dominates, node, i) {
-			if (ebitmap_set_bit(&rdatum->dominates, i, TRUE))
-				goto oom;
-		}
-		ebitmap_for_each_positive_bit(&types, node, i) {
-			if (ebitmap_set_bit(&rdatum->types.types, i, TRUE))
-				goto oom;
-		}
-		ebitmap_destroy(&types);
-	}
-
-	/* go through all the roles */
-	return 0;
-      oom:
-	yyerror("Out of memory");
-	return -1;
-}
-
-role_datum_t *define_role_dom(role_datum_t * r)
-{
-	role_datum_t *role;
-	char *role_id;
-	ebitmap_node_t *node;
-	unsigned int i;
-	int ret;
-
-	if (pass == 1) {
-		role_id = queue_remove(id_queue);
-		free(role_id);
-		return (role_datum_t *) 1;	/* any non-NULL value */
-	}
-
-	yywarn("Role dominance has been deprecated");
-
-	role_id = queue_remove(id_queue);
-	if (!is_id_in_scope(SYM_ROLES, role_id)) {
-		yyerror2("role %s is not within scope", role_id);
-		free(role_id);
-		return NULL;
-	}
-	role = (role_datum_t *) hashtab_search(policydbp->p_roles.table,
-					       role_id);
-	if (!role) {
-		role = (role_datum_t *) malloc(sizeof(role_datum_t));
-		if (!role) {
-			yyerror("out of memory");
-			free(role_id);
-			return NULL;
-		}
-		memset(role, 0, sizeof(role_datum_t));
-		ret =
-		    declare_symbol(SYM_ROLES, (hashtab_key_t) role_id,
-				   (hashtab_datum_t) role, &role->s.value,
-				   &role->s.value);
-		switch (ret) {
-		case -3:{
-				yyerror("Out of memory!");
-				goto cleanup;
-			}
-		case -2:{
-				yyerror2("duplicate declaration of role %s",
-					 role_id);
-				goto cleanup;
-			}
-		case -1:{
-				yyerror("could not declare role here");
-				goto cleanup;
-			}
-		case 0:
-		case 1:{
-				break;
-			}
-		default:{
-				assert(0);	/* should never get here */
-			}
-		}
-		if (ebitmap_set_bit(&role->dominates, role->s.value - 1, TRUE)) {
-			yyerror("Out of memory!");
-			goto cleanup;
-		}
-	}
-	if (r) {
-		ebitmap_t types;
-		ebitmap_init(&types);
-		ebitmap_for_each_positive_bit(&r->dominates, node, i) {
-			if (ebitmap_set_bit(&role->dominates, i, TRUE))
-				goto oom;
-		}
-		if (type_set_expand(&r->types, &types, policydbp, 1)) {
-			ebitmap_destroy(&types);
-			return NULL;
-		}
-		ebitmap_for_each_positive_bit(&types, node, i) {
-			if (ebitmap_set_bit(&role->types.types, i, TRUE))
-				goto oom;
-		}
-		ebitmap_destroy(&types);
-		if (!r->s.value) {
-			/* free intermediate result */
-			type_set_destroy(&r->types);
-			ebitmap_destroy(&r->dominates);
-			free(r);
-		}
-		/*
-		 * Now go through all the roles and escalate this role's
-		 * dominates and types if a role dominates this role.
-		 */
-		hashtab_map(policydbp->p_roles.table,
-			    dominate_role_recheck, role);
-	}
-	return role;
-      cleanup:
-	free(role_id);
-	role_datum_destroy(role);
-	free(role);
-	return NULL;
-      oom:
-	yyerror("Out of memory");
-	goto cleanup;
-}
-
 static int role_val_to_name_helper(hashtab_key_t key, hashtab_datum_t datum,
 				   void *p)
 {
diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
index c1314871..7c5a4e6c 100644
--- a/checkpolicy/policy_define.h
+++ b/checkpolicy/policy_define.h
@@ -69,8 +69,6 @@ int define_validatetrans(constraint_expr_t *expr);
 int expand_attrib(void);
 int insert_id(const char *id,int push);
 int insert_separator(int push);
-role_datum_t *define_role_dom(role_datum_t *r);
-role_datum_t *merge_roles_dom(role_datum_t *r1,role_datum_t *r2);
 uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t arg2);
 
 #endif /* _POLICY_DEFINE_H_ */
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index 6b6890a3..02b076c7 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -76,7 +76,6 @@ typedef int (* require_func_t)(int pass);
 %type <ptr> cond_expr cond_expr_prim cond_pol_list cond_else
 %type <ptr> cond_allow_def cond_auditallow_def cond_auditdeny_def cond_dontaudit_def
 %type <ptr> cond_transition_def cond_te_avtab_def cond_rule_def
-%type <ptr> role_def roles
 %type <valptr> cexpr cexpr_prim op role_mls_op
 %type <val> ipv4_addr_def number
 %type <val64> number64
@@ -312,7 +311,6 @@ te_rbac_decl		: te_decl
                         ;
 rbac_decl		: attribute_role_def
 			| role_type_def
-                        | role_dominance
                         | role_trans_def
  			| role_allow_def
 			| roleattribute_def
@@ -515,8 +513,6 @@ role_type_def		: ROLE identifier TYPES names ';'
 role_attr_def		: ROLE identifier opt_attr_list ';'
  			{if (define_role_attr()) return -1;}
                         ;
-role_dominance		: DOMINANCE '{' roles '}'
-			;
 role_trans_def		: ROLE_TRANSITION names names identifier ';'
 			{if (define_role_trans(0)) return -1; }
 			| ROLE_TRANSITION names names ':' names identifier ';'
@@ -525,16 +521,6 @@ role_trans_def		: ROLE_TRANSITION names names identifier ';'
 role_allow_def		: ALLOW names names ';'
 			{if (define_role_allow()) return -1; }
 			;
-roles			: role_def
-			{ $$ = $1; }
-			| roles role_def
-			{ $$ = merge_roles_dom((role_datum_t*)$1, (role_datum_t*)$2); if ($$ == 0) return -1;}
-			;
-role_def		: ROLE identifier_push ';'
-                        {$$ = define_role_dom(NULL); if ($$ == 0) return -1;}
-			| ROLE identifier_push '{' roles '}'
-                        {$$ = define_role_dom((role_datum_t*)$4); if ($$ == 0) return -1;}
-			;
 roleattribute_def	: ROLEATTRIBUTE identifier id_comma_list ';'
 			{if (define_roleattribute()) return -1;}
 			;
-- 
2.41.0

