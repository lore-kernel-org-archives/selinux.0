Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BF1C433F5
	for <selinux@archiver.kernel.org>; Tue,  8 Mar 2022 18:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349119AbiCHS7Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Mar 2022 13:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbiCHS7Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Mar 2022 13:59:16 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C53E0C4
        for <selinux@vger.kernel.org>; Tue,  8 Mar 2022 10:58:19 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p15so41363145ejc.7
        for <selinux@vger.kernel.org>; Tue, 08 Mar 2022 10:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GO179EgjLM05oz7aaodTSZQayy2QhT8H7jL0opjf51w=;
        b=X23jrLpsvEimr4DdbHJbE08LDdZWDkpWjr5JmaU2eFtx+QODLJ3+7cBCXVL30mqWmE
         v2Ha5oazv9HNFRx2inTvp/qp4fy9UcF693W1Cb5dHx3kEiXxgTy6D4e8Dtr73OQeoDXy
         q1FW7O3F5wtmnWZBufrQ/w4/dXmv+/zbXv94ohx2S5n0xcowBTNc0qSz42HgOyCQwN67
         YQiMVWS54oauCwqa+MwZYhrRMuYuTKUVl5uQaveef4A2RCRX7GUCBrexIaBmnIXaerwS
         99fZFXRDPLuBjtXVPNwynA4CGqgVnjOpr6OCyF9ELJLAeUmI4gKaRJaaaqjLSJaAoQVh
         F1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GO179EgjLM05oz7aaodTSZQayy2QhT8H7jL0opjf51w=;
        b=OJQjMwVt0KqecrFjQy8CsP3h94XbFNTtTMDM6VNxhHa6Rqx9BxaWDoq1WBOdDr4VsJ
         5oi+amyiJo5N7NYRbdUwO+pdamsnRAtb5xk3LkaVsEVO9MdiNQqLonF4gfoZExEKxoYm
         GSkyHoHgQSh9e8o4i0RhobcJ3/q5xI/3OGBQ6yxQo3lloXfkoaxI3xQ4X1Vb2vQoC7SD
         Id8kIeNEhJxuGgTC5eHyO7jx29BTwLqP+NMpI96AJ/CnjKmZa/j5YNGQqpp7o483gQg1
         M1isq7pQP7IB43TJHQj8rfhyPo8WqZXybNOrzlumJQENECR8gN6jfKl8lQLlG+FgJmZp
         7Syg==
X-Gm-Message-State: AOAM533n3ucVFsRjJ83/j9WUT6Kuuk8UK+IuuxzTfqiHwPUxcx3wcmVs
        BLdotLLZEd4wp+SHjSGkrVlfIwoEASPYkA==
X-Google-Smtp-Source: ABdhPJzkPF9sWfLw9v/jwm2kqa2bdaVKRnPcX5GJsBSiYjUqSwii6BqYk75okOTFte7zpu1/CNdDVQ==
X-Received: by 2002:a17:906:bc9b:b0:6da:9f90:a56a with SMTP id lv27-20020a170906bc9b00b006da9f90a56amr14814081ejb.575.1646765897473;
        Tue, 08 Mar 2022 10:58:17 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-006-252-105.77.6.pool.telefonica.de. [77.6.252.105])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906961500b006daac87ddb0sm5408063ejx.140.2022.03.08.10.58.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 10:58:17 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] libsepol: reject xperm av rules in conditional statements
Date:   Tue,  8 Mar 2022 19:58:09 +0100
Message-Id: <20220308185811.72407-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Extended permission and neverallow rules are not permitted in
conditional statements.

This causes issues on policy optimization where avtab_search() might
return a non extended permission rule when searching for one.

