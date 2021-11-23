Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB656C433F5
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 19:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbhKWTKZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhKWTKZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 14:10:25 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A309CC061714
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 11:07:16 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id r25so59483727edq.7
        for <selinux@vger.kernel.org>; Tue, 23 Nov 2021 11:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nt0jIK7SPFKBMVlvHFcofgHig0quJrfmFbQ9J8vJA7w=;
        b=h43rrrWuH9hgAHBarDjV6PYPauVY0UbVAYX7BQPL6S2OBDi0U4UIsdpGasA2yET14g
         hNQbWlncmb+dT6AcGvRIF2+kqvhEz5/viocCyq9OXfGaGRJx37aLeBU91/IxhktR2RGl
         C0P25XSbKctsUsbzgvEzP/1adFoyEf2GvNQT4cn3Gov1zIa4AFvSh0Zz+urrN1boq4Ft
         YX4mz0WLItoQzKfwJJZk0lSmUT42nbd/FKh6nlAFY+y43SReGGSg1hcKGDmzLDYllbJw
         O0Hq82lrz/JdsGbWux4zotv4tMbe+Q9ztosCSprq7Y8IbQMJPHwVUMLS3iA2FJaCD2t5
         5KhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nt0jIK7SPFKBMVlvHFcofgHig0quJrfmFbQ9J8vJA7w=;
        b=piVfguOAJAuUDIF+tOhMtbjZEfYT9nWM/F83IBIJ2RgisgeZo8O9uBtcIEbdcq46fZ
         5Agm8TUqjGs/k3KQZXuyY3NbGw/k5OVr65jejgKRsanuj2tiL/K7zId56b51ceaUnMrA
         pEvjEWURNMyBoNMa4U2gqoyklNPgxy75Wz5OKCfmReg4PDqrMS5nDjXOBa/07v0g2sZW
         GqniF/p8j+ATH/TCTA7JIau+qKjAW4469CCn0rc7/vjuYged+ImywJSfE4e0OlRrA0S0
         exEp2NeNz2RDQS96XNgNszWTtfhCLJnNbdn8+uXKVwvsFogob4Hr1eHJMoItQAIUg601
         Z4gw==
X-Gm-Message-State: AOAM531aC+P8gcAn0jtufCiVhvplEEPNHIMD1sQjxBu1o//y6/iMHHU8
        WMmnm/4ObbpJlAwLaDrHnXcoxxugRQw=
X-Google-Smtp-Source: ABdhPJwq58hcNiKEfOUCj8OtWRZQ2RqbYUHxGT3xhNVWde9DYOS1nrCul1C4raVgFQF11MRXSoWkCg==
X-Received: by 2002:a05:6402:170a:: with SMTP id y10mr13091305edu.324.1637694435097;
        Tue, 23 Nov 2021 11:07:15 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-112-244-006.95.112.pool.telefonica.de. [95.112.244.6])
        by smtp.gmail.com with ESMTPSA id e16sm7093326edz.18.2021.11.23.11.07.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 11:07:14 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 2/3] libsepol: add not-self neverallow support
Date:   Tue, 23 Nov 2021 20:07:03 +0100
Message-Id: <20211123190704.14341-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123190704.14341-1-cgzones@googlemail.com>
References: <20211123190704.14341-1-cgzones@googlemail.com>
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
 libsepol/include/sepol/policydb/policydb.h |  3 +-
 libsepol/src/assertion.c                   | 39 ++++++++++++++++++++--
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 4bf9f05d..da5256e8 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -285,7 +285,8 @@ typedef struct avrule {
 #define AVRULE_XPERMS	(AVRULE_XPERMS_ALLOWED | AVRULE_XPERMS_AUDITALLOW | \
 				AVRULE_XPERMS_DONTAUDIT | AVRULE_XPERMS_NEVERALLOW)
 	uint32_t specified;
-#define RULE_SELF 1
+#define RULE_SELF       (1U << 1)
+#define RULE_NOTSELF    (1U << 2)
 	uint32_t flags;
 	type_set_t stypes;
 	type_set_t ttypes;
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index dd2749a0..9bbeddb0 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -241,7 +241,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	if (rc)
 		goto oom;
 
-	if (avrule->flags == RULE_SELF) {
+	if (avrule->flags & RULE_SELF) {
 		rc = ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1]);
 		if (rc)
 			goto oom;
@@ -268,6 +268,8 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 
 		ebitmap_for_each_positive_bit(&src_matches, snode, i) {
 			ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
+				if ((avrule->flags & RULE_NOTSELF) && i == j)
+					continue;
 				if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
 					a->errors += report_assertion_extended_permissions(handle,p, avrule,
 											i, j, cp, perms, k, avtab);
@@ -402,7 +404,7 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	if (rc)
 		goto oom;
 
-	if (avrule->flags == RULE_SELF) {
+	if (avrule->flags & RULE_SELF) {
 		rc = ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1],
 				&p->attr_type_map[k->target_type - 1]);
 		if (rc)
@@ -418,6 +420,21 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 		}
 	}
 
+	if (avrule->flags & RULE_NOTSELF) {
+		rc = ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1]);
+		if (rc)
+			goto oom;
+		rc = ebitmap_and(&self_matches, &avrule->ttypes.types, &matches);
+		if (rc)
+			goto oom;
+
+		if (!ebitmap_is_empty(&self_matches)) {
+			rc = ebitmap_subtract(&tgt_matches, &self_matches);
+			if (rc)
+				goto oom;
+		}
+	}
+
 	if (ebitmap_is_empty(&tgt_matches))
 		goto exit;
 
@@ -463,7 +480,7 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	if (rc == 0)
 		goto exit;
 
-	if (avrule->flags == RULE_SELF) {
+	if (avrule->flags & RULE_SELF) {
 		/* If the neverallow uses SELF, then it is not enough that the
 		 * neverallow's source matches the src and tgt of the rule being checked.
 		 * It must match the same thing in the src and tgt, so AND the source
@@ -479,6 +496,22 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 		ebitmap_destroy(&match);
 	}
 
+	if (avrule->flags & RULE_NOTSELF) {
+		ebitmap_t match;
+		rc = ebitmap_cpy(&match, &p->attr_type_map[k->source_type - 1]);
+		if (rc) {
+			ebitmap_destroy(&match);
+			goto oom;
+		}
+		rc = ebitmap_subtract(&match, &p->attr_type_map[k->target_type - 1]);
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
2.34.0

