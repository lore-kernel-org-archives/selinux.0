Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9A7C7EE2C
	for <selinux@archiver.kernel.org>; Fri,  2 Jun 2023 13:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjFBNGX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjFBNGU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Jun 2023 09:06:20 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E32E4C
        for <selinux@vger.kernel.org>; Fri,  2 Jun 2023 06:06:17 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b1a46ad09fso23394281fa.2
        for <selinux@vger.kernel.org>; Fri, 02 Jun 2023 06:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685711175; x=1688303175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6e/YvWURXRbA9yHh/CLpAgKhIdhkW4fVyKRWrB6iQA=;
        b=Ns83oj1SPGULw+qCkmj1VYeiH+FHYAo+L1puQPEsuKBgDYdEweE1bcFbrSdIwC/1bL
         k/8ajlqE9WzYbFpFsOHChZDsYsE7qNGe3ejVGA/hPvw+5J+rM5mjSvbRlznm+CQQBB8c
         +VMt6gAknBohTEaBV/7kHCAYkjA5fVCP83Lfe5TozxZmPrk1vrjBeTicvtmMu+/YOlle
         oS2zERbHBfiRmM0rnlnSwQ8Az/VjKQyZotsoBexvtX7DI7/tHXysACljX8R2gAmDQaDn
         YA5t276n9bBeW/P77VTuKrkL+vdpX9tihM7vTyHx6LQyCFyl844AEMbFoh2sUcYqb8ke
         uI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711175; x=1688303175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6e/YvWURXRbA9yHh/CLpAgKhIdhkW4fVyKRWrB6iQA=;
        b=lShrFJoEpt/rCcK9iVV0EOSj5K03Eg7JSziOXhVkvHOIJA7iOifU8FKNFQk/6BoMft
         KHfFWiSE1qnmdLeJ5kjrqz57+gY+E5iX0M+DdjETqor+Liw4EJFv5vKfdUPbHdF722Kc
         i7zPeb/dg2hIkzdz/zeNKISdMTOMWu/e2/qpb6YXsOXVMMjqi+wNjVD3J62ncxaD9ZP2
         xIrkRgqm+bR+OXU5VfK8TR4OYD7GLxUcsZgdLOcQCVqoZRBUkZbejjQx3GtIfp4xPKhR
         96QkpnfLOQkEJbmpwZQLTK2R8fMWx222TYckzbNfCvEVnoRd7Vhy1EZaYQFtCPeREt1x
         xs6g==
X-Gm-Message-State: AC+VfDw9lIrIPx7K8acEz77Ehf8MolC7jxyj66lwQzUj60qYNnqagPXy
        4SE1+oRyZXk8aCmLOfOxxv72QcsxnmLySw==
X-Google-Smtp-Source: ACHHUZ4Te6k2ckzj/fQwJN6ARaBKcP4h9vZTlEXfeWsO1L4QIHtAkjpD5ma2+6+22tVVC3jeqD1/Pw==
X-Received: by 2002:a2e:96cb:0:b0:2ad:a955:dfa3 with SMTP id d11-20020a2e96cb000000b002ada955dfa3mr1670587ljj.9.1685711174978;
        Fri, 02 Jun 2023 06:06:14 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-062-107.95.112.pool.telefonica.de. [95.112.62.107])
        by smtp.gmail.com with ESMTPSA id z19-20020aa7c653000000b005149b6ec1bdsm669961edr.29.2023.06.02.06.06.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:06:14 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/4] libsepol: drop duplicate newline in sepol_log_err() calls
Date:   Fri,  2 Jun 2023 15:06:06 +0200
Message-Id: <20230602130608.24586-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602130608.24586-1-cgzones@googlemail.com>
References: <20230602130608.24586-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

sepol_log_err() will already append a newline unconditionally.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  added signed-off
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

