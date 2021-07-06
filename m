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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229CFC07E9B
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BAE161C44
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhGFR51 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhGFR51 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 13:57:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04A3C061574
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 10:54:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id he13so16875260ejc.11
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=owOEfCGffVGQrfJc8S5GiUOD30lI+xpvB8JQIklYJEs=;
        b=Dxon+2JImlpNNeUvX611PHcibyYd//E1+qmV4P9hQ4LNAl1LaY5OTUCTK8O2CoxE5e
         oM8CxnIxAo4K9gxkuX7QWpvgAS3OFK6DNnpeHqeg3s2STFdgr5q29LvAgpEWge8Dmv7B
         B1DkrYoQMWLV3peLmMoIU70rMZL6K8i38uUs48QH26qeorC5b5oTyMSJ3mwqfQOKFVd6
         mGoDkRTaB+iDm33IWtgPSr3/r+IYl3LAhqQ4pCIOmJc7e1+iMGZMUkt5WYEv/uz1p8UT
         mGfp+I1tgqM+haYv5/B8gE637AymnfBN8TPDMZiM06qbWbkw6L3/ks+j/SnH85PBZZ8n
         XKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=owOEfCGffVGQrfJc8S5GiUOD30lI+xpvB8JQIklYJEs=;
        b=eepHW52OCVy8DQrFafSgk/NoD0TEcgVQDQyT9Z4utDomwguILA6Elwprwj70tgFcDu
         t5dWRRlGybvgXALvkIsyzvOHGmasmIMdhXIl2aNOn9dnz0oUKH3CoBxJ/ABI/Rst6boQ
         nW4ZN2Bx1I79Riz9Hwdq/ul1MWserZWmJ5wg49ngUA5W7xeMskOu4qx0JQKxZfiBfMuP
         RUyIL2el3bPTM5TRs2iE4eiADULXKSH1kLUQvtLR4ex5Iy5ybkdbwZapqJO22iItAx1m
         ZzagxvOT1ag9u14wsaifd7G3Zmi+s5w2DjGGbFjI74AK1vrqwIIpogDNN8NiMLCNIZA2
         paVw==
X-Gm-Message-State: AOAM532FqnzTAIdftytU9vE/at/ru4mKyfMhANYPRcYi9uxPqFipUEZU
        CAT9/+YoE8+6RlzAxI6QQqFmQfT/+q4=
X-Google-Smtp-Source: ABdhPJwU99T1LvOTvCWXiDs5wNtZ/2YQspKor95fnmz+XU/vbe3ANSTpq/M+Q7oMIlLUle9OBNoPaA==
X-Received: by 2002:a17:907:7797:: with SMTP id ky23mr20070780ejc.229.1625594086509;
        Tue, 06 Jul 2021 10:54:46 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-100-174.95.116.pool.telefonica.de. [95.116.100.174])
        by smtp.gmail.com with ESMTPSA id lg16sm6050950ejb.69.2021.07.06.10.54.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:54:46 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 12/13] checkpolicy/test: mark file local functions static
Date:   Tue,  6 Jul 2021 19:54:32 +0200
Message-Id: <20210706175433.29270-12-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706175433.29270-1-cgzones@googlemail.com>
References: <20210706175433.29270-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/test/dismod.c | 36 ++++++++++++++++++------------------
 checkpolicy/test/dispol.c | 22 +++++++++++-----------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index b1b96115..90c29318 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -111,7 +111,7 @@ static void display_id(policydb_t * p, FILE * fp, uint32_t symbol_type,
 	}
 }
 
