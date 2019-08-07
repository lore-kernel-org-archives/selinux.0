Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E451C32751
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161D921EF2
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="h5Vf8vYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389191AbfHGTo4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:44:56 -0400
Received: from sonic307-13.consmr.mail.gq1.yahoo.com ([98.137.64.37]:44780
        "EHLO sonic307-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389214AbfHGTo4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207095; bh=NX1Wm9mZ2rrFAh4r01JvGuFtS1Wfm+5+bHPs+vG06x4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=h5Vf8vYKwSgwChQK7YDYKvJp+Do0ASqKxXU562ACI3rff3gMJNYscm/j8GRZEQ3B84GjgTYSxGJ5himpQ8Sskq56VNwg23sp3TgbiHOw+l8Jv6uXAq5j7WlV66KEK8mqh0pkX0nvejIGfTT9feJovzDJC49hB+LZznxoISMFhve3xLQ/rIclBzFEfZWgeJt/W7psIQFMfZlgmEvoGwzp0jeWZTcNNquKS6R+8T4jCFq2Nq6ACzVjzFRYppJVvzXRFcojzVgQgyToeuW/0tUdvGp0euJcnSpTOABUOK1q4e38Y9Ezy6F6WDeXrLhMlIO83QHzifclluVdiH05kVWlUg==
X-YMail-OSG: wohaeA4VM1nhgKLVWURfhDiTy7.LMmldDNfl9jp4Maj3D5UJ4ZPipfWIzfrKwWv
 Ozdqu1_pRRHpqGPIW6pLspKfOteonlJG_rMJqJvTfqrzwFPONXtN5FtFEnoUY5zfJlO.aUbBEiwk
 .AyMr_uLONeHfg4hWhEVgboxGMC7z2kFEzksoHyzTC7D4PGKphV6YW5cupdFwxHlgvnsTA9xfyA0
 RErDpMI2z1XXJJKDfZU30HPfUDXo8UeI5X74c4f2CatFt04PoS2YOQU5llJfc7oCjANoZiZQ4cZm
 0JcUtiohcJBGQ4DJ74AKtC1tNnfvPwsJ3bRN5APSi6UNXkafxz4tTc7ZsKjX0xm1k4fJOtUiHOsw
 p2XcvP1TJ21aXagJOwwy9STM7KE4V7yjedvAhLhoen7rncLqHZQBvE.DifAks7ozpP6JPoTqA0Ri
 IyPmvzGv9NrdxaTj9JHum3y5hMaHPSfyaPiIvgBJ18SbsujMfr0JFmeYkdRJ5b0eA3ov7UFk2YmE
 WqZPVS9obkYhZ3C90mEtnbWnk1aokWzfzGL2eIu7Hkrwn9_snKpqGv4trCJ2LUlPXVMagZ3PKZch
 L4AwH6KbI.7OLCipS1sUnj94ieVgYv1ZmD4HhMEvFjjpnv7iHjt7NzrW4FS9wS2_XSoN8Pufso9C
 42R5ODc_Ek1GMgzLOQ3rWUyeYgi9znPuWkkF8K08c7rCxa8o2G867.3twDpyLMy0OaHPpho4PWiZ
 jiEkL5iDxs9kCqlwbMEKGYqsNuhC2eXK.DEKQk31NGrlOg7LFR7KNfifrutBCIFaMiRyPmPQ00CC
 AyHAMHTCocgHIkx9H9qq0Tq6mzD.OtPVljlGzE6zTM1xkPwhtrsF7VdFmkboHbO98m5BRL8LgsD7
 11eToULMAXhiCaPR8ymX4l8L7pn1uTiprJ_mIuhMqmIG7TCpt00Hn5jf2ssy5eMnL8F0bYuz2XLo
 pWBYBGuwhXBDrr1OFpUDXO2H8eosL6VzoXGhHLq6GV38j7247s.O8RNg0uMKCJcu5UmdQkdBk23p
 0JL6cXYdtvnuqPbYyxrKshy21.TQGsMrEMhnKk4Kva0LWDU7r0OCYdpKp7EsO9TUFSkBiM1w2t3h
 doGSO0PcKoHXgAS8QPNlc1_QIzB0qkBP3mpyQ4dsT_ZE.d6z1iM65BHPC7aRerh.4R.K4iLsrEJJ
 SVC0jwRaj28egmP1Z.wl.6v9o4S18zC79CjVYa.tIBP8RnpgBPKDg.kLcZBV6qUwnyh8cg.SLsoO
 ythqxg6yPtydrc4BCpGNSxmlDFRI_xEiFZrQrmn68PDBB2oc4khJmEVofhPF3N13HGd0AmYSmALt
 XZqMSSwo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Wed, 7 Aug 2019 19:44:55 +0000
Received: by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e1e2368a1a71816f77f09bb43c177f80;
          Wed, 07 Aug 2019 19:44:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 20/28] LSM: security_secid_to_secctx in netlink netfilter
Date:   Wed,  7 Aug 2019 12:44:02 -0700
Message-Id: <20190807194410.9762-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
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

