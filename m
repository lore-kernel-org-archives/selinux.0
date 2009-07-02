Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n625WA29013532
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 01:32:10 -0400
Received: from wa-out-1112.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n625VmvX014582
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 05:31:54 GMT
Received: by wa-out-1112.google.com with SMTP id k17so271606waf.18
        for <selinux@tycho.nsa.gov>; Wed, 01 Jul 2009 22:32:09 -0700 (PDT)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: selinux@tycho.nsa.gov, "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 6/8] SELinux netport.c non trivial fixes.
Date: Wed,  1 Jul 2009 22:32:45 -0700
Message-Id: <1246512767-2999-7-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1246512767-2999-1-git-send-email-justinmattock@gmail.com>
References: <1246512767-2999-1-git-send-email-justinmattock@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

Fix some debug comments.
Fix some comments.
---
 security/selinux/netport.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index fe7fba6..61a88b3 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -56,11 +56,11 @@ struct sel_netport {
 	struct rcu_head rcu;
 };
 
-/* NOTE: we are using a combined hash table for both IPv4 and IPv6, the reason
+/* NOTE: We are using a combined hash table for both IPv4 and IPv6, the reason
  * for this is that I suspect most users will not make heavy use of both
  * address families at the same time so one table will usually end up wasted,
  * if this becomes a problem we can always add a hash table for each address
- * family later */
+ * family later. */
 
 static LIST_HEAD(sel_netport_list);
 static DEFINE_SPINLOCK(sel_netport_lock);
@@ -131,8 +131,8 @@ static void sel_netport_insert(struct sel_netport *port)
 {
 	unsigned int idx;
 
-	/* we need to impose a limit on the growth of the hash table so check
-	 * this bucket to make sure it is within the specified bounds */
+	/* We need to impose a limit on the growth of the hash table so check
+	 * this bucket to make sure it is within the specified bounds. */
 	idx = sel_netport_hashfn(port->psec.port);
 	list_add_rcu(&port->list, &sel_netport_hash[idx].list);
 	if (sel_netport_hash[idx].size == SEL_NETPORT_HASH_BKT_LIMIT) {
@@ -187,8 +187,8 @@ out:
 	spin_unlock_bh(&sel_netport_lock);
 	if (unlikely(ret)) {
 		printk(KERN_WARNING
-		       "SELinux: failure in sel_netport_sid_slow(),"
-		       " unable to determine network port label\n");
+		       "SELinux: Failure in sel_netport_sid_slow(),"
+		       " unable to determine network port label.\n");
 		kfree(new);
 	}
 	return ret;
-- 
1.6.3.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
