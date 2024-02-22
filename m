Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D1113BAD8
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646385; cv=none; b=YguQOlFi3aYYJRLaEAxdOCRdsT0PwHbAh03zg3sMEPhjvAGYpILPzHxu1RXd+3UKucwyrBwKnr3BH2/gQBjWM3dmmO5MMVBE6LB+6TwTmUXM3vCjVkcioBTqnIRRGVAkKqbuCy4//FDD4XrpWrkqScYhcpAOFM9hpEaQREXDsNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646385; c=relaxed/simple;
	bh=0myqjR7bL7e9jczq8U37pmJ9D5uz1aYn/yTKEm8VFcg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzzuYQ/QT2t3zSirfQYP2STtx0ibFoU6iVSS17J4F4mfw1AKVV/FGHiHlR/8HC9GnsG+2gnJZ0wi2fORiZ2y4rDVVJvepdZ44wsurkLdttfPWM8+o5t43rmweMu9bZdrlcIbKqKcrmn9TeREPOULZWmUwJ/O6zqRSqJYWaY8kYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QMDWCx1A; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QMDWCx1A"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6080a3eecd4so3266807b3.2
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646382; x=1709251182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWYpiilN4nTrPbR6MOLP0d0xEslY2d0ttJvDdoofzd4=;
        b=QMDWCx1A+B49CHxKRt+egSyU2uIyaBX2a3TkC5KnHxgTJxVWNWTaCYJ52MXBHg66PJ
         wL4RMcWJVJCwrTbk6gHmyiqqxVcnacq+6nVgtWUj+3uY628Lbm9+rvgF7Q/INEFBy6Wz
         r5iAzEcrvweBsoM1escNy6AV8h46ClimC1vT0iZWk4a/pFi1wXnVXM97ENF1mDwxRoU8
         reG7pLfn8W572dwz0pd+11tSqvjznISDWT5wi6+DfqEcOW+zAsYouz93QNayrlxEhC35
         WLK2YH5qMm8P8O8H+NLwXfSJnRw00rEQj24efgOGXB4lL2EJv1D67CKSvQxKfrf1AHGb
         5OAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646382; x=1709251182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWYpiilN4nTrPbR6MOLP0d0xEslY2d0ttJvDdoofzd4=;
        b=rCPQZCCA5kadNIZasD3Jq0jq2G3PplF5dSu83rdHH02KgOgfq07Cn2+CjD5GhU+LDG
         Gel8QNIj4DM2ZYP3AhWSJUhEtMpOpJGwOitY5qbCrUC65zWmj28fjC1vcMdQ27W9rOao
         3EflseQmylsgBzwhCx+V2avc1XcE6CGer8ruDKXsVxcMLp14XArgjrG/M3FEebqi3YVa
         elyppzWBUwhwn3w5YedQKfktfmXaZtCdQfBMqDkwm5JRDos7QWBC5Vvv691gfb/gZhNL
         TknSVNm8jctLqpEYZrDgRm7IwhoQvnv/x2uHGEUpcDfObH3G/iJ1NjJNneLUEc+F4AQF
         5TdA==
X-Gm-Message-State: AOJu0YwtPCM9yTqjSdiybRr5fhCfQrA97ZovDVuuLnDMsz8QEKTdJAFH
	9Hmplxj1gWfxtnm+lWoHM3a6vU+9jHt1p6k289eBBn3v8o5bqtYgW+cnhCJOVUP0JWDZE5MTfCo
	=
X-Google-Smtp-Source: AGHT+IGh53pUJTrrzw2OGrJoTzIaVEAywSlNuNGhzkCiO8Z9S5f3d2drKfw+16Oz0OxJAAjjMGGVRg==
X-Received: by 2002:a05:690c:368f:b0:607:cc6a:58aa with SMTP id fu15-20020a05690c368f00b00607cc6a58aamr821000ywb.23.1708646382107;
        Thu, 22 Feb 2024 15:59:42 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id x6-20020ac81206000000b0042e5da69d93sm262513qti.1.2024.02.22.15.59.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:41 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 09/21] selinux: fix style issues in security/selinux/ss/ebitmap.c
