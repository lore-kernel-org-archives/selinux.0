Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5478C48BD6
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F89920663
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TAeAodSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFZTW6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:22:58 -0400
Received: from sonic308-13.consmr.mail.gq1.yahoo.com ([98.137.68.37]:36281
        "EHLO sonic308-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726425AbfFZTW6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 15:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561576976; bh=IpPrdH9kVyBWqCUcX8rcf9/TZsdL8AbkaUhCzNBz//Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=TAeAodSb5btG5MZNYeUG6KxqpfRcpiKP175+dm61bw7+1774RDHBs/7A+Om9VnCIiAAnDlwYYJfRZq2lrveXnea8BgB/vEtb/cIiaeJHtaOq9Wjofv46NYKgIYbRYkBiDqxc/JTeM7Jc13M2COLfT61Bq8g5H/gytYtcoeTIfXAvIuSRFaN1NQd2YGEAvXt+B98Qmc7ouGEPEE6uOeXCM8aMD/F3dvs9trEtGSQwA9ZoSRxBJSrcF1u5z1y7IP05FrNS63QQr6nJo/mzbg+onJ+a+1huFdfq91S2W95eevkQMClWO0epOXLeRAdSe1tAyEFZejK7DmiPCxVBdVCZMQ==
X-YMail-OSG: .O3LchQVM1nLuwQGbHHOxSCDY9wefBeeqRY.VT4QPL3k5VVg1QyRIDZ7FGRalfQ
 55pt3pn4OwEPQ9XNRAOjv3ZeOsivSdSgQF6NJl.egpYpROioMv8qYHUuS84nVV2XBmzxldyDJA2Z
 QLy9Q7e_ljhL_rf_VFNVVHrFdgolMbSV54I35osTFuKTVxHeUXR9eMEpy2JClwHTlw1FEKFdpgz2
 1FRi8UvBamPN4tocTbnKltWOyljAafwwQf83BIKe1.3ZdNNWY2esmf.HGKkmV4CJQ_7aeZwkEkcW
 hyO.ZYiLMN6iugVuU4ruAPLlKXu07bH8X7f6UdzpDJUtbs.hkFHUFia8w8UmOwwIMGticTg2.AT3
 fBQ.rAO8e5ii5cEw4IcJ1QmqR2WvPz13RPWnuiz20cTcx9FgPKzwdb5WvJxlym.p.38iiKeFGMiI
 yZjKq8SAbLRypGIGV8.QrXwfjb9YnE9.ER8dSImYb9pnuzR4TwdHXRie1em9HmpTyNs34hlz8Qtt
 lg_gFpEBR80_gIC3O6LuNBLTyAM4pt2PCO.TSfMH2yRn.I8OKAHSl_8z00qOiFx9zVscA2XJPzS9
 PwoHHzsmic39kt.k4Pv2U3aBep4_6Bw121.f.W3xFhIMsoenqtiW6oC6bdHU_CJquNOPZBdIRjeM
 R6ZTsxA8GE7Ok3VpMBwmWnDGNqEVUF35W92Z7qA_qJohJGYgUO6SuzhkopC2DYGOXc4T_SmrPCkl
 6wnBBirTcUw3W_QHeneiJUCZ9bJr2cQm6mWXP2WpqhiAmwiBUsaY1OF1m.XASRaWj3UV.IISXHSC
 xP.BqbeJakBvYy4FhW_MkVlo7ciFvBtvB_NiWsVleGoSHj34bhhBjI5eAB1wQa75fzUuETC1_EPo
 MMc0fRAm.zW02PhTeomzty21jSpTWiTiizOxbT2_A2UXnAIMePGW0P5c0do_WfWgE8E7Ihc6r6lq
 NXUGhuTr1CV2GbUIzU8VCtGFyu1Hnvlq5Y0fZM0TIMauejQZNbjnciOuZiIAZ5P7W_J10KjVzlti
 LMMWVKG3xuYI5MFWzdfkA72UP9ZLGRc0AGBvXfmb_h5lZGr6Y.MrFCjh2ejXQ9QqEYkNyUjfJjAW
 70.5igxyluOPHbbW3RGzj858mATZ4dS9W6ecLc1RPQMMHWxyE0L0cHHBOpIahcd4l81vPOBAhryu
 dJmhtVpIQ3uxP7RsDLGC.ABLXudufpeQ3PbpJoRTUb3_EDRuh22y2a4JaXrJSyrlqQJ0D3HDa_iO
 Jy2ZwMjfm1MM7nYD.cWe4O1G_VpcWfs5jdH1PUml8Dbj3.qCmY5ZS9DJSZQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Wed, 26 Jun 2019 19:22:56 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c714fa5cf5fc340fbb5c59821a30e7c3;
          Wed, 26 Jun 2019 19:22:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v4 08/23] LSM: Use lsmblob in security_secctx_to_secid
