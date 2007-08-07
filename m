Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77EMXfJ028023
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 10:22:33 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l77EMOmT021185
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 14:22:24 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070807141538.944273935@hp.com>
References: <20070807141415.525577324@hp.com>
Date: Tue, 07 Aug 2007 10:14:19 -0400
To: selinux@tycho.nsa.gov
Cc: kaigai@ak.jp.nec.com, joe@nall.com
Subject: [RFC 4/5] NetLabel: introduce static network labels for unlabeled connections
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

---
 include/net/netlabel.h            |    6 
 net/netlabel/netlabel_kapi.c      |   16 
 net/netlabel/netlabel_unlabeled.c | 1168 +++++++++++++++++++++++++++++++++++++-
 net/netlabel/netlabel_unlabeled.h |   90 ++
 4 files changed, 1262 insertions(+), 18 deletions(-)

Index: linux-2.6_staticlbl/include/net/netlabel.h
===================================================================
--- linux-2.6_staticlbl.orig/include/net/netlabel.h
+++ linux-2.6_staticlbl/include/net/netlabel.h
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
Index: linux-2.6_staticlbl/net/netlabel/netlabel_kapi.c
===================================================================
--- linux-2.6_staticlbl.orig/net/netlabel/netlabel_kapi.c
+++ linux-2.6_staticlbl/net/netlabel/netlabel_kapi.c
@@ -311,7 +311,7 @@ socket_setattr_return:
  * @secattr: the security attributes
  *
  * Description:
- * Examines the given sock to see any NetLabel style labeling has been
+ * Examines the given sock to see if any NetLabel style labeling has been
  * applied to the sock, if so it parses the socket label and returns the
  * security attributes in @secattr.  Returns zero on success, negative values
  * on failure.
@@ -319,13 +319,7 @@ socket_setattr_return:
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
@@ -349,7 +343,7 @@ int netlbl_skbuff_getattr(const struct s
 	    cipso_v4_skbuff_getattr(skb, secattr) == 0)
 		return 0;
 
-	return netlbl_unlabel_getattr(secattr);
+	return netlbl_unlabel_getattr(skb, family, secattr);
 }
 
 /**
@@ -433,6 +427,10 @@ static int __init netlbl_init(void)
 	if (ret_val != 0)
 		goto init_failure;
 
+	ret_val = netlbl_unlabel_init(NETLBL_UNLHSH_BITSIZE);
+	if (ret_val != 0)
+		goto init_failure;
+
 	ret_val = netlbl_netlink_init();
 	if (ret_val != 0)
 		goto init_failure;
Index: linux-2.6_staticlbl/net/netlabel/netlabel_unlabeled.c
===================================================================
--- linux-2.6_staticlbl.orig/net/netlabel/netlabel_unlabeled.c
+++ linux-2.6_staticlbl/net/netlabel/netlabel_unlabeled.c
@@ -36,9 +36,18 @@
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
+#include <net/ip.h>
+#include <net/ipv6.h>
 
 #include <net/netlabel.h>
 #include <asm/bug.h>
@@ -46,12 +55,68 @@
 #include "netlabel_user.h"
 #include "netlabel_domainhash.h"
 #include "netlabel_unlabeled.h"
+#include "netlabel_mgmt.h"
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
+/* XXX - updates should be so rare that having one spinlock for the entire
+ * hash table should be okay */
+static DEFINE_SPINLOCK(netlbl_unlhsh_lock);
+static struct netlbl_unlhsh_tbl *netlbl_unlhsh = NULL;
 
 /* Accept unlabeled packets flag */
 static DEFINE_SPINLOCK(netlabel_unlabel_acceptflg_lock);
 static u8 netlabel_unlabel_acceptflg = 0;
 
