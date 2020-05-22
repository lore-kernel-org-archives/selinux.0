Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8A8C433E0
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 14:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A3652145D
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 14:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5ICSpTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgEVOzA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 10:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730973AbgEVOvV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 10:51:21 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8742C061A0E
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 07:51:20 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o19so8425364qtr.10
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oyYWC7FPAvQijXlFvBDt4Oz/D+XQzVCnV+3M5WKDh4w=;
        b=a5ICSpTlr3afa82CNP5nKSHZ6f241Iz4vDdUAcr2Uu6NS92ZaQ4YjiliU1cSq6E3tK
         zIPU0ew9IrRjMsbmpI10vdsXN/yg9qdsFyyucjvKdRekTZeppB7rzmmunyr3aMGyYbWT
         eP2LxaikJOT/HNGLygh5VZCMU4hWDJJiopSmR7vYg/S/O+bh6U10DfDhQ258Vyzj9ATH
         QMUefGoTxQ+5Kcftgmf6ZQRN1Q5/088YVO56JSIGqXSXFoYBit4pODbHmebFfjval0X8
         pmdyn5/VOmmcUM6QrM+iyVmB6t2kgfrcMojHskZIeRAKliIfth07AG8kdo+31BiqCND6
         LztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oyYWC7FPAvQijXlFvBDt4Oz/D+XQzVCnV+3M5WKDh4w=;
        b=B3bZoiZ11+L4Uu8gXi/Use89Vc7kIMFSU3xqx49fvKa9cvmNCFyeqM9n8M2B/TYKLo
         ZLmf13w5hMOgUfNHOA7G4EI1EkxEsxekzx8VHHgv97q40a2RlxhwJtDEdweRNo6Ixavl
         32DDFXgSX6P+0p2V+z9Qkos/0HJIv9vys8dYjmV/jBKaIP7rUi2oGmgmLY0i00+twxGz
         ng0Y9AV1isHwKhsW+4AU8HVCHHRF2FeTKawv5TtO48lwEpR2b29Hvz0i++pB0mgBVarj
         TGz/bffrmgBrLdEPx5AmgoPDMqiKgLJTYrOirPHJYnsHFRLfrY6QH7i2HQRDPxQGMbj6
         FpAQ==
X-Gm-Message-State: AOAM533epSjsL25h4wuV1HfUII7ARoq1Hy/Pa51glUcqSkQrGoL9YuxM
        /H4zvCkQ+KtrQu0ymJE75mUEryhxGa8=
X-Google-Smtp-Source: ABdhPJw/iIK+8wk/As9fN/K29Ch8r1Ei3T9b6wJbM+x3GFRoNvpjbnGFr0VjyYteyWnlRX2rMoLqSg==
X-Received: by 2002:ac8:6c54:: with SMTP id z20mr16040971qtu.76.1590159079409;
        Fri, 22 May 2020 07:51:19 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-99-106.bltmmd.east.verizon.net. [71.166.99.106])
        by smtp.gmail.com with ESMTPSA id v69sm3668805qkb.96.2020.05.22.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 07:51:18 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH v3 1/2] libsepol: Fix type alias handling in kernel_to_cil
Date:   Fri, 22 May 2020 10:50:37 -0400
Message-Id: <20200522145038.194209-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Type alias rules are not written out when converting a binary kernel
policy to CIL. The problem is that type aliases are not in the
type_val_to_struct array and that is what is being used to find the
aliases.

Since type aliases are only in the types hashtable, walk that to
find the type aliases.

Fixes: 70a480bfcd46214a ("libsepol: Add ability to convert binary
       policy to CIL")

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: No changes
v3: Add "__attribute__((unused))" to unused parameters as suggested by
    Nicolas Iooss

 libsepol/src/kernel_to_cil.c | 44 +++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index ede78a20..9acf2ec2 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1367,33 +1367,55 @@ exit:
 	return rc;
 }
 
+static int map_count_type_aliases(__attribute__((unused)) char *key, void *data, void *args)
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
 static int write_type_alias_rules_to_cil(FILE *out, struct policydb *pdb)
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
+	}
+
+	rc = hashtab_map(pdb->p_types.table, map_type_aliases_to_strs, strs);
+	if (rc != 0) {
+		goto exit;
 	}
 
 	strs_sort(strs);
 
-	num = strs_num_items(strs);
 	for (i=0; i<num; i++) {
 		name = strs_read_at_index(strs, i);
 		if (!name) {
-- 
2.25.4

