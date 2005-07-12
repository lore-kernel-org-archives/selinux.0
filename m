Subject: Re: port and address caches
From: Joy Latten <latten@austin.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@redhat.com>, SELinux@tycho.nsa.gov
In-Reply-To: <1121191588.16209.136.camel@moss-spartans.epoch.ncsc.mil>
References: <200507121746.j6CHkePX004477@faith.austin.ibm.com>
	 <1121191588.16209.136.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 17:06:52 -0500
Message-Id: <1121206012.4518.20.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-07-12 at 14:06 -0400, Stephen Smalley wrote:
> On Tue, 2005-07-12 at 12:46 -0500, Joy Latten wrote:
> > My colleague implemented port and ipaddress caches 
> > in security_port_sid() and security_node_sid(). 
> > I ran a few benchmark tests as indicated below. 
> > The reaim benchmark is the only one that I
> > know contains networking tests. The 16-way with the cache changes
> > indicate some performance improvement. I am currently working 
> > on a testcase that will somewhat exercise the use of ports and/or
> > ipaddresses. Hopefully this will better indicate an improvement.
> 
> Hi,
> 
> Thanks for continuing to work on these patches.  Can you post or provide
> a URL to a current version of the patches, against a recent upstream
> kernel (e.g. 2.6.13-rc2-mm2)?
> 

Here is a patch against linux-2.6.12. The code was written by my 
colleague, Kylie Hall. I am testing it with the intent of fixing it
up if it shows promise. 

Regards,
Joy

diff -urpN linux-2.6.11.orig/security/selinux/ss/services.c
linux-2.6.11.perf/security/selinux/ss/services.c
--- linux-2.6.11.orig/security/selinux/ss/services.c	2005-06-10
18:27:37.000000000 -0500
+++ linux-2.6.11.perf/security/selinux/ss/services.c	2005-06-10
18:29:02.000000000 -0500
@@ -28,6 +28,10 @@
 #include <linux/sched.h>
 #include <linux/audit.h>
 #include <asm/semaphore.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
+#include <linux/jhash.h>
+#include <linux/random.h>
 #include "flask.h"
 #include "avc.h"
 #include "avc_ss.h"
@@ -52,6 +56,51 @@ static DECLARE_MUTEX(load_sem);
 #define LOAD_LOCK down(&load_sem)
 #define LOAD_UNLOCK up(&load_sem)
 
+#define CACHE_SLOTS 512
+#define CACHE_THRESHOLD 410
+#define CACHE_RECLAIM 16
+
+#define RECENTLY_USED 2
+
+struct node_entry {
+	u16 domain;
+	u32 addrlen;
+	u32 addr[4];
+};
+
+struct port_entry {
+	u8 protocol;
+	u16 port;
+};
+
+union slot_entry {
+	struct port_entry port;
+	struct node_entry node;
+};
+
+struct cache_slot {
+	union slot_entry entry;
+	u32 sid;
+	atomic_t used;
+	kmem_cache_t *mem_cache;
+	struct list_head list;
+	struct rcu_head rhead;
+};
+
+struct cache {
+	struct list_head slot[CACHE_SLOTS];
+	spinlock_t slot_lock[CACHE_SLOTS];
+	kmem_cache_t *mem_cache;
+	int cache_initialized;
+	atomic_t lru_hint;
+	atomic_t actives;
+	u32 hash_rnd;
+};
+
+static struct cache ipv4_cache;
+static struct cache ipv6_cache;
+static struct cache port_cache;
+
 static struct sidtab sidtab;
 struct policydb policydb;
 int ss_initialized = 0;
