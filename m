Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24925C47082
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCAE610A2
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhFHQCh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:02:37 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:43589 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhFHQCh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:02:37 -0400
Received: by mail-ej1-f49.google.com with SMTP id ci15so33423926ejc.10
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wt8tV6cOAtQf7ullP506otx0rkyraYe9/a8/Bp/vNP4=;
        b=ml3Oz41pqseqQB78yRju3Hw8hSXgfjsw8dR3EyTjmgV7xxwOUA0I1bzx6N8Ns1iCaE
         B/Ds+yg5bJcIbnG4ytYjCi9dn0q6vaLdxqQwupzeWBmd9iR/3LUWeA+LfWRRm6fdchxw
         qa/p86ebPs3X/N86KWhyHt2RB3hNnVkpWg78lNNTF5ZFcidij9+Uz+DGRwmsV7aB4LSY
         Synuf7snejJmp5pzX3zsTkWbJpP9TStEhlsZkwkTny7n+e/UbclUBeeHN45zUMpNiBId
         PzM1d8pAKbFSEz/B/O4hSFfaW2vFuEVzKG8ahwyjM1LLfXySPa1Oh6XdxkKm7cDktKWn
         Zoog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wt8tV6cOAtQf7ullP506otx0rkyraYe9/a8/Bp/vNP4=;
        b=LT2tvKw7IOCXnzj5x82RsW1TDkrWKmR/COMLMWFa+5vNT7bZwbMo2pBA3XO3Wf8Y+8
         p2iifhDbgb/lTnwwnosubdKZumPC4L1mK+yfysDm4HjTL4iQqrcXcO/veLW5EfRVTnZW
         KOmuhyhWZrATm+3VJnXaOBw6uszc+IDRCiuW+c6GUPbg0jTqbuZds2y/2bAx6H5C2TVD
         qf9fV/bDRBLDKhVzrEthUNjmrJttguxcroNPqF3a8jJddb3V5d4cqdS6ymBx3Du/cUsr
         wV/QUbQWJJvhQBIQYAuqOpnKlnpgNuGHLvFv3rsW07Q0MPvZz9AmTeAattPc1M+TfXaj
         9IWQ==
X-Gm-Message-State: AOAM532Fp4GPk9PJCB1HJ1RFUgUNwh+tmkm8DHlw9P2gdQzEP03S9x+7
        qKdcGVXL3TeVQizu4FKZwbHubt/MDZs=
X-Google-Smtp-Source: ABdhPJxr06kftxrDONkYwl9oHB87ZtiXrwmbPhP9AuMW7TwV0XkstNGXHgCAXqmHK+GL/tb/GCNarA==
X-Received: by 2002:a17:907:7808:: with SMTP id la8mr22170600ejc.13.1623167969889;
        Tue, 08 Jun 2021 08:59:29 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.29
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:29 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 19/23] libsepol/cil: avoid using maybe uninitialized variables
Date:   Tue,  8 Jun 2021 17:59:08 +0200
Message-Id: <20210608155912.32047-20-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Initialize variables, as they are set after goto statements, which jump
to cleanup code using them.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_binary.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 601fe8d1..54d13f2f 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -1073,7 +1073,7 @@ int __cil_type_rule_to_avtab(policydb_t *pdb, const struct cil_db *db, struct ci
 	type_datum_t *sepol_src = NULL;
 	type_datum_t *sepol_tgt = NULL;
 	class_datum_t *sepol_obj = NULL;
-	struct cil_list *class_list;
+	struct cil_list *class_list = NULL;
 	type_datum_t *sepol_result = NULL;
 	ebitmap_t src_bitmap, tgt_bitmap;
 	ebitmap_node_t *node1, *node2;
@@ -1129,7 +1129,7 @@ int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *db, stru
 	type_datum_t *sepol_src = NULL;
 	type_datum_t *sepol_tgt = NULL;
 	class_datum_t *sepol_obj = NULL;
-	struct cil_list *class_list;
+	struct cil_list *class_list = NULL;
 	type_datum_t *sepol_result = NULL;
 	ebitmap_t src_bitmap, tgt_bitmap;
 	ebitmap_node_t *node1, *node2;
@@ -2338,7 +2338,7 @@ int cil_roletrans_to_policydb(policydb_t *pdb, const struct cil_db *db, struct c
 	role_datum_t *sepol_src = NULL;
 	type_datum_t *sepol_tgt = NULL;
 	class_datum_t *sepol_obj = NULL;
-	struct cil_list *class_list;
+	struct cil_list *class_list = NULL;
 	role_datum_t *sepol_result = NULL;
 	role_trans_t *new = NULL;
 	uint32_t *new_role = NULL;
@@ -3166,7 +3166,7 @@ int cil_rangetransition_to_policydb(policydb_t *pdb, const struct cil_db *db, st
 	type_datum_t *sepol_src = NULL;
 	type_datum_t *sepol_tgt = NULL;
 	class_datum_t *sepol_class = NULL;
-	struct cil_list *class_list;
+	struct cil_list *class_list = NULL;
 	range_trans_t *newkey = NULL;
 	struct mls_range *newdatum = NULL;
 	ebitmap_t src_bitmap, tgt_bitmap;
@@ -3603,7 +3603,7 @@ int cil_default_to_policydb(policydb_t *pdb, struct cil_default *def)
 {
 	struct cil_list_item *curr;
 	class_datum_t *sepol_class;
-	struct cil_list *class_list;
+	struct cil_list *class_list = NULL;
 
 	cil_list_for_each(curr, def->class_datums) {
 		struct cil_list_item *c;
@@ -3658,7 +3658,7 @@ int cil_defaultrange_to_policydb(policydb_t *pdb, struct cil_defaultrange *def)
 {
 	struct cil_list_item *curr;
 	class_datum_t *sepol_class;
-	struct cil_list *class_list;
+	struct cil_list *class_list = NULL;
 
 	cil_list_for_each(curr, def->class_datums) {
 		struct cil_list_item *c;
-- 
2.32.0

