Return-Path: <SRS0=VF96=T5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEEBC04AB3
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 07:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81737208C3
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 07:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfE2HiL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 May 2019 03:38:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40004 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfE2HiL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 May 2019 03:38:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id 15so789992wmg.5
        for <selinux@vger.kernel.org>; Wed, 29 May 2019 00:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eGMdSE2GCsRb5R4QSJjqQk06P9Mxv3bZBAK87hQDkSw=;
        b=h5BJ8FDJw2X8J5E8u14kPn2z2p+bcuFeBvEZiD64tjq7wWCrpwm5BaEh+DgjXEauXm
         8r445oEjrzGoGDAXSUHUGv/ggNH9v1L9JeaUU60FbjxmiivpxDEhiaEciMNhjZaApHwH
         ryexQ3VUFPAyxWPdyu2ZvD05C/PAI3ennDigDeJf6uPyLRTpLRa/9pZWrsmL12cztLWx
         QDe7jwJLVFrKXLVgjA6j3Uwe/KkVTcKoVe+dw5Qp7lj8FiCrBAIizWWoRScbtvXKfMgb
         /4Z36CJ7Zy0Ey7XUtOi2WRZQFlSddmnS/6UZgxLgb7f/CO8P8aujAiM3VOQQwhvC0wyQ
         LJqA==
X-Gm-Message-State: APjAAAUupXeG5HDPVfyh55foO5VGKEwqsMMuyj/N2hj/N2NHWu6nluae
        lhwQHedkwKet/3E6gKhNXuuDcvziqIU=
X-Google-Smtp-Source: APXvYqyMAhcbqx1SiOck01VpbjBgt0I5BWJjByLJhWDnyPDgO+DCrWuQUQqWpgtS9+PE10FZMEAUrg==
X-Received: by 2002:a1c:b041:: with SMTP id z62mr6243763wme.113.1559115489434;
        Wed, 29 May 2019 00:38:09 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p16sm32024877wrg.49.2019.05.29.00.38.08
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 00:38:08 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v3 6/7] [RFC] lisepol: slightly more thorough optimization
Date:   Wed, 29 May 2019 09:37:58 +0200
Message-Id: <20190529073759.20548-7-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529073759.20548-1-omosnace@redhat.com>
References: <20190529073759.20548-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Removes also rules that are covered only by a union of two or more
rules. There are usually only a few of such rules (if any), but there
should be almost no (policy build) perfomance cost for this.

Side effect: clears all permission bits covered by a more general rule
-> might slow down avtab lookups (only a single rule will now match each
query)
---
 libsepol/src/optimize.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index b3859b6c..abb711e7 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -73,36 +73,38 @@ static void destroy_type_map(const policydb_t *p, ebitmap_t *type_map)
 	free(type_map);
 }
 
-static int match_xperms(const uint32_t *p1, const uint32_t *p2)
+static int process_xperms(uint32_t *p1, const uint32_t *p2)
 {
 	size_t i;
+	int ret = 1;
 
 	for (i = 0; i < EXTENDED_PERMS_LEN; i++) {
-		if ((p2[i] & p1[i]) != p1[i])
-			return 0;
+		p1[i] &= ~p2[i];
+		if (p1[i] != 0)
+			ret = 0;
 	}
-	return 1;
+	return ret;
 }
 
-static int match_avtab_datum(uint16_t specified,
-			     const avtab_datum_t *d1, const avtab_datum_t *d2)
+static int process_avtab_datum(uint16_t specified,
+			       avtab_datum_t *d1, const avtab_datum_t *d2)
 {
 	/* inverse logic needed for AUDITDENY rules */
 	if (specified & AVTAB_AUDITDENY)
-		return (d1->data & d2->data) == d2->data;
+		return (d1->data |= ~d2->data) == 0xFFFFFFFF;
 
 	if (specified & AVTAB_AV)
-		return (d2->data & d1->data) == d1->data;
+		return (d1->data &= ~d2->data) == 0;
 
 	if (specified & AVTAB_XPERMS) {
-		const avtab_extended_perms_t *x1 = d1->xperms;
+		avtab_extended_perms_t *x1 = d1->xperms;
 		const avtab_extended_perms_t *x2 = d2->xperms;
 
 		if (x1->specified == AVTAB_XPERMS_IOCTLFUNCTION) {
 			if (x2->specified == AVTAB_XPERMS_IOCTLFUNCTION) {
 				if (x1->driver != x2->driver)
 					return 0;
-				return match_xperms(x1->perms, x2->perms);
+				return process_xperms(x1->perms, x2->perms);
 			}
 			if (x2->specified == AVTAB_XPERMS_IOCTLDRIVER)
 				return xperm_test(x1->driver, x2->perms);
@@ -111,7 +113,7 @@ static int match_avtab_datum(uint16_t specified,
 				return 0;
 
 			if (x2->specified == AVTAB_XPERMS_IOCTLDRIVER)
-				return match_xperms(x1->perms, x2->perms);
+				return process_xperms(x1->perms, x2->perms);
 		}
 		return 0;
 	}
@@ -152,7 +154,7 @@ static int is_avrule_redundant(avtab_ptr_t entry, avtab_t *tab,
 			if (!d2)
 				continue;
 
-			if (match_avtab_datum(key.specified, d1, d2))
+			if (process_avtab_datum(key.specified, d1, d2))
 				return 1;
 		}
 	}
@@ -205,7 +207,7 @@ static int is_cond_rule_redundant(avtab_ptr_t e1, cond_av_list_t *list,
 		if (!ebitmap_get_bit(&type_map[t1], t2))
 			continue;
 
-		if (match_avtab_datum(k1, &e1->datum, &e2->datum))
+		if (process_avtab_datum(k1, &e1->datum, &e2->datum))
 			return 1;
 	}
 	return 0;
-- 
2.20.1