Found by oss-fuzz (#45327)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb_validate.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 735c7a33..72063351 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -658,7 +658,7 @@ bad:
  * Functions to validate a kernel policydb
  */
 
-static int validate_avtab_key(avtab_key_t *key, validate_t flavors[])
+static int validate_avtab_key(avtab_key_t *key, int conditional, validate_t flavors[])
 {
 	if (validate_value(key->source_type, &flavors[SYM_TYPES]))
 		goto bad;
@@ -670,13 +670,16 @@ static int validate_avtab_key(avtab_key_t *key, validate_t flavors[])
 	case AVTAB_ALLOWED:
 	case AVTAB_AUDITALLOW:
 	case AVTAB_AUDITDENY:
-	case AVTAB_XPERMS_ALLOWED:
-	case AVTAB_XPERMS_AUDITALLOW:
-	case AVTAB_XPERMS_DONTAUDIT:
 	case AVTAB_TRANSITION:
 	case AVTAB_MEMBER:
 	case AVTAB_CHANGE:
 		break;
+	case AVTAB_XPERMS_ALLOWED:
+	case AVTAB_XPERMS_AUDITALLOW:
+	case AVTAB_XPERMS_DONTAUDIT:
+		if (conditional)
+			goto bad;
+		break;
 	default:
 		goto bad;
 	}
@@ -691,7 +694,7 @@ static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d, void *
 {
 	validate_t *flavors = (validate_t *)args;
 
-	if (validate_avtab_key(k, flavors))
+	if (validate_avtab_key(k, 0, flavors))
 		return -1;
 
 	if ((k->specified & AVTAB_TYPE) && validate_value(d->data, &flavors[SYM_TYPES]))
@@ -716,7 +719,7 @@ static int validate_cond_av_list(sepol_handle_t *handle, cond_av_list_t *cond_av
 
 	for (; cond_av; cond_av = cond_av->next) {
 		for (avtab_ptr = cond_av->node; avtab_ptr; avtab_ptr = avtab_ptr->next) {
-			if (validate_avtab_key(&avtab_ptr->key, flavors)) {
+			if (validate_avtab_key(&avtab_ptr->key, 1, flavors)) {
 				ERR(handle, "Invalid cond av list");
 				return -1;
 			}
@@ -726,7 +729,7 @@ static int validate_cond_av_list(sepol_handle_t *handle, cond_av_list_t *cond_av
 	return 0;
 }
 
-static int validate_avrules(sepol_handle_t *handle, avrule_t *avrule, validate_t flavors[])
+static int validate_avrules(sepol_handle_t *handle, avrule_t *avrule, int conditional, validate_t flavors[])
 {
 	class_perm_node_t *class;
 
@@ -746,14 +749,17 @@ static int validate_avrules(sepol_handle_t *handle, avrule_t *avrule, validate_t
 		case AVRULE_AUDITALLOW:
 		case AVRULE_AUDITDENY:
 		case AVRULE_DONTAUDIT:
-		case AVRULE_NEVERALLOW:
 		case AVRULE_TRANSITION:
 		case AVRULE_MEMBER:
 		case AVRULE_CHANGE:
+			break;
+		case AVRULE_NEVERALLOW:
 		case AVRULE_XPERMS_ALLOWED:
 		case AVRULE_XPERMS_AUDITALLOW:
 		case AVRULE_XPERMS_DONTAUDIT:
 		case AVRULE_XPERMS_NEVERALLOW:
+			if (conditional)
+				goto bad;
 			break;
 		default:
 			goto bad;
@@ -814,9 +820,9 @@ static int validate_cond_list(sepol_handle_t *handle, cond_list_t *cond, validat
 			goto bad;
 		if (validate_cond_av_list(handle, cond->false_list, flavors))
 			goto bad;
-		if (validate_avrules(handle, cond->avtrue_list, flavors))
+		if (validate_avrules(handle, cond->avtrue_list, 1, flavors))
 			goto bad;
-		if (validate_avrules(handle, cond->avfalse_list, flavors))
+		if (validate_avrules(handle, cond->avfalse_list, 1, flavors))
 			goto bad;
 		if (validate_bool_id_array(handle, cond->bool_ids, cond->nbools, &flavors[SYM_BOOLS]))
 			goto bad;
@@ -1098,7 +1104,7 @@ static int validate_avrule_blocks(sepol_handle_t *handle, avrule_block_t *avrule
 		for (decl = avrule_block->branch_list; decl != NULL; decl = decl->next) {
 			if (validate_cond_list(handle, decl->cond_list, flavors))
 				goto bad;
-			if (validate_avrules(handle, decl->avrules, flavors))
+			if (validate_avrules(handle, decl->avrules, 0, flavors))
 				goto bad;
 			if (validate_role_trans_rules(handle, decl->role_tr_rules, flavors))
 				goto bad;
-- 
2.35.1

