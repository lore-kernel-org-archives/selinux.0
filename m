Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649A3C43381
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 21:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3930521917
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 21:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfCUVpl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:45:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35277 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfCUVpi (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 21 Mar 2019 17:45:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A087330821EC;
        Thu, 21 Mar 2019 21:45:37 +0000 (UTC)
Received: from llong.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06E364B3;
        Thu, 21 Mar 2019 21:45:35 +0000 (UTC)
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
Subject: [PATCH 1/4] mm: Implement kmem objects freeing queue
Date:   Thu, 21 Mar 2019 17:45:09 -0400
Message-Id: <20190321214512.11524-2-longman@redhat.com>
In-Reply-To: <20190321214512.11524-1-longman@redhat.com>
References: <20190321214512.11524-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 21 Mar 2019 21:45:37 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When releasing kernel data structures, freeing up the memory
occupied by those objects is usually the last step. To avoid races,
the release operation is commonly done with a lock held. However, the
freeing operations do not need to be under lock, but are in many cases.

In some complex cases where the locks protect many different memory
objects, that can be a problem especially if some memory debugging
features like KASAN are enabled. In those cases, freeing memory objects
under lock can greatly lengthen the lock hold time. This can even lead
to soft/hard lockups in some extreme cases.

To make it easer to defer freeing memory objects until after unlock,
a kernel memory freeing queue mechanism is now added. It is modelled
after the wake_q mechanism for waking up tasks without holding a lock.

Now kmem_free_q_add() can be called to add memory objects into a freeing
queue. Later on, kmem_free_up_q() can be called to free all the memory
objects in the freeing queue after releasing the lock.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/slab.h | 28 ++++++++++++++++++++++++++++
 mm/slab_common.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 11b45f7ae405..6116fcecbd8f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -762,4 +762,32 @@ int slab_dead_cpu(unsigned int cpu);
 #define slab_dead_cpu		NULL
 #endif
 
+/*
+ * Freeing queue node for freeing kmem_cache slab objects later.
+ * The node is put at the beginning of the memory object and so the object
+ * size cannot be smaller than sizeof(kmem_free_q_node).
+ */
+struct kmem_free_q_node {
+	struct kmem_free_q_node *next;
+	struct kmem_cache *cachep;	/* NULL if alloc'ed by kmalloc */
+};
+
+struct kmem_free_q_head {
+	struct kmem_free_q_node *first;
+	struct kmem_free_q_node **lastp;
+};
+
+#define DEFINE_KMEM_FREE_Q(name)	\
+	struct kmem_free_q_head name = { NULL, &name.first }
+
+static inline void kmem_free_q_init(struct kmem_free_q_head *head)
+{
+	head->first = NULL;
+	head->lastp = &head->first;
+}
+
+extern void kmem_free_q_add(struct kmem_free_q_head *head,
+			    struct kmem_cache *cachep, void *object);
+extern void kmem_free_up_q(struct kmem_free_q_head *head);
+
 #endif	/* _LINUX_SLAB_H */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 03eeb8b7b4b1..dba20b4208f1 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1597,6 +1597,47 @@ void kzfree(const void *p)
 }
 EXPORT_SYMBOL(kzfree);
 
+/**
+ * kmem_free_q_add - add a kmem object to a freeing queue
+ * @head: freeing queue head
+ * @cachep: kmem_cache pointer (NULL for kmalloc'ed objects)
+ * @object: kmem object to be freed put into the queue
+ *
+ * Put a kmem object into the freeing queue to be freed later.
+ */
+void kmem_free_q_add(struct kmem_free_q_head *head, struct kmem_cache *cachep,
+		     void *object)
+{
+	struct kmem_free_q_node *node = object;
+
+	WARN_ON_ONCE(cachep && cachep->object_size < sizeof(*node));
+	node->next = NULL;
+	node->cachep = cachep;
+	*(head->lastp) = node;
+	head->lastp = &node->next;
+}
+EXPORT_SYMBOL_GPL(kmem_free_q_add);
+
+/**
+ * kmem_free_up_q - free all the objects in the freeing queue
+ * @head: freeing queue head
+ *
+ * Free all the objects in the freeing queue.
+ */
+void kmem_free_up_q(struct kmem_free_q_head *head)
+{
+	struct kmem_free_q_node *node, *next;
+
+	for (node = head->first; node; node = next) {
+		next = node->next;
+		if (node->cachep)
+			kmem_cache_free(node->cachep, node);
+		else
+			kfree(node);
+	}
+}
+EXPORT_SYMBOL_GPL(kmem_free_up_q);
+
 /* Tracepoints definitions. */
 EXPORT_TRACEPOINT_SYMBOL(kmalloc);
 EXPORT_TRACEPOINT_SYMBOL(kmem_cache_alloc);
-- 
2.18.1

