Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0HKvOgI018226
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 15:57:24 -0500
Received: from g4t0016.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0HKvNGS004298
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 20:57:23 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v12 16/18] NetLabel: Add auditing to the static labeling
	mechanism
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Thu, 17 Jan 2008 15:57:05 -0500
Message-ID: <20080117205705.21013.90800.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20080117204653.21013.77930.stgit@flek.americas.hpqcorp.net>
References: <20080117204653.21013.77930.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds auditing support to the NetLabel static labeling mechanism.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 include/linux/audit.h             |    2 
 net/netlabel/netlabel_unlabeled.c |  207 ++++++++++++++++++++++++++++++++++---
 2 files changed, 195 insertions(+), 14 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index c687816..bdd6f5d 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -115,6 +115,8 @@
 #define AUDIT_MAC_IPSEC_ADDSPD	1413	/* Not used */
 #define AUDIT_MAC_IPSEC_DELSPD	1414	/* Not used */
 #define AUDIT_MAC_IPSEC_EVENT	1415	/* Audit an IPSec event */
+#define AUDIT_MAC_UNLBL_STCADD	1416	/* NetLabel: add a static label */
+#define AUDIT_MAC_UNLBL_STCDEL	1417	/* NetLabel: del a static label */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index d0c628c..42e81fd 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -147,6 +147,74 @@ static const struct nla_policy netlbl_unlabel_genl_policy[NLBL_UNLABEL_A_MAX + 1
 };
 
 /*
+ * Audit Helper Functions
+ */
+
+/**
+ * netlbl_unlabel_audit_addr4 - Audit an IPv4 address
+ * @audit_buf: audit buffer
+ * @dev: network interface
+ * @addr: IP address
+ * @mask: IP address mask
+ *
+ * Description:
+ * Write the IPv4 address and address mask, if necessary, to @audit_buf.
+ *
+ */
+static void netlbl_unlabel_audit_addr4(struct audit_buffer *audit_buf,
+				     const char *dev,
+				     __be32 addr, __be32 mask)
+{
+	u32 mask_val = ntohl(mask);
+
+	if (dev != NULL)
+		audit_log_format(audit_buf, " netif=%s", dev);
+	audit_log_format(audit_buf, " src=" NIPQUAD_FMT, NIPQUAD(addr));
+	if (mask_val != 0xffffffff) {
+		u32 mask_len = 0;
+		while (mask_val > 0) {
+			mask_val <<= 1;
+			mask_len++;
+		}
+		audit_log_format(audit_buf, " src_prefixlen=%d", mask_len);
+	}
+}
+
+/**
+ * netlbl_unlabel_audit_addr6 - Audit an IPv6 address
+ * @audit_buf: audit buffer
+ * @dev: network interface
+ * @addr: IP address
+ * @mask: IP address mask
+ *
+ * Description:
+ * Write the IPv6 address and address mask, if necessary, to @audit_buf.
+ *
+ */
+static void netlbl_unlabel_audit_addr6(struct audit_buffer *audit_buf,
+				     const char *dev,
+				     const struct in6_addr *addr,
+				     const struct in6_addr *mask)
+{
+	if (dev != NULL)
+		audit_log_format(audit_buf, " netif=%s", dev);
+	audit_log_format(audit_buf, " src=" NIP6_FMT, NIP6(*addr));
+	if (ntohl(mask->s6_addr32[3]) != 0xffffffff) {
+		u32 mask_len = 0;
+		u32 mask_val;
+		int iter = -1;
+		while (ntohl(mask->s6_addr32[++iter]) == 0xffffffff)
+			mask_len += 32;
+		mask_val = ntohl(mask->s6_addr32[iter]);
+		while (mask_val > 0) {
+			mask_val <<= 1;
+			mask_len++;
+		}
+		audit_log_format(audit_buf, " src_prefixlen=%d", mask_len);
+	}
+}
+
+/*
  * Unlabeled Connection Hash Table Functions
  */
 
@@ -530,6 +598,7 @@ add_iface_failure:
  * @mask: address mask in network byte order
  * @addr_len: length of address/mask (4 for IPv4, 16 for IPv6)
  * @secid: LSM secid value for the entry
