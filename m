Return-Path: <SRS0=pl+I=WK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC659C32753
	for <selinux@archiver.kernel.org>; Wed, 14 Aug 2019 13:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D112083B
	for <selinux@archiver.kernel.org>; Wed, 14 Aug 2019 13:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfHNNdZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:33:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54334 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfHNNdZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Aug 2019 09:33:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so4622932wme.4
        for <selinux@vger.kernel.org>; Wed, 14 Aug 2019 06:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2P45VgaeKFL7ns9duqFh90wO1EP3x5X4uRcvxsvMqR0=;
        b=YmFxuuUKvJjDjtIdzaiqPMFugbuzK3auRVFySU8MeixOkY00AQzD8iIUEEsP2Gh7RJ
         1/oiYQQ0oAgFTuBM2HP0p0Xg2BBSmPlzOCiWft2oSrtW80mHkM+nqF4cXG8uO38+gGYu
         lcmiawe7izebEp+fBGwPXPI6xZdxoK6CztyOt1foy3mqIyXrjps8RgDKc3Y5GviXIUFg
         2rRdulC2fr2D/aIazFs5YDWqVUgIh/tkG4YCws3hI9ZevzT8qVYHiJOQqlZ/X7i8joL/
         XhigI4G+NgQiYVUVhOkDvSScRNs9I0ChUO2stIUnrPcbxXKDnoFLN32gkAq7Mh+nqED6
         tj/Q==
X-Gm-Message-State: APjAAAU4UocK/q58LjddAGggS86j8CwB8V3tVR5Z61zZQoXrlQwMXB/S
        CUTdpgoeg/Ee8kLz261o6jlkrXktc7A=
X-Google-Smtp-Source: APXvYqzZJo1sTvXtf9fr0FnwWtK72932t+1B8K6hL51b5MM1Z4Xq3uqH5F4YThGGSr2bfZDwuy/hgA==
X-Received: by 2002:a1c:c00e:: with SMTP id q14mr8705853wmf.142.1565789602992;
        Wed, 14 Aug 2019 06:33:22 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c1sm3253740wmc.40.2019.08.14.06.33.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 06:33:22 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Jann Horn <jannh@google.com>, NitinGote <nitin.r.gote@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v2] selinux: avoid atomic_t usage in sidtab
Date:   Wed, 14 Aug 2019 15:33:20 +0200
Message-Id: <20190814133320.28516-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As noted in Documentation/atomic_t.txt, if we don't need the RMW atomic
operations, we should only use READ_ONCE()/WRITE_ONCE() +
smp_rmb()/smp_wmb() where necessary (or the combined variants
smp_load_acquire()/smp_store_release()).

