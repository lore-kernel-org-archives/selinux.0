Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8048BC77B75
	for <selinux@archiver.kernel.org>; Fri, 12 May 2023 10:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbjELKOX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 May 2023 06:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbjELKOL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 May 2023 06:14:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FC911B7E
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:13:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so15014417a12.1
        for <selinux@vger.kernel.org>; Fri, 12 May 2023 03:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683886418; x=1686478418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUrXXt/hS2N8OChDMwTllJgcZkVssYXTx6WOXpbVxBQ=;
        b=ggWUtL9/grZueU8Z0x0Ry3LjET+e5URhp+GxZ1Uvz1Tzj0PdEK1R0/XLQAA8DhCPb1
         vNic0Tm0Ws50Uam6ys/sqnzb9bAXEE9fSJeYk/rpSa1HYBQdcy6UCqiCQnILD0jhxIRJ
         0GQLSYTIGDN2qLGUllzGMonvjV/WF0qdcMte8PDs5cwTERfIh0K31tyi6lSeaZQ1ne8a
         7xLtD3qlGrKPSbSmnfAKpJwI/gyZ+7ehaqOJIGiWyVTpDfiXGyYn66+JxZQ1+SVNt2fY
         CadqiGXI9oGjF2aW44ZcOhMaqfJX51NkeNZKnTsXQJkdowgVvfNyoqKOBF6HTzXFXUOT
         on9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683886418; x=1686478418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUrXXt/hS2N8OChDMwTllJgcZkVssYXTx6WOXpbVxBQ=;
        b=jG8utWWqcRZmZWbcI3H+MlO8cIuQLL27XwylOyvDtagPI3B/7H5obF44L8jkuFPDTo
         P+KFIbcQbwzNPJlz9hM5ZEHIgda+9c/nz9uQkKqQzhT/ojv73bi9LRRTFW86Sydvpkeb
         BmshD0yyofJKzN/e+GmyEiA1XyDKvX32YwdsO0WqLx6u/vcxf5Xx6y/BLNywutczSCmB
         xEHWGgyYynK06RqI8+Z/ea3roRAw5g6wxYawrtAaKPGkOZRPkYBCOWuwfpW/pWCV3t0J
         uUveol/LcnX4Eojr6CWHChtKAV+JJ0Ncm8AC/fRLKIfAv63z5VE7G/X6b1DW9onUii7b
         N1hg==
X-Gm-Message-State: AC+VfDyNUlWCA95Bto7105ejh2HpZjppkfE1Q2TD0JSTtqkg5frrCRuN
        6p/QnGLPV3gquPySFE+uKKdImiawk3q1ZQ==
X-Google-Smtp-Source: ACHHUZ6IoF4DBXXEeisWRqKkqcRfdslk1ef81mPd2fV0cB/v48f1EJhJX3DqwtAIwFPc05FquraP2Q==
X-Received: by 2002:a17:907:98c:b0:955:dcc9:d101 with SMTP id bf12-20020a170907098c00b00955dcc9d101mr22403672ejc.18.1683886418372;
        Fri, 12 May 2023 03:13:38 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id n5-20020a1709065da500b0096616adc0d5sm5233551ejv.104.2023.05.12.03.13.37
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:13:37 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/4] libsepol: drop duplicate newline in sepol_log_err() calls
Date:   Fri, 12 May 2023 12:13:31 +0200
Message-Id: <20230512101333.67196-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512101333.67196-1-cgzones@googlemail.com>
References: <20230512101333.67196-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

sepol_log_err() will already append a newline unconditionally.
---
 libsepol/src/kernel_to_cil.c    | 78 ++++++++++++++++-----------------
 libsepol/src/kernel_to_common.c |  4 +-
 libsepol/src/kernel_to_conf.c   | 78 ++++++++++++++++-----------------
 3 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index e9cd89c2..edca4d5f 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -314,7 +314,7 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 
 	return 0;
 exit:
-	sepol_log_err("Error gathering constraint rules\n");
+	sepol_log_err("Error gathering constraint rules");
 	return rc;
 }
 
@@ -543,7 +543,7 @@ static int write_class_decl_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing class rules to CIL\n");
+		sepol_log_err("Error writing class rules to CIL");
 	}
 
 	return rc;
