Return-Path: <SRS0=MVxc=RY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612C8C43381
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 21:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3846C21925
	for <selinux@archiver.kernel.org>; Thu, 21 Mar 2019 21:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfCUVpp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:45:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61443 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfCUVpo (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 21 Mar 2019 17:45:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC171C00735D;
        Thu, 21 Mar 2019 21:45:43 +0000 (UTC)
Received: from llong.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 013D75C659;
        Thu, 21 Mar 2019 21:45:40 +0000 (UTC)
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
Subject: [PATCH 4/4] mm: Do periodic rescheduling when freeing objects in kmem_free_up_q()
Date:   Thu, 21 Mar 2019 17:45:12 -0400
Message-Id: <20190321214512.11524-5-longman@redhat.com>
In-Reply-To: <20190321214512.11524-1-longman@redhat.com>
References: <20190321214512.11524-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 21 Mar 2019 21:45:43 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If the freeing queue has many objects, freeing all of them consecutively
may cause soft lockup especially on a debug kernel. So kmem_free_up_q()
is modified to call cond_resched() if running in the process context.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/slab_common.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index dba20b4208f1..633a1d0f6d20 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1622,11 +1622,14 @@ EXPORT_SYMBOL_GPL(kmem_free_q_add);
  * kmem_free_up_q - free all the objects in the freeing queue
  * @head: freeing queue head
  *
- * Free all the objects in the freeing queue.
+ * Free all the objects in the freeing queue. The caller cannot hold any
+ * non-sleeping locks.
  */
 void kmem_free_up_q(struct kmem_free_q_head *head)
 {
 	struct kmem_free_q_node *node, *next;
+	bool do_resched = !in_irq();
+	int cnt = 0;
 
 	for (node = head->first; node; node = next) {
 		next = node->next;
@@ -1634,6 +1637,12 @@ void kmem_free_up_q(struct kmem_free_q_head *head)
 			kmem_cache_free(node->cachep, node);
 		else
 			kfree(node);
+		/*
+		 * Call cond_resched() every 256 objects freed when in
+		 * process context.
+		 */
+		if (do_resched && !(++cnt & 0xff))
+			cond_resched();
 	}
 }
 EXPORT_SYMBOL_GPL(kmem_free_up_q);
-- 
2.18.1

