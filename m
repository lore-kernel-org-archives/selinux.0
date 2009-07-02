Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n625W1Rw013476
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 01:32:01 -0400
Received: from mail-px0-f202.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n625VYvZ014527
	for <selinux@tycho.nsa.gov>; Thu, 2 Jul 2009 05:31:44 GMT
Received: by mail-px0-f202.google.com with SMTP id 40so129340pxi.32
        for <selinux@tycho.nsa.gov>; Wed, 01 Jul 2009 22:32:00 -0700 (PDT)
From: "Justin P. Mattock" <justinmattock@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: selinux@tycho.nsa.gov, "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 3/8] SELinux netif.c non trivial fixes.
Date: Wed,  1 Jul 2009 22:32:42 -0700
Message-Id: <1246512767-2999-4-git-send-email-justinmattock@gmail.com>
In-Reply-To: <1246512767-2999-1-git-send-email-justinmattock@gmail.com>
References: <1246512767-2999-1-git-send-email-justinmattock@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

Fix some comments.
---
 security/selinux/netif.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index b4e14bc..dc6dc37 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -71,8 +71,8 @@ static inline struct sel_netif *sel_netif_find(int ifindex)
 	struct sel_netif *netif;
 
 	list_for_each_entry_rcu(netif, &sel_netif_hash[idx], list)
-		/* all of the devices should normally fit in the hash, so we
-		 * optimize for that case */
+		/* All of the devices should normally fit in the hash, so we
+		 * optimize for that case. */
 		if (likely(netif->nsec.ifindex == ifindex))
 			return netif;
 
@@ -152,13 +152,13 @@ static int sel_netif_sid_slow(int ifindex, u32 *sid)
 	struct sel_netif *new = NULL;
 	struct net_device *dev;
 
-	/* NOTE: we always use init's network namespace since we don't
-	 * currently support containers */
+	/* NOTE: We always use init's network namespace since we don't
+	 * currently support containers. */
 
 	dev = dev_get_by_index(&init_net, ifindex);
 	if (unlikely(dev == NULL)) {
 		printk(KERN_WARNING
-		       "SELinux: failure in sel_netif_sid_slow(),"
+		       "SELinux: Failure in sel_netif_sid_slow(),"
 		       " invalid network interface (%d)\n", ifindex);
 		return -ENOENT;
 	}
@@ -189,7 +189,7 @@ out:
 	dev_put(dev);
 	if (unlikely(ret)) {
 		printk(KERN_WARNING
-		       "SELinux: failure in sel_netif_sid_slow(),"
+		       "SELinux: Failure in sel_netif_sid_slow(),"
 		       " unable to determine network interface label (%d)\n",
 		       ifindex);
 		kfree(new);
-- 
1.6.3.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
