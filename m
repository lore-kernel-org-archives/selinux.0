Return-Path: <SRS0=cgF/=2P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E734AC2D0C3
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B132F20679
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RGNugrrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfLYAAq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:00:46 -0500
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:45311
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbfLYAAq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 19:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577232044; bh=cO2o32Iw5ZY4n6C3yFf6bELF12NZMF9ACZp6XEuRPbU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=RGNugrrvjKO6qoWF6OXm7yMNP9mMyezFgWSsTL+EkdAmiQsboxtbkfblzc0H/55CdwwTNPGWifnbYG3vuGJikutPB+B/MDH70t7TUt+e2Pew4A0foIAsaP0lqFZKFoefXwfbw4RZCxpDVrQf521IYEkbtGi0TScVB+BkEsv16NuwtjAQ9s9t4yUgHW8BKgjZ476cjem93Z8kzqSkpe0BWMLTBnswP4R4n2sBMk5dMUFxFRpKA0CRkU5+K7eWCWrH/gF5hjSmHAAVE5r6Eb5hIcVslk9pgcNqZ57PcClqX+lsqlxeW3E305NT1kyDc0j4p9d/k+n4N0kE2G6L+H/4wg==
X-YMail-OSG: WSb15HIVM1k0D6dV55JDsXR0UzfN8NIvrdFgb4PP3oULYPTMaK7WcZ3sh0TiDCf
 6mG1.RKHg1_IFWBRW4NmoWkQosOxPOxJp3IvRzjAUFgEmRr6iKxPNS3oudnQkvJLqOfc0PauOrPN
 w_hvY_WrTOOgQtIbXxyV4rYhVLjHoE_zyirEAyApb8n0pJFXsPcU.y3idOqM8bX4HGYiOvlkoCc3
 0UhuuWIo6dcmQuWg67RUw7ekoBR7tPQMXfuksxxQ8F.gz9uEB2.t31Js9pk7dZdHjH9IfKBFzCZH
 6OVpksImrYKVcnjNKpspSUkMbVnF0GGEW.oIOjRA1TqAaU.51vXF_zTop9diMDE26AGkLzWyaO5v
 NhNfpkMoYVKBNfns7crm5xfRenO5drrTFMxCYq16tTxwMLhAi6Gj7u_T.xDs0UyTiGryYExuRRlP
 Am4EitY2MFQrVGNWVqQZf612KZv26dLiQ38W3O02.xcqcWMT7xZJGxK7MGQIdmqaL07oUMBjzDDc
 G8YlZj.2EgevHhER03cfAjkLGAGo18168.fyNFq2P55HYIOuIWqYbWRI4N6wbboqszA3A5OOIiqu
 r66H9IVEh5zavd0Or2ip4FsBW6KkjAb7iUF.iy7wVsIGcvlK9j9CGIB.PcGve3RdHzBzb.avMM3n
 N5wlK.970rsFdstygPg9oIdXOJMv7JFrOK2canlSHxogQGshVDXvsK07W5H8f6J5IFE8ltk.q7iU
 LVTvAXuMH21I2DMlhIbik5_2U6B4bqKhPL1HCE74zxKEpGJjYj0Of67akjSzZSqqc.MOgIUhkfMh
 hv.6H37_UXZeLPG7plTaMzD1Emo03iacolghVJ8JFjELqNHTikJZV89sbUjZGm7iGw5LEBEuyREP
 zaoRbfVsXIquqGndK.tkQ7M6OvMQ.iMRURIr4vLFIbcR3fGCZtHpHHJmw_yIF52y1dKo704uM4aU
 s9Yd9hUqDILXyV2.O9CcfNQR3KJW9mSEL5SEsYZCyPhHk2Sq2Ua2AcvF4rsLtDaTpfhvShyyDOhP
 brAtYsgvwDb_Iq33NdFkFfm0ZlEKpEcf9QrZ52nFiJB28JZ5oz4gpc5fmgOunfCORPEzYfJaAOQg
 ZE2E3kwtHmUuspSK1t30aA0SPZGZVbD15zWGP3.ti_hRKyGkPXigu9JDXSavtPDGbGwlCTf6bByf
 bNbRxaKd7Fg92PXCbU90d6OTgjimVZ0UuWCEsVKScBsuJBmAjzvX3rhFGcoaD_U5vA5hkGbTTTr3
 ZOMwDhM7ISphqvHeG7saG3jujs9uWTkqHy5rUafszQaiVC2PM_YfGhBAzG4SP9o4OfutbEwPWnNo
 KZHw_oejFDZ3QGmzQLuAjfRWo8C4yg3KjnSiHvl7EKGRNkMXr0e5ZyxoVvg5OJzBNLENI4dfxxbE
 RgUn5ZTcRlDRU4aTVQ6NusBNUZprr_PErMpdCd4AA8JXAYMG07L.p3Gb4AUl9ElnZzXkulg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Dec 2019 00:00:44 +0000
Received: by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cb9d1c4a0e15e922daffdf8ab166265c;
          Wed, 25 Dec 2019 00:00:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v13 06/25] Use lsmblob in security_secctx_to_secid
Date:   Tue, 24 Dec 2019 15:59:20 -0800
Message-Id: <20191224235939.7483-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224235939.7483-1-casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h          |  5 +++--
 kernel/cred.c                     |  4 +---
 net/netfilter/nft_meta.c          | 12 +++++++-----
 net/netfilter/xt_SECMARK.c        |  5 ++++-
 net/netlabel/netlabel_unlabeled.c | 14 ++++++++------
 security/security.c               | 18 +++++++++++++++---
 6 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 995faba7393f..8cae9e4bd760 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -496,7 +496,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsmblob *blob);
 void security_release_secctx(char *secdata, u32 seclen);
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
@@ -1302,7 +1303,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 
 static inline int security_secctx_to_secid(const char *secdata,
 					   u32 seclen,
-					   u32 *secid)
+					   struct lsmblob *blob)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 846ac4b23c16..7fef90f3f10b 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -756,14 +756,12 @@ EXPORT_SYMBOL(set_security_override);
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
index 9740b554fdb3..259c78d2f371 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -625,21 +625,23 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
 
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
+	if (!lsmblob_is_set(&blob))
 		return -ENOENT;
 
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
index 2317721f3ecb..2d68416b4552 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -45,13 +45,14 @@ secmark_tg(struct sk_buff *skb, const struct xt_action_param *par)
 
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
@@ -59,6 +60,8 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
+	/* scaffolding during the transition */
+	info->secid = blob.secid[0];
 	if (!info->secid) {
 		pr_info_ratelimited("unable to map security context \'%s\'\n",
 				    info->secctx);
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index d2e4ab8d1cb1..7a5a87f15736 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -881,7 +881,7 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct lsmblob blob;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -905,12 +905,13 @@ static int netlbl_unlabel_staticadd(struct sk_buff *skb,
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
 
@@ -932,7 +933,7 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
 	void *addr;
 	void *mask;
 	u32 addr_len;
-	u32 secid;
+	struct lsmblob blob;
 	struct netlbl_audit audit_info;
 
 	/* Don't allow users to add both IPv4 and IPv6 addresses for a
@@ -954,12 +955,13 @@ static int netlbl_unlabel_staticadddef(struct sk_buff *skb,
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
index 33563963cd45..9dc0bbfe567e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1970,10 +1970,22 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
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