Date: Thu, 22 Feb 2024 18:52:27 -0500
Message-ID: <20240222235708.386652-32-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6400; i=paul@paul-moore.com; h=from:subject; bh=0myqjR7bL7e9jczq8U37pmJ9D5uz1aYn/yTKEm8VFcg=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl19+GJK5U7fQIfy5/hXNXI63a4SXgFNJqBTX/E Qz5LA35n6mJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffhgAKCRDqIPLalzeJ czMlEACNadQ7Z5UgunXJVkG4+JAHbpHlGJptwq1qD/voDRx4EGwd7mox2r71KyzXGfnaMDYtZed 5lHH+gxK9KLEs/iS+zHe2muYc7YiLZDApUWKDHNRxZ677aZ4HPUxzL/JFTipcpB9Ad9XOi4OYw6 /RV2g9gSG7F8XH+70OuzkrxdnwRdDN/jmCnCbFsRGQL7CmD0sbvXeXQZ1joA7cVSMdNBaOOJqSi i1u+J6qOBbg/fVSNbiXmsmXPi069RoXVrwrIKFrimqH41PJ8U4pvhSgrKFlUkU+V3x8p35k7y2b PDG5xvhHUoTC+vkX9f3t1RLvj4FNoqezH6uUnFzXW8+lD66H24o/4s4vFSRY3BpPghnAk5HzNp3 5xIxSDbuKmQ/t+2fzn2+Cgr3ZhS4O8qhMJV1y2rQ1dpBf6u6yG0kiXIvd1gASdU4L2NF8lIaRi6 cf7W4ZUyDn8i1+NCUfNUrY8IqPkxH93uzrQJ47DyJC5OueHkY5Rg7ajnzQrGkY3npZVSKqj9tAG XYB0QPYGEkDM8W1vJwH5xBSgqBmh34JftdKjMrlINDiNlg7BtUI/b+MmCpn1axM7kG07The5oyG fy16Kd7Z4197Jq/+6ZgWi+KBkXdwgiODR8cfi0VC25ImpP1jQl8oCZtzjsIGSRNjEXRp+KlV7VJ VeZ7Ta44AhFNsWg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/ebitmap.c | 56 +++++++++++++++++------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 77875ad355f7..67c1a73cd5ee 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Implementation of the extensible bitmap type.
  *
@@ -6,14 +6,11 @@
  */
 /*
  * Updated: Hewlett-Packard <paul@paul-moore.com>
+ *          Added support to import/export the NetLabel category bitmap
+ *          (c) Copyright Hewlett-Packard Development Company, L.P., 2006
  *
- *      Added support to import/export the NetLabel category bitmap
- *
- * (c) Copyright Hewlett-Packard Development Company, L.P., 2006
- */
-/*
  * Updated: KaiGai Kohei <kaigai@ak.jp.nec.com>
- *      Applied standard bit operations to improve bitmap scanning.
+ *          Applied standard bit operations to improve bitmap scanning.
  */
 
 #include <linux/kernel.h>
@@ -24,7 +21,7 @@
 #include "ebitmap.h"
 #include "policydb.h"
 
-#define BITS_PER_U64	(sizeof(u64) * 8)
+#define BITS_PER_U64 (sizeof(u64) * 8)
 
 static struct kmem_cache *ebitmap_node_cachep __ro_after_init;
 
@@ -37,8 +34,7 @@ int ebitmap_cmp(const struct ebitmap *e1, const struct ebitmap *e2)
 
 	n1 = e1->node;
 	n2 = e2->node;
