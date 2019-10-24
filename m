Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AC8CA9EAF
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8365F21A4C
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jySwjNKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfJXUyC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:54:02 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:33269
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728676AbfJXUyC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950440; bh=NX1Wm9mZ2rrFAh4r01JvGuFtS1Wfm+5+bHPs+vG06x4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=jySwjNKC2LtrqhznTjC+nQ2xeMJGIS1mQGoUwsa5Zj3GY3rQbSF4CA4ttci0X0DRiTCIF5E5DaoCJoiTIv9Xz/vfNIDIYQj8IptW3Juy0HBxBORBlkH0eTmgkA+8hlZZKUTp4EsdAtL816DQZnQ5hmV3t3zuOKKvYc5cPQ50Lps+ePvkmOSlOE9mBg79Hnd6fn87pAIA9ezi7d177kjKc5XY48nuIdNF31j1vdCgZ8oyhvSv5/kg6G/AnlHazluQTn4d5Hdt8rKALySxVQDCKfcG9LJrQRM2xzB4QrcYlOcYFkHAWHAAr4rDn7K/jFZ/LCZ1zRvoaX4kExVc2ZAk7A==
X-YMail-OSG: 9V94gH4VM1kCz4DXIHG7ZC7d.UKhY02jn56TpZBPs0BugAzADVYDbiETQUZTXPS
 DG36jDVZCBGBvS2XJD1PLPjWu4vL0H8Rp0BEuou_KIy.SL6CPuQWhNcPBym0rPX8LoI8PCJP7CDH
 WHyFmfSVsw0J1.Unq742ZPEbyfKzc0J...i3Qy6KNCzARo3phfySPCN86nM3LtabeE03PD5Bk_l1
 tCDxXDNyMbi3_ufWftisLb_EACmrDPRkhSscjqGFXbtQmS3b2pks14pgFoJh77qcNdF73kBub4mU
 lOvWYwFcD0yimjDWajxiWokutBl5RA1CjYea_NxVs8jiFejlvZ5LdsyuJTdtM7KU4d5k4Va1bHtD
 SbaXZNhPhpxf4XmHmHG7BwB4ydOSTfi1SBZKEM.J.B_Np2plI5sMueyPD6h60BX7lrNFlze._Rxx
 grDX0Kg7FSyVY6I21YGfGaePGJNs249vjyUqHhK1VLsSs96YvYBFSpPNVCXXPR5q9KPJ9K7bGwgJ
 rwxslv4AFIBOWUM1O7JN2D_2kwpGSm_97RDos2LJk0eScWGo4s3Ok9ouf0ok3UT8KBSnk9mUICkK
 bz3qHQ17IMdRzb5kAEI._DRGt8mUl41m9jdtUP7BxKtrjnogWcDD.5BaFi1JzJa1UAF0W7krPtEW
 GaK5SLwIxObf5UB.dv850hLjTRNFzhr5qSDrOrjzIZaqT_LANg6FbRIMgDVuT3IsP4sqx2CmggGi
 vkXt2AakiDGzsiQo45c41qrPuGKsHG5gMv1yaJSK.jUuyvIkyKjwLKZu.GwmR868AuIVF2Xhy34j
 8xEo8CY0blVdWtKXrCG.dVT7z_oEL_Wdb3zteC0kOnkcpmbDoFFH3T7iaDfyKfwG2niECre33JEp
 xYyTO4uSxNjDMdvE3iU2J3C.pH3BpNTumkdVTAmrjKLNLM9XIdZG8xQYtPBViaVEiU5qSIAvegtp
 Hd4Lm0WUXRjNVkTDe5VDvljq9LLHovxTjfmpQWb9VxpGYpVx03vul_UrRmLyiUH.gnzOAqm9nLbC
 R8DFibh7iPrtIuJh2.ee0x25ghzpxISgv3eB1T41Thkda8DNrprtVBhrJ3_Atq0sajuOH3ewTycB
 QtZMoxbppu3X2I2tdHh5xxn2vdGFKag60neqErHHGWwbHnv7WPARZipOXzHNfRq.hY2yw.AkTq4s
 aJ9yt46Sx5g8PCP7iaa2BFlRxV.saCwIfrRzYJwLNqu0iCwqT0oOxpBCu7u_YT9WOux1pvLcNj5g
 gW_yw5Jrx_Fjt.qTMGylhEm49peJ68505W5QUzdNAhce6bvx8Gi_mWlHl7Yhg_p5JvbIBAS9hqWi
 0_Xy6aKRyVp7uJdJIM_YJpKk7w5CcwV0MqRrfkz9nUFLZ8bmg.i0cV3P9KhHPiwzRdTqvcmWWycf
 VKZi6i8EFXI.CYEZDQnqElqE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Oct 2019 20:54:00 +0000
Received: by smtp428.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 40856e22461a71521149fbac47a9a44a;
          Thu, 24 Oct 2019 20:53:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 18/25] LSM: security_secid_to_secctx in netlink netfilter
Date:   Thu, 24 Oct 2019 13:52:21 -0700
Message-Id: <20191024205228.6922-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
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

