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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CFBC433E0
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 15:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38058206B6
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 15:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEXZAjx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgETPm2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 May 2020 11:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgETPm1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 May 2020 11:42:27 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A8DC061A0E
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 08:42:27 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id r3so1550796qve.1
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qD2c8ZTUUcysl+0yM7G8WeUR/LiTblDLjpSaVs+SGFU=;
        b=uEXZAjx+KYmtLJ7yl9kJUdHYb0DFgPCWSBpmGyp8II4RNU0LwosUhoobaRsh43yC40
         x8BSsju83QBNJkQhSrBc7K92F4WKv/C/aVwUNf46jZb4+OareytQFP48DmQm+zpKVJBl
         lKrpdo0XNFzD+M2v9synGrWDTpLvNBYa2tvY3G8+KF9lVVFnLoQjWZ8Qq1F69TRheVn4
         vvn/E/ikbHO/WZr2KAWKIP233vd3xM8hmQPGNqu8n22C+Z0vUiu9dIotwId41b4t5V/h
         vifrpugyuMDHrpuREAA+f0Cqy5H0oVOG5TtPwed8PMLegbK7On/UfzXhQ6POi1RKEAbs
         8+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qD2c8ZTUUcysl+0yM7G8WeUR/LiTblDLjpSaVs+SGFU=;
        b=IVeO2iq3YD3QzHUtnWUvWmCqjE6de3Gjh5Dpq7ccvi2I0xsKfs6TCrtgq4gLVQLqy1
         VrnsV+zRQG5fo7bcRpcR7xMGSItbAd6PAoBpeA76PU2koOcmxuo/f7za7ckzH1UFXEFR
         ombb14sqpIxkwHDZ0CHB1O0QMwm+zkCeGFZk/iKW23P1Ha+ywSP9qmzYVUTa5ymx0LvS
         50OIVgIazPiv5LgWDo+xsOZ9F3B0bMSKZG6xHJh2ILYxIVb5WhoEyuETAUc8id7LxVAe
         tNgFxNboGQQ+AHp5ZqnjAJiC20e6RguELBVVI6MCExEGqItyAnAzsRw7xAzOfGkiC46S
         qF/Q==
X-Gm-Message-State: AOAM530bgoo0SDvWK01wtoEFoyQCcp9RxcNfdGQM5fQ5yCFaXp8OCAhS
        pTyPOZs5lOC/dELmxTt430skNtDRvm8=
X-Google-Smtp-Source: ABdhPJyVyjVINXaGqCffiERbeVGzRXDaR39ryFG2S/b20qQGDsUopT3zF8hG3p1eV1Z+ySQBPPrDcQ==
X-Received: by 2002:ad4:4b26:: with SMTP id s6mr5505544qvw.146.1589989346200;
        Wed, 20 May 2020 08:42:26 -0700 (PDT)
Received: from localhost.localdomain (pool-71-166-99-106.bltmmd.east.verizon.net. [71.166.99.106])
        by smtp.gmail.com with ESMTPSA id 62sm2448813qkh.113.2020.05.20.08.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 08:42:24 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol: Fix type alias handling in kernel_to_cil
Date:   Wed, 20 May 2020 11:42:12 -0400
Message-Id: <20200520154213.117606-1-jwcart2@gmail.com>
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
 libsepol/src/kernel_to_cil.c | 44 +++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index ede78a20..bc5f9b52 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1367,33 +1367,55 @@ exit:
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

