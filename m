Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A5DC10F0E
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FB920851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Uayzkvpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfB1WUK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:10 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:35295
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729903AbfB1WUG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392406; bh=umiA6rgN79wKL8zMFCT2r8i1pODDWRGGU2FW9J8lllI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=UayzkvpyUhfuciipnvfPrKtYkIB7D4axLePMaG3R0eU0B7nE3YfhprNiOlnQ8iV2GQe9K1GnZs+CZML4zFdLDVOVMAPZv4X5jHSQbO/FPN+0cA3NkE3peh8PXEY/U9hK4dITcqIH8ev8G19QChQ8lcFPKn+6tAXj57cV2QLAAW42DIVztAzVLaOzMroSXtvAA7ysZZiKWNrp6NI2VxoHUye/ktn8Q1YPKNxB+Pv+eUpA9ql08uxLVqcC+AsbZRDoQuUuJhH/Uu1cJRhsA30aA+AFQdddyU9xRaF1V8eI/+e3jPicfJGJBccOWslRvFq4acp+KBTo9AJjyq0Xkpvheg==
X-YMail-OSG: 3LUyd18VM1l.p_XnEE35jhnFEAeWH3J33BNxG5V8zEcaKqxdxBHnrKPrvV85TOP
 vwPu4X72Nj4oNTyb5ZkkPmQR2tcm03Cvo1aaPpOJS9C9zD4.85mgOgrVligJ6zV5ifGCo5mBsojV
 LZM7fjY2H40SQRzUzKP9iMKU4YhDg_YPPnJmgO6OnRNLQA8VC5qNVzS31uisfXyFdWcJ8oO1oNtI
 gP1gPKUpQsKlif8YZgibt3ND0YeIA8PYXiRzoUd6BwY3BzAlGaEPuvuZGx.cgiPclu2MfP2KwxxK
 zvHaRZ.p7yCABLZyscbSFLyE1VEJDckbB.OdNCcCY4l1_dG4Pzvf_WB7qys3yb2.h5Q2Lw18G65V
 VEyDmRWc_IyapiRjojacgdX40KpvwOyeoeX7lPqriWzoLcC3XJG_zQxqU7cNUQ6dywzWiQzaWx2v
 chWOtdO2DeNrQWE0Mvzekxlp9buf7XRJCe8cbQqwT49CC3veFRy2gaMNLsCkvC2Ewef71vkOZMl3
 Jpsca2ObPVtbhJsTVnMEFqcP3gURmqd6AcDRfNk1WpydoxZzXq6eEIGu1V0qfr4ZZBoUBjK98j31
 C0pOblXCYEnXFOkmIDoUif.Ltlo14sQ1NyJID6BglAePkueM34m7lMbcONg6jgWkaUXGAjuxDCBS
 S7k9pDJDvNn3uhznclHkaw5sllQkF7nkF7dS7VVI6P1GBmfdafjGuhHNhmGlw4yF5OO8xi1Q6z60
 2j7WUPaX4IUH3s6Ge3gAo3NMe5ay3mkuIncih4baXxGXXhnkVdNOwZk8hN.CMzuOCLsKz81EgF5x
 gSr9eGobCWRHtc8_TOAcxgmXZsqWMkSO_68Oyd87UQ8yfz.wPVXW7rz9H30My5HsD7ZYabNsmIIZ
 0vBoOOIqyzHeSr1xXAah5J0kToCoA3sl2OvzSjhSAe9FoPMZVzur.qRPX2gJowOU0xKOvjdtyCq5
 7UUE33a6Od0gXKwznVs3Y.oJKVVR5voV08n7m53Zqt9F2vD3DA2fb9ecA3I5.9BN88.Mf5eY.4rX
 dp1L2FV2eoXfqWnFfvzSuzAbug.RJK6EcDcXUkXY4xVTf9CwYIvQXHKiTWGaRvqFSM.AGzbiJnid
 6hLXMuFfkg2uEjCBH3aXSvaxhPmrdNQXI5JCjQMC_M.66CLYkCvDwS3KM
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:06 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e8fded081226753664bb344863181a7a;
          Thu, 28 Feb 2019 22:20:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 37/97] Netlabel: Replace secids with lsm_export
