Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC81EC4646B
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CBA208C3
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XOBLAXbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfFUSxb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:53:31 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:44977
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbfFUSxa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 14:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561143209; bh=h2rSFc2ghHqIrEXM042Ev062xVOxnPCZZ39NiW40Q0M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=XOBLAXbNJ+gVm9ZIjB08rpkYusMoBnvDJ3ufdM7rpH0VQinn48NG0hLt68S5BhgOV5HW18hWGv51Ol+JcHJjSjFP49E78CzNB7J2wIjIOwmBnSGzsFAjQRhHjkOW8GRVNHGR1e5Osypck+GTA8wfSH5Ps5pM2crroiS8Hw4+s7L6xJdYH6/QRZ2p05JIZRbvj8rudrtK9zIf0eTjJB490af9xEtCvU8QHFVJHqPvMkl3RF5GQzAToO7yu7E2/I8xrLQfryF8sRj81hNPekt9K8hkcS456Vxo+mw+PCW+/gLmn6tzyp6z6MV7tvIzEYo6QzrwJJ6NY7x51HIAsZqocQ==
X-YMail-OSG: vAnr75cVM1kHhA3EuK21SzAlD0a0mE421FT.JzV5TK.LJh0qYKZJzn_wEDHzZpW
 sLQepGacOPQDbw9wGtc2OD1jicmXUw6__g8RYHtNE_j.MdZq0joxAP1fVZO8KAGD1VDo_.J59vQV
 kjdriZyPYRbpYUTWChCAq7WWimCc2qWYZYHR5dCUsO.eZwR94FAeOrBmmTfYVvR.zeF20_BOi9fv
 iYeeeT_Aus1yRfSaq.TgaM5rip8OKNY_BgE08eL4gmPkquYMV6xhlyDKlFcqyOSU5B1ryJ8Zec..
 OHX4YNRlBdTsWb3.iwVSTayyibObY0U6jNfJW2WgLk7vFJx12Uo41lon6AfHzQyEn0Z1nACtVx6J
 .SNgRHzps4m1x2k8CosfbNjJj.xKkNd7E.pShnEMZTLqzL9mZqENz4dZXvJeQZBIqSuKgeJAlIrq
 FvZ9bAaClyH9Y5RXdJeBndLP4F9VWKtvmXQ0ych9Er6CXVDiZsvqEVIY9KWWh3wSNSAHOVpiwwNU
 Rl3gLgEXxhJMQEfsAzS_UBMTHOOGbzFHclEr6aoHvXSymAomsUvlxoOJWt8fqeO0naR.HT.Wzkl7
 X08vJ7L3LcpDEtJjW_6TcyXDJhYDjsduPHYiQ9i.yiPRELrOSjI_YPIhsNqwc0Pu4DB83IxMoNb.
 3LcNbB3XahsA2pYLE._Ii_BEUGR.OXSF7.8bcsfzP0D9Lvp5Q5VAh0tkouKKA1_Mjn9kGOnfxagz
 RqxDXGVUVxUrqTgIcxMa5E9s5J3yhHDDX912oSEXkOq20fkrD5AWdUcDSPOOFcy_EJOMEX3pbP3l
 dkFwz6jV9ztFwRa8DfvXEEKLVpQcucqdGxqZjLQFE7DmpnJ8f.5Fpl32mb4uayYjadGBoewz5CHf
 du.fOpmk.smOGULmUDQqw5ZmGJxKPh45azN3mVOHoAZjuZ1tN1zX0N1N2KkhJQjTXhu93lbwelen
 _39_Ccdc9cPg1JGpdT_xWpF7q6RKRNgVAMMj1dBWHbdOEBrM9C_WpzkXtAJORJAOPSx0Hlpr3AAZ
 6jSCLkCNzvD5FCpaQbAiYmbrqulwutVq4VgTSr4K2zipEUvlo2kJ_66zImpW19kZevZT4ZJaLlYN
 oLRLPY0m8HJhuGUxxfewvI92RRX9JOZ.T71FBSk2SFQxCo3rZEBqOnzo6dzO3XIGN5goVtVpaGB1
 jGh157cKHcRO56CF9zNRSkLKqiAZJVgzycwc74RzOhFkdBIwmy8hCCXR8ydPLSCn.H8Tnwb4bgeA
 53NM4s15z8PO1fiKpW6o8iX9xzt2Vlq25VSwkNUs3gLK_atTjgvBGBnpo
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Jun 2019 18:53:29 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp431.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0eb7bde0fe71be6c1c6028ab1630b25e;
          Fri, 21 Jun 2019 18:53:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v3 20/24] LSM: security_secid_to_secctx in netlink netfilter
Date:   Fri, 21 Jun 2019 11:52:29 -0700
Message-Id: <20190621185233.6766-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621185233.6766-1-casey@schaufler-ca.com>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change netlink netfilter interfaces to use lsmcontext
pointers, and remove scaffolding.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/nfnetlink_queue.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 6da00c7add5b..69efb688383f 100644
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
-	struct lsmcontext context;
 
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
+	struct lsmcontext context;
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

