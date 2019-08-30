Return-Path: <SRS0=26Hx=W2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6B9C3A59B
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 15:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1903423427
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 15:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="OmX6cr0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfH3PkG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:40:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42110 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfH3PkG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Aug 2019 11:40:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id t12so8018390qtp.9
        for <selinux@vger.kernel.org>; Fri, 30 Aug 2019 08:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TwOUpIQ25jPLvALUFZFCTbvNhrGC5u6dsIaQmuJr3d8=;
        b=OmX6cr0XPPOFH5VHYR0RrOUUtu0+dNxpViqf+DIU+MqLDjgU+iuZe/Ml9sW1s/XfuL
         KBW7gkrUqri8cgily1fhmpZWQvsM2s3B+IplwiNC1i/r9tO9a3p9IpN1nZWsBJBIMBkl
         DUilr2QST6rO+JAPWSGplwwB1U5k42t0IL/oRAfp9tiJgTofMXxzsbtLM9FEPjfnZj+3
         yW2abWhsJil+tE32YWcBf2VHoZNLfm1ez0P9SQ2xAlS+/D51yizzx6mwZB6ll0W8DDiH
         7inNBYkZLkWkmia+YclyVi37yyFuzOj7687m1AFzY8f/B+3lXqy1gYqneXs9KyHWw18n
         j6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TwOUpIQ25jPLvALUFZFCTbvNhrGC5u6dsIaQmuJr3d8=;
        b=Czy6O/9brC0k0WFeO8rGQlqrA7C+EmnQd8MxBH4cxIo0F5W+YtYrCHcZXo0TwbtASw
         Rd3xgL53hnv+1doILZWr4w3Us0cIFvSeLtrFX51/3wc00UvZvj0DlxMkvqH2E7PoCMbd
         776jtB4wkUZV71VgZ30Pl1DZmfyc4dYOHiA5JDQVcMQdtjgDpSjmANeskxDEgWqysmch
         nj2aQi6vtbdOxW42Lms4jaIZXLhKeJomEZ65iWDGWp4Yxg2VHg3/yVrLhBbQEpVGzIKq
         ucnppcOgBJom153QqK9Rn5YOh941KwjNs8XXfE5QZM1udfnU/zDj+Z6VcwjRgo+7kfQt
         8dtw==
X-Gm-Message-State: APjAAAUNjLTLfa7m6MrHDpMRBLRD9qbq/qHkKnqCyUdaz8FCTeaBl+Zp
        BLUXwQOLVrkXpEGflDt7BmmNElJ1aN8=
X-Google-Smtp-Source: APXvYqwVfcN/N06fht7rnYuN83YnZybq3IRL4aRvQS9aAlAgDeSfYB2wu7r9EG0X1S4nCDslyugKAQ==
X-Received: by 2002:a0c:8809:: with SMTP id 9mr10758246qvl.141.1567179605240;
        Fri, 30 Aug 2019 08:40:05 -0700 (PDT)
Received: from fedora30.localdomain (pool-71-121-242-40.bltmmd.fios.verizon.net. [71.121.242.40])
        by smtp.gmail.com with ESMTPSA id e5sm2229921qtk.35.2019.08.30.08.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 08:40:04 -0700 (PDT)
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Joshua Brindle <joshua.brindle@crunchydata.com>
Subject: [PATCH v3] default_range glblub implementation
Date:   Fri, 30 Aug 2019 08:39:47 -0700
Message-Id: <20190830153946.28159-1-joshua.brindle@crunchydata.com>
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

The glb (greatest lower bound) lub (lowest upper bound) of a range is calculated
as the greater of the low sensitivities and the lower of the high sensitivities
and the and of each category bitmap.

This can be used by MLS solution developers to compute a context that satisfies,
for example, the range of a network interface and the range of a user logging in.

Some examples are:

User Permitted Range | Network Device Label | Computed Label
---------------------|----------------------|----------------
S0-S1:c0.c12         | S0                   | S0
S0-S1:c0.c12         | S0-S1:c0.c1024       | S0-S1:c0.c12
S0-S4:c0.c512        | S1-S1:c0.c1024       | S1-S1:c0.c512
S0-S16:c0,c2         | S4-S6:c0.c128        | S4-S6:c0,c2
S0-S4                | S2-S6                | S2-S4
S0-S4                | S5-S8                | INVALID
S5-S8                | S0-S4                | INVALID
S6:c0,c2-S7:c4,c5    | S0:c2,c4-S6:c5.c100  | S6:c2-S6:c5

Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
---
 security/selinux/include/security.h |  3 ++-
 security/selinux/ss/context.h       | 28 ++++++++++++++++++++++++++++
 security/selinux/ss/ebitmap.c       | 18 ++++++++++++++++++
 security/selinux/ss/ebitmap.h       |  1 +
 security/selinux/ss/mls.c           |  2 ++
 security/selinux/ss/policydb.c      |  5 +++++
 security/selinux/ss/policydb.h      |  1 +
 7 files changed, 57 insertions(+), 1 deletion(-)

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
index 2260c44a568c..ea2a56d910a5 100644
--- a/security/selinux/ss/context.h
+++ b/security/selinux/ss/context.h
@@ -95,6 +95,34 @@ static inline int mls_context_cpy_high(struct context *dst, struct context *src)
 	return rc;
 }
 
+
+static inline int mls_context_glblub(struct context *dst, struct context *c1, struct context *c2)
+{
+	struct mls_range *dr = &dst->range, *r1 = &c1->range, *r2 = &c2->range;
+	int rc = 0;
+
+	if (r1->level[1].sens < r2->level[0].sens || r2->level[1].sens < r1->level[0].sens)
+		/* These ranges have no common sensitivities */
+		return -1;
+
+	/* Take the greatest of the low */
+	dr->level[0].sens = max(r1->level[0].sens, r2->level[0].sens);
+
+	/* Take the least of the high */
+	dr->level[1].sens = min(r1->level[1].sens, r2->level[1].sens);
+
+	rc = ebitmap_and(&dr->level[0].cat, &r1->level[0].cat, &r2->level[0].cat);
+	if (rc)
+		goto out;
+
+	rc = ebitmap_and(&dr->level[1].cat, &r1->level[1].cat, &r2->level[1].cat);
+	if (rc)
+		goto out;
+
+out:
+	return rc;
+}
+
 static inline int mls_context_cmp(struct context *c1, struct context *c2)
 {
 	return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 09929fc5ab47..c8c3663111e2 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -77,6 +77,24 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src)
 	return 0;
 }
 
+int ebitmap_and(struct ebitmap *dst, struct ebitmap *e1, struct ebitmap *e2)
+{
+	struct ebitmap_node *n;
+	int bit, rc;
+
+	ebitmap_init(dst);
+
+	ebitmap_for_each_positive_bit(e1, n, bit) {
+		if (ebitmap_get_bit(e2, bit)) {
+			rc = ebitmap_set_bit(dst, bit, 1);
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

