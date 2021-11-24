Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12A1C433EF
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 19:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350907AbhKXTLf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Nov 2021 14:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242927AbhKXTLe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Nov 2021 14:11:34 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07404C06173E
        for <selinux@vger.kernel.org>; Wed, 24 Nov 2021 11:08:24 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id e3so14986083edu.4
        for <selinux@vger.kernel.org>; Wed, 24 Nov 2021 11:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TauaxXjrhRutN6oPo6eDHF4hG+8baJDPly2T/TRVXWo=;
        b=qcFt/glqbWESWMb5mYrgdKQMOQxoGsgO62Kl3UoNDJwKCl5RwA2wgQZSpecQsw7UXf
         0tx0UF8f0aFwaAp/Jjln0Z9Dh7eyESAlB3F2eOaSZIEmOSlnOv1Gpe3E/4Am0RDlkvJW
         zsMrnjNYmbCkQ/MfDLk9DjudUPy0XrhzdMFcb1hEVJw20YTXlW+KeepcAS8W/TBVu88Q
         N/ytjLz+UWpzUrgRnvLXpKp5dH07YFz4xbIEckazdwjdPUpOPoKze/iJv5629wcpwsT8
         MIq5rvj8GXA9CV51Wbv9O1cKYdhLI6uBFPzmBarYe8gQ2FfDZgd0YoqybF7030okkkaG
         CbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TauaxXjrhRutN6oPo6eDHF4hG+8baJDPly2T/TRVXWo=;
        b=QJ5xUWTCwrAImI/p/+2eBfR1fiFc50EMdanOsfNRqdkvMXRpU2p1YE2uO0q/QPNhZ7
         kij5QMRQcHL+BHUksyomsiqHpSr3lfjFe8DE13g4szu3vkPHjAu4jsUf9iIGy5ID6rJv
         OhC0ff1eDqFy6l2cwGcjswaTh0XZRIuUNMEkKGCCOEPZ9N83vaUzFCVlTHHVLlWvRwFQ
         TzPw5Ata5I6ARVgG7p75vsNEm6HWUyFlZSFy/Ft3U7KLL0hrKuEqiZuJwwm6P7m+neRL
         xjNgfP0GOECsF1l5fkMQBbXmlTCp2UHXNUcBqdxw0Cy70yqNfQ4XxVDaHqzx2HWlR/2U
         V/dg==
X-Gm-Message-State: AOAM530hM4I9h9m3XVmd19KMssEyjI8IJdULkKESXlcHHhuAmo3eZ9Wa
        8L1tTicgHwQm4jfW+tb/Noti+CutYTqpZg==
X-Google-Smtp-Source: ABdhPJxHdSoGLUMRpiyBlcYef6KOX8Eto9M0w73+Nei3UeaKFaF+e2y2OCsg9mKgiIO9mwHHmyz+JQ==
X-Received: by 2002:a50:d8cf:: with SMTP id y15mr28816007edj.66.1637780902513;
        Wed, 24 Nov 2021 11:08:22 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-186-056.77.8.pool.telefonica.de. [77.8.186.56])
        by smtp.gmail.com with ESMTPSA id p3sm339256ejy.94.2021.11.24.11.08.22
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:08:22 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 2/4] libsepol: add not-self neverallow support
Date:   Wed, 24 Nov 2021 20:08:13 +0100
Message-Id: <20211124190815.12757-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211124190815.12757-1-cgzones@googlemail.com>
References: <20211123190704.14341-1-cgzones@googlemail.com>
 <20211124190815.12757-1-cgzones@googlemail.com>
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
v2:
  - do not change the value of RULE_SELF
---
 libsepol/include/sepol/policydb/policydb.h |  3 +-
 libsepol/src/assertion.c                   | 36 ++++++++++++++++++++--
 2 files changed, 35 insertions(+), 4 deletions(-)

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
index dd2749a0..efa136c8 100644
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
@@ -418,6 +420,18 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 		}
 	}
 
+	if (avrule->flags & RULE_NOTSELF) {
+		rc = ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1]);
+		if (rc)
+			goto oom;
+		rc = ebitmap_and(&self_matches, &avrule->ttypes.types, &matches);
+		if (rc)
+			goto oom;
+		rc = ebitmap_subtract(&tgt_matches, &self_matches);
+		if (rc)
+			goto oom;
+	}
+
 	if (ebitmap_is_empty(&tgt_matches))
 		goto exit;
 
@@ -463,7 +477,7 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 	if (rc == 0)
 		goto exit;
 
-	if (avrule->flags == RULE_SELF) {
+	if (avrule->flags & RULE_SELF) {
 		/* If the neverallow uses SELF, then it is not enough that the
 		 * neverallow's source matches the src and tgt of the rule being checked.
 		 * It must match the same thing in the src and tgt, so AND the source
@@ -479,6 +493,22 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
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

