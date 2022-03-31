Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F34FC433F5
	for <selinux@archiver.kernel.org>; Thu, 31 Mar 2022 14:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbiCaOqr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Mar 2022 10:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiCaOqr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Mar 2022 10:46:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6990FF462A
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:44:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id pv16so48633289ejb.0
        for <selinux@vger.kernel.org>; Thu, 31 Mar 2022 07:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWXU5OaJXUYGuqXkdrFP21LKs1Lyjv1V5KcWgyCV2Mo=;
        b=FIGavYQNEK/Cl4PTh9X9IMmkaOuYAMkeIYo7BsF3RIX7UDDaM9/bLMYBuhoy43yeLJ
         lNRxclYQD4VQyewJ+TdtSppT1ToqcnUbDxnx9Nhr/DMjjq6tOw3VB6Xjt421YivdhyY2
         5OTYzo/XXVD5yYKtYHG6IvsdW4w0vYjBXiQ4Mnod3t9FlWCSLWwY9uPfeMR+/ebw/dQN
         W4pYgHB634rC8pE8kuBLhdcNpqHX3cu0Kg6kPoUhRAy8i4Z0+Waf8F7curNSbF8Eq5FY
         xFtQ7TO557JkyqAAV1+lGD9bXUKYJber0gYyyJGR4T3yCJzoaFhSiQ+mKaybVRZQmXF6
         F1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vWXU5OaJXUYGuqXkdrFP21LKs1Lyjv1V5KcWgyCV2Mo=;
        b=MMQLlZ+KkXkMfn80zmFaarn2A6o/WbHewacXugdM1NWywdjDPx1LIVX/gA4/nMwDN4
         UROc3mAmNbZnvFYMiup/ovCmEEktz7+AIC2zyimyYK3NpZzNr1hFGHc3VwIpclbK0Ke3
         UEtt95PQYkrbM3dPo3uFWx5V7aFy1OYMFXnqYfwdAKajXNOJ+1OE/Wxl3pQTzsvs/aOg
         sdum3i+L92mo7dNR2Cz24mt9MiL4xnfJiDzTv1QLB6cM45YzNz094HprwBNLiM515opF
         B7ZWW69WpUoi22a4J5Td45wGFJM0BzTH13BBOblmaPkCmTrMp6MlX/LdySQnivsEt3AP
         9wPw==
X-Gm-Message-State: AOAM531IHySLHpc0pF8bJmhb73vWMuXzDSk1GQAp8HYrdrYRzmCBv8X+
        8fmzHeBP7TFLXdnczuJOl60kvtJTD2g=
X-Google-Smtp-Source: ABdhPJyT7FR9O2kYqWqUrQwoRDd1979oIGeiCmZX01mS5q5K1DLGZ1jDu5w9qjbKsxZqhL+pmADxjw==
X-Received: by 2002:a17:906:7210:b0:6d6:7881:1483 with SMTP id m16-20020a170906721000b006d678811483mr5222113ejk.227.1648737897959;
        Thu, 31 Mar 2022 07:44:57 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-006-065-043.77.6.pool.telefonica.de. [77.6.65.43])
        by smtp.gmail.com with ESMTPSA id sa32-20020a1709076d2000b006df935924c1sm9532859ejc.59.2022.03.31.07.44.57
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:44:57 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: add missing oom checks
Date:   Thu, 31 Mar 2022 16:44:52 +0200
Message-Id: <20220331144452.30869-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Check return values of memory allocation functions and propagate their
failure.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/kernel_to_cil.c  |  9 +++++++++
 libsepol/src/kernel_to_conf.c |  4 ++++
 libsepol/src/module_to_cil.c  | 11 +++++++++++
 libsepol/src/policydb.c       |  3 ++-
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 869f6940..9128ac55 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -190,6 +190,10 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 				}
 				if (!names) {
 					names = strdup("NO_IDENTIFIER");
+					if (!names) {
+						sepol_log_err("Out of memory");
+						goto exit;
+					}
 				}
 				if (strchr(names, ' ')) {
 					new_val = create_str("(%s %s (%s))", 3, op, attr1, names);
@@ -568,6 +572,11 @@ static int write_sids_to_cil(FILE *out, const char *const *sid_to_str,
 		} else {
 			snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
 			sid = strdup(unknown);
+			if (!sid) {
+				sepol_log_err("Out of memory");
+				rc = -1;
+				goto exit;
+			}
 		}
 		rc = strs_add_at_index(strs, sid, i);
 		if (rc != 0) {
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 3544f73d..63dffd9b 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -187,6 +187,10 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
 				}
 				if (!names) {
 					names = strdup("NO_IDENTIFIER");
+					if (!names) {
+						sepol_log_err("Out of memory");
+						goto exit;
+					}
 				}
 				if (strchr(names, ' ')) {
 					new_val = create_str("%s %s { %s }", 3, attr1, op, names);
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index c9e88f1e..f2e8aff0 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -393,6 +393,8 @@ static int typealias_list_create(struct policydb *pdb)
 	}
 
 	typealias_lists = calloc(max_decl_id + 1, sizeof(*typealias_lists));
+	if (!typealias_lists)
+		goto exit;
 	typealias_lists_len = max_decl_id + 1;
 
 	rc = hashtab_map(pdb->p_types.table, typealiases_gather_map, pdb);
@@ -1792,6 +1794,10 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 				}
 				if (num_names == 0) {
 					names = strdup("NO_IDENTIFIER");
+					if (!names) {
+						rc = -1;
+						goto exit;
+					}
 				} else {
 					rc = name_list_to_string(name_list, num_names, &names);
 					if (rc != 0) {
@@ -2556,6 +2562,11 @@ static int ocontext_isid_to_cil(struct policydb *pdb, const char *const *sid_to_
 			goto exit;
 		}
 		item->sid_key = strdup(sid);
+		if (!item->sid_key) {
+			log_err("Out of memory");
+			rc = -1;
+			goto exit;
+		}
 		item->next = head;
 		head = item;
 	}
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index fc71463e..5c7e35e8 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1252,7 +1252,8 @@ int policydb_index_others(sepol_handle_t * handle,
 	if (!p->type_val_to_struct)
 		return -1;
 
-	cond_init_bool_indexes(p);
+	if (cond_init_bool_indexes(p))
+		return -1;
 
 	for (i = SYM_ROLES; i < SYM_NUM; i++) {
 		free(p->sym_val_to_name[i]);
-- 
2.35.1

