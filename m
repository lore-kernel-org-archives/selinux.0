Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E957CCA479
	for <selinux@archiver.kernel.org>; Wed, 13 Jul 2022 13:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiGMNnz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiGMNnx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jul 2022 09:43:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D502AE8
        for <selinux@vger.kernel.org>; Wed, 13 Jul 2022 06:43:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dn9so19923694ejc.7
        for <selinux@vger.kernel.org>; Wed, 13 Jul 2022 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EzrcWy+LyF0DX7ugCyKzRHZJLseYVkcBn7I3jA9Fxa8=;
        b=PEyq+Gtncgnf3X9GPAEV9/1YQibMa+y91o+963oFGctCY3PPqTzIXoSsCxYeVqNpFP
         h8kNHbulaHYL5ZzihwO5V0iQ2iAYpXw2aePSo30HmxBneLVWnsqXD0Neq3OErumRdIoG
         iTkI9sxdPLVd8LSw1Es9oiCNrb0eq7Y5mEX/LNiKtwXWMiKnqhZqkNU7SjTImaZ/bUW4
         Y+YV18s1zTM4JH2w0q1x4xBl1TgZOeokEIhCvefWhKMTiuPaVBv1di1Y84rcEdhaHQsb
         6dzQ4eGbXBiVTOBjkQFiSyrAMNx/BOFiMqX711OuGhXg7OBE+6Iw4pwarxKvjZkL1GZF
         A3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EzrcWy+LyF0DX7ugCyKzRHZJLseYVkcBn7I3jA9Fxa8=;
        b=0tvUIAc69kZCRmkjJPSuxG66WSoWKJvmUu9OSGpVWI0y6FxgEDT3QugQb2DReWkvWf
         eWmhVSAMGCRgYTztO2H8ZNGyOaEpPtVoexMHdgiq0m5oceNrIRQbX7rkoqsbZuVIRFS7
         RQRHyNbk+SmHdAyijdVeAII0kSsw6nvNfnICNAc8Vpg7nyRJaaTzeAaUX+0C/UWXzG6e
         i2TTUoUw1bOZjnNS+mQNTqkRgsKOo6ygvKDO+ZUCRYAgC0xkWpQlvzplllP3gX+kHmm8
         aAtplxui/ITeHnfGCe0zYFXUcm1LHjCn9SBGQn7N7QApVGMXvIAmUdtv2fpQ5toLAS6Q
         gIgw==
X-Gm-Message-State: AJIora/LdKNtKo9rXrROo6rpzOVJ63cQj76aX0H/y5a9CmmbHcQgArQm
        Daz4o1ZeOov2l7bLV0b4LGu5cFZhdACu/w==
X-Google-Smtp-Source: AGRyM1vCNAyYSF/dkvpRJBS5blL+jlXIsqKgba1m/E4f7TdiFORoiXzAuomCLpybdaSRhdjU4nFyUg==
X-Received: by 2002:a17:907:2ce9:b0:72b:30e5:f1bc with SMTP id hz9-20020a1709072ce900b0072b30e5f1bcmr3616076ejc.127.1657719830842;
        Wed, 13 Jul 2022 06:43:50 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-083-213.95.116.pool.telefonica.de. [95.116.83.213])
        by smtp.gmail.com with ESMTPSA id g18-20020a170906539200b00722fc0779e3sm4973763ejo.85.2022.07.13.06.43.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:43:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] libsepol: enclose macro parameters and replacement lists in parentheses
