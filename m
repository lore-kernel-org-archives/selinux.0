From: Eric Paris <eparis@redhat.com>
Subject: [DO NOT COMMIT PATCH 1/2] SELinux: place avc_cache hlist and lock
	together - DO NOT COMMIT!!!
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, paul.moore@hp.com
Date: Thu, 12 Feb 2009 14:52:30 -0500
Message-ID: <20090212195230.25719.99849.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently the avc_cache lock and the list it protects are hugely seperated
in space.  This patch puts these together for better cache coherency.

Turns out this is a bad idea.  Putting the lock in the same cache line as the
list head means that when the lock is taken the list head is also marked dirty
and that cache line has to be cleared from all cpus.  I'm just sending this
patch for completeness of things I tried.

Caused an 11% performance INCREASE in time spent in avc_has_perm_noaudit based
on oprofile results running tbench.

THIS IS A BAD PATCH SENT TO LIST ONLY FOR HISTORICAL PURPOSES.  DO NOT COMMIT.
THIS WAS A BAD IDEA.
---

 security/selinux/avc.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index cc83acd..d8fb209 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -96,9 +96,13 @@ struct avc_node {
 	struct rcu_head		rhead;
 };
 
+struct avc_slot {
+	struct hlist_head	head; /* head for avc_node->list */
+	spinlock_t		lock; /* lock for writes */
+};
+
 struct avc_cache {
-	struct hlist_head	slots[AVC_CACHE_SLOTS]; /* head for avc_node->list */
-	spinlock_t		slots_lock[AVC_CACHE_SLOTS]; /* lock for writes */
+	struct avc_slot		slots[AVC_CACHE_SLOTS];
 	atomic_t		lru_hint;	/* LRU hint for reclaim scan */
 	atomic_t		active_nodes;
 	u32			latest_notif;	/* latest revocation notification */
@@ -238,8 +242,8 @@ void __init avc_init(void)
 	int i;
 
 	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		INIT_HLIST_HEAD(&avc_cache.slots[i]);
-		spin_lock_init(&avc_cache.slots_lock[i]);
+		INIT_HLIST_HEAD(&avc_cache.slots[i].head);
+		spin_lock_init(&avc_cache.slots[i].lock);
 	}
 	atomic_set(&avc_cache.active_nodes, 0);
 	atomic_set(&avc_cache.lru_hint, 0);
@@ -261,7 +265,7 @@ int avc_get_hash_stats(char *page)
 	slots_used = 0;
 	max_chain_len = 0;
 	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		head = &avc_cache.slots[i];
+		head = &avc_cache.slots[i].head;
 		if (!hlist_empty(head)) {
 			struct hlist_node *next;
 
@@ -321,8 +325,8 @@ static inline int avc_reclaim_node(void)
 
 	for (try = 0, ecx = 0; try < AVC_CACHE_SLOTS; try++) {
 		hvalue = atomic_inc_return(&avc_cache.lru_hint) & (AVC_CACHE_SLOTS - 1);
-		head = &avc_cache.slots[hvalue];
-		lock = &avc_cache.slots_lock[hvalue];
+		head = &avc_cache.slots[hvalue].head;
+		lock = &avc_cache.slots[hvalue].lock;
 
 		if (!spin_trylock_irqsave(lock, flags))
 			continue;
@@ -380,7 +384,7 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
 	struct hlist_node *next;
 
 	hvalue = avc_hash(ssid, tsid, tclass);
-	head = &avc_cache.slots[hvalue];
+	head = &avc_cache.slots[hvalue].head;
 	hlist_for_each_entry_rcu(node, next, head, list) {
 		if (ssid == node->ae.ssid &&
 		    tclass == node->ae.tclass &&
@@ -477,8 +481,8 @@ static struct avc_node *avc_insert(u32 ssid, u32 tsid, u16 tclass, struct av_dec
 		hvalue = avc_hash(ssid, tsid, tclass);
 		avc_node_populate(node, ssid, tsid, tclass, avd);
 
-		head = &avc_cache.slots[hvalue];
-		lock = &avc_cache.slots_lock[hvalue];
+		head = &avc_cache.slots[hvalue].head;
+		lock = &avc_cache.slots[hvalue].lock;
 
 		spin_lock_irqsave(lock, flag);
 		hlist_for_each_entry(pos, next, head, list) {
@@ -773,8 +777,8 @@ static int avc_update_node(u32 event, u32 perms, u32 ssid, u32 tsid, u16 tclass,
 	/* Lock the target slot */
 	hvalue = avc_hash(ssid, tsid, tclass);
 
-	head = &avc_cache.slots[hvalue];
-	lock = &avc_cache.slots_lock[hvalue];
+	head = &avc_cache.slots[hvalue].head;
+	lock = &avc_cache.slots[hvalue].lock;
 
 	spin_lock_irqsave(lock, flag);
 
@@ -843,8 +847,8 @@ int avc_ss_reset(u32 seqno)
 	spinlock_t *lock;
 
 	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		head = &avc_cache.slots[i];
-		lock = &avc_cache.slots_lock[i];
+		head = &avc_cache.slots[i].head;
+		lock = &avc_cache.slots[i].lock;
 
 		spin_lock_irqsave(lock, flag);
 		/*


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
