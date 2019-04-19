Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B19BC282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DE721736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ssbVzyrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfDSArv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:51 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:38751 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726876AbfDSAru (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634869; bh=zfBzq44MmcEq1Uo3O/oH4Lkcr97+L8XoyMvRBXLr+Uw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ssbVzyrlOMAmgPnftSg/VwIgatVRSd5Mtx0qhIWi+YH2nBzYNZi6ZI7xXAwAzQLIvkSG6GzQVM2www4b1C0ynolA1wjHNk1VzBoh6LWco+zTEHzwo9/JfBoFu6YYBEUYXxfPHcYqDp5Ez6XZNUa7b2ay1CGs3UR1kG01AdyWbOaXz8lTfronzyxxpTuvA1o/zcddvoJvWzMcclteUKk8uTWhE6/J0wnKhZ8vnRYxMjxla3pyPp+KM7eDux3ACx/pfsYBpn7nk+4QuBHyKkyywan1rAUfU4bDq6UtvHJQKBrx/GZnssZFPcSZBXPuPPlMY+lEBdeISPu4/BQPI7BWqw==
X-YMail-OSG: qS..ymsVM1k4w.KLqY1gDMfLIR8mKYGKHfr8n5ATn7suv5iFEK.RTvScvTyezJg
 Lqpta7viIqILvaAU0hH9F5NjNAJTnzVXbOGsXaQTQV5fOmJCYQ6S7GycEOQZ.wqiANlXotAYDFPk
 2xsRFlN5AN_vzhp7R_2.TUOyOVv4uG3P81kHoT_sQkAnBZnG4AQnB9O_ismHemjDv_MV8Zl9cD84
 qQemRHru5cKnHQg10I1p7OSQjKDNGsMcb9hrp3ndXoTt_8_AJ110EjRF3RxFuNt0z7QpWM6NVIWN
 xCmG7CI_EO8mzjagmOtA_NrqgHR8iLc2S6I_SRlg8thLTzSoP32pM_5QuUO7FNreI5FKeLIBoLma
 82YaArEOUQDzgBKFz1K8QPq5pDLttkBA6SJjw9dpWmhiLxE.hogen3A14JyFjrjInh9ie49VU_Ap
 FoJW5YE6KcFhNtDtsYmJg8qG_JMDUhTxETfA3Rxwz4Oyv6o2Es6.uetUvYxLpozkM0o40BcRbRWP
 x0_yUtV0LWW1AMtkS4pS_TFSmAX6QI9we41wqgPZL5f_CeKXkYKt8axAZJp7RlBfQPTtt_TfewC3
 cJ.WDOSNAbrYNAZONGxE0DNZakMnSafVikPDTs._2J6zg2jeT7GeOnkC7T5qPGEX0ZFfiYtx1aR_
 qoqQ6pya00qd28XxTp3FOOXv.iZ4pgOo849ZcCLEXnMwjdv38d_jfKMac0oT3Ai0EOyf7ZuxIpjl
 tWCQH8m8tq0DZ8vF93AZZtZEts.EU9.UPDk_LQ2wh5PdiXEpFztA1ctfgiM.vQ0mv4sUhOThGszj
 y9fSbf_zpp_F8uXHuXxy7jS13xYFY4vjz6iit2D.XmH4pQH34PBXKxLntKL9hGvjAA8jA9uA0LWl
 YYJIfCWPxr0WnzNo0us_zzDCAQWBlWUlcw17at5vfpN6ipp.VBOoVLNYik7TIgsDoQMn_uEkfaTR
 mAjUWp6fk481meUk5Z1tiNnIwPBzYi_f41oiTh2hwpxT3iirksHP0wTcYAryvbRtw7t_.mEXGdhq
 f5StFpQumlpaFdQzI.gOSZvhkJxlu2JuSXeytY6fMcQITqKvbIMJR.JnobV7MNvb17cV9NTD3jW.
 QdoqTbc6CpevCykcz9QenEGG7O66scc_in1DQDx19IUE86bZF_JuVXhR_Es1QoKVz8MIb3j3Bm.R
 Hxmet1yRI.45k
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:49 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID be9fa3e2c75d2b77c1de47e4a712b0c9;
          Fri, 19 Apr 2019 00:47:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 36/90] LSM: Limit calls to certain module hooks
Date:   Thu, 18 Apr 2019 17:45:23 -0700
Message-Id: <20190419004617.64627-37-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

