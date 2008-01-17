Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0HL3PMO019216
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 16:03:25 -0500
Received: from g5t0007.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0HL3Oug021560
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 21:03:24 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v12 15/18] NetLabel: Introduce static network labels for
	unlabeled connections
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Thu, 17 Jan 2008 15:56:59 -0500
Message-ID: <20080117205659.21013.49198.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20080117204653.21013.77930.stgit@flek.americas.hpqcorp.net>
References: <20080117204653.21013.77930.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Most trusted OSs, with the exception of Linux, have the ability to specify
static security labels for unlabeled networks.  This patch adds this ability to
the NetLabel packet labeling framework.

If the NetLabel subsystem is called to determine the security attributes of an
incoming packet it first checks to see if any recognized NetLabel packet
labeling protocols are in-use on the packet.  If none can be found then the
unlabled connection table is queried and based on the packets incoming
interface and address it is matched with a security label as configured by the
administrator using the netlabel_tools package.  The matching security label is
returned to the caller just as if the packet was explicitly labeled using a
labeling protocol.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 include/net/netlabel.h            |    6 
 net/netlabel/netlabel_kapi.c      |   16 
 net/netlabel/netlabel_unlabeled.c | 1375 +++++++++++++++++++++++++++++++++++++
 net/netlabel/netlabel_unlabeled.h |  145 ++++
 4 files changed, 1524 insertions(+), 18 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index a3bffb4..b3213c7 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -67,7 +67,11 @@
  * NetLabel NETLINK protocol
  */
 
-#define NETLBL_PROTO_VERSION            1
+/* NetLabel NETLINK protocol version
+ *  1: initial version
+ *  2: added static labels for unlabeled connections
+ */
+#define NETLBL_PROTO_VERSION            2
 
 /* NetLabel NETLINK types/families */
 #define NETLBL_NLTYPE_NONE              0
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 4914615..c69e3e1 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -312,7 +312,7 @@ socket_setattr_return:
  * @secattr: the security attributes
  *
  * Description:
- * Examines the given sock to see any NetLabel style labeling has been
+ * Examines the given sock to see if any NetLabel style labeling has been
  * applied to the sock, if so it parses the socket label and returns the
  * security attributes in @secattr.  Returns zero on success, negative values
  * on failure.
@@ -320,13 +320,7 @@ socket_setattr_return:
  */
 int netlbl_sock_getattr(struct sock *sk, struct netlbl_lsm_secattr *secattr)
 {
-	int ret_val;
-
-	ret_val = cipso_v4_sock_getattr(sk, secattr);
-	if (ret_val == 0)
-		return 0;
-
-	return netlbl_unlabel_getattr(secattr);
+	return cipso_v4_sock_getattr(sk, secattr);
 }
 
 /**
@@ -350,7 +344,7 @@ int netlbl_skbuff_getattr(const struct sk_buff *skb,
 	    cipso_v4_skbuff_getattr(skb, secattr) == 0)
 		return 0;
 
-	return netlbl_unlabel_getattr(secattr);
+	return netlbl_unlabel_getattr(skb, family, secattr);
 }
 
 /**
@@ -434,6 +428,10 @@ static int __init netlbl_init(void)
 	if (ret_val != 0)
 		goto init_failure;
 
+	ret_val = netlbl_unlabel_init(NETLBL_UNLHSH_BITSIZE);
+	if (ret_val != 0)
+		goto init_failure;
+
 	ret_val = netlbl_netlink_init();
 	if (ret_val != 0)
 		goto init_failure;
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 7f5df0c..d0c628c 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -10,7 +10,7 @@
  */
 
 /*
- * (c) Copyright Hewlett-Packard Development Company, L.P., 2006
+ * (c) Copyright Hewlett-Packard Development Company, L.P., 2006 - 2007
  *
  * This program is free software;  you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -29,27 +29,99 @@
  */
 
 #include <linux/types.h>
+#include <linux/rcupdate.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/socket.h>
 #include <linux/string.h>
 #include <linux/skbuff.h>
 #include <linux/audit.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/notifier.h>
+#include <linux/netdevice.h>
+#include <linux/security.h>
 #include <net/sock.h>
 #include <net/netlink.h>
 #include <net/genetlink.h>
-
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <net/net_namespace.h>
 #include <net/netlabel.h>
 #include <asm/bug.h>
+#include <asm/atomic.h>
 
 #include "netlabel_user.h"
 #include "netlabel_domainhash.h"
 #include "netlabel_unlabeled.h"
+#include "netlabel_mgmt.h"
+
+/* NOTE: at present we always use init's network namespace since we don't
+ *       presently support different namespaces even though the majority of
+ *       the functions in this file are "namespace safe" */
+
+/* The unlabeled connection hash table which we use to map network interfaces
+ * and addresses of unlabeled packets to a user specified secid value for the
+ * LSM.  The hash table is used to lookup the network interface entry
+ * (struct netlbl_unlhsh_iface) and then the interface entry is used to
+ * lookup an IP address match from an ordered list.  If a network interface
+ * match can not be found in the hash table then the default entry
+ * (netlbl_unlhsh_def) is used.  The IP address entry list
+ * (struct netlbl_unlhsh_addr) is ordered such that the entries with a
+ * larger netmask come first.
+ */
+struct netlbl_unlhsh_tbl {
+	struct list_head *tbl;
+	u32 size;
+};
+struct netlbl_unlhsh_addr4 {
+	__be32 addr;
+	__be32 mask;
+	u32 secid;
+
+	u32 valid;
+	struct list_head list;
+	struct rcu_head rcu;
+};
+struct netlbl_unlhsh_addr6 {
+	struct in6_addr addr;
+	struct in6_addr mask;
+	u32 secid;
+
+	u32 valid;
+	struct list_head list;
+	struct rcu_head rcu;
+};
+struct netlbl_unlhsh_iface {
+	int ifindex;
+	struct list_head addr4_list;
+	struct list_head addr6_list;
+
+	u32 valid;
+	struct list_head list;
+	struct rcu_head rcu;
+};
+
+/* Argument struct for netlbl_unlhsh_walk() */
+struct netlbl_unlhsh_walk_arg {
+	struct netlink_callback *nl_cb;
+	struct sk_buff *skb;
+	u32 seq;
+};
+
+/* Unlabeled connection hash table */
+/* updates should be so rare that having one spinlock for the entire
+ * hash table should be okay */
+static DEFINE_SPINLOCK(netlbl_unlhsh_lock);
+static struct netlbl_unlhsh_tbl *netlbl_unlhsh = NULL;
+static struct netlbl_unlhsh_iface *netlbl_unlhsh_def = NULL;
 
 /* Accept unlabeled packets flag */
 static u8 netlabel_unlabel_acceptflg = 0;
 
