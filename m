Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B2CC43381
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 21:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1854521925
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 21:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfCUVpz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:45:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbfCUVpl (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 21 Mar 2019 17:45:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D480C30821A3;
        Thu, 21 Mar 2019 21:45:40 +0000 (UTC)
Received: from llong.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47A2A5C66D;
        Thu, 21 Mar 2019 21:45:39 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 3/4] signal: Add free_uid_to_q()
Date:   Thu, 21 Mar 2019 17:45:11 -0400
Message-Id: <20190321214512.11524-4-longman@redhat.com>
In-Reply-To: <20190321214512.11524-1-longman@redhat.com>
References: <20190321214512.11524-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 21 Mar 2019 21:45:41 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a new free_uid_to_q() function to put the user structure on
freeing queue instead of freeing it directly. That new function is then
called from __sigqueue_free() with a free_q parameter.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched/user.h |  3 +++
 kernel/signal.c            |  2 +-
 kernel/user.c              | 17 +++++++++++++----
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index c7b5f86b91a1..77f28d5cb940 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -63,6 +63,9 @@ static inline struct user_struct *get_uid(struct user_struct *u)
 	refcount_inc(&u->__count);
 	return u;
 }
+
+struct kmem_free_q_head;
 extern void free_uid(struct user_struct *);
+extern void free_uid_to_q(struct user_struct *u, struct kmem_free_q_head *q);
 
 #endif /* _LINUX_SCHED_USER_H */
diff --git a/kernel/signal.c b/kernel/signal.c
index 04fb202c16bd..2ecb23b540eb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -440,7 +440,7 @@ static void __sigqueue_free(struct sigqueue *q, struct kmem_free_q_head *free_q)
 	if (q->flags & SIGQUEUE_PREALLOC)
 		return;
 	atomic_dec(&q->user->sigpending);
-	free_uid(q->user);
+	free_uid_to_q(q->user, free_q);
 	if (free_q)
 		kmem_free_q_add(free_q, sigqueue_cachep, q);
 	else
diff --git a/kernel/user.c b/kernel/user.c
index 0df9b1640b2a..d92629bae546 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -135,14 +135,18 @@ static struct user_struct *uid_hash_find(kuid_t uid, struct hlist_head *hashent)
  * IRQ state (as stored in flags) is restored and uidhash_lock released
  * upon function exit.
  */
-static void free_user(struct user_struct *up, unsigned long flags)
+static void free_user(struct user_struct *up, unsigned long flags,
+		      struct kmem_free_q_head *free_q)
 	__releases(&uidhash_lock)
 {
 	uid_hash_remove(up);
 	spin_unlock_irqrestore(&uidhash_lock, flags);
 	key_put(up->uid_keyring);
 	key_put(up->session_keyring);
-	kmem_cache_free(uid_cachep, up);
+	if (free_q)
+		kmem_free_q_add(free_q, uid_cachep, up);
+	else
+		kmem_cache_free(uid_cachep, up);
 }
 
 /*
@@ -162,7 +166,7 @@ struct user_struct *find_user(kuid_t uid)
 	return ret;
 }
 
-void free_uid(struct user_struct *up)
+void free_uid_to_q(struct user_struct *up, struct kmem_free_q_head *free_q)
 {
 	unsigned long flags;
 
@@ -170,7 +174,12 @@ void free_uid(struct user_struct *up)
 		return;
 
 	if (refcount_dec_and_lock_irqsave(&up->__count, &uidhash_lock, &flags))
-		free_user(up, flags);
+		free_user(up, flags, free_q);
+}
+
+void free_uid(struct user_struct *up)
+{
+	free_uid_to_q(up, NULL);
 }
 
 struct user_struct *alloc_uid(kuid_t uid)
-- 
2.18.1