Date:   Wed, 26 Jun 2019 12:22:19 -0700
Message-Id: <20190626192234.11725-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626192234.11725-1-casey@schaufler-ca.com>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change security_secctx_to_secid() to fill in a lsmblob instead
of a u32 secid. Multiple LSMs may be able to interpret the
string, and this allows for setting whichever secid is
appropriate. In some cases there is scaffolding where other
interfaces have yet to be converted.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h          |  5 +++--
 kernel/cred.c                     |  4 +---
 net/netfilter/nft_meta.c          | 13 ++++++-------
 net/netfilter/xt_SECMARK.c        |  5 ++++-
 net/netlabel/netlabel_unlabeled.c | 14 ++++++++------
 security/security.c               | 18 +++++++++++++++---
 6 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index dcf20da87d1b..30337f1a9056 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -447,7 +447,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsmblob *blob);
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1230,7 +1231,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 
 static inline int security_secctx_to_secid(const char *secdata,
 					   u32 seclen,
-					   u32 *secid)
+					   struct lsmblob *blob)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 71c14dda107e..d70a2c02ced4 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -725,14 +725,12 @@ EXPORT_SYMBOL(set_security_override);
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
 	struct lsmblob blob;
-	u32 secid;
 	int ret;
 
-	ret = security_secctx_to_secid(secctx, strlen(secctx), &secid);
+	ret = security_secctx_to_secid(secctx, strlen(secctx), &blob);
 	if (ret < 0)
 		return ret;
 
-	lsmblob_init(&blob, secid);
 	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 987d2d6ce624..054fb4b48d51 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -576,21 +576,20 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
 
 static int nft_secmark_compute_secid(struct nft_secmark *priv)
 {
-	u32 tmp_secid = 0;
+	struct lsmblob blob;
 	int err;
 
-	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &tmp_secid);
+	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &blob);
 	if (err)
 		return err;
 
-	if (!tmp_secid)
-		return -ENOENT;
-
-	err = security_secmark_relabel_packet(tmp_secid);
+	/* Using le[0] is scaffolding */
+	err = security_secmark_relabel_packet(blob.secid[0]);
 	if (err)
 		return err;
 
-	priv->secid = tmp_secid;
+	/* Using le[0] is scaffolding */
+	priv->secid = blob.secid[0];
 	return 0;
 }
 
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index f16202d26c20..8081fadc30e9 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -49,13 +49,14 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
 
 static int checkentry_lsm(struct xt_secmark_target_info *info)
 {
+	struct lsmblob blob;
 	int err;
 
 	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
 	info->secid = 0;
 
 	err = security_secctx_to_secid(info->secctx, strlen(info->secctx),
-				       &info->secid);
+				       &blob);
 	if (err) {
 		if (err == -EINVAL)
 			pr_info_ratelimited("invalid security context \'%s\'\n",
@@ -63,6 +64,8 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
+	/* scaffolding during the transition */
+	info->secid = blob.secid[0];
 	if (!info->secid) {
 		pr_info_ratelimited("unable to map security context \'%s\'\n",
 				    info->secctx);
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index c92894c3e40a..2976370e41aa 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -895,7 +895,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct lsmblob blob;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -919,12 +919,13 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	ret_val = security_secctx_to_secid(
 		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &secid);
+				  &blob);
 	if (ret_val != 0)
 		return ret_val;
 
+	/* scaffolding with the [0] */
 	return netlbl_unlhsh_add(&init_net,
-				 dev_name, addr, mask, addr_len, secid,
+				 dev_name, addr, mask, addr_len, blob.secid[0],
 				 &audit_info);
 }
 
@@ -946,7 +947,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct lsmblob blob;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -968,12 +969,13 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	ret_val = security_secctx_to_secid(
 		                  nla_data(info->attrs[NLBL_UNLABEL_A_SECCTX]),
 				  nla_len(info->attrs[NLBL_UNLABEL_A_SECCTX]),
-				  &secid);
+				  &blob);
 	if (ret_val != 0)
 		return ret_val;
 
+	/* scaffolding with the [0] */
 	return netlbl_unlhsh_add(&init_net,
-				 NULL, addr, mask, addr_len, secid,
+				 NULL, addr, mask, addr_len, blob.secid[0],
 				 &audit_info);
 }
 
diff --git a/security/security.c b/security/security.c
index 4e1eb2a54064..ad9aaa46ed04 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1982,10 +1982,22 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsmblob *blob)
 {
-	*secid = 0;
-	return call_int_hook(secctx_to_secid, 0, secdata, seclen, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.secctx_to_secid(secdata, seclen,
+					      &blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
-- 
2.20.1

