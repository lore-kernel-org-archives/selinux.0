Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8334AC77B60
	for <selinux@archiver.kernel.org>; Fri, 31 Mar 2023 17:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjCaRfJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 13:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjCaRfI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Mar 2023 13:35:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E57C1E72A
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 10:35:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so92601462ede.8
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1680284105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duzBxFc9kKSjBG7483XjC2C2FRJYWNZxBjCwIZqXL6A=;
        b=p7U+3g70yL/WPrPKhB3eI1Yysdu/rk4MHqTLzwfK8TmjbigiwF+Mul7XQEZZ7/JoPd
         pQr4s53eHyympHoqgFpKRYa8Y1gL1lPeZEni35cc7R08BhWYWHzf4jDx/jcF8D6xUZE5
         TQO/1QGJ0jrVbXTCtmi1M1yGPDIerbGdj7AF9abEvVegtXLkixf7E9jn5/g8a52T1uJu
         zoYUsdrgJIYowAsaLogJc8ewO4TKQVBeHW3VhlptAJ4TNzDQpwFdBtqw99zorWbNdC09
         v+IOk8coPRQJ+E9H9QMvZoIPJV0LVMx6AbaHzClz3Djv3b5xijGHSXmTFDStMQHvAPYw
         Drow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680284105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duzBxFc9kKSjBG7483XjC2C2FRJYWNZxBjCwIZqXL6A=;
        b=kJNUVFbUbfUyD4mODmSzGmFD8fOkcbe+hB/Tni//Ue/4OsoNsweDDVHcdeoozlWL4/
         fzLTwiwKbJFr1AZXymM7/IOlZ74tGMxTh/Zy91aSu9LTqvhwD47vkOBfIrt2B2ny2mEt
         1lMguXiueitQbabN9AyevsJK20g7IpNzEugr08DhUxRwCDQdtbV25dXDqj6VRWpLzxGj
         zflzH2i1FzdMshjd4W8edOo6wwEN7Z51Pn+dEGQlZNxzYSvMj3kdIs44qT0ENcLlCsXO
         zIGOiQUXqmZi7zwsCVuUrce/h8gM3oQLxdMejKz3qdJYRriPMLVJIBo3n/J3nUnzY08X
         i1/w==
X-Gm-Message-State: AAQBX9cI7TLQMdpPOIqcYyxmoyJL/Ls5QtQ013KnRitqGr7qssJvFK2D
        DLQ/jotfwC/YxyTvnLNRK7O3KmmwotWDpyYn
X-Google-Smtp-Source: AKy350bcjNIWdmSPlVM2Ua097btN4PlLkH7aU0ks7Rl+yn9FdyFQobaGcxe8Xhi+7mrkCeUxH6NeqA==
X-Received: by 2002:aa7:d885:0:b0:4fd:2155:74ef with SMTP id u5-20020aa7d885000000b004fd215574efmr27858810edq.19.1680284105659;
        Fri, 31 Mar 2023 10:35:05 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-010-126-250.77.10.pool.telefonica.de. [77.10.126.250])
        by smtp.gmail.com with ESMTPSA id h5-20020a50c385000000b004ad601533a3sm1303138edf.55.2023.03.31.10.35.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:35:05 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] checkpolicy/dismod: misc improvements
Date:   Fri, 31 Mar 2023 19:34:42 +0200
Message-Id: <20230331173442.101678-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331173442.101678-1-cgzones@googlemail.com>
References: <20230331173442.101678-1-cgzones@googlemail.com>
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
 checkpolicy/test/dismod.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index a2d74d42..ebc1eec3 100644
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
@@ -117,7 +114,7 @@ static int display_type_set(type_set_t * set, uint32_t flags, policydb_t * polic
 	unsigned int i, num_types;
 
 	if (set->flags & TYPE_STAR) {
-		fprintf(fp, " * ");
+		fprintf(fp, " *");
 		return 0;
 	} else if (set->flags & TYPE_COMP) {
 		fprintf(fp, " ~");
@@ -149,7 +146,7 @@ static int display_type_set(type_set_t * set, uint32_t flags, policydb_t * polic
 	}
 
 	if (num_types > 1)
-		fprintf(fp, "{");
+		fprintf(fp, " {");
 
 	for (i = ebitmap_startbit(&set->types); i < ebitmap_length(&set->types);
 	     i++) {
@@ -170,7 +167,10 @@ static int display_type_set(type_set_t * set, uint32_t flags, policydb_t * polic
 	}
 
 	if (flags & RULE_NOTSELF) {
-		fprintf(fp, " -self");
+		if (set->flags & TYPE_COMP)
+			fprintf(fp, " self");
+		else
+			fprintf(fp, " -self");
 	}
 
 	if (num_types > 1)
@@ -234,6 +234,9 @@ static int display_avrule(avrule_t * avrule, policydb_t * policy,
 		if (avrule->specified & AVRULE_DONTAUDIT) {
 			fprintf(fp, "  dontaudit");
 		}
+		if (avrule->specified & AVRULE_NEVERALLOW) {
+			fprintf(fp, "  neverallow");
+		}
 	} else if (avrule->specified & AVRULE_TYPE) {
 		if (avrule->specified & AVRULE_TRANSITION) {
 			fprintf(fp, "  type_transition");
@@ -244,15 +247,15 @@ static int display_avrule(avrule_t * avrule, policydb_t * policy,
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
@@ -560,7 +563,7 @@ static int display_scope_index(scope_index_t * indices, policydb_t * p,
 								     p, out_fp);
 					} else {
 						fprintf(out_fp,
-							"<no perms known>");
+							" <no perms known>");
 					}
 				}
 			}
-- 
2.40.0

