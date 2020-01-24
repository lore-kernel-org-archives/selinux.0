Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA01C35240
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42C22087E
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nmWEVCpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbgAXAZ5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:25:57 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:46321
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729413AbgAXAZ5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 19:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579825556; bh=AzN0Yrc5E2uiTrmC3S4nLoRQ2OaZGi8GU7FIVIM3g9c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=nmWEVCpDx0yr2Tj5j33bUBGAM/0K9g4ZVyyPUzwqFN87UMtHP33RytgTsnk2kEhPbTa+x0PvGJoJ+rm67JAqZZmfyBGJGjgq7oGnBOuRYDRu4FcatytbtuWAIRaJA9jZBggtuw2DLbgTvvaQ0KM1eGDVNBSRf9tTOCqYc7NeLTm5jypomKAuN386QboJYBOZKGuHsmMD19ffz9dWuiDu71UPiAapSfU6oaTrr3ZjzFrAs6c1tslxbK8l3eeB82LYDtq5Vzl4QIikjpVtgQY0myGDUE8icZjjHbCCpR0IipGqq3+h/4AHMPRwNDUIyv0adWg4kuzX6zTjqX6osLaosA==
X-YMail-OSG: wI7mK6IVM1mE8beoFpyEGNuM3mzu4NgL5y6cvsmHdwDpRE8DiPIoJ9lPpJWaOwX
 pWVUzgM4i3knfltM5AnIy.U3gUGRTO4uA5NwEzAulhoBYOi84RqXy9sRXnJyKXokbC_OGSxlZ1w_
 nwYNT64a6JMJ1uyEVsDYr6crOJSDesV_0wE.Bi9EJXWUQVbmvM5q065IVoJ0B54LJ0MZLSnZknAC
 EkEfZ3g7DWL28vjDXgLJ3nnSW57RB4sMEQSUVyfdOR81kHHlRdfS0S8lrPpd._g_oYZsP_7fe5hy
 9rKLXGkyFbsphEL8tlr6anCuTrLr_SdPK9tRjf47N.PD2Lel7aK8LGxxmOl4xSWsAuIOikB7l3P1
 mPg_.IrKWG7GaI86A4CE_M6DedOpOyrp6cPVgqGK6C0NgFh3JUjE866_.4Vh5chN5baU8G6aTVK7
 LGFLXMNaeYvu_REHiPLJESWQ8vOoxJNXrPRpT23DLxwzkEEnaNX1flezckaQ6ORhRJY2qGWW.30d
 iSrSSOr1ccaSgJo89vz8X6ZDHPdvxvE4vCIyuO3ozS7YIGpCNdTjayTkVAg6ucthnJNS4jAb9wfg
 qPdO8aA1fanNwZVfgVJWjJoDKvBPdgpeGSf31020eSDSWJdb.qLiC5_6FxgrRP47crjQAO2fgLXo
 GbZH4i__RRU4HAeCTonGTFTv2NzeN7zroKww5cU2xhO7JHnFuSQdXyVNvxqdHq.SpFeoeSQG1ZAI
 dVOfDfCDc9zxHfw56WN.zZevxGYTmUK1U.KgNpZSazv591AWJjDkjxKHOhHS.02YE5usY68MuQPu
 K0qMdl8ysOSXXYD_cRaQVEab6scU0EpAo2PdSi5_y5EhDrM1qio18RmhccVBr2qf_voUdoZMEIyd
 YTWDHvarwPh9WVqRuG1JBpDjWwX47p7nGfkW3TnlCPLZbD6Wf8YI_xbKTX4i5AP3JpJkb5Pgz1_V
 jvnhSYrful19hsviZkbJCyUcL1OZEt.cBcgDCWJ2O2LkyuBsQSZsjGQB4mK6.XFrWRGOSZ5GfJ3O
 qDnX1iOwXbX6_6b_QPlGGGUSHar4MQGlXxyv7qG3HQFVibjCfst9lKAW_qzTISfc6aJmnUjwj32j
 s0W3r81W0fRHgx_SqCDUab_0AHoqGiUUsEIvaC0ejyflVU.Kd8DbRafwkwgrG4elFW.8NFKd7i5S
 lynOMh6gL.p8EbYPCdOzyXqkv8ow1vO9ibszYBpLVUeQ_JPTvTLPD4vF1WZsQHKVNYRmb4da8Y.E
 FFlCempO51aqFmL_EMNNbtZDhqKEtsajBJ7I516XnVDzpsGoFbSi7Qyk8Xuyu3CApl_rvXsAyjp_
 TKWlUpkj_IwNRSM7B8i1EyNTn_QaVKpIIjH4xZjLmsxtjpJyHPmAOBielsPXJFfqPkQSP4HsmZiR
 vIuxJ9v01zGq3AtEKtasltif8kbngOd1HmmsrenrLXta88CIGaxpC4fV2F1hi9cjtLnDraZ0J
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Jan 2020 00:25:56 +0000
Received: by smtp412.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 41a84560f838fac6611e7b28424c2970;
          Fri, 24 Jan 2020 00:25:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v14 17/23] LSM: security_secid_to_secctx in netlink netfilter
Date:   Thu, 23 Jan 2020 16:23:00 -0800
Message-Id: <20200124002306.3552-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124002306.3552-1-casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
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
2.24.1