-	while (n1 && n2 &&
-	       (n1->startbit == n2->startbit) &&
+	while (n1 && n2 && (n1->startbit == n2->startbit) &&
 	       !memcmp(n1->maps, n2->maps, EBITMAP_SIZE / 8)) {
 		n1 = n1->next;
 		n2 = n2->next;
@@ -79,14 +75,16 @@ int ebitmap_cpy(struct ebitmap *dst, const struct ebitmap *src)
 	return 0;
 }
 
-int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1, const struct ebitmap *e2)
+int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1,
+		const struct ebitmap *e2)
 {
 	struct ebitmap_node *n;
 	int bit, rc;
 
 	ebitmap_init(dst);
 
-	ebitmap_for_each_positive_bit(e1, n, bit) {
+	ebitmap_for_each_positive_bit(e1, n, bit)
+	{
 		if (ebitmap_get_bit(e2, bit)) {
 			rc = ebitmap_set_bit(dst, bit, 1);
 			if (rc < 0)
@@ -96,7 +94,6 @@ int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1, const struct ebit
 	return 0;
 }
 
-
 #ifdef CONFIG_NETLABEL
 /**
  * ebitmap_netlbl_export - Export an ebitmap into a NetLabel category bitmap
@@ -131,10 +128,8 @@ int ebitmap_netlbl_export(struct ebitmap *ebmap,
 		for (iter = 0; iter < EBITMAP_UNIT_NUMS; iter++) {
 			e_map = e_iter->maps[iter];
 			if (e_map != 0) {
-				rc = netlbl_catmap_setlong(catmap,
-							   offset,
-							   e_map,
-							   GFP_ATOMIC);
+				rc = netlbl_catmap_setlong(catmap, offset,
+							   e_map, GFP_ATOMIC);
 				if (rc != 0)
 					goto netlbl_export_failure;
 			}
@@ -185,7 +180,8 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
 		if (e_iter == NULL ||
 		    offset >= e_iter->startbit + EBITMAP_SIZE) {
 			e_prev = e_iter;
-			e_iter = kmem_cache_zalloc(ebitmap_node_cachep, GFP_ATOMIC);
+			e_iter = kmem_cache_zalloc(ebitmap_node_cachep,
+						   GFP_ATOMIC);
 			if (e_iter == NULL)
 				goto netlbl_import_failure;
 			e_iter->startbit = offset - (offset % EBITMAP_SIZE);
@@ -218,7 +214,8 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
  * if last_e2bit is non-zero, the highest set bit in e2 cannot exceed
  * last_e2bit.
  */
-int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2, u32 last_e2bit)
+int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2,
+		     u32 last_e2bit)
 {
 	const struct ebitmap_node *n1, *n2;
 	int i;
@@ -234,8 +231,8 @@ int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2, u32 las
 			n1 = n1->next;
 			continue;
 		}
-		for (i = EBITMAP_UNIT_NUMS - 1; (i >= 0) && !n2->maps[i]; )
-			i--;	/* Skip trailing NULL map entries */
+		for (i = EBITMAP_UNIT_NUMS - 1; (i >= 0) && !n2->maps[i];)
+			i--; /* Skip trailing NULL map entries */
 		if (last_e2bit && (i >= 0)) {
 			u32 lastsetbit = n2->startbit + i * EBITMAP_UNIT_SIZE +
 					 __fls(n2->maps[i]);
@@ -302,8 +299,8 @@ int ebitmap_set_bit(struct ebitmap *e, unsigned long bit, int value)
 					 * within the bitmap
 					 */
 					if (prev)
-						e->highbit = prev->startbit
-							     + EBITMAP_SIZE;
+						e->highbit = prev->startbit +
+							     EBITMAP_SIZE;
 					else
 						e->highbit = 0;
 				}
@@ -424,7 +421,8 @@ int ebitmap_read(struct ebitmap *e, void *fp)
 
 		if (!n || startbit >= n->startbit + EBITMAP_SIZE) {
 			struct ebitmap_node *tmp;
-			tmp = kmem_cache_zalloc(ebitmap_node_cachep, GFP_KERNEL);
+			tmp = kmem_cache_zalloc(ebitmap_node_cachep,
+						GFP_KERNEL);
 			if (!tmp) {
 				pr_err("SELinux: ebitmap: out of memory\n");
 				rc = -ENOMEM;
@@ -481,7 +479,8 @@ int ebitmap_write(const struct ebitmap *e, void *fp)
 	count = 0;
 	last_bit = 0;
 	last_startbit = -1;
-	ebitmap_for_each_positive_bit(e, n, bit) {
+	ebitmap_for_each_positive_bit(e, n, bit)
+	{
 		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
 			count++;
 			last_startbit = rounddown(bit, BITS_PER_U64);
@@ -497,7 +496,8 @@ int ebitmap_write(const struct ebitmap *e, void *fp)
 
 	map = 0;
 	last_startbit = INT_MIN;
-	ebitmap_for_each_positive_bit(e, n, bit) {
+	ebitmap_for_each_positive_bit(e, n, bit)
+	{
 		if (rounddown(bit, (int)BITS_PER_U64) > last_startbit) {
 			__le64 buf64[1];
 
@@ -559,6 +559,6 @@ u32 ebitmap_hash(const struct ebitmap *e, u32 hash)
 void __init ebitmap_cache_init(void)
 {
 	ebitmap_node_cachep = kmem_cache_create("ebitmap_node",
-							sizeof(struct ebitmap_node),
-							0, SLAB_PANIC, NULL);
+						sizeof(struct ebitmap_node), 0,
+						SLAB_PANIC, NULL);
 }
-- 
2.43.2

