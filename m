Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C571AC432C3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F3C206CB
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="e1PPqcHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfKMR7L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:59:11 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:35319
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728239AbfKMR7L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 12:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573667949; bh=jx6SBqD3iFh7Ov9qmHnd1D9nd07iILpEnAa1txjocoA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=e1PPqcHz00xlj5SqgTv3D6woMzKuh7iCObT4JI2nQ0lKjIL6EYS34qzTdQ6P1i/sxyvbNXivufPDekODqelpxDhXlKh8BKOwaXBik3Y4m6og5Wtr1U/ecrgYQ8aE0y1Q/6iSsRYdye1NBbOddDCQJ7vM96kzI0uVmu7HuPPvQe0/4PxT+Wt+MRtaGCwYtQw+4TqJTQxd0ScBW3oa7i10KfATxp5mzGgKIA4+YbfQCAm/jzl60o92m8ox/zyQXxH/uVEimtzOJQ2QWw1rsZkdC7M6+z/1qdh7fAO4IQq5T9eP+X89K3W+mK3Tx6GR/QFOW+dDzeVMsvC3ouEff6aQ/w==
X-YMail-OSG: 5Z9oZXQVM1lflSU.FqnorD9CAZwg4ZcO9HlLo6.FI0PvZyTcV_5uP.Ox.3SH3gV
 piRacqhd.gU_QcjoxA1lgNqS1SeJ6gI3OOrkB81h9ZQu9x3irixHHPH5jhnsT4JGQuYQ3bymLdgm
 jwJGT5KmyaAqMqMX9.VfA.YqsREhNgxpHtoFWtrwrCj0Wf7lbQi3FME3sFr3VHlKgF4gJXAN74gU
 LJjEOBRUeFoap5xxFMGfY4oVnLBazUDHqh7dZCSNPHVAS1jUCb6L869.B87p_qva1g9do806j1zm
 Eej7sKBwHwhXzZsNhjrJyEB29E7trgp7lCDaOpMza1eSothd8cdOjntz6DhMdNY61HIKPEKIT08O
 2FKOLG7SbyKJKF_jiyfLnGpoXMg2i.1rIrkut5oaRXFHLZbckpB5g47_ADWH9.8gHDlrAeGyMK.f
 5V4_rnbYq.4L2xpMRdxmlyf69MBY1GQNJ1.fz1wjtbbdFPQC3kENmnHJTfjeBRXqiaw8sUmkpxUR
 hzP8MzwmWp9ujHOkLuHlCAuthVdPTBY9bg7W7isXasixsw2SktWQGN6Aeb1FkWJE8.mzChBf.927
 LQnlhK71fcWgm4C1GoYHNsteSUHH0AaJZs7mhAtRym.Eey.oVg.fcp01DT8Z.nj8uX1CF1P2vSxQ
 PVoqU3AET3U0IdUywk.eQuVqBfQa_F0N5l8LF2l8opCEd1qSr0iQJdVwuddVBgtcfpqEkHPidovO
 oChw5lj3kg5aSXQMoAFs3_lXD8o.7Eeqwni4gXxrxouwetu0Yn6uO_58Feyo1Oc1lq_PGBSqcdes
 k8wkeyY_CrNjeIA44neGn9cntwzCMvIuRsthX9Dg54.1iRY4PDCivTS3t7.s09KHSAyHbHKbTXpE
 N.wONPr6TTwTPGChniGkOQd633jX_yrteW4viUW5KhXiBtPhK1jKZRMT_gAvXVLG0X38OXNl9Bs5
 TULKKKRHc26Q29jiPjqtu1TWn6yDk2BdLyJsxGZp1mm6a3gMf4USAca6Wc0v2xirArxVQcHPJVHK
 mq3uVNa.RgSxwA1zOCiqAze4RWs_sKZrms7qVC8WVZ6R4.UNV1DRLZb7DIAQfdPib5E8uK_NsZ6f
 RWtdsh4Q2tIPsrC6YGkdi2Gt8i1U5QB5Q.WjIZ.jhGC9cmQ_8Z_6Lf8PkPlFGYwRhtC8VoUX.eJ1
 Wt2vLg7hhWsSPA1wHBg760q3DtYGZGCIyOxMWpy8rq7rTe.pkA0Zx23u6yNQmzd.8UodhcvomPfK
 TbgLR45drx3pS.B7w5Nql5FZQun2RaDUD8Azik4FXY2xax1l72UywR7OHYfI5FKW1gwGKwjjT4k9
 BVqvYqumgwMyTCDzr7BddNJDRvmiSnQR0NLEpHRiGBlyvreqZK6yIRhJJnrRM4jeUEcpFIn.g_dN
 hl7.zsaDggZ.aXzJ1.VU3V8Ei5E3eyL_Gqp0j5kybTbIHQIvCOxYyFSe22ZzUpkwlAcjGBVREz11
 sFQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 17:59:09 +0000
Received: by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID fec4cba33610c9e3531f5c622293ec8a;
          Wed, 13 Nov 2019 17:59:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v11 18/25] LSM: security_secid_to_secctx in netlink netfilter
Date:   Wed, 13 Nov 2019 09:57:14 -0800
Message-Id: <20191113175721.2317-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113175721.2317-1-casey@schaufler-ca.com>
References: <20191113175721.2317-1-casey@schaufler-ca.com>
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

