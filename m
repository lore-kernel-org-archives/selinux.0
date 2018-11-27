Return-Path: <SRS0=Cb3q=OG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00307C43610
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 10:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DB020873
	for <selinux@archiver.kernel.org>; Tue, 27 Nov 2018 10:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DB020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeK0VgR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:36:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44580 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbeK0VgR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Nov 2018 16:36:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so17811935wrt.11
        for <selinux@vger.kernel.org>; Tue, 27 Nov 2018 02:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QHhtw/IQhsqPhOLy4RIIr1pOCMe1+0ikEJEbPL56Q3g=;
        b=YxFJggNsaS5S7DpN0ed+Vxa4m2rx6Kxq5KEBAJi9OrTULE8BlSrAqQhe452uJTK0NH
         Yq2fs3Slvjs3uajI/4RGqTM/B2+uFX4VHKvX6jqhy21/Bd2h+WNfIZ4yUYbgh0t4cKcc
         cwPumi0nSkDNQfFrmn/Qw89/mBsyijtYhK4xBT2carnz4nv1tz7ALFeF7R3yHCq59EOv
         tQz3eq5+Ywckj50ZJrCYuXxNTRyz1fvQUuRjYCjzyfjv2AX7V4zmdyXEUo1UzYH5UZZr
         Gdezx4ziF/ibVnpf572CRo1e0cS58Xz+RUzDuFLpv3CBb26UGGOzW10lPr5OHXpVp7lk
         pgHw==
X-Gm-Message-State: AA+aEWZUlB7ORBbZ8MM6Y+WzYmZkY9xMohU9vNjQyhfeNEtns486QIrq
        y1WVy+yo1fDvWL1Rt8EcRTmYdEpx51mEWQ==
X-Google-Smtp-Source: AFSGD/W8cnjYvyrgnqvyTKq4LQYzTO40FWKkUjeMF8WCPiZ1/d1FjtIDDbnwx1ONzAbi1KdoymJUkA==
X-Received: by 2002:adf:9521:: with SMTP id 30mr25785419wrs.192.1543315127245;
        Tue, 27 Nov 2018 02:38:47 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f18sm2870765wrs.92.2018.11.27.02.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 02:38:46 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH v2 4/4] [squash] add back reverse lookup cache to sidtab
Date:   Tue, 27 Nov 2018 11:36:05 +0100
Message-Id: <20181127103605.32765-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181127103605.32765-1-omosnace@redhat.com>
References: <20181127103605.32765-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch adds a simple cache for reverse lookup to the new sidtab
implementation. The cache works in a very similar way as the old
implementation's cache. The only difference is that instead of storing
pointers to the hash table nodes it stores just the indices of the
'cached' entries.

The new cache ensures that the indices are loaded/stored atomically, but
it still has the drawback that concurrent cache updates may mess up the
contents of the cache. Such situation however only reduces its
effectivity, not the correctness of lookups.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/sidtab.c | 49 ++++++++++++++++++++++++++++++++++--
 security/selinux/ss/sidtab.h |  5 ++++
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index a82deecfac09..abd2beb6dafc 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -23,6 +23,9 @@ int sidtab_init(struct sidtab *s)
 
 	memset(s->roots, 0, sizeof(s->roots));
 
+	for (i = 0; i < SIDTAB_RCACHE_SIZE; i++)
+		atomic_set(&s->rcache[i], -1);
+
 	for (i = 0; i < SECINITSID_NUM; i++)
 		s->isids[i].set = 0;
 
@@ -204,6 +207,40 @@ static int sidtab_find_context(union sidtab_entry_inner entry,
 	return -ENOENT;
 }
 
+static void sidtab_rcache_update(struct sidtab *s, u32 index, u32 pos)
+{
+	while (pos > 0) {
+		atomic_set(&s->rcache[pos], atomic_read(&s->rcache[pos - 1]));
+		--pos;
+	}
+	atomic_set(&s->rcache[0], (int)index);
+}
+
+static void sidtab_rcache_push(struct sidtab *s, u32 index)
+{
+	sidtab_rcache_update(s, index, SIDTAB_RCACHE_SIZE - 1);
+}
+
+static int sidtab_rcache_search(struct sidtab *s, struct context *context,
+				u32 *index)
+{
+	u32 i;
+
+	for (i = 0; i < SIDTAB_RCACHE_SIZE; i++) {
+		int v = atomic_read(&s->rcache[i]);
+
+		if (v < 0)
+			continue;
+
+		if (context_cmp(sidtab_do_lookup(s, (u32)v, 0), context)) {
+			sidtab_rcache_update(s, (u32)v, i);
+			*index = (u32)v;
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+
 static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 				 u32 *index)
 {
@@ -214,6 +251,10 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 	struct context *dst, *dst_convert;
 	int rc;
 
+	rc = sidtab_rcache_search(s, context, index);
+	if (rc == 0)
+		return 0;
+
 	level = sidtab_level_from_count(count);
 
 	/* read entries after reading count */
@@ -222,8 +263,10 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 	pos = 0;
 	rc = sidtab_find_context(s->roots[level], &pos, count, level,
 				 context, index);
-	if (rc == 0)
+	if (rc == 0) {
+		sidtab_rcache_push(s, *index);
 		return 0;
+	}
 
 	/* lock-free search failed: lock, re-search, and insert if not found */
 	spin_lock_irqsave(&s->lock, flags);
@@ -235,8 +278,9 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 	/* if count has changed before we acquired the lock, then catch up */
 	while (count < count_locked) {
 		if (context_cmp(sidtab_do_lookup(s, count, 0), context)) {
-			rc = 0;
+			sidtab_rcache_push(s, count);
 			*index = count;
+			rc = 0;
 			goto out_unlock;
 		}
 		++count;
@@ -278,6 +322,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 		pr_info("SELinux:  Context %s is not valid (left unmapped).\n",
 			context->str);
 
+	sidtab_rcache_push(s, count);
 	*index = count;
 
 	/* write entries before writing new count */
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index 292512792a70..2bf50bf12751 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -66,12 +66,17 @@ struct sidtab_convert_params {
 	struct sidtab *target;
 };
 
+#define SIDTAB_RCACHE_SIZE 4
+
 struct sidtab {
 	union sidtab_entry_inner roots[SIDTAB_MAX_LEVEL + 1];
 	atomic_t count;
 	struct sidtab_convert_params *convert;
 	spinlock_t lock;
 
+	/* reverse lookup cache */
+	atomic_t rcache[SIDTAB_RCACHE_SIZE];
+
 	/* index == SID - 1 (no entry for SECSID_NULL) */
 	struct sidtab_isid_entry isids[SECINITSID_NUM];
 };
-- 
2.19.1