-int display_type_set(type_set_t * set, uint32_t flags, policydb_t * policy,
+static int display_type_set(type_set_t * set, uint32_t flags, policydb_t * policy,
 		     FILE * fp)
 {
 	unsigned int i, num_types;
@@ -175,7 +175,7 @@ int display_type_set(type_set_t * set, uint32_t flags, policydb_t * policy,
 	return 0;
 }
 
-int display_mod_role_set(role_set_t * roles, policydb_t * p, FILE * fp)
+static int display_mod_role_set(role_set_t * roles, policydb_t * p, FILE * fp)
 {
 	unsigned int i, num = 0;
 
@@ -210,7 +210,7 @@ int display_mod_role_set(role_set_t * roles, policydb_t * p, FILE * fp)
 
 }
 
-int display_avrule(avrule_t * avrule, policydb_t * policy,
+static int display_avrule(avrule_t * avrule, policydb_t * policy,
 		   FILE * fp)
 {
 	class_perm_node_t *cur;
@@ -313,7 +313,7 @@ int display_avrule(avrule_t * avrule, policydb_t * policy,
 	return 0;
 }
 
-int display_type_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+static int display_type_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
 	type_datum_t *type;
 	FILE *fp;
@@ -355,14 +355,14 @@ int display_type_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
 	return 0;
 }
 
-int display_types(policydb_t * p, FILE * fp)
+static int display_types(policydb_t * p, FILE * fp)
 {
 	if (hashtab_map(p->p_types.table, display_type_callback, fp))
 		return -1;
 	return 0;
 }
 
-int display_users(policydb_t * p, FILE * fp)
+static int display_users(policydb_t * p, FILE * fp)
 {
 	unsigned int i, j;
 	ebitmap_t *bitmap;
@@ -381,7 +381,7 @@ int display_users(policydb_t * p, FILE * fp)
 	return 0;
 }
 
-int display_bools(policydb_t * p, FILE * fp)
+static int display_bools(policydb_t * p, FILE * fp)
 {
 	unsigned int i;
 
@@ -392,7 +392,7 @@ int display_bools(policydb_t * p, FILE * fp)
 	return 0;
 }
 
-void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp)
+static void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp)
 {
 
 	cond_expr_t *cur;
@@ -427,14 +427,14 @@ void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp)
 	}
 }
 
-void display_policycon(FILE * fp)
+static void display_policycon(FILE * fp)
 {
 	/* There was an attempt to implement this at one time.  Look through
 	 * git history to find it. */
 	fprintf(fp, "Sorry, not implemented\n");
 }
 
-void display_initial_sids(policydb_t * p, FILE * fp)
+static void display_initial_sids(policydb_t * p, FILE * fp)
 {
 	ocontext_t *cur;
 	char *user, *role, *type;
@@ -459,7 +459,7 @@ void display_initial_sids(policydb_t * p, FILE * fp)
 #endif
 }
 
-void display_class_set(ebitmap_t *classes, policydb_t *p, FILE *fp)
+static void display_class_set(ebitmap_t *classes, policydb_t *p, FILE *fp)
 {
 	unsigned int i, num = 0;
 
@@ -482,7 +482,7 @@ void display_class_set(ebitmap_t *classes, policydb_t *p, FILE *fp)
 		fprintf(fp, " }");
 }
 
-void display_role_trans(role_trans_rule_t * tr, policydb_t * p, FILE * fp)
+static void display_role_trans(role_trans_rule_t * tr, policydb_t * p, FILE * fp)
 {
 	for (; tr; tr = tr->next) {
 		fprintf(fp, "role transition ");
@@ -495,7 +495,7 @@ void display_role_trans(role_trans_rule_t * tr, policydb_t * p, FILE * fp)
 	}
 }
 
