Return-Path: <SRS0=dBUy=VA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC84C5B578
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A709E21882
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="biwURfd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfGCV03 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:26:29 -0400
Received: from sonic310-22.consmr.mail.bf2.yahoo.com ([74.6.135.196]:45519
        "EHLO sonic310-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727326AbfGCV03 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jul 2019 17:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562189187; bh=NX1Wm9mZ2rrFAh4r01JvGuFtS1Wfm+5+bHPs+vG06x4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=biwURfd6mfmUJsNkFW3kUJ/ZU+Mx1yzp9m6pLKFrSpG1npzzifTXbsk+915Kxd4LTSfW6+8UMrzylQ8zs3/qlrELvcStVhS4hMraPOFJYgpVUk9gMniPoUmBjI+nzk+UGfQ87J7hKIjbUbTpORUgN3V0YhZ9iVi656taUhbyczqftDW/D1lz+Ld/vfXBnfjody+iCQ1nE0Y4l0hneOx7Dv715p7YpAZZFSDAGtU7sa0Bjoa3nqBciGmR+kdVEKn6PHGw2xbeR0QSUszS4ZUXriJbPKtSfesLipSN8p08MfKOKogRqNysOot2k3XIwZpYt1FOZnCA7djSsaaSHA9xuw==
X-YMail-OSG: i8MHiH4VM1luroodjbdEj4illAUt.0UzN3BSVV1XTQulMT_UntHseMdCX1iT.dD
 YrstDXklHNS41XPwQBsbjqTr4XEwKa0ToCkRyDVzYzyHEwFznfzJy0sgZE8tghy6uYLwZ2hPmCby
 mq6SwKbp1q5CGh3KQNB65wXJw1o2HVy9K5fV3xmseVSxVyeBqNdF.jLdFYJ_wbzrBDX2Y2vfg.X0
 cw.5_84lGB5tjCKldagJ6O.RKX.zw7gMMbjW0hppAyDU1L7FENJxH4.36Rqbo_hMnwbRjHYBnsTZ
 JqAMMHQd00QYBXt3AddOFDTMntSALn2meZyDH28pKhZt2pv83ixWkXroYH60WDZYXUJed9LYsC7y
 1BBklBcQoTCJ_ZJIbGHq0hOS4ZHnmLavxxOoCmQVsZsJnKW85Udsm9YvWUmHiBSStcpEIJ_8Kdwd
 k7Jyc8Q3PbW37uhtJUKKAJ5n94.xdmtiY42bAd5cnauGkgx.L9X2Aui4BAVof_n4Hh50NvFjVxw4
 xzaTMRWXrnIbqGdyEOK3htuU.6Oz3J23ym1htScrvous_LevwTV1wSv4ot3O2pNv5S747Hz8mRCH
 uyoIdOjPIam1E6JzhWg3IlbsyCab34w3OPxTeDRpsle6nIoIjj6KhCQWtE6zDLP94cR4y7HqT8AK
 sOItmP1Y19eK2LXDPLuV2tNK_Yz.13YtTagAns.5J0NPp0hYc9RmOehM7zJql3HJOUoS7zpjQa6f
 ofYGaTWD4n4KYmiCoz2DvIW3PvL56f5ErdF_0vFylnKgCS80eGJDENWeB5LMkG.SwcMb.agzZdGY
 zY_WJ2WCQQ6859Hms1ipDI7gmlHH1qaQt0tp4MSWgC3jAqSroXX65dOnc6OqGAqwTCz8hNNwZxD4
 m7Mfgq0M2cZ6TttXRbYE8_yDmhp9.X9O2OEnniHBW7keEUwJWJdinL5oyO7RWLmRay4BU0QC6Vx7
 BzUEY5ZwAu0xYsalbOV4pHv1EO51evFUXxY0NWWgdGsyD9eNCJcgRYp4cIPbMO9B.ROTZubfqYwT
 2sSGzQdxDS9sS1cK.u6OPh09xDx2LBc7gVAmkWxuLftIipTE.GNJ6Vd3Xqb30ussrZDKdr3BHIKx
 M0IFcK.5r16L7m.yLRGGBlDWvrHQZvc2Q_dosXfQ.ffZGYYjvKJumefqDNXY3Vi8kNvpk_HSUQnO
 Kls_Jto.zMtW4ojdGtJVhUTz1NSWLMpQcz9Fe67IPq61X3v6jI0xjFDDqtcLxXjo1tI0x7n5Qnd5
 sslkhORiUhRaf8jWdd2jrCYJJ1vMizBBONNCW1ckBBHKY47ZGZscZ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 3 Jul 2019 21:26:27 +0000
Received: by smtp421.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dcee8b60478c08e91221837756b9c2c8;
          Wed, 03 Jul 2019 21:26:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v5 20/23] LSM: security_secid_to_secctx in netlink netfilter
Date:   Wed,  3 Jul 2019 14:25:35 -0700
Message-Id: <20190703212538.7383-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703212538.7383-1-casey@schaufler-ca.com>
References: <20190703212538.7383-1-casey@schaufler-ca.com>
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

