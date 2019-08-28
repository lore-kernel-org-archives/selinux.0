Return-Path: <SRS0=2AUq=WY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E63C3A5A1
	for <selinux@archiver.kernel.org>; Wed, 28 Aug 2019 20:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF5220828
	for <selinux@archiver.kernel.org>; Wed, 28 Aug 2019 20:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="WBIswn2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfH1UnS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:43:18 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38167 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfH1UnR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Aug 2019 16:43:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id u190so1019661qkh.5
        for <selinux@vger.kernel.org>; Wed, 28 Aug 2019 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eC7AZuMY3DBow60iBFc4BXZSeVd02oIb+Ldy1pmyLa0=;
        b=WBIswn2MwZd4vYRQmJuQfL2z+DHIpstAmUgX/YZjztgEBbUujjsxJwFXpefJ8QBAR+
         tnkcg75CBfCkXiyW8woDr22RFgY+9HMUeGw40jExpV2/3L/BK3kYoEUOQ+UqWfTEP49q
         dnBgr3PA2diJBbnorvK3DETvqwCIM7aAqBk0mCVZf29KZ59wscSuyXNfmlBkFlDuF1gW
         +WOt+S5kZPaf9uFKWjhHbGoDa/3ZcSRRTXf6Ol8ECX7khBN2qk1C+V0OtcxOxigaiHQh
         6qesWz5ilm8GlNgB7e6inHTEcUDu61G+Go741vOEOczbabWioTFO/bjwNSzNsKahvPNs
         iXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eC7AZuMY3DBow60iBFc4BXZSeVd02oIb+Ldy1pmyLa0=;
        b=oPsJHl7GNEdUEqqd26GP6GK1S4Pa17Ks+JXG0vNL8HwIwhL2593+4CjeWNe1WJnua3
         9YnB3jzS6iwjruGIlR8SeZSoqi1h5mXW8zp7EnZ1klN3+dWNII+dxzjH8NrBncnq8KAX
         h6xo4dB01HcMDlpyUVTEz19VWjoL0hoCxB3QJ8l1m6BCRC1svweE9ne3oocNu1XW6yih
         GAcxkjG0cr2KCQdThv4zBY4D002dqvjuFtyIuTabMneGtBjbzlBhDZVTTIjTCzzQhlqf
         4WpdCAV4IDubah6Sew6OBHWm4GpmCBEwNZcCuG7xf+jCCO23U3WZGjXlMErE1XHVvkVe
         DQQA==
X-Gm-Message-State: APjAAAVmfYIKkxbNm/x6uITVmlRW/VRYvxsTnc+bZ39RtLgR5vU7morl
        ZnUDX0xyVZtLWZeD/LkTh7FiW9G2euU=
X-Google-Smtp-Source: APXvYqx74UqfGT7xkf3K+VcQ1iyyYRg/ZqzXxVsvSNpgu7vcxqLDrEZR7Pggd2usOA7rTw2aIS7WiQ==
X-Received: by 2002:ae9:e102:: with SMTP id g2mr6039785qkm.182.1567024996739;
        Wed, 28 Aug 2019 13:43:16 -0700 (PDT)
Received: from fedora30.localdomain (pool-71-121-242-40.bltmmd.fios.verizon.net. [71.121.242.40])
        by smtp.gmail.com with ESMTPSA id y67sm145275qkd.40.2019.08.28.13.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 13:43:16 -0700 (PDT)
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Joshua Brindle <joshua.brindle@crunchydata.com>
Subject: [PATCH v2] default_range glblub implementation
Date:   Wed, 28 Aug 2019 13:43:00 -0700
Message-Id: <20190828204259.23160-1-joshua.brindle@crunchydata.com>
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
index 2260c44a568c..0a0fbcc0d90c 100644
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
+	// Take the greatest of the low
+	dr->level[0].sens = max(r1->level[0].sens, r2->level[0].sens);
+
+        // Take the least of the high
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
index 09929fc5ab47..c0a9f8ecffc3 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -77,6 +77,24 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src)
 	return 0;
 }
 
+int ebitmap_and(struct ebitmap *dst, struct ebitmap *e1, struct ebitmap *e2)
+{
+	struct ebitmap_node *n;
+	int bit;
+
+	ebitmap_init(dst);
+
+	ebitmap_for_each_positive_bit(e1, n, bit) {
+		if (ebitmap_get_bit(e2, bit)) {
+			int rc = ebitmap_set_bit(dst, bit, 1);
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

