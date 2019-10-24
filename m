Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F475CA9EBC
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209F921929
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="P7U2t2Y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfJXUyE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:54:04 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:35793
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728692AbfJXUyE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950440; bh=547HbZVCRc+yzGH5moJGyELgsFj7NzMEkzk7J8bqeQg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=P7U2t2Y3KX3pTm07TByhvJvvdz+LzqC0+uX5XORnhpRC3vjL6x+xqXBuYPWyCeiVrFISPud+sSeNB5rULZXms4v+t6kw+8T8IOANB2KZfgQUo2jiyq36kq2BS70Jf9Q5z/1q+Cq9jddH2BXHNHSYqei6ia0z9hqJBwNX20HNZKzvcCoMu6tEt6CNHUat46RdnNDIU1VAIQl6CvvQoxEIVRkriP1IqSDg8IbHeJv5HbMXedJZWIX3x4qZppdqeo9frDCuSezCy2LmIIxaFWzva1scWeuqFab5HyK5rvgFU/cm9qUoFsHVmznmf7/CBMZcOIYVs5pop57bJEC2HnIRMA==
X-YMail-OSG: P6A8_HAVM1m0pgs4upoMv3FS0geb3axv53lg6koIVH.6jj9R6dz28Dx7P9Omcoe
 i9paUUp44ezjYV5VXU4_QMXnqRltXbULO4D2otmJ8.J3DkNu_OOI2Wk.GBgRQpLwFRTGaEEmWFSJ
 QicGHZTs3dbwuSl2RAHRAaYspeQXZ3.u8UzPXTKvpZfHGFE.HbpTfgILElZ_wGR6wkbRQeX8Subx
 iAa81Q0Zwlx2qCHwGpgTM5nQdaUbdLUr8H2oHRPW5LnIRtPaURXkN2JBW1tlKQ027U14tKcJmaVR
 6BnJwyS_Z1b.30WYZbWhmxLinhCsiTEHOf7XsGdZxLoih3o3tbS_LIkhcnB_e0mf9_ThUf1jaZJo
 bmFiT4NUYs9luLE0iZJ9Nkb1wo7uLACQXaF14HR5bwXdNLSPMpWT8TJURa4J5yKrjzi7nTRGiCbR
 sSsxbVKjXAN83lxgaS0UuxQUTp.2Ty6adkKzmz_aTuKg4siA2FmFPIVAZJx.tnXnji5QBtXUuXuk
 EVJz4j93i7dhJoyylz0Mm_oSxbWykDdnwOR1R6XtWsbV39r6nE1WLepq_IeZJx.BPbNC3qTcvhcJ
 orSx1RcHsA.vwT0DSlKS9er6mzLsRV4N.9oCVlbowPtuYdUpN.h.I.bvOuhBw92iw80BAPu28Zsy
 MOHEQ53W0XbxoSktH3q5SAsCF2WhYc.a6QM4Br4lexLOk6HdQmR5cpfdsrWFVQme5aHAfGovZglI
 rbqQLs9YR0IHVPiEO2gbcpnnoyWF_ss4qSyLjJ_SyYvSOvjjiB6DOCKKANHyA2LDdnx7T2QesUhu
 Ti7.9PbXAjWUEuRoGImzneWp4KPwsI0cwMAOLLCHRGZNahAw1zgP8J_bglQJlVMZkDszpVTk9vNP
 eu.JYaHm3M1M5h54v4flzZEzFCPMbnsaUnnJwaOVUNVOh8_YgE5N3twP8iyBD_W4GOarwhRBH1Bm
 US_hxoivD1svZk6R6IEKvOvOvSS4WHPJC68N4oPRlibbSwPsH53Jb.KfPjR0HKmc12nZmiz07wk5
 2jdifB8tntCs5hS8EzrQ6U_SylymRvnMBA0.V55Ns8845YNRZ9zZSxldBMXiYo9DBhTv_SYNbzAi
 1gI9S92JXFpkJVVAbGk1pUkCNLVUN_NK5w_hvh_ptP4OdmVN3h5GS.ZX_jFv.WLMKdfka.6KPdP6
 OJDXSnWbl8qgXtH2HhNeVDJsokkXWwt6Pph2.EyISW5EWtge3s1iHz32zVMGNcyrTGWdL6dn6iKO
 QmWJdxyxNwvwJDTCo7yfib5KpTjmodpzIexIgGgNd4QBCWOhRZV.5SFeoJwcuNpM0FLAp.iIl478
 wbS.CJfD5VDnM4XhRc6i3FRswDs5dAnjol1CcLcE5MyXKQ9wmYokUdg6xcR8tRaWqxeBywv978q3
 uKRGK_kn1u2GkudABEiPeAw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Oct 2019 20:54:00 +0000