Date:   Thu, 28 Feb 2019 14:18:33 -0800
Message-Id: <20190228221933.2551-38-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert to lsm_export structures instead of u32 secids.
Clean out the associated scaffolding. This requires changes
to several internal interfaces, but no change in behavior.

Change the LOC tag type to pass an lsm_export instead of
a single u32. As this tag is only used locally there is
no change to externally exposed interfaces.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/net/netlabel.h            | 10 ++---
 net/ipv4/cipso_ipv4.c             | 13 ++++---
 net/netlabel/netlabel_kapi.c      |  5 +--
 net/netlabel/netlabel_unlabeled.c | 65 ++++++++++++-------------------
 net/netlabel/netlabel_unlabeled.h |  2 +-
 net/netlabel/netlabel_user.c      |  7 +---
 net/netlabel/netlabel_user.h      |  5 +--
 security/selinux/netlabel.c       |  2 +-
 security/selinux/ss/services.c    |  9 +++--
 security/smack/smack_lsm.c        |  5 ++-
 security/smack/smackfs.c          | 12 ++++--
 11 files changed, 63 insertions(+), 72 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 72d6435fc16c..546c75f27d05 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -111,7 +111,7 @@ struct calipso_doi;
 
 /* NetLabel audit information */
 struct netlbl_audit {
-	u32 secid;
+	struct lsm_export le;
 	kuid_t loginuid;
 	unsigned int sessionid;
 };
@@ -180,7 +180,7 @@ struct netlbl_lsm_catmap {
  * @attr.mls: MLS sensitivity label
  * @attr.mls.cat: MLS category bitmap
  * @attr.mls.lvl: MLS sensitivity level
- * @attr.secid: LSM specific secid token
+ * @attr.le: LSM specific data
  *
  * Description:
  * This structure is used to pass security attributes between NetLabel and the
@@ -215,7 +215,7 @@ struct netlbl_lsm_secattr {
 			struct netlbl_lsm_catmap *cat;
 			u32 lvl;
 		} mls;
-		u32 secid;
+		struct lsm_export le;
 	} attr;
 };
 
