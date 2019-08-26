Return-Path: <SRS0=L6MV=WW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E089C3A5A6
	for <selinux@archiver.kernel.org>; Mon, 26 Aug 2019 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB4F20679
	for <selinux@archiver.kernel.org>; Mon, 26 Aug 2019 14:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="t6hz+o2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfHZOUP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:20:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35245 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbfHZOUP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 26 Aug 2019 10:20:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id u34so18030348qte.2
        for <selinux@vger.kernel.org>; Mon, 26 Aug 2019 07:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s9o5y6vQrq/OjqTGJl1mlB5Bi1wRnaRbsPezF97mkUs=;
        b=t6hz+o2Mn0JZOUmwMoePj55DfL6hRIKwFVBhQkWhu+AHIUY802uL7W0hqTmAIfifOQ
         85akEVt5JTb7tKSwn/RwPRADLLmALdT9XBj/ljEwkTI7ovYRGBp/L2OTeOaeDvOFlZBV
         /A2UypI6WErSAq6vPiyjliS8rUuF1yHIyzA354vyqLlWqgvlHguKoV4dS0dcXT+zbAGe
         7S6zDbz57XXdgd+1lSKMIPWMqaCAMG7W5elT6yHwXFSIO1MarucbOrMB+7UKDl/bU/dY
         yS42bxn6YaTWKUCDtKzEkcEUJtiBg4vV7z+hcH4mKAF3K8MSRMtYhicOVLTb8WiWTXfZ
         DBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s9o5y6vQrq/OjqTGJl1mlB5Bi1wRnaRbsPezF97mkUs=;
        b=DgV6hEENSoFc4D23fpVIOxYOuAEGCmULaJQEKsB3Gv8kKh1wqESNAPZBZZGXCkfGeC
         dYPS11i511mpx4vBdKiYGmS1NpeyI5CTjdQWbqtMG5SWQRIqL/PcQRlu1yQJBd5JGU1i
         Hbo2XwOADr9/E8uFydMBaPTS8lrfMDJUtC6xzFyFNrZLHms2uKHUD0p+TGrIbUThBuDb
         0NR8nfwuE55xoIAzrWS8kvdhFzxkdDXWeZR/ycXvnxShPGioWZfaGHACXnbyLufHJE/2
         4e87UFuNYgxU+ApUUhhR6I724k9NfvEaMNwQD1l5nUQsjc44fKkX/LNQUS24W9GEDOqF
         y77g==
X-Gm-Message-State: APjAAAWxqkdVdiBhZOGUbyBVNHi8nlxnJaRvT/IX0/xe5r+rijbvzoQa
        n6txvY1BK02/OpFe4xBKyqI2RqQHMiU=
X-Google-Smtp-Source: APXvYqyf/rIyNYQspDDSVQeBTQfelRgqIy4yAAttrIhlSmqv1/XULjtWXx112uO7pEz8cyTgvlFQVA==
X-Received: by 2002:ac8:64a:: with SMTP id e10mr17209357qth.30.1566829213902;
        Mon, 26 Aug 2019 07:20:13 -0700 (PDT)
Received: from fedora30.localdomain (pool-71-121-242-40.bltmmd.fios.verizon.net. [71.121.242.40])
        by smtp.gmail.com with ESMTPSA id j18sm6094973qth.24.2019.08.26.07.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 07:20:13 -0700 (PDT)
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Joshua Brindle <joshua.brindle@crunchydata.com>
Subject: [PATCH] default_range glblub implementation
Date:   Mon, 26 Aug 2019 07:20:08 -0700
Message-Id: <20190826142008.2198-1-joshua.brindle@crunchydata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A policy developer can now specify glblub as a default_range default and
the computed transition will be the intersection of the mls range of
the two contexts.

Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
---
 security/selinux/include/security.h |  3 ++-
 security/selinux/ss/context.h       |  6 ++++++
 security/selinux/ss/ebitmap.c       | 15 +++++++++++++++
 security/selinux/ss/ebitmap.h       |  1 +
 security/selinux/ss/mls.c           |  2 ++
 security/selinux/ss/mls_types.h     | 28 ++++++++++++++++++++++++++++
 security/selinux/ss/policydb.c      |  5 +++++
 security/selinux/ss/policydb.h      |  1 +
 8 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 111121281c47..ae840634e3c7 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -40,10 +40,11 @@
 #define POLICYDB_VERSION_CONSTRAINT_NAMES	29
 #define POLICYDB_VERSION_XPERMS_IOCTL	30
 #define POLICYDB_VERSION_INFINIBAND		31
