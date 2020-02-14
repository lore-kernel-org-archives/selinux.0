Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B74C3F68F
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0610222C4
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="K6m4erOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgBNXoz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:44:55 -0500
Received: from sonic310-31.consmr.mail.ne1.yahoo.com ([66.163.186.212]:45743
        "EHLO sonic310-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728236AbgBNXoz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 18:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581723893; bh=7uEuOMRa05eNQvWzZSvo8zwgKED7of4sujRisHV1bww=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=K6m4erOA5A8mu4pizTCC6e9Ifp5dzyHObxl+yU5ZnJBi6IlvbkvF1eAC6A+nc0CObw8Q6mjWgigXJStti1otHDQgL21vtkv18nU82Mp2aDwBraKGH8XZF7sOElgLJhWWKAApa6lcF70jC3IAVY0CmH84rOl9u/rThehwp/juYYWmsdCgOZLFJNLkkOfWZCY4fnXjf7mTSyfOImKMPG7uLR3elYhfa55k4JupYmxlSllIAcPgvoxi5fV/MZG/Jk3M5vLEcr2oAExeYM7OpmaOQoNOixlsgk05ViEYtadw+KYg89YR4iWJnnw/TCqdpKvrQksa2J0fwShCLjBeFs1vrA==
X-YMail-OSG: dmBevWwVM1maW2qwnizCRZdPncSaCxYxxmiwaePZTFQuz7nwWYky7n3TClXS_w4
 2J12NitrF_wLFRJ8q5_sZO5MlIQH_BzRUCsT9o3soKyRl7Bi2oAT4hVYyb1rvkKfUFiFNvEuDl_9
 QAxOG1NMZ5yBUjcHw_b1YQfHKSSLZhVADSiNR9lyPgIY0U1mIx6.4tkGjCFlOVwpMuJ7kz3NTCoV
 vP6XNeUlkMlbVo9Y8jnho.s_we0.goJmoYhxEXohkZP93ECuXD3TuAMOPocYsbTxSBhXrNzjn0vb
 b4molKJsNllPfXmJhGY4dtIA_E7w_woo3KB8Q24OMOWl_EKdI3Tcq_UCteNRCtXaMFM.hIasXK9T
 VVSFYIW_I_LtQk49AA5nNHENfYm4kKf_aVr59HPz_3IUmXq3s4Xn_M.LJpIY3YEB3PkFbf.tZrdK
 V_7koKcUGcLlLOXzOJyzCbQ9Up3PhTt..X7Bibhu4Vlzx93CE_zvJDuKn6E9U0UGWwq0.kGf0fgr
 y9ZBXUvECJ2tEq7M2PZC9NfhiPbCGxCp9JdWxSuf1rHjmrifb6v64CfnIpuN1aHEMRhXtXm0vgoq
 3tYqw.34mzutKpcOMK5QVl7DAZ4G8fla2RyoOAPcMHRM60cRRU9lTv7U9iFao67P0m5WdPuOezdk
 NJobgAFSAZFgw.rfssWgypnCDCI82Gk3FU1RpQNC_RotnH564uPMN.EwangVRPkLlmEksyCmKCNv
 F0ODeQX4Ilqdrq0Xml6HlCaVIIogpXJwHDvHcw2j3wrR7.5pgrJVcgg9FuxUKY54H7D8e81T8SP.
 nKWWwxmuhQimWMcLIddmKhyXAvnn92DB4kvPUreaNXkR9IHabigR1RWdS.Xatp5b3X_0sKgmb6M.
 zm8alYKQylRJdkC865cDspd3AcmAD2QfQFKfcXRlT1TzYDrZQmoijfkc3AjN1Q1VT3iFSmY9VLa1
 og6pvgE9bt_HidIjtBtq8Vl1m7CpMgX4BfGO0bIkzxe3x5a6FprZilb7qOrZS22.ApQOHB6qmt0_
 dZp39QKFLsrleDtl5cXH6rmsUM2KEPtqzmhhUiaBB7bHNKsdjCgtIKQPJBD8i.ok4Zl4jx4jfFk8
 MSvDXdnORyy7EyPDjyoPX2De3vWMCdztk7Os9yr5LPJG6OSbUVzr_B272cUQ2BUPRersdkUAalTD
 w_1KfnTthXV86X2sIimTuRiLR.U.HElQ5didSGr0dG3c.TsSfSPAEmPntTj4K7gXzWnUDwzqHikP
 sA3.A4tYYRy2yrO1ofTyYKmGdY3SFAKSl_isYPhDSkCETWWiq5gQxmasCiUbA7lh4VzFnmzH9uhB
 tNvD9vGwf.k3KBsuMh8w7kUFnMtb6k05hhi5qgKtc7Ium7fGXTKqGYlt43_Hi_233wdjk_8Kydr0
 VfLCc8YUCIiJUlaVV4amPerX83HqqM6NOd4fqIdr4S.AWDEegjMcnzNMTm8Yvw4DT5AlQI14zve0
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Feb 2020 23:44:53 +0000
Received: by smtp407.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 768a909794458cd16a286f5d22121ebc;
          Fri, 14 Feb 2020 23:44:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v15 17/23] LSM: security_secid_to_secctx in netlink netfilter
