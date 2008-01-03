Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m03Hci4A012939
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 12:38:44 -0500
Received: from g4t0015.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m03HchjV029849
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 17:38:43 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v10 09/20] SELinux: Convert the netif code to use ifindex
	values
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Thu, 03 Jan 2008 12:38:38 -0500
Message-ID: <20080103173838.15387.60882.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20080103173225.15387.60940.stgit@flek.americas.hpqcorp.net>
References: <20080103173225.15387.60940.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The current SELinux netif code requires the caller have a valid net_device
struct pointer to lookup network interface information.  However, we don't
always have a valid net_device pointer so convert the netif code to use
the ifindex values we always have as part of the sk_buff.  This patch also
removes the default message SID from the network interface record, it is
not being used and therefore is "dead code".

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 security/selinux/hooks.c            |    4 -
 security/selinux/include/netif.h    |    4 -
 security/selinux/include/objsec.h   |    5 -
 security/selinux/include/security.h |    3 
 security/selinux/netif.c            |  254 ++++++++++++++++++++---------------
 security/selinux/ss/services.c      |   10 -
 6 files changed, 155 insertions(+), 125 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7b99d52..8336c93 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3616,7 +3616,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 	if (!skb->dev)
 		goto out;
 
-	err = sel_netif_sids(skb->dev, &if_sid, NULL);
+	err = sel_netif_sid(skb->iif, &if_sid);
 	if (err)
 		goto out;
 
