Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n625W7Vl013519
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 01:32:07 -0400
Received: from mail-px0-f202.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n625VYva014527
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 05:31:51 GMT
Received: by mail-px0-f202.google.com with SMTP id 40so129340pxi.32
        for <selinux@tycho.nsa.gov>; Wed, 01 Jul 2009 22:32:06 -0700 (PDT)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: selinux@tycho.nsa.gov, "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 5/8] SELinux netnode.c non trivial fixes.
Date: Wed,  1 Jul 2009 22:32:44 -0700
Message-Id: <1246512767-2999-6-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1246512767-2999-1-git-send-email-justinmattock@gmail.com>
References: <1246512767-2999-1-git-send-email-justinmattock@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

Fix some comments.
---
 security/selinux/netnode.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 7100072..426c41d 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -57,11 +57,11 @@ struct sel_netnode {
 	struct rcu_head rcu;
 };
 
-/* NOTE: we are using a combined hash table for both IPv4 and IPv6, the reason
+/* NOTE: We are using a combined hash table for both IPv4 and IPv6, the reason
  * for this is that I suspect most users will not make heavy use of both
  * address families at the same time so one table will usually end up wasted,
  * if this becomes a problem we can always add a hash table for each address
- * family later */
+ * family later. */
 
 static LIST_HEAD(sel_netnode_list);
 static DEFINE_SPINLOCK(sel_netnode_lock);
@@ -94,8 +94,8 @@ static void sel_netnode_free(struct rcu_head *p)
  */
 static unsigned int sel_netnode_hashfn_ipv4(__be32 addr)
 {
-	/* at some point we should determine if the mismatch in byte order
-	 * affects the hash function dramatically */
+	/* At some point we should determine if the mismatch in byte order
+	 * affects the hash function dramatically. */
 	return (addr & (SEL_NETNODE_HASH_SIZE - 1));
 }
 
@@ -110,9 +110,9 @@ static unsigned int sel_netnode_hashfn_ipv4(__be32 addr)
  */
 static unsigned int sel_netnode_hashfn_ipv6(const struct in6_addr *addr)
 {
-	/* just hash the least significant 32 bits to keep things fast (they
+	/* Just hash the least significant 32 bits to keep things fast (they
 	 * are the most likely to be different anyway), we can revisit this
-	 * later if needed */
+	 * later if needed. */
 	return (addr->s6_addr32[3] & (SEL_NETNODE_HASH_SIZE - 1));
 }
 
@@ -184,8 +184,8 @@ static void sel_netnode_insert(struct sel_netnode *node)
 
 	INIT_RCU_HEAD(&node->rcu);
 
-	/* we need to impose a limit on the growth of the hash table so check
-	 * this bucket to make sure it is within the specified bounds */
+	/* We need to impose a limit on the growth of the hash table so check
+	 * this bucket to make sure it is within the specified bounds. */
 	list_add_rcu(&node->list, &sel_netnode_hash[idx].list);
 	if (sel_netnode_hash[idx].size == SEL_NETNODE_HASH_BKT_LIMIT) {
 		struct sel_netnode *tail;
@@ -252,8 +252,8 @@ out:
 	spin_unlock_bh(&sel_netnode_lock);
 	if (unlikely(ret)) {
 		printk(KERN_WARNING
-		       "SELinux: failure in sel_netnode_sid_slow(),"
-		       " unable to determine network node label\n");
+		       "SELinux: Failure in sel_netnode_sid_slow(),"
+		       " unable to determine network node label.\n");
 		kfree(new);
 	}
 	return ret;
-- 
1.6.3.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