@@ -616,7 +616,7 @@ exit:
 	}
 	strs_destroy(&strs);
 	if (rc != 0) {
-		sepol_log_err("Error writing sid rules to CIL\n");
+		sepol_log_err("Error writing sid rules to CIL");
 	}
 
 	return rc;
@@ -795,7 +795,7 @@ static int write_default_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing default rules to CIL\n");
+		sepol_log_err("Error writing default rules to CIL");
 	}
 
 	return rc;
@@ -906,7 +906,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing sensitivity rules to CIL\n");
+		sepol_log_err("Error writing sensitivity rules to CIL");
 	}
 
 	return rc;
@@ -1010,7 +1010,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing category rules to CIL\n");
+		sepol_log_err("Error writing category rules to CIL");
 	}
 
 	return rc;
@@ -1141,7 +1141,7 @@ static int write_sensitivitycategory_rules_to_cil(FILE *out, struct policydb *pd
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing sensitivitycategory rules to CIL\n");
+		sepol_log_err("Error writing sensitivitycategory rules to CIL");
 	}
 
 	return rc;
@@ -1177,7 +1177,7 @@ static int write_mls_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing mls rules to CIL\n");
+		sepol_log_err("Error writing mls rules to CIL");
 	}
 
 	return rc;
@@ -1218,7 +1218,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing polcap rules to CIL\n");
+		sepol_log_err("Error writing polcap rules to CIL");
 	}
 
 	return rc;
@@ -1263,7 +1263,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing typeattribute rules to CIL\n");
+		sepol_log_err("Error writing typeattribute rules to CIL");
 	}
 
 	return rc;
@@ -1308,7 +1308,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing roleattribute rules to CIL\n");
+		sepol_log_err("Error writing roleattribute rules to CIL");
 	}
 
 	return rc;
@@ -1348,7 +1348,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing boolean declarations to CIL\n");
+		sepol_log_err("Error writing boolean declarations to CIL");
 	}
 
 	return rc;
@@ -1393,7 +1393,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing type declarations to CIL\n");
+		sepol_log_err("Error writing type declarations to CIL");
 	}
 
 	return rc;
@@ -1476,7 +1476,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing type alias rules to CIL\n");
+		sepol_log_err("Error writing type alias rules to CIL");
 	}
 
 	return rc;
@@ -1530,7 +1530,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing type bounds rules to CIL\n");
+		sepol_log_err("Error writing type bounds rules to CIL");
 	}
 
 	return rc;
@@ -1578,7 +1578,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing typeattributeset rules to CIL\n");
+		sepol_log_err("Error writing typeattributeset rules to CIL");
 	}
 
 	return rc;
@@ -1620,7 +1620,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing typepermissive rules to CIL\n");
+		sepol_log_err("Error writing typepermissive rules to CIL");
 	}
 
 	return rc;
@@ -1862,7 +1862,7 @@ static int write_avtab_to_cil(FILE *out, struct policydb *pdb, int indent)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing avtab rules to CIL\n");
+		sepol_log_err("Error writing avtab rules to CIL");
 	}
 
 	return rc;
@@ -1933,7 +1933,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing filename typetransition rules to CIL\n");
+		sepol_log_err("Error writing filename typetransition rules to CIL");
 	}
 
 	return rc;
@@ -2044,7 +2044,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing range transition rules to CIL\n");
+		sepol_log_err("Error writing range transition rules to CIL");
 	}
 
 	return rc;
@@ -2184,7 +2184,7 @@ exit:
 	}
 
 	if (rc != 0) {
-		sepol_log_err("Error writing conditional rules to CIL\n");
+		sepol_log_err("Error writing conditional rules to CIL");
 	}
 
 	return rc;
@@ -2309,7 +2309,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing role declarations to CIL\n");
+		sepol_log_err("Error writing role declarations to CIL");
 	}
 
 	return rc;
@@ -2350,7 +2350,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing role transition rules to CIL\n");
+		sepol_log_err("Error writing role transition rules to CIL");
 	}
 
 	return rc;