@@ -3941,7 +3941,7 @@ static int selinux_ip_postroute_last_compat(struct sock *sk, struct net_device *
 
 	isec = inode->i_security;
 	
-	err = sel_netif_sids(dev, &if_sid, NULL);
+	err = sel_netif_sid(dev->ifindex, &if_sid);
 	if (err)
 		goto out;
 
diff --git a/security/selinux/include/netif.h b/security/selinux/include/netif.h
index 8bd6f99..ce23edd 100644
--- a/security/selinux/include/netif.h
+++ b/security/selinux/include/netif.h
@@ -7,6 +7,8 @@
  * Author: James Morris <jmorris@redhat.com>
  *
  * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ * Copyright (C) 2007 Hewlett-Packard Development Company, L.P.
+ *                    Paul Moore, <paul.moore@hp.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2,
@@ -15,7 +17,7 @@
 #ifndef _SELINUX_NETIF_H_
 #define _SELINUX_NETIF_H_
 
-int sel_netif_sids(struct net_device *dev, u32 *if_sid, u32 *msg_sid);
+int sel_netif_sid(int ifindex, u32 *sid);
 
 #endif	/* _SELINUX_NETIF_H_ */
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 642a9fd..e41a2aa 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -95,9 +95,8 @@ struct bprm_security_struct {
 };
 
 struct netif_security_struct {
-	struct net_device *dev;		/* back pointer */
-	u32 if_sid;			/* SID for this interface */
-	u32 msg_sid;			/* default SID for messages received on this interface */
+	int ifindex;			/* device index */
+	u32 sid;			/* SID for this interface */
 };
 
 struct sk_security_struct {
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 39337af..a33437b 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -77,8 +77,7 @@ int security_get_user_sids(u32 callsid, char *username,
 int security_port_sid(u16 domain, u16 type, u8 protocol, u16 port,
 	u32 *out_sid);
 
-int security_netif_sid(char *name, u32 *if_sid,
-	u32 *msg_sid);
+int security_netif_sid(char *name, u32 *if_sid);
 
 int security_node_sid(u16 domain, void *addr, u32 addrlen,
 	u32 *out_sid);
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index e87ab94..ee49a73 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -7,6 +7,8 @@
  * Author: James Morris <jmorris@redhat.com>
  *
  * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ * Copyright (C) 2007 Hewlett-Packard Development Company, L.P.
+ *                    Paul Moore <paul.moore@hp.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2,
@@ -29,14 +31,6 @@
 #define SEL_NETIF_HASH_SIZE	64
 #define SEL_NETIF_HASH_MAX	1024
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DEBUGP printk
-#else
-#define DEBUGP(format, args...)
-#endif
-
 struct sel_netif
 {
 	struct list_head list;
@@ -49,174 +43,217 @@ static LIST_HEAD(sel_netif_list);
 static DEFINE_SPINLOCK(sel_netif_lock);
 static struct list_head sel_netif_hash[SEL_NETIF_HASH_SIZE];
 
-static inline u32 sel_netif_hasfn(struct net_device *dev)
+/**
+ * sel_netif_hashfn - Hashing function for the interface table
+ * @ifindex: the network interface
+ *
+ * Description:
+ * This is the hashing function for the network interface table, it returns the
+ * bucket number for the given interface.
+ *
+ */
+static inline u32 sel_netif_hashfn(int ifindex)
 {
-	return (dev->ifindex & (SEL_NETIF_HASH_SIZE - 1));
+	return (ifindex & (SEL_NETIF_HASH_SIZE - 1));
 }
 
-/*
- * All of the devices should normally fit in the hash, so we optimize
- * for that case.
+/**
+ * sel_netif_find - Search for an interface record
+ * @ifindex: the network interface
+ *
+ * Description:
+ * Search the network interface table and return the record matching @ifindex.
+ * If an entry can not be found in the table return NULL.
+ *
  */
-static inline struct sel_netif *sel_netif_find(struct net_device *dev)
+static inline struct sel_netif *sel_netif_find(int ifindex)
 {
-	struct list_head *pos;
-	int idx = sel_netif_hasfn(dev);
+	int idx = sel_netif_hashfn(ifindex);
+	struct sel_netif *netif;
 
-	__list_for_each_rcu(pos, &sel_netif_hash[idx]) {
-		struct sel_netif *netif = list_entry(pos,
-		                                     struct sel_netif, list);
-		if (likely(netif->nsec.dev == dev))
+	list_for_each_entry_rcu(netif, &sel_netif_hash[idx], list)
+		/* all of the devices should normally fit in the hash, so we
+		 * optimize for that case */
+		if (likely(netif->nsec.ifindex == ifindex))
 			return netif;
-	}
+
 	return NULL;
 }
 
+/**
+ * sel_netif_insert - Insert a new interface into the table
+ * @netif: the new interface record
+ *
+ * Description:
+ * Add a new interface record to the network interface hash table.  Returns
+ * zero on success, negative values on failure.
+ *
+ */
 static int sel_netif_insert(struct sel_netif *netif)
 {
-	int idx, ret = 0;
+	int idx;
 	
-	if (sel_netif_total >= SEL_NETIF_HASH_MAX) {
-		ret = -ENOSPC;
-		goto out;
-	}
+	if (sel_netif_total >= SEL_NETIF_HASH_MAX)
+		return -ENOSPC;
 	
-	idx = sel_netif_hasfn(netif->nsec.dev);
+	idx = sel_netif_hashfn(netif->nsec.ifindex);
 	list_add_rcu(&netif->list, &sel_netif_hash[idx]);
 	sel_netif_total++;
-out:
-	return ret;
+
+	return 0;
 }
 
+/**
+ * sel_netif_free - Frees an interface entry
+ * @p: the entry's RCU field
+ *
+ * Description:
+ * This function is designed to be used as a callback to the call_rcu()
+ * function so that memory allocated to a hash table interface entry can be
+ * released safely.
+ *
+ */
 static void sel_netif_free(struct rcu_head *p)
 {
 	struct sel_netif *netif = container_of(p, struct sel_netif, rcu_head);
-
-	DEBUGP("%s: %s\n", __FUNCTION__, netif->nsec.dev->name);
 	kfree(netif);
 }
 
+/**
+ * sel_netif_destroy - Remove an interface record from the table
+ * @netif: the existing interface record
+ *
+ * Description:
+ * Remove an existing interface record from the network interface table.
+ *
+ */
 static void sel_netif_destroy(struct sel_netif *netif)
 {
-	DEBUGP("%s: %s\n", __FUNCTION__, netif->nsec.dev->name);
-
 	list_del_rcu(&netif->list);
 	sel_netif_total--;
 	call_rcu(&netif->rcu_head, sel_netif_free);
 }
 
-static struct sel_netif *sel_netif_lookup(struct net_device *dev)
+/**
+ * sel_netif_sid_slow - Lookup the SID of a network interface using the policy
+ * @ifindex: the network interface
+ * @sid: interface SID
+ *
+ * Description:
+ * This function determines the SID of a network interface by quering the
+ * security policy.  The result is added to the network interface table to
+ * speedup future queries.  Returns zero on success, negative values on
+ * failure.
+ *
+ */
+static int sel_netif_sid_slow(int ifindex, u32 *sid)
 {
 	int ret;
-	struct sel_netif *netif, *new;
-	struct netif_security_struct *nsec;
+	struct sel_netif *netif;
+	struct sel_netif *new = NULL;
+	struct net_device *dev;
 
-	netif = sel_netif_find(dev);
-	if (likely(netif != NULL))
-		goto out;
-	
-	new = kzalloc(sizeof(*new), GFP_ATOMIC);
-	if (!new) {
-		netif = ERR_PTR(-ENOMEM);
-		goto out;
-	}
-	
-	nsec = &new->nsec;
+	/* NOTE: we always use init's network namespace since we don't
+	 * currently support containers */
 
-	ret = security_netif_sid(dev->name, &nsec->if_sid, &nsec->msg_sid);
-	if (ret < 0) {
-		kfree(new);
-		netif = ERR_PTR(ret);
-		goto out;
-	}
+	dev = dev_get_by_index(&init_net, ifindex);
+	if (dev == NULL)
+		return -ENOENT;
 
-	nsec->dev = dev;
-	
 	spin_lock_bh(&sel_netif_lock);
-	
-	netif = sel_netif_find(dev);
-	if (netif) {
-		spin_unlock_bh(&sel_netif_lock);
-		kfree(new);
+	netif = sel_netif_find(ifindex);
+	if (netif != NULL) {
+		*sid = netif->nsec.sid;
+		ret = 0;
 		goto out;
 	}
-	
-	ret = sel_netif_insert(new);
-	spin_unlock_bh(&sel_netif_lock);
-	
-	if (ret) {
-		kfree(new);
-		netif = ERR_PTR(ret);
+	new = kzalloc(sizeof(*new), GFP_ATOMIC);
+	if (new == NULL) {
+		ret = -ENOMEM;
 		goto out;
 	}
+	ret = security_netif_sid(dev->name, &new->nsec.sid);
+	if (ret != 0)
+		goto out;
+	new->nsec.ifindex = ifindex;
+	ret = sel_netif_insert(new);
+	if (ret != 0)
+		goto out;
+	*sid = new->nsec.sid;
 
-	netif = new;
-	
-	DEBUGP("new: ifindex=%u name=%s if_sid=%u msg_sid=%u\n", dev->ifindex, dev->name,
-	        nsec->if_sid, nsec->msg_sid);
 out:
-	return netif;
-}
-
-static void sel_netif_assign_sids(u32 if_sid_in, u32 msg_sid_in, u32 *if_sid_out, u32 *msg_sid_out)
-{
-	if (if_sid_out)
-		*if_sid_out = if_sid_in;
-	if (msg_sid_out)
-		*msg_sid_out = msg_sid_in;
-}
-
-static int sel_netif_sids_slow(struct net_device *dev, u32 *if_sid, u32 *msg_sid)
-{
-	int ret = 0;
-	u32 tmp_if_sid, tmp_msg_sid;
-	
-	ret = security_netif_sid(dev->name, &tmp_if_sid, &tmp_msg_sid);
-	if (!ret)
-		sel_netif_assign_sids(tmp_if_sid, tmp_msg_sid, if_sid, msg_sid);
+	spin_unlock_bh(&sel_netif_lock);
+	dev_put(dev);
+	if (ret != 0)
+		kfree(new);
 	return ret;
 }
 
-int sel_netif_sids(struct net_device *dev, u32 *if_sid, u32 *msg_sid)
+/**
+ * sel_netif_sid - Lookup the SID of a network interface
+ * @ifindex: the network interface
+ * @sid: interface SID
+ *
+ * Description:
+ * This function determines the SID of a network interface using the fastest
+ * method possible.  First the interface table is queried, but if an entry
+ * can't be found then the policy is queried and the result is added to the
+ * table to speedup future queries.  Returns zero on success, negative values
+ * on failure.
+ *
+ */
+int sel_netif_sid(int ifindex, u32 *sid)
 {
-	int ret = 0;
 	struct sel_netif *netif;
 
 	rcu_read_lock();
-	netif = sel_netif_lookup(dev);
-	if (IS_ERR(netif)) {
+	netif = sel_netif_find(ifindex);
+	if (likely(netif != NULL)) {
+		*sid = netif->nsec.sid;
 		rcu_read_unlock();
-		ret = sel_netif_sids_slow(dev, if_sid, msg_sid);
-		goto out;
+		return 0;
 	}
-	sel_netif_assign_sids(netif->nsec.if_sid, netif->nsec.msg_sid, if_sid, msg_sid);
 	rcu_read_unlock();
-out:
-	return ret;
+
+	return sel_netif_sid_slow(ifindex, sid);
 }
 
-static void sel_netif_kill(struct net_device *dev)
+/**
+ * sel_netif_kill - Remove an entry from the network interface table
+ * @ifindex: the network interface
+ *
+ * Description:
+ * This function removes the entry matching @ifindex from the network interface
+ * table if it exists.
+ *
+ */
+static void sel_netif_kill(int ifindex)
 {
 	struct sel_netif *netif;
 
 	spin_lock_bh(&sel_netif_lock);
-	netif = sel_netif_find(dev);
+	netif = sel_netif_find(ifindex);
 	if (netif)
 		sel_netif_destroy(netif);
 	spin_unlock_bh(&sel_netif_lock);
 }
 
+/**
+ * sel_netif_flush - Flush the entire network interface table
+ *
+ * Description:
+ * Remove all entries from the network interface table.
+ *
+ */
 static void sel_netif_flush(void)
 {
 	int idx;
+	struct sel_netif *netif;
 
 	spin_lock_bh(&sel_netif_lock);
-	for (idx = 0; idx < SEL_NETIF_HASH_SIZE; idx++) {
-		struct sel_netif *netif;
-		
+	for (idx = 0; idx < SEL_NETIF_HASH_SIZE; idx++)
 		list_for_each_entry(netif, &sel_netif_hash[idx], list)
 			sel_netif_destroy(netif);
-	}
 	spin_unlock_bh(&sel_netif_lock);
 }
 
@@ -239,7 +276,7 @@ static int sel_netif_netdev_notifier_handler(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	if (event == NETDEV_DOWN)
-		sel_netif_kill(dev);
+		sel_netif_kill(dev->ifindex);
 
 	return NOTIFY_DONE;
 }
@@ -250,10 +287,10 @@ static struct notifier_block sel_netif_netdev_notifier = {
 
 static __init int sel_netif_init(void)
 {
-	int i, err = 0;
+	int i, err;
 	
 	if (!selinux_enabled)
-		goto out;
+		return 0;
 
 	for (i = 0; i < SEL_NETIF_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&sel_netif_hash[i]);
@@ -265,7 +302,6 @@ static __init int sel_netif_init(void)
 	if (err)
 		panic("avc_add_callback() failed, error %d\n", err);
 
-out:
 	return err;
 }
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 88fcd57..d4cc878 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1478,11 +1478,8 @@ out:
  * security_netif_sid - Obtain the SID for a network interface.
  * @name: interface name
  * @if_sid: interface SID
- * @msg_sid: default SID for received packets
  */
-int security_netif_sid(char *name,
-		       u32 *if_sid,
-		       u32 *msg_sid)
+int security_netif_sid(char *name, u32 *if_sid)
 {
 	int rc = 0;
 	struct ocontext *c;
@@ -1510,11 +1507,8 @@ int security_netif_sid(char *name,
 				goto out;
 		}
 		*if_sid = c->sid[0];
-		*msg_sid = c->sid[1];
-	} else {
+	} else
 		*if_sid = SECINITSID_NETIF;
-		*msg_sid = SECINITSID_NETMSG;
-	}
 
 out:
 	POLICY_RDUNLOCK;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