+ * @audit_info: NetLabel audit information
  *
  * Description:
  * Adds a new entry to the unlabeled connection hash table.  Returns zero on
@@ -541,12 +610,18 @@ static int netlbl_unlhsh_add(struct net *net,
 			     const void *addr,
 			     const void *mask,
 			     u32 addr_len,
-			     u32 secid)
+			     u32 secid,
+			     struct netlbl_audit *audit_info)
 {
 	int ret_val;
 	int ifindex;
 	struct net_device *dev;
 	struct netlbl_unlhsh_iface *iface;
+	struct in_addr *addr4, *mask4;
+	struct in6_addr *addr6, *mask6;
+	struct audit_buffer *audit_buf = NULL;
+	char *secctx = NULL;
+	u32 secctx_len;
 
 	if (addr_len != sizeof(struct in_addr) &&
 	    addr_len != sizeof(struct in6_addr))
@@ -573,13 +648,28 @@ static int netlbl_unlhsh_add(struct net *net,
 			goto unlhsh_add_return;
 		}
 	}
+	audit_buf = netlbl_audit_start_common(AUDIT_MAC_UNLBL_STCADD,
+					      audit_info);
 	switch (addr_len) {
 	case sizeof(struct in_addr):
-		ret_val = netlbl_unlhsh_add_addr4(iface, addr, mask, secid);
+		addr4 = (struct in_addr *)addr;
+		mask4 = (struct in_addr *)mask;
+		ret_val = netlbl_unlhsh_add_addr4(iface, addr4, mask4, secid);
+		if (audit_buf != NULL)
+			netlbl_unlabel_audit_addr4(audit_buf,
+						   dev_name,
+						   addr4->s_addr,
+						   mask4->s_addr);
 		break;
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 	case sizeof(struct in6_addr):
-		ret_val = netlbl_unlhsh_add_addr6(iface, addr, mask, secid);
+		addr6 = (struct in6_addr *)addr;
+		mask6 = (struct in6_addr *)mask;
+		ret_val = netlbl_unlhsh_add_addr6(iface, addr6, mask6, secid);
+		if (audit_buf != NULL)
+			netlbl_unlabel_audit_addr6(audit_buf,
+						   dev_name,
+						   addr6, mask6);
 		break;
 #endif /* IPv6 */
 	default:
@@ -590,14 +680,26 @@ static int netlbl_unlhsh_add(struct net *net,
 
 unlhsh_add_return:
 	rcu_read_unlock();
+	if (audit_buf != NULL) {
+		if (security_secid_to_secctx(secid,
+					     &secctx,
+					     &secctx_len) == 0) {
+			audit_log_format(audit_buf, " sec_obj=%s", secctx);
+			security_release_secctx(secctx, secctx_len);
+		}
+		audit_log_format(audit_buf, " res=%u", ret_val == 0 ? 1 : 0);
+		audit_log_end(audit_buf);
+	}
 	return ret_val;
 }
 
 /**
  * netlbl_unlhsh_remove_addr4 - Remove an IPv4 address entry
+ * @net: network namespace
  * @iface: interface entry
  * @addr: IP address
  * @mask: IP address mask
+ * @audit_info: NetLabel audit information
  *
  * Description:
  * Remove an IP address entry from the unlabeled connection hash table.
@@ -605,12 +707,18 @@ unlhsh_add_return:
  * responsible for calling the rcu_read_[un]lock() functions.
  *
  */
-static int netlbl_unlhsh_remove_addr4(struct netlbl_unlhsh_iface *iface,
+static int netlbl_unlhsh_remove_addr4(struct net *net,
+				      struct netlbl_unlhsh_iface *iface,
 				      const struct in_addr *addr,
-				      const struct in_addr *mask)
+				      const struct in_addr *mask,
+				      struct netlbl_audit *audit_info)
 {
 	int ret_val = -ENOENT;
 	struct netlbl_unlhsh_addr4 *entry;
+	struct audit_buffer *audit_buf = NULL;
+	struct net_device *dev;
+	char *secctx = NULL;
+	u32 secctx_len;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	entry = netlbl_unlhsh_search_addr4(addr->s_addr, iface);
@@ -622,6 +730,25 @@ static int netlbl_unlhsh_remove_addr4(struct netlbl_unlhsh_iface *iface,
 	}
 	spin_unlock(&netlbl_unlhsh_lock);
 
+	audit_buf = netlbl_audit_start_common(AUDIT_MAC_UNLBL_STCDEL,
+					      audit_info);
+	if (audit_buf != NULL) {
+		dev = dev_get_by_index(net, iface->ifindex);
+		netlbl_unlabel_audit_addr4(audit_buf,
+					   (dev != NULL ? dev->name : NULL),
+					   entry->addr, entry->mask);
+		if (dev != NULL)
+			dev_put(dev);
+		if (security_secid_to_secctx(entry->secid,
+					     &secctx,
+					     &secctx_len) == 0) {
+			audit_log_format(audit_buf, " sec_obj=%s", secctx);
+			security_release_secctx(secctx, secctx_len);
+		}
+		audit_log_format(audit_buf, " res=%u", ret_val == 0 ? 1 : 0);
+		audit_log_end(audit_buf);
+	}
+
 	if (ret_val == 0)
 		call_rcu(&entry->rcu, netlbl_unlhsh_free_addr4);
 	return ret_val;
@@ -630,9 +757,11 @@ static int netlbl_unlhsh_remove_addr4(struct netlbl_unlhsh_iface *iface,
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 /**
  * netlbl_unlhsh_remove_addr6 - Remove an IPv6 address entry
+ * @net: network namespace
  * @iface: interface entry
  * @addr: IP address
  * @mask: IP address mask
+ * @audit_info: NetLabel audit information
  *
  * Description:
  * Remove an IP address entry from the unlabeled connection hash table.
@@ -640,12 +769,18 @@ static int netlbl_unlhsh_remove_addr4(struct netlbl_unlhsh_iface *iface,
  * responsible for calling the rcu_read_[un]lock() functions.
  *
  */
-static int netlbl_unlhsh_remove_addr6(struct netlbl_unlhsh_iface *iface,
+static int netlbl_unlhsh_remove_addr6(struct net *net,
+				      struct netlbl_unlhsh_iface *iface,
 				      const struct in6_addr *addr,
-				      const struct in6_addr *mask)
+				      const struct in6_addr *mask,
+				      struct netlbl_audit *audit_info)
 {
 	int ret_val = -ENOENT;
 	struct netlbl_unlhsh_addr6 *entry;
+	struct audit_buffer *audit_buf = NULL;
+	struct net_device *dev;
+	char *secctx = NULL;
+	u32 secctx_len;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	entry = netlbl_unlhsh_search_addr6(addr, iface);
@@ -658,6 +793,25 @@ static int netlbl_unlhsh_remove_addr6(struct netlbl_unlhsh_iface *iface,
 	}
 	spin_unlock(&netlbl_unlhsh_lock);
 
+	audit_buf = netlbl_audit_start_common(AUDIT_MAC_UNLBL_STCDEL,
+					      audit_info);
+	if (audit_buf != NULL) {
+		dev = dev_get_by_index(net, iface->ifindex);
+		netlbl_unlabel_audit_addr6(audit_buf,
+					   (dev != NULL ? dev->name : NULL),
+					   addr, mask);
+		if (dev != NULL)
+			dev_put(dev);
+		if (security_secid_to_secctx(entry->secid,
+					     &secctx,
+					     &secctx_len) == 0) {
+			audit_log_format(audit_buf, " sec_obj=%s", secctx);
+			security_release_secctx(secctx, secctx_len);
+		}
+		audit_log_format(audit_buf, " res=%u", ret_val == 0 ? 1 : 0);
+		audit_log_end(audit_buf);
+	}
+
 	if (ret_val == 0)
 		call_rcu(&entry->rcu, netlbl_unlhsh_free_addr6);
 	return ret_val;
@@ -708,6 +862,7 @@ unlhsh_condremove_failure:
  * @addr: IP address in network byte order
  * @mask: address mask in network byte order
  * @addr_len: length of address/mask (4 for IPv4, 16 for IPv6)
+ * @audit_info: NetLabel audit information
  *
  * Description:
  * Removes and existing entry from the unlabeled connection hash table.
@@ -718,7 +873,8 @@ static int netlbl_unlhsh_remove(struct net *net,
 				const char *dev_name,
 				const void *addr,
 				const void *mask,
-				u32 addr_len)
+				u32 addr_len,
+				struct netlbl_audit *audit_info)
 {
 	int ret_val;
 	struct net_device *dev;
@@ -745,11 +901,15 @@ static int netlbl_unlhsh_remove(struct net *net,
 	}
 	switch (addr_len) {
 	case sizeof(struct in_addr):
-		ret_val = netlbl_unlhsh_remove_addr4(iface, addr, mask);
+		ret_val = netlbl_unlhsh_remove_addr4(net,
+						     iface, addr, mask,
+						     audit_info);
 		break;
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 	case sizeof(struct in6_addr):
-		ret_val = netlbl_unlhsh_remove_addr6(iface, addr, mask);
+		ret_val = netlbl_unlhsh_remove_addr6(net,
+						     iface, addr, mask,
+						     audit_info);
 		break;
 #endif /* IPv6 */
 	default:
@@ -972,6 +1132,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	void *mask;
 	u32 addr_len;
 	u32 secid;
+	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
 	 * single entry.  However, allow users to create two entries, one each
@@ -985,6 +1146,8 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
 		return -EINVAL;
 
+	netlbl_netlink_auditinfo(skb, &audit_info);
+
 	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
 	if (ret_val != 0)
 		return ret_val;
@@ -997,7 +1160,8 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 		return ret_val;
 
 	return netlbl_unlhsh_add(&init_net,
-				 dev_name, addr, mask, addr_len, secid);
+				 dev_name, addr, mask, addr_len, secid,
+				 &audit_info);
 }
 
 /**
@@ -1019,6 +1183,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	void *mask;
 	u32 addr_len;
 	u32 secid;
+	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
 	 * single entry.  However, allow users to create two entries, one each
@@ -1031,6 +1196,8 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
 		return -EINVAL;
 
+	netlbl_netlink_auditinfo(skb, &audit_info);
+
 	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
 	if (ret_val != 0)
 		return ret_val;
@@ -1041,7 +1208,9 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	if (ret_val != 0)
 		return ret_val;
 
-	return netlbl_unlhsh_add(&init_net, NULL, addr, mask, addr_len, secid);
+	return netlbl_unlhsh_add(&init_net,
+				 NULL, addr, mask, addr_len, secid,
+				 &audit_info);
 }
 
 /**
@@ -1063,6 +1232,7 @@ static int netlbl_unlabel_staticremove(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
+	struct netlbl_audit audit_info;
 
 	/* See the note in netlbl_unlabel_staticadd() about not allowing both
 	 * IPv4 and IPv6 in the same entry. */
@@ -1073,12 +1243,16 @@ static int netlbl_unlabel_staticremove(struct sk_buff *skb,
 	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
 		return -EINVAL;
 
+	netlbl_netlink_auditinfo(skb, &audit_info);
+
 	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
 	if (ret_val != 0)
 		return ret_val;
 	dev_name = nla_data(info->attrs[NLBL_UNLABEL_A_IFACE]);
 
-	return netlbl_unlhsh_remove(&init_net, dev_name, addr, mask, addr_len);
+	return netlbl_unlhsh_remove(&init_net,
+				    dev_name, addr, mask, addr_len,
+				    &audit_info);
 }
 
 /**
@@ -1099,6 +1273,7 @@ static int netlbl_unlabel_staticremovedef(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
+	struct netlbl_audit audit_info;
 
 	/* See the note in netlbl_unlabel_staticadd() about not allowing both
 	 * IPv4 and IPv6 in the same entry. */
@@ -1108,11 +1283,15 @@ static int netlbl_unlabel_staticremovedef(struct sk_buff *skb,
 	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
 		return -EINVAL;
 
+	netlbl_netlink_auditinfo(skb, &audit_info);
+
 	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
 	if (ret_val != 0)
 		return ret_val;
 
-	return netlbl_unlhsh_remove(&init_net, NULL, addr, mask, addr_len);
+	return netlbl_unlhsh_remove(&init_net,
+				    NULL, addr, mask, addr_len,
+				    &audit_info);
 }
 
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
