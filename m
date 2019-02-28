Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FAEC10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003162184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lh+QsAyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfB1WTr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:47 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:44476
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729293AbfB1WTr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392386; bh=kdtislM8E8h74/k7iD5aHOq6AYv+fS3/ejHJ7LD5ioI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=lh+QsAyxCQq105gQQotAtOAEFGdBw6aK1Dxq/xpp9X2G65T5M0YEBcpCoA89vDMlhZ0zEQdqDj8lkfViTBU0MUac1AeC6/OhrLW62JcaYKSIlrHjxlZRHlqvqDnURRh5oiFWQi/73qjf5KL9jw/eInalDCb9iFRWhIVWLGTqOhNsH/ZOqDCK5TfmoGdzJ7tOZLY7FiZXh/mcHuVPU6sggo/ULC64yX4HljIkyvnuebqGpAFQG8hKUGHo0G24cWvE6hdAuwkN8sDMU77QYGWo5MSi4kngSQ21zjXcItvj4WxL9mVTUZpwCpGACQRw1SgVDb6WyhLJYOS8NH7uc81NXA==
X-YMail-OSG: zAfK7zwVM1np_7128qPpP6wQGyulkb5n_7K6Kc6rZfk8pEAjW9hKS_Ubka5Eqou
 Fei1Ga9RyW5djwhjm4azyTFO3hS2v.Hm9g.261N7GsGYCyCEUhhlIiX948VqHTnXiAwROMNBUzqv
 S30duzrAio93qWv.FbzpO60rSxyQUb0m_i4GnySW3ztqbUwRaNtOGLCg89g.PVUYp8_WwNGoZz9C
 zTM9j0E6UtmGGHVKXr.RywehFDkWk8i5RaTnUTQZaBPSBIstO0RZbbnNleVnOvrKRw_Uz82rXyiE
 M3kFsrSI6pWMzyHRpS0PTNw0VV_ufaeIlNe30GwNzJ2JD7qhttKh6BB5lENFGXeZ3gGIysMHlT9q
 Q584eq2X0NW8M6.mgwbg0As7Jr5mRZCMTo065hV.GFxXH_kAp8GB.410yXqYt7WqrQ2T_8EMiDT.
 LjNXRN7BdJpQYIrXxXaFMxzknnyZl5UE6KMzNAQ27JOg0c_3DIa4XG7sFH_QH6GJnX0q1.ZV7kY0
 hNxOgZz1AZhHWcXxE_UnCLrCLFmpx75dzZ3CeHSUNL1Hagr_pyWg1mDQwkp.lxadJDGKqlA0cw15
 FOKo3kL_aQ3aX8WB.SGzTmwmSvLNP2EfIhsDGryr8d5SGBCWihPy_WJ_Et7lUKo0idF35rwUCmlS
 MSGvuVW6ougtnbreUPtfBj83.G_96A06LFn4PRb60uGbV2zsvWifci1vGs8nonkZ4QMEQE43pvB3
 qE.hw9gdqzVQI0YwrEZAArXqoKVUtvnCnM9SNds5XEez6Cds6B82gRsT8UG0WIn9TXOCcXc.polz
 ibxi8vK7QpES8XnrI37rvKrL2SbqPmhhxRrfW0v971NO6BqYxkKq1Dl3fqHa5gRSHLeAav9xopie
 oIN6avkljfrruwoHhaRKqhQdlCSM8hMm5m2ArEjaWXbfWjkO5ZllGupa1jg16htJAQdyTMFCrno7
 IENywvAzeUpmS_JnzP0EKNTrw8QdVYSiukOmPKd7Z2CKroBQvr27QK7ik_EaB_LFpeHBF9Bqs8oh
 rbHFl6uB4Si6mTChF8CY6RLUW.UeIMyUXj822E717zonNEg0UPcbswlp_1gqZU_1os9K9693P1ul
 lVU1SG41nzLnV8e43z3FcbTSoybv448XPiHUJxg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:46 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eca90f2e660dab57d5d3726b0a8f0373;
          Thu, 28 Feb 2019 22:19:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 04/97] SCAFFOLD: Move sock_graft out of sock.h
Date:   Thu, 28 Feb 2019 14:18:00 -0800
Message-Id: <20190228221933.2551-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Move sock_graft out of sock.h so that sock.h doesn't need security.h.
This makes Casey's life easier as lots less recompiles after a change
to security.h. DO NOT TAKE THIS PATCH!

Signed-off-by: Casey Schaufler <caey@schaufler-ca.com>
---
 include/net/sock.h | 14 ++------------
 net/socket.c       | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 2b229f7be8eb..2beeda35e39f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -51,7 +51,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>	/* struct sk_buff */
 #include <linux/mm.h>
-#include <linux/security.h>
+//CBS #include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/page_counter.h>
@@ -1800,17 +1800,7 @@ static inline void sock_orphan(struct sock *sk)
 	write_unlock_bh(&sk->sk_callback_lock);
 }
 
-static inline void sock_graft(struct sock *sk, struct socket *parent)
-{
-	WARN_ON(parent->sk);
-	write_lock_bh(&sk->sk_callback_lock);
-	rcu_assign_pointer(sk->sk_wq, parent->wq);
-	parent->sk = sk;
-	sk_set_socket(sk, parent);
-	sk->sk_uid = SOCK_INODE(parent)->i_uid;
-	security_sock_graft(sk, parent);
-	write_unlock_bh(&sk->sk_callback_lock);
-}
+void sock_graft(struct sock *sk, struct socket *parent);
 
 kuid_t sock_i_uid(struct sock *sk);
 unsigned long sock_i_ino(struct sock *sk);
diff --git a/net/socket.c b/net/socket.c
index e89884e2197b..d5da935302a7 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3425,3 +3425,20 @@ u32 kernel_sock_ip_overhead(struct sock *sk)
 	}
 }
 EXPORT_SYMBOL(kernel_sock_ip_overhead);
+
+//CBS - HACK TO SPEED COMPILES
+
+void sock_graft(struct sock *sk, struct socket *parent)
+{
+	WARN_ON(parent->sk);
+	write_lock_bh(&sk->sk_callback_lock);
+	rcu_assign_pointer(sk->sk_wq, parent->wq);
+	parent->sk = sk;
+	sk_set_socket(sk, parent);
+	sk->sk_uid = SOCK_INODE(parent)->i_uid;
+	security_sock_graft(sk, parent);
+	write_unlock_bh(&sk->sk_callback_lock);
+}
+EXPORT_SYMBOL(sock_graft);
+
+//CBS - HACK TO SPEED COMPILES
-- 
2.17.0

