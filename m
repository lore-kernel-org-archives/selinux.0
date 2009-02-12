From: Eric Paris <eparis@redhat.com>
Subject: [DO NOT COMMIT PATCH 2/2] SELinux: make avc_cache per cpu - DO NOT
	COMMIT
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
Date: Thu, 12 Feb 2009 14:52:36 -0500
Message-ID: <20090212195235.25719.6624.stgit@paris.rdu.redhat.com>
In-Reply-To: <20090212195230.25719.99849.stgit@paris.rdu.redhat.com>
References: <20090212195230.25719.99849.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I tried making the avc_cache per cpu and making sure the memory for that cache
was allocated in our numa node.  Having it per_cpu means that we don't need
per hash locks since only one cpu will really be working on the list at a
time.   So the results were not what I had hoped.  We did speed up a bit in
avc_has_perm_noaudit but up front overhead of making every cpu decide every
avc decision wasn't worth it.  Probably because even though we have the global
lists which may or may not even be close to the cpu, they are very much read
only and so we can keep things in cache close to our cpu.

Maybe someday I'll revisit this and try to make a per numa node avc_cache
instead of per cpu, but the overhead of building these caches was not worth
it, even with running my benchmark for an hour.

6.7189%  vmlinux avtab_search_node
0.7589%  vmlinux context_struct_compute_av

avc_has_perm_noaudit was my hottest selinux function running at less than 1%
of the total time but avtab_search_node and context_struct_compute_av became
the dominant functions.

THIS PATCH IS NOT TO BE COMMITTED.  IT IS BEING SENT TO THE LIST ONLY FOR
HISTORICAL PERSPECTIVE.
---

 security/selinux/avc.c |  171 ++++++++++++++++++++++++++++--------------------
 1 files changed, 100 insertions(+), 71 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index d8fb209..69c5d7a 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -96,18 +96,15 @@ struct avc_node {
 	struct rcu_head		rhead;
 };
 
-struct avc_slot {
-	struct hlist_head	head; /* head for avc_node->list */
-	spinlock_t		lock; /* lock for writes */
-};
-
 struct avc_cache {
-	struct avc_slot		slots[AVC_CACHE_SLOTS];
+	struct hlist_head	slots[AVC_CACHE_SLOTS];
+	spinlock_t		lock; /* lock for writes */
 	atomic_t		lru_hint;	/* LRU hint for reclaim scan */
 	atomic_t		active_nodes;
-	u32			latest_notif;	/* latest revocation notification */
 };
 
