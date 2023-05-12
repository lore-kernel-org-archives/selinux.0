Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A995C77B75
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 10:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjELKKR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 06:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240347AbjELKKJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 06:10:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD69F1328A
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:09:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc1612940so17556161a12.2
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683886134; x=1686478134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3wUbKOO9skgpUw8ufZrimNwW+ZSQha9XrnsbNKEb8I=;
        b=F8alFcJpUEU+N1t/pwoy9ROgDFf1URWUKRKE1LC9iE+4E8E1N77ee5q2aCf8byliOI
         HijGLnMPMk+GiOtERYzXTXZ+WMF9AHj8LgMzgwqom64DgGMf2s880nKJWbY6irrzpch7
         9xsqkbwUu3m0ejTBchqnaxbati++xmZhzTJgu8ySVV/uZfQrJu6O1gBC3G9IY7QQO8pn
         3VDp2HGDmxG2FtMYPg+QeS+92fCwOg/Zi2HDE8vDNCxgeBQI0qsw1TRus/3VEwyX83aP
         mmKvcrSHFtMHNQle7TVbt6E05WmaoYWs88ubRrFFCMJ9gxd9nCUNJ7sbVjxmncYzlnlV
         zJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683886134; x=1686478134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3wUbKOO9skgpUw8ufZrimNwW+ZSQha9XrnsbNKEb8I=;
        b=jb9lNovx/NtPYVNvWx0Pfsr+nHvsGgobhBfzOROJ5HWi8vBcjMdfZ4Qz4hBwNWOs19
         BIOCSbdXJxmM9s9lzXCMkrrIPndyC3W2enPGO+w1nIvIK2kKjt7gyL8+JBu6jOz+C1Al
         xawgxB3U+DpKBMoUNIP8WZVLXWXx9IvgyrtNfxkGG4EtrIjwVatvPInQMEELX2lXf1B+
         IJy2j4OwF+SASijWq7BxPCkVTi4ANnX8XUxYQvAoSTcHZe2Njr8hMbbCFCm6hmfgW0n5
         vKt10eAM+taoRNySQRagvZ02uJ2yAh764zdVrHicDq92Ij/INZSE4Sn9EE8fGLJowx40
         O3Og==
X-Gm-Message-State: AC+VfDxNnbKheihQZ5hDnUz9UIo/SD1anw5B8iC2zz2FjW081LTc9aI6
        ReDkntkMREX3xc7QQlPEOXYTk+hcw89Oqg==
X-Google-Smtp-Source: ACHHUZ7YsQhZiRDDrt8pQz4lfhDcl4QlloTcMr3kzYixQnhUNIN+tJpNlHX3EFFEAkDFnsoykatWNQ==
X-Received: by 2002:aa7:c950:0:b0:50b:fb85:8608 with SMTP id h16-20020aa7c950000000b0050bfb858608mr18752751edt.25.1683886134323;
        Fri, 12 May 2023 03:08:54 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id r9-20020a056402018900b0050dab547fc6sm3841775edv.74.2023.05.12.03.08.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:08:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2] checkpolicy/dismod: misc improvements
Date:   Fri, 12 May 2023 12:08:45 +0200
Message-Id: <20230512100845.63558-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230331173442.101678-3-cgzones@googlemail.com>
References: <20230331173442.101678-3-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

* fix minus self formatting in neverallow rules, avoiding `~ - self`

* show neverallow and neverallowxperm rules

* whitespace improvements in output
  - avoid duplicate whitespaces before permission list, since
    sepol_av_to_string() already adds a trailing one
  - avoid duplicate whitespace after wildcard type
  - unify indentation for xperm rules

