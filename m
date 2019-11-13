Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6206C17448
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBF321872
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KVbFsWNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKMAA6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:00:58 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:45503
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726969AbfKMAA6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603256; bh=E4ZPd37KA2N20mK3wBEmGvTwZWpQrlsQrFTPmyXCfFg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=KVbFsWNzDJVTJRY5GmyRIbNX/uXqiBlMy8mZy7Jdg4pKqGsjL3ISjt67eyiGOZNOIfZqGPB2CpDNZvIOTQSE/G6m+4hiR2FIC1bOgsodxLVX2w6FxQXsCj7JGrYrNzgXcBMWPo7t2B3mbg3izwpVy1xrZsmTGDUZmzaNC9uHTYf49xhVGeN/nXaitN1+/oF2QOE8+qf4RSGfiNQXU7YNbsj6a51SsoOdBpruvy9izlDFPdqllV8D1u5llLAXPTtp7WalOZ5PnsIH/Enp9Z82iaUXaMX2Vh7XpwX4xtYJIQmf2LVlPEXUEn39xRw4oVA5Oxb9JXJTT4k4LTiukiGTAQ==
X-YMail-OSG: AcuW4HYVM1nF1VjuURJkLqg1duM.qy8UBI5Nt2qBcChUujWb4hqEsYHxN7r29SE
 egH22l4Jx55fWKVlBCME0l_nvQXLTHIjrzQaDB0ja3Vrp00chsAP27e_KnV.HZxMoI1BXW4Q4WRa
 aQnh5sugONYZqZI0Zg3t.JL7VqhkBbNvmWYS.cE7fe6S4D90sIQt18e6vAHwt9DSTvmFTbesAckE
 ebL8u3dNaclNX4oCvkVBIZs1y3N0SRVm9Ux2RQdIykQovV_j7LTOQr7aeXGWL2pI4ZVdTJhiepeX
 fovp0BpGPkhFYn0K7_PeEx1lZi25wbVQiBkClCq4qJ_mIJ7a1w8uaCUQAmEPv0I_7IcEYc8VjNe6
 kGk_bls3_WbRRFDEw8Xqaxi6E0tN53WqkFILYSMH.A2wMPg9aoTxYGJSwfq4ZuEk9SeVeVdy9uBo
 gGrAddvJMlS7np_8BHDBZA9XFKvqnWWM5cw_lb.XPdfRs9I5rmhLw26lWkNoiaVcScReZ9SpCicl
 yqvJHuErzSSxhMO7KBsKyFe2MQTxez1C_92fYHsSoYqjTYH.rZnNz.WWvDGjC07N78thlxlqN7y_
 fcnX17Zfi8ojjII7ETcSJjif44rmrkak.vPD28z_McrpcDsE4r3pjyEcJbjX9TFPpJQ6c8Sjn88j
 Z5iqf.erCw7m5u5LoVz3xHunJkVYFdqP_BjDzlJRwLtHzyfO4Sqy5SbdUH9VsD95NTe39Fh9JK.b
 .bRVNJFJvfP88KN3PB5OuJNX0Bhq0uFDMncbbf7LHxlUy_7LxLosFe_tRTjFBcfuUz0yLcZXOPy.
 EbnawccXQzSrdzHfRDhNK8e8CSW4UlEHlkeD0bnIoQjPw917SBIoh8OLyQpw5QuGDN0VzTB6rJLd
 nkXu6Mz95i2P23VI.m7ozC5Nd0Uv1w3Y4plUUjBGhwrUxd0UyH705Bv8foCg7dxxEUvnA2iKuoaQ
 Mx1cmKKpv1aifsIUawdezmLaPKF_gqTalem.v9Br_U1qRIvNG55_jEJoFkHezLaF0MS6awPdugXE
 eXXvZ_8hTwf4PfL0xC8oGsfaWFNBGtDN7pZtGKI3BH3TxFp8hfgePcsa9P7nrNJP1eTVHa9GbQhy
 WEW1hYCdWgyhMcjzs5a1fqTPUT1XZcEqg535bWatJBPsTKdNIJfyFh_xsAkbcVvsFEwECNNeCRPW
 _JkYFk_yt_HobY4mYJ0nwsHsiVRF4IihJUirWGT3ZVS4WMekLPtHHTLw_cXKbDPbvNT_77rofCS5
 IvgYMtHZdUPkRrDPSri5V5_BR0fqBYRjQIub.rAiY6wJca8STcbNV9145PpJ0eeGZGaLaj6GG378
 SFb.YeACxFV0R40aW8gpjD1KpBQAZ2wcruSUrwN64GUq5QMVnsaD6gr3ns4cyFkioCJ6D0X3OOmA
 rJzNBFWJ90_Z7jNlZdlKDLQfE_AVejfLgkjYTzahb.pNz1ybzOQLkro8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:00:56 +0000
Received: by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4229ab0c2c09480daae2d5bd36928ec2;
          Wed, 13 Nov 2019 00:00:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 06/25] LSM: Use lsmblob in security_secctx_to_secid
Date:   Tue, 12 Nov 2019 16:00:03 -0800
Message-Id: <20191113000022.5300-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000022.5300-1-casey@schaufler-ca.com>
References: <20191113000022.5300-1-casey@schaufler-ca.com>
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