Date:   Wed, 13 Jul 2022 15:43:43 +0200
Message-Id: <20220713134343.19811-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713134343.19811-1-cgzones@googlemail.com>
References: <20220713134343.19811-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/include/sepol/errcodes.h          | 13 ++++++-------
 libsepol/include/sepol/policydb/policydb.h | 10 +++++-----
 libsepol/src/kernel_to_cil.c               |  2 +-
 libsepol/src/module_to_cil.c               |  2 +-
 libsepol/src/util.c                        |  2 +-
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/libsepol/include/sepol/errcodes.h b/libsepol/include/sepol/errcodes.h
index 6e9ff316..e5fe71e3 100644
--- a/libsepol/include/sepol/errcodes.h
+++ b/libsepol/include/sepol/errcodes.h
@@ -16,15 +16,14 @@ extern "C" {
  * codes that don't map to system error codes should be defined
  * outside of the range of system error codes.
  */
-#define SEPOL_ERR            -1
-#define SEPOL_ENOTSUP        -2  /* feature not supported in module language */
-#define SEPOL_EREQ           -3  /* requirements not met */
+#define SEPOL_ERR            (-1)
+#define SEPOL_ENOTSUP        (-2)  /* feature not supported in module language */
+#define SEPOL_EREQ           (-3)  /* requirements not met */
 
 /* Error codes that map to system error codes */
-#define SEPOL_ENOMEM         -ENOMEM
-#define SEPOL_ERANGE         -ERANGE
-#define SEPOL_EEXIST         -EEXIST
-#define SEPOL_ENOENT         -ENOENT
+#define SEPOL_ENOMEM         (-ENOMEM)
+#define SEPOL_EEXIST         (-EEXIST)
+#define SEPOL_ENOENT         (-ENOENT)
 
 #ifdef __cplusplus
 }
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index de0068a6..ef1a014a 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -251,9 +251,9 @@ typedef struct class_perm_node {
 	struct class_perm_node *next;
 } class_perm_node_t;
 
-#define xperm_test(x, p) (UINT32_C(1) & (p[x >> 5] >> (x & 0x1f)))
-#define xperm_set(x, p) (p[x >> 5] |= (UINT32_C(1) << (x & 0x1f)))
-#define xperm_clear(x, p) (p[x >> 5] &= ~(UINT32_C(1) << (x & 0x1f)))
+#define xperm_test(x, p) (UINT32_C(1) & ((p)[(x) >> 5] >> ((x) & 0x1f)))
+#define xperm_set(x, p) ((p)[(x) >> 5] |= (UINT32_C(1) << ((x) & 0x1f)))
+#define xperm_clear(x, p) ((p)[(x) >> 5] &= ~(UINT32_C(1) << ((x) & 0x1f)))
 #define EXTENDED_PERMS_LEN 8
 
 typedef struct av_extended_perms {
@@ -795,9 +795,9 @@ extern int policydb_set_target_platform(policydb_t *p, int platform);
 
 #define policydb_has_boundary_feature(p)			\
 	(((p)->policy_type == POLICY_KERN			\
-	  && p->policyvers >= POLICYDB_VERSION_BOUNDARY) ||	\
+	  && (p)->policyvers >= POLICYDB_VERSION_BOUNDARY) ||	\
 	 ((p)->policy_type != POLICY_KERN			\
-	  && p->policyvers >= MOD_POLICYDB_VERSION_BOUNDARY))
+	  && (p)->policyvers >= MOD_POLICYDB_VERSION_BOUNDARY))
 
 /* the config flags related to unknown classes/perms are bits 2 and 3 */
 #define DENY_UNKNOWN	SEPOL_DENY_UNKNOWN
diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
index 9128ac55..5a1336a3 100644
--- a/libsepol/src/kernel_to_cil.c
+++ b/libsepol/src/kernel_to_cil.c
@@ -1626,7 +1626,7 @@ exit:
 	return rc;
 }
 
-#define next_bit_in_range(i, p) ((i + 1 < sizeof(p)*8) && xperm_test((i + 1), p))
+#define next_bit_in_range(i, p) (((i) + 1 < sizeof(p)*8) && xperm_test(((i) + 1), p))
 
 static char *xperms_to_str(avtab_extended_perms_t *xperms)
 {
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index b35bf055..b900290a 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -624,7 +624,7 @@ exit:
 	return rc;
 }
 
-#define next_bit_in_range(i, p) ((i + 1 < sizeof(p)*8) && xperm_test((i + 1), p))
+#define next_bit_in_range(i, p) (((i) + 1 < sizeof(p)*8) && xperm_test(((i) + 1), p))
 
 static int xperms_to_cil(const av_extended_perms_t *xperms)
 {
diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index 1cd1308d..0a2edc85 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -124,7 +124,7 @@ char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
 	return avbuf;
 }
 
-#define next_bit_in_range(i, p) ((i + 1 < sizeof(p)*8) && xperm_test((i + 1), p))
+#define next_bit_in_range(i, p) (((i) + 1 < sizeof(p)*8) && xperm_test(((i) + 1), p))
 
 char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms)
 {
-- 
2.36.1

