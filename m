Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C281C282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4252082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="e+VRnSud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfDIVlJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:09 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:34846
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbfDIVlF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846063; bh=qAJ+Rda21nKW+P9EyOWFlXVarN/YAKnXHrX4pZPXalg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=e+VRnSud7rdFVtcRBw8wOjBB7Lxd1XCLZ199+IYioIfETQ76GVB/SkITBwWXvwD8TH37bsqvXBHoDHrAFUMMSkut7QsIuEWOAUoasTEf670vinSlEj8p7ODO60NyDzcNQdri2899Zs4rwUV5YX9A/e/w2bQZ96Xq0iconkxU2FdDtAiCZVZed27rJ3vlqjLXXg9Tfdr+e0S5wvgPkE9c1S+EVoFifNzT8XZg73zkBxQ9GGfHu0VgETvaXGHdOWdqpDgCCJiSSzs0KaEFj4CkULl7lconKpEYp8sS7+b/SRnW6ToLlRIHwBu/d9XfPPdJxI58A53+BipW5MSkyTQeRw==
X-YMail-OSG: vw49.RcVM1li4ZVYc7niFNTjtkOqomyet8nQ7RG4aJc0DH81lGhYdAFpLOGjkHG
 P7T8c8Ml5kbniDV.utSvxFRMKOtqw1IfbynICMp7omKKVldMkLLGqMwY6EzVQR0go0RP81N3zA7V
 _LHXg9GApWOnYnS7f8fiKUNT8MkX.O5DBRAp5tgLue69DVoDPwQU3.2OqijX5vVsgmgGqyOjE0jd
 2PZ2K7e8twvkUV0iO4iV98qR4D54FPgPFkpX9fmd3dNvhWdVSMshQE4E06B4fAXgcsmgHillxxD6
 rdp0MLLRqrQ1fGYJAsecVLcNBAHSLGmPwIG0WCi4ubfDXg5sCPC0uRGp_EkAKL48NmdlBvowPIrN
 8FHZHtKk78LDLSGaOaUjI_iXNdgUQVfjsCc19m.xh8.Yp0TlNSUxVvSn700MitcCt5e59sGOmey0
 uYBuQ7EMy5bU9TykomfNP3.PStNGPtkIBJ1v8oPlCDxFLVpKpl55XzQAi0GzUrvSVHX9VL0ARlFn
 yVtkV7SzfFbcH82L0bbvAzpCkUC6H3zMIZIBDlYdZp3RNN9Khr7IOzDIZPgsj3m5um9dubFOVO7k
 cr5xf4ENv49VwjftL0eW5zpoIv8m8kfJW3q2ni5sPBPR8S.Wyj4paSZReePnq1F5uOvJkee6E_GL
 0JolN.P5DwTNiRLs58nE20yuqlghp.cPQHoHylCpyfP8n3O.Zyn_Pm7086XayVv2We71.lSQBn7w
 9GGU14en9gJzcAztcgo_XWOCpmW0RmxrO0M0lrvmrwXr4ljGkYvqSliu_JxO0XGk5arX0TH6Ftyq
 nXblfym5j8myVN9rOBc8hdSXk3lK0pYzZa.Le5USCNlzb6omcmnRzlONHYayin2q4p_Qce53fh8u
 W.bF.nLyx14sgOpAhPBOJ7Y_ileiLw0wRwxY5nytxh7CGUNnS1VioOFb8Po7iyCqbgrYI32sJc1E
 PJodDBMhqCMv4seCOcxzkJ22veLoHX1SxHHoU8NHez0m4K0gs4h_0nMHuggt_FNY_hZVkAlfPMR3
 W0tu8TcnlgYJRPMsLHUkxzFSq3EoMToeE_4l2QfHJwr_tiVu1AM8F82BJD6Sl5ClHS2sCTHv5ird
 tl6ZPUN5.fnBNvKnKl0C2v3vvWwpus.kb4VLSiDDTNtrEYhX770ncZqWzMpLoIg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6a737b6f7572f7259a29fc213d8f0ed1;
          Tue, 09 Apr 2019 21:40:52 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 36/59] LSM: Limit calls to certain module hooks
Date:   Tue,  9 Apr 2019 14:39:23 -0700
Message-Id: <20190409213946.1667-37-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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

