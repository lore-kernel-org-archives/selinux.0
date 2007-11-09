Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA9LPBwp025168
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 16:25:11 -0500
Received: from palrel12.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA9LPAuu012565
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 21:25:10 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v6 13/13] NetLabel: add auditing to the static labeling
	mechanism
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Fri, 09 Nov 2007 16:25:04 -0500
Message-ID: <20071109212504.31738.86541.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20071109205331.31738.75266.stgit@flek.americas.hpqcorp.net>
References: <20071109205331.31738.75266.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds auditing support to the NetLabel static labeling mechanism.
---

 include/linux/audit.h             |    2 +
 net/netlabel/netlabel_unlabeled.c |  127 +++++++++++++++++++++++++++++++------
 2 files changed, 107 insertions(+), 22 deletions(-)

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
index add0988..30ebb14 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -519,6 +519,7 @@ add_iface_failure:
  * @mask: address mask in network byte order
  * @addr_len: length of address/mask (4 for IPv4, 16 for IPv6)
  * @secid: LSM secid value for the entry
+ * @audit_info: NetLabel audit information
  *
  * Description:
  * Adds a new entry to the unlabeled connection hash table.  Returns zero on
@@ -530,12 +531,18 @@ static int netlbl_unlhsh_add(struct net *net,
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
@@ -562,19 +569,25 @@ static int netlbl_unlhsh_add(struct net *net,
 			goto unlhsh_add_return;
 		}
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
@@ -585,6 +598,16 @@ static int netlbl_unlhsh_add(struct net *net,
 
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
 
@@ -593,6 +616,7 @@ unlhsh_add_return:
  * @iface: interface entry
  * @addr: IP address
  * @mask: IP address mask
+ * @audit_info: NetLabel audit information
  *
  * Description:
  * Remove an IP address entry from the unlabeled connection hash table.
@@ -602,10 +626,14 @@ unlhsh_add_return:
  */
 static int netlbl_unlhsh_remove_addr4(struct netlbl_unlhsh_iface *iface,
 				      const struct in_addr *addr,
-				      const struct in_addr *mask)
+				      const struct in_addr *mask,
+				      struct netlbl_audit *audit_info)
 {
 	int ret_val = -ENOENT;
 	struct netlbl_unlhsh_addr4 *entry;
+	struct audit_buffer *audit_buf = NULL;
+	char *secctx = NULL;
+	u32 secctx_len;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	entry = netlbl_unlhsh_search_addr4(addr->s_addr, iface);
@@ -617,6 +645,21 @@ static int netlbl_unlhsh_remove_addr4(struct netlbl_unlhsh_iface *iface,
 	}
 	spin_unlock(&netlbl_unlhsh_lock);
 
+	audit_buf = netlbl_audit_start_common(AUDIT_MAC_UNLBL_STCDEL,
+					      audit_info);
+	if (audit_buf != NULL) {
+		audit_log_format(audit_buf, " daddr=" NIPQUAD_FMT,
+				 NIPQUAD(entry->addr));
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
@@ -628,6 +671,7 @@ static int netlbl_unlhsh_remove_addr4(struct netlbl_unlhsh_iface *iface,
  * @iface: interface entry
  * @addr: IP address
  * @mask: IP address mask
+ * @audit_info: NetLabel audit information
  *
  * Description:
  * Remove an IP address entry from the unlabeled connection hash table.
@@ -637,10 +681,14 @@ static int netlbl_unlhsh_remove_addr4(struct netlbl_unlhsh_iface *iface,
  */
 static int netlbl_unlhsh_remove_addr6(struct netlbl_unlhsh_iface *iface,
 				      const struct in6_addr *addr,
-				      const struct in6_addr *mask)
+				      const struct in6_addr *mask,
+				      struct netlbl_audit *audit_info)
 {
 	int ret_val = -ENOENT;
 	struct netlbl_unlhsh_addr6 *entry;
+	struct audit_buffer *audit_buf = NULL;
+	char *secctx = NULL;
+	u32 secctx_len;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	entry = netlbl_unlhsh_search_addr6(addr, iface);
@@ -653,6 +701,21 @@ static int netlbl_unlhsh_remove_addr6(struct netlbl_unlhsh_iface *iface,
 	}
 	spin_unlock(&netlbl_unlhsh_lock);
 
+	audit_buf = netlbl_audit_start_common(AUDIT_MAC_UNLBL_STCDEL,
+					      audit_info);
+	if (audit_buf != NULL) {
+		audit_log_format(audit_buf, " daddr=" NIP6_FMT,
+				 NIP6(entry->addr));
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
@@ -703,6 +766,7 @@ unlhsh_condremove_failure:
  * @addr: IP address in network byte order
  * @mask: address mask in network byte order
  * @addr_len: length of address/mask (4 for IPv4, 16 for IPv6)
+ * @audit_info: NetLabel audit information
  *
  * Description:
  * Removes and existing entry from the unlabeled connection hash table.
@@ -713,7 +777,8 @@ static int netlbl_unlhsh_remove(struct net *net,
 				const char *dev_name,
 				const void *addr,
 				const void *mask,
-				u32 addr_len)
+				u32 addr_len,
+				struct netlbl_audit *audit_info)
 {
 	int ret_val;
 	struct net_device *dev;
@@ -740,15 +805,13 @@ static int netlbl_unlhsh_remove(struct net *net,
 	}
 	switch (addr_len) {
 	case sizeof(struct in_addr):
-		ret_val = netlbl_unlhsh_remove_addr4(iface,
-						     (struct in_addr *)addr,
-						     (struct in_addr *)mask);
+		ret_val = netlbl_unlhsh_remove_addr4(iface, addr, mask,
+						     audit_info);
 		break;
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 	case sizeof(struct in6_addr):
-		ret_val = netlbl_unlhsh_remove_addr6(iface,
-						     (struct in6_addr *)addr,
-						     (struct in6_addr *)mask);
+		ret_val = netlbl_unlhsh_remove_addr6(iface, addr, mask,
+						     audit_info);
 		break;
 #endif /* IPv6 */
 	default:
@@ -972,6 +1035,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	void *mask;
 	u32 addr_len;
 	u32 secid;
+	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
 	 * single entry.  However, allow users to create two entries, one each
@@ -985,6 +1049,8 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
 		return -EINVAL;
 
+	netlbl_netlink_auditinfo(skb, &audit_info);
+
 	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
 	if (ret_val != 0)
 		return ret_val;
@@ -996,7 +1062,9 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	if (ret_val != 0)
 		return ret_val;
 
-	return netlbl_unlhsh_add(net, dev_name, addr, mask, addr_len, secid);
+	return netlbl_unlhsh_add(net,
+				 dev_name, addr, mask, addr_len, secid,
+				 &audit_info);
 }
 
 /**
@@ -1019,6 +1087,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	void *mask;
 	u32 addr_len;
 	u32 secid;
+	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
 	 * single entry.  However, allow users to create two entries, one each
@@ -1031,6 +1100,8 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
 		return -EINVAL;
 
+	netlbl_netlink_auditinfo(skb, &audit_info);
+
 	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
 	if (ret_val != 0)
 		return ret_val;
@@ -1041,7 +1112,9 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	if (ret_val != 0)
 		return ret_val;
 
-	return netlbl_unlhsh_add(net, NULL, addr, mask, addr_len, secid);
+	return netlbl_unlhsh_add(net,
+				 NULL, addr, mask, addr_len, secid,
+				 &audit_info);
 }
 
 /**
@@ -1064,6 +1137,7 @@ static int netlbl_unlabel_staticremove(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
+	struct netlbl_audit audit_info;
 
 	/* See the note in netlbl_unlabel_staticadd() about not allowing both
 	 * IPv4 and IPv6 in the same entry. */
@@ -1074,12 +1148,16 @@ static int netlbl_unlabel_staticremove(struct sk_buff *skb,
 	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
 		return -EINVAL;
 
+	netlbl_netlink_auditinfo(skb, &audit_info);
+
 	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
 	if (ret_val != 0)
 		return ret_val;
 	dev_name = nla_data(info->attrs[NLBL_UNLABEL_A_IFACE]);
 
-	return netlbl_unlhsh_remove(net, dev_name, addr, mask, addr_len);
+	return netlbl_unlhsh_remove(net,
+				    dev_name, addr, mask, addr_len,
+				    &audit_info);
 }
 
 /**
@@ -1101,6 +1179,7 @@ static int netlbl_unlabel_staticremovedef(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
+	struct netlbl_audit audit_info;
 
 	/* See the note in netlbl_unlabel_staticadd() about not allowing both
 	 * IPv4 and IPv6 in the same entry. */
@@ -1110,11 +1189,15 @@ static int netlbl_unlabel_staticremovedef(struct sk_buff *skb,
 	       !info->attrs[NLBL_UNLABEL_A_IPV6MASK])))
 		return -EINVAL;
 
+	netlbl_netlink_auditinfo(skb, &audit_info);
+
 	ret_val = netlbl_unlabel_addrinfo_get(info, &addr, &mask, &addr_len);
 	if (ret_val != 0)
 		return ret_val;
 
-	return netlbl_unlhsh_remove(net, NULL, addr, mask, addr_len);
+	return netlbl_unlhsh_remove(net,
+				    NULL, addr, mask, addr_len,
+				    &audit_info);
 }
 
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
