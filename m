Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3AEmhds002116
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 10:48:43 -0400
Received: from QMTA07.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3AEmgPq002664
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 14:48:42 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH v3 1/2] SELinux: Made netnode cache adds faster
To: selinux@tycho.nsa.gov
Date: Thu, 10 Apr 2008 10:48:09 -0400
Message-ID: <20080410144809.8521.5716.stgit@flek.lan>
In-Reply-To: <20080410144452.8521.39381.stgit@flek.lan>
References: <20080410144452.8521.39381.stgit@flek.lan>
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

 security/selinux/netnode.c |   67 +++++++++++++++++++++-----------------------
 1 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index f3c526f..6d71763 100644
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
@@ -165,9 +171,7 @@ static struct sel_netnode *sel_netnode_find(const void *addr, u16 family)
  */
 static int sel_netnode_insert(struct sel_netnode *node)
 {
-	u32 idx;
-	u32 count = 0;
-	struct sel_netnode *iter;
+	unsigned int idx;
 
 	switch (node->nsec.family) {
 	case PF_INET:
@@ -179,35 +183,22 @@ static int sel_netnode_insert(struct sel_netnode *node)
 	default:
 		BUG();
 	}
-	list_add_rcu(&node->list, &sel_netnode_hash[idx]);
 
 	/* we need to impose a limit on the growth of the hash table so check
 	 * this bucket to make sure it is within the specified bounds */
-	list_for_each_entry(iter, &sel_netnode_hash[idx], list)
-		if (++count > SEL_NETNODE_HASH_BKT_LIMIT) {
-			list_del_rcu(&iter->list);
-			call_rcu(&iter->rcu, sel_netnode_free);
-			break;
-		}
+	list_add_rcu(&node->list, &sel_netnode_hash[idx].list);
+	if (sel_netnode_hash[idx].size == SEL_NETNODE_HASH_BKT_LIMIT) {
+		struct sel_netnode *tail;
+		tail = list_entry(node->list.prev, struct sel_netnode, list);
+		list_del_rcu(node->list.prev);
+		call_rcu(&tail->rcu, sel_netnode_free);
+	} else
+		sel_netnode_hash[idx].size++;
 
 	return 0;
 }
 
 /**
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
-}
-
-/**
  * sel_netnode_sid_slow - Lookup the SID of a network address using the policy
  * @addr: the IP address
  * @family: the address family
@@ -312,13 +303,17 @@ int sel_netnode_sid(void *addr, u16 family, u32 *sid)
  */
 static void sel_netnode_flush(void)
 {
-	u32 idx;
+	unsigned int idx;
 	struct sel_netnode *node;
 
 	spin_lock_bh(&sel_netnode_lock);
-	for (idx = 0; idx < SEL_NETNODE_HASH_SIZE; idx++)
-		list_for_each_entry(node, &sel_netnode_hash[idx], list)
-			sel_netnode_destroy(node);
+	for (idx = 0; idx < SEL_NETNODE_HASH_SIZE; idx++) {
+		list_for_each_entry(node, &sel_netnode_hash[idx].list, list) {
+			list_del_rcu(&node->list);
+			call_rcu(&node->rcu, sel_netnode_free);
+		}
+		sel_netnode_hash[idx].size = 0;
+	}
 	spin_unlock_bh(&sel_netnode_lock);
 }
 
@@ -340,8 +335,10 @@ static __init int sel_netnode_init(void)
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
