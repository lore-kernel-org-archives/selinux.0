Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77EMdeW028049
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 10:22:39 -0400
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l77EMZVa000525
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 14:22:35 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070807141541.382337627@hp.com>
References: <20070807141415.525577324@hp.com>
Date: Tue, 07 Aug 2007 10:14:20 -0400
To: selinux@tycho.nsa.gov
Cc: kaigai@ak.jp.nec.com, joe@nall.com
Subject: [RFC 5/5] NetLabel: add auditing to the static labeling mechanism
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds auditing support to the NetLabel static labeling mechanism.

---
 include/linux/audit.h             |    2 
 net/netlabel/netlabel_unlabeled.c |   91 ++++++++++++++++++++++++++++++--------
 2 files changed, 75 insertions(+), 18 deletions(-)

Index: linux-2.6_staticlbl/include/linux/audit.h
===================================================================
--- linux-2.6_staticlbl.orig/include/linux/audit.h
+++ linux-2.6_staticlbl/include/linux/audit.h
@@ -112,6 +112,8 @@
 #define AUDIT_MAC_IPSEC_DELSA	1412	/* Delete a XFRM state */
 #define AUDIT_MAC_IPSEC_ADDSPD	1413	/* Add a XFRM policy */
 #define AUDIT_MAC_IPSEC_DELSPD	1414	/* Delete a XFRM policy */
+#define AUDIT_MAC_UNLBL_STCADD	1415	/* NetLabel: add a static label */
+#define AUDIT_MAC_UNLBL_STCDEL	1416	/* NetLabel: del a static label */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
Index: linux-2.6_staticlbl/net/netlabel/netlabel_unlabeled.c
===================================================================
--- linux-2.6_staticlbl.orig/net/netlabel/netlabel_unlabeled.c
+++ linux-2.6_staticlbl/net/netlabel/netlabel_unlabeled.c
@@ -613,6 +613,7 @@ static struct netlbl_unlhsh_iface *netlb
  * @mask: address mask in network byte order
  * @addr_len: length of address/mask (4 for IPv4, 16 for IPv6)
  * @secid: LSM secid value for the entry
+ * @audit_info: NetLabel audit information
  *
  * Description:
  * Adds a new entry to the unlabeled connection hash table.  Returns zero on
