Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3PJ4FrX019321
	for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2008 15:04:15 -0400
Received: from QMTA05.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3PJ4DHS022166
	for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2008 19:04:13 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 1/2] SELinux: Made netnode cache adds faster
To: selinux@tycho.nsa.gov
Date: Fri, 25 Apr 2008 15:03:34 -0400
Message-ID: <20080425190334.18002.38919.stgit@flek.lan>
In-Reply-To: <20080425185928.18002.88176.stgit@flek.lan>
References: <20080425185928.18002.88176.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When adding new entries to the network node cache we would walk the entire
hash bucket to make sure we didn't cross a threshold (done to bound the cache
size).  This isn't a very quick or elegant solution for something which is
supposed to be quick-ish so add a counter to each hash bucket to track the
size of the bucket and eliminate the need to walk the entire bucket list on
each add.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 security/selinux/netnode.c |  104 +++++++++++++++++++++-----------------------
 1 files changed, 49 insertions(+), 55 deletions(-)

diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 2edc4c5..b6ccd09 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -40,11 +40,17 @@
 #include <net/ipv6.h>
 #include <asm/bug.h>
 
+#include "netnode.h"
 #include "objsec.h"
 
 #define SEL_NETNODE_HASH_SIZE       256
 #define SEL_NETNODE_HASH_BKT_LIMIT   16
 
