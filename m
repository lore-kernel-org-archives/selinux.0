Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E016C43331
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EEA21872
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dsNaMF6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKMAB0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:01:26 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:42830
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727074AbfKMABZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603284; bh=NX1Wm9mZ2rrFAh4r01JvGuFtS1Wfm+5+bHPs+vG06x4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=dsNaMF6p5GzVk0Ykk0rM0eSez8TefqiYX2RWdWof6fW5DOMdT4cQPTKK+6YNNspoOs1dVskg6Prnpo3uSRn1McvzbIIw93rdy/h32yZGCxDd13TjQ6GEZ9/nkzve8PAve7r4bLXukG4Qkjq6TZqdXUs/1tcvraiiN9VFyqfsgcr+FblbizCzWt9OMEpESUIfdKNZa1Mqkk2EGWteGgfqAIijz29kwb5niMGmXHyxPfphv3cu9Y4PJusQAyYhhCxdhlelcOIL97RVP274iTU023TnaUSswK6IYIAYa7LuSII5xOy/xEoFuDVYe2Uhjzjxtwj6/Bh7EXjlGbfq451V3w==
X-YMail-OSG: 8w.6eL8VM1lUJ2vpClHmgZJiafaScIpQu1m6gyV1fSYVyFuuLJ2IdbU7gx0WH7J
 3CbI1ou2E_vuT3_0rh7CguczRtNI8mB6RvMqiOxcggC6xlJdKBV_iCPQl0zRIppJHOEt9HM3NOIV
 ew.jczV7bMHz9UxcH2QjYPanoSMZUqSaJGGc8AzE3FnzNyhZPxxzN1RMawg0qaFPThtYw6odcEsx
 p9bHpv.YgTIPCso91XGnQgPjdgkio2iqSDnhDrLR.8dhNjlkfFMgP1yipUBfaRdi6Yz5Kb_gbDvt
 UPMZn0tve6.vlrKNRPoBRk2mBMxTapG4_ozEZU1bZ0t9oL_v9eFLH_G34BvyXEwiLWWN5mcXBpBP
 GXAUNA.9B3VZqaLW6YDZNTW8.MORDWnSCw25gig92uqBIhm2.OoGGdQXvkrnZ8Jqovrwv72c99Vp
 vn1K3MXoDOPpRlJ0eerFilmUAPx538_SxnF9Bb4WOH9pOH9Fo_kN9pkmSNXtwzP7i6ow6GyGGkbM
 w7sFhm_YJYENYf0u8YuPKiNpeS4.q0DBoJ4TvSaL3XsN812EvytBrGrZb7elvxCEqvGKkeQSkov8
 omsOi9.DUVgJ3I.raOvIpg._aC9maObumrpTVitjhwQoLeOEPqogJgAugO4SddD0H1.wotHxQuiZ
 33MyqTvRWiWH7QKWTx5BI0xlcqaqFigp90cAIZzuMBibUtONkrhZY0g89MsHusWkM1.6hkNSIHNk
 chG3ip45FdhBe_BLbJKwazoO4IUA7oS0rOh8k0UXXsQsu7w5nU4201xteITvityAiJWzAvbnITB2
 t9Jea0MlNasW8axhmQSJ2ZyLqhk4DipkBbUlM3P2GCn._bfegXClnjHxqFhStonl_H0M1zgkcngF
 UVKmKdEcd7lLcX6tkRFnKlu124y4yFB3XtCWBvtrCs0d1bqRoVmISag3SlRYXysWyW3dVRgGFV12
 0R7YOMdabdJ35.6yVzMHHMpRDnJ..ch3rurReX5b4hc.iKqehoA1Q9xddiWxDuZNqpD1XuGtq_Vi
 wGPOJch5MH5GWLzSI4thi0rBN5o2vLP8BJR84FojKEo551ORdNUynt4bQx8p6Nry3DmhpdfgGxkN
 ZPAeCNhEjRoFTy2V6w41aA_k8xnjsN5L1X5T2NSaWfEXsDl9cTgFgqNzycuCYmjyandEJJQwwhTu
 xc29gcnX5Y51Qspsc7FbajbScAQ6qiwKWPY37Xup3CrzHQ8_WZtL73N4MCFK5CbPBqk2CMQYOOa_
 dAWVfxHfUkeguXtcB7eFVHGauaIlimpk8fbnDIsZaKS52D8m2MOVGNX.jhKRwLH1Ah0.AGdJMeJF
 E3Z3CE.Jykuvhk45YmNflmKtOkuiL7pVhJASUTPql89oKaH3DIb4MnHXUlXErssRvgjgTQ.rRaQF
 .03GeKb9dR.1exTIjrR8iRgHRNMccu4t_iW3_8_zDosNhhBKJ1wtHMcsoGSmyRA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:01:24 +0000
Received: by smtp421.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 684ad521453aa3517b6833d573a9ff1b;
          Wed, 13 Nov 2019 00:01:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 18/25] LSM: security_secid_to_secctx in netlink netfilter
Date:   Tue, 12 Nov 2019 16:00:15 -0800
Message-Id: <20191113000022.5300-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000022.5300-1-casey@schaufler-ca.com>
References: <20191113000022.5300-1-casey@schaufler-ca.com>
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
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/nfnetlink_queue.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 5593ee05d106..58d5bd7a376e 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -305,12 +305,10 @@ static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
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
@@ -318,15 +316,16 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
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
@@ -402,8 +401,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	enum ip_conntrack_info uninitialized_var(ctinfo);
 	struct nfnl_ct_hook *nfnl_ct;
 	bool csum_verify;
-	struct lsmcontext scaff; /* scaffolding */
-	char *secdata = NULL;
+	struct lsmcontext context = { };
 	u32 seclen = 0;
 
 	size =    nlmsg_total_size(sizeof(struct nfgenmsg))
@@ -470,7 +468,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	if ((queue->flags & NFQA_CFG_F_SECCTX) && entskb->sk) {
-		seclen = nfqnl_get_sk_secctx(entskb, &secdata);
+		seclen = nfqnl_get_sk_secctx(entskb, &context);
 		if (seclen)
 			size += nla_total_size(seclen);
 	}
@@ -605,7 +603,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	    nfqnl_put_sk_uidgid(skb, entskb->sk) < 0)
 		goto nla_put_failure;
 
-	if (seclen && nla_put(skb, NFQA_SECCTX, seclen, secdata))
+	if (seclen && nla_put(skb, NFQA_SECCTX, context.len, context.context))
 		goto nla_put_failure;
 
 	if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
@@ -633,10 +631,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
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
@@ -644,10 +640,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
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
2.20.1