This patch converts the sidtab code to use regular u32 for the counter
and reverse lookup cache and use the appropriate operations instead of
atomic_get()/atomic_set(). Note that when reading/updating the reverse
lookup cache we don't need memory barriers as it doesn't need to be
consistent or accurate. We can now also replace some atomic ops with
regular loads (when under spinlock) and stores (for conversion target
fields that are always accessed under the master table's spinlock).

We can now also bump SIDTAB_MAX to U32_MAX as we can use the full u32
range again.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Reviewed-by: Jann Horn <jannh@google.com>
---

v2: Added comments detailing access semantics of sidtab fields.

 security/selinux/ss/sidtab.c | 48 ++++++++++++++++--------------------
 security/selinux/ss/sidtab.h | 19 ++++++++++----
 2 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 1f0a6eaa2d6a..7d49994e8d5f 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -12,7 +12,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
-#include <linux/atomic.h>
+#include <asm/barrier.h>
 #include "flask.h"
 #include "security.h"
 #include "sidtab.h"
@@ -23,14 +23,14 @@ int sidtab_init(struct sidtab *s)
 
 	memset(s->roots, 0, sizeof(s->roots));
 
+	/* max count is SIDTAB_MAX so valid index is always < SIDTAB_MAX */
 	for (i = 0; i < SIDTAB_RCACHE_SIZE; i++)
-		atomic_set(&s->rcache[i], -1);
+		s->rcache[i] = SIDTAB_MAX;
 
 	for (i = 0; i < SECINITSID_NUM; i++)
 		s->isids[i].set = 0;
 
-	atomic_set(&s->count, 0);
-
+	s->count = 0;
 	s->convert = NULL;
 
 	spin_lock_init(&s->lock);
@@ -130,14 +130,12 @@ static struct context *sidtab_do_lookup(struct sidtab *s, u32 index, int alloc)
 
 static struct context *sidtab_lookup(struct sidtab *s, u32 index)
 {
-	u32 count = (u32)atomic_read(&s->count);
+	/* read entries only after reading count */
+	u32 count = smp_load_acquire(&s->count);
 
 	if (index >= count)
 		return NULL;
 
-	/* read entries after reading count */
-	smp_rmb();
-
 	return sidtab_do_lookup(s, index, 0);
 }
 
@@ -210,10 +208,10 @@ static int sidtab_find_context(union sidtab_entry_inner entry,
 static void sidtab_rcache_update(struct sidtab *s, u32 index, u32 pos)
 {
 	while (pos > 0) {
-		atomic_set(&s->rcache[pos], atomic_read(&s->rcache[pos - 1]));
+		WRITE_ONCE(s->rcache[pos], READ_ONCE(s->rcache[pos - 1]));
 		--pos;
 	}
-	atomic_set(&s->rcache[0], (int)index);
+	WRITE_ONCE(s->rcache[0], index);
 }
 
 static void sidtab_rcache_push(struct sidtab *s, u32 index)
@@ -227,14 +225,14 @@ static int sidtab_rcache_search(struct sidtab *s, struct context *context,
 	u32 i;
 
 	for (i = 0; i < SIDTAB_RCACHE_SIZE; i++) {
-		int v = atomic_read(&s->rcache[i]);
+		u32 v = READ_ONCE(s->rcache[i]);
 
-		if (v < 0)
+		if (v >= SIDTAB_MAX)
 			continue;
 
-		if (context_cmp(sidtab_do_lookup(s, (u32)v, 0), context)) {
-			sidtab_rcache_update(s, (u32)v, i);
-			*index = (u32)v;
+		if (context_cmp(sidtab_do_lookup(s, v, 0), context)) {
+			sidtab_rcache_update(s, v, i);
+			*index = v;
 			return 0;
 		}
 	}
@@ -245,8 +243,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 				 u32 *index)
 {
 	unsigned long flags;
-	u32 count = (u32)atomic_read(&s->count);
-	u32 count_locked, level, pos;
+	u32 count, count_locked, level, pos;
 	struct sidtab_convert_params *convert;
 	struct context *dst, *dst_convert;
 	int rc;
@@ -255,11 +252,10 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 	if (rc == 0)
 		return 0;
 
+	/* read entries only after reading count */
+	count = smp_load_acquire(&s->count);
 	level = sidtab_level_from_count(count);
 
-	/* read entries after reading count */
-	smp_rmb();
-
 	pos = 0;
 	rc = sidtab_find_context(s->roots[level], &pos, count, level,
 				 context, index);
@@ -272,7 +268,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 	spin_lock_irqsave(&s->lock, flags);
 
 	convert = s->convert;
-	count_locked = (u32)atomic_read(&s->count);
+	count_locked = s->count;
 	level = sidtab_level_from_count(count_locked);
 
 	/* if count has changed before we acquired the lock, then catch up */
@@ -320,7 +316,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 		}
 
 		/* at this point we know the insert won't fail */
-		atomic_set(&convert->target->count, count + 1);
+		convert->target->count = count + 1;
 	}
 
 	if (context->len)
@@ -331,9 +327,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 	*index = count;
 
 	/* write entries before writing new count */
-	smp_wmb();
-
-	atomic_set(&s->count, count + 1);
+	smp_store_release(&s->count, count + 1);
 
 	rc = 0;
 out_unlock:
@@ -423,7 +417,7 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
 		return -EBUSY;
 	}
 
-	count = (u32)atomic_read(&s->count);
+	count = s->count;
 	level = sidtab_level_from_count(count);
 
 	/* allocate last leaf in the new sidtab (to avoid race with
@@ -436,7 +430,7 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
 	}
 
 	/* set count in case no new entries are added during conversion */
-	atomic_set(&params->target->count, count);
+	params->target->count = count;
 
 	/* enable live convert of new entries */
 	s->convert = params;
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index bbd5c0d1f3bd..1f4763141aa1 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -40,8 +40,8 @@ union sidtab_entry_inner {
 #define SIDTAB_LEAF_ENTRIES \
 	(SIDTAB_NODE_ALLOC_SIZE / sizeof(struct sidtab_entry_leaf))
 
-#define SIDTAB_MAX_BITS 31 /* limited to INT_MAX due to atomic_t range */
-#define SIDTAB_MAX (((u32)1 << SIDTAB_MAX_BITS) - 1)
+#define SIDTAB_MAX_BITS 32
+#define SIDTAB_MAX U32_MAX
 /* ensure enough tree levels for SIDTAB_MAX entries */
 #define SIDTAB_MAX_LEVEL \
 	DIV_ROUND_UP(SIDTAB_MAX_BITS - size_to_shift(SIDTAB_LEAF_ENTRIES), \
@@ -69,13 +69,22 @@ struct sidtab_convert_params {
 #define SIDTAB_RCACHE_SIZE 3
 
 struct sidtab {
+	/*
+	 * lock-free read access only for as many items as a prior read of
+	 * 'count'
+	 */
 	union sidtab_entry_inner roots[SIDTAB_MAX_LEVEL + 1];
-	atomic_t count;
+	/*
+	 * access atomically via {READ|WRITE}_ONCE(); only increment under
+	 * spinlock
+	 */
+	u32 count;
+	/* access only under spinlock */
 	struct sidtab_convert_params *convert;
 	spinlock_t lock;
 
-	/* reverse lookup cache */
-	atomic_t rcache[SIDTAB_RCACHE_SIZE];
+	/* reverse lookup cache - access atomically via {READ|WRITE}_ONCE() */
+	u32 rcache[SIDTAB_RCACHE_SIZE];
 
 	/* index == SID - 1 (no entry for SECSID_NULL) */
 	struct sidtab_isid_entry isids[SECINITSID_NUM];
-- 
2.21.0