@@ -2388,7 +2388,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing role allow rules to CIL\n");
+		sepol_log_err("Error writing role allow rules to CIL");
 	}
 
 	return rc;
@@ -2529,7 +2529,7 @@ exit:
 		strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing user declarations to CIL\n");
+		sepol_log_err("Error writing user declarations to CIL");
 	}
 
 	return rc;
@@ -2611,7 +2611,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing sidcontext rules to CIL\n");
+		sepol_log_err("Error writing sidcontext rules to CIL");
 	}
 
 	return rc;
@@ -2655,7 +2655,7 @@ static int write_selinux_fsuse_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing fsuse rules to CIL\n");
+		sepol_log_err("Error writing fsuse rules to CIL");
 	}
 
 	return rc;
@@ -2733,7 +2733,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing genfscon rules to CIL\n");
+		sepol_log_err("Error writing genfscon rules to CIL");
 	}
 
 	return rc;
@@ -2788,7 +2788,7 @@ static int write_selinux_port_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing portcon rules to CIL\n");
+		sepol_log_err("Error writing portcon rules to CIL");
 	}
 
 	return rc;
@@ -2822,7 +2822,7 @@ static int write_selinux_netif_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing netifcon rules to CIL\n");
+		sepol_log_err("Error writing netifcon rules to CIL");
 	}
 
 	return rc;
@@ -2862,7 +2862,7 @@ static int write_selinux_node_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing nodecon rules to CIL\n");
+		sepol_log_err("Error writing nodecon rules to CIL");
 	}
 
 	return rc;
@@ -2902,7 +2902,7 @@ static int write_selinux_node6_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing nodecon rules to CIL\n");
+		sepol_log_err("Error writing nodecon rules to CIL");
 	}
 
 	return rc;
@@ -2958,7 +2958,7 @@ static int write_selinux_ibpkey_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing ibpkeycon rules to CIL\n");
+		sepol_log_err("Error writing ibpkeycon rules to CIL");
 	}
 
 	return rc;
@@ -2995,7 +2995,7 @@ static int write_selinux_ibendport_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing ibendportcon rules to CIL\n");
+		sepol_log_err("Error writing ibendportcon rules to CIL");
 	}
 
 	return rc;
@@ -3035,7 +3035,7 @@ static int write_xen_pirq_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing pirqcon rules to CIL\n");
+		sepol_log_err("Error writing pirqcon rules to CIL");
 	}
 
 	return rc;
@@ -3078,7 +3078,7 @@ static int write_xen_ioport_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing ioportcon rules to CIL\n");
+		sepol_log_err("Error writing ioportcon rules to CIL");
 	}
 
 	return rc;
@@ -3121,7 +3121,7 @@ static int write_xen_iomem_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing iomemcon rules to CIL\n");
+		sepol_log_err("Error writing iomemcon rules to CIL");
 	}
 
 	return rc;
@@ -3156,7 +3156,7 @@ static int write_xen_pcidevice_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing pcidevicecon rules to CIL\n");
+		sepol_log_err("Error writing pcidevicecon rules to CIL");
 	}
 
 	return rc;
@@ -3183,7 +3183,7 @@ static int write_xen_devicetree_rules_to_cil(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing devicetreecon rules to CIL\n");
+		sepol_log_err("Error writing devicetreecon rules to CIL");
 	}
 
 	return rc;
diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 775703a9..8da399e2 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -627,7 +627,7 @@ static int sort_ocontext_data(struct ocontext **ocons, int (*cmp)(const void *,
 
 	data = calloc(sizeof(*data), num);
 	if (!data) {
-		sepol_log_err("Out of memory\n");
+		sepol_log_err("Out of memory");
 		return -1;
 	}
 
@@ -718,7 +718,7 @@ int sort_ocontexts(struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error sorting ocontexts\n");
+		sepol_log_err("Error sorting ocontexts");
 	}
 
 	return rc;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index cb7cb740..1d812b19 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -318,7 +318,7 @@ static int class_constraint_rules_to_strs(struct policydb *pdb, char *classkey,
 
 	return 0;
 exit:
-	sepol_log_err("Error gathering constraint rules\n");
+	sepol_log_err("Error gathering constraint rules");
 	return rc;
 }
 
@@ -495,7 +495,7 @@ exit:
 	}
 	strs_destroy(&strs);
 	if (rc != 0) {
-		sepol_log_err("Error writing sid rules to policy.conf\n");
+		sepol_log_err("Error writing sid rules to policy.conf");
 	}
 
 	return rc;
@@ -610,7 +610,7 @@ static int write_class_and_common_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing class rules to policy.conf\n");
+		sepol_log_err("Error writing class rules to policy.conf");
 	}
 
 	return rc;
