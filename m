From: Stephen Smalley <sds@tycho.nsa.gov>
To: paul@paul-moore.com
Cc: selinux@tycho.nsa.gov, peter.enderborg@sony.com, jmorris@namei.org,
 Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon,  5 Mar 2018 11:47:56 -0500
Message-Id: <20180305164756.7878-2-sds@tycho.nsa.gov>
In-Reply-To: <20180305164756.7878-1-sds@tycho.nsa.gov>
References: <20180305164756.7878-1-sds@tycho.nsa.gov>
Subject: [PATCH 2/2] selinux: wrap AVC state
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Wrap the AVC state within the selinux_state structure and
pass it explicitly to all AVC functions.  The AVC private state
is encapsulated in a selinux_avc structure that is referenced
from the selinux_state.

This change should have no effect on SELinux behavior or
APIs (userspace or LSM).

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/avc.c              | 284 ++++++++++++++-----------
 security/selinux/hooks.c            | 398 ++++++++++++++++++++++++------------
 security/selinux/include/avc.h      |  32 ++-
 security/selinux/include/avc_ss.h   |   3 +-
 security/selinux/include/security.h |   3 +
 security/selinux/netlabel.c         |   3 +-
 security/selinux/selinuxfs.c        |  60 ++++--
 security/selinux/ss/services.c      |   9 +-
 security/selinux/xfrm.c             |  17 +-
 9 files changed, 512 insertions(+), 297 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 54b09cc03b55..f3aedf077509 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -82,14 +82,42 @@ struct avc_callback_node {
 	struct avc_callback_node *next;
 };
 
-/* Exported via selinufs */
-unsigned int avc_cache_threshold = AVC_DEF_CACHE_THRESHOLD;
-
 #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
 DEFINE_PER_CPU(struct avc_cache_stats, avc_cache_stats) = { 0 };
 #endif
 
-static struct avc_cache avc_cache;
+struct selinux_avc {
+	unsigned int avc_cache_threshold;
+	struct avc_cache avc_cache;
+};
+
+static struct selinux_avc selinux_avc;
+
+void selinux_avc_init(struct selinux_avc **avc)
+{
+	int i;
+
+	selinux_avc.avc_cache_threshold = AVC_DEF_CACHE_THRESHOLD;
+	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
+		INIT_HLIST_HEAD(&selinux_avc.avc_cache.slots[i]);
+		spin_lock_init(&selinux_avc.avc_cache.slots_lock[i]);
+	}
+	atomic_set(&selinux_avc.avc_cache.active_nodes, 0);
+	atomic_set(&selinux_avc.avc_cache.lru_hint, 0);
+	*avc = &selinux_avc;
+}
+
+unsigned int avc_get_cache_threshold(struct selinux_avc *avc)
+{
+	return avc->avc_cache_threshold;
+}
+
+void avc_set_cache_threshold(struct selinux_avc *avc,
+			     unsigned int cache_threshold)
+{
+	avc->avc_cache_threshold = cache_threshold;
+}
+
 static struct avc_callback_node *avc_callbacks;
 static struct kmem_cache *avc_node_cachep;
 static struct kmem_cache *avc_xperms_data_cachep;
@@ -143,14 +171,14 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
  * @tsid: target security identifier
  * @tclass: target security class
  */