Received: by smtp428.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 40856e22461a71521149fbac47a9a44a;
          Thu, 24 Oct 2019 20:54:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 19/25] NET: Store LSM netlabel data in a lsmblob
Date:   Thu, 24 Oct 2019 13:52:22 -0700
Message-Id: <20191024205228.6922-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Netlabel uses LSM interfaces requiring an lsmblob and
the internal storage is used to pass information between
these interfaces, so change the internal data from a secid
to a lsmblob. Update the netlabel interfaces and their
callers to accommodate the change. This requires that the
modules using netlabel use the lsm_id.slot to access the
correct secid when using netlabel.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/net/netlabel.h              |  8 ++--
 net/ipv4/cipso_ipv4.c               |  6 ++-
 net/netlabel/netlabel_kapi.c        |  6 +--
 net/netlabel/netlabel_unlabeled.c   | 57 +++++++++++------------------
 net/netlabel/netlabel_unlabeled.h   |  2 +-
 security/selinux/hooks.c            |  2 +-
 security/selinux/include/security.h |  1 +
 security/selinux/netlabel.c         |  2 +-
 security/selinux/ss/services.c      |  4 +-
 security/smack/smack.h              |  1 +
 security/smack/smack_lsm.c          |  5 ++-
 security/smack/smackfs.c            | 10 +++--
 12 files changed, 50 insertions(+), 54 deletions(-)

diff --git a/include/net/netlabel.h b/include/net/netlabel.h
index 72d6435fc16c..6c550455e69f 100644
--- a/include/net/netlabel.h
+++ b/include/net/netlabel.h
@@ -180,7 +180,7 @@ struct netlbl_lsm_catmap {
  * @attr.mls: MLS sensitivity label
  * @attr.mls.cat: MLS category bitmap
  * @attr.mls.lvl: MLS sensitivity level
- * @attr.secid: LSM specific secid token
+ * @attr.lsmblob: LSM specific data
  *
  * Description:
  * This structure is used to pass security attributes between NetLabel and the
@@ -215,7 +215,7 @@ struct netlbl_lsm_secattr {
 			struct netlbl_lsm_catmap *cat;
 			u32 lvl;
 		} mls;
-		u32 secid;
+		struct lsmblob lsmblob;
 	} attr;
 };
 
