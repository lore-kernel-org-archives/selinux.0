Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1919AC10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51EB2084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="T2YYna4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfDITTY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:24 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:44640
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726837AbfDITTX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837560; bh=ru3IBy79wwcnAZalZt5K4emNkCbgFnwqv7TisHF5r3A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=T2YYna4TzSn1NnyiEUe2Lz8EHFFg2ZNjsb8mkmNKFqIDkwTOuZbzVxRfRIdiGbeXtm2b7ZPoVKW2VP/jR+yPSPl0cOkJHCyRD5Nk10DgbAJT3v8MEE+m1LjUocDaBpx/Cq0yZrOeJa6EcVycjU/egyzN9Hxs++5Pr0/HpqGgoPrH+nKm4IdhnWh/T4DyQW/SIgBGOKobsVLUQu9ZulDLuCRgPUNRvs3PFzibx5yOl1Jx2xoigit8fptzQHooJm0BTYqppvE8LoIS6y7I6reG7N/tID6VFbi7xIzp+/BFMZG3gr+BrCIr7/lnNtq4EnYOUAgtA5KeHUm2yq7/aSfeLA==
X-YMail-OSG: Y9TxLpIVM1lEqvlZDLn2xx74Ce84oLE60hPsFR_iIR.YXkrSXMqySknuXEPVWU7
 Ql180Xa5FK03lCkGN8wi7fN2BI1CLtobbQqkAZ45qJ2ADMQn49eJIpuNU_Gbausuw6gFY6C89HkO
 tZQiqlpCKkCKQ0_ud52UXGYaRV.GyCC8GTy5rXcatwB2oPueSVp40xeJmLlIKyoVE_d2PtH36JEe
 kuOjEOUPG.E_ds7MBR.KyD4_0d9MGDemNXzJA1SOyUU2TN7.9Uo_klI.CPuDI4ETYg1n.l8egDEd
 VoRJNLyIIeHIYatnQK5tsHfo6GS3eDuFks_En9VcVhllVrXo0eqV2eDxcujQoPiq1DR2Qksj0wxH
 PE.fOrXgUJHuLfhZEvNhtW5KLKRhpeYddqyBQ8NvFj4lzZ_OKcng_fKfLuwCZUE.a8gZj.O28wy4
 2tqAcUAgG71xM_4CSu7JsvGhQ_ZnrtULXZDNUT8EqteJ.UBy9EDIHqY3huCeoskejACnxkOOeigV
 en9o1k_QiSK0lYD1.5yIfenuBx4q1d0Y7SV.aReAgINVdECSDyytelC86UM7pzjepSDWM.VZlP68
 P7eH4uv9UF8gB__hLvcGqI7lC8sIHKAm9tGdhU4Ai1osrKRslwQyoGY6e9.nLazDUfNwO5XB6.qW
 UJ.hudFLzOnQZ05Wvifw.C7XeUdyliEe_W82Q7QWBv64K30fdfTQ6ep_OxbkblXMYO1wnRqqoW0e
 e4aDihsYDwDKHsKu8SuYeJ8u2Xah_3xgqTFRMZMAyDNHtaAjZuB0oeQC4.PjpY8akW16h8_K7YSD
 Isb789nGxNlV0h8js2ykkqdUY1GUDuMBSDujQI_GwYELpL_yVDJpU0YpwITuGR7s.CD5Qpt_cDdy
 BkcIJdYU260YSm5p8KYCXuKOYmb2zh23EyziAe_xOnTtuhRvzSt7.yzzyvzlyrthvW_A3YunMd8j
 yKoJz7WfjLX2.Hu9Q8v9wg7x1O0BSv67vIf.6w0lbHFU40hF.brWzGhvF1Nw.ovbg.uFZU2Yi..7
 kzBab3DwtCwIMn9hTCfBpqhsbyh0nsFSCZUHpP3cf4ui0OBhx3IsPVAcmxJkzUWUP.Iu6P2PCant
 uzcqIms2oujagelas4TPxoe2.UUdJgovQUkkqF.EVga3F8cNtBBB771xeMasSCQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:20 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 564a224fa9abd9f41816cac9472f1914;
          Tue, 09 Apr 2019 19:19:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 31/59] Netlabel: Replace secids with lsm_export
Date:   Tue,  9 Apr 2019 12:18:20 -0700
Message-Id: <20190409191848.1380-32-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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
 net/netlabel/netlabel_user.c      |  7 ++--
 net/netlabel/netlabel_user.h      |  5 +--
 security/selinux/netlabel.c       |  2 +-
 security/selinux/ss/services.c    |  9 +++--
 security/smack/smack_lsm.c        |  5 ++-
 security/smack/smackfs.c          | 12 ++++--
 11 files changed, 64 insertions(+), 71 deletions(-)

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
index f0165c5f376b..1defea2488b3 100644
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
@@ -1481,7 +1484,7 @@ static int cipso_v4_gentag_loc(const struct cipso_v4_doi *doi_def,
 
 	buffer[0] = CIPSO_V4_TAG_LOCAL;
 	buffer[1] = CIPSO_V4_TAG_LOC_BLEN;
-	*(u32 *)&buffer[2] = secattr->attr.secid;
+	memcpy(&buffer[2], &secattr->attr.le, sizeof(secattr->attr.le));
 
 	return CIPSO_V4_TAG_LOC_BLEN;
 }
@@ -1501,7 +1504,7 @@ static int cipso_v4_parsetag_loc(const struct cipso_v4_doi *doi_def,
 				 const unsigned char *tag,
 				 struct netlbl_lsm_secattr *secattr)
 {
-	secattr->attr.secid = *(u32 *)&tag[2];
+	memcpy(&secattr->attr.le, &tag[2], sizeof(secattr->attr.le));
 	secattr->flags |= NETLBL_SECATTR_SECID;
 
 	return 0;
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index ee3e5b6471a6..849064422e0b 100644
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
index 7f245d593c8f..f79ab91bf25e 100644
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
+		lep = (struct lsm_export *)&addr4->le;
 	} else {
 		ret_val = nla_put_in6_addr(cb_arg->skb,
 					   NLBL_UNLABEL_A_IPV6ADDR,
@@ -1152,11 +1136,10 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		if (ret_val != 0)
 			goto list_cb_failure;
 
-		secid = addr6->secid;
+		lep = (struct lsm_export *)&addr6->le;
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
index 1079cdea872c..2cc96305c841 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -100,7 +100,6 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 	struct audit_buffer *audit_buf;
 	char *secctx;
 	u32 secctx_len;
-	struct lsm_export le;
 
 	if (audit_enabled == AUDIT_OFF)
 		return NULL;
@@ -113,9 +112,9 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
 
-	lsm_export_to_all(&le, audit_info->secid);
-	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(&le, &secctx, &secctx_len) == 0) {
+	if (lsm_export_any(&audit_info->le) &&
+	    security_secid_to_secctx(&audit_info->le, &secctx,
+				     &secctx_len) == 0) {
 		audit_log_format(audit_buf, " subj=%s", secctx);
 		security_release_secctx(secctx, secctx_len);
 	}
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
index 626b877363fb..8a197b387056 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3596,8 +3596,9 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 
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
@@ -3670,7 +3671,9 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
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
index ecd636e5c75c..38ea48d22547 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3756,11 +3756,12 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
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
2.19.1

