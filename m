Return-Path: <SRS0=Lh2G=7C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC98C433DF
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 15:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A787D206B6
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 15:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiK1kvQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgETPmf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 May 2020 11:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETPmf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 May 2020 11:42:35 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14153C061A0E
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 08:42:35 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n14so3970110qke.8
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 08:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aAMzysKhLmPEhQYwqe5E6+gXwQ7G/bkDuUsOLPexA7M=;
        b=eiK1kvQ0vk3lkkHDCL/DFyYW+GlWsQjCyOjisJBhaxxQAQIq7q/YVx81a8/CpPGoV+
         oIdwBHpRnhfBUGi/aRxcrI0J9RiiP04pLMUozxtyO0/hS5pyHBa9sldF9EYPbJCOYKy4
         MedlHn5rZFSMBE1vxrEZNsf1iHsXZAvR05Tdw3yo89tusyt/9o7Py+7U71p/6+YzaJF2
         r2xJKWhONv9l3Iqg9SzbskjsS7E3vH0Qj150fs8sIFRAkwNXeiTtJEkFkIxhOLYvq4ck
         oQs1eOgbvFcxAf2JfuqKe08Pl39trMMOfF4YdtASTaGfitJg/kpsuQ8YJAs3t8ki2jLi
         nIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aAMzysKhLmPEhQYwqe5E6+gXwQ7G/bkDuUsOLPexA7M=;
        b=l1sMNDCvxE4iGbRXSk7WXPWW+MTxNJLDG1AKkzRUBKEQzgeJbsJTVQdd6Ckdtgpz0z
         845PZ+tkSVrLBqpPOHcM74AxUFPjzavYWaKpkFIhU8oxeMYm+awjMEAT9fsjtynNCZMk
         UgRo/bPuLsA03GmmKjs1JcAEzKwULmSFHwGyCnI5FDuxmijHYevjfZjtja9fhn1oUPbw
         Fy1HxyLD2cjKvY5bP01YWGF7YcqhLyZ+Xsra5JSGhF72xFDnf4jO0fpVUmS0KO02npZL
         L5/0F4wtIpiGrCdfwSZpjX0lw3cAFn5WidB0DKnH1K6QHa0385ua4iFkzwi+SXcP5il5
         Zlpw==
X-Gm-Message-State: AOAM530qe/WMr/yzJadHPhBFIHtwhJkWI4ydbJ7Qvq0I9oqYZhLH0Ita
        FUymQt2aQtEu16R3f5DH3EGSn94b9ck=
X-Google-Smtp-Source: ABdhPJxCzQaiHLXKRpMAv8efkeNmGHNqhwVxZxjcT+b41gq62rXDO7LQQ3Qu5kZHlL2ZuC4cO6KPCg==
X-Received: by 2002:a37:9a48:: with SMTP id c69mr5234412qke.282.1589989354162;
        Wed, 20 May 2020 08:42:34 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-99-106.bltmmd.east.verizon.net. [71.166.99.106])
        by smtp.gmail.com with ESMTPSA id 62sm2448813qkh.113.2020.05.20.08.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 08:42:33 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol: Fix type alias handling in kernel_to_conf
Date:   Wed, 20 May 2020 11:42:13 -0400
Message-Id: <20200520154213.117606-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200520154213.117606-1-jwcart2@gmail.com>
References: <20200520154213.117606-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Type alias rules are not written out when converting a binary kernel
policy to a policy.conf. The problem is that type aliases are not in
the type_val_to_struct array and that is what is being used to find
the aliases.

Since type aliases are only in the types hashtable, walk that to
find the type aliases.

Fixes: 0a08fd1e69797d6a ("libsepol: Add ability to convert binary
       policy to policy.conf file")

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/kernel_to_conf.c | 45 +++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index 9de64832..78b7cc0b 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -1353,34 +1353,55 @@ exit:
 	return rc;
 }
 
+static int map_count_type_aliases(char *key, void *data, void *args)
+{
+	type_datum_t *datum = data;
+	unsigned *count = args;
+
+	if (datum->primary == 0 && datum->flavor == TYPE_TYPE)
+		(*count)++;
+
+	return SEPOL_OK;
+}
+
+static int map_type_aliases_to_strs(char *key, void *data, void *args)
+{
+	type_datum_t *datum = data;
+	struct strs *strs = args;
+	int rc = 0;
+
+	if (datum->primary == 0 && datum->flavor == TYPE_TYPE)
+		rc = strs_add(strs, key);
+
+	return rc;
+}
+
 static int write_type_alias_rules_to_conf(FILE *out, struct policydb *pdb)
 {
 	type_datum_t *alias;
 	struct strs *strs;
 	char *name;
 	char *type;
-	unsigned i, num;
+	unsigned i, num = 0;
 	int rc = 0;
 
-	rc = strs_init(&strs, pdb->p_types.nprim);
+	rc = hashtab_map(pdb->p_types.table, map_count_type_aliases, &num);
 	if (rc != 0) {
 		goto exit;
 	}
 
-	for (i=0; i < pdb->p_types.nprim; i++) {
-		alias = pdb->type_val_to_struct[i];
-		if (!alias->primary) {
-			rc = strs_add(strs, pdb->p_type_val_to_name[i]);
-			if (rc != 0) {
-				goto exit;
-			}
-		}
+	rc = strs_init(&strs, num);
+	if (rc != 0) {
+		goto exit;
 	}
 
+	rc = hashtab_map(pdb->p_types.table, map_type_aliases_to_strs, strs);
+	if (rc != 0) {
+		goto exit;
+	}
+	
 	strs_sort(strs);
 
-	num = strs_num_items(strs);
-
 	for (i=0; i<num; i++) {
 		name = strs_read_at_index(strs, i);
 		if (!name) {
-- 
2.25.4