-/* NetLabel Generic NETLINK CIPSOv4 family */
+/* NetLabel Generic NETLINK unlabeled family */
 static struct genl_family netlbl_unlabel_gnl_family = {
 	.id = GENL_ID_GENERATE,
 	.hdrsize = 0,
@@ -61,11 +133,681 @@ static struct genl_family netlbl_unlabel_gnl_family = {
 /* NetLabel Netlink attribute policy */
 static const struct nla_policy netlbl_unlabel_genl_policy[NLBL_UNLABEL_A_MAX + 1] = {
 	[NLBL_UNLABEL_A_ACPTFLG] = { .type = NLA_U8 },
+	[NLBL_UNLABEL_A_IPV6ADDR] = { .type = NLA_BINARY,
+				      .len = sizeof(struct in6_addr) },
+	[NLBL_UNLABEL_A_IPV6MASK] = { .type = NLA_BINARY,
+				      .len = sizeof(struct in6_addr) },
+	[NLBL_UNLABEL_A_IPV4ADDR] = { .type = NLA_BINARY,
+				      .len = sizeof(struct in_addr) },
+	[NLBL_UNLABEL_A_IPV4MASK] = { .type = NLA_BINARY,
+				      .len = sizeof(struct in_addr) },
+	[NLBL_UNLABEL_A_IFACE] = { .type = NLA_NUL_STRING,
+				   .len = IFNAMSIZ - 1 },
+	[NLBL_UNLABEL_A_SECCTX] = { .type = NLA_BINARY }
 };
 
 /*
- * Helper Functions
+ * Unlabeled Connection Hash Table Functions
+ */
+
+/**
+ * netlbl_unlhsh_free_addr4 - Frees an IPv4 address entry from the hash table
+ * @entry: the entry's RCU field
+ *
+ * Description:
+ * This function is designed to be used as a callback to the call_rcu()
+ * function so that memory allocated to a hash table address entry can be
+ * released safely.
+ *
+ */
+static void netlbl_unlhsh_free_addr4(struct rcu_head *entry)
+{
+	struct netlbl_unlhsh_addr4 *ptr;
+
+	ptr = container_of(entry, struct netlbl_unlhsh_addr4, rcu);
+	kfree(ptr);
+}
+
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+/**
+ * netlbl_unlhsh_free_addr6 - Frees an IPv6 address entry from the hash table
+ * @entry: the entry's RCU field
+ *
+ * Description:
+ * This function is designed to be used as a callback to the call_rcu()
+ * function so that memory allocated to a hash table address entry can be
+ * released safely.
+ *
+ */
+static void netlbl_unlhsh_free_addr6(struct rcu_head *entry)
+{
+	struct netlbl_unlhsh_addr6 *ptr;
+
+	ptr = container_of(entry, struct netlbl_unlhsh_addr6, rcu);
+	kfree(ptr);
+}
+#endif /* IPv6 */
+
+/**
+ * netlbl_unlhsh_free_iface - Frees an interface entry from the hash table
+ * @entry: the entry's RCU field
+ *
+ * Description:
+ * This function is designed to be used as a callback to the call_rcu()
+ * function so that memory allocated to a hash table interface entry can be
+ * released safely.  It is important to note that this function does not free
+ * the IPv4 and IPv6 address lists contained as part of an interface entry.  It
+ * is up to the rest of the code to make sure an interface entry is only freed
+ * once it's address lists are empty.
+ *
+ */
+static void netlbl_unlhsh_free_iface(struct rcu_head *entry)
+{
+	struct netlbl_unlhsh_iface *iface;
+	struct netlbl_unlhsh_addr4 *iter4;
+	struct netlbl_unlhsh_addr4 *tmp4;
+	struct netlbl_unlhsh_addr6 *iter6;
+	struct netlbl_unlhsh_addr6 *tmp6;
+
+	iface = container_of(entry, struct netlbl_unlhsh_iface, rcu);
+
+	/* no need for locks here since we are the only one with access to this
+	 * structure */
+
+	list_for_each_entry_safe(iter4, tmp4, &iface->addr4_list, list)
+		if (iter4->valid) {
+			list_del_rcu(&iter4->list);
+			kfree(iter4);
+		}
+	list_for_each_entry_safe(iter6, tmp6, &iface->addr6_list, list)
+		if (iter6->valid) {
+			list_del_rcu(&iter6->list);
+			kfree(iter6);
+		}
+	kfree(iface);
+}
+
+/**
+ * netlbl_unlhsh_hash - Hashing function for the hash table
+ * @ifindex: the network interface/device to hash
+ *
+ * Description:
+ * This is the hashing function for the unlabeled hash table, it returns the
+ * bucket number for the given device/interface.  The caller is responsible for
+ * calling the rcu_read_[un]lock() functions.
+ *
+ */
+static u32 netlbl_unlhsh_hash(int ifindex)
+{
+	/* this is taken _almost_ directly from
+	 * security/selinux/netif.c:sel_netif_hasfn() as they do pretty much
+	 * the same thing */
+	return ifindex & (rcu_dereference(netlbl_unlhsh)->size - 1);
+}
+
+/**
+ * netlbl_unlhsh_search_addr4 - Search for a matching IPv4 address entry
+ * @addr: IPv4 address
+ * @iface: the network interface entry
+ *
+ * Description:
+ * Searches the IPv4 address list of the network interface specified by @iface.
+ * If a matching address entry is found it is returned, otherwise NULL is
+ * returned.  The caller is responsible for calling the rcu_read_[un]lock()
+ * functions.
+ *
+ */
+static struct netlbl_unlhsh_addr4 *netlbl_unlhsh_search_addr4(
+	                               __be32 addr,
+	                               const struct netlbl_unlhsh_iface *iface)
+{
+	struct netlbl_unlhsh_addr4 *iter;
+
+	list_for_each_entry_rcu(iter, &iface->addr4_list, list)
+		if (iter->valid && (addr & iter->mask) == iter->addr)
+			return iter;
+
+	return NULL;
+}
+
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+/**
+ * netlbl_unlhsh_search_addr6 - Search for a matching IPv6 address entry
+ * @addr: IPv6 address
+ * @iface: the network interface entry
+ *
+ * Description:
+ * Searches the IPv6 address list of the network interface specified by @iface.
+ * If a matching address entry is found it is returned, otherwise NULL is
+ * returned.  The caller is responsible for calling the rcu_read_[un]lock()
+ * functions.
+ *
+ */
+static struct netlbl_unlhsh_addr6 *netlbl_unlhsh_search_addr6(
+	                               const struct in6_addr *addr,
+	                               const struct netlbl_unlhsh_iface *iface)
+{
+	struct netlbl_unlhsh_addr6 *iter;
+
+	list_for_each_entry_rcu(iter, &iface->addr6_list, list)
+		if (iter->valid &&
+		    ipv6_masked_addr_cmp(&iter->addr, &iter->mask, addr) == 0)
+		return iter;
+
+	return NULL;
+}
+#endif /* IPv6 */
+
+/**
+ * netlbl_unlhsh_search_iface - Search for a matching interface entry
+ * @ifindex: the network interface
+ *
+ * Description:
+ * Searches the unlabeled connection hash table and returns a pointer to the
+ * interface entry which matches @ifindex, otherwise NULL is returned.  The
+ * caller is responsible for calling the rcu_read_[un]lock() functions.
+ *
+ */
+static struct netlbl_unlhsh_iface *netlbl_unlhsh_search_iface(int ifindex)
+{
+	u32 bkt;
+	struct netlbl_unlhsh_iface *iter;
+
+	bkt = netlbl_unlhsh_hash(ifindex);
+	list_for_each_entry_rcu(iter,
+				&rcu_dereference(netlbl_unlhsh)->tbl[bkt],
+				list)
+		if (iter->valid && iter->ifindex == ifindex)
+			return iter;
+
+	return NULL;
+}
+
+/**
+ * netlbl_unlhsh_search_iface_def - Search for a matching interface entry
+ * @ifindex: the network interface
+ *
+ * Description:
+ * Searches the unlabeled connection hash table and returns a pointer to the
+ * interface entry which matches @ifindex.  If an exact match can not be found
+ * and there is a valid default entry, the default entry is returned, otherwise
+ * NULL is returned.  The caller is responsible for calling the
+ * rcu_read_[un]lock() functions.
+ *
+ */
+static struct netlbl_unlhsh_iface *netlbl_unlhsh_search_iface_def(int ifindex)
+{
+	struct netlbl_unlhsh_iface *entry;
+
+	entry = netlbl_unlhsh_search_iface(ifindex);
+	if (entry != NULL)
+		return entry;
+
+	entry = rcu_dereference(netlbl_unlhsh_def);
+	if (entry != NULL && entry->valid)
+		return entry;
+
+	return NULL;
+}
+
+/**
+ * netlbl_unlhsh_add_addr4 - Add a new IPv4 address entry to the hash table
+ * @iface: the associated interface entry
+ * @addr: IPv4 address in network byte order
+ * @mask: IPv4 address mask in network byte order
+ * @secid: LSM secid value for entry
+ *
+ * Description:
+ * Add a new address entry into the unlabeled connection hash table using the
+ * interface entry specified by @iface.  On success zero is returned, otherwise
+ * a negative value is returned.  The caller is responsible for calling the
+ * rcu_read_[un]lock() functions.
+ *
  */
+static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
+				   const struct in_addr *addr,
+				   const struct in_addr *mask,
+				   u32 secid)
+{
+	struct netlbl_unlhsh_addr4 *entry;
+	struct netlbl_unlhsh_addr4 *iter;
+
+	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+	if (entry == NULL)
+		return -ENOMEM;
+
+	entry->addr = addr->s_addr & mask->s_addr;
+	entry->mask = mask->s_addr;
+	entry->secid = secid;
+	entry->valid = 1;
+	INIT_RCU_HEAD(&entry->rcu);
+
+	spin_lock(&netlbl_unlhsh_lock);
+	iter = netlbl_unlhsh_search_addr4(entry->addr, iface);
+	if (iter != NULL &&
+	    iter->addr == addr->s_addr && iter->mask == mask->s_addr) {
+		spin_unlock(&netlbl_unlhsh_lock);
+		kfree(entry);
+		return -EEXIST;
+	}
+	/* in order to speed up address searches through the list (the common
+	 * case) we need to keep the list in order based on the size of the
+	 * address mask such that the entry with the widest mask (smallest
+	 * numerical value) appears first in the list */
+	list_for_each_entry_rcu(iter, &iface->addr4_list, list)
+		if (iter->valid &&
+		    ntohl(entry->mask) > ntohl(iter->mask)) {
+			__list_add_rcu(&entry->list,
+				       iter->list.prev,
+				       &iter->list);
+			spin_unlock(&netlbl_unlhsh_lock);
+			return 0;
+		}
+	list_add_tail_rcu(&entry->list, &iface->addr4_list);
+	spin_unlock(&netlbl_unlhsh_lock);
+	return 0;
+}
+
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+/**
+ * netlbl_unlhsh_add_addr6 - Add a new IPv6 address entry to the hash table
+ * @iface: the associated interface entry
+ * @addr: IPv6 address in network byte order
+ * @mask: IPv6 address mask in network byte order
+ * @secid: LSM secid value for entry
+ *
+ * Description:
+ * Add a new address entry into the unlabeled connection hash table using the
+ * interface entry specified by @iface.  On success zero is returned, otherwise
+ * a negative value is returned.  The caller is responsible for calling the
+ * rcu_read_[un]lock() functions.
+ *
+ */
+static int netlbl_unlhsh_add_addr6(struct netlbl_unlhsh_iface *iface,
+				   const struct in6_addr *addr,
+				   const struct in6_addr *mask,
+				   u32 secid)
+{
+	struct netlbl_unlhsh_addr6 *entry;
+	struct netlbl_unlhsh_addr6 *iter;
+
+	entry = kzalloc(sizeof(*entry), GFP_ATOMIC);
+	if (entry == NULL)
+		return -ENOMEM;
+
+	ipv6_addr_copy(&entry->addr, addr);
+	entry->addr.s6_addr32[0] &= mask->s6_addr32[0];
+	entry->addr.s6_addr32[1] &= mask->s6_addr32[1];
+	entry->addr.s6_addr32[2] &= mask->s6_addr32[2];
+	entry->addr.s6_addr32[3] &= mask->s6_addr32[3];
+	ipv6_addr_copy(&entry->mask, mask);
+	entry->secid = secid;
+	entry->valid = 1;
+	INIT_RCU_HEAD(&entry->rcu);
+
+	spin_lock(&netlbl_unlhsh_lock);
+	iter = netlbl_unlhsh_search_addr6(&entry->addr, iface);
+	if (iter != NULL &&
+	    (ipv6_addr_equal(&iter->addr, addr) &&
+	     ipv6_addr_equal(&iter->mask, mask))) {
+		spin_unlock(&netlbl_unlhsh_lock);
+		kfree(entry);
+		return -EEXIST;
+	}
+	/* in order to speed up address searches through the list (the common
+	 * case) we need to keep the list in order based on the size of the
+	 * address mask such that the entry with the widest mask (smallest
+	 * numerical value) appears first in the list */
+	list_for_each_entry_rcu(iter, &iface->addr6_list, list)
+		if (iter->valid &&
+		    ipv6_addr_cmp(&entry->mask, &iter->mask) > 0) {
+			__list_add_rcu(&entry->list,
+				       iter->list.prev,
+				       &iter->list);
+			spin_unlock(&netlbl_unlhsh_lock);
+			return 0;
+		}
+	list_add_tail_rcu(&entry->list, &iface->addr6_list);
+	spin_unlock(&netlbl_unlhsh_lock);
+	return 0;
+}
+#endif /* IPv6 */
+
+/**
+ * netlbl_unlhsh_add_iface - Adds a new interface entry to the hash table
+ * @ifindex: network interface
+ *
+ * Description:
+ * Add a new, empty, interface entry into the unlabeled connection hash table.
+ * On success a pointer to the new interface entry is returned, on failure NULL
+ * is returned.  The caller is responsible for calling the rcu_read_[un]lock()
+ * functions.
+ *
+ */
+static struct netlbl_unlhsh_iface *netlbl_unlhsh_add_iface(int ifindex)
+{
+	u32 bkt;
+	struct netlbl_unlhsh_iface *iface;
+
+	iface = kzalloc(sizeof(*iface), GFP_ATOMIC);
+	if (iface == NULL)
+		return NULL;
+
+	iface->ifindex = ifindex;
+	INIT_LIST_HEAD(&iface->addr4_list);
+	INIT_LIST_HEAD(&iface->addr6_list);
+	iface->valid = 1;
+	INIT_RCU_HEAD(&iface->rcu);
+
+	spin_lock(&netlbl_unlhsh_lock);
+	if (ifindex > 0) {
+		bkt = netlbl_unlhsh_hash(ifindex);
+		if (netlbl_unlhsh_search_iface(ifindex) != NULL)
+			goto add_iface_failure;
+		list_add_tail_rcu(&iface->list,
+				  &rcu_dereference(netlbl_unlhsh)->tbl[bkt]);
+	} else {
+		INIT_LIST_HEAD(&iface->list);
+		if (rcu_dereference(netlbl_unlhsh_def) != NULL)
+			goto add_iface_failure;
+		rcu_assign_pointer(netlbl_unlhsh_def, iface);
+	}
+	spin_unlock(&netlbl_unlhsh_lock);
+
+	return iface;
+
+add_iface_failure:
+	spin_unlock(&netlbl_unlhsh_lock);
+	kfree(iface);
+	return NULL;
+}
+
+/**
+ * netlbl_unlhsh_add - Adds a new entry to the unlabeled connection hash table
+ * @net: network namespace
+ * @dev_name: interface name
+ * @addr: IP address in network byte order
+ * @mask: address mask in network byte order
+ * @addr_len: length of address/mask (4 for IPv4, 16 for IPv6)
+ * @secid: LSM secid value for the entry
+ *
+ * Description:
+ * Adds a new entry to the unlabeled connection hash table.  Returns zero on
+ * success, negative values on failure.
+ *
+ */
+static int netlbl_unlhsh_add(struct net *net,
+			     const char *dev_name,
+			     const void *addr,
+			     const void *mask,
+			     u32 addr_len,
+			     u32 secid)
+{
+	int ret_val;
+	int ifindex;
+	struct net_device *dev;
+	struct netlbl_unlhsh_iface *iface;
+
+	if (addr_len != sizeof(struct in_addr) &&
+	    addr_len != sizeof(struct in6_addr))
+		return -EINVAL;
+
+	rcu_read_lock();
+	if (dev_name != NULL) {
+		dev = dev_get_by_name(net, dev_name);
+		if (dev == NULL) {
+			ret_val = -ENODEV;
+			goto unlhsh_add_return;
+		}
+		ifindex = dev->ifindex;
+		dev_put(dev);
+		iface = netlbl_unlhsh_search_iface(ifindex);
+	} else {
+		ifindex = 0;
+		iface = rcu_dereference(netlbl_unlhsh_def);
+	}
+	if (iface == NULL) {
+		iface = netlbl_unlhsh_add_iface(ifindex);
+		if (iface == NULL) {
+			ret_val = -ENOMEM;
+			goto unlhsh_add_return;
+		}
+	}
+	switch (addr_len) {
+	case sizeof(struct in_addr):
+		ret_val = netlbl_unlhsh_add_addr4(iface, addr, mask, secid);
+		break;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	case sizeof(struct in6_addr):
+		ret_val = netlbl_unlhsh_add_addr6(iface, addr, mask, secid);
+		break;
+#endif /* IPv6 */
+	default:
+		ret_val = -EINVAL;
+	}
+	if (ret_val == 0)
+		atomic_inc(&netlabel_mgmt_protocount);
+
+unlhsh_add_return:
+	rcu_read_unlock();
+	return ret_val;
+}
+
+/**
+ * netlbl_unlhsh_remove_addr4 - Remove an IPv4 address entry
+ * @iface: interface entry
+ * @addr: IP address
+ * @mask: IP address mask
+ *
+ * Description:
+ * Remove an IP address entry from the unlabeled connection hash table.
+ * Returns zero on success, negative values on failure.  The caller is
+ * responsible for calling the rcu_read_[un]lock() functions.
+ *
+ */
+static int netlbl_unlhsh_remove_addr4(struct netlbl_unlhsh_iface *iface,
+				      const struct in_addr *addr,
+				      const struct in_addr *mask)
+{
+	int ret_val = -ENOENT;
+	struct netlbl_unlhsh_addr4 *entry;
+
+	spin_lock(&netlbl_unlhsh_lock);
+	entry = netlbl_unlhsh_search_addr4(addr->s_addr, iface);
+	if (entry != NULL &&
+	    entry->addr == addr->s_addr && entry->mask == mask->s_addr) {
+		entry->valid = 0;
+		list_del_rcu(&entry->list);
+		ret_val = 0;
+	}
+	spin_unlock(&netlbl_unlhsh_lock);
+
+	if (ret_val == 0)
+		call_rcu(&entry->rcu, netlbl_unlhsh_free_addr4);
+	return ret_val;
+}
+
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+/**
+ * netlbl_unlhsh_remove_addr6 - Remove an IPv6 address entry
+ * @iface: interface entry
+ * @addr: IP address
+ * @mask: IP address mask
+ *
+ * Description:
+ * Remove an IP address entry from the unlabeled connection hash table.
+ * Returns zero on success, negative values on failure.  The caller is
+ * responsible for calling the rcu_read_[un]lock() functions.
+ *
+ */
+static int netlbl_unlhsh_remove_addr6(struct netlbl_unlhsh_iface *iface,
+				      const struct in6_addr *addr,
+				      const struct in6_addr *mask)
+{
+	int ret_val = -ENOENT;
+	struct netlbl_unlhsh_addr6 *entry;
+
+	spin_lock(&netlbl_unlhsh_lock);
+	entry = netlbl_unlhsh_search_addr6(addr, iface);
+	if (entry != NULL &&
+	    (ipv6_addr_equal(&entry->addr, addr) &&
+	     ipv6_addr_equal(&entry->mask, mask))) {
+		entry->valid = 0;
+		list_del_rcu(&entry->list);
+		ret_val = 0;
+	}
+	spin_unlock(&netlbl_unlhsh_lock);
+
+	if (ret_val == 0)
+		call_rcu(&entry->rcu, netlbl_unlhsh_free_addr6);
+	return ret_val;
+}
+#endif /* IPv6 */
+
+/**
+ * netlbl_unlhsh_condremove_iface - Remove an interface entry
+ * @iface: the interface entry
+ *
+ * Description:
+ * Remove an interface entry from the unlabeled connection hash table if it is
+ * empty.  An interface entry is considered to be empty if there are no
+ * address entries assigned to it.
+ *
+ */
+static void netlbl_unlhsh_condremove_iface(struct netlbl_unlhsh_iface *iface)
+{
+	struct netlbl_unlhsh_addr4 *iter4;
+	struct netlbl_unlhsh_addr6 *iter6;
+
+	spin_lock(&netlbl_unlhsh_lock);
+	list_for_each_entry_rcu(iter4, &iface->addr4_list, list)
+		if (iter4->valid)
+			goto unlhsh_condremove_failure;
+	list_for_each_entry_rcu(iter6, &iface->addr6_list, list)
+		if (iter6->valid)
+			goto unlhsh_condremove_failure;
+	iface->valid = 0;
+	if (iface->ifindex > 0)
+		list_del_rcu(&iface->list);
+	else
+		rcu_assign_pointer(netlbl_unlhsh_def, NULL);
+	spin_unlock(&netlbl_unlhsh_lock);
+
+	call_rcu(&iface->rcu, netlbl_unlhsh_free_iface);
+	return;
+
+unlhsh_condremove_failure:
+	spin_unlock(&netlbl_unlhsh_lock);
+	return;
+}
+
+/**
+ * netlbl_unlhsh_remove - Remove an entry from the unlabeled hash table
+ * @net: network namespace
+ * @dev_name: interface name
+ * @addr: IP address in network byte order
+ * @mask: address mask in network byte order
+ * @addr_len: length of address/mask (4 for IPv4, 16 for IPv6)
+ *
+ * Description:
+ * Removes and existing entry from the unlabeled connection hash table.
+ * Returns zero on success, negative values on failure.
+ *
+ */
+static int netlbl_unlhsh_remove(struct net *net,
+				const char *dev_name,
+				const void *addr,
+				const void *mask,
+				u32 addr_len)
+{
+	int ret_val;
+	struct net_device *dev;
+	struct netlbl_unlhsh_iface *iface;
+
+	if (addr_len != sizeof(struct in_addr) &&
+	    addr_len != sizeof(struct in6_addr))
+		return -EINVAL;
+
+	rcu_read_lock();
+	if (dev_name != NULL) {
+		dev = dev_get_by_name(net, dev_name);
+		if (dev == NULL) {
+			ret_val = -ENODEV;
+			goto unlhsh_remove_return;
+		}
+		iface = netlbl_unlhsh_search_iface(dev->ifindex);
+		dev_put(dev);
+	} else
+		iface = rcu_dereference(netlbl_unlhsh_def);
+	if (iface == NULL) {
+		ret_val = -ENOENT;
+		goto unlhsh_remove_return;
+	}
+	switch (addr_len) {
+	case sizeof(struct in_addr):
+		ret_val = netlbl_unlhsh_remove_addr4(iface, addr, mask);
+		break;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	case sizeof(struct in6_addr):
+		ret_val = netlbl_unlhsh_remove_addr6(iface, addr, mask);
+		break;
+#endif /* IPv6 */
+	default:
+		ret_val = -EINVAL;
+	}
+	if (ret_val == 0) {
+		netlbl_unlhsh_condremove_iface(iface);
+		atomic_dec(&netlabel_mgmt_protocount);
+	}
+
+unlhsh_remove_return:
+	rcu_read_unlock();
+	return ret_val;
+}
+
+/*
+ * General Helper Functions
+ */
+
+/**
+ * netlbl_unlhsh_netdev_handler - Network device notification handler
+ * @this: notifier block
+ * @event: the event
+ * @ptr: the network device (cast to void)
+ *
+ * Description:
+ * Handle network device events, although at present all we care about is a
+ * network device going away.  In the case of a device going away we clear any
+ * related entries from the unlabeled connection hash table.
+ *
+ */
+static int netlbl_unlhsh_netdev_handler(struct notifier_block *this,
+					unsigned long event,
+					void *ptr)
+{
+	struct net_device *dev = ptr;
+	struct netlbl_unlhsh_iface *iface = NULL;
+
+	if (dev->nd_net != &init_net)
+		return NOTIFY_DONE;
+
+	/* XXX - should this be a check for NETDEV_DOWN or _UNREGISTER? */
+	if (event == NETDEV_DOWN) {
+		spin_lock(&netlbl_unlhsh_lock);
+		iface = netlbl_unlhsh_search_iface(dev->ifindex);
+		if (iface != NULL && iface->valid) {
+			iface->valid = 0;
+			list_del_rcu(&iface->list);
+		} else
+			iface = NULL;
+		spin_unlock(&netlbl_unlhsh_lock);
+	}
+
+	if (iface != NULL)
+		call_rcu(&iface->rcu, netlbl_unlhsh_free_iface);
+
+	return NOTIFY_DONE;
+}
 
 /**
  * netlbl_unlabel_acceptflg_set - Set the unlabeled accept flag
@@ -93,6 +835,48 @@ static void netlbl_unlabel_acceptflg_set(u8 value,
 	}
 }
 
+/**
+ * netlbl_unlabel_addrinfo_get - Get the IPv4/6 address information
+ * @info: the Generic NETLINK info block
+ * @addr: the IP address
+ * @mask: the IP address mask
+ * @len: the address length
+ *
+ * Description:
+ * Examine the Generic NETLINK message and extract the IP address information.
+ * Returns zero on success, negative values on failure.
+ *
+ */
+static int netlbl_unlabel_addrinfo_get(struct genl_info *info,
+				       void **addr,
+				       void **mask,
+				       u32 *len)
+{
+	u32 addr_len;
+
+	if (info->attrs[NLBL_UNLABEL_A_IPV4ADDR]) {
+		addr_len = nla_len(info->attrs[NLBL_UNLABEL_A_IPV4ADDR]);
+		if (addr_len != sizeof(struct in_addr) &&
+		    addr_len != nla_len(info->attrs[NLBL_UNLABEL_A_IPV4MASK]))
+			return -EINVAL;
+		*len = addr_len;
+		*addr = nla_data(info->attrs[NLBL_UNLABEL_A_IPV4ADDR]);
+		*mask = nla_data(info->attrs[NLBL_UNLABEL_A_IPV4MASK]);
+		return 0;
+	} else if (info->attrs[NLBL_UNLABEL_A_IPV6ADDR]) {
+		addr_len = nla_len(info->attrs[NLBL_UNLABEL_A_IPV6ADDR]);
+		if (addr_len != sizeof(struct in6_addr) &&
+		    addr_len != nla_len(info->attrs[NLBL_UNLABEL_A_IPV6MASK]))
+			return -EINVAL;
+		*len = addr_len;
+		*addr = nla_data(info->attrs[NLBL_UNLABEL_A_IPV6ADDR]);
+		*mask = nla_data(info->attrs[NLBL_UNLABEL_A_IPV6MASK]);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 /*
  * NetLabel Command Handlers
  */
@@ -168,11 +952,470 @@ list_failure:
 	return ret_val;
 }
 
+/**
+ * netlbl_unlabel_staticadd - Handle a STATICADD message
+ * @skb: the NETLINK buffer
+ * @info: the Generic NETLINK info block
+ *
+ * Description:
+ * Process a user generated STATICADD message and add a new unlabeled
+ * connection entry to the hash table.  Returns zero on success, negative
+ * values on failure.
+ *
+ */
+static int netlbl_unlabel_staticadd(struct sk_buff *skb,
+				    struct genl_info *info)
+{
+	int ret_val;
+	char *dev_name;
+	void *addr;
+	void *mask;
+	u32 addr_len;
+	u32 secid;
+
+	/* Don't allow users to add both IPv4 and IPv6 addresses for a
+	 * single entry.  However, allow users to create two entries, one each
+	 * for IPv4 and IPv4, with the same LSM security context which should
+	 * achieve the same result. */
+	if (!info->attrs[NLBL_UNLABEL_A_SECCTX] ||
+	    !info->attrs[NLBL_UNLABEL_A_IFACE] ||
+	    !((!info->attrs[NLBL_UNLABEL_A_IPV4ADDR] ||
+	       !info->attrs[NLBL_UNLABEL_A_IPV4MASK]) ^
+	      (!info->attrs[NLBL_UNLABEL_A_IPV6ADDR] ||
+	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
+		return -EINVAL;
+
+	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
+	if (ret_val != 0)
+		return ret_val;
+	dev_name = nla_data(info->attrs[NLBL_UNLABEL_A_IFACE]);
+	ret_val = security_secctx_to_secid(
+		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
+				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
+				  &secid);
+	if (ret_val != 0)
+		return ret_val;
+
+	return netlbl_unlhsh_add(&init_net,
+				 dev_name, addr, mask, addr_len, secid);
+}
+
+/**
+ * netlbl_unlabel_staticadddef - Handle a STATICADDDEF message
+ * @skb: the NETLINK buffer
+ * @info: the Generic NETLINK info block
+ *
+ * Description:
+ * Process a user generated STATICADDDEF message and add a new default
+ * unlabeled connection entry.  Returns zero on success, negative values on
+ * failure.
+ *
+ */
+static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
+				       struct genl_info *info)
+{
+	int ret_val;
+	void *addr;
+	void *mask;
+	u32 addr_len;
+	u32 secid;
+
+	/* Don't allow users to add both IPv4 and IPv6 addresses for a
+	 * single entry.  However, allow users to create two entries, one each
+	 * for IPv4 and IPv6, with the same LSM security context which should
+	 * achieve the same result. */
+	if (!info->attrs[NLBL_UNLABEL_A_SECCTX] ||
+	    !((!info->attrs[NLBL_UNLABEL_A_IPV4ADDR] ||
+	       !info->attrs[NLBL_UNLABEL_A_IPV4MASK]) ^
+	      (!info->attrs[NLBL_UNLABEL_A_IPV6ADDR] ||
+	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
+		return -EINVAL;
+
+	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
+	if (ret_val != 0)
+		return ret_val;
+	ret_val = security_secctx_to_secid(
+		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
+				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
+				  &secid);
+	if (ret_val != 0)
+		return ret_val;
+
+	return netlbl_unlhsh_add(&init_net, NULL, addr, mask, addr_len, secid);
+}
+
+/**
+ * netlbl_unlabel_staticremove - Handle a STATICREMOVE message
+ * @skb: the NETLINK buffer
+ * @info: the Generic NETLINK info block
+ *
+ * Description:
+ * Process a user generated STATICREMOVE message and remove the specified
+ * unlabeled connection entry.  Returns zero on success, negative values on
+ * failure.
+ *
+ */
+static int netlbl_unlabel_staticremove(struct sk_buff *skb,
+				       struct genl_info *info)
+{
+	int ret_val;
+	char *dev_name;
+	void *addr;
+	void *mask;
+	u32 addr_len;
+
+	/* See the note in netlbl_unlabel_staticadd() about not allowing both
+	 * IPv4 and IPv6 in the same entry. */
+	if (!info->attrs[NLBL_UNLABEL_A_IFACE] ||
+	    !((!info->attrs[NLBL_UNLABEL_A_IPV4ADDR] ||
+	       !info->attrs[NLBL_UNLABEL_A_IPV4MASK]) ^
+	      (!info->attrs[NLBL_UNLABEL_A_IPV6ADDR] ||
+	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
+		return -EINVAL;
+
+	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
+	if (ret_val != 0)
+		return ret_val;
+	dev_name = nla_data(info->attrs[NLBL_UNLABEL_A_IFACE]);
+
+	return netlbl_unlhsh_remove(&init_net, dev_name, addr, mask, addr_len);
+}
+
+/**
+ * netlbl_unlabel_staticremovedef - Handle a STATICREMOVEDEF message
+ * @skb: the NETLINK buffer
+ * @info: the Generic NETLINK info block
+ *
+ * Description:
+ * Process a user generated STATICREMOVEDEF message and remove the default
+ * unlabeled connection entry.  Returns zero on success, negative values on
+ * failure.
+ *
+ */
+static int netlbl_unlabel_staticremovedef(struct sk_buff *skb,
+					  struct genl_info *info)
+{
+	int ret_val;
+	void *addr;
+	void *mask;
+	u32 addr_len;
+
+	/* See the note in netlbl_unlabel_staticadd() about not allowing both
+	 * IPv4 and IPv6 in the same entry. */
+	if (!((!info->attrs[NLBL_UNLABEL_A_IPV4ADDR] ||
+	       !info->attrs[NLBL_UNLABEL_A_IPV4MASK]) ^
+	      (!info->attrs[NLBL_UNLABEL_A_IPV6ADDR] ||
+	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
+		return -EINVAL;
+
+	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
+	if (ret_val != 0)
+		return ret_val;
+
+	return netlbl_unlhsh_remove(&init_net, NULL, addr, mask, addr_len);
+}
+
+
+/**
+ * netlbl_unlabel_staticlist_gen - Generate messages for STATICLIST[DEF]
+ * @cmd: command/message
+ * @iface: the interface entry
+ * @addr4: the IPv4 address entry
+ * @addr6: the IPv6 address entry
+ * @arg: the netlbl_unlhsh_walk_arg structure
+ *
+ * Description:
+ * This function is designed to be used to generate a response for a
+ * STATICLIST or STATICLISTDEF message.  When called either @addr4 or @addr6
+ * can be specified, not both, the other unspecified entry should be set to
+ * NULL by the caller.  Returns the size of the message on success, negative
+ * values on failure.
+ *
+ */
+static int netlbl_unlabel_staticlist_gen(u32 cmd,
+				       const struct netlbl_unlhsh_iface *iface,
+				       const struct netlbl_unlhsh_addr4 *addr4,
+				       const struct netlbl_unlhsh_addr6 *addr6,
+				       void *arg)
+{
+	int ret_val = -ENOMEM;
+	struct netlbl_unlhsh_walk_arg *cb_arg = arg;
+	struct net_device *dev;
+	void *data;
+	u32 secid;
+	char *secctx;
+	u32 secctx_len;
+
+	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).pid,
+			   cb_arg->seq, &netlbl_unlabel_gnl_family,
+			   NLM_F_MULTI, cmd);
+	if (data == NULL)
+		goto list_cb_failure;
+
+	if (iface->ifindex > 0) {
+		dev = dev_get_by_index(&init_net, iface->ifindex);
+		ret_val = nla_put_string(cb_arg->skb,
+					 NLBL_UNLABEL_A_IFACE, dev->name);
+		dev_put(dev);
+		if (ret_val != 0)
+			goto list_cb_failure;
+	}
+
+	if (addr4) {
+		struct in_addr addr_struct;
+
+		addr_struct.s_addr = addr4->addr;
+		ret_val = nla_put(cb_arg->skb,
+				  NLBL_UNLABEL_A_IPV4ADDR,
+				  sizeof(struct in_addr),
+				  &addr_struct);
+		if (ret_val != 0)
+			goto list_cb_failure;
+
+		addr_struct.s_addr = addr4->mask;
+		ret_val = nla_put(cb_arg->skb,
+				  NLBL_UNLABEL_A_IPV4MASK,
+				  sizeof(struct in_addr),
+				  &addr_struct);
+		if (ret_val != 0)
+			goto list_cb_failure;
+
+		secid = addr4->secid;
+	} else {
+		ret_val = nla_put(cb_arg->skb,
+				  NLBL_UNLABEL_A_IPV6ADDR,
+				  sizeof(struct in6_addr),
+				  &addr6->addr);
+		if (ret_val != 0)
+			goto list_cb_failure;
+
+		ret_val = nla_put(cb_arg->skb,
+				  NLBL_UNLABEL_A_IPV6MASK,
+				  sizeof(struct in6_addr),
+				  &addr6->mask);
+		if (ret_val != 0)
+			goto list_cb_failure;
+
+		secid = addr6->secid;
+	}
+
+	ret_val = security_secid_to_secctx(secid, &secctx, &secctx_len);
+	if (ret_val != 0)
+		goto list_cb_failure;
+	ret_val = nla_put(cb_arg->skb,
+			  NLBL_UNLABEL_A_SECCTX,
+			  secctx_len,
+			  secctx);
+	security_release_secctx(secctx, secctx_len);
+	if (ret_val != 0)
+		goto list_cb_failure;
+
+	cb_arg->seq++;
+	return genlmsg_end(cb_arg->skb, data);
+
+list_cb_failure:
+	genlmsg_cancel(cb_arg->skb, data);
+	return ret_val;
+}
+
+/**
+ * netlbl_unlabel_staticlist - Handle a STATICLIST message
+ * @skb: the NETLINK buffer
+ * @cb: the NETLINK callback
+ *
+ * Description:
+ * Process a user generated STATICLIST message and dump the unlabeled
+ * connection hash table in a form suitable for use in a kernel generated
+ * STATICLIST message.  Returns the length of @skb.
+ *
+ */
+static int netlbl_unlabel_staticlist(struct sk_buff *skb,
+				     struct netlink_callback *cb)
+{
+	struct netlbl_unlhsh_walk_arg cb_arg;
+	u32 skip_bkt = cb->args[0];
+	u32 skip_chain = cb->args[1];
+	u32 skip_addr4 = cb->args[2];
+	u32 skip_addr6 = cb->args[3];
+	u32 iter_bkt;
+	u32 iter_chain = 0, iter_addr4 = 0, iter_addr6 = 0;
+	struct netlbl_unlhsh_iface *iface;
+	struct netlbl_unlhsh_addr4 *addr4;
+	struct netlbl_unlhsh_addr6 *addr6;
+
+	cb_arg.nl_cb = cb;
+	cb_arg.skb = skb;
+	cb_arg.seq = cb->nlh->nlmsg_seq;
+
+	rcu_read_lock();
+	for (iter_bkt = skip_bkt;
+	     iter_bkt < rcu_dereference(netlbl_unlhsh)->size;
+	     iter_bkt++, iter_chain = 0, iter_addr4 = 0, iter_addr6 = 0) {
+		list_for_each_entry_rcu(iface,
+			        &rcu_dereference(netlbl_unlhsh)->tbl[iter_bkt],
+				list) {
+			if (!iface->valid ||
+			    iter_chain++ < skip_chain)
+				continue;
+			list_for_each_entry_rcu(addr4,
+						&iface->addr4_list,
+						list) {
+				if (!addr4->valid || iter_addr4++ < skip_addr4)
+					continue;
+				if (netlbl_unlabel_staticlist_gen(
+					             NLBL_UNLABEL_C_STATICLIST,
+						     iface,
+						     addr4,
+						     NULL,
+						     &cb_arg) < 0) {
+					iter_addr4--;
+					iter_chain--;
+					goto unlabel_staticlist_return;
+				}
+			}
+			list_for_each_entry_rcu(addr6,
+						&iface->addr6_list,
+						list) {
+				if (!addr6->valid || iter_addr6++ < skip_addr6)
+					continue;
+				if (netlbl_unlabel_staticlist_gen(
+						     NLBL_UNLABEL_C_STATICLIST,
+						     iface,
+						     NULL,
+						     addr6,
+						     &cb_arg) < 0) {
+					iter_addr6--;
+					iter_chain--;
+					goto unlabel_staticlist_return;
+				}
+			}
+		}
+	}
+
+unlabel_staticlist_return:
+	rcu_read_unlock();
+	cb->args[0] = skip_bkt;
+	cb->args[1] = skip_chain;
+	cb->args[2] = skip_addr4;
+	cb->args[3] = skip_addr6;
+	return skb->len;
+}
+
+/**
+ * netlbl_unlabel_staticlistdef - Handle a STATICLISTDEF message
+ * @skb: the NETLINK buffer
+ * @cb: the NETLINK callback
+ *
+ * Description:
+ * Process a user generated STATICLISTDEF message and dump the default
+ * unlabeled connection entry in a form suitable for use in a kernel generated
+ * STATICLISTDEF message.  Returns the length of @skb.
+ *
+ */
+static int netlbl_unlabel_staticlistdef(struct sk_buff *skb,
+					struct netlink_callback *cb)
+{
+	struct netlbl_unlhsh_walk_arg cb_arg;
+	struct netlbl_unlhsh_iface *iface;
+	u32 skip_addr4 = cb->args[0];
+	u32 skip_addr6 = cb->args[1];
+	u32 iter_addr4 = 0, iter_addr6 = 0;
+	struct netlbl_unlhsh_addr4 *addr4;
+	struct netlbl_unlhsh_addr6 *addr6;
+
+	cb_arg.nl_cb = cb;
+	cb_arg.skb = skb;
+	cb_arg.seq = cb->nlh->nlmsg_seq;
+
+	rcu_read_lock();
+	iface = rcu_dereference(netlbl_unlhsh_def);
+	if (iface == NULL || !iface->valid)
+		goto unlabel_staticlistdef_return;
+
+	list_for_each_entry_rcu(addr4, &iface->addr4_list, list) {
+		if (!addr4->valid || iter_addr4++ < skip_addr4)
+			continue;
+		if (netlbl_unlabel_staticlist_gen(NLBL_UNLABEL_C_STATICLISTDEF,
+					   iface,
+					   addr4,
+					   NULL,
+					   &cb_arg) < 0) {
+			iter_addr4--;
+			goto unlabel_staticlistdef_return;
+		}
+	}
+	list_for_each_entry_rcu(addr6, &iface->addr6_list, list) {
+		if (addr6->valid || iter_addr6++ < skip_addr6)
+			continue;
+		if (netlbl_unlabel_staticlist_gen(NLBL_UNLABEL_C_STATICLISTDEF,
+					   iface,
+					   NULL,
+					   addr6,
+					   &cb_arg) < 0) {
+			iter_addr6--;
+			goto unlabel_staticlistdef_return;
+		}
+	}
+
+unlabel_staticlistdef_return:
+	rcu_read_unlock();
+	cb->args[0] = skip_addr4;
+	cb->args[1] = skip_addr6;
+	return skb->len;
+}
 
 /*
  * NetLabel Generic NETLINK Command Definitions
  */
 
+static struct genl_ops netlbl_unlabel_genl_c_staticadd = {
+	.cmd = NLBL_UNLABEL_C_STATICADD,
+	.flags = GENL_ADMIN_PERM,
+	.policy = netlbl_unlabel_genl_policy,
+	.doit = netlbl_unlabel_staticadd,
+	.dumpit = NULL,
+};
+
+static struct genl_ops netlbl_unlabel_genl_c_staticremove = {
+	.cmd = NLBL_UNLABEL_C_STATICREMOVE,
+	.flags = GENL_ADMIN_PERM,
+	.policy = netlbl_unlabel_genl_policy,
+	.doit = netlbl_unlabel_staticremove,
+	.dumpit = NULL,
+};
+
+static struct genl_ops netlbl_unlabel_genl_c_staticlist = {
+	.cmd = NLBL_UNLABEL_C_STATICLIST,
+	.flags = 0,
+	.policy = netlbl_unlabel_genl_policy,
+	.doit = NULL,
+	.dumpit = netlbl_unlabel_staticlist,
+};
+
+static struct genl_ops netlbl_unlabel_genl_c_staticadddef = {
+	.cmd = NLBL_UNLABEL_C_STATICADDDEF,
+	.flags = GENL_ADMIN_PERM,
+	.policy = netlbl_unlabel_genl_policy,
+	.doit = netlbl_unlabel_staticadddef,
+	.dumpit = NULL,
+};
+
+static struct genl_ops netlbl_unlabel_genl_c_staticremovedef = {
+	.cmd = NLBL_UNLABEL_C_STATICREMOVEDEF,
+	.flags = GENL_ADMIN_PERM,
+	.policy = netlbl_unlabel_genl_policy,
+	.doit = netlbl_unlabel_staticremovedef,
+	.dumpit = NULL,
+};
+
+static struct genl_ops netlbl_unlabel_genl_c_staticlistdef = {
+	.cmd = NLBL_UNLABEL_C_STATICLISTDEF,
+	.flags = 0,
+	.policy = netlbl_unlabel_genl_policy,
+	.doit = NULL,
+	.dumpit = netlbl_unlabel_staticlistdef,
+};
+
 static struct genl_ops netlbl_unlabel_genl_c_accept = {
 	.cmd = NLBL_UNLABEL_C_ACCEPT,
 	.flags = GENL_ADMIN_PERM,
@@ -189,7 +1432,6 @@ static struct genl_ops netlbl_unlabel_genl_c_list = {
 	.dumpit = NULL,
 };
 
-
 /*
  * NetLabel Generic NETLINK Protocol Functions
  */
@@ -211,6 +1453,36 @@ int netlbl_unlabel_genl_init(void)
 		return ret_val;
 
 	ret_val = genl_register_ops(&netlbl_unlabel_gnl_family,
+				    &netlbl_unlabel_genl_c_staticadd);
+	if (ret_val != 0)
+		return ret_val;
+
+	ret_val = genl_register_ops(&netlbl_unlabel_gnl_family,
+				    &netlbl_unlabel_genl_c_staticremove);
+	if (ret_val != 0)
+		return ret_val;
+
+	ret_val = genl_register_ops(&netlbl_unlabel_gnl_family,
+				    &netlbl_unlabel_genl_c_staticlist);
+	if (ret_val != 0)
+		return ret_val;
+
+	ret_val = genl_register_ops(&netlbl_unlabel_gnl_family,
+				    &netlbl_unlabel_genl_c_staticadddef);
+	if (ret_val != 0)
+		return ret_val;
+
+	ret_val = genl_register_ops(&netlbl_unlabel_gnl_family,
+				    &netlbl_unlabel_genl_c_staticremovedef);
+	if (ret_val != 0)
+		return ret_val;
+
+	ret_val = genl_register_ops(&netlbl_unlabel_gnl_family,
+				    &netlbl_unlabel_genl_c_staticlistdef);
+	if (ret_val != 0)
+		return ret_val;
+
+	ret_val = genl_register_ops(&netlbl_unlabel_gnl_family,
 				    &netlbl_unlabel_genl_c_accept);
 	if (ret_val != 0)
 		return ret_val;
@@ -227,8 +1499,58 @@ int netlbl_unlabel_genl_init(void)
  * NetLabel KAPI Hooks
  */
 
+static struct notifier_block netlbl_unlhsh_netdev_notifier = {
+	.notifier_call = netlbl_unlhsh_netdev_handler,
+};
+
+/**
+ * netlbl_unlabel_init - Initialize the unlabeled connection hash table
+ * @size: the number of bits to use for the hash buckets
+ *
+ * Description:
+ * Initializes the unlabeled connection hash table and registers a network
+ * device notification handler.  This function should only be called by the
+ * NetLabel subsystem itself during initialization.  Returns zero on success,
+ * non-zero values on error.
+ *
+ */
+int netlbl_unlabel_init(u32 size)
+{
+	u32 iter;
+	struct netlbl_unlhsh_tbl *hsh_tbl;
+
+	if (size == 0)
+		return -EINVAL;
+
+	hsh_tbl = kmalloc(sizeof(*hsh_tbl), GFP_KERNEL);
+	if (hsh_tbl == NULL)
+		return -ENOMEM;
+	hsh_tbl->size = 1 << size;
+	hsh_tbl->tbl = kcalloc(hsh_tbl->size,
+			       sizeof(struct list_head),
+			       GFP_KERNEL);
+	if (hsh_tbl->tbl == NULL) {
+		kfree(hsh_tbl);
+		return -ENOMEM;
+	}
+	for (iter = 0; iter < hsh_tbl->size; iter++)
+		INIT_LIST_HEAD(&hsh_tbl->tbl[iter]);
+
+	rcu_read_lock();
+	spin_lock(&netlbl_unlhsh_lock);
+	rcu_assign_pointer(netlbl_unlhsh, hsh_tbl);
+	spin_unlock(&netlbl_unlhsh_lock);
+	rcu_read_unlock();
+
+	register_netdevice_notifier(&netlbl_unlhsh_netdev_notifier);
+
+	return 0;
+}
+
 /**
  * netlbl_unlabel_getattr - Get the security attributes for an unlabled packet
+ * @skb: the packet
+ * @family: protocol family
  * @secattr: the security attributes
  *
  * Description:
@@ -236,11 +1558,50 @@ int netlbl_unlabel_genl_init(void)
  * them in @secattr.  Returns zero on success and negative values on failure.
  *
  */
-int netlbl_unlabel_getattr(struct netlbl_lsm_secattr *secattr)
+int netlbl_unlabel_getattr(const struct sk_buff *skb,
+			   u16 family,
+			   struct netlbl_lsm_secattr *secattr)
 {
+	struct iphdr *hdr4;
+	struct ipv6hdr *hdr6;
+	struct netlbl_unlhsh_addr4 *addr4;
+	struct netlbl_unlhsh_addr6 *addr6;
+	struct netlbl_unlhsh_iface *iface;
+
+	rcu_read_lock();
+	iface = netlbl_unlhsh_search_iface_def(skb->iif);
+	if (iface == NULL)
+		goto unlabel_getattr_nolabel;
+	switch (family) {
+	case PF_INET:
+		hdr4 = ip_hdr(skb);
+		addr4 = netlbl_unlhsh_search_addr4(hdr4->saddr, iface);
+		if (addr4 == NULL)
+			goto unlabel_getattr_nolabel;
+		secattr->attr.secid = addr4->secid;
+		break;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	case PF_INET6:
+		hdr6 = ipv6_hdr(skb);
+		addr6 = netlbl_unlhsh_search_addr6(&hdr6->saddr, iface);
+		if (addr6 == NULL)
+			goto unlabel_getattr_nolabel;
+		secattr->attr.secid = addr6->secid;
+		break;
+#endif /* IPv6 */
+	default:
+		goto unlabel_getattr_nolabel;
+	}
+	rcu_read_unlock();
+
+	secattr->flags |= NETLBL_SECATTR_SECID;
+	secattr->type = NETLBL_NLTYPE_UNLABELED;
+	return 0;
+
+unlabel_getattr_nolabel:
+	rcu_read_unlock();
 	if (netlabel_unlabel_acceptflg == 0)
 		return -ENOMSG;
-	netlbl_secattr_init(secattr);
 	secattr->type = NETLBL_NLTYPE_UNLABELED;
 	return 0;
 }
diff --git a/net/netlabel/netlabel_unlabeled.h b/net/netlabel/netlabel_unlabeled.h
index c2917fb..06b1301 100644
--- a/net/netlabel/netlabel_unlabeled.h
+++ b/net/netlabel/netlabel_unlabeled.h
@@ -36,6 +36,116 @@
 /*
  * The following NetLabel payloads are supported by the Unlabeled subsystem.
  *
+ * o STATICADD
+ *   This message is sent from an application to add a new static label for
+ *   incoming unlabeled connections.
+ *
+ *   Required attributes:
+ *
+ *     NLBL_UNLABEL_A_IFACE
+ *     NLBL_UNLABEL_A_SECCTX
+ *
+ *   If IPv4 is specified the following attributes are required:
+ *
+ *     NLBL_UNLABEL_A_IPV4ADDR
+ *     NLBL_UNLABEL_A_IPV4MASK
+ *
+ *   If IPv6 is specified the following attributes are required:
+ *
+ *     NLBL_UNLABEL_A_IPV6ADDR
+ *     NLBL_UNLABEL_A_IPV6MASK
+ *
+ * o STATICREMOVE
+ *   This message is sent from an application to remove an existing static
+ *   label for incoming unlabeled connections.
+ *
+ *   Required attributes:
+ *
+ *     NLBL_UNLABEL_A_IFACE
+ *
+ *   If IPv4 is specified the following attributes are required:
+ *
+ *     NLBL_UNLABEL_A_IPV4ADDR
+ *     NLBL_UNLABEL_A_IPV4MASK
+ *
+ *   If IPv6 is specified the following attributes are required:
+ *
+ *     NLBL_UNLABEL_A_IPV6ADDR
+ *     NLBL_UNLABEL_A_IPV6MASK
+ *
+ * o STATICLIST
+ *   This message can be sent either from an application or by the kernel in
+ *   response to an application generated STATICLIST message.  When sent by an
+ *   application there is no payload and the NLM_F_DUMP flag should be set.
+ *   The kernel should response with a series of the following messages.
+ *
+ *   Required attributes:
+ *
+ *     NLBL_UNLABEL_A_IFACE
+ *     NLBL_UNLABEL_A_SECCTX
+ *
+ *   If IPv4 is specified the following attributes are required:
+ *
+ *     NLBL_UNLABEL_A_IPV4ADDR
+ *     NLBL_UNLABEL_A_IPV4MASK
+ *
+ *   If IPv6 is specified the following attributes are required:
+ *
+ *     NLBL_UNLABEL_A_IPV6ADDR
+ *     NLBL_UNLABEL_A_IPV6MASK
+ *
+ * o STATICADDDEF
+ *   This message is sent from an application to set the default static
+ *   label for incoming unlabeled connections.
+ *
+ *   Required attribute:
+ *
+ *     NLBL_UNLABEL_A_SECCTX
+ *
+ *   If IPv4 is specified the following attributes are required:
+ *
+ *     NLBL_UNLABEL_A_IPV4ADDR
+ *     NLBL_UNLABEL_A_IPV4MASK
+ *
+ *   If IPv6 is specified the following attributes are required:
+ *
+ *     NLBL_UNLABEL_A_IPV6ADDR
+ *     NLBL_UNLABEL_A_IPV6MASK
+ *
+ * o STATICREMOVEDEF
+ *   This message is sent from an application to remove the existing default
+ *   static label for incoming unlabeled connections.
+ *
+ *   If IPv4 is specified the following attributes are required:
+ *
+ *     NLBL_UNLABEL_A_IPV4ADDR
+ *     NLBL_UNLABEL_A_IPV4MASK
+ *
+ *   If IPv6 is specified the following attributes are required:
+ *
+ *     NLBL_UNLABEL_A_IPV6ADDR
+ *     NLBL_UNLABEL_A_IPV6MASK
+ *
+ * o STATICLISTDEF
+ *   This message can be sent either from an application or by the kernel in
+ *   response to an application generated STATICLISTDEF message.  When sent by
+ *   an application there is no payload and the NLM_F_DUMP flag should be set.
+ *   The kernel should response with the following message.
+ *
+ *   Required attribute:
+ *
+ *     NLBL_UNLABEL_A_SECCTX
+ *
+ *   If IPv4 is specified the following attributes are required:
+ *
+ *     NLBL_UNLABEL_A_IPV4ADDR
+ *     NLBL_UNLABEL_A_IPV4MASK
+ *
+ *   If IPv6 is specified the following attributes are required:
+ *
+ *     NLBL_UNLABEL_A_IPV6ADDR
+ *     NLBL_UNLABEL_A_IPV6MASK
+ *
  * o ACCEPT
  *   This message is sent from an application to specify if the kernel should
  *   allow unlabled packets to pass if they do not match any of the static
@@ -62,6 +172,12 @@ enum {
 	NLBL_UNLABEL_C_UNSPEC,
 	NLBL_UNLABEL_C_ACCEPT,
 	NLBL_UNLABEL_C_LIST,
+	NLBL_UNLABEL_C_STATICADD,
+	NLBL_UNLABEL_C_STATICREMOVE,
+	NLBL_UNLABEL_C_STATICLIST,
+	NLBL_UNLABEL_C_STATICADDDEF,
+	NLBL_UNLABEL_C_STATICREMOVEDEF,
+	NLBL_UNLABEL_C_STATICLISTDEF,
 	__NLBL_UNLABEL_C_MAX,
 };
 #define NLBL_UNLABEL_C_MAX (__NLBL_UNLABEL_C_MAX - 1)
@@ -73,6 +189,24 @@ enum {
 	/* (NLA_U8)
 	 * if true then unlabeled packets are allowed to pass, else unlabeled
 	 * packets are rejected */
+	NLBL_UNLABEL_A_IPV6ADDR,
+	/* (NLA_BINARY, struct in6_addr)
+	 * an IPv6 address */
+	NLBL_UNLABEL_A_IPV6MASK,
+	/* (NLA_BINARY, struct in6_addr)
+	 * an IPv6 address mask */
+	NLBL_UNLABEL_A_IPV4ADDR,
+	/* (NLA_BINARY, struct in_addr)
+	 * an IPv4 address */
+	NLBL_UNLABEL_A_IPV4MASK,
+	/* (NLA_BINARY, struct in_addr)
+	 * and IPv4 address mask */
+	NLBL_UNLABEL_A_IFACE,
+	/* (NLA_NULL_STRING)
+	 * network interface */
+	NLBL_UNLABEL_A_SECCTX,
+	/* (NLA_BINARY)
+	 * a LSM specific security context */
 	__NLBL_UNLABEL_A_MAX,
 };
 #define NLBL_UNLABEL_A_MAX (__NLBL_UNLABEL_A_MAX - 1)
@@ -80,8 +214,17 @@ enum {
 /* NetLabel protocol functions */
 int netlbl_unlabel_genl_init(void);
 
+/* Unlabeled connection hash table size */
+/* XXX - currently this number is an uneducated guess */
+#define NETLBL_UNLHSH_BITSIZE       7
+
+/* General Unlabeled init function */
+int netlbl_unlabel_init(u32 size);
+
 /* Process Unlabeled incoming network packets */
-int netlbl_unlabel_getattr(struct netlbl_lsm_secattr *secattr);
+int netlbl_unlabel_getattr(const struct sk_buff *skb,
+			   u16 family,
+			   struct netlbl_lsm_secattr *secattr);
 
 /* Set the default configuration to allow Unlabeled packets */
 int netlbl_unlabel_defconf(void);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
