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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519D4C4743E
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA7460FEA
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhFHQB2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhFHQB2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:01:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FB9C061787
        for <selinux@vger.kernel.org>; Tue,  8 Jun 2021 08:59:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l1so33445553ejb.6
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xtIdW4G81bW74Br+IjP1e2QKqelXexDHXVnkHP0CJk4=;
        b=o3CGXsvqHep38ta0UBAFBAxhxuXKUJx71dPeHdhKJ8VIsT5SmWCLHYNNyqRw/S2t9v
         Utfm3T45zDqGqhtH6OH/uO9Ol0dDG52f3qHsNJrFGRvBLgl7E0I94aH1Mi4JlBbjbzAf
         HP7newv3RzEl1kRPH7wI98a7Uke9fbyxodljI9WWwVQg6R1DEyfmQ4tArMmWcX7imaOG
         oM/IwXxkJsvNLOuiBVJm2JvG5iDqTBJNzdbql40eOMcusr1YprcCa6koDzVFmYADFFEc
         eH4EXqoqlcQcvZW2J70/dlH7D0+i+MV4fQnkuIxeMA1t9WLr9BfmINm+SOr5fI/t8ilx
         ILtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtIdW4G81bW74Br+IjP1e2QKqelXexDHXVnkHP0CJk4=;
        b=gfopiam/By9Ufz8nnFMiH7mpmir3sWtq2BvG0v+MOA85N8yghyV/zZlG7oDSTwusjQ
         WTLRZPy7eylfvP2dtPdxJxaXwjqlf4VhDVnh9BrOQL9POzgUR9DN3EllThabKwi0lg6T
         3KmEV9LNEAQly2YnujvQx1nHuCkGAy4mktwWJD8IGVlZJ7VoYOrefAd22BdvGvMgHxPD
         jHrY1VgruO8i7XjSpn9pUPFMszvS2HM03leflBoeoe4dPff/7+RftHrLvA1fZ36VA51z
         KZjHvxdopgAOHFkLKKKadDzuLY5c7S/5hsqjEecshw6zOEb5Ml65f2GhVXXZl5mm47Gg
         cJBg==
X-Gm-Message-State: AOAM530AYsVtgxE0sU4smNrnmAbfSjBQnYOm8KDXOPvK3JXv1n6HSYY4
        JDIgFbLzJmjakq5jtIEABViBQtLIW/k=
X-Google-Smtp-Source: ABdhPJxZs7jZ7dKDICnHCFymdcbciFY6QTzp66ZZ2SKacoB5eTbUCKlzp+jLgc6daXIRLjLNh1aAug==
X-Received: by 2002:a17:906:a854:: with SMTP id dx20mr24616927ejb.128.1623167959871;
        Tue, 08 Jun 2021 08:59:19 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.19
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:19 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 01/23] libsepol: fix typos
Date:   Tue,  8 Jun 2021 17:58:50 +0200
Message-Id: <20210608155912.32047-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_build_ast.c   | 2 +-
 libsepol/cil/src/cil_resolve_ast.c | 2 +-
 libsepol/src/module_to_cil.c       | 2 +-
 libsepol/src/policydb_validate.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 71f14e20..42d10c87 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -3692,7 +3692,7 @@ int cil_gen_sensitivityorder(struct cil_db *db, struct cil_tree_node *parse_curr
 
 	cil_list_for_each(curr, sensorder->sens_list_str) {
 		if (curr->data == CIL_KEY_UNORDERED) {
-			cil_log(CIL_ERR, "Sensitivy order cannot be unordered.\n");
+			cil_log(CIL_ERR, "Sensitivity order cannot be unordered.\n");
 			rc = SEPOL_ERR;
 			goto exit;
 		}
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 77ffe0ff..d8481002 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -1619,7 +1619,7 @@ int cil_resolve_sensitivityorder(struct cil_tree_node *current, void *extra_args
 	cil_list_for_each(curr, sensorder->sens_list_str) {
 		rc = cil_resolve_name(current, (char *)curr->data, CIL_SYM_SENS, extra_args, &datum);
 		if (rc != SEPOL_OK) {
-			cil_log(CIL_ERR, "Failed to resolve sensitivty %s in sensitivityorder\n", (char *)curr->data);
+			cil_log(CIL_ERR, "Failed to resolve sensitivity %s in sensitivityorder\n", (char *)curr->data);
 			goto exit;
 		}
 		if (FLAVOR(datum) != CIL_SENS) {
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 496693f4..41605eb8 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -3972,7 +3972,7 @@ int sepol_module_policydb_to_cil(FILE *fp, struct policydb *pdb, int linked)
 
 	if (pdb->policy_type != SEPOL_POLICY_BASE &&
 		pdb->policy_type != SEPOL_POLICY_MOD) {
-		log_err("Policy pakcage is not a base or module");
+		log_err("Policy package is not a base or module");
 		rc = -1;
 		goto exit;
 	}
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index b2891ddd..246aa6e3 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -641,7 +641,7 @@ static int validate_scope_index(sepol_handle_t *handle, scope_index_t *scope_ind
 	return 0;
 
 bad:
-	ERR(handle, "Invalide scope");
+	ERR(handle, "Invalid scope");
 	return -1;
 }
 
-- 
2.32.0

