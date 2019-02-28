Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F56CC10F06
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF9020851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PAG1H4wK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbfB1WUd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:33 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:44006
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732256AbfB1WUc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392430; bh=f8K6YGqPGEJWPQrpWKi0AaWdcZaQR+kZDh+aYC77/lU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PAG1H4wKoMG8Osa1g+zxlqUsFqNXI084BCXfD5A47sBae6z5o3WDHdIUIUHWzWaw/nvnnJ8CBrEBshW3z6qTSoHDFgtL4wHegauzYBl6uaUy61EvETNuAAGNe1OcIfhKPDCIgXAeTFjU2cgHc5onJf0vxkP3aFNLi4sGRUUBUHRZP6ppxLlDEVW5TlHO0FUZcfiTlWHOne9l3qVj1gg2VS++avUGnCKBDn1JQsEiGPNtjg03OxMZLwcB3btUAOMDWMtpKOZjDNETHGTrwGZM37VBR6UPxTlcRCUPF5hK4nj/h6zzmnSdIwMiPlUvB022KeRCbWsIa77x9hFFJ2jNzA==
X-YMail-OSG: NIHGviAVM1k8Ja7rtJtis2va7pFFTLxvIC9H0QuqFnBC8d25AFW72CElcjX..it
 272W5Xr.IkFiRb__eWl0IQUXQSqiASAXa4L3lYRmeHSVjrrRBpT3xnu4b7BwpOTDBBPxVspomASg
 _C4tyiMGefYhQXJkmdZF1MLBGaveLAzwd3kA8psCmUGHeth6RWerwB9C92rvvkWmTaS0Nv9enRm0
 CmNixM7opJ7aSrAigXNWM5Fb.nWlneQaH626e6PRi4NNYAF_CMmj6G7_Ze2qd2gadQjen8xmt7Ln
 eOjyyS4TH2xjgtyeA4VrmMoX8SKMsEYj2r1YJ3vipuZMPvyu.dvkeDlyIZLONgOK3wk_yphgTY9J
 zcYrmsicLCR5g6pV1YQfd0jzKerskdP68by9IXq6oauVTXfhrZOAR2r71jrRPN5jGA2Pak4pogNz
 jyKOb3yhn4qH8G_huIi9CshevhicZ6sn88IiL9nQxXERGrg.AMXXEGS17OXeTwDTeiQ9IGqixbGW
 QjogGB_CMNFJ45VqFT02Kua3WuBCAOqzEygGCdiJl4PKGtfGIMavzoBPclPgpGZa3.JFjZ1HohLY
 p6TLbkgLbHDX33QC2zVnP0Co6O9_2_Hwh3In2pHZC5VPP5WIJpjbCShIsxt.fknP5krRRJFw2Dja
 iLoXjH53Miu4HZbWZZKfd8bT0Ny9tu1sszVBx7dR0_YAFP9860elg0VzK1rVmtv9r1tbJoPP4OHL
 5WJu0QsPxxARhlZhRf3El6e9JIu06xXJTv5WY265a9qOhtOQOXWJCwu6Me8FtPyGJzmpSKxG36qz
 eJ.Gkd86ZyI67J.IVd_6jZFjFHG_fppakYgOn2vBhxul6Bo.tcYwqg9XNfoJ7p.UgGRGLOoa3w6s
 L.xcNGHMfiNTYgKnT0TY9G2htgOiHugDvsaTCwLhF7bBbcFBAa7mh41bJIWQVOV_lwGI9hhveeV2
 huP_.R2IDo3JXBwbrM8WWgCI1FX8rvkh08rkVTGvI._NhvpG0Om1uYsOuJr0L9nOW8D96lOt.8q7
 Ot4dnCqc80M3LBA.a3C8qQ6XfkyXgDPAZ6uThUJB_H03cUC9aF09IL0G6Q16mguohP1qyqh3JKWQ
 43IQT9RDtEEE4lSVcjCUDmTV0OPFug0NXl7yKXCnbKjrLvM7ZC9xQmwB4uw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:30 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d90148b291d74b44c78573c559ceeae0;
          Thu, 28 Feb 2019 22:20:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 68/97] netfilter: Fix memory leak introduced with lsm_context
Date:   Thu, 28 Feb 2019 14:19:04 -0800
Message-Id: <20190228221933.2551-69-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
2.17.0