Date:   Fri, 14 Feb 2020 15:41:57 -0800
Message-Id: <20200214234203.7086-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214234203.7086-1-casey@schaufler-ca.com>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change netlink netfilter interfaces to use lsmcontext
pointers, and remove scaffolding.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: netdev@vger.kernel.org
---
 net/netfilter/nfnetlink_queue.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 7e91f3c10b29..e0512e91fed9 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -301,12 +301,10 @@ static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
 	return -1;
 }
 
-static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
+static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsmcontext *context)
 {
-	u32 seclen = 0;
 #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
 	struct lsmblob blob;
-	struct lsmcontext context = { };
 
 	if (!skb || !sk_fullsock(skb->sk))
 		return 0;
@@ -314,15 +312,16 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
 	if (skb->secmark) {
+		/* Any LSM might be looking for the secmark */
 		lsmblob_init(&blob, skb->secmark);
-		security_secid_to_secctx(&blob, &context);
-		*secdata = context.context;
+		security_secid_to_secctx(&blob, context);
 	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
-	seclen = context.len;
+	return context->len;
+#else
+	return 0;
 #endif
-	return seclen;
 }
 
 static u32 nfqnl_get_bridge_size(struct nf_queue_entry *entry)
@@ -398,8 +397,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	enum ip_conntrack_info uninitialized_var(ctinfo);
 	struct nfnl_ct_hook *nfnl_ct;
 	bool csum_verify;
-	struct lsmcontext scaff; /* scaffolding */
-	char *secdata = NULL;
+	struct lsmcontext context = { };
 	u32 seclen = 0;
 
 	size = nlmsg_total_size(sizeof(struct nfgenmsg))
@@ -466,7 +464,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	if ((queue->flags & NFQA_CFG_F_SECCTX) && entskb->sk) {
-		seclen = nfqnl_get_sk_secctx(entskb, &secdata);
+		seclen = nfqnl_get_sk_secctx(entskb, &context);
 		if (seclen)
 			size += nla_total_size(seclen);
 	}
@@ -601,7 +599,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	    nfqnl_put_sk_uidgid(skb, entskb->sk) < 0)
 		goto nla_put_failure;
 
-	if (seclen && nla_put(skb, NFQA_SECCTX, seclen, secdata))
+	if (seclen && nla_put(skb, NFQA_SECCTX, context.len, context.context))
 		goto nla_put_failure;
 
 	if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
@@ -629,10 +627,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	nlh->nlmsg_len = skb->len;
-	if (seclen) {
-		lsmcontext_init(&scaff, secdata, seclen, 0);
-		security_release_secctx(&scaff);
-	}
+	if (seclen)
+		security_release_secctx(&context);
 	return skb;
 
 nla_put_failure:
@@ -640,10 +636,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	kfree_skb(skb);
 	net_err_ratelimited("nf_queue: error creating packet message\n");
 nlmsg_failure:
-	if (seclen) {
-		lsmcontext_init(&scaff, secdata, seclen, 0);
-		security_release_secctx(&scaff);
-	}
+	if (seclen)
+		security_release_secctx(&context);
 	return NULL;
 }
 
-- 
2.24.1