-static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tclass)
+static void avc_dump_query(struct audit_buffer *ab, struct selinux_state *state,
+			   u32 ssid, u32 tsid, u16 tclass)
 {
 	int rc;
 	char *scontext;
 	u32 scontext_len;
 
-	rc = security_sid_to_context(&selinux_state, ssid,
-				     &scontext, &scontext_len);
+	rc = security_sid_to_context(state, ssid, &scontext, &scontext_len);
 	if (rc)
 		audit_log_format(ab, "ssid=%d", ssid);
 	else {
@@ -158,8 +186,7 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
 		kfree(scontext);
 	}
 
-	rc = security_sid_to_context(&selinux_state, tsid,
-				     &scontext, &scontext_len);
+	rc = security_sid_to_context(state, tsid, &scontext, &scontext_len);
 	if (rc)
 		audit_log_format(ab, " tsid=%d", tsid);
 	else {
@@ -178,15 +205,6 @@ static void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
  */
 void __init avc_init(void)
 {
-	int i;
-
-	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		INIT_HLIST_HEAD(&avc_cache.slots[i]);
-		spin_lock_init(&avc_cache.slots_lock[i]);
-	}
-	atomic_set(&avc_cache.active_nodes, 0);
-	atomic_set(&avc_cache.lru_hint, 0);
-
 	avc_node_cachep = kmem_cache_create("avc_node", sizeof(struct avc_node),
 					0, SLAB_PANIC, NULL);
 	avc_xperms_cachep = kmem_cache_create("avc_xperms_node",
@@ -201,7 +219,7 @@ void __init avc_init(void)
 					0, SLAB_PANIC, NULL);
 }
 
-int avc_get_hash_stats(char *page)
+int avc_get_hash_stats(struct selinux_avc *avc, char *page)
 {
 	int i, chain_len, max_chain_len, slots_used;
 	struct avc_node *node;
@@ -212,7 +230,7 @@ int avc_get_hash_stats(char *page)
 	slots_used = 0;
 	max_chain_len = 0;
 	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		head = &avc_cache.slots[i];
+		head = &avc->avc_cache.slots[i];
 		if (!hlist_empty(head)) {
 			slots_used++;
 			chain_len = 0;
@@ -227,7 +245,7 @@ int avc_get_hash_stats(char *page)
 
 	return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
 			 "longest chain: %d\n",
-			 atomic_read(&avc_cache.active_nodes),
+			 atomic_read(&avc->avc_cache.active_nodes),
 			 slots_used, AVC_CACHE_SLOTS, max_chain_len);
 }
 
@@ -464,11 +482,12 @@ static inline u32 avc_xperms_audit_required(u32 requested,
 	return audited;
 }
 
-static inline int avc_xperms_audit(u32 ssid, u32 tsid, u16 tclass,
-				u32 requested, struct av_decision *avd,
-				struct extended_perms_decision *xpd,
-				u8 perm, int result,
-				struct common_audit_data *ad)
+static inline int avc_xperms_audit(struct selinux_state *state,
+				   u32 ssid, u32 tsid, u16 tclass,
+				   u32 requested, struct av_decision *avd,
+				   struct extended_perms_decision *xpd,
+				   u8 perm, int result,
+				   struct common_audit_data *ad)
 {
 	u32 audited, denied;
 
@@ -476,7 +495,7 @@ static inline int avc_xperms_audit(u32 ssid, u32 tsid, u16 tclass,
 			requested, avd, xpd, perm, result, &denied);
 	if (likely(!audited))
 		return 0;
-	return slow_avc_audit(ssid, tsid, tclass, requested,
+	return slow_avc_audit(state, ssid, tsid, tclass, requested,
 			audited, denied, result, ad, 0);
 }
 
@@ -488,29 +507,30 @@ static void avc_node_free(struct rcu_head *rhead)
 	avc_cache_stats_incr(frees);
 }
 
-static void avc_node_delete(struct avc_node *node)
+static void avc_node_delete(struct selinux_avc *avc, struct avc_node *node)
 {
 	hlist_del_rcu(&node->list);
 	call_rcu(&node->rhead, avc_node_free);
-	atomic_dec(&avc_cache.active_nodes);
+	atomic_dec(&avc->avc_cache.active_nodes);
 }
 
-static void avc_node_kill(struct avc_node *node)
+static void avc_node_kill(struct selinux_avc *avc, struct avc_node *node)
 {
 	avc_xperms_free(node->ae.xp_node);
 	kmem_cache_free(avc_node_cachep, node);
 	avc_cache_stats_incr(frees);
-	atomic_dec(&avc_cache.active_nodes);
+	atomic_dec(&avc->avc_cache.active_nodes);
 }
 
-static void avc_node_replace(struct avc_node *new, struct avc_node *old)
+static void avc_node_replace(struct selinux_avc *avc,
+			     struct avc_node *new, struct avc_node *old)
 {
 	hlist_replace_rcu(&old->list, &new->list);
 	call_rcu(&old->rhead, avc_node_free);
-	atomic_dec(&avc_cache.active_nodes);
+	atomic_dec(&avc->avc_cache.active_nodes);
 }
 
-static inline int avc_reclaim_node(void)
+static inline int avc_reclaim_node(struct selinux_avc *avc)
 {
 	struct avc_node *node;
 	int hvalue, try, ecx;
@@ -519,16 +539,17 @@ static inline int avc_reclaim_node(void)
 	spinlock_t *lock;
 
 	for (try = 0, ecx = 0; try < AVC_CACHE_SLOTS; try++) {
-		hvalue = atomic_inc_return(&avc_cache.lru_hint) & (AVC_CACHE_SLOTS - 1);
-		head = &avc_cache.slots[hvalue];
-		lock = &avc_cache.slots_lock[hvalue];
+		hvalue = atomic_inc_return(&avc->avc_cache.lru_hint) &
+			(AVC_CACHE_SLOTS - 1);
+		head = &avc->avc_cache.slots[hvalue];
+		lock = &avc->avc_cache.slots_lock[hvalue];
 
 		if (!spin_trylock_irqsave(lock, flags))
 			continue;
 
 		rcu_read_lock();
 		hlist_for_each_entry(node, head, list) {
-			avc_node_delete(node);
+			avc_node_delete(avc, node);
 			avc_cache_stats_incr(reclaims);
 			ecx++;
 			if (ecx >= AVC_CACHE_RECLAIM) {
@@ -544,7 +565,7 @@ static inline int avc_reclaim_node(void)
 	return ecx;
 }
 
-static struct avc_node *avc_alloc_node(void)
+static struct avc_node *avc_alloc_node(struct selinux_avc *avc)
 {
 	struct avc_node *node;
 
@@ -555,8 +576,9 @@ static struct avc_node *avc_alloc_node(void)
 	INIT_HLIST_NODE(&node->list);
 	avc_cache_stats_incr(allocations);
 
-	if (atomic_inc_return(&avc_cache.active_nodes) > avc_cache_threshold)
-		avc_reclaim_node();
+	if (atomic_inc_return(&avc->avc_cache.active_nodes) >
+	    avc->avc_cache_threshold)
+		avc_reclaim_node(avc);
 
 out:
 	return node;
@@ -570,14 +592,15 @@ static void avc_node_populate(struct avc_node *node, u32 ssid, u32 tsid, u16 tcl
 	memcpy(&node->ae.avd, avd, sizeof(node->ae.avd));
 }
 
-static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
+static inline struct avc_node *avc_search_node(struct selinux_avc *avc,
+					       u32 ssid, u32 tsid, u16 tclass)
 {
 	struct avc_node *node, *ret = NULL;
 	int hvalue;
 	struct hlist_head *head;
 
 	hvalue = avc_hash(ssid, tsid, tclass);
-	head = &avc_cache.slots[hvalue];
+	head = &avc->avc_cache.slots[hvalue];
 	hlist_for_each_entry_rcu(node, head, list) {
 		if (ssid == node->ae.ssid &&
 		    tclass == node->ae.tclass &&
@@ -602,12 +625,13 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
  * then this function returns the avc_node.
  * Otherwise, this function returns NULL.
  */
-static struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass)
+static struct avc_node *avc_lookup(struct selinux_avc *avc,
+				   u32 ssid, u32 tsid, u16 tclass)
 {
 	struct avc_node *node;
 
 	avc_cache_stats_incr(lookups);
-	node = avc_search_node(ssid, tsid, tclass);
+	node = avc_search_node(avc, ssid, tsid, tclass);
 
 	if (node)
 		return node;
@@ -616,7 +640,8 @@ static struct avc_node *avc_lookup(u32 ssid, u32 tsid, u16 tclass)
 	return NULL;
 }
 
-static int avc_latest_notif_update(int seqno, int is_insert)
+static int avc_latest_notif_update(struct selinux_avc *avc,
+				   int seqno, int is_insert)
 {
 	int ret = 0;
 	static DEFINE_SPINLOCK(notif_lock);
@@ -624,14 +649,14 @@ static int avc_latest_notif_update(int seqno, int is_insert)
 
 	spin_lock_irqsave(&notif_lock, flag);
 	if (is_insert) {
-		if (seqno < avc_cache.latest_notif) {
+		if (seqno < avc->avc_cache.latest_notif) {
 			printk(KERN_WARNING "SELinux: avc:  seqno %d < latest_notif %d\n",
-			       seqno, avc_cache.latest_notif);
+			       seqno, avc->avc_cache.latest_notif);
 			ret = -EAGAIN;
 		}
 	} else {
-		if (seqno > avc_cache.latest_notif)
-			avc_cache.latest_notif = seqno;
+		if (seqno > avc->avc_cache.latest_notif)
+			avc->avc_cache.latest_notif = seqno;
 	}
 	spin_unlock_irqrestore(&notif_lock, flag);
 
@@ -656,18 +681,19 @@ static int avc_latest_notif_update(int seqno, int is_insert)
  * the access vectors into a cache entry, returns
  * avc_node inserted. Otherwise, this function returns NULL.
  */
-static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass,
-				struct av_decision *avd,
-				struct avc_xperms_node *xp_node)
+static struct avc_node *avc_insert(struct selinux_avc *avc,
+				   u32 ssid, u32 tsid, u16 tclass,
+				   struct av_decision *avd,
+				   struct avc_xperms_node *xp_node)
 {
 	struct avc_node *pos, *node = NULL;
 	int hvalue;
 	unsigned long flag;
 
-	if (avc_latest_notif_update(avd->seqno, 1))
+	if (avc_latest_notif_update(avc, avd->seqno, 1))
 		goto out;
 
-	node = avc_alloc_node();
+	node = avc_alloc_node(avc);
 	if (node) {
 		struct hlist_head *head;
 		spinlock_t *lock;
@@ -680,15 +706,15 @@ static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass,
 			kmem_cache_free(avc_node_cachep, node);
 			return NULL;
 		}
-		head = &avc_cache.slots[hvalue];
-		lock = &avc_cache.slots_lock[hvalue];
+		head = &avc->avc_cache.slots[hvalue];
+		lock = &avc->avc_cache.slots_lock[hvalue];
 
 		spin_lock_irqsave(lock, flag);
 		hlist_for_each_entry(pos, head, list) {
 			if (pos->ae.ssid == ssid &&
 			    pos->ae.tsid == tsid &&
 			    pos->ae.tclass == tclass) {
-				avc_node_replace(node, pos);
+				avc_node_replace(avc, node, pos);
 				goto found;
 			}
 		}
@@ -726,9 +752,10 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 {
 	struct common_audit_data *ad = a;
 	audit_log_format(ab, " ");
-	avc_dump_query(ab, ad->selinux_audit_data->ssid,
-			   ad->selinux_audit_data->tsid,
-			   ad->selinux_audit_data->tclass);
+	avc_dump_query(ab, ad->selinux_audit_data->state,
+		       ad->selinux_audit_data->ssid,
+		       ad->selinux_audit_data->tsid,
+		       ad->selinux_audit_data->tclass);
 	if (ad->selinux_audit_data->denied) {
 		audit_log_format(ab, " permissive=%u",
 				 ad->selinux_audit_data->result ? 0 : 1);
@@ -736,10 +763,11 @@ static void avc_audit_post_callback(struct audit_buffer *ab, void *a)
 }
 
 /* This is the slow part of avc audit with big stack footprint */
-noinline int slow_avc_audit(u32 ssid, u32 tsid, u16 tclass,
-		u32 requested, u32 audited, u32 denied, int result,
-		struct common_audit_data *a,
-		unsigned flags)
+noinline int slow_avc_audit(struct selinux_state *state,
+			    u32 ssid, u32 tsid, u16 tclass,
+			    u32 requested, u32 audited, u32 denied, int result,
+			    struct common_audit_data *a,
+			    unsigned int flags)
 {
 	struct common_audit_data stack_data;
 	struct selinux_audit_data sad;
@@ -767,6 +795,7 @@ noinline int slow_avc_audit(u32 ssid, u32 tsid, u16 tclass,
 	sad.audited = audited;
 	sad.denied = denied;
 	sad.result = result;
+	sad.state = state;
 
 	a->selinux_audit_data = &sad;
 
@@ -815,10 +844,11 @@ int __init avc_add_callback(int (*callback)(u32 event), u32 events)
  * otherwise, this function updates the AVC entry. The original AVC-entry object
  * will release later by RCU.
  */
-static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32 ssid,
-			u32 tsid, u16 tclass, u32 seqno,
-			struct extended_perms_decision *xpd,
-			u32 flags)
+static int avc_update_node(struct selinux_avc *avc,
+			   u32 event, u32 perms, u8 driver, u8 xperm, u32 ssid,
+			   u32 tsid, u16 tclass, u32 seqno,
+			   struct extended_perms_decision *xpd,
+			   u32 flags)
 {
 	int hvalue, rc = 0;
 	unsigned long flag;
@@ -826,7 +856,7 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32 ssid,
 	struct hlist_head *head;
 	spinlock_t *lock;
 
-	node = avc_alloc_node();
+	node = avc_alloc_node(avc);
 	if (!node) {
 		rc = -ENOMEM;
 		goto out;
@@ -835,8 +865,8 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32 ssid,
 	/* Lock the target slot */
 	hvalue = avc_hash(ssid, tsid, tclass);
 
-	head = &avc_cache.slots[hvalue];
-	lock = &avc_cache.slots_lock[hvalue];
+	head = &avc->avc_cache.slots[hvalue];
+	lock = &avc->avc_cache.slots_lock[hvalue];
 
 	spin_lock_irqsave(lock, flag);
 
@@ -852,7 +882,7 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32 ssid,
 
 	if (!orig) {
 		rc = -ENOENT;
-		avc_node_kill(node);
+		avc_node_kill(avc, node);
 		goto out_unlock;
 	}
 
@@ -896,7 +926,7 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32 ssid,
 		avc_add_xperms_decision(node, xpd);
 		break;
 	}
-	avc_node_replace(node, orig);
+	avc_node_replace(avc, node, orig);
 out_unlock:
 	spin_unlock_irqrestore(lock, flag);
 out:
@@ -906,7 +936,7 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32 ssid,
 /**
  * avc_flush - Flush the cache
  */
-static void avc_flush(void)
+static void avc_flush(struct selinux_avc *avc)
 {
 	struct hlist_head *head;
 	struct avc_node *node;
@@ -915,8 +945,8 @@ static void avc_flush(void)
 	int i;
 
 	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		head = &avc_cache.slots[i];
-		lock = &avc_cache.slots_lock[i];
+		head = &avc->avc_cache.slots[i];
+		lock = &avc->avc_cache.slots_lock[i];
 
 		spin_lock_irqsave(lock, flag);
 		/*
@@ -925,7 +955,7 @@ static void avc_flush(void)
 		 */
 		rcu_read_lock();
 		hlist_for_each_entry(node, head, list)
-			avc_node_delete(node);
+			avc_node_delete(avc, node);
 		rcu_read_unlock();
 		spin_unlock_irqrestore(lock, flag);
 	}
@@ -935,12 +965,12 @@ static void avc_flush(void)
  * avc_ss_reset - Flush the cache and revalidate migrated permissions.
  * @seqno: policy sequence number
  */
-int avc_ss_reset(u32 seqno)
+int avc_ss_reset(struct selinux_avc *avc, u32 seqno)
 {
 	struct avc_callback_node *c;
 	int rc = 0, tmprc;
 
-	avc_flush();
+	avc_flush(avc);
 
 	for (c = avc_callbacks; c; c = c->next) {
 		if (c->events & AVC_CALLBACK_RESET) {
@@ -952,7 +982,7 @@ int avc_ss_reset(u32 seqno)
 		}
 	}
 
-	avc_latest_notif_update(seqno, 0);
+	avc_latest_notif_update(avc, seqno, 0);
 	return rc;
 }
 
@@ -965,32 +995,34 @@ int avc_ss_reset(u32 seqno)
  * Don't inline this, since it's the slow-path and just
  * results in a bigger stack frame.
  */
-static noinline struct avc_node *avc_compute_av(u32 ssid, u32 tsid,
-			 u16 tclass, struct av_decision *avd,
-			 struct avc_xperms_node *xp_node)
+static noinline
+struct avc_node *avc_compute_av(struct selinux_state *state,
+				u32 ssid, u32 tsid,
+				u16 tclass, struct av_decision *avd,
+				struct avc_xperms_node *xp_node)
 {
 	rcu_read_unlock();
 	INIT_LIST_HEAD(&xp_node->xpd_head);
-	security_compute_av(&selinux_state, ssid, tsid, tclass,
-			    avd, &xp_node->xp);
+	security_compute_av(state, ssid, tsid, tclass, avd, &xp_node->xp);
 	rcu_read_lock();
-	return avc_insert(ssid, tsid, tclass, avd, xp_node);
+	return avc_insert(state->avc, ssid, tsid, tclass, avd, xp_node);
 }
 
-static noinline int avc_denied(u32 ssid, u32 tsid,
-				u16 tclass, u32 requested,
-				u8 driver, u8 xperm, unsigned flags,
-				struct av_decision *avd)
+static noinline int avc_denied(struct selinux_state *state,
+			       u32 ssid, u32 tsid,
+			       u16 tclass, u32 requested,
+			       u8 driver, u8 xperm, unsigned int flags,
+			       struct av_decision *avd)
 {
 	if (flags & AVC_STRICT)
 		return -EACCES;
 
-	if (enforcing_enabled(&selinux_state) &&
+	if (enforcing_enabled(state) &&
 	    !(avd->flags & AVD_FLAGS_PERMISSIVE))
 		return -EACCES;
 
-	avc_update_node(AVC_CALLBACK_GRANT, requested, driver, xperm, ssid,
-				tsid, tclass, avd->seqno, NULL, flags);
+	avc_update_node(state->avc, AVC_CALLBACK_GRANT, requested, driver,
+			xperm, ssid, tsid, tclass, avd->seqno, NULL, flags);
 	return 0;
 }
 
@@ -1001,8 +1033,9 @@ static noinline int avc_denied(u32 ssid, u32 tsid,
  * as-is the case with ioctls, then multiple may be chained together and the
  * driver field is used to specify which set contains the permission.
  */
-int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 requested,
-			u8 driver, u8 xperm, struct common_audit_data *ad)
+int avc_has_extended_perms(struct selinux_state *state,
+			   u32 ssid, u32 tsid, u16 tclass, u32 requested,
+			   u8 driver, u8 xperm, struct common_audit_data *ad)
 {
 	struct avc_node *node;
 	struct av_decision avd;
@@ -1021,9 +1054,9 @@ int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 requested,
 
 	rcu_read_lock();
 
-	node = avc_lookup(ssid, tsid, tclass);
+	node = avc_lookup(state->avc, ssid, tsid, tclass);
 	if (unlikely(!node)) {
-		node = avc_compute_av(ssid, tsid, tclass, &avd, xp_node);
+		node = avc_compute_av(state, ssid, tsid, tclass, &avd, xp_node);
 	} else {
 		memcpy(&avd, &node->ae.avd, sizeof(avd));
 		xp_node = node->ae.xp_node;
@@ -1047,11 +1080,12 @@ int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 requested,
 			goto decision;
 		}
 		rcu_read_unlock();
-		security_compute_xperms_decision(&selinux_state, ssid, tsid,
-						 tclass, driver, &local_xpd);
+		security_compute_xperms_decision(state, ssid, tsid, tclass,
+						 driver, &local_xpd);
 		rcu_read_lock();
-		avc_update_node(AVC_CALLBACK_ADD_XPERMS, requested, driver, xperm,
-				ssid, tsid, tclass, avd.seqno, &local_xpd, 0);
+		avc_update_node(state->avc, AVC_CALLBACK_ADD_XPERMS, requested,
+				driver, xperm, ssid, tsid, tclass, avd.seqno,
+				&local_xpd, 0);
 	} else {
 		avc_quick_copy_xperms_decision(xperm, &local_xpd, xpd);
 	}
@@ -1063,12 +1097,12 @@ int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 requested,
 decision:
 	denied = requested & ~(avd.allowed);
 	if (unlikely(denied))
-		rc = avc_denied(ssid, tsid, tclass, requested, driver, xperm,
-				AVC_EXTENDED_PERMS, &avd);
+		rc = avc_denied(state, ssid, tsid, tclass, requested,
+				driver, xperm, AVC_EXTENDED_PERMS, &avd);
 
 	rcu_read_unlock();
 
-	rc2 = avc_xperms_audit(ssid, tsid, tclass, requested,
+	rc2 = avc_xperms_audit(state, ssid, tsid, tclass, requested,
 			&avd, xpd, xperm, rc, ad);
 	if (rc2)
 		return rc2;
@@ -1095,10 +1129,11 @@ int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 requested,
  * auditing, e.g. in cases where a lock must be held for the check but
  * should be released for the auditing.
  */
-inline int avc_has_perm_noaudit(u32 ssid, u32 tsid,
-			 u16 tclass, u32 requested,
-			 unsigned flags,
-			 struct av_decision *avd)
+inline int avc_has_perm_noaudit(struct selinux_state *state,
+				u32 ssid, u32 tsid,
+				u16 tclass, u32 requested,
+				unsigned int flags,
+				struct av_decision *avd)
 {
 	struct avc_node *node;
 	struct avc_xperms_node xp_node;
@@ -1109,15 +1144,16 @@ inline int avc_has_perm_noaudit(u32 ssid, u32 tsid,
 
 	rcu_read_lock();
 
-	node = avc_lookup(ssid, tsid, tclass);
+	node = avc_lookup(state->avc, ssid, tsid, tclass);
 	if (unlikely(!node))
-		node = avc_compute_av(ssid, tsid, tclass, avd, &xp_node);
+		node = avc_compute_av(state, ssid, tsid, tclass, avd, &xp_node);
 	else
 		memcpy(avd, &node->ae.avd, sizeof(*avd));
 
 	denied = requested & ~(avd->allowed);
 	if (unlikely(denied))
-		rc = avc_denied(ssid, tsid, tclass, requested, 0, 0, flags, avd);
+		rc = avc_denied(state, ssid, tsid, tclass, requested, 0, 0,
+				flags, avd);
 
 	rcu_read_unlock();
 	return rc;
@@ -1139,39 +1175,43 @@ inline int avc_has_perm_noaudit(u32 ssid, u32 tsid,
  * permissions are granted, -%EACCES if any permissions are denied, or
  * another -errno upon other errors.
  */
-int avc_has_perm(u32 ssid, u32 tsid, u16 tclass,
+int avc_has_perm(struct selinux_state *state, u32 ssid, u32 tsid, u16 tclass,
 		 u32 requested, struct common_audit_data *auditdata)
 {
 	struct av_decision avd;
 	int rc, rc2;
 
-	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, 0, &avd);
+	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested, 0,
+				  &avd);
 
-	rc2 = avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata, 0);
+	rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
+			auditdata, 0);
 	if (rc2)
 		return rc2;
 	return rc;
 }
 
-int avc_has_perm_flags(u32 ssid, u32 tsid, u16 tclass,
-		       u32 requested, struct common_audit_data *auditdata,
+int avc_has_perm_flags(struct selinux_state *state,
+		       u32 ssid, u32 tsid, u16 tclass, u32 requested,
+		       struct common_audit_data *auditdata,
 		       int flags)
 {
 	struct av_decision avd;
 	int rc, rc2;
 
-	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, 0, &avd);
+	rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested, 0,
+				  &avd);
 
-	rc2 = avc_audit(ssid, tsid, tclass, requested, &avd, rc,
+	rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
 			auditdata, flags);
 	if (rc2)
 		return rc2;
 	return rc;
 }
 
-u32 avc_policy_seqno(void)
+u32 avc_policy_seqno(struct selinux_state *state)
 {
-	return avc_cache.latest_notif;
+	return state->avc->avc_cache.latest_notif;
 }
 
 void avc_disable(void)
@@ -1188,7 +1228,7 @@ void avc_disable(void)
 	 * the cache and get that memory back.
 	 */
 	if (avc_node_cachep) {
-		avc_flush();
+		avc_flush(selinux_state.avc);
 		/* kmem_cache_destroy(avc_node_cachep); */
 	}
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7eaef2ea021..21b377aef69a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -468,12 +468,14 @@ static int may_context_mount_sb_relabel(u32 sid,
 	const struct task_security_struct *tsec = cred->security;
 	int rc;
 
-	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(&selinux_state,
+			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(tsec->sid, sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(&selinux_state,
+			  tsec->sid, sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELTO, NULL);
 	return rc;
 }
@@ -484,12 +486,14 @@ static int may_context_mount_inode_relabel(u32 sid,
 {
 	const struct task_security_struct *tsec = cred->security;
 	int rc;
-	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(&selinux_state,
+			  tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(sid, sbsec->sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(&selinux_state,
+			  sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__ASSOCIATE, NULL);
 	return rc;
 }
@@ -1774,9 +1778,11 @@ static int cred_has_capability(const struct cred *cred,
 		return -EINVAL;
 	}
 
-	rc = avc_has_perm_noaudit(sid, sid, sclass, av, 0, &avd);
+	rc = avc_has_perm_noaudit(&selinux_state,
+				  sid, sid, sclass, av, 0, &avd);
 	if (audit == SECURITY_CAP_AUDIT) {
-		int rc2 = avc_audit(sid, sid, sclass, av, &avd, rc, &ad, 0);
+		int rc2 = avc_audit(&selinux_state,
+				    sid, sid, sclass, av, &avd, rc, &ad, 0);
 		if (rc2)
 			return rc2;
 	}
@@ -1802,7 +1808,8 @@ static int inode_has_perm(const struct cred *cred,
 	sid = cred_sid(cred);
 	isec = inode->i_security;
 
-	return avc_has_perm(sid, isec->sid, isec->sclass, perms, adp);
+	return avc_has_perm(&selinux_state,
+			    sid, isec->sid, isec->sclass, perms, adp);
 }
 
 /* Same as inode_has_perm, but pass explicit audit data containing
@@ -1875,7 +1882,8 @@ static int file_has_perm(const struct cred *cred,
 	ad.u.file = file;
 
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(sid, fsec->sid,
+		rc = avc_has_perm(&selinux_state,
+				  sid, fsec->sid,
 				  SECCLASS_FD,
 				  FD__USE,
 				  &ad);
@@ -1945,7 +1953,8 @@ static int may_create(struct inode *dir,
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
 
-	rc = avc_has_perm(sid, dsec->sid, SECCLASS_DIR,
+	rc = avc_has_perm(&selinux_state,
+			  sid, dsec->sid, SECCLASS_DIR,
 			  DIR__ADD_NAME | DIR__SEARCH,
 			  &ad);
 	if (rc)
@@ -1956,11 +1965,13 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(sid, newsid, tclass, FILE__CREATE, &ad);
+	rc = avc_has_perm(&selinux_state,
+			  sid, newsid, tclass, FILE__CREATE, &ad);
 	if (rc)
 		return rc;
 
-	return avc_has_perm(newsid, sbsec->sid,
+	return avc_has_perm(&selinux_state,
+			    newsid, sbsec->sid,
 			    SECCLASS_FILESYSTEM,
 			    FILESYSTEM__ASSOCIATE, &ad);
 }
@@ -1989,7 +2000,8 @@ static int may_link(struct inode *dir,
 
 	av = DIR__SEARCH;
 	av |= (kind ? DIR__REMOVE_NAME : DIR__ADD_NAME);
-	rc = avc_has_perm(sid, dsec->sid, SECCLASS_DIR, av, &ad);
+	rc = avc_has_perm(&selinux_state,
+			  sid, dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 
@@ -2009,7 +2021,8 @@ static int may_link(struct inode *dir,
 		return 0;
 	}
 
-	rc = avc_has_perm(sid, isec->sid, isec->sclass, av, &ad);
+	rc = avc_has_perm(&selinux_state,
+			  sid, isec->sid, isec->sclass, av, &ad);
 	return rc;
 }
 
@@ -2033,16 +2046,19 @@ static inline int may_rename(struct inode *old_dir,
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 
 	ad.u.dentry = old_dentry;
-	rc = avc_has_perm(sid, old_dsec->sid, SECCLASS_DIR,
+	rc = avc_has_perm(&selinux_state,
+			  sid, old_dsec->sid, SECCLASS_DIR,
 			  DIR__REMOVE_NAME | DIR__SEARCH, &ad);
 	if (rc)
 		return rc;
-	rc = avc_has_perm(sid, old_isec->sid,
+	rc = avc_has_perm(&selinux_state,
+			  sid, old_isec->sid,
 			  old_isec->sclass, FILE__RENAME, &ad);
 	if (rc)
 		return rc;
 	if (old_is_dir && new_dir != old_dir) {
-		rc = avc_has_perm(sid, old_isec->sid,
+		rc = avc_has_perm(&selinux_state,
+				  sid, old_isec->sid,
 				  old_isec->sclass, DIR__REPARENT, &ad);
 		if (rc)
 			return rc;
@@ -2052,13 +2068,15 @@ static inline int may_rename(struct inode *old_dir,
 	av = DIR__ADD_NAME | DIR__SEARCH;
 	if (d_is_positive(new_dentry))
 		av |= DIR__REMOVE_NAME;
-	rc = avc_has_perm(sid, new_dsec->sid, SECCLASS_DIR, av, &ad);
+	rc = avc_has_perm(&selinux_state,
+			  sid, new_dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 	if (d_is_positive(new_dentry)) {
 		new_isec = backing_inode_security(new_dentry);
 		new_is_dir = d_is_dir(new_dentry);
-		rc = avc_has_perm(sid, new_isec->sid,
+		rc = avc_has_perm(&selinux_state,
+				  sid, new_isec->sid,
 				  new_isec->sclass,
 				  (new_is_dir ? DIR__RMDIR : FILE__UNLINK), &ad);
 		if (rc)
@@ -2078,7 +2096,8 @@ static int superblock_has_perm(const struct cred *cred,
 	u32 sid = cred_sid(cred);
 
 	sbsec = sb->s_security;
-	return avc_has_perm(sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
+	return avc_has_perm(&selinux_state,
+			    sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
 }
 
 /* Convert a Linux mode and permission mask to an access vector. */
@@ -2155,7 +2174,8 @@ static int selinux_binder_set_context_mgr(struct task_struct *mgr)
 	u32 mysid = current_sid();
 	u32 mgrsid = task_sid(mgr);
 
-	return avc_has_perm(mysid, mgrsid, SECCLASS_BINDER,
+	return avc_has_perm(&selinux_state,
+			    mysid, mgrsid, SECCLASS_BINDER,
 			    BINDER__SET_CONTEXT_MGR, NULL);
 }
 
@@ -2168,13 +2188,15 @@ static int selinux_binder_transaction(struct task_struct *from,
 	int rc;
 
 	if (mysid != fromsid) {
-		rc = avc_has_perm(mysid, fromsid, SECCLASS_BINDER,
+		rc = avc_has_perm(&selinux_state,
+				  mysid, fromsid, SECCLASS_BINDER,
 				  BINDER__IMPERSONATE, NULL);
 		if (rc)
 			return rc;
 	}
 
-	return avc_has_perm(fromsid, tosid, SECCLASS_BINDER, BINDER__CALL,
+	return avc_has_perm(&selinux_state,
+			    fromsid, tosid, SECCLASS_BINDER, BINDER__CALL,
 			    NULL);
 }
 
@@ -2184,7 +2206,8 @@ static int selinux_binder_transfer_binder(struct task_struct *from,
 	u32 fromsid = task_sid(from);
 	u32 tosid = task_sid(to);
 
-	return avc_has_perm(fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
+	return avc_has_perm(&selinux_state,
+			    fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
 			    NULL);
 }
 
@@ -2203,7 +2226,8 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 	ad.u.path = file->f_path;
 
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(sid, fsec->sid,
+		rc = avc_has_perm(&selinux_state,
+				  sid, fsec->sid,
 				  SECCLASS_FD,
 				  FD__USE,
 				  &ad);
@@ -2221,7 +2245,8 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 		return 0;
 
 	isec = backing_inode_security(dentry);
-	return avc_has_perm(sid, isec->sid, isec->sclass, file_to_av(file),
+	return avc_has_perm(&selinux_state,
+			    sid, isec->sid, isec->sclass, file_to_av(file),
 			    &ad);
 }
 
@@ -2232,21 +2257,25 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 	u32 csid = task_sid(child);
 
 	if (mode & PTRACE_MODE_READ)
-		return avc_has_perm(sid, csid, SECCLASS_FILE, FILE__READ, NULL);
+		return avc_has_perm(&selinux_state,
+				    sid, csid, SECCLASS_FILE, FILE__READ, NULL);
 
-	return avc_has_perm(sid, csid, SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
+	return avc_has_perm(&selinux_state,
+			    sid, csid, SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
 
 static int selinux_ptrace_traceme(struct task_struct *parent)
 {
-	return avc_has_perm(task_sid(parent), current_sid(), SECCLASS_PROCESS,
+	return avc_has_perm(&selinux_state,
+			    task_sid(parent), current_sid(), SECCLASS_PROCESS,
 			    PROCESS__PTRACE, NULL);
 }
 
 static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
 			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
-	return avc_has_perm(current_sid(), task_sid(target), SECCLASS_PROCESS,
+	return avc_has_perm(&selinux_state,
+			    current_sid(), task_sid(target), SECCLASS_PROCESS,
 			    PROCESS__GETCAP, NULL);
 }
 
@@ -2255,7 +2284,8 @@ static int selinux_capset(struct cred *new, const struct cred *old,
 			  const kernel_cap_t *inheritable,
 			  const kernel_cap_t *permitted)
 {
-	return avc_has_perm(cred_sid(old), cred_sid(new), SECCLASS_PROCESS,
+	return avc_has_perm(&selinux_state,
+			    cred_sid(old), cred_sid(new), SECCLASS_PROCESS,
 			    PROCESS__SETCAP, NULL);
 }
 
@@ -2315,18 +2345,21 @@ static int selinux_syslog(int type)
 	switch (type) {
 	case SYSLOG_ACTION_READ_ALL:	/* Read last kernel messages */
 	case SYSLOG_ACTION_SIZE_BUFFER:	/* Return size of the log buffer */
-		return avc_has_perm(current_sid(), SECINITSID_KERNEL,
+		return avc_has_perm(&selinux_state,
+				    current_sid(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__SYSLOG_READ, NULL);
 	case SYSLOG_ACTION_CONSOLE_OFF:	/* Disable logging to console */
 	case SYSLOG_ACTION_CONSOLE_ON:	/* Enable logging to console */
 	/* Set level of messages printed to console */
 	case SYSLOG_ACTION_CONSOLE_LEVEL:
-		return avc_has_perm(current_sid(), SECINITSID_KERNEL,
+		return avc_has_perm(&selinux_state,
+				    current_sid(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__SYSLOG_CONSOLE,
 				    NULL);
 	}
 	/* All other syslog types */
-	return avc_has_perm(current_sid(), SECINITSID_KERNEL,
+	return avc_has_perm(&selinux_state,
+			    current_sid(), SECINITSID_KERNEL,
 			    SECCLASS_SYSTEM, SYSTEM__SYSLOG_MOD, NULL);
 }
 
@@ -2393,7 +2426,8 @@ static int check_nnp_nosuid(const struct linux_binprm *bprm,
 			av |= PROCESS2__NNP_TRANSITION;
 		if (nosuid)
 			av |= PROCESS2__NOSUID_TRANSITION;
-		rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
+		rc = avc_has_perm(&selinux_state,
+				  old_tsec->sid, new_tsec->sid,
 				  SECCLASS_PROCESS2, av, NULL);
 		if (!rc)
 			return 0;
@@ -2476,25 +2510,29 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 	ad.u.file = bprm->file;
 
 	if (new_tsec->sid == old_tsec->sid) {
-		rc = avc_has_perm(old_tsec->sid, isec->sid,
+		rc = avc_has_perm(&selinux_state,
+				  old_tsec->sid, isec->sid,
 				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
 			return rc;
 	} else {
 		/* Check permissions for the transition. */
-		rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
+		rc = avc_has_perm(&selinux_state,
+				  old_tsec->sid, new_tsec->sid,
 				  SECCLASS_PROCESS, PROCESS__TRANSITION, &ad);
 		if (rc)
 			return rc;
 
-		rc = avc_has_perm(new_tsec->sid, isec->sid,
+		rc = avc_has_perm(&selinux_state,
+				  new_tsec->sid, isec->sid,
 				  SECCLASS_FILE, FILE__ENTRYPOINT, &ad);
 		if (rc)
 			return rc;
 
 		/* Check for shared state */
 		if (bprm->unsafe & LSM_UNSAFE_SHARE) {
-			rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
+			rc = avc_has_perm(&selinux_state,
+					  old_tsec->sid, new_tsec->sid,
 					  SECCLASS_PROCESS, PROCESS__SHARE,
 					  NULL);
 			if (rc)
@@ -2506,7 +2544,8 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 		if (bprm->unsafe & LSM_UNSAFE_PTRACE) {
 			u32 ptsid = ptrace_parent_sid();
 			if (ptsid != 0) {
-				rc = avc_has_perm(ptsid, new_tsec->sid,
+				rc = avc_has_perm(&selinux_state,
+						  ptsid, new_tsec->sid,
 						  SECCLASS_PROCESS,
 						  PROCESS__PTRACE, NULL);
 				if (rc)
@@ -2520,7 +2559,8 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 		/* Enable secure mode for SIDs transitions unless
 		   the noatsecure permission is granted between
 		   the two SIDs, i.e. ahp returns 0. */
-		rc = avc_has_perm(old_tsec->sid, new_tsec->sid,
+		rc = avc_has_perm(&selinux_state,
+				  old_tsec->sid, new_tsec->sid,
 				  SECCLASS_PROCESS, PROCESS__NOATSECURE,
 				  NULL);
 		bprm->secureexec |= !!rc;
@@ -2612,7 +2652,8 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
 	 * higher than the default soft limit for cases where the default is
 	 * lower than the hard limit, e.g. RLIMIT_CORE or RLIMIT_STACK.
 	 */
-	rc = avc_has_perm(new_tsec->osid, new_tsec->sid, SECCLASS_PROCESS,
+	rc = avc_has_perm(&selinux_state,
+			  new_tsec->osid, new_tsec->sid, SECCLASS_PROCESS,
 			  PROCESS__RLIMITINH, NULL);
 	if (rc) {
 		/* protect against do_prlimit() */
@@ -2652,7 +2693,8 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 	 * This must occur _after_ the task SID has been updated so that any
 	 * kill done after the flush will be checked against the new SID.
 	 */
-	rc = avc_has_perm(osid, sid, SECCLASS_PROCESS, PROCESS__SIGINH, NULL);
+	rc = avc_has_perm(&selinux_state,
+			  osid, sid, SECCLASS_PROCESS, PROCESS__SIGINH, NULL);
 	if (rc) {
 		if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
 			memset(&itimer, 0, sizeof itimer);
@@ -3081,7 +3123,8 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	return avc_has_perm_flags(sid, isec->sid, isec->sclass, FILE__READ, &ad,
+	return avc_has_perm_flags(&selinux_state,
+				  sid, isec->sid, isec->sclass, FILE__READ, &ad,
 				  rcu ? MAY_NOT_BLOCK : 0);
 }
 
@@ -3097,7 +3140,8 @@ static noinline int audit_inode_permission(struct inode *inode,
 	ad.type = LSM_AUDIT_DATA_INODE;
 	ad.u.inode = inode;
 
-	rc = slow_avc_audit(current_sid(), isec->sid, isec->sclass, perms,
+	rc = slow_avc_audit(&selinux_state,
+			    current_sid(), isec->sid, isec->sclass, perms,
 			    audited, denied, result, &ad, flags);
 	if (rc)
 		return rc;
@@ -3135,7 +3179,8 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
-	rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass, perms, 0, &avd);
+	rc = avc_has_perm_noaudit(&selinux_state,
+				  sid, isec->sid, isec->sclass, perms, 0, &avd);
 	audited = avc_audit_required(perms, &avd, rc,
 				     from_access ? FILE__AUDIT_ACCESS : 0,
 				     &denied);
@@ -3224,7 +3269,8 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	ad.u.dentry = dentry;
 
 	isec = backing_inode_security(dentry);
-	rc = avc_has_perm(sid, isec->sid, isec->sclass,
+	rc = avc_has_perm(&selinux_state,
+			  sid, isec->sid, isec->sclass,
 			  FILE__RELABELFROM, &ad);
 	if (rc)
 		return rc;
@@ -3261,7 +3307,8 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(sid, newsid, isec->sclass,
+	rc = avc_has_perm(&selinux_state,
+			  sid, newsid, isec->sclass,
 			  FILE__RELABELTO, &ad);
 	if (rc)
 		return rc;
@@ -3271,7 +3318,8 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	if (rc)
 		return rc;
 
-	return avc_has_perm(newsid,
+	return avc_has_perm(&selinux_state,
+			    newsid,
 			    sbsec->sid,
 			    SECCLASS_FILESYSTEM,
 			    FILESYSTEM__ASSOCIATE,
@@ -3489,7 +3537,7 @@ static int selinux_file_permission(struct file *file, int mask)
 
 	isec = inode_security(inode);
 	if (sid == fsec->sid && fsec->isid == isec->sid &&
-	    fsec->pseqno == avc_policy_seqno())
+	    fsec->pseqno == avc_policy_seqno(&selinux_state))
 		/* No change since file_open check. */
 		return 0;
 
@@ -3529,7 +3577,8 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 	ad.u.op->path = file->f_path;
 
 	if (ssid != fsec->sid) {
-		rc = avc_has_perm(ssid, fsec->sid,
+		rc = avc_has_perm(&selinux_state,
+				  ssid, fsec->sid,
 				SECCLASS_FD,
 				FD__USE,
 				&ad);
@@ -3541,8 +3590,9 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 		return 0;
 
 	isec = inode_security(inode);
-	rc = avc_has_extended_perms(ssid, isec->sid, isec->sclass,
-			requested, driver, xperm, &ad);
+	rc = avc_has_extended_perms(&selinux_state,
+				    ssid, isec->sid, isec->sclass,
+				    requested, driver, xperm, &ad);
 out:
 	return rc;
 }
@@ -3610,7 +3660,8 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 		 * private file mapping that will also be writable.
 		 * This has an additional check.
 		 */
-		rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
+		rc = avc_has_perm(&selinux_state,
+				  sid, sid, SECCLASS_PROCESS,
 				  PROCESS__EXECMEM, NULL);
 		if (rc)
 			goto error;
@@ -3640,7 +3691,8 @@ static int selinux_mmap_addr(unsigned long addr)
 
 	if (addr < CONFIG_LSM_MMAP_MIN_ADDR) {
 		u32 sid = current_sid();
-		rc = avc_has_perm(sid, sid, SECCLASS_MEMPROTECT,
+		rc = avc_has_perm(&selinux_state,
+				  sid, sid, SECCLASS_MEMPROTECT,
 				  MEMPROTECT__MMAP_ZERO, NULL);
 	}
 
@@ -3684,13 +3736,15 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		int rc = 0;
 		if (vma->vm_start >= vma->vm_mm->start_brk &&
 		    vma->vm_end <= vma->vm_mm->brk) {
-			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
+			rc = avc_has_perm(&selinux_state,
+					  sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECHEAP, NULL);
 		} else if (!vma->vm_file &&
 			   ((vma->vm_start <= vma->vm_mm->start_stack &&
 			     vma->vm_end >= vma->vm_mm->start_stack) ||
 			    vma_is_stack_for_current(vma))) {
-			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
+			rc = avc_has_perm(&selinux_state,
+					  sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECSTACK, NULL);
 		} else if (vma->vm_file && vma->anon_vma) {
 			/*
@@ -3782,7 +3836,8 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 	else
 		perm = signal_to_av(signum);
 
-	return avc_has_perm(fsec->fown_sid, sid,
+	return avc_has_perm(&selinux_state,
+			    fsec->fown_sid, sid,
 			    SECCLASS_PROCESS, perm, NULL);
 }
 
@@ -3808,7 +3863,7 @@ static int selinux_file_open(struct file *file, const struct cred *cred)
 	 * struct as its SID.
 	 */
 	fsec->isid = isec->sid;
-	fsec->pseqno = avc_policy_seqno();
+	fsec->pseqno = avc_policy_seqno(&selinux_state);
 	/*
 	 * Since the inode label or policy seqno may have changed
 	 * between the selinux_inode_permission check and the saving
@@ -3827,7 +3882,8 @@ static int selinux_task_alloc(struct task_struct *task,
 {
 	u32 sid = current_sid();
 
-	return avc_has_perm(sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
+	return avc_has_perm(&selinux_state,
+			    sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
 }
 
 /*
@@ -3901,7 +3957,8 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(sid, secid,
+	ret = avc_has_perm(&selinux_state,
+			   sid, secid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__USE_AS_OVERRIDE,
 			   NULL);
@@ -3925,7 +3982,8 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 	u32 sid = current_sid();
 	int ret;
 
-	ret = avc_has_perm(sid, isec->sid,
+	ret = avc_has_perm(&selinux_state,
+			   sid, isec->sid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__CREATE_FILES_AS,
 			   NULL);
@@ -3942,7 +4000,8 @@ static int selinux_kernel_module_request(char *kmod_name)
 	ad.type = LSM_AUDIT_DATA_KMOD;
 	ad.u.kmod_name = kmod_name;
 
-	return avc_has_perm(current_sid(), SECINITSID_KERNEL, SECCLASS_SYSTEM,
+	return avc_has_perm(&selinux_state,
+			    current_sid(), SECINITSID_KERNEL, SECCLASS_SYSTEM,
 			    SYSTEM__MODULE_REQUEST, &ad);
 }
 
@@ -3956,7 +4015,8 @@ static int selinux_kernel_module_from_file(struct file *file)
 
 	/* init_module */
 	if (file == NULL)
-		return avc_has_perm(sid, sid, SECCLASS_SYSTEM,
+		return avc_has_perm(&selinux_state,
+				    sid, sid, SECCLASS_SYSTEM,
 					SYSTEM__MODULE_LOAD, NULL);
 
 	/* finit_module */
@@ -3966,13 +4026,15 @@ static int selinux_kernel_module_from_file(struct file *file)
 
 	fsec = file->f_security;
 	if (sid != fsec->sid) {
-		rc = avc_has_perm(sid, fsec->sid, SECCLASS_FD, FD__USE, &ad);
+		rc = avc_has_perm(&selinux_state,
+				  sid, fsec->sid, SECCLASS_FD, FD__USE, &ad);
 		if (rc)
 			return rc;
 	}
 
 	isec = inode_security(file_inode(file));
-	return avc_has_perm(sid, isec->sid, SECCLASS_SYSTEM,
+	return avc_has_perm(&selinux_state,
+			    sid, isec->sid, SECCLASS_SYSTEM,
 				SYSTEM__MODULE_LOAD, &ad);
 }
 
@@ -3994,19 +4056,22 @@ static int selinux_kernel_read_file(struct file *file,
 
 static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
 {
-	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+	return avc_has_perm(&selinux_state,
+			    current_sid(), task_sid(p), SECCLASS_PROCESS,
 			    PROCESS__SETPGID, NULL);
 }
 
 static int selinux_task_getpgid(struct task_struct *p)
 {
-	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+	return avc_has_perm(&selinux_state,
+			    current_sid(), task_sid(p), SECCLASS_PROCESS,
 			    PROCESS__GETPGID, NULL);
 }
 
 static int selinux_task_getsid(struct task_struct *p)
 {
-	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+	return avc_has_perm(&selinux_state,
+			    current_sid(), task_sid(p), SECCLASS_PROCESS,
 			    PROCESS__GETSESSION, NULL);
 }
 
@@ -4017,19 +4082,22 @@ static void selinux_task_getsecid(struct task_struct *p, u32 *secid)
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
 {
-	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+	return avc_has_perm(&selinux_state,
+			    current_sid(), task_sid(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_setioprio(struct task_struct *p, int ioprio)
 {
-	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+	return avc_has_perm(&selinux_state,
+			    current_sid(), task_sid(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_getioprio(struct task_struct *p)
 {
-	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+	return avc_has_perm(&selinux_state,
+			    current_sid(), task_sid(p), SECCLASS_PROCESS,
 			    PROCESS__GETSCHED, NULL);
 }
 
@@ -4044,7 +4112,8 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
 		av |= PROCESS__SETRLIMIT;
 	if (flags & LSM_PRLIMIT_READ)
 		av |= PROCESS__GETRLIMIT;
-	return avc_has_perm(cred_sid(cred), cred_sid(tcred),
+	return avc_has_perm(&selinux_state,
+			    cred_sid(cred), cred_sid(tcred),
 			    SECCLASS_PROCESS, av, NULL);
 }
 
@@ -4058,7 +4127,8 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
 	   later be used as a safe reset point for the soft limit
 	   upon context transitions.  See selinux_bprm_committing_creds. */
 	if (old_rlim->rlim_max != new_rlim->rlim_max)
-		return avc_has_perm(current_sid(), task_sid(p),
+		return avc_has_perm(&selinux_state,
+				    current_sid(), task_sid(p),
 				    SECCLASS_PROCESS, PROCESS__SETRLIMIT, NULL);
 
 	return 0;
@@ -4066,19 +4136,22 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
 
 static int selinux_task_setscheduler(struct task_struct *p)
 {
-	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+	return avc_has_perm(&selinux_state,
+			    current_sid(), task_sid(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_getscheduler(struct task_struct *p)
 {
-	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+	return avc_has_perm(&selinux_state,
+			    current_sid(), task_sid(p), SECCLASS_PROCESS,
 			    PROCESS__GETSCHED, NULL);
 }
 
 static int selinux_task_movememory(struct task_struct *p)
 {
-	return avc_has_perm(current_sid(), task_sid(p), SECCLASS_PROCESS,
+	return avc_has_perm(&selinux_state,
+			    current_sid(), task_sid(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
 
@@ -4093,7 +4166,8 @@ static int selinux_task_kill(struct task_struct *p, struct siginfo *info,
 		perm = signal_to_av(sig);
 	if (!secid)
 		secid = current_sid();
-	return avc_has_perm(secid, task_sid(p), SECCLASS_PROCESS, perm, NULL);
+	return avc_has_perm(&selinux_state,
+			    secid, task_sid(p), SECCLASS_PROCESS, perm, NULL);
 }
 
 static void selinux_task_to_inode(struct task_struct *p,
@@ -4428,7 +4502,8 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 	ad.u.net = &net;
 	ad.u.net->sk = sk;
 
-	return avc_has_perm(current_sid(), sksec->sid, sksec->sclass, perms,
+	return avc_has_perm(&selinux_state,
+			    current_sid(), sksec->sid, sksec->sclass, perms,
 			    &ad);
 }
 
@@ -4448,7 +4523,8 @@ static int selinux_socket_create(int family, int type,
 	if (rc)
 		return rc;
 
-	return avc_has_perm(tsec->sid, newsid, secclass, SOCKET__CREATE, NULL);
+	return avc_has_perm(&selinux_state,
+			    tsec->sid, newsid, secclass, SOCKET__CREATE, NULL);
 }
 
 static int selinux_socket_post_create(struct socket *sock, int family,
@@ -4557,7 +4633,8 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 				ad.u.net = &net;
 				ad.u.net->sport = htons(snum);
 				ad.u.net->family = family;
-				err = avc_has_perm(sksec->sid, sid,
+				err = avc_has_perm(&selinux_state,
+						   sksec->sid, sid,
 						   sksec->sclass,
 						   SOCKET__NAME_BIND, &ad);
 				if (err)
@@ -4601,7 +4678,8 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 		else
 			ad.u.net->v6info.saddr = addr6->sin6_addr;
 
-		err = avc_has_perm(sksec->sid, sid,
+		err = avc_has_perm(&selinux_state,
+				   sksec->sid, sid,
 				   sksec->sclass, node_perm, &ad);
 		if (err)
 			goto out;
@@ -4686,7 +4764,8 @@ static int selinux_socket_connect_helper(struct socket *sock,
 		ad.u.net = &net;
 		ad.u.net->dport = htons(snum);
 		ad.u.net->family = sk->sk_family;
-		err = avc_has_perm(sksec->sid, sid, sksec->sclass, perm, &ad);
+		err = avc_has_perm(&selinux_state,
+				   sksec->sid, sid, sksec->sclass, perm, &ad);
 		if (err)
 			return err;
 	}
@@ -4798,7 +4877,8 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 	ad.u.net = &net;
 	ad.u.net->sk = other;
 
-	err = avc_has_perm(sksec_sock->sid, sksec_other->sid,
+	err = avc_has_perm(&selinux_state,
+			   sksec_sock->sid, sksec_other->sid,
 			   sksec_other->sclass,
 			   UNIX_STREAM_SOCKET__CONNECTTO, &ad);
 	if (err)
@@ -4829,7 +4909,8 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 	ad.u.net = &net;
 	ad.u.net->sk = other->sk;
 
-	return avc_has_perm(ssec->sid, osec->sid, osec->sclass, SOCKET__SENDTO,
+	return avc_has_perm(&selinux_state,
+			    ssec->sid, osec->sid, osec->sclass, SOCKET__SENDTO,
 			    &ad);
 }
 
@@ -4844,7 +4925,8 @@ static int selinux_inet_sys_rcv_skb(struct net *ns, int ifindex,
 	err = sel_netif_sid(ns, ifindex, &if_sid);
 	if (err)
 		return err;
-	err = avc_has_perm(peer_sid, if_sid,
+	err = avc_has_perm(&selinux_state,
+			   peer_sid, if_sid,
 			   SECCLASS_NETIF, NETIF__INGRESS, ad);
 	if (err)
 		return err;
@@ -4852,7 +4934,8 @@ static int selinux_inet_sys_rcv_skb(struct net *ns, int ifindex,
 	err = sel_netnode_sid(addrp, family, &node_sid);
 	if (err)
 		return err;
-	return avc_has_perm(peer_sid, node_sid,
+	return avc_has_perm(&selinux_state,
+			    peer_sid, node_sid,
 			    SECCLASS_NODE, NODE__RECVFROM, ad);
 }
 
@@ -4875,7 +4958,8 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 		return err;
 
 	if (selinux_secmark_enabled()) {
-		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
+		err = avc_has_perm(&selinux_state,
+				   sk_sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
 			return err;
@@ -4940,7 +5024,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 			selinux_netlbl_err(skb, family, err, 0);
 			return err;
 		}
-		err = avc_has_perm(sk_sid, peer_sid, SECCLASS_PEER,
+		err = avc_has_perm(&selinux_state,
+				   sk_sid, peer_sid, SECCLASS_PEER,
 				   PEER__RECV, &ad);
 		if (err) {
 			selinux_netlbl_err(skb, family, err, 0);
@@ -4949,7 +5034,8 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (secmark_active) {
-		err = avc_has_perm(sk_sid, skb->secmark, SECCLASS_PACKET,
+		err = avc_has_perm(&selinux_state,
+				   sk_sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
 		if (err)
 			return err;
@@ -5132,7 +5218,8 @@ static int selinux_sctp_assoc_request(struct sctp_endpoint *ep,
 		ad.type = LSM_AUDIT_DATA_NET;
 		ad.u.net = &net;
 		ad.u.net->sk = ep->base.sk;
-		err = avc_has_perm(sksec->peer_sid, peer_sid, sksec->sclass,
+		err = avc_has_perm(&selinux_state,
+				   sksec->peer_sid, peer_sid, sksec->sclass,
 				   SCTP_SOCKET__ASSOCIATION, &ad);
 		if (err)
 			return err;
@@ -5306,7 +5393,9 @@ static int selinux_secmark_relabel_packet(u32 sid)
 	__tsec = current_security();
 	tsid = __tsec->sid;
 
-	return avc_has_perm(tsid, sid, SECCLASS_PACKET, PACKET__RELABELTO, NULL);
+	return avc_has_perm(&selinux_state,
+			    tsid, sid, SECCLASS_PACKET, PACKET__RELABELTO,
+			    NULL);
 }
 
 static void selinux_secmark_refcount_inc(void)
@@ -5354,7 +5443,8 @@ static int selinux_tun_dev_create(void)
 	 * connections unlike traditional sockets - check the TUN driver to
 	 * get a better understanding of why this socket is special */
 
-	return avc_has_perm(sid, sid, SECCLASS_TUN_SOCKET, TUN_SOCKET__CREATE,
+	return avc_has_perm(&selinux_state,
+			    sid, sid, SECCLASS_TUN_SOCKET, TUN_SOCKET__CREATE,
 			    NULL);
 }
 
@@ -5362,7 +5452,8 @@ static int selinux_tun_dev_attach_queue(void *security)
 {
 	struct tun_security_struct *tunsec = security;
 
-	return avc_has_perm(current_sid(), tunsec->sid, SECCLASS_TUN_SOCKET,
+	return avc_has_perm(&selinux_state,
+			    current_sid(), tunsec->sid, SECCLASS_TUN_SOCKET,
 			    TUN_SOCKET__ATTACH_QUEUE, NULL);
 }
 
@@ -5390,11 +5481,13 @@ static int selinux_tun_dev_open(void *security)
 	u32 sid = current_sid();
 	int err;
 
-	err = avc_has_perm(sid, tunsec->sid, SECCLASS_TUN_SOCKET,
+	err = avc_has_perm(&selinux_state,
+			   sid, tunsec->sid, SECCLASS_TUN_SOCKET,
 			   TUN_SOCKET__RELABELFROM, NULL);
 	if (err)
 		return err;
-	err = avc_has_perm(sid, sid, SECCLASS_TUN_SOCKET,
+	err = avc_has_perm(&selinux_state,
+			   sid, sid, SECCLASS_TUN_SOCKET,
 			   TUN_SOCKET__RELABELTO, NULL);
 	if (err)
 		return err;
@@ -5485,7 +5578,8 @@ static unsigned int selinux_ip_forward(struct sk_buff *skb,
 	}
 
 	if (secmark_active)
-		if (avc_has_perm(peer_sid, skb->secmark,
+		if (avc_has_perm(&selinux_state,
+				 peer_sid, skb->secmark,
 				 SECCLASS_PACKET, PACKET__FORWARD_IN, &ad))
 			return NF_DROP;
 
@@ -5597,7 +5691,8 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 		return NF_DROP;
 
 	if (selinux_secmark_enabled())
-		if (avc_has_perm(sksec->sid, skb->secmark,
+		if (avc_has_perm(&selinux_state,
+				 sksec->sid, skb->secmark,
 				 SECCLASS_PACKET, PACKET__SEND, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
@@ -5720,7 +5815,8 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
 		return NF_DROP;
 
 	if (secmark_active)
-		if (avc_has_perm(peer_sid, skb->secmark,
+		if (avc_has_perm(&selinux_state,
+				 peer_sid, skb->secmark,
 				 SECCLASS_PACKET, secmark_perm, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
@@ -5730,13 +5826,15 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
 
 		if (sel_netif_sid(dev_net(outdev), ifindex, &if_sid))
 			return NF_DROP;
-		if (avc_has_perm(peer_sid, if_sid,
+		if (avc_has_perm(&selinux_state,
+				 peer_sid, if_sid,
 				 SECCLASS_NETIF, NETIF__EGRESS, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 
 		if (sel_netnode_sid(addrp, family, &node_sid))
 			return NF_DROP;
-		if (avc_has_perm(peer_sid, node_sid,
+		if (avc_has_perm(&selinux_state,
+				 peer_sid, node_sid,
 				 SECCLASS_NODE, NODE__SENDTO, &ad))
 			return NF_DROP_ERR(-ECONNREFUSED);
 	}
@@ -5824,7 +5922,8 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = ipc_perms->key;
 
-	return avc_has_perm(sid, isec->sid, isec->sclass, perms, &ad);
+	return avc_has_perm(&selinux_state,
+			    sid, isec->sid, isec->sclass, perms, &ad);
 }
 
 static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
@@ -5854,7 +5953,8 @@ static int selinux_msg_queue_alloc_security(struct msg_queue *msq)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->q_perm.key;
 
-	rc = avc_has_perm(sid, isec->sid, SECCLASS_MSGQ,
+	rc = avc_has_perm(&selinux_state,
+			  sid, isec->sid, SECCLASS_MSGQ,
 			  MSGQ__CREATE, &ad);
 	if (rc) {
 		ipc_free_security(&msq->q_perm);
@@ -5879,7 +5979,8 @@ static int selinux_msg_queue_associate(struct msg_queue *msq, int msqflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->q_perm.key;
 
-	return avc_has_perm(sid, isec->sid, SECCLASS_MSGQ,
+	return avc_has_perm(&selinux_state,
+			    sid, isec->sid, SECCLASS_MSGQ,
 			    MSGQ__ASSOCIATE, &ad);
 }
 
@@ -5892,7 +5993,8 @@ static int selinux_msg_queue_msgctl(struct msg_queue *msq, int cmd)
 	case IPC_INFO:
 	case MSG_INFO:
 		/* No specific object, just general system-wide information. */
-		return avc_has_perm(current_sid(), SECINITSID_KERNEL,
+		return avc_has_perm(&selinux_state,
+				    current_sid(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case IPC_STAT:
 	case MSG_STAT:
@@ -5941,15 +6043,18 @@ static int selinux_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
 	ad.u.ipc_id = msq->q_perm.key;
 
 	/* Can this process write to the queue? */
-	rc = avc_has_perm(sid, isec->sid, SECCLASS_MSGQ,
+	rc = avc_has_perm(&selinux_state,
+			  sid, isec->sid, SECCLASS_MSGQ,
 			  MSGQ__WRITE, &ad);
 	if (!rc)
 		/* Can this process send the message */
-		rc = avc_has_perm(sid, msec->sid, SECCLASS_MSG,
+		rc = avc_has_perm(&selinux_state,
+				  sid, msec->sid, SECCLASS_MSG,
 				  MSG__SEND, &ad);
 	if (!rc)
 		/* Can the message be put in the queue? */
-		rc = avc_has_perm(msec->sid, isec->sid, SECCLASS_MSGQ,
+		rc = avc_has_perm(&selinux_state,
+				  msec->sid, isec->sid, SECCLASS_MSGQ,
 				  MSGQ__ENQUEUE, &ad);
 
 	return rc;
@@ -5971,10 +6076,12 @@ static int selinux_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = msq->q_perm.key;
 
-	rc = avc_has_perm(sid, isec->sid,
+	rc = avc_has_perm(&selinux_state,
+			  sid, isec->sid,
 			  SECCLASS_MSGQ, MSGQ__READ, &ad);
 	if (!rc)
-		rc = avc_has_perm(sid, msec->sid,
+		rc = avc_has_perm(&selinux_state,
+				  sid, msec->sid,
 				  SECCLASS_MSG, MSG__RECEIVE, &ad);
 	return rc;
 }
@@ -5996,7 +6103,8 @@ static int selinux_shm_alloc_security(struct shmid_kernel *shp)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->shm_perm.key;
 
-	rc = avc_has_perm(sid, isec->sid, SECCLASS_SHM,
+	rc = avc_has_perm(&selinux_state,
+			  sid, isec->sid, SECCLASS_SHM,
 			  SHM__CREATE, &ad);
 	if (rc) {
 		ipc_free_security(&shp->shm_perm);
@@ -6021,7 +6129,8 @@ static int selinux_shm_associate(struct shmid_kernel *shp, int shmflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = shp->shm_perm.key;
 
-	return avc_has_perm(sid, isec->sid, SECCLASS_SHM,
+	return avc_has_perm(&selinux_state,
+			    sid, isec->sid, SECCLASS_SHM,
 			    SHM__ASSOCIATE, &ad);
 }
 
@@ -6035,7 +6144,8 @@ static int selinux_shm_shmctl(struct shmid_kernel *shp, int cmd)
 	case IPC_INFO:
 	case SHM_INFO:
 		/* No specific object, just general system-wide information. */
-		return avc_has_perm(current_sid(), SECINITSID_KERNEL,
+		return avc_has_perm(&selinux_state,
+				    current_sid(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case IPC_STAT:
 	case SHM_STAT:
@@ -6089,7 +6199,8 @@ static int selinux_sem_alloc_security(struct sem_array *sma)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->sem_perm.key;
 
-	rc = avc_has_perm(sid, isec->sid, SECCLASS_SEM,
+	rc = avc_has_perm(&selinux_state,
+			  sid, isec->sid, SECCLASS_SEM,
 			  SEM__CREATE, &ad);
 	if (rc) {
 		ipc_free_security(&sma->sem_perm);
@@ -6114,7 +6225,8 @@ static int selinux_sem_associate(struct sem_array *sma, int semflg)
 	ad.type = LSM_AUDIT_DATA_IPC;
 	ad.u.ipc_id = sma->sem_perm.key;
 
-	return avc_has_perm(sid, isec->sid, SECCLASS_SEM,
+	return avc_has_perm(&selinux_state,
+			    sid, isec->sid, SECCLASS_SEM,
 			    SEM__ASSOCIATE, &ad);
 }
 
@@ -6128,7 +6240,8 @@ static int selinux_sem_semctl(struct sem_array *sma, int cmd)
 	case IPC_INFO:
 	case SEM_INFO:
 		/* No specific object, just general system-wide information. */
-		return avc_has_perm(current_sid(), SECINITSID_KERNEL,
+		return avc_has_perm(&selinux_state,
+				    current_sid(), SECINITSID_KERNEL,
 				    SECCLASS_SYSTEM, SYSTEM__IPC_INFO, NULL);
 	case GETPID:
 	case GETNCNT:
@@ -6214,7 +6327,8 @@ static int selinux_getprocattr(struct task_struct *p,
 	__tsec = __task_cred(p)->security;
 
 	if (current != p) {
-		error = avc_has_perm(current_sid(), __tsec->sid,
+		error = avc_has_perm(&selinux_state,
+				     current_sid(), __tsec->sid,
 				     SECCLASS_PROCESS, PROCESS__GETATTR, NULL);
 		if (error)
 			goto bad;
@@ -6263,19 +6377,24 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	 * Basic control over ability to set these attributes at all.
 	 */
 	if (!strcmp(name, "exec"))
-		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
+		error = avc_has_perm(&selinux_state,
+				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETEXEC, NULL);
 	else if (!strcmp(name, "fscreate"))
-		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
+		error = avc_has_perm(&selinux_state,
+				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETFSCREATE, NULL);
 	else if (!strcmp(name, "keycreate"))
-		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
+		error = avc_has_perm(&selinux_state,
+				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETKEYCREATE, NULL);
 	else if (!strcmp(name, "sockcreate"))
-		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
+		error = avc_has_perm(&selinux_state,
+				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETSOCKCREATE, NULL);
 	else if (!strcmp(name, "current"))
-		error = avc_has_perm(mysid, mysid, SECCLASS_PROCESS,
+		error = avc_has_perm(&selinux_state,
+				     mysid, mysid, SECCLASS_PROCESS,
 				     PROCESS__SETCURRENT, NULL);
 	else
 		error = -EINVAL;
@@ -6332,7 +6451,8 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	} else if (!strcmp(name, "fscreate")) {
 		tsec->create_sid = sid;
 	} else if (!strcmp(name, "keycreate")) {
-		error = avc_has_perm(mysid, sid, SECCLASS_KEY, KEY__CREATE,
+		error = avc_has_perm(&selinux_state,
+				     mysid, sid, SECCLASS_KEY, KEY__CREATE,
 				     NULL);
 		if (error)
 			goto abort_change;
@@ -6354,7 +6474,8 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 		}
 
 		/* Check permissions for the transition. */
-		error = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
+		error = avc_has_perm(&selinux_state,
+				     tsec->sid, sid, SECCLASS_PROCESS,
 				     PROCESS__DYNTRANSITION, NULL);
 		if (error)
 			goto abort_change;
@@ -6363,7 +6484,8 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 		   Otherwise, leave SID unchanged and fail. */
 		ptsid = ptrace_parent_sid();
 		if (ptsid != 0) {
-			error = avc_has_perm(ptsid, sid, SECCLASS_PROCESS,
+			error = avc_has_perm(&selinux_state,
+					     ptsid, sid, SECCLASS_PROCESS,
 					     PROCESS__PTRACE, NULL);
 			if (error)
 				goto abort_change;
@@ -6489,7 +6611,8 @@ static int selinux_key_permission(key_ref_t key_ref,
 	key = key_ref_to_ptr(key_ref);
 	ksec = key->security;
 
-	return avc_has_perm(sid, ksec->sid, SECCLASS_KEY, perm, NULL);
+	return avc_has_perm(&selinux_state,
+			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
 }
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
@@ -6525,7 +6648,8 @@ static int selinux_ib_pkey_access(void *ib_sec, u64 subnet_prefix, u16 pkey_val)
 	ibpkey.subnet_prefix = subnet_prefix;
 	ibpkey.pkey = pkey_val;
 	ad.u.ibpkey = &ibpkey;
-	return avc_has_perm(sec->sid, sid,
+	return avc_has_perm(&selinux_state,
+			    sec->sid, sid,
 			    SECCLASS_INFINIBAND_PKEY,
 			    INFINIBAND_PKEY__ACCESS, &ad);
 }
@@ -6549,7 +6673,8 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
 	strncpy(ibendport.dev_name, dev_name, sizeof(ibendport.dev_name));
 	ibendport.port = port_num;
 	ad.u.ibendport = &ibendport;
-	return avc_has_perm(sec->sid, sid,
+	return avc_has_perm(&selinux_state,
+			    sec->sid, sid,
 			    SECCLASS_INFINIBAND_ENDPORT,
 			    INFINIBAND_ENDPORT__MANAGE_SUBNET, &ad);
 }
@@ -6582,11 +6707,13 @@ static int selinux_bpf(int cmd, union bpf_attr *attr,
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		ret = avc_has_perm(sid, sid, SECCLASS_BPF, BPF__MAP_CREATE,
+		ret = avc_has_perm(&selinux_state,
+				   sid, sid, SECCLASS_BPF, BPF__MAP_CREATE,
 				   NULL);
 		break;
 	case BPF_PROG_LOAD:
-		ret = avc_has_perm(sid, sid, SECCLASS_BPF, BPF__PROG_LOAD,
+		ret = avc_has_perm(&selinux_state,
+				   sid, sid, SECCLASS_BPF, BPF__PROG_LOAD,
 				   NULL);
 		break;
 	default:
@@ -6626,14 +6753,16 @@ static int bpf_fd_pass(struct file *file, u32 sid)
 	if (file->f_op == &bpf_map_fops) {
 		map = file->private_data;
 		bpfsec = map->security;
-		ret = avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
+		ret = avc_has_perm(&selinux_state,
+				   sid, bpfsec->sid, SECCLASS_BPF,
 				   bpf_map_fmode_to_av(file->f_mode), NULL);
 		if (ret)
 			return ret;
 	} else if (file->f_op == &bpf_prog_fops) {
 		prog = file->private_data;
 		bpfsec = prog->aux->security;
-		ret = avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
+		ret = avc_has_perm(&selinux_state,
+				   sid, bpfsec->sid, SECCLASS_BPF,
 				   BPF__PROG_RUN, NULL);
 		if (ret)
 			return ret;
@@ -6647,7 +6776,8 @@ static int selinux_bpf_map(struct bpf_map *map, fmode_t fmode)
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = map->security;
-	return avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
+	return avc_has_perm(&selinux_state,
+			    sid, bpfsec->sid, SECCLASS_BPF,
 			    bpf_map_fmode_to_av(fmode), NULL);
 }
 
@@ -6657,7 +6787,8 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
 	struct bpf_security_struct *bpfsec;
 
 	bpfsec = prog->aux->security;
-	return avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
+	return avc_has_perm(&selinux_state,
+			    sid, bpfsec->sid, SECCLASS_BPF,
 			    BPF__PROG_RUN, NULL);
 }
 
@@ -6958,6 +7089,7 @@ static __init int selinux_init(void)
 	enforcing_set(&selinux_state, selinux_enforcing_boot);
 	selinux_state.checkreqprot = selinux_checkreqprot_boot;
 	selinux_ss_init(&selinux_state.ss);
+	selinux_avc_init(&selinux_state.avc);
 
 	/* Set the security state for the initial task. */
 	cred_init_security();
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index de33dc9034b8..ef899bcfd2cb 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -52,6 +52,7 @@ struct selinux_audit_data {
 	u32 audited;
 	u32 denied;
 	int result;
+	struct selinux_state *state;
 };
 
 /*
@@ -96,7 +97,8 @@ static inline u32 avc_audit_required(u32 requested,
 	return audited;
 }
 
-int slow_avc_audit(u32 ssid, u32 tsid, u16 tclass,
+int slow_avc_audit(struct selinux_state *state,
+		   u32 ssid, u32 tsid, u16 tclass,
 		   u32 requested, u32 audited, u32 denied, int result,
 		   struct common_audit_data *a,
 		   unsigned flags);
@@ -121,7 +123,8 @@ int slow_avc_audit(u32 ssid, u32 tsid, u16 tclass,
  * be performed under a lock, to allow the lock to be released
  * before calling the auditing code.
  */
-static inline int avc_audit(u32 ssid, u32 tsid,
+static inline int avc_audit(struct selinux_state *state,
+			    u32 ssid, u32 tsid,
 			    u16 tclass, u32 requested,
 			    struct av_decision *avd,
 			    int result,
@@ -132,31 +135,35 @@ static inline int avc_audit(u32 ssid, u32 tsid,
 	audited = avc_audit_required(requested, avd, result, 0, &denied);
 	if (likely(!audited))
 		return 0;
-	return slow_avc_audit(ssid, tsid, tclass,
+	return slow_avc_audit(state, ssid, tsid, tclass,
 			      requested, audited, denied, result,
 			      a, flags);
 }
 
 #define AVC_STRICT 1 /* Ignore permissive mode. */
 #define AVC_EXTENDED_PERMS 2	/* update extended permissions */
-int avc_has_perm_noaudit(u32 ssid, u32 tsid,
+int avc_has_perm_noaudit(struct selinux_state *state,
+			 u32 ssid, u32 tsid,
 			 u16 tclass, u32 requested,
 			 unsigned flags,
 			 struct av_decision *avd);
 
-int avc_has_perm(u32 ssid, u32 tsid,
+int avc_has_perm(struct selinux_state *state,
+		 u32 ssid, u32 tsid,
 		 u16 tclass, u32 requested,
 		 struct common_audit_data *auditdata);
-int avc_has_perm_flags(u32 ssid, u32 tsid,
+int avc_has_perm_flags(struct selinux_state *state,
+		       u32 ssid, u32 tsid,
 		       u16 tclass, u32 requested,
 		       struct common_audit_data *auditdata,
 		       int flags);
 
-int avc_has_extended_perms(u32 ssid, u32 tsid, u16 tclass, u32 requested,
-		u8 driver, u8 perm, struct common_audit_data *ad);
+int avc_has_extended_perms(struct selinux_state *state,
+			   u32 ssid, u32 tsid, u16 tclass, u32 requested,
+			   u8 driver, u8 perm, struct common_audit_data *ad);
 
 
-u32 avc_policy_seqno(void);
+u32 avc_policy_seqno(struct selinux_state *state);
 
 #define AVC_CALLBACK_GRANT		1
 #define AVC_CALLBACK_TRY_REVOKE		2
@@ -171,8 +178,11 @@ u32 avc_policy_seqno(void);
 int avc_add_callback(int (*callback)(u32 event), u32 events);
 
 /* Exported to selinuxfs */
-int avc_get_hash_stats(char *page);
-extern unsigned int avc_cache_threshold;
+struct selinux_avc;
+int avc_get_hash_stats(struct selinux_avc *avc, char *page);
+unsigned int avc_get_cache_threshold(struct selinux_avc *avc);
+void avc_set_cache_threshold(struct selinux_avc *avc,
+			     unsigned int cache_threshold);
 
 /* Attempt to free avc node cache */
 void avc_disable(void);
diff --git a/security/selinux/include/avc_ss.h b/security/selinux/include/avc_ss.h
index 4e2a44d0ae66..88c384c5c09e 100644
--- a/security/selinux/include/avc_ss.h
+++ b/security/selinux/include/avc_ss.h
@@ -9,7 +9,8 @@
 
 #include "flask.h"
 
-int avc_ss_reset(u32 seqno);
+struct selinux_avc;
+int avc_ss_reset(struct selinux_avc *avc, u32 seqno);
 
 /* Class/perm mapping support */
 struct security_class_mapping {
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index f1db09a5f521..23e762d529fa 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -93,6 +93,7 @@ extern char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX];
 /* limitation of boundary depth  */
 #define POLICYDB_BOUNDS_MAXDEPTH	4
 
+struct selinux_avc;
 struct selinux_ss;
 
 struct selinux_state {
@@ -103,10 +104,12 @@ struct selinux_state {
 	bool checkreqprot;
 	bool initialized;
 	bool policycap[__POLICYDB_CAPABILITY_MAX];
+	struct selinux_avc *avc;
 	struct selinux_ss *ss;
 };
 
 void selinux_ss_init(struct selinux_ss **ss);
+void selinux_avc_init(struct selinux_avc **avc);
 
 extern struct selinux_state selinux_state;
 
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 28010f741cfe..186e727b737b 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -478,7 +478,8 @@ int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 		perm = RAWIP_SOCKET__RECVFROM;
 	}
 
-	rc = avc_has_perm(sksec->sid, nlbl_sid, sksec->sclass, perm, ad);
+	rc = avc_has_perm(&selinux_state,
+			  sksec->sid, nlbl_sid, sksec->sclass, perm, ad);
 	if (rc == 0)
 		return 0;
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 1a32e93ba7b9..511863566c61 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -162,7 +162,8 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 
 	old_value = enforcing_enabled(state);
 	if (new_value != old_value) {
-		length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+		length = avc_has_perm(&selinux_state,
+				      current_sid(), SECINITSID_SECURITY,
 				      SECCLASS_SECURITY, SECURITY__SETENFORCE,
 				      NULL);
 		if (length)
@@ -174,7 +175,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 			audit_get_sessionid(current));
 		enforcing_set(state, new_value);
 		if (new_value)
-			avc_ss_reset(0);
+			avc_ss_reset(state->avc, 0);
 		selnl_notify_setenforce(new_value);
 		selinux_status_update_setenforce(state, new_value);
 		if (!new_value)
@@ -379,7 +380,8 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 
 	mutex_lock(&fsi->mutex);
 
-	rc = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+	rc = avc_has_perm(&selinux_state,
+			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
 	if (rc)
 		goto err;
@@ -443,7 +445,8 @@ static ssize_t sel_read_policy(struct file *filp, char __user *buf,
 
 	mutex_lock(&fsi->mutex);
 
-	ret = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+	ret = avc_has_perm(&selinux_state,
+			   current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__READ_POLICY, NULL);
 	if (ret)
 		goto out;
@@ -540,7 +543,8 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 
 	mutex_lock(&fsi->mutex);
 
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+	length = avc_has_perm(&selinux_state,
+			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__LOAD_POLICY, NULL);
 	if (length)
 		goto out;
@@ -599,7 +603,8 @@ static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 	u32 sid, len;
 	ssize_t length;
 
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+	length = avc_has_perm(&selinux_state,
+			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__CHECK_CONTEXT, NULL);
 	if (length)
 		goto out;
@@ -647,7 +652,8 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	ssize_t length;
 	unsigned int new_value;
 
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+	length = avc_has_perm(&selinux_state,
+			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETCHECKREQPROT,
 			      NULL);
 	if (length)
@@ -692,7 +698,8 @@ static ssize_t sel_write_validatetrans(struct file *file,
 	u16 tclass;
 	int rc;
 
-	rc = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+	rc = avc_has_perm(&selinux_state,
+			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__VALIDATE_TRANS, NULL);
 	if (rc)
 		goto out;
@@ -820,7 +827,8 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 	struct av_decision avd;
 	ssize_t length;
 
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+	length = avc_has_perm(&selinux_state,
+			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_AV, NULL);
 	if (length)
 		goto out;
@@ -873,7 +881,8 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 	u32 len;
 	int nargs;
 
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+	length = avc_has_perm(&selinux_state,
+			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_CREATE,
 			      NULL);
 	if (length)
@@ -974,7 +983,8 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	char *newcon = NULL;
 	u32 len;
 
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+	length = avc_has_perm(&selinux_state,
+			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_RELABEL,
 			      NULL);
 	if (length)
@@ -1034,7 +1044,8 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	int i, rc;
 	u32 len, nsids;
 
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+	length = avc_has_perm(&selinux_state,
+			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
 			      NULL);
 	if (length)
@@ -1098,7 +1109,8 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	char *newcon = NULL;
 	u32 len;
 
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+	length = avc_has_perm(&selinux_state,
+			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_MEMBER,
 			      NULL);
 	if (length)
@@ -1211,7 +1223,8 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 
 	mutex_lock(&fsi->mutex);
 
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+	length = avc_has_perm(&selinux_state,
+			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETBOOL,
 			      NULL);
 	if (length)
@@ -1272,7 +1285,8 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 
 	mutex_lock(&fsi->mutex);
 
-	length = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+	length = avc_has_perm(&selinux_state,
+			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__SETBOOL,
 			      NULL);
 	if (length)
@@ -1412,10 +1426,13 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
 static ssize_t sel_read_avc_cache_threshold(struct file *filp, char __user *buf,
 					    size_t count, loff_t *ppos)
 {
+	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
-	length = scnprintf(tmpbuf, TMPBUFLEN, "%u", avc_cache_threshold);
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%u",
+			   avc_get_cache_threshold(state->avc));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
@@ -1424,11 +1441,14 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 					     size_t count, loff_t *ppos)
 
 {
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *page;
 	ssize_t ret;
 	unsigned int new_value;
 
-	ret = avc_has_perm(current_sid(), SECINITSID_SECURITY,
+	ret = avc_has_perm(&selinux_state,
+			   current_sid(), SECINITSID_SECURITY,
 			   SECCLASS_SECURITY, SECURITY__SETSECPARAM,
 			   NULL);
 	if (ret)
@@ -1449,7 +1469,7 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 	if (sscanf(page, "%u", &new_value) != 1)
 		goto out;
 
-	avc_cache_threshold = new_value;
+	avc_set_cache_threshold(state->avc, new_value);
 
 	ret = count;
 out:
@@ -1460,6 +1480,8 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 static ssize_t sel_read_avc_hash_stats(struct file *filp, char __user *buf,
 				       size_t count, loff_t *ppos)
 {
+	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
 	char *page;
 	ssize_t length;
 
@@ -1467,7 +1489,7 @@ static ssize_t sel_read_avc_hash_stats(struct file *filp, char __user *buf,
 	if (!page)
 		return -ENOMEM;
 
-	length = avc_get_hash_stats(page);
+	length = avc_get_hash_stats(state->avc, page);
 	if (length >= 0)
 		length = simple_read_from_buffer(buf, count, ppos, page, length);
 	free_page((unsigned long)page);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index ccfa65f6bc17..8057e19dc15f 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2151,7 +2151,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		state->initialized = 1;
 		seqno = ++state->ss->latest_granting;
 		selinux_complete_init();
-		avc_ss_reset(seqno);
+		avc_ss_reset(state->avc, seqno);
 		selnl_notify_policyload(seqno);
 		selinux_status_update_policyload(state, seqno);
 		selinux_netlbl_cache_invalidate();
@@ -2233,7 +2233,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	sidtab_destroy(&oldsidtab);
 	kfree(oldmapping);
 
-	avc_ss_reset(seqno);
+	avc_ss_reset(state->avc, seqno);
 	selnl_notify_policyload(seqno);
 	selinux_status_update_policyload(state, seqno);
 	selinux_netlbl_cache_invalidate();
@@ -2649,7 +2649,8 @@ int security_get_user_sids(struct selinux_state *state,
 	}
 	for (i = 0, j = 0; i < mynel; i++) {
 		struct av_decision dummy_avd;
-		rc = avc_has_perm_noaudit(fromsid, mysids[i],
+		rc = avc_has_perm_noaudit(state,
+					  fromsid, mysids[i],
 					  SECCLASS_PROCESS, /* kernel value */
 					  PROCESS__TRANSITION, AVC_STRICT,
 					  &dummy_avd);
@@ -2907,7 +2908,7 @@ int security_set_bools(struct selinux_state *state, int len, int *values)
 out:
 	write_unlock_irq(&state->ss->policy_rwlock);
 	if (!rc) {
-		avc_ss_reset(seqno);
+		avc_ss_reset(state->avc, seqno);
 		selnl_notify_policyload(seqno);
 		selinux_status_update_policyload(state, seqno);
 		selinux_xfrm_notify_policyload();
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index a5ac27de571f..91dc3783ed94 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -106,7 +106,8 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
 	if (rc)
 		goto err;
 
-	rc = avc_has_perm(tsec->sid, ctx->ctx_sid,
+	rc = avc_has_perm(&selinux_state,
+			  tsec->sid, ctx->ctx_sid,
 			  SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT, NULL);
 	if (rc)
 		goto err;
@@ -142,7 +143,8 @@ static int selinux_xfrm_delete(struct xfrm_sec_ctx *ctx)
 	if (!ctx)
 		return 0;
 
-	return avc_has_perm(tsec->sid, ctx->ctx_sid,
+	return avc_has_perm(&selinux_state,
+			    tsec->sid, ctx->ctx_sid,
 			    SECCLASS_ASSOCIATION, ASSOCIATION__SETCONTEXT,
 			    NULL);
 }
@@ -164,7 +166,8 @@ int selinux_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 	if (!selinux_authorizable_ctx(ctx))
 		return -EINVAL;
 
-	rc = avc_has_perm(fl_secid, ctx->ctx_sid,
+	rc = avc_has_perm(&selinux_state,
+			  fl_secid, ctx->ctx_sid,
 			  SECCLASS_ASSOCIATION, ASSOCIATION__POLMATCH, NULL);
 	return (rc == -EACCES ? -ESRCH : rc);
 }
@@ -203,7 +206,8 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	/* We don't need a separate SA Vs. policy polmatch check since the SA
 	 * is now of the same label as the flow and a flow Vs. policy polmatch
 	 * check had already happened in selinux_xfrm_policy_lookup() above. */
-	return (avc_has_perm(fl->flowi_secid, state_sid,
+	return (avc_has_perm(&selinux_state,
+			     fl->flowi_secid, state_sid,
 			    SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO,
 			    NULL) ? 0 : 1);
 }
@@ -422,7 +426,8 @@ int selinux_xfrm_sock_rcv_skb(u32 sk_sid, struct sk_buff *skb,
 	/* This check even when there's no association involved is intended,
 	 * according to Trent Jaeger, to make sure a process can't engage in
 	 * non-IPsec communication unless explicitly allowed by policy. */
-	return avc_has_perm(sk_sid, peer_sid,
+	return avc_has_perm(&selinux_state,
+			    sk_sid, peer_sid,
 			    SECCLASS_ASSOCIATION, ASSOCIATION__RECVFROM, ad);
 }
 
@@ -465,6 +470,6 @@ int selinux_xfrm_postroute_last(u32 sk_sid, struct sk_buff *skb,
 	/* This check even when there's no association involved is intended,
 	 * according to Trent Jaeger, to make sure a process can't engage in
 	 * non-IPsec communication unless explicitly allowed by policy. */
-	return avc_has_perm(sk_sid, SECINITSID_UNLABELED,
+	return avc_has_perm(&selinux_state, sk_sid, SECINITSID_UNLABELED,
 			    SECCLASS_ASSOCIATION, ASSOCIATION__SENDTO, ad);
 }
-- 
2.14.3
