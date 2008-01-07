Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m07HttHe030224
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 12:55:55 -0500
Received: from g1t0026.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m07Htqfn028083
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 17:55:52 GMT
Received: from g1t0026.austin.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 19201C306
	for <selinux@tycho.nsa.gov>; Mon,  7 Jan 2008 17:55:52 +0000 (UTC)
Received: from smtp1.fc.hp.com (smtp.cnd.hp.com [15.15.136.127])
	by g1t0026.austin.hp.com (Postfix) with ESMTP id E19D0C10D
	for <selinux@tycho.nsa.gov>; Mon,  7 Jan 2008 17:55:51 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v11 10/19] SELinux: Add a network node caching mechanism
	similar to the sel_netif_*() functions
To: selinux@tycho.nsa.gov
Date: Mon, 07 Jan 2008 12:55:45 -0500
Message-ID: <20080107175545.13733.92810.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20080107174952.13733.68074.stgit@flek.americas.hpqcorp.net>
References: <20080107174952.13733.68074.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds a SELinux IP address/node SID caching mechanism similar to the
sel_netif_*() functions.  The node SID queries in the SELinux hooks files are
also modified to take advantage of this new functionality.  In addition, remove
the address length information from the sk_buff parsing routines as it is
redundant since we already have the address family.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 security/selinux/Makefile          |    9 +
 security/selinux/hooks.c           |   33 ++-
 security/selinux/include/netnode.h |   32 +++
 security/selinux/include/objsec.h  |    9 +
 security/selinux/netnode.c         |  350 ++++++++++++++++++++++++++++++++++++
 5 files changed, 416 insertions(+), 17 deletions(-)

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index dc3502e..00afd85 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -4,7 +4,14 @@
 
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o ss/
 
-selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o exports.o
+selinux-y := avc.o \
+	     hooks.o \
+	     selinuxfs.o \
+	     netlink.o \
+	     nlmsgtab.o \
+	     netif.o \
+	     netnode.o \
+	     exports.o
 
 selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b451b4c..4250642 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -76,6 +76,7 @@
 #include "avc.h"
 #include "objsec.h"
 #include "netif.h"
+#include "netnode.h"
 #include "xfrm.h"
 #include "netlabel.h"
 
