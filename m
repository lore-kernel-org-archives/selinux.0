Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E33AC28CC2
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E7426FE7
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ge6r5ppz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfEaXQW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:16:22 -0400
Received: from sonic302-9.consmr.mail.bf2.yahoo.com ([74.6.135.48]:38621 "EHLO
        sonic302-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726520AbfEaXQW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344580; bh=zfBzq44MmcEq1Uo3O/oH4Lkcr97+L8XoyMvRBXLr+Uw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ge6r5ppzKbwCrIMK+0k9UKMpZzElow6sI96oZnpXuOIlQsLySEWl3ozFQIg+kFvVBPFIbcueTodKJBOhOi51AGGX1X6HMZLD5p1PyZsI2QqfLEajSCeugw7Dj9i6WfdG64zlYHm+BZb/aXkvIzWLISF9TjUI1EVlKKsuwDCb9VxAE7cwYSvXCPjRD3n14M6NFNsulSaScwgZ0l2GmiFzIVBUNCq5tHqnzYZyAiAaywDcfWK5nXXXjfvxU21hocoX8ZBFEj3+6yV1IRn/h7HtVTq6fnaXoEHBaxp+hxRBsiFxlXPxPdHIa97sHhgzJ0jOykXFOSXEjmVBGbv17lWBUg==
X-YMail-OSG: jhBgxS8VM1n79n3bp5iqi.87jrd2omCQ3QtvP8cPeppfMucsqZqo6GYDTvkxJM1
 VLXQPqbL5eVC4L0Y3qIroCti3XXie6k.LLGLKKkUPU9jYyqa8YuCuUxKTRuN7DeOfzciqOBMu0vk
 souKlz06hUdlL1GejZxh91gP2ls6iXTxWs0Fn1.Svcatq04giXbbBYXqcyArvTWVZo1VKQXMkWTH
 KKu8GhKNBv6Wiiovg6fnHXNrikNos_NMZgl3S7OltUpuoZAjUvJfBOQVB53Trcym4u37qT7LuprU
 eyXI5iaXvG5MFvoRZuTLQH9URWDCjyswlE5..8Ndo5bst8uBdHIUJmieCkXqrgq_K6BedHWVYUwm
 FN6j9N4sfgwDPPZqq_iy5OsXwFg.wpN8.nC10ue2l67FP3hse.H65hYQs16k29AWAfDkOCaI8pM5
 QJMNYp6YJ.0gTGX3my25XzZ6_3j397rRuJUF2B85CTZLQVDim49ZYeLvTRE7dA4IvBmDkCtNBThE
 NE_LmUlG6_BeUCtbj1LP_DRp_ZfXJHCbpza6vW8XySiNq.WtgWBIyiWktSn5PdoGVoUH3GnRVrx8
 hJJpeapPEX7GdAMsOxlZPJ8dzkQYF2Pa7ix_a3URvsA.vjNaEI3NJK5oyO3Bc1r8PnSVM4vfwR4r
 KybMWY_8BwBWDmb_V0I89h_MkFx87XmvEOyughnE.0pO_fPx.0qI5KDWNVjG4dfJdcXCFC_Bqi5_
 RoYTh4fsu.b8hQrLXObVIm.5Y0JSJYG5a4Ex.ARoWfZ354T0nmw5hbK2q1L3kKVBoVZ1D_VPsAKc
 TzeiSKyy9jPqiGtk91XYck2Y74O2oViCGO6GsUHbgDMY1PBJIGdi5oHwiQKEhnMJ9k.63Rf.OsYi
 wowENxDrH0.Jm0dn4xhaiu2.o5RHKEYvvdpgXkA.hP1PZRAmudyZKd2er3KNoeOLt8aw9dnlkQcX
 fD6lZ8dLw_8j3gKySV4SZy35esVOYKWlLhI5pmDAXJQmlSHCkVkOpOSrbJJXwTTwUoM4mNYm51UV
 ceTjoXRkVaeBESSQadaWe7aSiauWJ02AVL9kvKhA_GRH_63B.8AInyGmFZiQRbwmk2ZUPI7AuhL8
 d4Z2HKhq48qpvXZGLCb9j4_1tawLmVrKcvmBN9Wstazf7GPqk.ciG_Z.MVFSVjNCmQO3drexguEk
 PMYqpJW31geZTSPKFz9fRqoXutkR0lNzTpuSYOqHpixqIqpt1c5OIWudXPyDVJ9cdwoICVmkq1X4
 yqhIMR78wx3PjJkG6cS1NHbgK8Y6a5rtsEOzhZ8BDzK3dfu_VrGTKHxB6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:16:20 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 871cbbaf11ff5bc468f07126785c4e7b;
          Fri, 31 May 2019 23:16:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 35/58] LSM: Limit calls to certain module hooks
Date:   Fri, 31 May 2019 16:09:57 -0700
Message-Id: <20190531231020.628-36-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

