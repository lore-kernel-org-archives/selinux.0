Return-Path: <SRS0=KzaI=W7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D487DC3A5A9
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 21:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A014620674
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 21:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="mGs0yRuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfIDVDb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:03:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40644 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDVDb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Sep 2019 17:03:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id f10so13928qkg.7
        for <selinux@vger.kernel.org>; Wed, 04 Sep 2019 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VW+qd/DAEnvfIGanoVGoQsaKw0Ns4zQuerz+SJkV3XA=;
        b=mGs0yRuEypE2GfS9k76n/UVFB/liD5qNtbh5bphtyEbTJxm/aA15TW+9lcQXJV0SuV
         L5oquc3R3fcMwZ+oLzgK43wzxs8EDsb8dSqydofAMsEq2S8sgFNbQL4kVEder6sHWWwD
         b2mREF/dIZZzcBTtgx/N4NReXvD87DUiOMjYX9XLiTMVbcfMQx90BLnHD1ZrXDWZE/B5
         FTR+I4Tse8fo6m8ZnTcBJ6l6wtt0z5yoPKthU4lAmAmrMQf1oYF2JIBjY4BTlpcvSLbu
         +8lZgaqw0LWOPwarwhRkI4wE/PTZnNrg1EMbKZxze1T/jSgfogNaDDHmkvGQydBcOErJ
         QYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VW+qd/DAEnvfIGanoVGoQsaKw0Ns4zQuerz+SJkV3XA=;
        b=EjkIvi3kiQ2LKqP18qPhkFgZQ9amV5kSysEf1fZG0UMlKlCovaFL/3q21yTwofarOj
         m6Sps5A9ngV3dOC6hSOp4GU8NLAOJqnSAlITHItzV6KpTXXO6gf0ThHNRwCb99g9fpdi
         1diuqrMb3Lr/GUuImiKcqQ2S95mmfGRlLKaJb1WGq+JclDDp/VI7HUTqGhJd9G3RLb4a
         hNHp3/ErYQRYcl6AmeK+EtUb9ShdxODB8PW73jaTLS+COzutNS/RTHCFRt2z5khf/I4M
         wZkUKIayBE6cyYVyqIdcV1VCy6OGj8l+Rlzd4KMHR5H1rrgkGMR1/iN1yLfTpvojkVTu
         QH+w==
X-Gm-Message-State: APjAAAUSj96SCFoZnY9f0a+BewfeZDRbVVSwAbYf/oy1pz6Y0XW4+PZn
        11onM249JK4h32Hr71PZPzNVHArwKLI=
X-Google-Smtp-Source: APXvYqwKPtxVH70vqRPvif9vGOC5aODWNbej5wRxa8LdhKNpe5QTDJ2r/2er2aSRMQPmH41pfeMaYg==
X-Received: by 2002:a37:8a46:: with SMTP id m67mr22739241qkd.349.1567631010010;
        Wed, 04 Sep 2019 14:03:30 -0700 (PDT)
Received: from fedora30.localdomain (pool-71-121-242-40.bltmmd.fios.verizon.net. [71.121.242.40])
        by smtp.gmail.com with ESMTPSA id g19sm102036qtb.2.2019.09.04.14.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:03:29 -0700 (PDT)
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com,
        Joshua Brindle <joshua.brindle@crunchydata.com>
Subject: [PATCH v4] default_range glblub implementation
Date:   Wed,  4 Sep 2019 14:03:23 -0700
Message-Id: <20190904210322.1502-1-joshua.brindle@crunchydata.com>
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
s0-s1:c0.c12         | s0                   | s0
s0-s1:c0.c12         | s0-s1:c0.c1023       | s0-s1:c0.c12
s0-s4:c0.c512        | s1-s1:c0.c1023       | s1-s1:c0.c512
s0-s15:c0,c2         | s4-s6:c0.c128        | s4-s6:c0,c2
s0-s4                | s2-s6                | s2-s4
s0-s4                | s5-s8                | INVALID
s5-s8                | s0-s4                | INVALID

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
index 2260c44a568c..9b8fbb17d3a9 100644
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
+		return -EINVAL;
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