@@ -429,7 +429,7 @@ int netlbl_cfg_unlbl_static_add(struct net *net,
 				const void *addr,
 				const void *mask,
 				u16 family,
-				u32 secid,
+				struct lsmblob *lsmblob,
 				struct netlbl_audit *audit_info);
 int netlbl_cfg_unlbl_static_del(struct net *net,
 				const char *dev_name,
@@ -537,7 +537,7 @@ static inline int netlbl_cfg_unlbl_static_add(struct net *net,
 					      const void *addr,
 					      const void *mask,
 					      u16 family,
-					      u32 secid,
+					      struct lsmblob *lsmblob,
 					      struct netlbl_audit *audit_info)
 {
 	return -ENOSYS;
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index f0165c5f376b..eb4939f38a14 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1481,7 +1481,8 @@ static int cipso_v4_gentag_loc(const struct cipso_v4_doi *doi_def,
 
 	buffer[0] = CIPSO_V4_TAG_LOCAL;
 	buffer[1] = CIPSO_V4_TAG_LOC_BLEN;
-	*(u32 *)&buffer[2] = secattr->attr.secid;
+	/* only one netlabel user - the first */
+	*(u32 *)&buffer[2] = secattr->attr.lsmblob.secid[0];
 
 	return CIPSO_V4_TAG_LOC_BLEN;
 }
@@ -1501,7 +1502,8 @@ static int cipso_v4_parsetag_loc(const struct cipso_v4_doi *doi_def,
 				 const unsigned char *tag,
 				 struct netlbl_lsm_secattr *secattr)
 {
-	secattr->attr.secid = *(u32 *)&tag[2];
+	/* only one netlabel user - the first */
+	secattr->attr.lsmblob.secid[0] = *(u32 *)&tag[2];
 	secattr->flags |= NETLBL_SECATTR_SECID;
 
 	return 0;
diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index ee3e5b6471a6..724d44943543 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -210,7 +210,7 @@ int netlbl_cfg_unlbl_map_add(const char *domain,
  * @addr: IP address in network byte order (struct in[6]_addr)
  * @mask: address mask in network byte order (struct in[6]_addr)
  * @family: address family
- * @secid: LSM secid value for the entry
+ * @lsmblob: LSM data value for the entry
  * @audit_info: NetLabel audit information
  *
  * Description:
@@ -224,7 +224,7 @@ int netlbl_cfg_unlbl_static_add(struct net *net,
 				const void *addr,
 				const void *mask,
 				u16 family,
-				u32 secid,
+				struct lsmblob *lsmblob,
 				struct netlbl_audit *audit_info)
 {
 	u32 addr_len;
@@ -244,7 +244,7 @@ int netlbl_cfg_unlbl_static_add(struct net *net,
 
 	return netlbl_unlhsh_add(net,
 				 dev_name, addr, mask, addr_len,
-				 secid, audit_info);
+				 lsmblob, audit_info);
 }
 
 /**
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 4716e0011ba5..57ede7781c8f 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -80,7 +80,7 @@ struct netlbl_unlhsh_tbl {
 #define netlbl_unlhsh_addr4_entry(iter) \
 	container_of(iter, struct netlbl_unlhsh_addr4, list)
 struct netlbl_unlhsh_addr4 {
-	u32 secid;
+	struct lsmblob lsmblob;
 
 	struct netlbl_af4list list;
 	struct rcu_head rcu;
@@ -88,7 +88,7 @@ struct netlbl_unlhsh_addr4 {
 #define netlbl_unlhsh_addr6_entry(iter) \
 	container_of(iter, struct netlbl_unlhsh_addr6, list)
 struct netlbl_unlhsh_addr6 {
-	u32 secid;
+	struct lsmblob lsmblob;
 
 	struct netlbl_af6list list;
 	struct rcu_head rcu;
@@ -233,7 +233,7 @@ static struct netlbl_unlhsh_iface *netlbl_unlhsh_search_iface(int ifindex)
  * @iface: the associated interface entry
  * @addr: IPv4 address in network byte order
  * @mask: IPv4 address mask in network byte order
- * @secid: LSM secid value for entry
+ * @lsmblob: LSM data value for entry
  *
  * Description:
  * Add a new address entry into the unlabeled connection hash table using the
@@ -244,7 +244,7 @@ static struct netlbl_unlhsh_iface *netlbl_unlhsh_search_iface(int ifindex)
 static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
 				   const struct in_addr *addr,
 				   const struct in_addr *mask,
-				   u32 secid)
+				   struct lsmblob *lsmblob)
 {
 	int ret_val;
 	struct netlbl_unlhsh_addr4 *entry;
@@ -256,7 +256,7 @@ static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
 	entry->list.addr = addr->s_addr & mask->s_addr;
 	entry->list.mask = mask->s_addr;
 	entry->list.valid = 1;
-	entry->secid = secid;
+	entry->lsmblob = *lsmblob;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	ret_val = netlbl_af4list_add(&entry->list, &iface->addr4_list);
@@ -273,7 +273,7 @@ static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
  * @iface: the associated interface entry
  * @addr: IPv6 address in network byte order
  * @mask: IPv6 address mask in network byte order
- * @secid: LSM secid value for entry
+ * @lsmblob: LSM data value for entry
  *
  * Description:
  * Add a new address entry into the unlabeled connection hash table using the
@@ -284,7 +284,7 @@ static int netlbl_unlhsh_add_addr4(struct netlbl_unlhsh_iface *iface,
 static int netlbl_unlhsh_add_addr6(struct netlbl_unlhsh_iface *iface,
 				   const struct in6_addr *addr,
 				   const struct in6_addr *mask,
-				   u32 secid)
+				   struct lsmblob *lsmblob)
 {
 	int ret_val;
 	struct netlbl_unlhsh_addr6 *entry;
@@ -300,7 +300,7 @@ static int netlbl_unlhsh_add_addr6(struct netlbl_unlhsh_iface *iface,
 	entry->list.addr.s6_addr32[3] &= mask->s6_addr32[3];
 	entry->list.mask = *mask;
 	entry->list.valid = 1;
-	entry->secid = secid;
+	entry->lsmblob = *lsmblob;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	ret_val = netlbl_af6list_add(&entry->list, &iface->addr6_list);
@@ -379,7 +379,7 @@ int netlbl_unlhsh_add(struct net *net,
 		      const void *addr,
 		      const void *mask,
 		      u32 addr_len,
-		      u32 secid,
+		      struct lsmblob *lsmblob,
 		      struct netlbl_audit *audit_info)
 {
 	int ret_val;
@@ -388,7 +388,6 @@ int netlbl_unlhsh_add(struct net *net,
 	struct netlbl_unlhsh_iface *iface;
 	struct audit_buffer *audit_buf = NULL;
 	struct lsmcontext context;
-	struct lsmblob blob;
 
 	if (addr_len != sizeof(struct in_addr) &&
 	    addr_len != sizeof(struct in6_addr))
@@ -421,7 +420,7 @@ int netlbl_unlhsh_add(struct net *net,
 		const struct in_addr *addr4 = addr;
 		const struct in_addr *mask4 = mask;
 
-		ret_val = netlbl_unlhsh_add_addr4(iface, addr4, mask4, secid);
+		ret_val = netlbl_unlhsh_add_addr4(iface, addr4, mask4, lsmblob);
 		if (audit_buf != NULL)
 			netlbl_af4list_audit_addr(audit_buf, 1,
 						  dev_name,
@@ -434,7 +433,7 @@ int netlbl_unlhsh_add(struct net *net,
 		const struct in6_addr *addr6 = addr;
 		const struct in6_addr *mask6 = mask;
 
-		ret_val = netlbl_unlhsh_add_addr6(iface, addr6, mask6, secid);
+		ret_val = netlbl_unlhsh_add_addr6(iface, addr6, mask6, lsmblob);
 		if (audit_buf != NULL)
 			netlbl_af6list_audit_addr(audit_buf, 1,
 						  dev_name,
@@ -451,8 +450,7 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		lsmblob_init(&blob, secid);
-		if (security_secid_to_secctx(&blob, &context) == 0) {
+		if (security_secid_to_secctx(lsmblob, &context) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -487,7 +485,6 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 	struct audit_buffer *audit_buf;
 	struct net_device *dev;
 	struct lsmcontext context;
-	struct lsmblob blob;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	list_entry = netlbl_af4list_remove(addr->s_addr, mask->s_addr,
@@ -507,10 +504,8 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 					  addr->s_addr, mask->s_addr);
 		if (dev != NULL)
 			dev_put(dev);
-		if (entry != NULL)
-			lsmblob_init(&blob, entry->secid);
 		if (entry != NULL &&
-		    security_secid_to_secctx(&blob, &context) == 0) {
+		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -551,7 +546,6 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 	struct audit_buffer *audit_buf;
 	struct net_device *dev;
 	struct lsmcontext context;
-	struct lsmblob blob;
 
 	spin_lock(&netlbl_unlhsh_lock);
 	list_entry = netlbl_af6list_remove(addr, mask, &iface->addr6_list);
@@ -570,10 +564,8 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 					  addr, mask);
 		if (dev != NULL)
 			dev_put(dev);
-		if (entry != NULL)
-			lsmblob_init(&blob, entry->secid);
 		if (entry != NULL &&
-		    security_secid_to_secctx(&blob, &context) == 0) {
+		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -927,9 +919,8 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	if (ret_val != 0)
 		return ret_val;
 
-	/* scaffolding with the [0] */
 	return netlbl_unlhsh_add(&init_net,
-				 dev_name, addr, mask, addr_len, blob.secid[0],
+				 dev_name, addr, mask, addr_len, &blob,
 				 &audit_info);
 }
 
@@ -977,10 +968,8 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	if (ret_val != 0)
 		return ret_val;
 
-	/* scaffolding with the [0] */
 	return netlbl_unlhsh_add(&init_net,
-				 NULL, addr, mask, addr_len, blob.secid[0],
-				 &audit_info);
+				 NULL, addr, mask, addr_len, &blob, &audit_info);
 }
 
 /**
@@ -1092,8 +1081,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 	struct net_device *dev;
 	struct lsmcontext context;
 	void *data;
-	u32 secid;
-	struct lsmblob blob;
+	struct lsmblob *lsmb;
 
 	data = genlmsg_put(cb_arg->skb, NETLINK_CB(cb_arg->nl_cb->skb).portid,
 			   cb_arg->seq, &netlbl_unlabel_gnl_family,
@@ -1131,7 +1119,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		if (ret_val != 0)
 			goto list_cb_failure;
 
-		secid = addr4->secid;
+		lsmb = (struct lsmblob *)&addr4->lsmblob;
 	} else {
 		ret_val = nla_put_in6_addr(cb_arg->skb,
 					   NLBL_UNLABEL_A_IPV6ADDR,
@@ -1145,11 +1133,10 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		if (ret_val != 0)
 			goto list_cb_failure;
 
-		secid = addr6->secid;
+		lsmb = (struct lsmblob *)&addr6->lsmblob;
 	}
 
-	lsmblob_init(&blob, secid);
-	ret_val = security_secid_to_secctx(&blob, &context);
+	ret_val = security_secid_to_secctx(lsmb, &context);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
@@ -1500,7 +1487,7 @@ int netlbl_unlabel_getattr(const struct sk_buff *skb,
 					      &iface->addr4_list);
 		if (addr4 == NULL)
 			goto unlabel_getattr_nolabel;
-		secattr->attr.secid = netlbl_unlhsh_addr4_entry(addr4)->secid;
+		secattr->attr.lsmblob = netlbl_unlhsh_addr4_entry(addr4)->lsmblob;
 		break;
 	}
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1513,7 +1500,7 @@ int netlbl_unlabel_getattr(const struct sk_buff *skb,
 					      &iface->addr6_list);
 		if (addr6 == NULL)
 			goto unlabel_getattr_nolabel;
-		secattr->attr.secid = netlbl_unlhsh_addr6_entry(addr6)->secid;
+		secattr->attr.lsmblob = netlbl_unlhsh_addr6_entry(addr6)->lsmblob;
 		break;
 	}
 #endif /* IPv6 */
diff --git a/net/netlabel/netlabel_unlabeled.h b/net/netlabel/netlabel_unlabeled.h
index 3a9e5dc9511b..dcff99695c97 100644
--- a/net/netlabel/netlabel_unlabeled.h
+++ b/net/netlabel/netlabel_unlabeled.h
@@ -225,7 +225,7 @@ int netlbl_unlhsh_add(struct net *net,
 		      const void *addr,
 		      const void *mask,
 		      u32 addr_len,
-		      u32 secid,
+		      struct lsmblob *lsmblob,
 		      struct netlbl_audit *audit_info);
 int netlbl_unlhsh_remove(struct net *net,
 			 const char *dev_name,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c9e377d13f0e..b07f9b8c7670 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6656,7 +6656,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_sock = sizeof(struct sk_security_struct),
 };
 
-static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
+struct lsm_id selinux_lsmid __lsm_ro_after_init = {
 	.lsm  = "selinux",
 	.slot = LSMBLOB_NEEDED
 };
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index b5b7c5aade8c..f0ca3879ba48 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -68,6 +68,7 @@
 struct netlbl_lsm_secattr;
 
 extern int selinux_enabled;
+extern struct lsm_id selinux_lsmid;
 
 /* Policy capabilities */
 enum {
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index c40914a157b7..120d50c1bcac 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -122,7 +122,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
 		return NULL;
 
 	if ((secattr->flags & NETLBL_SECATTR_SECID) &&
-	    (secattr->attr.secid == sid))
+	    (secattr->attr.lsmblob.secid[selinux_lsmid.slot] == sid))
 		return secattr;
 
 	return NULL;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index ec62918521b1..508dfba8607b 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3592,7 +3592,7 @@ int security_netlbl_secattr_to_sid(struct selinux_state *state,
 	if (secattr->flags & NETLBL_SECATTR_CACHE)
 		*sid = *(u32 *)secattr->cache->data;
 	else if (secattr->flags & NETLBL_SECATTR_SECID)
-		*sid = secattr->attr.secid;
+		*sid = secattr->attr.lsmblob.secid[selinux_lsmid.slot];
 	else if (secattr->flags & NETLBL_SECATTR_MLS_LVL) {
 		rc = -EIDRM;
 		ctx = sidtab_search(sidtab, SECINITSID_NETMSG);
@@ -3665,7 +3665,7 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
 	if (secattr->domain == NULL)
 		goto out;
 
-	secattr->attr.secid = sid;
+	secattr->attr.lsmblob.secid[selinux_lsmid.slot] = sid;
 	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY | NETLBL_SECATTR_SECID;
 	mls_export_netlbl_lvl(policydb, ctx, secattr);
 	rc = mls_export_netlbl_cat(policydb, ctx, secattr);
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 0a5a2a296c1a..809f9486708b 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -320,6 +320,7 @@ void smk_destroy_label_list(struct list_head *list);
  * Shared data.
  */
 extern int smack_enabled;
+extern struct lsm_id smack_lsmid;
 extern int smack_cipso_direct;
 extern int smack_cipso_mapped;
 extern struct smack_known *smack_net_ambient;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 17a652f96bd5..8b2730e02044 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3765,7 +3765,8 @@ static struct smack_known *smack_from_secattr(struct netlbl_lsm_secattr *sap,
 		/*
 		 * Looks like a fallback, which gives us a secid.
 		 */
-		return smack_from_secid(sap->attr.secid);
+		return smack_from_secid(
+				sap->attr.lsmblob.secid[smack_lsmid.slot]);
 	/*
 	 * Without guidance regarding the smack value
 	 * for the packet fall back on the network
@@ -4583,7 +4584,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_sock = sizeof(struct socket_smack),
 };
 
-static struct lsm_id smack_lsmid __lsm_ro_after_init = {
+struct lsm_id smack_lsmid __lsm_ro_after_init = {
 	.lsm  = "smack",
 	.slot = LSMBLOB_NEEDED
 };
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index faf2ea3968b3..6a4c468c200c 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -1150,6 +1150,7 @@ static void smk_net4addr_insert(struct smk_net4addr *new)
 static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
+	struct lsmblob lsmblob;
 	struct smk_net4addr *snp;
 	struct sockaddr_in newname;
 	char *smack;
@@ -1281,10 +1282,13 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 	 * this host so that incoming packets get labeled.
 	 * but only if we didn't get the special CIPSO option
 	 */
-	if (rc == 0 && skp != NULL)
+	if (rc == 0 && skp != NULL) {
+		lsmblob_init(&lsmblob, 0);
+		lsmblob.secid[smack_lsmid.slot] = snp->smk_label->smk_secid;
 		rc = netlbl_cfg_unlbl_static_add(&init_net, NULL,
-			&snp->smk_host, &snp->smk_mask, PF_INET,
-			snp->smk_label->smk_secid, &audit_info);
+			&snp->smk_host, &snp->smk_mask, PF_INET, &lsmblob,
+			&audit_info);
+	}
 
 	if (rc == 0)
 		rc = count;
-- 
2.20.1

