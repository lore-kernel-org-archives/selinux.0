Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF331C2BA80
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FAA2072A
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FDbn5+WO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDGAUq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:20:46 -0400
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:46348
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbgDGAUp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 20:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586218844; bh=4fwGYFIaTna7Qau3AuaTLIXKfuJzcUJq32PBOZ2EAgE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=FDbn5+WOZ+3VwGUzJkIpdQXEMgK7J4fJMhDEKoD7au+5Y1rV/OVF88TJQHGlukbu9owzMnGv/oqet9F3u7L08lHoxk/M3zNMEYVVvYXl1zqL9aAAktCnbi84uUfBdW07uPksye5348GWbxdCmiQUwgiE4DWjtHwzpulU/03eUyOV/sQZll7s0z6c6bmATnZljOhLZu1UWIKkfyNsGjmnBDuKmOHvS38Z52dx9dRvzFeWCdAIjkwJmSw8gh1cO0elWaXnxmGeM91Ca9cOuypR60MU4smyWK+mptr/R93erOooW/gRTEX2KTH9RHqlpPVrUdx+h+6UxX0C/lIsnZQ6aw==
X-YMail-OSG: l1kTWOcVM1kOHuppWU6odZDhVsdBmDG5MeXte_siIlauEFtxQqzDJLLZYje.OfX
 BT7HiLy7LlhBsEJnANMC712t5vbpm7ZeKsKsz6WvhiVdlBCvhAitpJ7ABtdRZWLf154XHz269esw
 n1OCys4yGe8X3YHUz_r2_VpcjmbsXUi0nPGvEpK158ndVmUqgsjNfuM0YWgKkgw6G_1zPdBi_NjJ
 Pb3fMzMO0QbYV0CBCxZcUEQHLe1UD8NYo3jFicuq1DDOs7MTsvh5vs_dqJGY5F8EcTRrwjjp6WRx
 vqEAh4zswAXYTSmcfCwQurGPHm.6AeDZWsEmoZFBNVOOW1A3IbFqjJTYpEkFMsAfkMLcUnbYfi05
 Vd56DFtzRxRuvPt1pGNmUTQDSlVTMIcFO1mzr8vhtTGG.v.cOJfJ9fr.joSeYlFDH.A3wXBIHXC3
 KYqnGijQDp4giKzGGnx_.YPe_kotjgDr7MWZ83Jogmr13bG5GIpeX_jacy.6TORo8yedsEGH_uWh
 LYqo3JgZ_IOFR33HaAXSfVDuSa5JREWOtYCfr9bcK62dudLVLI4bQPNxjpLbml_7XIr0JoxscrPg
 yamddYDpxd7GpJX55z7zlStridhJiP_MKzCkMxY37Q52qzFLyZj29qGFAZOWPCHFqWA7DodL2KFn
 B78gHw1SMf_p93aOvmS_e5DqRa8Qh3Y2H0YUxo8lGmxs5PGXZDzXfugCZIs0UGbtTuHHVcUJ92B0
 ZPAR5JrMZcvJZDQluflHS9Opsx8YiBJDYHhFMFA0XisvYHVjHB9v1IwKP6exqiiQDDL98DIErYEF
 vnRaAOFz8c1ELyp6CN2Dr8mZhSp3tei4Vyl575Wqh7boM_D7ZjG2hVJC6z4A8JOab.hnfi18KNJQ
 olrQ4e0GyusFnvei47JSd269agrPrSvJ0iLeWitV1c2yFMhUR7DJuvdGoOLwbfVcbxoQWXbvOT8o
 tSiOuRO5daXCSh7PE65Mtul5cbOJ5eau7yz.8sSDlqaCcox3_KfKDGfuZkhEbaYsZov9quFlcgtQ
 1UeCE2_8ih0hPKa1FLKHR8H1P3zbhD8k5v4XDV9QiqkcNjYbByLnnpz24jzTjti4Tj3C2tKPW.Xu
 6fOtbaPPsqlxpLpSANV5wBEkOvAMF8vbbw4cG.cxeqi4XRKlkU121xBlUPojwnx4.xy4f1o.EIPO
 E2AKZdRl0oDD97LXsQlz6OQ_f721TZNrUlVOA6BbuXjgKJoio3jlIDmiwio76UAlTBRmfbAZx5RH
 zG4Rgz00DZ7k1KS.pR08W5aVkKau3qC02EHDw508ux9F7eh1DVeySLqri.dLDhLiY.QPpLCqLQJS
 yvSPkHvA.KRG_TX1Ywxd1.FeebATNFlaThTAvld6Rh3JHL.GptnBP6DsNAVcHEyoZHaSD4WXidZ8
 Bo01V2vn2MH0DkvtW6CZHk5YN3bJMfFQO2KsHMQJRskCzDWey_v2J391vAa4DVVemqMB0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Apr 2020 00:20:44 +0000
Received: by smtp418.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 86f2db2525fe1a2c095fcf4b017ab2b8;
          Tue, 07 Apr 2020 00:20:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v16 17/23] LSM: security_secid_to_secctx in netlink netfilter
Date:   Mon,  6 Apr 2020 17:01:53 -0700
Message-Id: <20200407000159.43602-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200407000159.43602-1-casey@schaufler-ca.com>
References: <20200407000159.43602-1-casey@schaufler-ca.com>
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
 net/netfilter/nfnetlink_queue.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 880da01ef4d3..d07900c317fd 100644
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
@@ -318,14 +316,14 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 		 * blob. security_secid_to_secctx() will know which security
 		 * module to use to create the secctx.  */
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
@@ -401,8 +399,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	enum ip_conntrack_info uninitialized_var(ctinfo);
 	struct nfnl_ct_hook *nfnl_ct;
 	bool csum_verify;
-	struct lsmcontext scaff; /* scaffolding */
-	char *secdata = NULL;
+	struct lsmcontext context = { };
 	u32 seclen = 0;
 
 	size = nlmsg_total_size(sizeof(struct nfgenmsg))
@@ -469,7 +466,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	if ((queue->flags & NFQA_CFG_F_SECCTX) && entskb->sk) {
-		seclen = nfqnl_get_sk_secctx(entskb, &secdata);
+		seclen = nfqnl_get_sk_secctx(entskb, &context);
 		if (seclen)
 			size += nla_total_size(seclen);
 	}
@@ -604,7 +601,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	    nfqnl_put_sk_uidgid(skb, entskb->sk) < 0)
 		goto nla_put_failure;
 
-	if (seclen && nla_put(skb, NFQA_SECCTX, seclen, secdata))
+	if (seclen && nla_put(skb, NFQA_SECCTX, context.len, context.context))
 		goto nla_put_failure;
 
 	if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
@@ -632,10 +629,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
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
@@ -643,10 +638,8 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
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

