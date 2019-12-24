Return-Path: <SRS0=cgF/=2P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E814C2D0C3
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113DA206D7
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kLT80A7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfLYACh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:02:37 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:44113
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbfLYACh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 19:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577232156; bh=o9Qt544WeJ5/ctvUBjFkXndWhc2x1k4dB7+A3jIh7rY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kLT80A7VK1DqCwvqEkjDr6PeZh6C3nbmCjEFH7xfvLzXrb5WtBQFwBXGfRxGiVbC94hK2MfyqTqC1U0pEu0sMNAXRfu7TiPoBrMCubpppJc1SDF4/hTKYSzuGiebdeeGqmQPK1fXoVKVU+YPnPhweiYtaCPhLu9+1lFhoNinK5h2KnLgwSnO5nXhoU6TrTHoj1fKbN2hsu6HljPL1pOX5EUIg64NsrmXab5Smz3e0kDINVqW5V6D6jAyf1cOG4yvt4Dbkk5yPc8hJ73wPpPo7RUlRBmdRkZx7hikWtcM+Xit5zxluKBQtlIWTHijazbO4RS+Lsa3gE/orApEcd6fBw==
X-YMail-OSG: cw46zJcVM1nh62ay6FSe_.QabdTOjzUM4EZpTu6jgWK40xtuUEnU.4F2iqPCLwi
 Y7sJYQT9Fnpgr8aEemaECVaaKySn09i3lST7TmqEb2RvR1P78knI4KT20ulba_gpShLdEpdOujPN
 Ct.V4TJkKBg2tGSQ52aORKvhO1qs3rho2isU178ZUuQQ1e_5QewJ2ecRuh7JPIq0Ymc_LbmnWCRV
 muSUh6XXrfYvix1XvoR2yWdFwcq8niGo.ZsdzHCONranRsVbV1LffYnic1K6AsjeAn_g00gKgWJO
 R_B_qkRfbIaR0_zfTnlS_CiVHtrV0_JYx0_oOlaIyUBxjZiBD95pd_D93IDiOqrxJjYNwyUWgwyw
 rRkUDc_zkrmNmQAUMZAeFaxXwmjahUxi5jazajQVBdM4ydKveIefWQJTlgbTuqW9dmr1A9gdTUw9
 J_a4xOCzYCsD6C7M5_wBv3JrJlgePMPGsMriVj4ATu.i3o37ZDPSEMgP7xr6NneGKE36kfgxPa2J
 82NHWSwxAWSDs15a2O73764sBqp6_HKlw7uIpcY7pokVmPf6UVw396tMV2psCjFX9eLdY15Swx4N
 tr7GEHItHq9WJK7Pa9jlIzEXB5PBn5TmaqIseIkRcjXqMHAom0I4rmJrrTZ9vRsEbQu.n4Y7rpHP
 4_v4MnH06b6I5ty13QX3zH8ridkrJBNO8FqlkCz6OJvYO7IL08iketSV4D3_OMd8u28g9psXXA7O
 A5_aHBwH2q_BLi7ci3gP1YdIRCQ2jrR94OsKp6dFU3wodsaY_r4mVSjO1oMGQ6C4ufSfANJKK8o0
 NRaDqZD3w4Kn6q4RToChaSKV4sGdlGqk62IqIkK_iISnnZt2x0_2rPckur53plipW5k9ntfNTyUO
 _U6NbDxoTCaf4CupN9rQ5v5CsoVIjtdqSkXzplToqf8gan2IjQzo1n6iVW1uGE6r2dT6T6sZ7XzK
 kGHvCApqao4O8EnKlKwSlrjEiJX5x9IIAn7ane8pvbmpH.yGMMHaa3t.73jyza__uw1G.a2m059c
 kZQJdQOWXwVMPcmNE0RQeroNgOpIxjtemQEYKgyvPy49mBBQWU3JrVyHHp0FtDPV.NsjYpXOXYQz
 FIKeySMIEt.p5ESWwe1EwkPBcwFLj_TG1DpPjMfwsosTvvdqfS43tqnxkpi1kldg_WQHoB1.qHJm
 ONcke6LNXYQSs3AheDYIXJkmBrC90_VkL.56mPMg9vgY.lNbgo2xwdYphEoqFBo0V1ywYOu92E84
 jBkpjo1ymJmDm9Aca6TwNnxDA8NYfFN.ioERIUUnFADNioc3XjHf92bIAdVtkfs5XrMCPf9n3ws_
 tE5JZZSLU.vG58lMswgKtLxvlcsGYuvLgP3IYreBrMZkpuFcNN0gF0b2YlORrLJVuADBK.CYSq_5
 zkCyVDA9RQYnL20QBxNrc9R0NyubsWcXpCAqldFsvp9aUojWzG2lf774c7mABuc6k.1GJhQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Dec 2019 00:02:36 +0000
Received: by smtp424.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 561f5fd0706adaa1ec0af5b9f4fc4ad1;
          Wed, 25 Dec 2019 00:02:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v13 18/25] LSM: security_secid_to_secctx in netlink netfilter
Date:   Tue, 24 Dec 2019 15:59:32 -0800
Message-Id: <20191224235939.7483-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224235939.7483-1-casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
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
2.20.1