+static u32			latest_notif;	/* latest revocation notification */
+
 struct avc_callback_node {
 	int (*callback) (u32 event, u32 ssid, u32 tsid,
 			 u16 tclass, u32 perms,
@@ -127,7 +124,7 @@ unsigned int avc_cache_threshold = AVC_DEF_CACHE_THRESHOLD;
 DEFINE_PER_CPU(struct avc_cache_stats, avc_cache_stats) = { 0 };
 #endif
 
-static struct avc_cache avc_cache;
+static DEFINE_PER_CPU(struct avc_cache, avc_cache);
 static struct avc_callback_node *avc_callbacks;
 static struct kmem_cache *avc_node_cachep;
 
@@ -240,13 +237,16 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
 void __init avc_init(void)
 {
 	int i;
+	unsigned cpu;
 
-	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		INIT_HLIST_HEAD(&avc_cache.slots[i].head);
-		spin_lock_init(&avc_cache.slots[i].lock);
+	for_each_possible_cpu(cpu) {
+		for (i = 0; i < AVC_CACHE_SLOTS; i++) {
+			INIT_HLIST_HEAD(&per_cpu(avc_cache, cpu).slots[i]);
+		}
+		spin_lock_init(&per_cpu(avc_cache, cpu).lock);
+		atomic_set(&per_cpu(avc_cache, cpu).active_nodes, 0);
+		atomic_set(&per_cpu(avc_cache, cpu).lru_hint, 0);
 	}
-	atomic_set(&avc_cache.active_nodes, 0);
-	atomic_set(&avc_cache.lru_hint, 0);
 
 	avc_node_cachep = kmem_cache_create("avc_node", sizeof(struct avc_node),
 					     0, SLAB_PANIC, NULL);
@@ -256,34 +256,49 @@ void __init avc_init(void)
 
 int avc_get_hash_stats(char *page)
 {
-	int i, chain_len, max_chain_len, slots_used;
+	int i, chain_len, max_chain_len, slots_used, max_slots_used;
+	int slots_unused, max_slots_unused, total_entries = 0;
 	struct avc_node *node;
 	struct hlist_head *head;
+	unsigned cpu;
 
 	rcu_read_lock();
 
-	slots_used = 0;
 	max_chain_len = 0;
-	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		head = &avc_cache.slots[i].head;
-		if (!hlist_empty(head)) {
-			struct hlist_node *next;
-
-			slots_used++;
-			chain_len = 0;
-			hlist_for_each_entry_rcu(node, next, head, list)
-				chain_len++;
-			if (chain_len > max_chain_len)
-				max_chain_len = chain_len;
+	max_slots_used = 0;
+	max_slots_unused = 0;
+	for_each_possible_cpu(cpu) {
+		slots_used = 0;
+		slots_unused = 0;
+		for (i = 0; i < AVC_CACHE_SLOTS; i++) {
+			head = &per_cpu(avc_cache, cpu).slots[i];
+			if (!hlist_empty(head)) {
+				struct hlist_node *next;
+	
+				slots_used++;
+				chain_len = 0;
+				hlist_for_each_entry_rcu(node, next, head, list)
+					chain_len++;
+				if (chain_len > max_chain_len)
+					max_chain_len = chain_len;
+			} else {
+				slots_unused++;
+			}
 		}
+		if (slots_used > max_slots_used)
+			max_slots_used = slots_used;
+		if (slots_unused > max_slots_unused)
+			max_slots_unused = slots_unused;
+
+		total_entries += atomic_read(&per_cpu(avc_cache, cpu).active_nodes);
 	}
 
 	rcu_read_unlock();
 
-	return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
-			 "longest chain: %d\n",
-			 atomic_read(&avc_cache.active_nodes),
-			 slots_used, AVC_CACHE_SLOTS, max_chain_len);
+	return scnprintf(page, PAGE_SIZE, "entries: %d\nmax buckets used: %d/%d\n"
+			 "max buckets unused: %d/%d\nlongest chain: %d\n",
+			 total_entries, max_slots_used, AVC_CACHE_SLOTS,
+			 max_slots_unused, AVC_CACHE_SLOTS, max_chain_len);
 }
 
 static void avc_node_free(struct rcu_head *rhead)
@@ -297,39 +312,41 @@ static void avc_node_delete(struct avc_node *node)
 {
 	hlist_del_rcu(&node->list);
 	call_rcu(&node->rhead, avc_node_free);
-	atomic_dec(&avc_cache.active_nodes);
+	atomic_dec(&per_cpu(avc_cache, smp_processor_id()).active_nodes);
 }
 
 static void avc_node_kill(struct avc_node *node)
 {
 	kmem_cache_free(avc_node_cachep, node);
 	avc_cache_stats_incr(frees);
-	atomic_dec(&avc_cache.active_nodes);
+	atomic_dec(&per_cpu(avc_cache, smp_processor_id()).active_nodes);
 }
 
 static void avc_node_replace(struct avc_node *new, struct avc_node *old)
 {
 	hlist_replace_rcu(&old->list, &new->list);
 	call_rcu(&old->rhead, avc_node_free);
-	atomic_dec(&avc_cache.active_nodes);
+	atomic_dec(&per_cpu(avc_cache, smp_processor_id()).active_nodes);
 }
 
 static inline int avc_reclaim_node(void)
 {
 	struct avc_node *node;
-	int hvalue, try, ecx;
+	int hvalue, try, ecx = 0;
 	unsigned long flags;
 	struct hlist_head *head;
 	struct hlist_node *next;
 	spinlock_t *lock;
+	unsigned cpu = get_cpu();
 
-	for (try = 0, ecx = 0; try < AVC_CACHE_SLOTS; try++) {
-		hvalue = atomic_inc_return(&avc_cache.lru_hint) & (AVC_CACHE_SLOTS - 1);
-		head = &avc_cache.slots[hvalue].head;
-		lock = &avc_cache.slots[hvalue].lock;
+	lock = &per_cpu(avc_cache, cpu).lock;
 
-		if (!spin_trylock_irqsave(lock, flags))
-			continue;
+	if (!spin_trylock_irqsave(lock, flags))
+		goto out;
+
+	for (try = 0; try < AVC_CACHE_SLOTS; try++) {
+		hvalue = atomic_inc_return(&per_cpu(avc_cache, cpu).lru_hint) & (AVC_CACHE_SLOTS - 1);
+		head = &per_cpu(avc_cache, cpu).slots[hvalue];
 
 		rcu_read_lock();
 		hlist_for_each_entry(node, next, head, list) {
@@ -338,14 +355,15 @@ static inline int avc_reclaim_node(void)
 			ecx++;
 			if (ecx >= AVC_CACHE_RECLAIM) {
 				rcu_read_unlock();
-				spin_unlock_irqrestore(lock, flags);
-				goto out;
+				goto out_unlock;
 			}
 		}
 		rcu_read_unlock();
-		spin_unlock_irqrestore(lock, flags);
 	}
+out_unlock:
+	spin_unlock_irqrestore(lock, flags);
 out:
+	put_cpu();
 	return ecx;
 }
 
@@ -353,7 +371,7 @@ static struct avc_node *avc_alloc_node(void)
 {
 	struct avc_node *node;
 
-	node = kmem_cache_zalloc(avc_node_cachep, GFP_ATOMIC);
+	node = kmem_cache_zalloc(avc_node_cachep, GFP_ATOMIC | GFP_THISNODE);
 	if (!node)
 		goto out;
 
@@ -361,7 +379,7 @@ static struct avc_node *avc_alloc_node(void)
 	INIT_HLIST_NODE(&node->list);
 	avc_cache_stats_incr(allocations);
 
-	if (atomic_inc_return(&avc_cache.active_nodes) > avc_cache_threshold)
+	if (atomic_inc_return(&per_cpu(avc_cache, smp_processor_id()).active_nodes) > avc_cache_threshold)
 		avc_reclaim_node();
 
 out:
@@ -382,9 +400,10 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
 	int hvalue;
 	struct hlist_head *head;
 	struct hlist_node *next;
+	unsigned cpu = get_cpu();
 
 	hvalue = avc_hash(ssid, tsid, tclass);
-	head = &avc_cache.slots[hvalue].head;
+	head = &per_cpu(avc_cache, cpu).slots[hvalue];
 	hlist_for_each_entry_rcu(node, next, head, list) {
 		if (ssid == node->ae.ssid &&
 		    tclass == node->ae.tclass &&
@@ -394,6 +413,7 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
 		}
 	}
 
+	put_cpu();
 	return ret;
 }
 
@@ -432,14 +452,14 @@ static int avc_latest_notif_update(int seqno, int is_insert)
 
 	spin_lock_irqsave(&notif_lock, flag);
 	if (is_insert) {
-		if (seqno < avc_cache.latest_notif) {
+		if (seqno < latest_notif) {
 			printk(KERN_WARNING "SELinux: avc:  seqno %d < latest_notif %d\n",
-			       seqno, avc_cache.latest_notif);
+			       seqno, latest_notif);
 			ret = -EAGAIN;
 		}
 	} else {
-		if (seqno > avc_cache.latest_notif)
-			avc_cache.latest_notif = seqno;
+		if (seqno > latest_notif)
+			latest_notif = seqno;
 	}
 	spin_unlock_irqrestore(&notif_lock, flag);
 
@@ -477,15 +497,16 @@ static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct av_dec
 		struct hlist_head *head;
 		struct hlist_node *next;
 		spinlock_t *lock;
+		unsigned cpu = get_cpu();
 
 		hvalue = avc_hash(ssid, tsid, tclass);
 		avc_node_populate(node, ssid, tsid, tclass, avd);
 
-		head = &avc_cache.slots[hvalue].head;
-		lock = &avc_cache.slots[hvalue].lock;
+		head = &per_cpu(avc_cache, cpu).slots[hvalue];
+		lock = &per_cpu(avc_cache, cpu).lock;
 
 		spin_lock_irqsave(lock, flag);
-		hlist_for_each_entry(pos, next, head, list) {
+		hlist_for_each_entry_rcu(pos, next, head, list) {
 			if (pos->ae.ssid == ssid &&
 			    pos->ae.tsid == tsid &&
 			    pos->ae.tclass == tclass) {
@@ -496,6 +517,7 @@ static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct av_dec
 		hlist_add_head_rcu(&node->list, head);
 found:
 		spin_unlock_irqrestore(lock, flag);
+		put_cpu();
 	}
 out:
 	return node;
@@ -767,6 +789,7 @@ static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
 	struct hlist_head *head;
 	struct hlist_node *next;
 	spinlock_t *lock;
+	unsigned cpu = get_cpu();
 
 	node = avc_alloc_node();
 	if (!node) {
@@ -777,12 +800,12 @@ static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
 	/* Lock the target slot */
 	hvalue = avc_hash(ssid, tsid, tclass);
 
-	head = &avc_cache.slots[hvalue].head;
-	lock = &avc_cache.slots[hvalue].lock;
+	head = &per_cpu(avc_cache, cpu).slots[hvalue];
+	lock = &per_cpu(avc_cache, cpu).lock;
 
 	spin_lock_irqsave(lock, flag);
 
-	hlist_for_each_entry(pos, next, head, list) {
+	hlist_for_each_entry_rcu(pos, next, head, list) {
 		if (ssid == pos->ae.ssid &&
 		    tsid == pos->ae.tsid &&
 		    tclass == pos->ae.tclass &&
@@ -829,6 +852,7 @@ static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
 out_unlock:
 	spin_unlock_irqrestore(lock, flag);
 out:
+	put_cpu();
 	return rc;
 }
 
@@ -845,29 +869,34 @@ int avc_ss_reset(u32 seqno)
 	struct hlist_head *head;
 	struct hlist_node *next;
 	spinlock_t *lock;
+	unsigned cpu;
 
-	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		head = &avc_cache.slots[i].head;
-		lock = &avc_cache.slots[i].lock;
-
+	for_each_possible_cpu(cpu) {
+		lock = &per_cpu(avc_cache, cpu).lock;
+		
 		spin_lock_irqsave(lock, flag);
-		/*
-		 * With preemptable RCU, the outer spinlock does not
-		 * prevent RCU grace periods from ending.
-		 */
-		rcu_read_lock();
-		hlist_for_each_entry(node, next, head, list)
-			avc_node_delete(node);
-		rcu_read_unlock();
+		for (i = 0; i < AVC_CACHE_SLOTS; i++) {
+			head = &per_cpu(avc_cache, cpu).slots[i];
+	
+			/*
+		 	* With preemptable RCU, the outer spinlock does not
+		 	* prevent RCU grace periods from ending.
+		 	*/
+			rcu_read_lock();
+			hlist_for_each_entry_rcu(node, next, head, list)
+				avc_node_delete(node);
+			rcu_read_unlock();
+		}
 		spin_unlock_irqrestore(lock, flag);
+	
 	}
 
 	for (c = avc_callbacks; c; c = c->next) {
 		if (c->events & AVC_CALLBACK_RESET) {
 			tmprc = c->callback(AVC_CALLBACK_RESET,
-					    0, 0, 0, 0, NULL);
+				    	0, 0, 0, 0, NULL);
 			/* save the first error encountered for the return
-			   value and continue processing the callbacks */
+		   	value and continue processing the callbacks */
 			if (!rc)
 				rc = tmprc;
 		}
@@ -977,5 +1006,5 @@ int avc_has_perm(u32 ssid, u32 tsid, u16 tclass,
 
 u32 avc_policy_seqno(void)
 {
-	return avc_cache.latest_notif;
+	return latest_notif;
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
