Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3DLblDo002057
 for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2016 17:37:48 -0400
Subject: [RFC PATCH] selinux: always return a value from the
 netport/netnode/netif caches
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 13 Apr 2016 17:37:42 -0400
Message-ID: <146058346288.11989.9543589385643222847.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

Even if we are under memory pressure and can't allocate a new cache
node we can still return the port/node/iface value we looked up from
the policy.

Reported-by: Greg <gkubok@gmail.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/netif.c   |   35 +++++++++++++----------------------
 security/selinux/netnode.c |   31 +++++++++++++++++--------------
 security/selinux/netport.c |   19 ++++++++-----------
 3 files changed, 38 insertions(+), 47 deletions(-)

diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index e607b44..5c3bfa4 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -91,18 +91,16 @@ static inline struct sel_netif *sel_netif_find(const struct net *ns,
  * zero on success, negative values on failure.
  *
  */
-static int sel_netif_insert(struct sel_netif *netif)
+static void sel_netif_insert(struct sel_netif *netif)
 {
 	int idx;
 
 	if (sel_netif_total >= SEL_NETIF_HASH_MAX)
-		return -ENOSPC;
+		return;
 
 	idx = sel_netif_hashfn(netif->nsec.ns, netif->nsec.ifindex);
 	list_add_rcu(&netif->list, &sel_netif_hash[idx]);
 	sel_netif_total++;
-
-	return 0;
 }
 
 /**
@@ -135,7 +133,7 @@ static void sel_netif_destroy(struct sel_netif *netif)
  */
 static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 {
-	int ret;
+	int ret = 0;
 	struct sel_netif *netif;
 	struct sel_netif *new = NULL;
 	struct net_device *dev;
@@ -155,34 +153,27 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 	netif = sel_netif_find(ns, ifindex);
 	if (netif != NULL) {
 		*sid = netif->nsec.sid;
-		ret = 0;
 		goto out;
 	}
-	new = kzalloc(sizeof(*new), GFP_ATOMIC);
-	if (new == NULL) {
-		ret = -ENOMEM;
+	ret = security_netif_sid(dev->name, sid);
+	if (ret != 0) {
+		printk(KERN_WARNING
+		       "SELinux: failure in sel_netif_sid_slow(),"
+		       " unable to determine network interface label (%d)\n",
+		       ifindex);
 		goto out;
 	}
-	ret = security_netif_sid(dev->name, &new->nsec.sid);
-	if (ret != 0)
+	new = kzalloc(sizeof(*new), GFP_ATOMIC);
+	if (new == NULL)
 		goto out;
 	new->nsec.ns = ns;
 	new->nsec.ifindex = ifindex;
-	ret = sel_netif_insert(new);
-	if (ret != 0)
-		goto out;
-	*sid = new->nsec.sid;
+	new->nsec.sid = *sid;
+	sel_netif_insert(new);
 
 out:
 	spin_unlock_bh(&sel_netif_lock);
 	dev_put(dev);
-	if (unlikely(ret)) {
-		printk(KERN_WARNING
-		       "SELinux: failure in sel_netif_sid_slow(),"
-		       " unable to determine network interface label (%d)\n",
-		       ifindex);
-		kfree(new);
-	}
 	return ret;
 }
 
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index da923f8..b752bd2 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -199,7 +199,7 @@ static void sel_netnode_insert(struct sel_netnode *node)
  */
 static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 {
-	int ret = -ENOMEM;
+	int ret;
 	struct sel_netnode *node;
 	struct sel_netnode *new = NULL;
 
@@ -210,39 +210,42 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 		spin_unlock_bh(&sel_netnode_lock);
 		return 0;
 	}
-	new = kzalloc(sizeof(*new), GFP_ATOMIC);
-	if (new == NULL)
-		goto out;
 	switch (family) {
 	case PF_INET:
 		ret = security_node_sid(PF_INET,
 					addr, sizeof(struct in_addr), sid);
-		new->nsec.addr.ipv4 = *(__be32 *)addr;
 		break;
 	case PF_INET6:
 		ret = security_node_sid(PF_INET6,
 					addr, sizeof(struct in6_addr), sid);
-		new->nsec.addr.ipv6 = *(struct in6_addr *)addr;
 		break;
 	default:
 		BUG();
 		ret = -EINVAL;
 	}
-	if (ret != 0)
+	if (ret != 0) {
+		printk(KERN_WARNING
+		       "SELinux: failure in sel_netnode_sid_slow(),"
+		       " unable to determine network node label\n");
 		goto out;
-
+	}
+	new = kzalloc(sizeof(*new), GFP_ATOMIC);
+	if (new == NULL)
+		goto out;
+	switch (family) {
+	case PF_INET:
+		new->nsec.addr.ipv4 = *(__be32 *)addr;
+		break;
+	case PF_INET6:
+		new->nsec.addr.ipv6 = *(struct in6_addr *)addr;
+		break;
+	}
 	new->nsec.family = family;
 	new->nsec.sid = *sid;
 	sel_netnode_insert(new);
 
 out:
 	spin_unlock_bh(&sel_netnode_lock);
-	if (unlikely(ret)) {
-		printk(KERN_WARNING
-		       "SELinux: failure in sel_netnode_sid_slow(),"
-		       " unable to determine network node label\n");
-		kfree(new);
-	}
 	return ret;
 }
 
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 3311cc3..189c293 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -147,7 +147,7 @@ static void sel_netport_insert(struct sel_netport *port)
  */
 static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
 {
-	int ret = -ENOMEM;
+	int ret;
 	struct sel_netport *port;
 	struct sel_netport *new = NULL;
 
@@ -158,13 +158,16 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
 		spin_unlock_bh(&sel_netport_lock);
 		return 0;
 	}
+	ret = security_port_sid(protocol, pnum, sid);
+	if (ret != 0) {
+		printk(KERN_WARNING
+		       "SELinux: failure in sel_netport_sid_slow(),"
+		       " unable to determine network port label\n");
+		goto out;
+	}
 	new = kzalloc(sizeof(*new), GFP_ATOMIC);
 	if (new == NULL)
 		goto out;
-	ret = security_port_sid(protocol, pnum, sid);
-	if (ret != 0)
-		goto out;
-
 	new->psec.port = pnum;
 	new->psec.protocol = protocol;
 	new->psec.sid = *sid;
@@ -172,12 +175,6 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
 
 out:
 	spin_unlock_bh(&sel_netport_lock);
-	if (unlikely(ret)) {
-		printk(KERN_WARNING
-		       "SELinux: failure in sel_netport_sid_slow(),"
-		       " unable to determine network port label\n");
-		kfree(new);
-	}
 	return ret;
 }
 
