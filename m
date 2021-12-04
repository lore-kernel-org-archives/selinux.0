Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22862C433EF
	for <selinux@archiver.kernel.org>; Sat,  4 Dec 2021 10:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhLDKi4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 4 Dec 2021 05:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbhLDKiz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 4 Dec 2021 05:38:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FF6C061354
        for <selinux@vger.kernel.org>; Sat,  4 Dec 2021 02:35:30 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l25so21799841eda.11
        for <selinux@vger.kernel.org>; Sat, 04 Dec 2021 02:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BSzVqEHQArCQJRZFOLvUMnwPXoWHlMnGm9yud/mfpfk=;
        b=Eky2LaHzkRBKL0LmVOymsv/4f+QkBFjlnnWH8g028KliVI25z3+Odfz/5ZJ7aZISy5
         nmogQKp37ZJZLVgXGs5CcW0KEU6eCvZQmDmAz+lWrsxodtxyNKt/+GQjuJtX5Nfp/hDv
         9G0LbPhQtTt805fenfECHnqMwPrDORThAd57PH5z29XVYC7/3MtnmnBjyM3U5T4EAy/3
         quBSnB6aT4mmlEv+AjcNvFFpWVTlge25rAGXlFfANOaDHbYjv2jFwEVIfVCzzfwxKHft
         VlZPF/Nk/AZlvsD+P09Xx04p+edwea1EQSenL7oTDcwXi8EhTkCoOLg9A/rxzAgqoNYw
         m+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BSzVqEHQArCQJRZFOLvUMnwPXoWHlMnGm9yud/mfpfk=;
        b=aoE1nrvy/tJN5HYBsM6cp8+YzF06RfR+woWGVhWULn1HF7ll3z6YCeTTJmgzFwXVhW
         BcV3B9r4F5bnqWSO71oxgbYLMWpaAyZTbxcSF4mnUveezVT3Ji4Y4fsrzlyrRG92f9kk
         p4j5hxtnyezivQdKb7a9N6NJ4/sEx4LIwkUdik8xOA9NlkVokuj4YEXIhRfr+Ug5+0xt
         VNTK/ezS8CyjV2u8LUPsc+f7k0HNOl2ZYZcbfjolOVBl5rlhLKm/t2h3Ic29OIqCBmb2
         SoGpsXrT4J6A9NIox1oSDEfpDa7CMYpobmZh2MGt9EjLWFh62F2W6/AUbSbkiTmepN5N
         ymvw==
X-Gm-Message-State: AOAM530LAOqcO76loT2BCfVkBwhn+AXTecq6xCB60xzSS2shbNlj+VvY
        KFYKg8FNTeGDfr6ENyF7s7KmDtfp7Q8=
X-Google-Smtp-Source: ABdhPJxIkhIfQ2OpdAZyFSgA709GK52EX3Jz63idKvw64sYa++3oN9zEO5Wz6LmlDFsWPAAlxLKuqg==
X-Received: by 2002:a17:907:7f0f:: with SMTP id qf15mr31306233ejc.560.1638614128994;
        Sat, 04 Dec 2021 02:35:28 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-006-110-042.77.6.pool.telefonica.de. [77.6.110.42])
        by smtp.gmail.com with ESMTPSA id hc16sm3192756ejc.12.2021.12.04.02.35.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:35:28 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v3 2/5] libsepol: add not-self neverallow support
Date:   Sat,  4 Dec 2021 11:35:13 +0100
Message-Id: <20211204103516.17375-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204103516.17375-1-cgzones@googlemail.com>
References: <20211124190815.12757-1-cgzones@googlemail.com>
 <20211204103516.17375-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add support for not-self neverallow rules. These do not trigger on allow
rules where the source type is exactly equal to the target type.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

---
v3:
  - use renamed ebitmap_relative_complement(), see previous commit
  - cache not-self status of avrules and add loop shortcut on target and
    source type match
v2:
  - do not change the value of RULE_SELF
