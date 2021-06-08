Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B0DC4743F
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20A660FEA
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhFHQB2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhFHQB2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:01:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838BAC061789
        for <selinux@vger.kernel.org>; Tue,  8 Jun 2021 08:59:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id he7so14012665ejc.13
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 08:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ty8GekRQ/JaeL0oD8unL+aEzUu4oz9pGY5yY4pa6Ao8=;
        b=uHMnM1wJ8/2ofH+UrNZCMHL0vGGxPJRbRFNCy1lq3waJAw45hM9kcOQUCtxkUMd4AC
         CuogF8thbcAwCc1DKuKKwFkYWgKIsX7Al9RNvucE+RL8BCtjyW2zgZoL/IPMy+KkUdTO
         IITRAKQt7aWnM8+i+8+OKgats+bcyskDabQib/fwt0qw09XffgHd0ZaJvWd5D2LoMcP7
         qn/CPoEtcuvQSnhXRrYCngM9O7bvvDFnLiAG8N+LpMH67yGhdZfqpSTokGdiwh/iSRse
         wtUbS+zeEdtoqCz18jg4i8Y42ou5ObYqnVwzEyFOKh//WzUDE6rxKubYu2E38UgMh8A8
         BrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ty8GekRQ/JaeL0oD8unL+aEzUu4oz9pGY5yY4pa6Ao8=;
        b=V5QCjZWL+8oWLgrFvKEioSGL6zxRZ2jIsJvwiWkLv000bD9qtsHKk+rl8AH8YJ5Ia4
         LTj/WlZCd6bd2vn1lS1ymJUdY+BNzHaw/4YX/9kBPtO8jCX5Q5ZYrHowNu1gR0XzG8QD
         9pALl6R9dl5HM1VhCMXykEcTXlO1Kc8lssaryQ72zrxkAw2Cf4GSU7og+mi+mFNno3dD
         vf2G6zlNh2m8n0lBYs1tY+p8COgFnPVRbMUOvmaDJzel1PMOfBIFUwql+MxwAdn6QMsz
         L/uEO4r7VEb/FlesSFkgwkqJ3OR/XR0iKYSGcUVb0crMghFOx2gz4A7w2hCtrLSI9zJE
         USzw==
X-Gm-Message-State: AOAM533Aa8YX6A7LL8NLyp6ua0CiiTb435mxlTjJBLQNfyLbtC/kgwIu
        C8zJV17l712Q/piZBWSv/1JGEY9iWeU=
X-Google-Smtp-Source: ABdhPJzz6/kNK+B5ku+kEFy/ZCglyqwedLCfV6SQi7PyZ2dWTmTXSAbmPPsC7XmPEG1lUGLDSRivxg==
X-Received: by 2002:a17:907:3e1a:: with SMTP id hp26mr24275922ejc.77.1623167960424;
        Tue, 08 Jun 2021 08:59:20 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:20 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 02/23] libsepol: resolve missing prototypes
Date:   Tue,  8 Jun 2021 17:58:51 +0200
Message-Id: <20210608155912.32047-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Declare the functions as static or include the corresponding header
file.

assertion.c:294:5: error: no previous prototype for function 'report_assertion_failures' [-Werror,-Wmissing-prototypes]
int report_assertion_failures(sepol_handle_t *handle, policydb_t *p, avrule_t *avrule)
    ^

context.c:23:5: error: no previous prototype for function 'sepol_check_context' [-Werror,-Wmissing-prototypes]
int sepol_check_context(const char *context)
    ^

