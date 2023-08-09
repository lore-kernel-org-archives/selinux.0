Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521D5C04FDF
	for <selinux@archiver.kernel.org>; Wed,  9 Aug 2023 21:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjHIVCI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjHIVCI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Aug 2023 17:02:08 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C81D1BCF
        for <selinux@vger.kernel.org>; Wed,  9 Aug 2023 14:02:07 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-76af2cb7404so21240485a.0
        for <selinux@vger.kernel.org>; Wed, 09 Aug 2023 14:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691614926; x=1692219726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttG7BXXG9EKRyjx9xNnQyGuwCfvNcKZgX1sXT8Hi0KE=;
        b=hZhQepIABNsmWWHnlrSpU30EY2D6qNpIwWQjgizXT6AKLUk2quoZfUmtUNtqoIgYnA
         sh6zHBd25SzdDq/Ta7/hQ1vUJVU9LAPt1EETdLWB0Aor6R9fcl0J6O6nXAbbakrlg2z3
         b7i5AytkqSYVcGRSMErH1agQZGWzwCDV53FzeUdlQOQ1cFo/G+8ERyxZgqG0H411/G/B
         aViterx3DMV65CTTwSgzHj7Bm7j+g/kf/GpRAKySN4H4gB4V13+ciaHZ8xFeroZi3+33
         b6quDpAvjzgD/VYNCH4RKVyf86VokdP1PqUtAqYJ+IrzqSbu+rckZooIhvHqRLfRKZ1W
         WO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691614926; x=1692219726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttG7BXXG9EKRyjx9xNnQyGuwCfvNcKZgX1sXT8Hi0KE=;
        b=BG1bc6vYeoh8JzmkGxbQK7ikyOZ6w85BLI6/RRe15tS/CqoBNviBWH4XyOU0UEaK6C
         4B4Elvgdh3XgsENMqOUjnye7wCqtzl8kTStvx+QF8aHT+eT30c2R9P+CRQBN2G1UulM0
         CrLL3xJ5yEN39egZDpVoVl2NLm4Q2VmGeMh41gnYFfeJQSvuBPzG3g+Er8tiV1/rxMW6
         B49Fa0oBxYOxujuEcI56HHv67aX4j7bI9elF2Mi+zXKu5U4TwLRNyt6ucYtrswputWOA
         iJpCaCLpjww6Mqwu9C8nr3q3RFr3OXrpoC6ukuRtT1TQfe3x62pxBFB49FkbVfKzV/pl
         wsXg==
X-Gm-Message-State: AOJu0YzSRTP4DQvnzbmKq+wy3qRI3DmGsF4OFNtB253Ix+vRJYjfNxKX
        oly3jYnj7yAjzNXdjhI1rdg5G06pUlU=
X-Google-Smtp-Source: AGHT+IGH9Ps8MRbGKTaLE4ur9NdOq1jKzZceDOEOToyULc66j6lGlV5vNqrDbk0VjPrZfpdLkSkM0Q==
X-Received: by 2002:a05:620a:4481:b0:765:acf7:9572 with SMTP id x1-20020a05620a448100b00765acf79572mr195619qkp.34.1691614925691;
        Wed, 09 Aug 2023 14:02:05 -0700 (PDT)
Received: from electric.. (c-73-172-54-2.hsd1.md.comcast.net. [73.172.54.2])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a10b400b00766fbeb3e7csm4208287qkk.132.2023.08.09.14.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:02:05 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/9 v4] libsepol/cil: Add cil_write_post_ast function
Date:   Wed,  9 Aug 2023 17:01:53 -0400
Message-ID: <20230809210157.112275-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809210157.112275-1-jwcart2@gmail.com>
References: <20230809210157.112275-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The function cil_write_post_ast() will write the CIL AST after
post processing is done. Most post processing does not change the
CIL AST, this is where deny rules are processed (because to process
them, type attributes have to have been evaluated.)

When processed, deny rules may add new rules and attributes and the
deny rule itself will be removed from the AST, so using this new
function will show the results of the deny rule processing.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/include/cil/cil.h   |  1 +
 libsepol/cil/src/cil.c           | 50 ++++++++++++++++++++++++++++++++
 libsepol/cil/src/cil_write_ast.h |  1 +
 3 files changed, 52 insertions(+)

diff --git a/libsepol/cil/include/cil/cil.h b/libsepol/cil/include/cil/cil.h
index 482ca522..88e47e79 100644
--- a/libsepol/cil/include/cil/cil.h
+++ b/libsepol/cil/include/cil/cil.h
@@ -64,6 +64,7 @@ extern void cil_write_policy_conf(FILE *out, struct cil_db *db);
 extern int cil_write_parse_ast(FILE *out, cil_db_t *db);
 extern int cil_write_build_ast(FILE *out, cil_db_t *db);
 extern int cil_write_resolve_ast(FILE *out, cil_db_t *db);
+extern int cil_write_post_ast(FILE *out, cil_db_t *db);
 
 enum cil_log_level {
 	CIL_ERR = 1,
diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 4876752a..2021187d 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -687,6 +687,56 @@ exit:
 	return rc;
 }
 
+int cil_write_post_ast(FILE *out, cil_db_t *db)
+{
+	int rc = SEPOL_ERR;
+
+	if (db == NULL) {
+		goto exit;
+	}
+
+	cil_log(CIL_INFO, "Building AST from Parse Tree\n");
+	rc = cil_build_ast(db, db->parse->root, db->ast->root);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to build ast\n");
+		goto exit;
+	}
+
+	cil_log(CIL_INFO, "Destroying Parse Tree\n");
+	cil_tree_destroy(&db->parse);
+
+	cil_log(CIL_INFO, "Resolving AST\n");
+	rc = cil_resolve_ast(db, db->ast->root);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to resolve ast\n");
+		goto exit;
+	}
+
+	cil_log(CIL_INFO, "Qualifying Names\n");
+	rc = cil_fqn_qualify(db->ast->root);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to qualify names\n");
+		goto exit;
+	}
+
+	cil_log(CIL_INFO, "Compile post process\n");
+	rc = cil_post_process(db);
+	if (rc != SEPOL_OK ) {
+		cil_log(CIL_ERR, "Post process failed\n");
+		goto exit;
+	}
+
+	cil_log(CIL_INFO, "Writing Post AST\n");
+	rc = cil_write_ast(out, CIL_WRITE_AST_PHASE_POST, db->ast->root);
+	if (rc != SEPOL_OK) {
+		cil_log(CIL_ERR, "Failed to write post ast\n");
+		goto exit;
+	}
+
+exit:
+	return rc;
+}
+
 int cil_build_policydb(cil_db_t *db, sepol_policydb_t **sepol_db)
 {
 	int rc;
diff --git a/libsepol/cil/src/cil_write_ast.h b/libsepol/cil/src/cil_write_ast.h
index 3f4b9d95..6b3274a8 100644
--- a/libsepol/cil/src/cil_write_ast.h
+++ b/libsepol/cil/src/cil_write_ast.h
@@ -38,6 +38,7 @@ enum cil_write_ast_phase {
 	CIL_WRITE_AST_PHASE_PARSE = 0,
 	CIL_WRITE_AST_PHASE_BUILD,
 	CIL_WRITE_AST_PHASE_RESOLVE,
+	CIL_WRITE_AST_PHASE_POST,
 };
 
 void cil_write_ast_node(FILE *out, struct cil_tree_node *node);
-- 
2.41.0

