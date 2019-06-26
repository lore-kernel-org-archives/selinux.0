Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E1FC48BD3
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392D320663
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 19:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ROiAHchQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfFZTXZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:23:25 -0400
Received: from sonic311-30.consmr.mail.gq1.yahoo.com ([98.137.65.211]:41392
        "EHLO sonic311-30.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbfFZTXX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 15:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561577002; bh=h2rSFc2ghHqIrEXM042Ev062xVOxnPCZZ39NiW40Q0M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ROiAHchQmWxgDsZMTtlW5sVKVI+/+HbCTJat4cgqKKE+3UtXSutRaLmWJDMKpRlQmjqJclpyXMex0uHYEvmRwPFKWW0j8zh+5XjRvaHxVqg2O8Yc81xm3zxwQUE12rj3qSd4x9oskLj+1gSmAl+3lypvOZqBh7okCC04UnP6S0tI6gbHR41b+tf8NqzgZytwSSlkQWMXhAoALn2gUoN4oydAc1thCy7MFIBabYPRGvW5Z2tLq9RGqiq+QkCJLFyX5HfC2soX7GsbOgH/tTPmo6YYA11mNUoZye4XQe/HGYo9McX0L6AgzTRHPIG6gMluzVXF0R71sQa4iAp8+cO1zg==
X-YMail-OSG: B8PVOfQVM1kZx5n8I3e825TBaJd1Bmi7EjRQycfPjjSlfoCRYakrgLjCBoBnao5
 ly7D1DRcd5JpiDcnFRGMtwTpyf0Io.RbLw6wfpjVI9BPjpcD0Obdp7nmDArQYfA0L3NM8UEktWEn
 VRbn49jZ8Oc2sZCNf88nup4LpQCW00mEYlns.d__K10YRQ8hb.QGjNihBZsixFYKHta6vGO.vYsV
 Z7ZvPKU4BeTriZ_K79y6LLmexdfbNI2PbpZ4Lf3TnFhcdAuNN1wh77DSJOaqbG.6HdUj0EDzocO6
 UdPVImy4WILVA4CH45BQ6REqHIvfkEud.FT._PnSM5Ou6lv.BK2hk7h1ogliZH3E2yX0ieTvVOK7
 Bil4oO8j4fjSAe_sOG8P3ZK7lrehNBU.0AJmObPBaR9VuIpfoDbZTHttY4WCoqSaG.tOnXcTGej3
 pJ1NAVcpajgmiD93CgMUsY7zC..e6yN51NFVd86kyZ9aS9Yd8YcTc8GEsQBZIMH2slKvlZhm4XUI
 kwO9CAkKRyIIMjqEC3123HYYt0N2bpE8qj1BsuxnjHnOdw_UQ.LlWi6BLuitkLyobk6.SRBRW_ZC
 3abXS9BTwwCm1.NqR6iaiM7hhootuxaQnoBWPBJxtbjIh6RauX6eFyq9C0sQv3oiXZT_0cyN8CQq
 L42XGUgLigr8eMreB6OkYmXwpmZh5_uljPqAGFIAUugDk5RRgJGI4xEHHfLmSodObW9UuNUtumtz
 GGEEMCuZqBmKO81ahkDrPx1Rg6rS5Hh1kqgeD0ICWacbCPC3qKXqa5PEagC.hbXrPRzMVXnelKUQ
 lSK3S0aVEkNkxTl8_xJ0SqjO7Ej4L8KHqOp4Pg0UQzdwoH5oLd__CCA6ulBklCedpKSkvH1akFqe
 sE5MjL25cMpgjs2BySb.4q1hFYMBIz_lrkhEnqYQHtlfSEZzselUtYRgbUjSqhBphxboa2HbH4lU
 8QHcALq_hoPHmwGSIV6AC341iEoqWdne5.5_0oqa2IfXNApMTxKf7i6N5rwQhU.SLj3kqvNioII6
 HNgxx8CNkU32uPqzzOpTXQreDGd2h0s5ilai8c.fifv5dJQ0.V.ST0QnrbJR__BPaKq.uB_JCML2
 qH6TqcbGpE7D0ErvDI8NnfN36qbsNwLKBGlqD1PJt560j6AhE.Ihwzl0gXayjdYV2a_pf5yCpiz.
 X6ZKQ1cizPPjPVmRZFRLy7O.jK_ZR2Fm.Erz6Ww1I_assbFVDZAH74oKvs8arsEc5aKYUU85nmQI
 XU0taf1jtJ.ZCxMCeOLTS7Puqpukd2SRn8KxgNmH6NcTsOMGqaGLXuA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Wed, 26 Jun 2019 19:23:22 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp413.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7fc532bf6bcf33ac8b649a0abf15fbe8;
          Wed, 26 Jun 2019 19:23:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v4 20/23] LSM: security_secid_to_secctx in netlink netfilter
Date:   Wed, 26 Jun 2019 12:22:31 -0700
Message-Id: <20190626192234.11725-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626192234.11725-1-casey@schaufler-ca.com>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
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

