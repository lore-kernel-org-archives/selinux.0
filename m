Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65E8C7618F
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA1921994
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cJVLz08G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfGZXj5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:39:57 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:39204
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727958AbfGZXj4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184395; bh=NX1Wm9mZ2rrFAh4r01JvGuFtS1Wfm+5+bHPs+vG06x4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=cJVLz08GknoUVo6DfoOR9hzwK37JEPplx1qgM4yLG3HL9RihwCk4NGFWbGY9jYEfq7kD66Xn7qGFfYrCet2Zy0xqukpIC8v+LWYAepZ/A1B8qwed0vyvhiVaNEkG4Oj8WVayCaVCeukfueBbcl3dsteoWVuiRemPVzIE17vcsaetLFzC8TE/XlmrTWFqdX7NJFM+Fd1my2/St/qS864nAl1qvvom+KiZTqBUkLQ3Xiw57/diA8C+wqWdcirsxT31ZFdgC/TIUwmSi2Ivui8TcR4bVFmxtsbJBAgmDWyMK9hZZZaspxIDcvXgKOa0CUCBH0C+VTVPxbglIez7Ka+xDg==
X-YMail-OSG: b5GsMeAVM1kH1WCP8BGI7sA_x.Qy_zbOVCEQdDgzEI2rfDp3TCBNbCzurZUEcyw
 mqNEVhjaRyEQ8EpGqiKDMRz1085jk0wxShZoFVC9M1lTL7LdMt9ltIb4F6ODZDBx5yDwO4nDdtCZ
 847sDFCLezcGlcfR1OFuCU37HKsmeIPdv_qtEc9CnZtwn.wNYFsYGv..OWRbwCFYVuOiDuS1XRJj
 6XqmPc.OUHXfd5W1zAyFI_yPWGKDfHHr8WQz0RfjJ_Odx0BzNNqHLCh_HmmXIpkE5IDZenDR2hYF
 wY3HJXMBriOzIAnGl7GID9F.c636bA_lyVM7A4Vym0zFZnGhTIEpmrhi1xRWnnoQUxXuRxB8K1.z
 oQTInQEhMgt61rPMJXKRlmUXC6X.VMAxUGwcW4W9k5m4S2BIIh1pMIWJSMQ4iJU9UbBkh18CT4Y0
 o1f1HQCgUV.bBFP1UzOP44ipzCU7ti6iQ4nK28RuHhgOKRagOFXADX1kq12F4PmljhMfzEbvhjLY
 D8I.0UZyxHOZOvXd.CggHodYIfnwMKZmBNZfJOOHV9SEooBJHUyAVYZ2c0ziKOjepbEazNjDl8YQ
 Ef6UCdRp6m6s5qjz4RwSp8TqJj5RXnhV3pD9ulewwGF9E5I90G3B3eieCALP2Fxlj1IQI.krbguh
 I.DUQS5zJ8EvD7V4UlO1eH.zYWu94JRBs3nbasS17G4Tov5URBxNIlNG61mYueAWSTUnOGb55jRx
 j.n0oa7e8rxd00b7t2rNF84MMivZWr2sgARtMIN9cGm..et3LxDoIRADw.tMevMZ9PIFtSXXo7d3
 .WeD9MMGfzjtsO_XESo6jWnYCh0QQMqXerBRy4WKbWOW3yYZ2A14V5ztMjLL2el3rSbzBuTEP0F1
 Emb2Gr4.94NTI27ROri5sWWwMF3DIoqMhVvS0ZZkgKi.AUB6r3b8Xr1qil1ryuEYtdUShGch8Cih
 8JgelzKYxmZop1gGICjrz3HYr.qZJVJO7mcVEKZ5YVLChzVxRVLgArJ5EVry9r9JQgJ0m0VFeyiZ
 NLUTgsxPvObTI2V5gM86QdYD8FmL5N4_wNb5QcAQ.YQjz.8MzG607kdlJpafnMtM_A3Ijlk9ecKr
 Qm1xjrVuFjfRtbhg9UikK8QAc5L2SlGzJp.Ba9KStQVgSiZQ0S6h9XL3cqsSs9y.feMAjlnqw35m
 1wvQWLMpIyuo8ZbpYkyhDh53adkH3qCapS4TUx.SBeoos7ZMZYY50wfgMY19PzbUu3SiwXTx1KiU
 Axt63f4MQ6ohLID0v8IS8lYGSDYHdWpUnHtlQM7OX283YsMK8irq6Sw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Fri, 26 Jul 2019 23:39:55 +0000
Received: by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 223f61bb2347890e9e9f353c8afb834f;
          Fri, 26 Jul 2019 23:39:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 19/27] LSM: security_secid_to_secctx in netlink netfilter
Date:   Fri, 26 Jul 2019 16:39:15 -0700
Message-Id: <20190726233923.2570-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726233923.2570-1-casey@schaufler-ca.com>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
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