* drop unused global variables

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   drop extra whitespace in between ~ and { for type sets
   (there are still some minor spacing issues like
       neverallow  test1_t ~ self : file { read };
   but they would need an overhaul of the common display_id() function)
---
 checkpolicy/test/dismod.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 929ee308..5ec33860 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -54,11 +54,8 @@
 #define DISPLAY_AVBLOCK_FILENAME_TRANS	7
 
 static policydb_t policydb;
-extern unsigned int ss_initialized;
 
-int policyvers = MOD_POLICYDB_VERSION_BASE;
-
-static const char *symbol_labels[9] = {
+static const char *const symbol_labels[9] = {
 	"commons",
 	"classes", "roles  ", "types  ", "users  ", "bools  ",
 	"levels ", "cats   ", "attribs"
@@ -86,12 +83,12 @@ static void render_access_bitmap(ebitmap_t * map, uint32_t class,
 {
 	unsigned int i;
 	char *perm;
-	fprintf(fp, "{");
+	fprintf(fp, " {");
 	for (i = ebitmap_startbit(map); i < ebitmap_length(map); i++) {
 		if (ebitmap_get_bit(map, i)) {
 			perm = sepol_av_to_string(p, class, UINT32_C(1) << i);
 			if (perm)
-				fprintf(fp, " %s", perm);
+				fprintf(fp, "%s", perm);
 		}
 	}
 	fprintf(fp, " }");
@@ -117,10 +114,12 @@ static int display_type_set(type_set_t * set, uint32_t flags, policydb_t * polic
 	unsigned int i, num_types;
 
 	if (set->flags & TYPE_STAR) {
-		fprintf(fp, " * ");
+		fprintf(fp, " *");
 		return 0;
 	} else if (set->flags & TYPE_COMP) {
 		fprintf(fp, " ~");
+	} else {
+		fprintf(fp, " ");
 	}
 
 	num_types = 0;
@@ -170,7 +169,10 @@ static int display_type_set(type_set_t * set, uint32_t flags, policydb_t * polic
 	}
 
 	if (flags & RULE_NOTSELF) {
-		fprintf(fp, " -self");
+		if (set->flags & TYPE_COMP)
+			fprintf(fp, " self");
+		else
+			fprintf(fp, " -self");
 	}
 
 	if (num_types > 1)
@@ -234,6 +236,9 @@ static int display_avrule(avrule_t * avrule, policydb_t * policy,
 		if (avrule->specified & AVRULE_DONTAUDIT) {
 			fprintf(fp, "  dontaudit");
 		}
+		if (avrule->specified & AVRULE_NEVERALLOW) {
+			fprintf(fp, "  neverallow");
+		}
 	} else if (avrule->specified & AVRULE_TYPE) {
 		if (avrule->specified & AVRULE_TRANSITION) {
 			fprintf(fp, "  type_transition");
@@ -244,15 +249,15 @@ static int display_avrule(avrule_t * avrule, policydb_t * policy,
 		if (avrule->specified & AVRULE_CHANGE) {
 			fprintf(fp, "  type_change");
 		}
-	} else if (avrule->specified & AVRULE_NEVERALLOW) {
-		fprintf(fp, "  neverallow");
 	} else if (avrule->specified & AVRULE_XPERMS) {
 		if (avrule->specified & AVRULE_XPERMS_ALLOWED)
-			fprintf(fp, "allowxperm ");
+			fprintf(fp, "  allowxperm");
 		else if (avrule->specified & AVRULE_XPERMS_AUDITALLOW)
-			fprintf(fp, "auditallowxperm ");
+			fprintf(fp, "  auditallowxperm");
 		else if (avrule->specified & AVRULE_XPERMS_DONTAUDIT)
-			fprintf(fp, "dontauditxperm ");
+			fprintf(fp, "  dontauditxperm");
+		else if (avrule->specified & AVRULE_XPERMS_NEVERALLOW)
+			fprintf(fp, "  neverallowxperm");
 	} else {
 		fprintf(fp, "     ERROR: no valid rule type specified\n");
 		return -1;
@@ -560,7 +565,7 @@ static int display_scope_index(scope_index_t * indices, policydb_t * p,
 								     p, out_fp);
 					} else {
 						fprintf(out_fp,
-							"<no perms known>");
+							" <no perms known>");
 					}
 				}
 			}
-- 
2.40.1