@@ -771,7 +771,7 @@ static int write_default_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing default rules to policy.conf\n");
+		sepol_log_err("Error writing default rules to policy.conf");
 	}
 
 	return rc;
@@ -902,7 +902,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing sensitivity rules to CIL\n");
+		sepol_log_err("Error writing sensitivity rules to CIL");
 	}
 
 	return rc;
@@ -1010,7 +1010,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing category rules to policy.conf\n");
+		sepol_log_err("Error writing category rules to policy.conf");
 	}
 
 	return rc;
@@ -1129,7 +1129,7 @@ static int write_level_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing level rules to policy.conf\n");
+		sepol_log_err("Error writing level rules to policy.conf");
 	}
 
 	return rc;
@@ -1160,7 +1160,7 @@ static int write_mls_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing mls rules to policy.conf\n");
+		sepol_log_err("Error writing mls rules to policy.conf");
 	}
 
 	return rc;
@@ -1201,7 +1201,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing polcap rules to policy.conf\n");
+		sepol_log_err("Error writing polcap rules to policy.conf");
 	}
 
 	return rc;
@@ -1246,7 +1246,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing typeattribute rules to policy.conf\n");
+		sepol_log_err("Error writing typeattribute rules to policy.conf");
 	}
 
 	return rc;
@@ -1291,7 +1291,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing roleattribute rules to policy.conf\n");
+		sepol_log_err("Error writing roleattribute rules to policy.conf");
 	}
 
 	return rc;
@@ -1331,7 +1331,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing boolean declarations to policy.conf\n");
+		sepol_log_err("Error writing boolean declarations to policy.conf");
 	}
 
 	return rc;
@@ -1376,7 +1376,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing type declarations to policy.con\n");
+		sepol_log_err("Error writing type declarations to policy.conf");
 	}
 
 	return rc;
@@ -1450,7 +1450,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing type alias rules to policy.conf\n");
+		sepol_log_err("Error writing type alias rules to policy.conf");
 	}
 
 	return rc;
@@ -1504,7 +1504,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing type bounds rules to policy.conf\n");
+		sepol_log_err("Error writing type bounds rules to policy.conf");
 	}
 
 	return rc;
@@ -1631,7 +1631,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing typeattributeset rules to policy.conf\n");
+		sepol_log_err("Error writing typeattributeset rules to policy.conf");
 	}
 
 	return rc;
@@ -1673,7 +1673,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing typepermissive rules to policy.conf\n");
+		sepol_log_err("Error writing typepermissive rules to policy.conf");
 	}
 
 	return rc;
@@ -1838,7 +1838,7 @@ static int write_avtab_to_conf(FILE *out, struct policydb *pdb, int indent)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing avtab rules to policy.conf\n");
+		sepol_log_err("Error writing avtab rules to policy.conf");
 	}
 
 	return rc;
@@ -1909,7 +1909,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing filename typetransition rules to policy.conf\n");
+		sepol_log_err("Error writing filename typetransition rules to policy.conf");
 	}
 
 	return rc;
@@ -2020,7 +2020,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing range transition rules to policy.conf\n");
+		sepol_log_err("Error writing range transition rules to policy.conf");
 	}
 
 	return rc;
@@ -2158,7 +2158,7 @@ exit:
 	}
 
 	if (rc != 0) {
-		sepol_log_err("Error writing conditional rules to policy.conf\n");
+		sepol_log_err("Error writing conditional rules to policy.conf");
 	}
 
 	return rc;
