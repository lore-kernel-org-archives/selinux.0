Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C284C3A5A6
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D772173E
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KdumSXWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfH2XaU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:30:20 -0400
Received: from sonic310-28.consmr.mail.gq1.yahoo.com ([98.137.69.154]:43604
        "EHLO sonic310-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728295AbfH2XaU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 19:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567121418; bh=NX1Wm9mZ2rrFAh4r01JvGuFtS1Wfm+5+bHPs+vG06x4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=KdumSXWVnk7MPX/PRbmTBz06UWydkkrc/PubkN6V54WUAwrTNiBUhC2ZJRZlvTv/0LDnctbSqdBj12jYEueRx4IGX4rL/lFc5Lnxiw+JpZrAfQzv7UQg/6ani1T9d59i63HCEUH1k1BLZoSLxymf/jXhJTT5CAdHY91QxSWwMj2x0th7M8PYy7ubPtQHbTHgfjkgR85cMyVy+S43je5n1TuiUyZVgGqUB71FRT1T2mdn3fygdyJQHPW1GgV1CIN5SoH9xj++z8eaIeZwktlw1pGPgEzMtbEt/eiHRi/5H/j1O3Yzome0zRU93uLNCxWhObNYBuimD7+DSYTTAI87Dg==
X-YMail-OSG: k1AO6u4VM1l7D_9R77afib1Fxxa67Q6y5YXiOj6DGp2awbebriKHCfxz5zLK3Va
 hRPp42lDfiZzj6IrUBShGP9anRBtSW.8SGVn_KfFRJi6LzqGQu8amZx10rsT7ZjRVaoF8Nbnsvzb
 KoiVSBdbdHMZXN5jomiowECr0TVpu4IIghyEprVA2PxFC4ZTcP9m8Sb9ourdBjvGYVmYRXTwTXZa
 RakBzmdusWqKaOlVnwKQYMAB1ISHwfLxAV6CoEBB2VONiYJYcAzkP0h8VvO2nyrHq33QiyVvBOyp
 N68ZcCxEyAZlC1VEqQzSlSa1Bf6p289.uzYGhchChO3IHdgOehzFiel6.mXs53jVhXTlO1iXg908
 JXu0XnfB.DGBmBqgABoFULjhuEoEXZ8XkSGjatM2ttuKAPljXsdjRya2tDuelY.0ulCjicy2s4Hv
 jQtmMvdq1o00cFzq1D_SKDklFiLbIAeMPmrFzq58UNBScq7VdbUV0xwUBcZ.6yeyIE0kT0FykKsY
 CyfWKwC6wNnMZ81PYEdy.BgjAapbeeocD.gFrWMBtaE_wAkiiQTP4b3ZCVVN3E8P98p4Qi9pU4ZW
 Bbyd5qMXgiUgUor1h95gt_Y47cQ5HvwQo1YWe_VAWbo7NZQ.PDDpfRxx6jSSCaTcJNtZGV6XG0IA
 XdCznwoGaxieQsl4BDgLL4xhTNL9gCBBL.KtJnoD.5XrjQEVYCB9F.HiP_rqYZIamcvdOUjt_BQq
 lUMoo68bSCbvGqQHU95EbjAUvjmlr0gNc3LjiwEQy55j_UPu5huA4Ol6iSqPc9DH5vyYZPJHW30S
 REgwFzD99L3rmVmnIwG6Q5Ffb.MJl8px8qLHyVLDppNcUN72vHY5B2oqueTYStL6yhYTXKif8hUj
 IBl0mIwBa6S2c49bufnRy.uFXUfTOWX0zkrD2xcde3t08eZ91ixNicz_p9e062qYAtSh1lsk8zBA
 Q3gvGlYJ2tl9NoznAJlz_od5eSAXS4r.L..F1Rijen5ig__SzCLGj9ZnNQU_1bqBwITdA_Fb7gEZ
 CLCGVAi3Ln_763Tq3ey8ywD9t0rvf5hT_y2zaTZcCZYst_7C5hXQdQ9tyJMAfxBzHFQDMuXFJQ45
 MV9kQ6FHeR6WxSCjUL.ZcucXfP4Dc6dS08f1BoYJeHHcnzG02JvA530zVc.3nslCS9VFVy2r8WOX
 Om.1WlYqS9xFSl8tq3TgCYGpNddCJeUheNtuw3Tgdpm7AT8F8cz2jEBZlAhWgul0u.hHLe8sTwdc
 dQLDIWFIASR9.rqxE5UvOBxUywQug0I.9pSbTFZKjl8B_CLp2IPe_snxF23Bc6us4mZdlw2htdMZ
 18mAS
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Thu, 29 Aug 2019 23:30:18 +0000
Received: by smtp402.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f8639e220c8a96cf24b2b0474e56d17f;
          Thu, 29 Aug 2019 23:30:14 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v8 20/28] LSM: security_secid_to_secctx in netlink netfilter
Date:   Thu, 29 Aug 2019 16:29:27 -0700
Message-Id: <20190829232935.7099-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829232935.7099-1-casey@schaufler-ca.com>
References: <20190829232935.7099-1-casey@schaufler-ca.com>
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

