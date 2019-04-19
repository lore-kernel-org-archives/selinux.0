Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0072C282E0
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E92821736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GCj30fSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfDSAsu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:50 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:43512 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727018AbfDSAsu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634928; bh=IQPOe1KDOXin7cd+cq1pf4+Z4nQsCBIs+n+ynYEv1w4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=GCj30fSXlsgwMz8TmBvTL8LEmIXILSRk2X+FOAj+vilJdgVKurquc74DjVoRBDvUhPB6I7fmcRSW0fZq+NhOLTHS985cg3z66DiqIdYfH86FuuSAcQvBtR9wCzYSD+JMETRdmGs0fnbkdxCiKCicj0fkHq7krniEZY8FLqZ5Ghsa49fGaW5/koEj9cDWgH578AX/I5TToMhG5A3WQSE0iiXw/pzf3Kv4WcVScmeeoqHr4la+gQYIo/IxfYWwfIkxEYs0kx0kiqNWeCtbPTWsplNKzxjuYA6e5mi3xW1Yf0xvok8jsqFVQi4wdWFGC29Di2HxFSCt1y4W88qHzM2PIg==
X-YMail-OSG: 5rLEYQQVM1mepwn5fu6N7lFG0dN1TLiyCqOfoYeRCcEhPefNNIX_XdIhWULk8qN
 lzdFrtP8xhATUOgtNlPFehjaiVkUphVYWDhHaPwwS5rU2l84O0eYVV0rIvxzZuBz3TN9C4XVSLhq
 7NpNOTVNEtS4H96qp1nU1rYhofp5WVT5_JKQVGdlKgdw5AxIy2Zz0ey1HJOxU4jNj2W.KB4wnRUQ
 tbO07SmH9sVBwcO1qseAjNO4roBnxgknlW5e_NKcp4SfYQf4J.xuFLgA9SlSA8NOTPkkk4a8JjC3
 v3b7J77SMl25Ti3mUVikoVN.GQdAtAJXS8QdV3gQ4Ze2sJA99PMcAcBwRNqoWx8P7n6ZNMkEhO.U
 JDEzEpiHCwM5WBb3zEWIldwj5ZkUcI6Ou.cIU7yFFISkPdJbT4NxrenDoaA7PZmzkx53SpzZgMpf
 IjnA3rXCvDUKlHWhVxNaTCfJKKaY4wjlX9A5ecCmxN_zgEvCey3_JNd.PoN_hFvHb8Bg87V0xhL2
 4fmU5Mj9gQcixqiDPLdo.bDFJhbdsEbK4NUbwASKtQhRWapXHMzQDz_Sbi4a3Zst_eoQSpXN9LXD
 QHmdPaZg7hsvqZDtQ2ueDpDGhkTXJqOleKVOntnMCmDesRfRa.okzAGYSnsd2BRvnRNaoJYGwbrf
 kQhwwRMYCp0_BuJMJXXAaECqNQJp5MO52MI4_K1KHx8w_GsXNWAnmBnszSMep3XJhTjTh24IsHua
 itF6aERs.l3QdIt3EVFqRI9jBIw7TL158AE0N.W.D_WqS3Zd_6xRojZ4up4IXdXRpHUu8iKOJ53u
 kulgYo._FWjwIh71J1bQnIqvywBvdw4AvKnM.EftnF.97R6YCNvZ6hQ3XTd5kq7lKKHlFo6oevzv
 uKBbH0JW0D_8OvIeLVMzWNJ3i9brho0yKsnDzT_ycQG2NvnUHBm6Kp8zN2_6BdreBztEtSOk6Zxk
 sgSusQdUmIEm134OBnIdIujMv4AaOJmrHBOUItow8A9KxFyMRu32mArKfUUT.SF8wrV6HcKlGwCf
 g2qsOkOlxZtaqMO3WnprE9twkE2xS6LrkqpHnSXBv7ssR.sYZoYN4eqYYzeDCmSWeOpYfV6oiUjX
 YuDQ0f8AAU38HRJg5RpvcZfbNTmMGkNkph7v7DSQ5Lb2UhhMLiqo19fePfDZANf1YAQEWQazn
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:48 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 33cedab91c06b09a1d8646eb41267569;
          Fri, 19 Apr 2019 00:48:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 62/90] netfilter: Fix memory leak introduced with lsm_context
Date:   Thu, 18 Apr 2019 17:45:49 -0700
Message-Id: <20190419004617.64627-63-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix a memory leak introduced by the scaffolding around
the introduction of lsm_context structures.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/nfnetlink_queue.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 4a3d4b52caef..7a095b9d0a10 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -305,14 +305,13 @@ static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
 	return -1;
 }
 
-static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
+static void nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsm_context *cp)
 {
 #if IS_ENABLED(CONFIG_NETWORK_SECMARK)
 	struct lsm_export le;
-	struct lsm_context lc = { .context = NULL, .len = 0, };
 
 	if (!skb || !sk_fullsock(skb->sk))
-		return 0;
+		return;
 
 	read_lock_bh(&skb->sk->sk_callback_lock);
 
@@ -322,14 +321,10 @@ static u32 nfqnl_get_sk_secctx(struct sk_buff *skb, char **secdata)
 		le.flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK;
 		le.selinux = skb->secmark;
 		le.smack = skb->secmark;
-		security_secid_to_secctx(&le, &lc);
-		*secdata = lc.context;
+		security_secid_to_secctx(&le, cp);
 	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
-	return lc.len;
-#else
-	return 0;
 #endif
 }
 
@@ -406,7 +401,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	enum ip_conntrack_info uninitialized_var(ctinfo);
 	struct nfnl_ct_hook *nfnl_ct;
 	bool csum_verify;
-	struct lsm_context lc = { .context = NULL, };
+	struct lsm_context lc;
 
 	size =    nlmsg_total_size(sizeof(struct nfgenmsg))
 		+ nla_total_size(sizeof(struct nfqnl_msg_packet_hdr))
@@ -472,7 +467,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	if ((queue->flags & NFQA_CFG_F_SECCTX) && entskb->sk) {
-		lc.len = nfqnl_get_sk_secctx(entskb, &lc.context);
+		nfqnl_get_sk_secctx(entskb, &lc);
 		if (lc.len)
 			size += nla_total_size(lc.len);
 	}
@@ -635,8 +630,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	}
 
 	nlh->nlmsg_len = skb->len;
-	if (lc.context)
-		security_release_secctx(&lc);
+	security_release_secctx(&lc);
 	return skb;
 
 nla_put_failure:
-- 
2.19.1

