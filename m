Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5181AC2D0BF
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270B021739
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AnxDB0Kb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfLPWiL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:38:11 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:45698
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727833AbfLPWiL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535889; bh=jx6SBqD3iFh7Ov9qmHnd1D9nd07iILpEnAa1txjocoA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=AnxDB0KbGRVger61THhaZnVpxwzEVvZLQ8wPuLY8I15T9xjANLG1uv+NARhtuGUoY1+Gz0MmxYsK6g0NLB7Tl35rDjy/WPvin52RLZSyVmd+t2lBgy872GhXsbPjaWLO0TQT+zA2jLcn80upNhq4O3bEZjqIkKso+FEaOHDF6dzPYat37F62HDYmHxu1+UTIlZnccXt6G7/dmQqGR+9ZO+7F8q1g9Iz3wmnwg5kWG91bezslpwmfi0Kj+W8UcV73ts5x6BGWfCzwXTKOi7CSwO/qjDHHN/a7k6SGUmICDv9g7Fyn+kcZyCF7yiAJJBnYB98n5k62tphnF7c7txomxg==
X-YMail-OSG: 2J3m5usVM1mmc.1MkHcG54h_3b9UrNSx8NQFdUySmtx9zSSgok5Vs4T1uixA57g
 t6vbPOqN71K298vyyD7SeZBci6IV9g7z1HBvuJOFWJMs2G6Xd9uap_Ojjlrs9X04AZhRb6TFtXXH
 TGExlJscyrkjq4ES8EkbAiycRslp.RwASKjR4sfSgurElWxvGSsfI3hbHWwcuhDkVdhMvVcSvLnO
 dTFESRQgwhpaKr4TWn4KGbF3Sc4cyOIlQh8XQwN3o4RS.B5Mz2A78RKQPr3gXdpMI5hqF0bC1iVs
 YUUoGQiPjzXCIQ2jQPzq7sE8LysDiFo84lJckEkLnVW.ErDVsyRWyGbLQAF1JhbO1OVw3dIb5AfQ
 4mkphpvYaVKoFgHScZmv07PkYfFq0RCGg1iaPF9rhoqJGXxL6Pc1wMmelB7pRHY9jSc5K4DveX_R
 F4LWIL44J7qnCt3j1Lgl7__TsAwdyphfRRDSaY8ZNO0JFo2s6.K325qaJlHHZxVPlEIhPxqpkVzn
 ZHnoqWHn0QPI9B2v7AtdZHOO_sqX.E4obVKTlrpenNAwsxktKyb.VJmvmYNG1Le73Uhi6hSt_UUv
 lTV_hUQ8bPFEwi0rgwKrupNxgzJnMEhn4ctWcwKy3Aj8kD_3MNREo_uXuddkdgOGUauMypQMvsWZ
 Iimd.RLd86H19KySCuXfTcoGa8pqPSDF11UVb.rXZOTI._W.g9IiCKBY30vjEvUCn_04fjJUpEch
 bSJwsORnhbNo0mfoSpefSua7iI8ycLl_Zl4ck98frZ6mqgMa7W1bDwXlCw8co34kEfMNYdaFOfBF
 9ipJYjbMoFha_x.0IN8E.FnhI0skpLd_JYBhAZH_cTuauhYlBjUFnStAjkWqBjeUMXYlo9X7CzH1
 rFPr4OsjwpujstOVfxuwTSPwJXy0E4d7a7.P2GVT3aqD.ReUZuvS5QFCgCseAdbtNsIOzkSSjPpr
 NKSHIlpe6iNW5Pk5_Fig1u8YB8Nqhi97pq_Ao_2V07lXw34bQV.NJ0MbTh8frlKsohycouF_CZ7O
 p.X7C1sdytHyr7ve7HpfrckM5XlKWxo0bptorDuZzP7lG7J1K.Lths1Kt7hLXFty8EEEYV_1fgfG
 5aPN6b08_DN.go3qsNy2JbybxhsZm8FgqFa24wj.x8PD2X3QpkzpxJcp2yugHPQwAqx9SyNX98L8
 qQt.MxSmZWPxYLB3GNB84Ka75eFZNWV1w.b7UvZ.NZn2kXTYhOQLG80qGbb5NZ17FT1ftcl4NWbP
 c9IVXKM4RacekP8Qn8ogAek0p5Psv5WNRYkjzEzeobQcitamKDjXsZdmzQb_fmFnqSWtsoROcuke
 J.oPb2EvQXxEh.C0p7A7Zcy4AjWrJWZKVCua989sQp76edYRujqU9KhWt_LP3JOO2y0US7mKU_.G
 Vm82zmdUQAVJDKiBHdGLJe_6BoH2MkMqUtgUXoOnjPEzq5Hpy4.vlKjCyh1G7F1AQiWMffQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:38:09 +0000
Received: by smtp424.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 19a4a615975b36081bc636e8892a49d8;
          Mon, 16 Dec 2019 22:38:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 18/25] LSM: security_secid_to_secctx in netlink netfilter
Date:   Mon, 16 Dec 2019 14:36:14 -0800
Message-Id: <20191216223621.5127-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223621.5127-1-casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
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
cc: netdev@vger.kernel.org
---
 net/netfilter/nfnetlink_queue.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 2d6668fd026c..a1296453d8f2 100644
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
2.20.1

