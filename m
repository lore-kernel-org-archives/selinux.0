Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A7CCA9EAF
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9142821A4C
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WIqFX8nF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfJXUxa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:53:30 -0400
Received: from sonic314-22.consmr.mail.bf2.yahoo.com ([74.6.132.196]:38348
        "EHLO sonic314-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728615AbfJXUxa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950408; bh=E4ZPd37KA2N20mK3wBEmGvTwZWpQrlsQrFTPmyXCfFg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=WIqFX8nF3Mpvt7QWCsK+CvPzBJnYspJkTFI6ePHlytjtovbsRngT6Toh7qzD1rEqJjaCX018TsbYmHDvAxyMlqy4YeMoB2qp+HRU9ek967VqPuQ/1AsEvVDvtLTNdiqC+ZCp7+xpzeDtEJbwsZ1AxtKMsvjBM89+jzCyiNH6WMP8F71hkDW/N2Ce1whpC2h9AWtqVW2ZYvkMkNrsygjNumJ9gpB4MdPLve3KyE9VZEZpAhLVcjiMME/TJHAHaTalFRS/7fUVc+VlUfIB8QNTIxBTex5RcZwuczi+qd+9SxP6kYIv0+s3xIXdXj+0cAJMFfx9aKtRJECuqx515ySw+A==
X-YMail-OSG: _KQneV8VM1kr2PhOYTuiSv3EHnYqTfJMt4AbIyqmHomjq1953skh6AYfvZzyxso
 efI7VGZo2FxZnCuDekIGAukjIKoHfBGhtzPhhceRMK7_COspnvOIc3zD2lcad4QDR843zM9W58Zx
 TSTIC0YFr_Ue5fqAZ5Bx7iDoaFj5qzGXeIXadWF06X5JYuwsvTiXOzUvakH5O3RSSSvF71ZZmEPe
 OE1nGO8pGOnMAS7VsPDwTtJ_YsI_Slogtxrwslnw7O3vwbO0kX10JzvToTnG9ZRWsE.wJPYFQAx5
 zH.LwPSDg1x8KdMfFJmn537pkr6CxondoNLcR1reMl1eyWj4Gbpird_9o6cKjSHE_Dx70uyA87ib
 aB2WlWNZU5pQWXb0j5R08sPHZRI4dJ7sD3GHwAMWuJ1.5e34jL0keZ1JMb51Xjp.Wlv4TFgGVqzv
 iWoL4h0lYjDeQEfn_ugnW3W2csd5U1Ic.nrYV7iB3JebetexwKFfgk.Jb81vC2pSnsMXzAZY4J_.
 tW_2ESznC3idjcGp5uIFm33WW0hcBrhKt4pYYNEG2RA4Pwyro1_uffQXRdunRzEBz6in5NhlhONV
 EMNP.yBQe6zuIhFqb1d0tMHJ2OcMioS9xw9NB7x4zU.ymwTgDVrqyb2_NhIelDrItK5t9qNjc.pq
 ux76vqQ4ARfY58fVWlDjJRUIJmVQ_YqlCQxb75RrVn9DK8elmxdhQpSbRtRu1qLkrh5kuvEKDJfg
 yiLkFlHYnL5JFrDKM5QXgT1KUaIuLT7Kn.0HxhRsiZzSQWzD4fmg6huUWwBTb5okgufgxRmhdXAz
 VCozYH8YEaZjQ31ZZs_OqevM2NZ2srQ3qa2IVprr.kjZXF3_CQ0wmetneaRNALHmkzJZgatrNUqV
 P_HNR3YiYp.YDXzvffG6ioVAkoaJgcNj6pGc2CxdkqmoXSr5mQqJxkNLNNRBcXdlJFhH1jVMHX.X
 BKP3.OJSstx8.97URFFI0OXYzXNSfBBEEJvkycZMJKwRCpTMA428m4hAiDONZ6flXlzBJ8Ig9TD9
 FL01SAdKLaoIDKTo2S8R8q2kP6UbN6U1Fk7EfeEz7DEwF_9mhOK.jksyXDJterU86xFEsMW4YHzM
 TxdPagSvA_qoaZB1YL.DKo1fDi_22A_5Qs3heHwSUjbIQCtRc.PZePVQ2RUYWm_kUK68grtghp26
 Yv01IDZ7VoQk41fNqBBjUc6815b9P13WntE7Xun2VoMXVPH5QHbJjBUc2xG9VzdhXRZ7vrPg3ybY
 bcyViDQyhFvS5IT7E1BRENqEXO1t9XLEQGbSpddsZdhrGGC03GNVpukCiYQEiKauJ6M81RU13seX
 ovIFSLk9T5clzUBQnKxaTWlBylDtOvQ3EUcgM0Y3livfpxyfn6_YLyWNO27jbOnylfo37nKVmWsk
 F_3ggwHGueBWKQb5Z1yEhcQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Thu, 24 Oct 2019 20:53:28 +0000
Received: by smtp403.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0cc137411481ced1a298f2ec2316752a;
          Thu, 24 Oct 2019 20:53:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 06/25] LSM: Use lsmblob in security_secctx_to_secid
Date:   Thu, 24 Oct 2019 13:52:09 -0700
Message-Id: <20191024205228.6922-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
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
index 02ff6250bf2b..2cc0588311b9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -439,7 +439,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
+int security_secctx_to_secid(const char *secdata, u32 seclen,
+			     struct lsmblob *blob);
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1222,7 +1223,7 @@ static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *secle
 
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
index bd685be33b56..8e4f41d9af0f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1921,10 +1921,22 @@ int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
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