@@ -3158,7 +3159,7 @@ out:
 #endif /* IPV6 */
 
 static int selinux_parse_skb(struct sk_buff *skb, struct avc_audit_data *ad,
-			     char **addrp, int *len, int src, u8 *proto)
+			     char **addrp, int src, u8 *proto)
 {
 	int ret = 0;
 
@@ -3167,7 +3168,6 @@ static int selinux_parse_skb(struct sk_buff *skb, struct avc_audit_data *ad,
 		ret = selinux_parse_skb_ipv4(skb, ad, proto);
 		if (ret || !addrp)
 			break;
-		*len = 4;
 		*addrp = (char *)(src ? &ad->u.net.v4info.saddr :
 					&ad->u.net.v4info.daddr);
 		break;
@@ -3177,7 +3177,6 @@ static int selinux_parse_skb(struct sk_buff *skb, struct avc_audit_data *ad,
 		ret = selinux_parse_skb_ipv6(skb, ad, proto);
 		if (ret || !addrp)
 			break;
-		*len = 16;
 		*addrp = (char *)(src ? &ad->u.net.v6info.saddr :
 					&ad->u.net.v6info.daddr);
 		break;
@@ -3377,7 +3376,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 			break;
 		}
 		
-		err = security_node_sid(family, addrp, addrlen, &sid);
+		err = sel_netnode_sid(addrp, family, &sid);
 		if (err)
 			goto out;
 		
@@ -3589,7 +3588,8 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 }
 
 static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
-		struct avc_audit_data *ad, u16 family, char *addrp, int len)
+				       struct avc_audit_data *ad,
+				       u16 family, char *addrp)
 {
 	int err = 0;
 	u32 netif_perm, node_perm, node_sid, if_sid, recv_perm = 0;
@@ -3649,7 +3649,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 	if (err)
 		goto out;
 	
-	err = security_node_sid(family, addrp, len, &node_sid);
+	err = sel_netnode_sid(addrp, family, &node_sid);
 	if (err)
 		goto out;
 	
@@ -3678,7 +3678,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	u16 family;
 	char *addrp;
-	int len, err = 0;
+	int err = 0;
 	struct avc_audit_data ad;
 	struct sk_security_struct *sksec = sk->sk_security;
 
@@ -3694,13 +3694,12 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	ad.u.net.netif = skb->iif;
 	ad.u.net.family = family;
 
-	err = selinux_parse_skb(skb, &ad, &addrp, &len, 1, NULL);
+	err = selinux_parse_skb(skb, &ad, &addrp, 1, NULL);
 	if (err)
 		goto out;
 
 	if (selinux_compat_net)
-		err = selinux_sock_rcv_skb_compat(sk, skb, &ad, family,
-						  addrp, len);
+		err = selinux_sock_rcv_skb_compat(sk, skb, &ad, family, addrp);
 	else
 		err = avc_has_perm(sksec->sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__RECV, &ad);
@@ -3921,9 +3920,11 @@ out:
 
 #ifdef CONFIG_NETFILTER
 
-static int selinux_ip_postroute_last_compat(struct sock *sk, struct net_device *dev,
+static int selinux_ip_postroute_last_compat(struct sock *sk,
+					    struct net_device *dev,
 					    struct avc_audit_data *ad,
-					    u16 family, char *addrp, int len)
+					    u16 family,
+					    char *addrp)
 {
 	int err = 0;
 	u32 netif_perm, node_perm, node_sid, if_sid, send_perm = 0;
@@ -3974,7 +3975,7 @@ static int selinux_ip_postroute_last_compat(struct sock *sk, struct net_device *
 	if (err)
 		goto out;
 		
-	err = security_node_sid(family, addrp, len, &node_sid);
+	err = sel_netnode_sid(addrp, family, &node_sid);
 	if (err)
 		goto out;
 	
@@ -4008,7 +4009,7 @@ static unsigned int selinux_ip_postroute_last(unsigned int hooknum,
                                               u16 family)
 {
 	char *addrp;
-	int len, err = 0;
+	int err = 0;
 	struct sock *sk;
 	struct avc_audit_data ad;
 	struct net_device *dev = (struct net_device *)out;
@@ -4025,13 +4026,13 @@ static unsigned int selinux_ip_postroute_last(unsigned int hooknum,
 	ad.u.net.netif = dev->ifindex;
 	ad.u.net.family = family;
 
-	err = selinux_parse_skb(skb, &ad, &addrp, &len, 0, &proto);
+	err = selinux_parse_skb(skb, &ad, &addrp, 0, &proto);
 	if (err)
 		goto out;
 
 	if (selinux_compat_net)
 		err = selinux_ip_postroute_last_compat(sk, dev, &ad,
-						       family, addrp, len);
+						       family, addrp);
 	else
 		err = avc_has_perm(sksec->sid, skb->secmark, SECCLASS_PACKET,
 				   PACKET__SEND, &ad);
diff --git a/security/selinux/include/netnode.h b/security/selinux/include/netnode.h
new file mode 100644
index 0000000..1b94450
--- /dev/null
+++ b/security/selinux/include/netnode.h
@@ -0,0 +1,32 @@
+/*
+ * Network node table
+ *
+ * SELinux must keep a mapping of network nodes to labels/SIDs.  This
+ * mapping is maintained as part of the normal policy but a fast cache is
+ * needed to reduce the lookup overhead since most of these queries happen on
+ * a per-packet basis.
+ *
+ * Author: Paul Moore <paul.moore@hp.com>
+ *
+ */
+
+/*
+ * (c) Copyright Hewlett-Packard Development Company, L.P., 2007
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _SELINUX_NETNODE_H
+#define _SELINUX_NETNODE_H
+
+int sel_netnode_sid(void *addr, u16 family, u32 *sid);
+
+#endif
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index e41a2aa..6140734 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -99,6 +99,15 @@ struct netif_security_struct {
 	u32 sid;			/* SID for this interface */
 };
 
+struct netnode_security_struct {
+	union {
+		__be32 ipv4;		/* IPv4 node address */
+		struct in6_addr ipv6;	/* IPv6 node address */
+	} addr;
+	u32 sid;			/* SID for this node */
+	u16 family;			/* address family */
+};
+
 struct sk_security_struct {
 	struct sock *sk;		/* back pointer to sk object */
 	u32 sid;			/* SID of this object */
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
new file mode 100644
index 0000000..49c5277
--- /dev/null
+++ b/security/selinux/netnode.c
@@ -0,0 +1,350 @@
+/*
+ * Network node table
+ *
+ * SELinux must keep a mapping of network nodes to labels/SIDs.  This
+ * mapping is maintained as part of the normal policy but a fast cache is
+ * needed to reduce the lookup overhead since most of these queries happen on
+ * a per-packet basis.
+ *
+ * Author: Paul Moore <paul.moore@hp.com>
+ *
+ * This code is heavily based on the "netif" concept originally developed by
+ * James Morris <jmorris@redhat.com>
+ *   (see security/selinux/netif.c for more information)
+ *
+ */
+
+/*
+ * (c) Copyright Hewlett-Packard Development Company, L.P., 2007
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/rcupdate.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <asm/bug.h>
+
+#include "objsec.h"
+
+#define SEL_NETNODE_HASH_SIZE       256
+#define SEL_NETNODE_HASH_BKT_LIMIT   16
+
+struct sel_netnode {
+	struct netnode_security_struct nsec;
+
+	struct list_head list;
+	struct rcu_head rcu;
+};
+
+/* NOTE: we are using a combined hash table for both IPv4 and IPv6, the reason
+ * for this is that I suspect most users will not make heavy use of both
+ * address families at the same time so one table will usually end up wasted,
+ * if this becomes a problem we can always add a hash table for each address
+ * family later */
+
+static LIST_HEAD(sel_netnode_list);
+static DEFINE_SPINLOCK(sel_netnode_lock);
+static struct list_head sel_netnode_hash[SEL_NETNODE_HASH_SIZE];
+
+/**
+ * sel_netnode_free - Frees a node entry
+ * @p: the entry's RCU field
+ *
+ * Description:
+ * This function is designed to be used as a callback to the call_rcu()
+ * function so that memory allocated to a hash table node entry can be
+ * released safely.
+ *
+ */
+static void sel_netnode_free(struct rcu_head *p)
+{
+	struct sel_netnode *node = container_of(p, struct sel_netnode, rcu);
+	kfree(node);
+}
+
+/**
+ * sel_netnode_hashfn_ipv4 - IPv4 hashing function for the node table
+ * @addr: IPv4 address
+ *
+ * Description:
+ * This is the IPv4 hashing function for the node interface table, it returns
+ * the bucket number for the given IP address.
+ *
+ */
+static u32 sel_netnode_hashfn_ipv4(__be32 addr)
+{
+	/* at some point we should determine if the mismatch in byte order
+	 * affects the hash function dramatically */
+	return (addr & (SEL_NETNODE_HASH_SIZE - 1));
+}
+
+/**
+ * sel_netnode_hashfn_ipv6 - IPv6 hashing function for the node table
+ * @addr: IPv6 address
+ *
+ * Description:
+ * This is the IPv6 hashing function for the node interface table, it returns
+ * the bucket number for the given IP address.
+ *
+ */
+static u32 sel_netnode_hashfn_ipv6(const struct in6_addr *addr)
+{
+	/* just hash the least significant 32 bits to keep things fast (they
+	 * are the most likely to be different anyway), we can revisit this
+	 * later if needed */
+	return (addr->s6_addr32[3] & (SEL_NETNODE_HASH_SIZE - 1));
+}
+
+/**
+ * sel_netnode_find - Search for a node record
+ * @addr: IP address
+ * @family: address family
+ *
+ * Description:
+ * Search the network node table and return the record matching @addr.  If an
+ * entry can not be found in the table return NULL.
+ *
+ */
+static struct sel_netnode *sel_netnode_find(const void *addr, u16 family)
+{
+	u32 idx;
+	struct sel_netnode *node;
+
+	switch (family) {
+	case PF_INET:
+		idx = sel_netnode_hashfn_ipv4(*(__be32 *)addr);
+		break;
+	case PF_INET6:
+		idx = sel_netnode_hashfn_ipv6(addr);
+		break;
+	default:
+		BUG();
+	}
+
+	list_for_each_entry_rcu(node, &sel_netnode_hash[idx], list)
+		if (node->nsec.family == family)
+			switch (family) {
+			case PF_INET:
+				if (node->nsec.addr.ipv4 == *(__be32 *)addr)
+					return node;
+				break;
+			case PF_INET6:
+				if (ipv6_addr_equal(&node->nsec.addr.ipv6,
+						    addr))
+					return node;
+				break;
+			}
+
+	return NULL;
+}
+
+/**
+ * sel_netnode_insert - Insert a new node into the table
+ * @node: the new node record
+ *
+ * Description:
+ * Add a new node record to the network address hash table.  Returns zero on
+ * success, negative values on failure.
+ *
+ */
+static int sel_netnode_insert(struct sel_netnode *node)
+{
+	u32 idx;
+	u32 count = 0;
+	struct sel_netnode *iter;
+
+	switch (node->nsec.family) {
+	case PF_INET:
+		idx = sel_netnode_hashfn_ipv4(node->nsec.addr.ipv4);
+		break;
+	case PF_INET6:
+		idx = sel_netnode_hashfn_ipv6(&node->nsec.addr.ipv6);
+		break;
+	default:
+		BUG();
+	}
+	list_add_rcu(&node->list, &sel_netnode_hash[idx]);
+
+	/* we need to impose a limit on the growth of the hash table so check
+	 * this bucket to make sure it is within the specified bounds */
+	list_for_each_entry(iter, &sel_netnode_hash[idx], list)
+		if (++count > SEL_NETNODE_HASH_BKT_LIMIT) {
+			list_del_rcu(&iter->list);
+			call_rcu(&iter->rcu, sel_netnode_free);
+			break;
+		}
+
+	return 0;
+}
+
+/**
+ * sel_netnode_destroy - Remove a node record from the table
+ * @node: the existing node record
+ *
+ * Description:
+ * Remove an existing node record from the network address table.
+ *
+ */
+static void sel_netnode_destroy(struct sel_netnode *node)
+{
+	list_del_rcu(&node->list);
+	call_rcu(&node->rcu, sel_netnode_free);
+}
+
+/**
+ * sel_netnode_sid_slow - Lookup the SID of a network address using the policy
+ * @addr: the IP address
+ * @family: the address family
+ * @sid: node SID
+ *
+ * Description:
+ * This function determines the SID of a network address by quering the
+ * security policy.  The result is added to the network address table to
+ * speedup future queries.  Returns zero on success, negative values on
+ * failure.
+ *
+ */
+static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
+{
+	int ret;
+	struct sel_netnode *node;
+	struct sel_netnode *new = NULL;
+
+	spin_lock_bh(&sel_netnode_lock);
+	node = sel_netnode_find(addr, family);
+	if (node != NULL) {
+		*sid = node->nsec.sid;
+		ret = 0;
+		goto out;
+	}
+	new = kzalloc(sizeof(*new), GFP_ATOMIC);
+	if (new == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	switch (family) {
+	case PF_INET:
+		ret = security_node_sid(PF_INET,
+					addr, sizeof(struct in_addr),
+					&new->nsec.sid);
+		new->nsec.addr.ipv4 = *(__be32 *)addr;
+		break;
+	case PF_INET6:
+		ret = security_node_sid(PF_INET6,
+					addr, sizeof(struct in6_addr),
+					&new->nsec.sid);
+		ipv6_addr_copy(&new->nsec.addr.ipv6, addr);
+		break;
+	default:
+		BUG();
+	}
+	if (ret != 0)
+		goto out;
+	new->nsec.family = family;
+	ret = sel_netnode_insert(new);
+	if (ret != 0)
+		goto out;
+	*sid = new->nsec.sid;
+
+out:
+	spin_unlock_bh(&sel_netnode_lock);
+	if (ret != 0)
+		kfree(new);
+	return ret;
+}
+
+/**
+ * sel_netnode_sid - Lookup the SID of a network address
+ * @addr: the IP address
+ * @family: the address family
+ * @sid: node SID
+ *
+ * Description:
+ * This function determines the SID of a network address using the fastest
+ * method possible.  First the address table is queried, but if an entry
+ * can't be found then the policy is queried and the result is added to the
+ * table to speedup future queries.  Returns zero on success, negative values
+ * on failure.
+ *
+ */
+int sel_netnode_sid(void *addr, u16 family, u32 *sid)
+{
+	struct sel_netnode *node;
+
+	rcu_read_lock();
+	node = sel_netnode_find(addr, family);
+	if (node != NULL) {
+		*sid = node->nsec.sid;
+		rcu_read_unlock();
+		return 0;
+	}
+	rcu_read_unlock();
+
+	return sel_netnode_sid_slow(addr, family, sid);
+}
+
+/**
+ * sel_netnode_flush - Flush the entire network address table
+ *
+ * Description:
+ * Remove all entries from the network address table.
+ *
+ */
+static void sel_netnode_flush(void)
+{
+	u32 idx;
+	struct sel_netnode *node;
+
+	spin_lock_bh(&sel_netnode_lock);
+	for (idx = 0; idx < SEL_NETNODE_HASH_SIZE; idx++)
+		list_for_each_entry(node, &sel_netnode_hash[idx], list)
+			sel_netnode_destroy(node);
+	spin_unlock_bh(&sel_netnode_lock);
+}
+
+static int sel_netnode_avc_callback(u32 event, u32 ssid, u32 tsid,
+				    u16 class, u32 perms, u32 *retained)
+{
+	if (event == AVC_CALLBACK_RESET) {
+		sel_netnode_flush();
+		synchronize_net();
+	}
+	return 0;
+}
+
+static __init int sel_netnode_init(void)
+{
+	int iter;
+	int ret;
+
+	if (!selinux_enabled)
+		return 0;
+
+	for (iter = 0; iter < SEL_NETNODE_HASH_SIZE; iter++)
+		INIT_LIST_HEAD(&sel_netnode_hash[iter]);
+
+	ret = avc_add_callback(sel_netnode_avc_callback, AVC_CALLBACK_RESET,
+	                       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
+	if (ret != 0)
+		panic("avc_add_callback() failed, error %d\n", ret);
+
+	return ret;
+}
+
+__initcall(sel_netnode_init);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