-/* NetLabel Generic NETLINK CIPSOv4 family */
+/* NetLabel Generic NETLINK unlabeled family */
 static struct genl_family netlbl_unlabel_gnl_family = {
 	.id = GENL_ID_GENERATE,
 	.hdrsize = 0,
@@ -63,10 +128,763 @@ static struct genl_family netlbl_unlabel
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
+
+	iface = container_of(entry, struct netlbl_unlhsh_iface, rcu);
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
+	/* We could use ipv6_masked_addr_cmp() below, but our way should be a
+	 * bit quicker and we want this to be fast. */
+	list_for_each_entry_rcu(iter, &iface->addr6_list, list)
+		if (iter->valid &&
+		    ((addr->s6_addr32[0] & iter->mask.s6_addr32[0])
+		     == iter->addr.s6_addr32[0]) &&
+		    ((addr->s6_addr32[1] & iter->mask.s6_addr32[1])
+		     == iter->addr.s6_addr32[1]) &&
+		    ((addr->s6_addr32[2] & iter->mask.s6_addr32[2])
+		     == iter->addr.s6_addr32[2]) &&
+		    ((addr->s6_addr32[3] & iter->mask.s6_addr32[3])
+		     == iter->addr.s6_addr32[3]))
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
+ * interface entry which matches @ifindex.  If no match is found the NULL is
+ * returned.  The caller is responsible for calling the rcu_read_[un]lock()
+ * functions.
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
+ * netlbl_unlhsh_search - Search for a matching unlabeled connection entry
+ * @skb: the incoming packet
+ * @family: protocol family
+ *
+ * Description:
+ * Searches through the unlabeled connection hash table to find an entry which
+ * matches the packet specified by @skb.  If a matching entry is found the
+ * secid token for that entry is returned, otherwise zero if returned.  The
+ * caller is responsible for calling the rcu_read_[un]lock() functions.
+ *
+ */
+static u32 netlbl_unlhsh_search(const struct sk_buff *skb, u16 family)
+{
+	struct iphdr *hdr4;
+	struct ipv6hdr *hdr6;
+	struct netlbl_unlhsh_addr4 *addr4;
+	struct netlbl_unlhsh_addr6 *addr6;
+	struct netlbl_unlhsh_iface *iface;
+
+	iface = netlbl_unlhsh_search_iface(skb->iif);
+	if (iface == NULL)
+		return 0;
+
+	switch (family) {
+	case PF_INET:
+		hdr4 = ip_hdr(skb);
+		addr4 = netlbl_unlhsh_search_addr4(hdr4->saddr, iface);
+		if (addr4 != NULL)
+			return addr4->secid;
+		break;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	case PF_INET6:
+		hdr6 = ipv6_hdr(skb);
+		addr6 = netlbl_unlhsh_search_addr6(&hdr6->saddr, iface);
+		if (addr6 != NULL)
+			return addr6->secid;
+		break;
+#endif /* IPv6 */
+	}
+
+	return 0;
+}
+
+/**
+ * netlbl_unlhsh_walk - Iterate through the unlabeled connection hash table
+ * @skip_bkt: the number of hash buckets to skip at the start
+ * @skip_chain: the number of interface entries to skip
+ * @skip_addr4: the number of IPv4 entries to skip
+ * @skip_addr6: the number of IPv6 entries to skip
+ * @callback: callback for each entry
+ * @cb_arg: argument for the callback function
+ *
+ * Description:
+ * Iterate ove the unlabeled connection hash table, while first skipping over
+ * a number of entries.  For each entry in the table call @callback, if the
+ * callback function return a negative value stop 'walking' through the table
+ * and return.  Updates the values in @skip_bkt, @skip_chain, @skip_addr4, and
+ * @skip_addr6 on return.  Returns zero on success, negative values on failure.
+ *
+ */
+static int netlbl_unlhsh_walk(u32 *skip_bkt,
+			      u32 *skip_chain,
+			      u32 *skip_addr4,
+			      u32 *skip_addr6,
+			      int (*callback)
+			              (const struct netlbl_unlhsh_iface *iface,
+				       const struct netlbl_unlhsh_addr4 *addr4,
+				       const struct netlbl_unlhsh_addr6 *addr6,
+				       void *arg),
+			      void *cb_arg)
+{
+	int ret_val = -ENOENT;
+	u32 iter_bkt;
+	u32 iter_chain = 0;
+	u32 iter_addr4 = 0;
+	u32 iter_addr6 = 0;
+	struct netlbl_unlhsh_iface *iface;
+	struct netlbl_unlhsh_addr4 *addr4;
+	struct netlbl_unlhsh_addr6 *addr6;
+
+	rcu_read_lock();
+	for (iter_bkt = *skip_bkt;
+	     iter_bkt < rcu_dereference(netlbl_unlhsh)->size;
+	     iter_bkt++, iter_chain = 0, iter_addr4 = 0, iter_addr6 = 0) {
+		list_for_each_entry_rcu(iface,
+			        &rcu_dereference(netlbl_unlhsh)->tbl[iter_bkt],
+				list)
+			if (iface->valid) {
+				if (iter_chain++ < *skip_chain)
+					continue;
+				list_for_each_entry_rcu(addr4,
+							&iface->addr4_list,
+							list)
+					if (addr4->valid) {
+						if (iter_addr4++ < *skip_addr4)
+							continue;
+						ret_val = callback(iface,
+								   addr4,
+								   NULL,
+								   cb_arg);
+						if (ret_val < 0) {
+						       iter_addr4--;
+						       iter_chain--;
+						       goto unlhsh_walk_return;
+						}
+					}
+				list_for_each_entry_rcu(addr6,
+							&iface->addr6_list,
+							list)
+					if (addr6->valid) {
+						if (iter_addr6++ < *skip_addr6)
+							continue;
+						ret_val = callback(iface,
+								   NULL,
+								   addr6,
+								   cb_arg);
+						if (ret_val < 0) {
+						       iter_addr6--;
+						       iter_chain--;
+						       goto unlhsh_walk_return;
+						}
+					}
+			}
+	}
+
+unlhsh_walk_return:
+	rcu_read_unlock();
+	*skip_bkt = iter_bkt;
+	*skip_chain = iter_chain;
+	*skip_addr4 = iter_addr4;
+	*skip_addr6 = iter_addr6;
+	return ret_val;
+
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
+ */
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
+	if (netlbl_unlhsh_search_addr4(entry->addr, iface) != NULL) {
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
+	if (netlbl_unlhsh_search_addr6(&entry->addr, iface) != NULL) {
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
+		    memcmp(&entry->mask.s6_addr,
+			   &iter->mask.s6_addr,
+			   16) > 0) {
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
+	bkt = netlbl_unlhsh_hash(ifindex);
+	spin_lock(&netlbl_unlhsh_lock);
+	if (netlbl_unlhsh_search_iface(ifindex) != NULL) {
+		spin_unlock(&netlbl_unlhsh_lock);
+		kfree(iface);
+		return NULL;
+	}
+	list_add_tail_rcu(&iface->list,
+			  &rcu_dereference(netlbl_unlhsh)->tbl[bkt]);
+	spin_unlock(&netlbl_unlhsh_lock);
+
+	return iface;
+}
+
+/**
+ * netlbl_unlhsh_add - Adds a new entry to the unlabeled connection hash table
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
+static int netlbl_unlhsh_add(const char *dev_name,
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
+	dev = dev_get_by_name(dev_name);
+	if (dev == NULL)
+		return -ENODEV;
+	ifindex = dev->ifindex;
+	dev_put(dev);
+
+	rcu_read_lock();
+	iface = netlbl_unlhsh_search_iface(ifindex);
+	if (iface == NULL)
+		iface = netlbl_unlhsh_add_iface(ifindex);
+	if (iface == NULL) {
+		rcu_read_unlock();
+		return -ENOMEM;
+	}
+	switch (addr_len) {
+	case sizeof(struct in_addr):
+		ret_val = netlbl_unlhsh_add_addr4(iface,
+						  (struct in_addr *)addr,
+						  (struct in_addr *)mask,
+						  secid);
+		break;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	case sizeof(struct in6_addr):
+		ret_val = netlbl_unlhsh_add_addr6(iface,
+						  (struct in6_addr *)addr,
+						  (struct in6_addr *)mask,
+						  secid);
+		break;
+#endif /* IPv6 */
+	default:
+		ret_val = -EINVAL;
+	}
+	rcu_read_unlock();
+
+	if (ret_val == 0)
+		netlbl_mgmt_protocount_inc();
+
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
+	struct netlbl_unlhsh_addr4 *entry;
+
+	spin_lock(&netlbl_unlhsh_lock);
+	entry = netlbl_unlhsh_search_addr4(addr->s_addr, iface);
+	if (entry == NULL ||
+	    (entry->addr != addr->s_addr && entry->mask != mask->s_addr)) {
+		spin_unlock(&netlbl_unlhsh_lock);
+		return -ENOENT;
+	}
+	entry->valid = 0;
+	list_del_rcu(&entry->list);
+	spin_unlock(&netlbl_unlhsh_lock);
+
+	call_rcu(&entry->rcu, netlbl_unlhsh_free_addr4);
+
+	return 0;
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
+	struct netlbl_unlhsh_addr6 *entry;
+
+	spin_lock(&netlbl_unlhsh_lock);
+	entry = netlbl_unlhsh_search_addr6(addr, iface);
+	if (entry == NULL ||
+	    (ipv6_addr_cmp(&entry->addr, addr) != 0 &&
+	     ipv6_addr_cmp(&entry->mask, mask) != 0)) {
+		spin_unlock(&netlbl_unlhsh_lock);
+		return -ENOENT;
+	}
+	entry->valid = 0;
+	list_del_rcu(&entry->list);
+	spin_unlock(&netlbl_unlhsh_lock);
+
+	call_rcu(&entry->rcu, netlbl_unlhsh_free_addr6);
+
+	return 0;
+}
+#endif /* IPv6 */
+
+/**
+ * netlbl_unlhsh_condremove_iface - Remove an interface entry
+ * @ifindex: interface
+ *
+ * Description:
+ * Remove an interface entry from the unlabeled connection hash table if it is
+ * empty.  An interface entry is considered to be empty if there are no
+ * address entries assigned to it.
+ *
+ */
+static void netlbl_unlhsh_condremove_iface(int ifindex)
+{
+	struct netlbl_unlhsh_iface *entry;
+	struct netlbl_unlhsh_addr4 *iter4;
+	struct netlbl_unlhsh_addr6 *iter6;
+
+	spin_lock(&netlbl_unlhsh_lock);
+	entry = netlbl_unlhsh_search_iface(ifindex);
+	if (entry == NULL || entry->ifindex != ifindex)
+		goto unlhsh_condremove_failure;
+	list_for_each_entry_rcu(iter4, &entry->addr4_list, list)
+		if (iter4->valid)
+			goto unlhsh_condremove_failure;
+	list_for_each_entry_rcu(iter6, &entry->addr6_list, list)
+		if (iter6->valid)
+			goto unlhsh_condremove_failure;
+	entry->valid = 0;
+	list_del_rcu(&entry->list);
+	spin_unlock(&netlbl_unlhsh_lock);
+
+	call_rcu(&entry->rcu, netlbl_unlhsh_free_iface);
+	return;
+
+unlhsh_condremove_failure:
+	spin_unlock(&netlbl_unlhsh_lock);
+}
+
+/**
+ * netlbl_unlhsh_remove - Remove an entry from the unlabeled hash table
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
+static int netlbl_unlhsh_remove(const char *dev_name,
+				const void *addr,
+				const void *mask,
+				u32 addr_len)
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
+	dev = dev_get_by_name(dev_name);
+	if (dev == NULL)
+		return -ENODEV;
+	ifindex = dev->ifindex;
+	dev_put(dev);
+
+	rcu_read_lock();
+	iface = netlbl_unlhsh_search_iface(ifindex);
+	if (iface == NULL) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+	switch (addr_len) {
+	case sizeof(struct in_addr):
+		ret_val = netlbl_unlhsh_remove_addr4(iface,
+						     (struct in_addr *)addr,
+						     (struct in_addr *)mask);
+		break;
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	case sizeof(struct in6_addr):
+		ret_val = netlbl_unlhsh_remove_addr6(iface,
+						     (struct in6_addr *)addr,
+						     (struct in6_addr *)mask);
+		break;
+#endif /* IPv6 */
+	default:
+		ret_val = -EINVAL;
+	}
+	if (ret_val == 0)
+		netlbl_unlhsh_condremove_iface(ifindex);
+	rcu_read_unlock();
+
+	if (ret_val == 0)
+		netlbl_mgmt_protocount_dec();
+
+	return ret_val;
+}
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
+	struct netlbl_unlhsh_iface *iface;
+
+	/* XXX - should this be a check for NETDEV_DOWN or _UNREGISTER? */
+	if (event == NETDEV_DOWN) {
+		rcu_read_lock();
+		iface = netlbl_unlhsh_search_iface(dev->ifindex);
+		if (iface != NULL && iface->valid) {
+			spin_lock(&netlbl_unlhsh_lock);
+			iface->valid = 0;
+			list_del_rcu(&iface->list);
+			spin_unlock(&netlbl_unlhsh_lock);
+
+			call_rcu(&iface->rcu, netlbl_unlhsh_free_iface);
+		}
+		rcu_read_unlock();
+	}
+
+	return NOTIFY_DONE;
+}
+
+/*
+ * General Helper Functions
  */
 
 /**
@@ -177,11 +995,276 @@ list_failure:
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
+	if (info->attrs[NLBL_UNLABEL_A_IPV4ADDR]) {
+		addr_len = nla_len(info->attrs[NLBL_UNLABEL_A_IPV4ADDR]);
+		if (addr_len != sizeof(struct in_addr) &&
+		    addr_len != nla_len(info->attrs[NLBL_UNLABEL_A_IPV4MASK]))
+			return -EINVAL;
+		addr = nla_data(info->attrs[NLBL_UNLABEL_A_IPV4ADDR]);
+		mask = nla_data(info->attrs[NLBL_UNLABEL_A_IPV4MASK]);
+	} else {
+		addr_len = nla_len(info->attrs[NLBL_UNLABEL_A_IPV6ADDR]);
+		if (addr_len != sizeof(struct in6_addr) &&
+		    addr_len != nla_len(info->attrs[NLBL_UNLABEL_A_IPV6MASK]))
+			return -EINVAL;
+		addr = nla_data(info->attrs[NLBL_UNLABEL_A_IPV6ADDR]);
+		mask = nla_data(info->attrs[NLBL_UNLABEL_A_IPV6MASK]);
+	}
+	dev_name = nla_data(info->attrs[NLBL_UNLABEL_A_IFACE]);
+	ret_val = security_secctx_to_secid(
+		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
+				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
+				  &secid);
+	if (ret_val != 0)
+		return ret_val;
+
+	return netlbl_unlhsh_add(dev_name, addr, mask, addr_len, secid);
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
+	if (info->attrs[NLBL_UNLABEL_A_IPV4ADDR]) {
+		addr_len = nla_len(info->attrs[NLBL_UNLABEL_A_IPV4ADDR]);
+		if (addr_len != sizeof(struct in_addr) &&
+		    addr_len != nla_len(info->attrs[NLBL_UNLABEL_A_IPV4MASK]))
+			return -EINVAL;
+		addr = nla_data(info->attrs[NLBL_UNLABEL_A_IPV4ADDR]);
+		mask = nla_data(info->attrs[NLBL_UNLABEL_A_IPV4MASK]);
+	} else {
+		addr_len = nla_len(info->attrs[NLBL_UNLABEL_A_IPV6ADDR]);
+		if (addr_len != sizeof(struct in6_addr) &&
+		    addr_len != nla_len(info->attrs[NLBL_UNLABEL_A_IPV6MASK]))
+			return -EINVAL;
+		addr = nla_data(info->attrs[NLBL_UNLABEL_A_IPV6ADDR]);
+		mask = nla_data(info->attrs[NLBL_UNLABEL_A_IPV6MASK]);
+	}
+	dev_name = nla_data(info->attrs[NLBL_UNLABEL_A_IFACE]);
+
+	return netlbl_unlhsh_remove(dev_name, addr, mask, addr_len);
+}
+
+/**
+ * netlbl_unlabel_list_cb - netlbl_unlhsh_walk() callback for STATICLIST
+ * @iface: the interface entry
+ * @addr4: the IPv4 address entry
+ * @addr6: the IPv6 address entry
+ * @arg: the netlbl_unlhsh_walk_arg structure
+ *
+ * Description:
+ * This function is designed to be used as a callback to the
+ * netlbl_unlhsh_walk() function for use in generating a response for a
+ * STATICLIST message.  When called either @addr4 or @addr6 can be specified,
+ * not both, the other unspecified entry should be set to NULL by the caller.
+ * Returns the size of the message on success, negative values on failure.
+ *
+ */
+static int netlbl_unlabel_list_cb(const struct netlbl_unlhsh_iface *iface,
+				  const struct netlbl_unlhsh_addr4 *addr4,
+				  const struct netlbl_unlhsh_addr6 *addr6,
+				  void *arg)
+{
+	int ret_val = -ENOMEM;
+	struct net_device *dev;
+	struct netlbl_unlhsh_walk_arg *cb_arg = arg;
+	void *data;
+	u32 secid;
+	char *secctx;
+	u32 secctx_len;
+
+	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).pid,
+			   cb_arg->seq, &netlbl_unlabel_gnl_family,
+			   NLM_F_MULTI, NLBL_UNLABEL_C_STATICLIST);
+	if (data == NULL)
+		goto list_cb_failure;
+
+	dev = dev_get_by_index(iface->ifindex);
+	ret_val = nla_put_string(cb_arg->skb, NLBL_UNLABEL_A_IFACE, dev->name);
+	dev_put(dev);
+	if (ret_val != 0)
+		goto list_cb_failure;
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
+
+	cb_arg.nl_cb = cb;
+	cb_arg.skb = skb;
+	cb_arg.seq = cb->nlh->nlmsg_seq;
+
+	netlbl_unlhsh_walk(&skip_bkt,
+			   &skip_chain,
+			   &skip_addr4,
+			   &skip_addr6,
+			   netlbl_unlabel_list_cb,
+			   &cb_arg);
+
+	cb->args[0] = skip_bkt;
+	cb->args[1] = skip_chain;
+	cb->args[2] = skip_addr4;
+	cb->args[3] = skip_addr6;
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
 static struct genl_ops netlbl_unlabel_genl_c_accept = {
 	.cmd = NLBL_UNLABEL_C_ACCEPT,
 	.flags = GENL_ADMIN_PERM,
@@ -198,7 +1281,6 @@ static struct genl_ops netlbl_unlabel_ge
 	.dumpit = NULL,
 };
 