+struct sel_netnode_bkt {
+	unsigned int size;
+	struct list_head list;
+};
+
 struct sel_netnode {
 	struct netnode_security_struct nsec;
 
@@ -60,7 +66,7 @@ struct sel_netnode {
 
 static LIST_HEAD(sel_netnode_list);
 static DEFINE_SPINLOCK(sel_netnode_lock);
-static struct list_head sel_netnode_hash[SEL_NETNODE_HASH_SIZE];
+static struct sel_netnode_bkt sel_netnode_hash[SEL_NETNODE_HASH_SIZE];
 
 /**
  * sel_netnode_free - Frees a node entry
@@ -87,7 +93,7 @@ static void sel_netnode_free(struct rcu_head *p)
  * the bucket number for the given IP address.
  *
  */
-static u32 sel_netnode_hashfn_ipv4(__be32 addr)
+static unsigned int sel_netnode_hashfn_ipv4(__be32 addr)
 {
 	/* at some point we should determine if the mismatch in byte order
 	 * affects the hash function dramatically */
@@ -103,7 +109,7 @@ static u32 sel_netnode_hashfn_ipv4(__be32 addr)
  * the bucket number for the given IP address.
  *
  */
-static u32 sel_netnode_hashfn_ipv6(const struct in6_addr *addr)
+static unsigned int sel_netnode_hashfn_ipv6(const struct in6_addr *addr)
 {
 	/* just hash the least significant 32 bits to keep things fast (they
 	 * are the most likely to be different anyway), we can revisit this
@@ -123,7 +129,7 @@ static u32 sel_netnode_hashfn_ipv6(const struct in6_addr *addr)
  */
 static struct sel_netnode *sel_netnode_find(const void *addr, u16 family)
 {
-	u32 idx;
+	unsigned int idx;
 	struct sel_netnode *node;
 
 	switch (family) {
@@ -137,7 +143,7 @@ static struct sel_netnode *sel_netnode_find(const void *addr, u16 family)
 		BUG();
 	}
 
-	list_for_each_entry_rcu(node, &sel_netnode_hash[idx], list)
+	list_for_each_entry_rcu(node, &sel_netnode_hash[idx].list, list)
 		if (node->nsec.family == family)
 			switch (family) {
 			case PF_INET:
@@ -159,15 +165,12 @@ static struct sel_netnode *sel_netnode_find(const void *addr, u16 family)
  * @node: the new node record
  *
  * Description:
- * Add a new node record to the network address hash table.  Returns zero on
- * success, negative values on failure.
+ * Add a new node record to the network address hash table.
  *
  */
-static int sel_netnode_insert(struct sel_netnode *node)
+static void sel_netnode_insert(struct sel_netnode *node)
 {
-	u32 idx;
-	u32 count = 0;
-	struct sel_netnode *iter;
+	unsigned int idx;
 
 	switch (node->nsec.family) {
 	case PF_INET:
@@ -179,32 +182,21 @@ static int sel_netnode_insert(struct sel_netnode *node)
 	default:
 		BUG();
 	}
-	list_add_rcu(&node->list, &sel_netnode_hash[idx]);
+
+	INIT_RCU_HEAD(&node->rcu);
 
 	/* we need to impose a limit on the growth of the hash table so check
 	 * this bucket to make sure it is within the specified bounds */
-	list_for_each_entry(iter, &sel_netnode_hash[idx], list)
-		if (++count > SEL_NETNODE_HASH_BKT_LIMIT) {
-			list_del_rcu(&iter->list);
-			call_rcu(&iter->rcu, sel_netnode_free);
-			break;
-		}
-
-	return 0;
-}
-
-/**
- * sel_netnode_destroy - Remove a node record from the table
- * @node: the existing node record
- *
- * Description:
- * Remove an existing node record from the network address table.
- *
- */
-static void sel_netnode_destroy(struct sel_netnode *node)
-{
-	list_del_rcu(&node->list);
-	call_rcu(&node->rcu, sel_netnode_free);
+	list_add_rcu(&node->list, &sel_netnode_hash[idx].list);
+	if (sel_netnode_hash[idx].size == SEL_NETNODE_HASH_BKT_LIMIT) {
+		struct sel_netnode *tail;
+		tail = list_entry(
+			rcu_dereference(sel_netnode_hash[idx].list.prev),
+			struct sel_netnode, list);
+		list_del_rcu(&tail->list);
+		call_rcu(&tail->rcu, sel_netnode_free);
+	} else
+		sel_netnode_hash[idx].size++;
 }
 
 /**
@@ -222,7 +214,7 @@ static void sel_netnode_destroy(struct sel_netnode *node)
  */
 static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 {
-	int ret;
+	int ret = -ENOMEM;
 	struct sel_netnode *node;
 	struct sel_netnode *new = NULL;
 
@@ -230,25 +222,21 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 	node = sel_netnode_find(addr, family);
 	if (node != NULL) {
 		*sid = node->nsec.sid;
-		ret = 0;
-		goto out;
+		spin_unlock_bh(&sel_netnode_lock);
+		return 0;
 	}
 	new = kzalloc(sizeof(*new), GFP_ATOMIC);
-	if (new == NULL) {
-		ret = -ENOMEM;
+	if (new == NULL)
 		goto out;
-	}
 	switch (family) {
 	case PF_INET:
 		ret = security_node_sid(PF_INET,
-					addr, sizeof(struct in_addr),
-					&new->nsec.sid);
+					addr, sizeof(struct in_addr), sid);
 		new->nsec.addr.ipv4 = *(__be32 *)addr;
 		break;
 	case PF_INET6:
 		ret = security_node_sid(PF_INET6,
-					addr, sizeof(struct in6_addr),
-					&new->nsec.sid);
+					addr, sizeof(struct in6_addr), sid);
 		ipv6_addr_copy(&new->nsec.addr.ipv6, addr);
 		break;
 	default:
@@ -256,11 +244,10 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 	}
 	if (ret != 0)
 		goto out;
+
 	new->nsec.family = family;
-	ret = sel_netnode_insert(new);
-	if (ret != 0)
-		goto out;
-	*sid = new->nsec.sid;
+	new->nsec.sid = *sid;
+	sel_netnode_insert(new);
 
 out:
 	spin_unlock_bh(&sel_netnode_lock);
@@ -312,13 +299,18 @@ int sel_netnode_sid(void *addr, u16 family, u32 *sid)
  */
 static void sel_netnode_flush(void)
 {
-	u32 idx;
-	struct sel_netnode *node;
+	unsigned int idx;
+	struct sel_netnode *node, *node_tmp;
 
 	spin_lock_bh(&sel_netnode_lock);
-	for (idx = 0; idx < SEL_NETNODE_HASH_SIZE; idx++)
-		list_for_each_entry(node, &sel_netnode_hash[idx], list)
-			sel_netnode_destroy(node);
+	for (idx = 0; idx < SEL_NETNODE_HASH_SIZE; idx++) {
+		list_for_each_entry_safe(node, node_tmp,
+					 &sel_netnode_hash[idx].list, list) {
+				list_del_rcu(&node->list);
+				call_rcu(&node->rcu, sel_netnode_free);
+		}
+		sel_netnode_hash[idx].size = 0;
+	}
 	spin_unlock_bh(&sel_netnode_lock);
 }
 
@@ -340,8 +332,10 @@ static __init int sel_netnode_init(void)
 	if (!selinux_enabled)
 		return 0;
 
-	for (iter = 0; iter < SEL_NETNODE_HASH_SIZE; iter++)
-		INIT_LIST_HEAD(&sel_netnode_hash[iter]);
+	for (iter = 0; iter < SEL_NETNODE_HASH_SIZE; iter++) {
+		INIT_LIST_HEAD(&sel_netnode_hash[iter].list);
+		sel_netnode_hash[iter].size = 0;
+	}
 
 	ret = avc_add_callback(sel_netnode_avc_callback, AVC_CALLBACK_RESET,
 			       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