expand.c:3377:5: error: no previous prototype for function 'expand_cond_av_node' [-Werror,-Wmissing-prototypes]
int expand_cond_av_node(policydb_t * p,
    ^

policydb.c:638:6: error: no previous prototype for function 'role_trans_rule_destroy' [-Werror,-Wmissing-prototypes]
void role_trans_rule_destroy(role_trans_rule_t * x)
     ^

policydb.c:1169:5: error: no previous prototype for function 'policydb_index_decls' [-Werror,-Wmissing-prototypes]
int policydb_index_decls(sepol_handle_t * handle, policydb_t * p)
    ^

policydb.c:1429:6: error: no previous prototype for function 'ocontext_selinux_free' [-Werror,-Wmissing-prototypes]
void ocontext_selinux_free(ocontext_t **ocontexts)
     ^

policydb.c:1451:6: error: no previous prototype for function 'ocontext_xen_free' [-Werror,-Wmissing-prototypes]
void ocontext_xen_free(ocontext_t **ocontexts)
     ^

policydb.c:1750:5: error: no previous prototype for function 'type_set_or' [-Werror,-Wmissing-prototypes]
int type_set_or(type_set_t * dst, type_set_t * a, type_set_t * b)
    ^

policydb.c:2524:5: error: no previous prototype for function 'role_trans_read' [-Werror,-Wmissing-prototypes]
int role_trans_read(policydb_t *p, struct policy_file *fp)
    ^

policydb.c:2567:5: error: no previous prototype for function 'role_allow_read' [-Werror,-Wmissing-prototypes]
int role_allow_read(role_allow_t ** r, struct policy_file *fp)
    ^

policydb.c:2842:5: error: no previous prototype for function 'filename_trans_read' [-Werror,-Wmissing-prototypes]
int filename_trans_read(policydb_t *p, struct policy_file *fp)
    ^

services.c:1027:5: error: no previous prototype for function 'sepol_validate_transition' [-Werror,-Wmissing-prototypes]
int sepol_validate_transition(sepol_security_id_t oldsid,
    ^

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/assertion.c        |  2 +-
 libsepol/src/context_internal.h |  1 +
 libsepol/src/expand.c           |  6 +++---
 libsepol/src/policydb.c         | 16 ++++++++--------
 libsepol/src/services.c         |  2 +-
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 266f67d7..dd2749a0 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -291,7 +291,7 @@ exit:
 	return rc;
 }
 
-int report_assertion_failures(sepol_handle_t *handle, policydb_t *p, avrule_t *avrule)
+static int report_assertion_failures(sepol_handle_t *handle, policydb_t *p, avrule_t *avrule)
 {
 	int rc;
 	struct avtab_match_args args;
diff --git a/libsepol/src/context_internal.h b/libsepol/src/context_internal.h
index 3cae28cc..3dc9cd15 100644
--- a/libsepol/src/context_internal.h
+++ b/libsepol/src/context_internal.h
@@ -1,6 +1,7 @@
 #ifndef _SEPOL_CONTEXT_INTERNAL_H_
 #define _SEPOL_CONTEXT_INTERNAL_H_
 
+#include <sepol/context.h>
 #include <sepol/context_record.h>
 
 #endif
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index a656ffad..84bfcfa3 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -3374,9 +3374,9 @@ static int expand_cond_insert(cond_av_list_t ** l,
 	return 0;
 }
 
-int expand_cond_av_node(policydb_t * p,
-			avtab_ptr_t node,
-			cond_av_list_t ** newl, avtab_t * expa)
+static int expand_cond_av_node(policydb_t * p,
+			       avtab_ptr_t node,
+			       cond_av_list_t ** newl, avtab_t * expa)
 {
 	avtab_key_t *k = &node->key;
 	avtab_datum_t *d = &node->datum;
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index ffa27971..3f7ddb11 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -635,7 +635,7 @@ void role_trans_rule_init(role_trans_rule_t * x)
 	ebitmap_init(&x->classes);
 }
 
-void role_trans_rule_destroy(role_trans_rule_t * x)
+static void role_trans_rule_destroy(role_trans_rule_t * x)
 {
 	if (x != NULL) {
 		role_set_destroy(&x->roles);
@@ -1166,7 +1166,7 @@ int policydb_index_bools(policydb_t * p)
 	return 0;
 }
 
-int policydb_index_decls(sepol_handle_t * handle, policydb_t * p)
+static int policydb_index_decls(sepol_handle_t * handle, policydb_t * p)
 {
 	avrule_block_t *curblock;
 	avrule_decl_t *decl;
@@ -1426,7 +1426,7 @@ static int range_tr_destroy(hashtab_key_t key, hashtab_datum_t datum,
 	return 0;
 }
 
-void ocontext_selinux_free(ocontext_t **ocontexts)
+static void ocontext_selinux_free(ocontext_t **ocontexts)
 {
 	ocontext_t *c, *ctmp;
 	int i;
@@ -1448,7 +1448,7 @@ void ocontext_selinux_free(ocontext_t **ocontexts)
 	}
 }
 
-void ocontext_xen_free(ocontext_t **ocontexts)
+static void ocontext_xen_free(ocontext_t **ocontexts)
 {
 	ocontext_t *c, *ctmp;
 	int i;
@@ -1747,7 +1747,7 @@ int symtab_insert(policydb_t * pol, uint32_t sym,
 	return retval;
 }
 
-int type_set_or(type_set_t * dst, type_set_t * a, type_set_t * b)
+static int type_set_or(type_set_t * dst, type_set_t * a, type_set_t * b)
 {
 	type_set_init(dst);
 
@@ -2521,7 +2521,7 @@ static int type_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 	return -1;
 }
 
-int role_trans_read(policydb_t *p, struct policy_file *fp)
+static int role_trans_read(policydb_t *p, struct policy_file *fp)
 {
 	role_trans_t **t = &p->role_tr;
 	unsigned int i;
@@ -2564,7 +2564,7 @@ int role_trans_read(policydb_t *p, struct policy_file *fp)
 	return 0;
 }
 
-int role_allow_read(role_allow_t ** r, struct policy_file *fp)
+static int role_allow_read(role_allow_t ** r, struct policy_file *fp)
 {
 	unsigned int i;
 	uint32_t buf[2], nel;
@@ -2839,7 +2839,7 @@ err:
 	return -1;
 }
 
-int filename_trans_read(policydb_t *p, struct policy_file *fp)
+static int filename_trans_read(policydb_t *p, struct policy_file *fp)
 {
 	unsigned int i;
 	uint32_t buf[1], nel;
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 6596431c..39fbd979 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -1024,7 +1024,7 @@ static int context_struct_compute_av(context_struct_t * scontext,
 	return 0;
 }
 
-int sepol_validate_transition(sepol_security_id_t oldsid,
+static int sepol_validate_transition(sepol_security_id_t oldsid,
 				     sepol_security_id_t newsid,
 				     sepol_security_id_t tasksid,
 				     sepol_security_class_t tclass)
-- 
2.32.0