@@ -429,7 +429,7 @@ int netlbl_cfg_unlbl_static_add(struct net *net,
 				const void *addr,
 				const void *mask,
 				u16 family,
-				u32 secid,
+				struct lsm_export *l,
 				struct netlbl_audit *audit_info);
 int netlbl_cfg_unlbl_static_del(struct net *net,
 				const char *dev_name,
@@ -537,7 +537,7 @@ static inline int netlbl_cfg_unlbl_static_add(struct net *net,
 					      const void *addr,
 					      const void *mask,
 					      u16 family,
-					      u32 secid,
+					      struct lsm_export *l,
 					      struct netlbl_audit *audit_info)
 {
 	return -ENOSYS;
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 777fa3b7fb13..bd6b47fbc1a4 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -122,13 +122,16 @@ int cipso_v4_rbm_strictvalid = 1;
  *
  * 0          8          16         24         32
  * +----------+----------+----------+----------+
- * | 10000000 | 00000110 | 32-bit secid value  |
+ * | 10000000 | 00000110 | SELinux secid       |
  * +----------+----------+----------+----------+
- * | in (host byte order)|
+ * | Smack secid         | AppArmor secid      |
+ * +----------+----------+----------+----------+
+ * | LSM export flags    |
  * +----------+----------+
  *
+ * All secid and flag fields are in host byte order.
  */
-#define CIPSO_V4_TAG_LOC_BLEN         6
+#define CIPSO_V4_TAG_LOC_BLEN         (2 + sizeof(struct lsm_export))
 
 /*
  * Helper Functions
@@ -1480,7 +1483,7 @@ static int cipso_v4_gentag_loc(const struct cipso_v4_doi *doi_def,
 
 	buffer[0] = CIPSO_V4_TAG_LOCAL;
 	buffer[1] = CIPSO_V4_TAG_LOC_BLEN;
-	*(u32 *)&buffer[2] = secattr->attr.secid;
+	memcpy(&buffer[2], &secattr->attr.le, sizeof(secattr->attr.le));
 
 	return CIPSO_V4_TAG_LOC_BLEN;
 }
@@ -1500,7 +1503,7 @@ static int cipso_v4_parsetag_loc(const struct cipso_v4_doi *doi_def,
 				 const unsigned char *tag,
 				 struct netlbl_lsm_secattr *secattr)
 {
-	secattr->attr.secid = *(u32 *)&tag[2];
+	memcpy(&secattr->attr.le, &tag[2], sizeof(secattr->attr.le));
 	secattr->flags |= NETLBL_SECATTR_SECID;
 
 	return 0;
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index ea7c67050792..01b8006c7c55 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -224,7 +224,7 @@ int netlbl_cfg_unlbl_static_add(struct net *net,
 				const void *addr,
 				const void *mask,
 				u16 family,
-				u32 secid,
+				struct lsm_export *l,
 				struct netlbl_audit *audit_info)
 {
 	u32 addr_len;
@@ -243,8 +243,7 @@ int netlbl_cfg_unlbl_static_add(struct net *net,
 	}
 
 	return netlbl_unlhsh_add(net,
-				 dev_name, addr, mask, addr_len,
-				 secid, audit_info);
+				 dev_name, addr, mask, addr_len, l, audit_info);
 }
 
 /**
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 7f245d593c8f..934667e8969c 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -80,7 +80,7 @@ struct netlbl_unlhsh_tbl {
 #define netlbl_unlhsh_addr4_entry(iter) \
 	container_of(iter, struct netlbl_unlhsh_addr4, list)
 struct netlbl_unlhsh_addr4 {
-	u32 secid;
+	struct lsm_export le;
 
 	struct netlbl_af4list list;
 	struct rcu_head rcu;
@@ -88,7 +88,7 @@ struct netlbl_unlhsh_addr4 {
 #define netlbl_unlhsh_addr6_entry(iter) \
 	container_of(iter, struct netlbl_unlhsh_addr6, list)
 struct netlbl_unlhsh_addr6 {
-	u32 secid;
+	struct lsm_export le;
 
 	struct netlbl_af6list list;
 	struct rcu_head rcu;
@@ -244,7 +244,7 @@ static struct netlbl_unlhsh_iface *netlbl_unlhsh_search_iface(int ifindex)
 static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
 				   const struct in_addr *addr,
 				   const struct in_addr *mask,
-				   u32 secid)
+				   struct lsm_export *l)
 {
 	int ret_val;
 	struct netlbl_unlhsh_addr4 *entry;
@@ -256,7 +256,7 @@ static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
 	entry->list.addr = addr->s_addr & mask->s_addr;
 	entry->list.mask = mask->s_addr;
 	entry->list.valid = 1;
-	entry->secid = secid;
+	entry->le = *l;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	ret_val = netlbl_af4list_add(&entry->list, &iface->addr4_list);
@@ -284,7 +284,7 @@ static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
 static int netlbl_unlhsh_add_addr6(struct netlbl_unlhsh_iface *iface,
 				   const struct in6_addr *addr,
 				   const struct in6_addr *mask,
-				   u32 secid)
+				   struct lsm_export *l)
 {
 	int ret_val;
 	struct netlbl_unlhsh_addr6 *entry;
@@ -300,7 +300,7 @@ static int netlbl_unlhsh_add_addr6(struct netlbl_unlhsh_iface *iface,
 	entry->list.addr.s6_addr32[3] &= mask->s6_addr32[3];
 	entry->list.mask = *mask;
 	entry->list.valid = 1;
-	entry->secid = secid;
+	entry->le = *l;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	ret_val = netlbl_af6list_add(&entry->list, &iface->addr6_list);
@@ -379,7 +379,7 @@ int netlbl_unlhsh_add(struct net *net,
 		      const void *addr,
 		      const void *mask,
 		      u32 addr_len,
-		      u32 secid,
+		      struct lsm_export *l,
 		      struct netlbl_audit *audit_info)
 {
 	int ret_val;
@@ -389,7 +389,6 @@ int netlbl_unlhsh_add(struct net *net,
 	struct audit_buffer *audit_buf = NULL;
 	char *secctx = NULL;
 	u32 secctx_len;
-	struct lsm_export le;
 
 	if (addr_len != sizeof(struct in_addr) &&
 	    addr_len != sizeof(struct in6_addr))
@@ -422,7 +421,7 @@ int netlbl_unlhsh_add(struct net *net,
 		const struct in_addr *addr4 = addr;
 		const struct in_addr *mask4 = mask;
 
-		ret_val = netlbl_unlhsh_add_addr4(iface, addr4, mask4, secid);
+		ret_val = netlbl_unlhsh_add_addr4(iface, addr4, mask4, l);
 		if (audit_buf != NULL)
 			netlbl_af4list_audit_addr(audit_buf, 1,
 						  dev_name,
@@ -435,7 +434,7 @@ int netlbl_unlhsh_add(struct net *net,
 		const struct in6_addr *addr6 = addr;
 		const struct in6_addr *mask6 = mask;
 
-		ret_val = netlbl_unlhsh_add_addr6(iface, addr6, mask6, secid);
+		ret_val = netlbl_unlhsh_add_addr6(iface, addr6, mask6, l);
 		if (audit_buf != NULL)
 			netlbl_af6list_audit_addr(audit_buf, 1,
 						  dev_name,
@@ -452,10 +451,7 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		lsm_export_to_all(&le, secid);
-		if (security_secid_to_secctx(&le,
-					     &secctx,
-					     &secctx_len) == 0) {
+		if (security_secid_to_secctx(l, &secctx, &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
 			security_release_secctx(secctx, secctx_len);
 		}
@@ -490,7 +486,6 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 	struct net_device *dev;
 	char *secctx;
 	u32 secctx_len;
-	struct lsm_export le;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	list_entry = netlbl_af4list_remove(addr->s_addr, mask->s_addr,
@@ -510,10 +505,8 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 					  addr->s_addr, mask->s_addr);
 		if (dev != NULL)
 			dev_put(dev);
-		if (entry != NULL)
-			lsm_export_to_all(&le, entry->secid);
 		if (entry != NULL &&
-		    security_secid_to_secctx(&le,
+		    security_secid_to_secctx(&entry->le,
 					     &secctx, &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
 			security_release_secctx(secctx, secctx_len);
@@ -555,7 +548,6 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 	struct net_device *dev;
 	char *secctx;
 	u32 secctx_len;
-	struct lsm_export le;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	list_entry = netlbl_af6list_remove(addr, mask, &iface->addr6_list);
@@ -574,10 +566,8 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 					  addr, mask);
 		if (dev != NULL)
 			dev_put(dev);
-		if (entry != NULL)
-			lsm_export_to_all(&le, entry->secid);
 		if (entry != NULL &&
-		    security_secid_to_secctx(&le,
+		    security_secid_to_secctx(&entry->le,
 					     &secctx, &secctx_len) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s", secctx);
 			security_release_secctx(secctx, secctx_len);
@@ -903,7 +893,6 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
 	struct lsm_export le;
 	struct netlbl_audit audit_info;
 
@@ -932,9 +921,8 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	if (ret_val != 0)
 		return ret_val;
 
-	lsm_export_secid(&le, &secid);
 	return netlbl_unlhsh_add(&init_net,
-				 dev_name, addr, mask, addr_len, secid,
+				 dev_name, addr, mask, addr_len, &le,
 				 &audit_info);
 }
 
@@ -956,7 +944,6 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
 	struct lsm_export le;
 	struct netlbl_audit audit_info;
 
@@ -983,10 +970,8 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	if (ret_val != 0)
 		return ret_val;
 
-	lsm_export_secid(&le, &secid);
 	return netlbl_unlhsh_add(&init_net,
-				 NULL, addr, mask, addr_len, secid,
-				 &audit_info);
+				 NULL, addr, mask, addr_len, &le, &audit_info);
 }
 
 /**
@@ -1097,10 +1082,9 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 	struct netlbl_unlhsh_walk_arg *cb_arg = arg;
 	struct net_device *dev;
 	void *data;
-	u32 secid;
 	char *secctx;
 	u32 secctx_len;
-	struct lsm_export le;
+	struct lsm_export *lep;
 
 	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
 			   cb_arg->seq, &netlbl_unlabel_gnl_family,
@@ -1138,7 +1122,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		if (ret_val != 0)
 			goto list_cb_failure;
 
-		secid = addr4->secid;
+		lep = &addr4->le;
 	} else {
 		ret_val = nla_put_in6_addr(cb_arg->skb,
 					   NLBL_UNLABEL_A_IPV6ADDR,
@@ -1152,11 +1136,10 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		if (ret_val != 0)
 			goto list_cb_failure;
 
-		secid = addr6->secid;
+		lep = &addr6->le;
 	}
 
-	lsm_export_to_all(&le, secid);
-	ret_val = security_secid_to_secctx(&le, &secctx, &secctx_len);
+	ret_val = security_secid_to_secctx(lep, &secctx, &secctx_len);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
@@ -1501,26 +1484,30 @@ int netlbl_unlabel_getattr(const struct sk_buff *skb,
 	case PF_INET: {
 		struct iphdr *hdr4;
 		struct netlbl_af4list *addr4;
+		struct lsm_export *lep;
 
 		hdr4 = ip_hdr(skb);
 		addr4 = netlbl_af4list_search(hdr4->saddr,
 					      &iface->addr4_list);
 		if (addr4 == NULL)
 			goto unlabel_getattr_nolabel;
-		secattr->attr.secid = netlbl_unlhsh_addr4_entry(addr4)->secid;
+		lep = &netlbl_unlhsh_addr4_entry(addr4)->le;
+		secattr->attr.le = *lep;
 		break;
 	}
 #if IS_ENABLED(CONFIG_IPV6)
 	case PF_INET6: {
 		struct ipv6hdr *hdr6;
 		struct netlbl_af6list *addr6;
+		struct lsm_export *lep;
 
 		hdr6 = ipv6_hdr(skb);
 		addr6 = netlbl_af6list_search(&hdr6->saddr,
 					      &iface->addr6_list);
 		if (addr6 == NULL)
 			goto unlabel_getattr_nolabel;
-		secattr->attr.secid = netlbl_unlhsh_addr6_entry(addr6)->secid;
+		lep = &netlbl_unlhsh_addr6_entry(addr6)->le;
+		secattr->attr.le = *lep;
 		break;
 	}
 #endif /* IPv6 */
@@ -1554,13 +1541,11 @@ int __init netlbl_unlabel_defconf(void)
 	int ret_val;
 	struct netlbl_dom_map *entry;
 	struct netlbl_audit audit_info;
-	struct lsm_export le;
 
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_task_getsecid(current, &le);
-	lsm_export_secid(&le, &audit_info.secid);
+	security_task_getsecid(current, &audit_info.le);
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_unlabeled.h b/net/netlabel/netlabel_unlabeled.h
index 3a9e5dc9511b..0803f1e6e3c1 100644
--- a/net/netlabel/netlabel_unlabeled.h
+++ b/net/netlabel/netlabel_unlabeled.h
@@ -225,7 +225,7 @@ int netlbl_unlhsh_add(struct net *net,
 		      const void *addr,
 		      const void *mask,
 		      u32 addr_len,
-		      u32 secid,
+		      struct lsm_export *l,
 		      struct netlbl_audit *audit_info);
 int netlbl_unlhsh_remove(struct net *net,
 			 const char *dev_name,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 0266879efef1..eae91a11accc 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -100,7 +100,6 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 	struct audit_buffer *audit_buf;
 	char *secctx;
 	u32 secctx_len;
-	struct lsm_export le;
 
 	if (audit_enabled == AUDIT_OFF)
 		return NULL;
@@ -113,10 +112,8 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
-	if (audit_info->secid != 0)
-		lsm_export_to_all(&le, audit_info->secid);
-	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(&le,
+	if (lsm_export_any(&audit_info->le) &&
+	    security_secid_to_secctx(&audit_info->le,
 				     &secctx,
 				     &secctx_len) == 0) {
 		audit_log_format(audit_buf, " subj=%s", secctx);
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index 2dbc4276bdcc..ee73711e0756 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -48,10 +48,7 @@
 static inline void netlbl_netlink_auditinfo(struct sk_buff *skb,
 					    struct netlbl_audit *audit_info)
 {
-	struct lsm_export le;
-
-	security_task_getsecid(current, &le);
-	lsm_export_secid(&le, &audit_info->secid);
+	security_task_getsecid(current, &audit_info->le);
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index c40914a157b7..4bbd50237a8a 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -122,7 +122,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
 		return NULL;
 
 	if ((secattr->flags & NETLBL_SECATTR_SECID) &&
-	    (secattr->attr.secid == sid))
+	    (secattr->attr.le.selinux == sid))
 		return secattr;
 
 	return NULL;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index fcd11105fafa..d3e730b2ed3b 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3577,8 +3577,9 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 
 	if (secattr->flags & NETLBL_SECATTR_CACHE)
 		*sid = *(u32 *)secattr->cache->data;
-	else if (secattr->flags & NETLBL_SECATTR_SECID)
-		*sid = secattr->attr.secid;
+	else if (secattr->flags & NETLBL_SECATTR_SECID &&
+		 (secattr->attr.le.flags & LSM_EXPORT_SELINUX))
+		*sid = secattr->attr.le.selinux;
 	else if (secattr->flags & NETLBL_SECATTR_MLS_LVL) {
 		rc = -EIDRM;
 		ctx = sidtab_search(sidtab, SECINITSID_NETMSG);
@@ -3651,7 +3652,9 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 	if (secattr->domain == NULL)
 		goto out;
 
-	secattr->attr.secid = sid;
+	lsm_export_init(&secattr->attr.le);
+	secattr->attr.le.flags = LSM_EXPORT_SELINUX;
+	secattr->attr.le.selinux = sid;
 	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY | NETLBL_SECATTR_SECID;
 	mls_export_netlbl_lvl(policydb, ctx, secattr);
 	rc = mls_export_netlbl_cat(policydb, ctx, secattr);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1ee9c94c0e16..37b0ef6ca767 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3670,11 +3670,12 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
 			return &smack_known_web;
 		return &smack_known_star;
 	}
-	if ((sap->flags & NETLBL_SECATTR_SECID) != 0)
+	if ((sap->flags & NETLBL_SECATTR_SECID) != 0 &&
+	    (sap->attr.le.flags & LSM_EXPORT_SMACK))
 		/*
 		 * Looks like a fallback, which gives us a secid.
 		 */
-		return smack_from_secid(sap->attr.secid);
+		return smack_from_secid(sap->attr.le.smack);
 	/*
 	 * Without guidance regarding the smack value
 	 * for the packet fall back on the network
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index faf2ea3968b3..28c567465f6c 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -197,7 +197,8 @@ static void smk_netlabel_audit_set(struct netlbl_audit *nap)
 
 	nap->loginuid = audit_get_loginuid(current);
 	nap->sessionid = audit_get_sessionid(current);
-	nap->secid = skp->smk_secid;
+	nap->le.flags = LSM_EXPORT_SMACK;
+	nap->le.smack = skp->smk_secid;
 }
 
 /*
@@ -1150,6 +1151,7 @@ static void smk_net4addr_insert(struct smk_net4addr *new)
 static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
+	struct lsm_export le;
 	struct smk_net4addr *snp;
 	struct sockaddr_in newname;
 	char *smack;
@@ -1281,10 +1283,14 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 	 * this host so that incoming packets get labeled.
 	 * but only if we didn't get the special CIPSO option
 	 */
-	if (rc == 0 && skp != NULL)
+	if (rc == 0 && skp != NULL) {
+		lsm_export_init(&le);
+		le.flags = LSM_EXPORT_SMACK;
+		le.smack = snp->smk_label->smk_secid;
 		rc = netlbl_cfg_unlbl_static_add(&init_net, NULL,
 			&snp->smk_host, &snp->smk_mask, PF_INET,
-			snp->smk_label->smk_secid, &audit_info);
+			&le, &audit_info);
+	}
 
 	if (rc == 0)
 		rc = count;
-- 
2.17.0

