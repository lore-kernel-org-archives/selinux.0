Return-Path: <SRS0=lMs6=2O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D26C2D0C3
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227A7206D3
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Lvr20cNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfLXXUV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:20:21 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:33762
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726256AbfLXXUV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 18:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229619; bh=CflM/BYE/m6vkCFgy2DwlH+gpJmxaxAxuCstaWJenLE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Lvr20cNRIIzBRkhbYdoWVeXrZFg3OJ4hrAXaSHn+lPgpvlt5JZRDZb8mGTDG1Cnu+xTwFFT3PKBRjQEZTL+WSYz3SOur2wNPkm3+ZKsisx3Gh/LqDSTjfu3Pq0wXirxF6+TlmaYwmzvtHDzdRvGD0nCV/TIjVHRuLbFFmH7ythnlcA/DATPBgtjy+jYlBnYho6vnzI27CK2Lsu0vrBQONrnoikTNPlCxYSnoXoeb61qtLwGopGAzf86cyqBpG6jMS/XH/mWHi9mFsDnX/5ETnETSuzow91h5p4iAxLyeQRRO7P5fCEQ/g/YQRhKjnYeQFTZB0HGKXnjj/jom0fwMVA==
X-YMail-OSG: _rKldXgVM1mUQffj2Nf6hx3rYRsqmp534257zRvOaDNoud9mkOKM6RKam_dKRt4
 DoM_7TS_.vcn0zLwOTvjQWLJjWsTUAg4YUSA6mA7g.ByJPee5QsCo8dAcJtqFoETSY_0ILVe7ZhD
 tShUD7h5bwZoNH99jBASlLrlqmOSgSUYsEBkwNAwQGwUGsyiLNgva_TZD8uHWbFmertT4DehQ85m
 jrv6DNDk.nWYqfVXbXPCGrpkBIUZp1PXSE52n5YJG5o2wCG3KRwWFdqj8Tueaq6Kvwk.JJ2Sk.bZ
 l.aL2p5gKUeBj_DJST2064lkQMmhxVvFeG78ADhH.X2M9g2DZwymiXGsWQ2GWUFJLAD9qefj1Z1t
 4VD4akg24IZ.WbP29pKBxkUKN12ntBwZiwCBZjdQ6olA1AwW1PEEUL54B3ANDgq0r4t7tHNo8nmB
 bq1myftlJjmXTJtIS8ErNxvfbmKUjmYPi0jX08Ycsb._s3nQNx8cPDTYorKl0tAv3cYIEUyp8nxw
 mLAUMGZxkFifKzPazVbFkKrqjf9v42Z_Gkjf4bYjVwpgKM2vAnIhQ8JwYfd.sOC0enKw9v2oAq6d
 _mQ7mpZAuN8pPhUyf1QpF6WTp9Bq.KkPoYMz_I.BNHlxNwBk1fsEAER0ileicJ9SafQGKi30c2en
 pjS4lmEn4F43jVT.Pmg099o6bJ3Hd4ZGwcDCc7mj7Q3YYfml5H04RhtPaXb2VvC4Bh7p4J_W93Ie
 Do3b59QLMnaU.KSH4VsBvJpwDaemEGWrPijnOwaHml63MFtbZ0ks0Nw8JkZ5ZPxwWZJYAJeRm0gf
 bzOH114pMSw.XHkWfvEY2Yxueb0RhOYc9wSo0jKznkwrx.EJFhpC3zYWv9Ys1s.Ii87t5VOx_aUi
 12QrPmKc9OTr7Czzo.eTlkKLXYPnnWmHYxdIeYqES4ZEfjMOLCmxxWLvFIAFwLQUagY7Y1Ppgdsa
 eZ53MlTPMsiXNTB3vXdp8s7AOPt.uom_eisHpYHxckP2eHj1gzXXzvwcyP1NxDO6aa9Yk0ncBNxS
 zdVnHPcPILvhtGWEyRGDo.Dfmn2eZSvQVlWfCF9pds3o2s8VqyFMCWIxfmD5HWoQLWz2Rrq.cyA3
 OmYZsWPhYrH3tXRtuS5lwomH2JCV_rk2DmSKKmvSML8Dtyo7W2U9YislaMKwqwLwaVoLGrgp3gD4
 etML4jEN7vKRYF3GNJC7XQBMBXn3y4cD8T0fnAkQ99XBCDdcaFdsdNgQUggZIS.Qx_nqLcPNXRCf
 TkFPPciziRqRDa5e5tZx5icK1WCvoPBO2s7AOtyBMn4xSrQnCMS2IEmZIBhF2z2eU5Gv35O9bBE2
 Mk.35HyvXaxY_d2J06yQdQsjbFfKSmclvFFe5fh14eJ1jnZQXrBb.0tsIoskoH7nCkz3s40t1Uh9
 nCtbRhyZVsZ_XVogx.URBMnM.Zffnqvv.cw8Z7jFIE7.eqg4oSAcbm8ukO_1qsmmxqphs
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:20:19 +0000
Received: by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9a4d12a9329a89eb5945214f42e285db;
          Tue, 24 Dec 2019 23:20:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v12 06/25] LSM: Use lsmblob in security_secctx_to_secid
Date:   Tue, 24 Dec 2019 15:18:56 -0800
Message-Id: <20191224231915.7208-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231915.7208-1-casey@schaufler-ca.com>
References: <20191224231915.7208-1-casey@schaufler-ca.com>
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
 net/netfilter/nft_meta.c          | 13 ++++++-------
 net/netfilter/xt_SECMARK.c        |  5 ++++-
 net/netlabel/netlabel_unlabeled.c | 14 ++++++++------
 security/security.c               | 18 +++++++++++++++---
 6 files changed, 37 insertions(+), 22 deletions(-)

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
index 9740b554fdb3..9b8066d02868 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -625,21 +625,20 @@ static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
 
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
index a3be3929a60a..03ac668c0c10 100644
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