---
 libsepol/include/sepol/policydb/policydb.h |  3 +-
 libsepol/src/assertion.c                   | 41 ++++++++++++++++++++--
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 4bf9f05d..11637fe8 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -285,7 +285,8 @@ typedef struct avrule {
 #define AVRULE_XPERMS	(AVRULE_XPERMS_ALLOWED | AVRULE_XPERMS_AUDITALLOW | \
 				AVRULE_XPERMS_DONTAUDIT | AVRULE_XPERMS_NEVERALLOW)
 	uint32_t specified;
-#define RULE_SELF 1
+#define RULE_SELF       (1U << 0)
+#define RULE_NOTSELF    (1U << 1)
 	uint32_t flags;
 	type_set_t stypes;
 	type_set_t ttypes;
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index dd2749a0..fe6b88ae 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -216,6 +216,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	uint32_t perms;
 	ebitmap_t src_matches, tgt_matches, self_matches, matches;
 	ebitmap_node_t *snode, *tnode;
+	const int is_avrule_notself = (avrule->flags & RULE_NOTSELF) != 0;
 	unsigned int i, j;
 
 	if ((k->specified & AVTAB_ALLOWED) == 0)
@@ -241,7 +242,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	if (rc)
 		goto oom;
 
-	if (avrule->flags == RULE_SELF) {
+	if (avrule->flags & RULE_SELF) {
 		rc = ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1]);
 		if (rc)
 			goto oom;
@@ -268,6 +269,8 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 
 		ebitmap_for_each_positive_bit(&src_matches, snode, i) {
 			ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
+				if (is_avrule_notself && i == j)
+					continue;
 				if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
 					a->errors += report_assertion_extended_permissions(handle,p, avrule,
 											i, j, cp, perms, k, avtab);
@@ -381,6 +384,7 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	unsigned int i, j;
 	ebitmap_node_t *snode, *tnode;
 	class_perm_node_t *cp;
+	const int is_avrule_notself = (avrule->flags & RULE_NOTSELF) != 0;
 	int rc;
 	int ret = 1;
 
@@ -402,7 +406,7 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	if (rc)
 		goto oom;
 
-	if (avrule->flags == RULE_SELF) {
+	if (avrule->flags & RULE_SELF) {
 		rc = ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1],
 				&p->attr_type_map[k->target_type - 1]);
 		if (rc)
@@ -418,6 +422,18 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 		}
 	}
 
+	if (is_avrule_notself) {
+		rc = ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1]);
+		if (rc)
+			goto oom;
+		rc = ebitmap_and(&self_matches, &avrule->ttypes.types, &matches);
+		if (rc)
+			goto oom;
+		rc = ebitmap_relative_complement(&tgt_matches, &self_matches);
+		if (rc)
+			goto oom;
+	}
+
 	if (ebitmap_is_empty(&tgt_matches))
 		goto exit;
 
@@ -426,6 +442,9 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 			continue;
 		ebitmap_for_each_positive_bit(&src_matches, snode, i) {
 			ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
+				if (is_avrule_notself && i == j)
+					continue;
+
 				ret = check_assertion_extended_permissions_avtab(
 						avrule, avtab, i, j, k, p);
 				if (ret)
@@ -463,7 +482,7 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	if (rc == 0)
 		goto exit;
 
-	if (avrule->flags == RULE_SELF) {
+	if (avrule->flags & RULE_SELF) {
 		/* If the neverallow uses SELF, then it is not enough that the
 		 * neverallow's source matches the src and tgt of the rule being checked.
 		 * It must match the same thing in the src and tgt, so AND the source
@@ -479,6 +498,22 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 		ebitmap_destroy(&match);
 	}
 
+	if (avrule->flags & RULE_NOTSELF) {
+		ebitmap_t match;
+		rc = ebitmap_cpy(&match, &p->attr_type_map[k->source_type - 1]);
+		if (rc) {
+			ebitmap_destroy(&match);
+			goto oom;
+		}
+		rc = ebitmap_relative_complement(&match, &p->attr_type_map[k->target_type - 1]);
+		if (rc) {
+			ebitmap_destroy(&match);
+			goto oom;
+		}
+		rc2 = ebitmap_match_any(&avrule->ttypes.types, &match);
+		ebitmap_destroy(&match);
+	}
+
 	/* neverallow may have tgts even if it uses SELF */
 	rc = ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
 	if (rc == 0 && rc2 == 0)
-- 
2.34.1

