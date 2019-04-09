Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5099C282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7F82084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Qkozs887"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfDITTV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:21 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:33857
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbfDITTV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837560; bh=qAJ+Rda21nKW+P9EyOWFlXVarN/YAKnXHrX4pZPXalg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Qkozs887KGB1Cuc1ABph6kaKuhXY2pdpwfMpYwbOcPoDtR+PasqqakMZT5Ytxae86Aiwk9UBNHHd7F/APvvwWRWnFfGCiuYTiD06ZOA3Lq3LTj8or+ZI3EpfbVcupkRVi6M3pkXvXlKIOzagsrkt/9xs+ZiLhJp647uHHE1vFbogNXy/BZScHEpdr9kVYcIgiq4VZLwuyPUItPUypSxXZ88OPHVvU3OzUaJCf5R96vVvQyoAMKmQJAtWtt07NN972z3I3TbMrVmNHLDgwSOsJuHY6qa61OWxF8L5xKWQGJBUBX3UhZl1SCw7H7xyeMhmL9+kfC9KypKRQfY2v//Smg==
X-YMail-OSG: Z8X48R0VM1kAX6hfv5ZUz2wpZYQSmRp2u6ngxow4yd9y2GRAVNnIgBUil0uPZj0
 Ce8L1dcV_ZHwSyCjEgzTS9nQVcxnQ5FC_vVjpGzWOxcH0r87Q78V90zgLdCy2v.S14LzrIQYXadE
 FGn9o_5YBbFzOTnOwiHRTMVAyGG8XOXbqnksHrO2Y_kDA0BtlCj.fdNJfcVt8CGc6fY1AlwXRsnv
 jeHS2Joktz9YiWir5UMjjBu7RYqXPmnjBemAfVJK5dOqMr.JisQwEnmRkpvYZkg5760BuHTNtZkK
 8uvPsljUTZl9__Ce529eLtsojBLoofdUR6B2cHJfzdEzGri_L.4J8WWe8iw2haQ.gBE.7gIzn_L0
 Gx2duRKtvM137Ux1KL0kXNadL6SudMfkjB6XuN7NOVtI8LvREF5qeYTT4d8VUebRRBJhE9lvJrMH
 I167zAuXGMAF0nMYOmKgaGDelKgijrlbd5kixQ_ygZ56AXKzB8fboqfgbws4mQuEGs84e3Lsh6YP
 xyGUawwSE3x_WL9iSwEVo.FNIq6qsk9O80s6sXgd4aYfVzpWqgF_siyyaw0f4rmgz7_oa399qOTz
 pWcqBZKN7.QQ_7VzTBcuT4naKFVeuzgT7kc2w.pU0UtWN28IeeBz8JarWlZYJLCKhMutaedo1jXc
 fxWSOSJvIB65JikQWmL_nmyTDMtkYYDWgwgkFTrLKhkMAj7tFnMVof_NXwEnSyUcz.g9V2N1k4c8
 E8Z7yhzHtiSoagmiHlOTP4qIXHDp3Wm7giRg9j1Opr3ds45_s6iLdUpgqNnULJZfdYzXWFO18zk_
 frt96QSNqCFEm9DFGf8P_3a.sqjCFCGKU1CcS.5dlusUq1k_68qYJpkPVApinmstYPqIIOd25lkc
 oHakMZU2y1QZZgX0RKe9M7A75CjlfqTl35D2LrpOeu6.QvUlXUzWU88b0ed9.DCcjyQEG1o.ppR6
 HDF0IMS0VV_qJWS01.iacQT7CBQNNW7CByAOJeIVkf8fLCuu9K_SWU.gAnapyclkv22JanYJLNAZ
 Ie7T7Gmq8VdyOH3KJyjrH_P.jr_oSCr8ejjO5JxJBPn8JU7hbwmyeKdt0zcG3_pra4PDcPUPITR9
 SA_ib5nYR2WInGz.mZWb4yjNHiHatWHbi1OPFOy7uxXfh94ctzoChYueJ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:20 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 564a224fa9abd9f41816cac9472f1914;
          Tue, 09 Apr 2019 19:19:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 36/59] LSM: Limit calls to certain module hooks
Date:   Tue,  9 Apr 2019 12:18:25 -0700
Message-Id: <20190409191848.1380-37-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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
index 015c38c882ba..7bf16c547010 100644
--- a/security/security.c
+++ b/security/security.c
@@ -713,6 +713,16 @@ int lsm_superblock_alloc(struct super_block *sb)
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
@@ -727,6 +737,19 @@ int lsm_superblock_alloc(struct super_block *sb)
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
@@ -1966,7 +1989,8 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 {
-	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, l, secdata, seclen);
+	return call_one_int_hook(secid_to_secctx, -EOPNOTSUPP, l, secdata,
+				 seclen);
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
@@ -1974,13 +1998,13 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
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
 
@@ -2105,7 +2129,7 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
+	return call_one_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
 				optval, optlen, len);
 }
 
-- 
2.19.1

