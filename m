Return-Path: <SRS0=pD7g=VW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33665C76191
	for <selinux@archiver.kernel.org>; Thu, 25 Jul 2019 13:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078682075E
	for <selinux@archiver.kernel.org>; Thu, 25 Jul 2019 13:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbfGYN7k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:59:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44368 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390987AbfGYN7i (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Jul 2019 09:59:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so50887793wrf.11
        for <selinux@vger.kernel.org>; Thu, 25 Jul 2019 06:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9XNbuOKaJr7DHARWd/UxHo0V4FulYfiy9Ai6RraBIg=;
        b=djghi8Gl2xnDqwHLqdW4lzUZG3eU3aQdB8sN33cLsaJrgOmLdHuc5rPeKxilRE3Qwf
         hmB9OC2/A/X+tjjzASHBZ+epMeK3JXjxEHp4QDsLMfh1zqJsp6F8BKq6HXue3zaVNL3Y
         9AIH/jEK8DPufVxmTblemIPSoY1UGBgwlMWW/dfX7iVyEH/kaARQSY6qJEMvm8fdeK8W
         a9YeDOWbF5OoLXjgnsz5fDw/6fEnlnzayrimlcFsTGyep0cCfd0rFA6GCtdLRj6FMqzv
         Zj5GvPZz2oYqGdJ8aIerOKF0z8js0nNoqHj6QTZduDLLjiqBGM9nb7OpWJl98vLJqdOu
         /gPg==
X-Gm-Message-State: APjAAAVydDMjfjFGux/uOq6IcCSm3Jg/DqQpUWBRqcRbPGZzQfKw4aS0
        V9+zrekArbhTZu++ZlHFf0G1hsh7nHk4tw==
X-Google-Smtp-Source: APXvYqzcqSQf7sNmxyEnDFJwl9YYj7HUuP3AZy31xYXQoZPbU1zHE29jlHKVrccC7EhcVduKGByS3w==
X-Received: by 2002:a5d:5302:: with SMTP id e2mr80037777wrv.347.1564063176371;
        Thu, 25 Jul 2019 06:59:36 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 32sm42711717wrh.76.2019.07.25.06.59.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 06:59:35 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Jann Horn <jannh@google.com>, NitinGote <nitin.r.gote@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] selinux: avoid atomic_t usage in sidtab
Date:   Thu, 25 Jul 2019 15:59:33 +0200
Message-Id: <20190725135933.30046-1-omosnace@redhat.com>
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
---
 security/selinux/ss/sidtab.c | 48 ++++++++++++++++--------------------
 security/selinux/ss/sidtab.h |  8 +++---
 2 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index e63a90ff2728..dc6c078b6432 100644
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
@@ -315,7 +311,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 		}
 
 		/* at this point we know the insert won't fail */
-		atomic_set(&convert->target->count, count + 1);
+		convert->target->count = count + 1;
 	}
 
 	if (context->len)
@@ -326,9 +322,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 	*index = count;
 
 	/* write entries before writing new count */
-	smp_wmb();
-
-	atomic_set(&s->count, count + 1);
+	smp_store_release(&s->count, count + 1);
 
 	rc = 0;
 out_unlock:
@@ -418,7 +412,7 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
 		return -EBUSY;
 	}
 
-	count = (u32)atomic_read(&s->count);
+	count = s->count;
 	level = sidtab_level_from_count(count);
 
 	/* allocate last leaf in the new sidtab (to avoid race with
@@ -431,7 +425,7 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
 	}
 
 	/* set count in case no new entries are added during conversion */
-	atomic_set(&params->target->count, count);
+	params->target->count = count;
 
 	/* enable live convert of new entries */
 	s->convert = params;
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index bbd5c0d1f3bd..b4561c5ec893 100644
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
@@ -70,12 +70,12 @@ struct sidtab_convert_params {
 
 struct sidtab {
 	union sidtab_entry_inner roots[SIDTAB_MAX_LEVEL + 1];
-	atomic_t count;
+	u32 count;
 	struct sidtab_convert_params *convert;
 	spinlock_t lock;
 
 	/* reverse lookup cache */
-	atomic_t rcache[SIDTAB_RCACHE_SIZE];
+	u32 rcache[SIDTAB_RCACHE_SIZE];
 
 	/* index == SID - 1 (no entry for SECSID_NULL) */
 	struct sidtab_isid_entry isids[SECINITSID_NUM];
-- 
2.21.0

