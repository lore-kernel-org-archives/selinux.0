Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B56C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90222794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pSLViKX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfFBQxR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:53:17 -0400
Received: from sonic305-8.consmr.mail.bf2.yahoo.com ([74.6.133.47]:41300 "EHLO
        sonic305-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727003AbfFBQxQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494395; bh=zfBzq44MmcEq1Uo3O/oH4Lkcr97+L8XoyMvRBXLr+Uw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=pSLViKX9XwzPWHDeQbs1mCWAQouOX0d5VIV6cGG7N0nfI6Kh/nAkxbkdaYKj8SB7UOPCHHI4MBcL1gcCVjOCCxkoGTq3fELERr4REGSl9hyTjBD5ojbyOpZAgUUZv1GHzoQzLjQ74s8ww6ai8lVpUZo+NY5I+fUIYyqDknR2jI6pZ6b7M+5pCuwlEFSN+JpGvgZzjk2uIr6Y569gXUh/n+PEog59YYeLsaZcNss/Ti0eecX0PLnr+Zi6JS+Cr/x2fhE3piu/y24qWwZToA+Mfe9S2Uwv82lcuyZ8rsEiFlpFsN4zaC9VDknp/DqB3KrZ7BdT0S9+JLQ0nuc+gflprg==
X-YMail-OSG: WVEU2ukVM1nah2BCHatiKixJPmV9NbXf8.JwkjTRF2s5rdTMYALu74dLThq7Uf9
 JLH74nS.Ts_ic7rfUhKmAHBGozpSuGLREwmndYZAJ6X0yFiW4D_sK3RF7bldQIKoKGxlfVxaD4nc
 lbblB6ZMxCnhsVlN.DCkrn2n7CJRYEqaANyK7fFn3pd8HvYxgSQtny2IpPhfCaQeUNoWsWgfIHon
 DHVNoxCU7LuAaMR1p2LWzjUCGZ1mlMA7uwNc8gJ4EMeg8NQnD3lCuNRbjhEPox83RCEkSyTqdVTz
 7hz7QU5ySc2vXRNMKk42WVVcGKuo4BNQWIOaqfXO2OeD5.M.5vhH8JgpeFH7LbQVtUGncrEVn8XM
 goZU0VZIpK921c1rx54bsVcGx7lVVuOBeu_OftjAYvq7gMZy4JkIO9JM0qf1a4S5YKsMXM1fsIJ8
 LB2oFS54SWQRSKFxyhRyStRGI2GFgVswL6LZUh4TxQHScurFlLWZnUJCsPvhTdp2nxOvATTWCwvJ
 U1a4DukzKAyx1h4RifWAuu57b4TWZGucJ6ppPM2Du_OtBiIj_SQE18iYpi5rgJHtDpVjLXDvBKBM
 3cOs6aj95PC4LI.CjMrAmhSJ.UQqs.Igm8LQD4vJppvmtoJFCY_spVObDb3SPW.YHXY9RrOz1sZG
 rI5HbF_huT1lb58w4YYbzjoy3UyeKceTFH6OCUFsHHl7n_DyRUyRUDZATAzIwGWRY1I9cdPeCVEH
 vz5ElHSKnw0WaNLioSSLKWk4vJ.J_V0vajwYKUfAYSgX0.fyAVWzc5NW40bowTelqZP7qk9EKhtG
 VMZRfLSGpKAiOjCPIikk7US5jZOtFe6Kwq2h9Hzkd05IHV_gKqAwO_AYUF.jhPtmM1xV9Y19iSr2
 f2b5zY1ScSXdLSfdmFKzNplA10bMqPx.uKE8lUGwUfqzhg2kRctdUk8EozV4PfKdtleTwy.CwSq3
 YfCzSFrr1euC7DC6PcL3.JDapi0K1958_KZ1IP6tJsUVvm.4zWZEu_t8udLOZU1NBx3EtFERbT20
 EIKDdNCXw_HrA8Dz9Ni3WaeI0w.ui8ggOtoxQtqadXjOW8BMhUn1xo1IaKab3.GckXO.YY4xxrBm
 TztwhbrZ9U_c4SKCTgRdjztg9kwhulKd2JZhFVPFwKqLFnyP.b72bS4AYjs73GLBZFRQawuykI54
 _Nxt1SBHzy19iPgzphz7afxgPmsNIjiFC4Eb08y7_Kbz.YyQb_V6S6xpF94jaGCgaJro25WVCdl4
 HkTVLQkQO24LfrABmmY7QXaTqLZvqb5X__Gh1jArBJklANIWkRrnLvnF0Og--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:53:15 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 740888a1156cdff0756b5bee8a218310;
          Sun, 02 Jun 2019 16:53:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 35/58] LSM: Limit calls to certain module hooks
Date:   Sun,  2 Jun 2019 09:50:38 -0700
Message-Id: <20190602165101.25079-36-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

LSM hooks dealing with security context strings should
only be called for one security module. Add call macros
that invoke a single module hook and us in for those cases.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/security/security.c b/security/security.c
index 69983ad68233..365970f2501d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -698,6 +698,16 @@ int lsm_superblock_alloc(struct super_block *sb)
 			P->hook.FUNC(__VA_ARGS__);		\
 	} while (0)
 
+#define call_one_void_hook(FUNC, ...)				\
+	do {							\
+		struct security_hook_list *P;			\
+								\
+		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
+			P->hook.FUNC(__VA_ARGS__);		\
+			break;					\
+		}						\
+	} while (0)
+
 #define call_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
 	do {							\
@@ -712,6 +722,19 @@ int lsm_superblock_alloc(struct super_block *sb)
 	RC;							\
 })
 
+#define call_one_int_hook(FUNC, IRC, ...) ({			\
+	int RC = IRC;						\
+	do {							\
+		struct security_hook_list *P;			\
+								\
+		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
+			RC = P->hook.FUNC(__VA_ARGS__);		\
+			break;					\
+		}						\
+	} while (0);						\
+	RC;							\
+})
+
 /* Security operations */
 
 int security_binder_set_context_mgr(struct task_struct *mgr)
@@ -1951,7 +1974,8 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 {
-	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, l, secdata, seclen);
+	return call_one_int_hook(secid_to_secctx, -EOPNOTSUPP, l, secdata,
+				 seclen);
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
@@ -1959,13 +1983,13 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsm_export *l)
 {
 	lsm_export_init(l);
-	return call_int_hook(secctx_to_secid, 0, secdata, seclen, l);
+	return call_one_int_hook(secctx_to_secid, 0, secdata, seclen, l);
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	call_void_hook(release_secctx, secdata, seclen);
+	call_one_void_hook(release_secctx, secdata, seclen);
 }
 EXPORT_SYMBOL(security_release_secctx);
 
@@ -2090,7 +2114,7 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
+	return call_one_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
 				optval, optlen, len);
 }
 
-- 
2.19.1