-
 /*
  * NetLabel Generic NETLINK Protocol Functions
  */
@@ -220,6 +1302,21 @@ int netlbl_unlabel_genl_init(void)
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
 				    &netlbl_unlabel_genl_c_accept);
 	if (ret_val != 0)
 		return ret_val;
@@ -236,8 +1333,58 @@ int netlbl_unlabel_genl_init(void)
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
@@ -245,15 +1392,22 @@ int netlbl_unlabel_genl_init(void)
  * them in @secattr.  Returns zero on success and negative values on failure.
  *
  */
-int netlbl_unlabel_getattr(struct netlbl_lsm_secattr *secattr)
+int netlbl_unlabel_getattr(const struct sk_buff *skb,
+			   u16 family,
+			   struct netlbl_lsm_secattr *secattr)
 {
 	int ret_val;
+	u32 secid;
 
 	rcu_read_lock();
-	if (netlabel_unlabel_acceptflg == 1) {
-		netlbl_secattr_init(secattr);
+	secid = netlbl_unlhsh_search(skb, family);
+	if (secid != 0) {
+		secattr->attr.secid = secid;
+		secattr->flags |= NETLBL_SECATTR_SECID;
+		ret_val = 0;
+	} else if (netlabel_unlabel_acceptflg == 1)
 		ret_val = 0;
-	} else
+	else
 		ret_val = -ENOMSG;
 	rcu_read_unlock();
 
Index: linux-2.6_staticlbl/net/netlabel/netlabel_unlabeled.h
===================================================================
--- linux-2.6_staticlbl.orig/net/netlabel/netlabel_unlabeled.h
+++ linux-2.6_staticlbl/net/netlabel/netlabel_unlabeled.h
@@ -36,6 +36,64 @@
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
  * o ACCEPT
  *   This message is sent from an application to specify if the kernel should
  *   allow unlabled packets to pass if they do not match any of the static
@@ -62,6 +120,9 @@ enum {
 	NLBL_UNLABEL_C_UNSPEC,
 	NLBL_UNLABEL_C_ACCEPT,
 	NLBL_UNLABEL_C_LIST,
+	NLBL_UNLABEL_C_STATICADD,
+	NLBL_UNLABEL_C_STATICREMOVE,
+	NLBL_UNLABEL_C_STATICLIST,
 	__NLBL_UNLABEL_C_MAX,
 };
 #define NLBL_UNLABEL_C_MAX (__NLBL_UNLABEL_C_MAX - 1)
@@ -73,6 +134,24 @@ enum {
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
@@ -80,8 +159,17 @@ enum {
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
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