@@ -623,12 +624,18 @@ static int netlbl_unlhsh_add(const char 
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
@@ -648,24 +655,40 @@ static int netlbl_unlhsh_add(const char 
 		rcu_read_unlock();
 		return -ENOMEM;
 	}
+	audit_buf = netlbl_audit_start_common(AUDIT_MAC_UNLBL_STCADD,
+					      audit_info);
 	switch (addr_len) {
 	case sizeof(struct in_addr):
-		ret_val = netlbl_unlhsh_add_addr4(iface,
-						  (struct in_addr *)addr,
-						  (struct in_addr *)mask,
-						  secid);
+		addr4 = (struct in_addr *)addr;
+		mask4 = (struct in_addr *)mask;
+		ret_val = netlbl_unlhsh_add_addr4(iface, addr4, mask4, secid);
+		if (audit_buf != NULL)
+			audit_log_format(audit_buf, " daddr=" NIPQUAD_FMT,
+					 NIPQUAD(addr4->s_addr));
 		break;
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 	case sizeof(struct in6_addr):
-		ret_val = netlbl_unlhsh_add_addr6(iface,
-						  (struct in6_addr *)addr,
-						  (struct in6_addr *)mask,
-						  secid);
+		addr6 = (struct in6_addr *)addr;
+		mask6 = (struct in6_addr *)mask;
+		ret_val = netlbl_unlhsh_add_addr6(iface, addr6, mask6, secid);
+		if (audit_buf != NULL)
+			audit_log_format(audit_buf, " daddr= " NIP6_FMT,
+					 NIP6(*addr6));
 		break;
 #endif /* IPv6 */
 	default:
 		ret_val = -EINVAL;
 	}
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
 	rcu_read_unlock();
 
 	if (ret_val == 0)
@@ -788,6 +811,7 @@ unlhsh_condremove_failure:
  * @addr: IP address in network byte order
  * @mask: address mask in network byte order
  * @addr_len: length of address/mask (4 for IPv4, 16 for IPv6)
+ * @audit_info: NetLabel audit information
  *
  * Description:
  * Removes and existing entry from the unlabeled connection hash table.
@@ -797,12 +821,16 @@ unlhsh_condremove_failure:
 static int netlbl_unlhsh_remove(const char *dev_name,
 				const void *addr,
 				const void *mask,
-				u32 addr_len)
+				u32 addr_len,
+				struct netlbl_audit *audit_info)
 {
 	int ret_val;
 	int ifindex;
 	struct net_device *dev;
 	struct netlbl_unlhsh_iface *iface;
+	struct in_addr *addr4, *mask4;
+	struct in6_addr *addr6, *mask6;
+	struct audit_buffer *audit_buf = NULL;
 
 	if (addr_len != sizeof(struct in_addr) &&
 	    addr_len != sizeof(struct in6_addr))
@@ -820,22 +848,34 @@ static int netlbl_unlhsh_remove(const ch
 		rcu_read_unlock();
 		return -ENOENT;
 	}
+	audit_buf = netlbl_audit_start_common(AUDIT_MAC_UNLBL_STCDEL,
+					      audit_info);
 	switch (addr_len) {
 	case sizeof(struct in_addr):
-		ret_val = netlbl_unlhsh_remove_addr4(iface,
-						     (struct in_addr *)addr,
-						     (struct in_addr *)mask);
+		addr4 = (struct in_addr *)addr;
+		mask4 = (struct in_addr *)mask;
+		ret_val = netlbl_unlhsh_remove_addr4(iface, addr4, mask4);
+		if (audit_buf != NULL)
+			audit_log_format(audit_buf, " daddr=" NIPQUAD_FMT,
+					 NIPQUAD(addr4->s_addr));
 		break;
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 	case sizeof(struct in6_addr):
-		ret_val = netlbl_unlhsh_remove_addr6(iface,
-						     (struct in6_addr *)addr,
-						     (struct in6_addr *)mask);
+		addr6 = (struct in6_addr *)addr;
+		mask6 = (struct in6_addr *)mask;
+		ret_val = netlbl_unlhsh_remove_addr6(iface, addr6, mask6);
+		if (audit_buf != NULL)
+			audit_log_format(audit_buf, " daddr= " NIP6_FMT,
+					 NIP6(*addr6));
 		break;
 #endif /* IPv6 */
 	default:
 		ret_val = -EINVAL;
 	}
+	if (audit_buf != NULL) {
+		audit_log_format(audit_buf, " res=%u", ret_val == 0 ? 1 : 0);
+		audit_log_end(audit_buf);
+	}
 	if (ret_val == 0)
 		netlbl_unlhsh_condremove_iface(ifindex);
 	rcu_read_unlock();
@@ -1015,6 +1055,7 @@ static int netlbl_unlabel_staticadd(stru
 	void *mask;
 	u32 addr_len;
 	u32 secid;
+	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
 	 * single entry.  However, allow users to create two entries, one each
@@ -1028,6 +1069,8 @@ static int netlbl_unlabel_staticadd(stru
 	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
 		return -EINVAL;
 
+	netlbl_netlink_auditinfo(skb, &audit_info);
+
 	if (info->attrs[NLBL_UNLABEL_A_IPV4ADDR]) {
 		addr_len = nla_len(info->attrs[NLBL_UNLABEL_A_IPV4ADDR]);
 		if (addr_len != sizeof(struct in_addr) &&
@@ -1051,7 +1094,12 @@ static int netlbl_unlabel_staticadd(stru
 	if (ret_val != 0)
 		return ret_val;
 
-	return netlbl_unlhsh_add(dev_name, addr, mask, addr_len, secid);
+	return netlbl_unlhsh_add(dev_name,
+				 addr,
+				 mask,
+				 addr_len,
+				 secid,
+				 &audit_info);
 }
 
 /**
@@ -1072,6 +1120,7 @@ static int netlbl_unlabel_staticremove(s
 	void *addr;
 	void *mask;
 	u32 addr_len;
+	struct netlbl_audit audit_info;
 
 	/* See the note in netlbl_unlabel_staticadd() about not allowing both
 	 * IPv4 and IPv6 in the same entry. */
@@ -1082,6 +1131,8 @@ static int netlbl_unlabel_staticremove(s
 	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
 		return -EINVAL;
 
+	netlbl_netlink_auditinfo(skb, &audit_info);
+
 	if (info->attrs[NLBL_UNLABEL_A_IPV4ADDR]) {
 		addr_len = nla_len(info->attrs[NLBL_UNLABEL_A_IPV4ADDR]);
 		if (addr_len != sizeof(struct in_addr) &&
@@ -1099,7 +1150,11 @@ static int netlbl_unlabel_staticremove(s
 	}
 	dev_name = nla_data(info->attrs[NLBL_UNLABEL_A_IFACE]);
 
-	return netlbl_unlhsh_remove(dev_name, addr, mask, addr_len);
+	return netlbl_unlhsh_remove(dev_name,
+				    addr,
+				    mask,
+				    addr_len,
+				    &audit_info);
 }
 
 /**

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