+#define POLICYDB_VERSION_GLBLUB		32
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_INFINIBAND
+#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_GLBLUB
 
 /* Mask for just the mount related flags */
 #define SE_MNTMASK	0x0f
diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
index 2260c44a568c..cecb84d8b26c 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -95,6 +95,12 @@ static inline int mls_context_cpy_high(struct context *dst, struct context *src)
 	return rc;
 }
 
+
+static inline int mls_context_glblub(struct context *dst, struct context *c1, struct context *c2)
+{
+	return mls_range_glblub(&dst->range, &c1->range, &c2->range);
+}
+
 static inline int mls_context_cmp(struct context *c1, struct context *c2)
 {
 	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 09929fc5ab47..2042729b81f8 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -77,6 +77,21 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src)
 	return 0;
 }
 
+int ebitmap_and(struct ebitmap *dst, struct ebitmap *e1, struct ebitmap *e2)
+{
+	unsigned int i, length = min(ebitmap_length(e1), ebitmap_length(e2));
+	ebitmap_init(dst);
+	for (i=0; i < length; i++) {
+		if (ebitmap_get_bit(e1, i) && ebitmap_get_bit(e2, i)) {
+			int rc = ebitmap_set_bit(dst, i, 1);
+			if (rc < 0)
+				return rc;
+		}
+	}
+	return 0;
+}
+
+
 #ifdef CONFIG_NETLABEL
 /**
  * ebitmap_netlbl_export - Export an ebitmap into a NetLabel category bitmap
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index 6aa7cf6a2197..9a23b81b8832 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -124,6 +124,7 @@ static inline void ebitmap_node_clr_bit(struct ebitmap_node *n,
 
 int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
 int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
+int ebitmap_and(struct ebitmap *dst, struct ebitmap *e1, struct ebitmap *e2);
 int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2, u32 last_e2bit);
 int ebitmap_get_bit(struct ebitmap *e, unsigned long bit);
 int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value);
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 5e05f5b902d7..76c8ad014ac9 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -529,6 +529,8 @@ int mls_compute_sid(struct policydb *p,
 			return mls_context_cpy_high(newcontext, tcontext);
 		case DEFAULT_TARGET_LOW_HIGH:
 			return mls_context_cpy(newcontext, tcontext);
+		case DEFAULT_GLBLUB:
+			return mls_context_glblub(newcontext, scontext, tcontext);
 		}
 
 		/* Fallthrough */
diff --git a/security/selinux/ss/mls_types.h b/security/selinux/ss/mls_types.h
index 068e0d7809db..e2a20eb0e87c 100644
--- a/security/selinux/ss/mls_types.h
+++ b/security/selinux/ss/mls_types.h
@@ -39,6 +39,34 @@ static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
 		ebitmap_contains(&l1->cat, &l2->cat, 0));
 }
 
+static inline int mls_range_glblub(struct mls_range *dst, struct mls_range *r1, struct mls_range *r2)
+{
+	int rc = 0;
+
+	if (r1->level[1].sens < r2->level[0].sens || r2->level[1].sens < r1->level[0].sens) {
+	{
+		// These ranges have no common sensitivities
+		return -1;
+	}
+
+	// Take the greatest of the low
+	dst->level[0].sens = max(r1->level[0].sens, r2->level[0].sens);
+
+        // Take the least of the high
+	dst->level[1].sens = min(r1->level[1].sens, r2->level[1].sens);
+
+	rc = ebitmap_and(&dst->level[0].cat, &r1->level[0].cat, &r2->level[0].cat);
+	if (rc)
+		goto out;
+
+	rc = ebitmap_and(&dst->level[1].cat, &r1->level[1].cat, &r2->level[1].cat);
+	if (rc)
+		goto out;
+
+out:
+	return rc;
+}
+
 #define mls_level_incomp(l1, l2) \
 (!mls_level_dom((l1), (l2)) && !mls_level_dom((l2), (l1)))
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index f8efaa9f647c..1b59f72effbb 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -160,6 +160,11 @@ static struct policydb_compat_info policydb_compat[] = {
 		.sym_num	= SYM_NUM,
 		.ocon_num	= OCON_NUM,
 	},
+	{
+		.version	= POLICYDB_VERSION_GLBLUB,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NUM,
+	},
 };
 
 static struct policydb_compat_info *policydb_lookup_compat(int version)
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index fcc6366b447f..0c41d0b4da96 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -69,6 +69,7 @@ struct class_datum {
 #define DEFAULT_TARGET_LOW     4
 #define DEFAULT_TARGET_HIGH    5
 #define DEFAULT_TARGET_LOW_HIGH        6
+#define DEFAULT_GLBLUB		7
 	char default_range;
 };
 
-- 
2.21.0

