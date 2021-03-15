Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7538AC433E0
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 15:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4826264DDF
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 15:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhCOPKM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Mar 2021 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhCOPJo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Mar 2021 11:09:44 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F309DC06174A
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 08:09:43 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 30so7900270qva.9
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1gXXGv88cXpjOLLAUTWPysQamCqmYouV/05SQBrD2mg=;
        b=havOovmk5yYdYpinLomMXiIy3ei/geg7tT20Jq9v0LiKt+KQGCefhoWeOzptZyihZ8
         KP5hpJHet62KFYAOv+BDmiV1Fj8unSytJx9gca9tml12yVqZ/4R3ofYDtC34XBYrHkJU
         RKkV5lK7AyJUvjHqrAvjq0hnsu/ZgoM92XfR5qmHbeRj216GAHGYn0xuoAx3pMVGA7LH
         mde5PUg5/QGicyiFkH8iUDNcBT74Fh7s8OM6K6hYucCwLpRLqSx1FJflvMP3gZWkEfk9
         s2BrvBEcXlxVY7I1MUNnyipT6HwiFkipgMZuWU3XyJzg/i8l1Y0tYMoQIlGDx3Yebf4E
         ZL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1gXXGv88cXpjOLLAUTWPysQamCqmYouV/05SQBrD2mg=;
        b=eg2VWKAvc3ctoDTvzF4C8gDn7xptouxNXPZgs3eiSkmQyJIV7DKjeNlwwIWRDyGTlm
         gFfRCDQwOKm0BX32or9Oq0gsO3kSe31Te7ueWgLPEZcWKW5mf1rjpMDgU6G/x1ssy/yN
         M+lb8h5MCgu75Co62xALED5+A4PV0+4pNdMn7+7/jqdTXe/4gf51f2rP8kDaH8FnLzEh
         KCwAc2CcF4jn3Xdj82rUN0FRZ5jykq0ufaQbtUAjTVwj85c6vz/PrTC4RfS+ZnOfI01h
         ak9dvzeesM9CzM1s/I3Lib3DgMaHipazdmdTBmDGCRIlqF3CLzwroynTaaCjKepT4VfT
         h7Uw==
X-Gm-Message-State: AOAM532j1kLfeShuE0539jso+zrp5FELZWHh1/J119UyHT/5iNo/2iOy
        NSJNFzRZyrbU3xIYzNk2Q8DRihL3SEI=
X-Google-Smtp-Source: ABdhPJxRf+Oy0RsbNVQfhTY6sDui6Qz2tu+Ro78L/qGRK3MfCC3Nz7w/uUUaP4/oKy7NU6VrOUOEcw==
X-Received: by 2002:a0c:e788:: with SMTP id x8mr11337129qvn.48.1615820983044;
        Mon, 15 Mar 2021 08:09:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id m7sm11443045qti.33.2021.03.15.08.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 08:09:42 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: [PATCH 2/2 v2] libsepol: Check kernel to CIL and Conf functions for supported versions
Date:   Mon, 15 Mar 2021 11:09:38 -0400
Message-Id: <20210315150938.320990-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210315150938.320990-1-jwcart2@gmail.com>
References: <20210315150938.320990-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For policy versions between 20 and 23, attributes exist in the
policy, but only in the type_attr_map. This means that there are
gaps in both the type_val_to_struct and p_type_val_to_name arrays
and policy rules can refer to those gaps which can lead to NULL
dereferences when using sepol_kernel_policydb_to_conf() and
sepol_kernel_policydb_to_cil().

This can be seen with the following policy:
  class CLASS1
  sid SID1
  class CLASS1 { PERM1 }
  attribute TYPE_ATTR1;
  type TYPE1;
  typeattribute TYPE1 TYPE_ATTR1;
  allow TYPE_ATTR1 self : CLASS1 PERM1;
  role ROLE1;
  role ROLE1 types TYPE1;
  user USER1 roles ROLE1;
  sid SID1 USER1:ROLE1:TYPE1

Compile the policy:
  checkpolicy -c 23 -o policy.bin policy.conf
Converting back to a policy.conf causes a segfault:
  checkpolicy -F -b -o policy.bin.conf policy.bin

Have both sepol_kernel_policydb_to_conf() and
sepol_kernel_policydb_to_cil() exit with an error if the kernel
policy version is between 20 and 23.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2 - No changes

 libsepol/src/kernel_to_cil.c  | 12 ++++++++++++
 libsepol/src/kernel_to_conf.c | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index a146ac51..edfebeaf 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -3164,6 +3164,18 @@ int sepol_kernel_policydb_to_cil(FILE *out, struct policydb *pdb)
 		goto exit;
 	}
 
+	if (pdb->policyvers >= POLICYDB_VERSION_AVTAB && pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+		/*
+		 * For policy versions between 20 and 23, attributes exist in the policy,
+		 * but only in the type_attr_map. This means that there are gaps in both
+		 * the type_val_to_struct and p_type_val_to_name arrays and policy rules
+		 * can refer to those gaps.
+		 */
+		sepol_log_err("Writing policy versions between 20 and 23 as CIL is not supported");
+		rc = -1;
+		goto exit;
+	}
+
 	rc = constraint_rules_to_strs(pdb, mls_constraints, non_mls_constraints);
 	if (rc != 0) {
 		goto exit;
diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
index a22f196d..ea58a026 100644
--- a/libsepol/src/kernel_to_conf.c
+++ b/libsepol/src/kernel_to_conf.c
@@ -3041,6 +3041,18 @@ int sepol_kernel_policydb_to_conf(FILE *out, struct policydb *pdb)
 		goto exit;
 	}
 
+	if (pdb->policyvers >= POLICYDB_VERSION_AVTAB && pdb->policyvers <= POLICYDB_VERSION_PERMISSIVE) {
+		/*
+		 * For policy versions between 20 and 23, attributes exist in the policy,
+		 * but only in the type_attr_map. This means that there are gaps in both
+		 * the type_val_to_struct and p_type_val_to_name arrays and policy rules
+		 * can refer to those gaps.
+		 */
+		sepol_log_err("Writing policy versions between 20 and 23 as a policy.conf is not supported");
+		rc = -1;
+		goto exit;
+	}
+
 	rc = constraint_rules_to_strs(pdb, mls_constraints, non_mls_constraints);
 	if (rc != 0) {
 		goto exit;
-- 
2.26.2

