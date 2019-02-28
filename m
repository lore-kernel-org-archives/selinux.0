Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A254FC10F0A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB692133D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Lot8j9v4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfB1WTw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:52 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:43362
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729353AbfB1WTv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392390; bh=JCuVFGARXGdMuwyrW5Udrkka/zma4Zt7984sa9ut/Ko=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Lot8j9v40AOYW/tCNfquT4KSlxdDzf9LVWf9oJxTX8xjCRI44rXV83psPBsa9oSpj4qObqKdbXjTjFROQqbktVfvAhPPfk/gH7lY3NxR3Hr0gjI9UFTvO3IQXw63fQaqGVYmAQvdf5rlbTDMjTDVuwsYMGPGWpxTa7mO6PdxbyKyJiw6B2xPfI7NJzI+ULeO7+kZV/GaypmV7u9jUGO2uf8COmI2foyoHNfcna/J/MhNnBeelBmF2mKiff3bedby7EK/P2pOD7hULljyGkEeH7FsUaUW3wuAVXPqyrmWXB0uE5vbssPaZcVw539zUH1WO2I/4kHBvHrd0Ih8/2vKrA==
X-YMail-OSG: RKdEtlUVM1m_KpuF6RdsFkv6fba2AOHgQlF8DsVSQeoHjLwdAMmWnMITfmH6o30
 N5wrZUtAXXIwxmHKF8X.ZB.x2c5nhkpjCKkY79UWWzsR1az4kj_JLYjb20t24_sQQdcV0kr5WV19
 lZXqVBuZFfJp2ggi3qtY7QxqG7HLaCMfAtsTCiSb4D.jG6REldXwSQeDGpU8Pan3EZS6QoYdMcWM
 AhXF0.h76fr_rXs7ccZpbuOMjn_VHHz8rPCdvg_VZzsN1LVY7AYx4K9WArhnVbTTatLTikfPO5ef
 _SNTPtW4MuIf34LLWZMHxADdoyqCJV.ezFELshPrneawy9V324L6Lld_5LM0no__vVW5_NYYxxaR
 0xcAEAmgF2ypYJ9_QEWjAIQaN3UXuU0FJsYeFW0sfOickEpw7a4t0bLVAQq6x9xfHO3Z3TpvNxMY
 jk4MZxjqKhylAJ148.96IiiAQqaTL7NWiVc65NvNhfPsUMaafo8Fco9DisTDjcWdmKqgapwQJlON
 pWdKd_v_ofqc_wrTnZ9d.OHJ89Aipwoabee.d0DtxtVEZlU5P.LCNJiJF1xZ.xl_Vlu2KrcksrMk
 vMXQ87VNcZYhhxubKfxqKeNQsPDMMriNxUM.vKodp04iq3ijb2091eqNgKCOmNCMbXh3y6_kBb0F
 _Y_4VTLIUkVzAkdF4MXeK3J3l8COWnXfvZNUuDf.S_QzXrsm_lSx8JhoTxS4yU.Cd.H9ATeiOZND
 SsNO.dgBbEJUTa7duWO0lL6_9638fFjP_bETHLEptCMS5RewbehdttBOrntDM_mjgrqrzkonHsE2
 ynKrBv7PgHcV26.ms3UkaJ5xQnAo5YNw2iyFMQvqA3XRvX.wWbP3xLcFFJKJABKi._VGq0Iew_rC
 bHRe23NK6Ff8msNrtIrAtAASHaPfzndcPaB7jT0DQ49L4f9U8BnNIjOsH52G5fd_zDgR_Nw0Z9DH
 iGkZg0ic9GhVXKk_UIkWzFGRdjHFw2DKhCfeHTv5FcqqsZk7jtqhojWftjpmlsBASDHl2ej8fnVC
 Mlaib3apuQP4GSdE2Dx4MIVZpxo4ElusEotsV_NZT23096qIuO8E4cfu3smzivXXq0HX6lGXDS73
 jD8snhq9G7afzhtSbUo2zakFyVwCchkwYKJCd1Fim3Xrw
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:50 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0da9962b364e649f4905df2b440bd211;
          Thu, 28 Feb 2019 22:19:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 10/97] LSM: Use lsm_export in the sk_getsecid hooks
Date:   Thu, 28 Feb 2019 14:18:06 -0800
Message-Id: <20190228221933.2551-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the cred_getsecid hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_sk_classify_flow()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h | 4 ++--
 security/security.c       | 5 ++++-
 security/selinux/hooks.c  | 6 +++---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index f798a947bf8d..44597189fea4 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -877,7 +877,7 @@
  * @sk_clone_security:
  *	Clone/copy security structure.
  * @sk_getsecid:
- *	Retrieve the LSM-specific secid for the sock to enable caching
+ *	Retrieve the LSM exported data for the sock to enable caching
  *	of network authorizations.
  * @sock_graft:
  *	Sets the socket's isec sid to the sock's sid.
@@ -1696,7 +1696,7 @@ union security_list_options {
 	int (*sk_alloc_security)(struct sock *sk, int family, gfp_t priority);
 	void (*sk_free_security)(struct sock *sk);
 	void (*sk_clone_security)(const struct sock *sk, struct sock *newsk);
-	void (*sk_getsecid)(struct sock *sk, u32 *secid);
+	void (*sk_getsecid)(struct sock *sk, struct lsm_export *l);
 	void (*sock_graft)(struct sock *sk, struct socket *parent);
 	int (*inet_conn_request)(struct sock *sk, struct sk_buff *skb,
 					struct request_sock *req);
diff --git a/security/security.c b/security/security.c
index f6ee25ebfa3c..909b6b8d1a50 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2152,7 +2152,10 @@ EXPORT_SYMBOL(security_sk_clone);
 
 void security_sk_classify_flow(struct sock *sk, struct flowi *fl)
 {
-	call_void_hook(sk_getsecid, sk, &fl->flowi_secid);
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+
+	call_void_hook(sk_getsecid, sk, &data);
+	lsm_export_secid(&data, &fl->flowi_secid);
 }
 EXPORT_SYMBOL(security_sk_classify_flow);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 104b2315d36d..6f61a894f7c5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4893,14 +4893,14 @@ static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 	selinux_netlbl_sk_security_reset(newsksec);
 }
 
-static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
+static void selinux_sk_getsecid(struct sock *sk, struct lsm_export *l)
 {
 	if (!sk)
-		*secid = SECINITSID_ANY_SOCKET;
+		selinux_export_secid(l, SECINITSID_ANY_SOCKET);
 	else {
 		struct sk_security_struct *sksec = selinux_sock(sk);
 
-		*secid = sksec->sid;
+		selinux_export_secid(l, sksec->sid);
 	}
 }
 
-- 
2.17.0

