Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9370C33CB2
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9492924680
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ESqyL3ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLPW1m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:27:42 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:34811
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727982AbfLPWZw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535151; bh=jx6SBqD3iFh7Ov9qmHnd1D9nd07iILpEnAa1txjocoA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ESqyL3exKSWdDr8n2tcaMPXti0F8hGgup3FGEHElAPi//UHwzndIwy+1+gHsuUs40GQamH9UutucObTaNF2BNFZQD9gj4v2BIZDM22OB2Mwl/6+8F66HNxMm66+0od+nX6XQHJe0nEjCv5jzYr0UBjeL4sT7ppjym0GkzcqSYv4L/gc7jGtqjeMbWejiz176E9K1sqqhbmxsSPqP1R9MQpYpvNzvdsDX/p+Wu5F+0keMXG5Hmmvg9wX4crvNk2JwGk6ZpsGPiWe+xyND9NJ7BXXtbtZlsoUIZJzHHQtK9OumiBKk1rpx/jtnmIsUhon69R+5h+FwM4LZJek+lfy4ww==
X-YMail-OSG: tSC1aBIVM1lcTSwRig.1Vc27QGalz1IjSTyZQw7ZjkV56UmZryZZkUV4PXBVBdr
 r8SDso6N1.5wi85DH5_f6_oTd25Jx_aJ7gnQQ45O1rofgbdKLDqawKFeLbjx83NWjecAMqCudbHX
 HCNOJGiQJSeKlYRhNQL0craGIBFcpoT9zabsviX1MyTaEyXMcNY6RgAH9AlL3y_fH4L_FmpH0lvZ
 AJ3qamAB7231J5dDNlKMpnqIlyYtXSA8.HzR2TbKddRDT8yNjXQVWZHQtkjAwHg.lsk9oozcaHV_
 lmznIbxSXDJurVFCvFQHqt3I3SloBfkncqJwbWBG6J.ySaEMDkot0vVmFC6ts.NFUhs8WC5dXxT_
 IdY8VPpAoTsOQOSN7tGJSKt64ihh.Iv.RiZeRDOBPs7y4Hpw2wZx3yG0bUdRD_4x7_RJIXdRYtRR
 ILVyEVSLMmXi6.RWXHwYoYwi.Yd0k75PrBRx0VcOL2hASaWZmwNIkJoVMlzVnPQTwLmXRgkD4cUY
 jPcNwZ1oGS8TcaglEo0kaHzYG4XBI3PyDzwtqpEzUklvI6C3LoiWjPKpZFiyz3EiKn1N4qE6zGvj
 Ouh87.x2iXWwBq3Skxi_eVp1p8mCPV7HPQrdUxUAiNY5BUY3NPdeyItGDFJf7Vx8bNwHOyf4DhRc
 LzUNO7qmiC4rbSxfsh.NJiCplXmTDhu7AYuEJEBomZ7twIJNxCqzewETccGV4eS6iV64ZKyqE5h6
 HTscw4jnXndjB8CB0u4Mv3mqOHqjeXkPGL64PM3RDhmzTVgQUWwrYRT8wYtp28PvX1pGKpkA2GR5
 x43p7o1eYhlO2cs0hYfvV190aIxGcAlpv4lyaO56mdAtHNaKRM1bxIJaCOrEMMh6n2NtveF3zDBx
 nRVtbeM3nNhMEeuFXt.kJ27Y1X8NQTic9eoaKc4eCdbxfaUSIbvPtdEpK9DDmY8OScmZ10M3x.mV
 1aXI_aAKa0dUNx4QC_gDQ_houY5OnAJZvM9PDbYx2QCxETtigT_MGijdazVn.SVKKdHyvpDPtJXr
 0G9aWN8ofb0TKvMDv.frxrko9ClsGPU7Pw7QWWgqcoe5XQRVKpZ9Hh7mb1tA8WMZVjooMtr5Ymxo
 Jp0Xpbu.7QQAB6ZSmrvBXz7Mh41cGN519Iplq4IZd7.Kkj.rr1UDlGwEBLYWGN2ydiIXzQ.VdGz9
 9qssDfKPGgeloCLmE4uLy4LQFnOkWmdOmly8uOgqEcLGGKvmARG9G1vDyiZ2.1KY2zA7rB.zakwm
 S3h6TjxfbSGtfSiawCQW5hY1lHi4RIVkK3ol6VzVsAygX1aEc78aeHHhhJBiaCY9icfBg4DxHTaH
 R_nv3Yjsyh5ZPxeEGqvLPxx01nk9d9kqxMwn1izKIAtT0ZR7rIFl7mGAtHWJn1Eqmj3jOThgpbBt
 HhvpELK8RwxqIEjBRVK0xo1ddxoCJqmRCeTEALjoGBIMlWuvYUH83mcgem4mmsaRBee3FgAI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:25:51 +0000
Received: by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ad449dcdff93ede6e1b6227b68a93c45;
          Mon, 16 Dec 2019 22:25:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 18/25] LSM: security_secid_to_secctx in netlink netfilter
Date:   Mon, 16 Dec 2019 14:24:24 -0800
Message-Id: <20191216222431.4956-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216222431.4956-1-casey@schaufler-ca.com>
References: <20191216222431.4956-1-casey@schaufler-ca.com>
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