@@ -2240,7 +2240,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing role declarations to policy.conf\n");
+		sepol_log_err("Error writing role declarations to policy.conf");
 	}
 
 	return rc;
@@ -2281,7 +2281,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing role transition rules to policy.conf\n");
+		sepol_log_err("Error writing role transition rules to policy.conf");
 	}
 
 	return rc;
@@ -2319,7 +2319,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing role allow rules to policy.conf\n");
+		sepol_log_err("Error writing role allow rules to policy.conf");
 	}
 
 	return rc;
@@ -2402,7 +2402,7 @@ exit:
 		strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing user declarations to policy.conf\n");
+		sepol_log_err("Error writing user declarations to policy.conf");
 	}
 
 	return rc;
@@ -2479,7 +2479,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing sidcontext rules to policy.conf\n");
+		sepol_log_err("Error writing sidcontext rules to policy.conf");
 	}
 
 	return rc;
@@ -2523,7 +2523,7 @@ static int write_selinux_fsuse_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing fsuse rules to policy.conf\n");
+		sepol_log_err("Error writing fsuse rules to policy.conf");
 	}
 
 	return rc;
@@ -2601,7 +2601,7 @@ exit:
 	strs_destroy(&strs);
 
 	if (rc != 0) {
-		sepol_log_err("Error writing genfscon rules to policy.conf\n");
+		sepol_log_err("Error writing genfscon rules to policy.conf");
 	}
 
 	return rc;
@@ -2656,7 +2656,7 @@ static int write_selinux_port_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing portcon rules to policy.conf\n");
+		sepol_log_err("Error writing portcon rules to policy.conf");
 	}
 
 	return rc;
@@ -2690,7 +2690,7 @@ static int write_selinux_netif_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing netifcon rules to policy.conf\n");
+		sepol_log_err("Error writing netifcon rules to policy.conf");
 	}
 
 	return rc;
@@ -2730,7 +2730,7 @@ static int write_selinux_node_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing nodecon rules to policy.conf\n");
+		sepol_log_err("Error writing nodecon rules to policy.conf");
 	}
 
 	return rc;
@@ -2771,7 +2771,7 @@ static int write_selinux_node6_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing nodecon rules to policy.conf\n");
+		sepol_log_err("Error writing nodecon rules to policy.conf");
 	}
 
 	return rc;
@@ -2828,7 +2828,7 @@ static int write_selinux_ibpkey_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing ibpkeycon rules to policy.conf\n");
+		sepol_log_err("Error writing ibpkeycon rules to policy.conf");
 	}
 
 	return rc;
@@ -2864,7 +2864,7 @@ static int write_selinux_ibendport_rules_to_conf(FILE *out, struct policydb *pdb
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing ibendportcon rules to policy.conf\n");
+		sepol_log_err("Error writing ibendportcon rules to policy.conf");
 	}
 
 	return rc;
@@ -2905,7 +2905,7 @@ static int write_xen_pirq_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing pirqcon rules to policy.conf\n");
+		sepol_log_err("Error writing pirqcon rules to policy.conf");
 	}
 
 	return rc;
@@ -2948,7 +2948,7 @@ static int write_xen_ioport_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing ioportcon rules to policy.conf\n");
+		sepol_log_err("Error writing ioportcon rules to policy.conf");
 	}
 
 	return rc;
@@ -2991,7 +2991,7 @@ static int write_xen_iomem_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing iomemcon rules to policy.conf\n");
+		sepol_log_err("Error writing iomemcon rules to policy.conf");
 	}
 
 	return rc;
@@ -3026,7 +3026,7 @@ static int write_xen_pcidevice_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing pcidevicecon rules to policy.conf\n");
+		sepol_log_err("Error writing pcidevicecon rules to policy.conf");
 	}
 
 	return rc;
@@ -3053,7 +3053,7 @@ static int write_xen_devicetree_rules_to_conf(FILE *out, struct policydb *pdb)
 
 exit:
 	if (rc != 0) {
-		sepol_log_err("Error writing devicetreecon rules to policy.conf\n");
+		sepol_log_err("Error writing devicetreecon rules to policy.conf");
 	}
 
 	return rc;
-- 
2.40.1

