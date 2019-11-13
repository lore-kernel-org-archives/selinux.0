Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19523C432C3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333C5206EE
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="od30rqg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfKMSZO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:25:14 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:35179
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728262AbfKMSZO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 13:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573669513; bh=jx6SBqD3iFh7Ov9qmHnd1D9nd07iILpEnAa1txjocoA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=od30rqg3Sgkgee3ocWI4JmxOT0neRmkGtuihfAE1P5FJvL/07ZFE0JnEpbgwV5wZMcemErS6CEpHlRAGHYfVzcqOyB0FibGmPrSsuUvbYkAXO9V4XisDcElFfbZNkcN/+5OdxmtZNI0kg6CMZg1R+tocx47ejc1w/Gbu6F0h5f7/yhQbiNYpZQ9hQWB+cdSov1DSEbbUh4BnXcDc1RtvwlEG7g7mWVo8Orw2Zem6VNLThpCtLA/i84h63Q22i4FjmqXNWzE15eC/7rtata4FoKyK0WbfLn7zPBKdNlvNN7ULgUeI4I7o3PhTLQvrkt9ZWuL+n9BdF1dWphmlQe7Wvg==
X-YMail-OSG: K.HnA9EVM1n9VUzEOgzFHUa62dUwOGKrq2ObRHY5gZaj0jcuZWTHNoeK8DYQXUz
 MROnLqFJi5FgWI65EiAdOp.NbEU4bdOQz9Z3CSgyouO2n1oGA20JxqKbZ6Kr6mkLQ0_srz_uoppz
 SaEU.ezoFRyrw9Oj8920NCV5900LgBcwPj8lWWk8FLOsTFAsagOIHsFujbNcongdMhEXaQ4CXkJP
 nhJ3TMNJtkY58qDODdy0P5rjE_81u7Bt7UvD_b0BU9pT1bFgcPTuLYy1F6MA3eMgUad5IeXMWB4E
 DOLk4TDt6XTJim59dgUwMknIUb4SWA7h6l4kGFiqVSlh8WTdeFebcRHZ4gYQEI6xxchpT8ENEM7C
 CJD0fxK_JcHKNJ1F9F2q91W7yTeABo93FOId1TsC.JQBjapoXmMpjuCFeY72A5mO33DF40h2vlE.
 RiWVuj6mQKFTx23TRD6LIqYXPiYQ9awJARcoGaC4RCp4OrgncUnexKmBq_ZXbUa2G8A1NMr2iR6z
 LgRRV.6gO.svJOvUjliCZO4npePwg3i97F.h68phqD1kufSQLuihwgUPpzIwuN6TwTsDYbgW_p.Q
 NCKMPiyjD06mJTGZYFYYNJ41EsMY1AsmaVmuPgdEtXdHyywyOToRl8LO1LHd4YF_.X_HFP2yZsAt
 BqSZtoTj59f7jMkTHU0LrmsD22vmwP_URa8vdAPe3lqzUTqoH2icBTOgdI.DTrEWmT_3YGoBy5l0
 mN0I3zcB3ztLvRKYAeeqRqa49rJtNEV_Iquf1oGBtexhFbYb4mdxFVUUfy0CkWzwo_CGlqDyXSjQ
 notM9V1MQs4stxg_HxWT1fI1p1F9K5tNniq__ZFNgCM_DFA9nbiABofrBzspM5iF1cdlVMPya3pl
 OQt_oFEHJ3pmBDuuocGj97QCq2cJqM.Zn2c26qDMPcQ2UxS94DFVoPf1K92AvMl3IbjtlqfdHLA9
 IcapuDJCFy_.j1vMPg3fpmdy4i9KCKwyA.sDeql8_9xJ9BdWt56eDmYWwCvqUPvBHT1QXPNOeZ.J
 HabtfsieMIKHrGTL1BzZa_Wg6UbsA589nGtyExE1dmgEdmVQoY5DDa8LKn6UbC5XM2wXpfy7jioz
 YtVv1IRbWx2Iu799LaTllj4aCeChDknj9_5Wu7WrEa5nnku9Y75_K94xuWUxlm2YH9_jvnmX7EEI
 PDQWTJdCFxqNlaM__tAUwHA4Y3VmSVZBnw066mdfhpiI3n6f1.Ru6qT9cAQF4L9m7nvo6rB8Vg7u
 fz1vB8GflIogLedk0bhq7ixX8TZadaa7Ktss.E1aJE.SzwAnkJBv3f0AhHoeYWrl.XrArXBjSR7H
 fwKA1VlHn_cejRtTmRJkw7ZVY9Lel.phQaiGGg.WMF1WbAZQB_.hQTtkt3HEuw0PjAbaFHF56Ldg
 yc0VNAyWrAzkzz.KnYUF.QOkFHnYOFFaLzpiZ397p6BgB2PkpA0JunpzQ7W8j8EPD7hUdcg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 18:25:13 +0000
Received: by smtp406.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ff0a2ef488dab9126fe07248878e2ba7;
          Wed, 13 Nov 2019 18:25:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v11 18/25] LSM: security_secid_to_secctx in netlink netfilter
Date:   Wed, 13 Nov 2019 10:24:59 -0800
Message-Id: <20191113182506.2580-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113182506.2580-1-casey@schaufler-ca.com>
References: <20191113182506.2580-1-casey@schaufler-ca.com>
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

