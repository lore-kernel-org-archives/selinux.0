Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF605C2D0C3
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F3821D7D
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NtUqTZ3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfLPWZD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:25:03 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:45536
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726545AbfLPWZD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535101; bh=CflM/BYE/m6vkCFgy2DwlH+gpJmxaxAxuCstaWJenLE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=NtUqTZ3V5F+X5ON6RS3+jt+DvO1GGMtS8Ja0CM3bEI3XR+ZECghl681wf9UVkwfLQeFobOgeRPXL9zBQxVhcYA+FtsCD4eaVY254KbkRY/rKWtIFnJwsd6zg6Ekzhy2lenPpadXJA0pbjtXx36QQr/vtIfXfXoDkt3JCxsEbE+co+w+HT6jDzKUx/DwPZuYogZo5wp7dxqu1+9O0fNAPUH7Y54qm+IZQruQ+FW3sE0e+YgVMmpwRh/qpWg1E4rEUSFAp3OcK8doTF/5K9Zgfsh9XI3LsqkjbVFppOuw7XhWjFBJ1dMuYTFQzvQxNKxsHlCTLX5mf8JOMaj/YUGipBg==
X-YMail-OSG: rkERSv0VM1nHaA8.jc8nh.AfJWpNCQOQJTtoQhv_tyko4_imCgqymm.D95jVdxL
 1_hgBNj8Q3BXXwpS39fgXM.EBYF.iugChuo3MB708e8d8qZGj_7_0MzZjC2wGqeJNWn2ef_yFyS5
 ChfEjxFZv6mi2td7uyZeO4zwEZzaqdj0idP6c.Hcm8Qzj60nlCVf6l.Us8LPwl14vcf4AIeytoRV
 q5CugIXjJxpJGbsx0tRJcDQ8F0cztT9Us9WRy.77n.EbQtxy0aW71Cz1zkUOQRgVYbIjyXafaFsn
 2G2aLxQU6NRmz9UNlM.0GUkLeQiL8_3VpM1IIBtJ9hQDr0mLx6ZIfPGdfBUtxG3i8nBeb8wXdBNr
 XauBBbULTnhc8.JI3xzghdGdlAEabaKxaFNZvHwyBYmQgcVs6a2.sxYyVjHYPq7GtKz2dPB5A7dv
 zMfiI8hkl.S6gGXlFL6NBNC6_1i1IaXvOInYiEW2WskGRFWwqixIFA3iJBIpdVDqnaPMrEv._o7D
 msPREB.CLcrK_L7gLYj7qmliPl5osbclscSKviw9bjw32q7fip9Q9mkMA4IOoy20SM03I4BhKRto
 pD6nPS.Dat1ZpF7d8UD70cooGX6j3nyWsgb.qG7bHmPqentzpk0PBeDmNMKZLdeul4PhHxEzZY4_
 n6Yfn5mj0dIEDMYZb0XNEsp8.CxwVT1Mbg9G7Tj8VNC7oCRgN3Hn8LXgqkbhgDSn4KonCW980A.B
 ak9iEq0MDV1SKjdlKD0z2B0ry_wUR0hOdELXq8WmvGa7sq20WwdPpdRaSL5SyIOlTTKe59McgELk
 rzOdStIUuHTMs_d5fX7x4ZcXW69WloAV_yJlA_BNt2zsnNL5KhPAan9.28XuaIsNvbSRgLKtfKGY
 hNKYQRitDlmQMxIrPAEXz43nCQN0ZyjIZlr.ttUMkAGZDJwaVZJt8GVAcL11yxHknKX2khRDcK8H
 B08NMZM1NsOQS1ju.tUrjrRJSGxdbUVQosd3kB7KNMdcJoXTNya5qCKmF2iic9EMAw1UxdzqBy3p
 JeX.QYfYwuhTm0Q_61vgWcaVFlG.3qq3j07bXfyznzyjFyAVg9YB7AUJ.dBKpvM0Viz3kFx9CNih
 GtPocAXrX8cPsqK_rZ6ks8p9T6xxbKbrtXt5fx8rrY0tVg8JGhv93Vv8_Swql_NlGROFcSCsunA0
 LdTZTS1T.gBuqcM9SCCHQO7cHAzlnnwAfkaFEMvWuzjwUpIRhqD2gQ4ZX0HEZo24IfQj.oJD566Q
 hQKedUCR1hStF8wLBjlbi5Obn9c0.Tz7Q_SwzWpJZFJ_ydsemEA1NiIKVlZwqqzSSBeYU5LJjqvN
 5dcdqA3rCr_tncQUnj5KaBpRS9MVrgEw2j8bKxHL5DZZcTQAjW7qHKg_836FeEV.Ta0QNhZLyfl8
 VpfxPxaN72xF9zczblf5PY8RVp20uwXRL3IEl6iPsBWNdVYVWxhF4HlEnzA1JSoGHkA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:25:01 +0000
Received: by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1be22e4886451d124518193455ee7ee2;
          Mon, 16 Dec 2019 22:24:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 06/25] LSM: Use lsmblob in security_secctx_to_secid
Date:   Mon, 16 Dec 2019 14:24:12 -0800
Message-Id: <20191216222431.4956-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216222431.4956-1-casey@schaufler-ca.com>
References: <20191216222431.4956-1-casey@schaufler-ca.com>
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