-void display_role_allow(role_allow_rule_t * ra, policydb_t * p, FILE * fp)
+static void display_role_allow(role_allow_rule_t * ra, policydb_t * p, FILE * fp)
 {
 	for (; ra; ra = ra->next) {
 		fprintf(fp, "role allow ");
@@ -517,7 +517,7 @@ static void display_filename_trans(filename_trans_rule_t * tr, policydb_t * p, F
 	}
 }
 
-int role_display_callback(hashtab_key_t key __attribute__((unused)),
+static int role_display_callback(hashtab_key_t key __attribute__((unused)),
 			  hashtab_datum_t datum, void *data)
 {
 	role_datum_t *role;
@@ -611,7 +611,7 @@ int change_bool(char *name, int state, policydb_t * p, FILE * fp)
 }
 #endif
 
-int display_avdecl(avrule_decl_t * decl, int field,
+static int display_avdecl(avrule_decl_t * decl, int field,
 		   policydb_t * policy, FILE * out_fp)
 {
 	fprintf(out_fp, "decl %u:%s\n", decl->decl_id,
@@ -692,7 +692,7 @@ int display_avdecl(avrule_decl_t * decl, int field,
 	return 0;		/* should never get here */
 }
 
-int display_avblock(int field, policydb_t * policy,
+static int display_avblock(int field, policydb_t * policy,
 		    FILE * out_fp)
 {
 	avrule_block_t *block = policydb.global;
@@ -710,7 +710,7 @@ int display_avblock(int field, policydb_t * policy,
 	return 0;
 }
 
-int display_handle_unknown(policydb_t * p, FILE * out_fp)
+static int display_handle_unknown(policydb_t * p, FILE * out_fp)
 {
 	if (p->handle_unknown == ALLOW_UNKNOWN)
 		fprintf(out_fp, "Allow unknown classes and perms\n");
@@ -834,7 +834,7 @@ static void display_policycaps(policydb_t * p, FILE * fp)
 	}
 }
 
-int menu(void)
+static int menu(void)
 {
 	printf("\nSelect a command:\n");
 	printf("1)  display unconditional AVTAB\n");
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index 37f71842..8ddefb04 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -42,7 +42,7 @@ static __attribute__((__noreturn__)) void usage(const char *progname)
 	exit(1);
 }
 
-int render_access_mask(uint32_t mask, avtab_key_t * key, policydb_t * p,
+static int render_access_mask(uint32_t mask, avtab_key_t * key, policydb_t * p,
 		       FILE * fp)
 {
 	char *perm;
@@ -54,13 +54,13 @@ int render_access_mask(uint32_t mask, avtab_key_t * key, policydb_t * p,
 	return 0;
 }
 
-int render_type(uint32_t type, policydb_t * p, FILE * fp)
+static int render_type(uint32_t type, policydb_t * p, FILE * fp)
 {
 	fprintf(fp, "%s", p->p_type_val_to_name[type - 1]);
 	return 0;
 }
 
-int render_key(avtab_key_t * key, policydb_t * p, FILE * fp)
+static int render_key(avtab_key_t * key, policydb_t * p, FILE * fp)
 {
 	char *stype, *ttype, *tclass;
 	stype = p->p_type_val_to_name[key->source_type - 1];
@@ -84,7 +84,7 @@ int render_key(avtab_key_t * key, policydb_t * p, FILE * fp)
 #define RENDER_DISABLED		0x0004
 #define RENDER_CONDITIONAL	(RENDER_ENABLED|RENDER_DISABLED)
 
-int render_av_rule(avtab_key_t * key, avtab_datum_t * datum, uint32_t what,
+static int render_av_rule(avtab_key_t * key, avtab_datum_t * datum, uint32_t what,
 		   policydb_t * p, FILE * fp)
 {
 	if (!(what & RENDER_UNCONDITIONAL)) {
@@ -163,7 +163,7 @@ int render_av_rule(avtab_key_t * key, avtab_datum_t * datum, uint32_t what,
 	return 0;
 }
 
-int display_avtab(avtab_t * a, uint32_t what, policydb_t * p, FILE * fp)
+static int display_avtab(avtab_t * a, uint32_t what, policydb_t * p, FILE * fp)
 {
 	unsigned int i;
 	avtab_ptr_t cur;
@@ -178,7 +178,7 @@ int display_avtab(avtab_t * a, uint32_t what, policydb_t * p, FILE * fp)
 	return 0;
 }
 
-int display_bools(policydb_t * p, FILE * fp)
+static int display_bools(policydb_t * p, FILE * fp)
 {
 	unsigned int i;
 
@@ -189,7 +189,7 @@ int display_bools(policydb_t * p, FILE * fp)
 	return 0;
 }
 
-void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp)
+static void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp)
 {
 
 	cond_expr_t *cur;
@@ -224,7 +224,7 @@ void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp)
 	}
 }
 
-int display_cond_expressions(policydb_t * p, FILE * fp)
+static int display_cond_expressions(policydb_t * p, FILE * fp)
 {
 	cond_node_t *cur;
 	cond_av_list_t *av_cur;
@@ -249,7 +249,7 @@ int display_cond_expressions(policydb_t * p, FILE * fp)
 	return 0;
 }
 
-int display_handle_unknown(policydb_t * p, FILE * out_fp)
+static int display_handle_unknown(policydb_t * p, FILE * out_fp)
 {
 	if (p->handle_unknown == ALLOW_UNKNOWN)
 		fprintf(out_fp, "Allow unknown classes and permissions\n");
@@ -260,7 +260,7 @@ int display_handle_unknown(policydb_t * p, FILE * out_fp)
 	return 0;
 }
 
-int change_bool(char *name, int state, policydb_t * p, FILE * fp)
+static int change_bool(char *name, int state, policydb_t * p, FILE * fp)
 {
 	cond_bool_datum_t *bool;
 
@@ -368,7 +368,7 @@ static void display_filename_trans(policydb_t *p, FILE *fp)
 	hashtab_map(p->filename_trans, filenametr_display, &args);
 }
 
-int menu(void)
+static int menu(void)
 {
 	printf("\nSelect a command:\n");
 	printf("1)  display unconditional AVTAB\n");
-- 
2.32.0