@@ -69,6 +118,195 @@ static int context_struct_to_string(stru
 				    u32 *scontext_len);
 
 /*
+ * Use:
+	ports: word1 = protocol                 word2 = port
+	ipv4:  word1 = addr                     word2 = 0
+	ipv6:  word1 = addr[0] ^ addr[1]        word2 = addr[2] ^ addr[3]
+*/
+static inline int cache_hash(struct cache *c_ptr, u32 word1, u32 word2)
+{
+
+	return jhash_2words(word1, word2, c_ptr->hash_rnd) & (CACHE_SLOTS -
1);
+}
+
+static void cache_slot_free(struct rcu_head *rhead)
+{
+	struct cache_slot *slot;
+	slot = container_of(rhead, struct cache_slot, rhead);
+	kmem_cache_free(slot->mem_cache, slot);
+}
+
+static inline int reclaim_cache_slots(struct cache *c_ptr)
+{
+	int hvalue, i, claimed;
+	unsigned long flags = 0;
+	struct cache_slot *slot;
+
+	for (i = 0, claimed = 0; i < CACHE_SLOTS; i++) {
+		hvalue = atomic_inc_return(&(c_ptr->lru_hint))
+			 & (CACHE_SLOTS - 1); 
+		if (!spin_trylock_irqsave (&(c_ptr->slot_lock[hvalue]), flags))
+			continue;
+
+		list_for_each_entry_rcu(slot, &(c_ptr->slot[hvalue]), list) {
+			if (atomic_dec_and_test(&slot->used)) {
+				list_del_rcu(&slot->list);
+				call_rcu(&slot->rhead, cache_slot_free);
+				atomic_dec(&(c_ptr->actives));
+				claimed++;
+				if (claimed >= CACHE_RECLAIM) {
+					spin_unlock_irqrestore(&(c_ptr->
+								 slot_lock
+								 [hvalue]),
+								 flags);
+					goto out;
+				}
+			}
+		}
+
+		spin_unlock_irqrestore(&(c_ptr->slot_lock[hvalue]), flags);
+	}
+	out:
+	return claimed;
+}
+
+static inline struct cache_slot *get_slot(struct cache *c_ptr, u32 sid)
+{
+	struct cache_slot *new;
+
+	new = kmem_cache_alloc(c_ptr->mem_cache, GFP_ATOMIC);
+	if (!new)
+		return NULL;
+
+	INIT_RCU_HEAD(&new->rhead);
+	INIT_LIST_HEAD(&new->list);
+
+	atomic_set(&new->used, RECENTLY_USED);
+	new->mem_cache = c_ptr->mem_cache;
+	new->sid = sid;
+
+	if (atomic_inc_return(&(c_ptr->actives)) > CACHE_THRESHOLD)
+		reclaim_cache_slots(c_ptr);
+
+	return new;
+}
+
+static void cache_reset(struct cache *c_ptr)
+{
+	int i;
+	struct cache_slot *slot;
+	unsigned long flags;
+
+	rcu_read_lock();
+	for (i = 0; i < CACHE_SLOTS; i++) {
+		spin_lock_irqsave(&(c_ptr->slot_lock[i]), flags);
+		list_for_each_entry_rcu(slot, &(c_ptr->slot[i]), list) {
+			list_del_rcu(&slot->list);
+			call_rcu(&slot->rhead, cache_slot_free);
+			atomic_dec(&(c_ptr->actives));
+		}
+		spin_unlock_irqrestore(&(c_ptr->slot_lock[i]), flags);
+	}
+	rcu_read_unlock();
+}
+
+static inline void cache_init(struct cache *c_ptr, char *name)
+{
+	int i;
+
+	c_ptr->cache_initialized = 1;
+	c_ptr->mem_cache = kmem_cache_create(name, sizeof(struct cache_slot), 
+					     0, 0, NULL, NULL);
+	for (i = 0; i < CACHE_SLOTS; i++) {
+		INIT_LIST_HEAD(&(c_ptr->slot[i]));
+		spin_lock_init(&(c_ptr->slot_lock[i]));
+	}
+
+	atomic_set(&(c_ptr->actives), 0);
+	atomic_set(&(c_ptr->lru_hint), 0);
+	get_random_bytes(&(c_ptr->hash_rnd), sizeof(u32));
+}
+
+static inline int port_compare(union slot_entry *ins, union slot_entry
*pos)
+{
+
+	if (ins->port.protocol == pos->port.protocol &&
+				  ins->port.port == pos->port.port)
+		return 1;
+
+	return 0;
+}
+
+static inline int ipv4_compare(union slot_entry *ins, union slot_entry
*pos)
+{
+	if (ins->node.domain == pos->node.domain &&
+	    ins->node.addrlen == pos->node.addrlen &&
+	    ins->node.addr[0] == pos->node.addr[0])
+		return 1;
+	return 0;
+}
+
+static inline int ipv6_compare(union slot_entry *ins, union slot_entry
*pos)
+{
+	if (ins->node.domain == pos->node.domain &&
+	    ins->node.addrlen == pos->node.addrlen &&
+	    ins->node.addr[0] == pos->node.addr[0] &&
+	    ins->node.addr[1] == pos->node.addr[1] &&
+	    ins->node.addr[2] == pos->node.addr[2] &&
+	    ins->node.addr[3] == pos->node.addr[3])
+		return 1;
+	return 0;
+}
+
+static inline void add_cache_entry(struct cache *c_ptr,
+				   struct cache_slot *slot, int hash_val,
+				   int (*slot_cmp) (union slot_entry *,
+				   union slot_entry *))
+{
+	unsigned long flags = 0;
+	struct cache_slot *pos;
+
+	spin_lock_irqsave(&(c_ptr->slot_lock[hash_val]), flags);
+	rcu_read_lock();
+	list_for_each_entry_rcu(pos, &(c_ptr->slot[hash_val]), list) {
+		if ((*slot_cmp) (&slot->entry, &pos->entry)) {
+			list_replace_rcu(&pos->list, &slot->list);
+			call_rcu(&pos->rhead, cache_slot_free);
+			atomic_dec(&(c_ptr->actives));
+			goto out;
+		}
+	}
+	list_add_rcu(&slot->list, &(c_ptr->slot[hash_val]));
+out:
+	spin_unlock_irqrestore(&(c_ptr->slot_lock[hash_val]), flags);
+	rcu_read_unlock();
+}
+
+static inline int search_cache_entry(struct cache *c_ptr,
+				     union slot_entry *slot, int hash_val,
+				     int (*slot_cmp) (union slot_entry *,
+				     union slot_entry *),
+				     u32 * sid)
+{
+	struct cache_slot *node;
+	int rc = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(node, &(c_ptr->slot[hash_val]), list) {
+		if ((*slot_cmp) (slot, &node->entry)) {
+			*sid = node->sid;
+			if (atomic_read(&node->used) != RECENTLY_USED)
+				atomic_set(&node->used, RECENTLY_USED);
+				rc = 1;
+				goto out;
+		}
+	}
+out:
+	rcu_read_unlock();
+	return rc;
+}
+
+/*
  * Return the boolean value of a constraint expression
  * when it is applied to the specified source and target
  * security contexts.
@@ -1253,6 +1491,10 @@ int security_load_policy(void *data, siz
 	policydb_destroy(&oldpolicydb);
 	sidtab_destroy(&oldsidtab);
 
+	cache_reset(&ipv4_cache);
+	cache_reset(&ipv6_cache);
+	cache_reset(&port_cache);
+
 	avc_ss_reset(seqno);
 	selnl_notify_policyload(seqno);
 
@@ -1283,6 +1525,21 @@ int security_port_sid(u16 domain,
 	struct ocontext *c;
 	int rc = 0;
 
+	struct cache_slot *node = NULL;
+
+	int hash = cache_hash(&port_cache, protocol, port);
+
+	if (!port_cache.cache_initialized)
+		cache_init(&port_cache, "port_mem_cache");
+	else {
+		union slot_entry slot;
+		slot.port.protocol = protocol;
+		slot.port.port = port;
+		if (search_cache_entry(&port_cache, &slot, hash, 
+					port_compare, out_sid))
+			goto out;
+	}
+
 	POLICY_RDLOCK;
 
 	c = policydb.ocontexts[OCON_PORT];
@@ -1300,15 +1557,23 @@ int security_port_sid(u16 domain,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
-				goto out;
+				goto out_unlock;
 		}
 		*out_sid = c->sid[0];
 	} else {
 		*out_sid = SECINITSID_PORT;
 	}
 
-out:
+	node = get_slot(&port_cache, *out_sid);
+	if (node) {
+		node->entry.port.protocol = protocol;
+		node->entry.port.port = port;
+
+		add_cache_entry(&port_cache, node, hash, port_compare);
+	}
+out_unlock:
 	POLICY_RDUNLOCK;
+out:
 	return rc;
 }
 
@@ -1384,8 +1649,50 @@ int security_node_sid(u16 domain,
 		      u32 addrlen,
 		      u32 *out_sid)
 {
-	int rc = 0;
+	int i, rc = 0;
 	struct ocontext *c;
+	int hash = -1;
+	struct cache_slot *node = NULL;
+
+	switch (domain) {
+	case AF_INET:
+		if (!ipv4_cache.cache_initialized)
+			cache_init(&ipv4_cache, "ipv4_mem_cache");
+		else {
+			union slot_entry slot;
+			hash = cache_hash(&ipv4_cache, *((u32 *) addrp), 0);
+			slot.node.domain = domain;
+			slot.node.addrlen = addrlen;
+			slot.node.addr[0] = *(u32 *) addrp;
+			if (search_cache_entry(&ipv4_cache, &slot, hash,
ipv4_compare, out_sid))
+				goto out;
+		}
+		break;
+	case AF_INET6:
+		if (!ipv6_cache.cache_initialized)
+			cache_init(&ipv6_cache, "ipv6_mem_cache");
+		else {
+			union slot_entry slot;
+			hash = cache_hash(&ipv6_cache,
+					 ((((u32 *) addrp)[0]) ^
+					 (((u32 *) addrp)[1])),
+					 ((((u32 *) addrp)[2]) ^
+					 (((u32 *) addrp)[3])));
+			slot.node.domain = domain;
+			slot.node.addrlen = addrlen;
+			slot.node.addr[0] = ((u32 *) addrp)[0];
+			slot.node.addr[1] = ((u32 *) addrp)[1];
+			slot.node.addr[2] = ((u32 *) addrp)[2];
+			slot.node.addr[3] = ((u32 *) addrp)[3];
+			if (search_cache_entry(&ipv6_cache, &slot, hash, 
+						ipv6_compare, out_sid))
+				goto out;
+		}
+		break;
+	default:
+		*out_sid = SECINITSID_NODE;
+		goto out;
+	}
 
 	POLICY_RDLOCK;
 
@@ -1395,7 +1702,7 @@ int security_node_sid(u16 domain,
 
 		if (addrlen != sizeof(u32)) {
 			rc = -EINVAL;
-			goto out;
+			goto out_unlock;
 		}
 
 		addr = *((u32 *)addrp);
@@ -1412,7 +1719,7 @@ int security_node_sid(u16 domain,
 	case AF_INET6:
 		if (addrlen != sizeof(u64) * 2) {
 			rc = -EINVAL;
-			goto out;
+			goto out_unlock;
 		}
 		c = policydb.ocontexts[OCON_NODE6];
 		while (c) {
@@ -1425,7 +1732,7 @@ int security_node_sid(u16 domain,
 
 	default:
 		*out_sid = SECINITSID_NODE;
-		goto out;
+		goto out_unlock;
 	}
 
 	if (c) {
@@ -1434,15 +1741,48 @@ int security_node_sid(u16 domain,
 						   &c->context[0],
 						   &c->sid[0]);
 			if (rc)
-				goto out;
+				goto out_unlock;
 		}
 		*out_sid = c->sid[0];
 	} else {
 		*out_sid = SECINITSID_NODE;
 	}
 
-out:
+	switch (domain) {
+	case AF_INET:
+		node = get_slot(&ipv4_cache, *out_sid);
+		if (!node)
+			goto out_unlock;
+		node->entry.node.domain = domain;
+		node->entry.node.addrlen = addrlen;
+		node->entry.node.addr[0] = *((u32 *) addrp);
+
+		if (hash < 0)
+			hash = cache_hash(&ipv4_cache, *((u32 *) addrp), 0);
+		add_cache_entry(&ipv4_cache, node, hash, ipv4_compare);
+		break;
+	case AF_INET6:
+		node = get_slot(&ipv6_cache, *out_sid);
+		if (!node)
+			goto out_unlock;
+		node->entry.node.domain = domain;
+		node->entry.node.addrlen = addrlen;
+		for (i = 0; i < 4; i++)
+			node->entry.node.addr[i] = ((u32 *) addrp)[i];
+		if (hash < 0)
+			hash = cache_hash(&ipv6_cache,
+					 ((u32 *) addrp)[0] ^
+					 ((u32 *) addrp)[1],
+					 ((u32 *) addrp)[2] ^
+					 ((u32 *) addrp)[3]);
+
+		add_cache_entry(&ipv6_cache, node, hash, ipv6_compare);
+		break;
+	}
+
+out_unlock:
 	POLICY_RDUNLOCK;
+out:
 	return rc;
 }
 
@@ -1753,6 +2093,9 @@ int security_set_bools(int len, int *val
 out:
 	POLICY_WRUNLOCK;
 	if (!rc) {
+		cache_reset(&ipv4_cache);
+		cache_reset(&ipv6_cache);
+		cache_reset(&port_cache);
 		avc_ss_reset(seqno);
 		selnl_notify_policyload(seqno);
 	}



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
