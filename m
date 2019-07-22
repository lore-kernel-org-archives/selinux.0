Return-Path: <SRS0=8ULP=VT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4183DC76188
	for <selinux@archiver.kernel.org>; Mon, 22 Jul 2019 11:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2191521911
	for <selinux@archiver.kernel.org>; Mon, 22 Jul 2019 11:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfGVLfi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:35:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:3457 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbfGVLfi (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 22 Jul 2019 07:35:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 04:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,294,1559545200"; 
   d="scan'208";a="159853965"
Received: from ngote-system-product-name.iind.intel.com ([10.106.124.92])
  by orsmga007.jf.intel.com with ESMTP; 22 Jul 2019 04:35:33 -0700
From:   NitinGote <nitin.r.gote@intel.com>
To:     keescook@chromium.org
Cc:     kernel-hardening@lists.openwall.com, paul@paul-moore.com,
        sds@tycho.nsa.gov, eparis@parisplace.org, omosnace@redhat.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        NitinGote <nitin.r.gote@intel.com>
Subject: [PATCH] selinux: convert struct sidtab count to refcount_t
Date:   Mon, 22 Jul 2019 17:01:51 +0530
Message-Id: <20190722113151.1584-1-nitin.r.gote@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

refcount_t type and corresponding API should be
used instead of atomic_t when the variable is used as
a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free
situations.

Signed-off-by: NitinGote <nitin.r.gote@intel.com>
---
 security/selinux/ss/sidtab.c | 16 ++++++++--------
 security/selinux/ss/sidtab.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index e63a90ff2728..20fe235c6c71 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -29,7 +29,7 @@ int sidtab_init(struct sidtab *s)
 	for (i = 0; i < SECINITSID_NUM; i++)
 		s->isids[i].set = 0;

-	atomic_set(&s->count, 0);
+	refcount_set(&s->count, 0);

 	s->convert = NULL;

@@ -130,7 +130,7 @@ static struct context *sidtab_do_lookup(struct sidtab *s, u32 index, int alloc)

 static struct context *sidtab_lookup(struct sidtab *s, u32 index)
 {
-	u32 count = (u32)atomic_read(&s->count);
+	u32 count = refcount_read(&s->count);

 	if (index >= count)
 		return NULL;
@@ -245,7 +245,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 				 u32 *index)
 {
 	unsigned long flags;
-	u32 count = (u32)atomic_read(&s->count);
+	u32 count = (u32)refcount_read(&s->count);
 	u32 count_locked, level, pos;
 	struct sidtab_convert_params *convert;
 	struct context *dst, *dst_convert;
@@ -272,7 +272,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 	spin_lock_irqsave(&s->lock, flags);

 	convert = s->convert;
-	count_locked = (u32)atomic_read(&s->count);
+	count_locked = (u32)refcount_read(&s->count);
 	level = sidtab_level_from_count(count_locked);

 	/* if count has changed before we acquired the lock, then catch up */
@@ -315,7 +315,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 		}

 		/* at this point we know the insert won't fail */
-		atomic_set(&convert->target->count, count + 1);
+		refcount_set(&convert->target->count, count + 1);
 	}

 	if (context->len)
@@ -328,7 +328,7 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
 	/* write entries before writing new count */
 	smp_wmb();

-	atomic_set(&s->count, count + 1);
+	refcount_set(&s->count, count + 1);

 	rc = 0;
 out_unlock:
@@ -418,7 +418,7 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
 		return -EBUSY;
 	}

-	count = (u32)atomic_read(&s->count);
+	count = (u32)refcount_read(&s->count);
 	level = sidtab_level_from_count(count);

 	/* allocate last leaf in the new sidtab (to avoid race with
@@ -431,7 +431,7 @@ int sidtab_convert(struct sidtab *s, struct sidtab_convert_params *params)
 	}

 	/* set count in case no new entries are added during conversion */
-	atomic_set(&params->target->count, count);
+	refcount_set(&params->target->count, count);

 	/* enable live convert of new entries */
 	s->convert = params;
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index bbd5c0d1f3bd..68dd96a5beba 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -70,7 +70,7 @@ struct sidtab_convert_params {

 struct sidtab {
 	union sidtab_entry_inner roots[SIDTAB_MAX_LEVEL + 1];
-	atomic_t count;
+	refcount_t count;
 	struct sidtab_convert_params *convert;
 	spinlock_t lock;

--
2.17.1

