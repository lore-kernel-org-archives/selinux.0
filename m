Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F989C10F0B
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4F420851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QgcK3hId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbfB1WUR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:17 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:32842
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730110AbfB1WUL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392411; bh=/7s9kJFAdPQiOafDPACLYw/xGNZ7CEoUzzV9C7ARcK4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=QgcK3hId8IRqa/QHE82Y/SKvz2X52gDzmxA3BA4SpzuTrKqzvJ0EwqAKH83dTW/bhcApZjHto55Gi+ngf76pwDvwQi8pjUkk00l/RxFmXMk2NBR0AxKVhCW0izrOz0cBc8zuql9weM2tivBxtRuEmXTx2E8EJyByhxGY0Yl+QQXRzuAl+lcBE9ZBtjES4h5eIvTkkmn/h3Lqhuepe5DMw6LrC0ZrzBXFdqd53TavId0vqPd/gzW+6RbLsYmOLusOQxcvYwVRdXEbItFIIsQUEwew0ddSQjnPj+/o271yw2sQWe7yyri/1ryXH3ndtBcTyho1HwQNrJ8bHONdb/Xk2w==
X-YMail-OSG: X994jiAVM1neTzZecOpsfIgC4DFnf1qW0mMq3wbonD7hxtHuw1Z9qwlaC6_RgwN
 Nc_jwZwESc.5obxpArAono6EgPapCaatWE3cKxprCnXPoozfe4oF3gVA5LZq7kQXN7gN1pibrSR1
 mO8qGxrbA9TJBapv.dGbL91DAKZxliDXBl_JKnooszXxiU7tAlaaq3t05yRfWacpjtnBcJz4l0Nu
 hXVWM6x2HczfvdGNqU664tmM_YhdQ3mZrlMoBLv2C3A2br7uLgzIkNWxVxYPd9LIm5HxoEuefFY_
 .8aw8HpI4tWe2nMepuPp8MuL8R5cBlxjYwixC7lv.eRLzz9oWR364mIz2cFNEX0czyDJlDU00vOn
 rMJnvBH0ekETcQzhZ6gme860qh5qeB20UOMqbWwr6v7sgjFlZCBm4WbF3oS3VPoRQXniJQl7tEqi
 duSTtubhzF3lJNQSHWo.BQgBQIVPTfUrVeNwD1jZe.0G.u_dhFw6TDWwd19RwDgZdYdwKmasKL02
 NjwxRZOz_COcD3o9bc2B8c7MJOwwmBBoNAKm9i.AGDXJqOINE_xaZqyBeAllo9ecJ60FmSXmS2Kd
 slwfu6zddZmX.iWRaATjyilB3UpNohWiu19t58yxmEUxDNbBOZynZfsFsrSKjjxxp3HJQEvqQW6U
 7cTkZOOukfLie2l9YTnUrzPM7x0YhkH1pIuBaU2bGo1vsnd21HusdPN12UpliEocRG4DAFrBn4B5
 _mKaSuDfyZWx_us8grfZAYyKH2qzDiL_H.0glyXuUJMcB.yBvea853oMrw_CtXHtDClIaC6Kmrw.
 ZPp_d4cOMZlCT9YGAyHEEjh98crL2WRfMzTqqs2DS_seTznEqH1BgdJv1jft90qHbjC49CD1UYK4
 TraMWLtQJZqwZXHfeSKCy5p7QV3aKExIqscFgqUe2KPff2nevNhZRRRFwcMAA7percm6UOkFhSiH
 MKhKCPtdecv_G_n_YCa2fXmF5oeXg9W.YcM0SLo0WPeXDezJtUJKe8i1qaIaEeac6cjsXNbExAu2
 E9FKByN8szySEIUZnbbxf_YVlT9KNMMWjqRzfdxRgH07900PXrFfR.El.faz8Dry2KQ8Emb_eAGD
 KQd1NbqVZiaqzkFDuPZYpTf7NMH8soap4q6OGhUsPh3hsH85A
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:11 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e588ca5e0935b1286f019b02cb065c6f;
          Thu, 28 Feb 2019 22:20:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 42/97] LSM: Limit calls to certain module hooks
Date:   Thu, 28 Feb 2019 14:18:38 -0800
Message-Id: <20190228221933.2551-43-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index 2f9411b93f70..c81010db34bf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -709,6 +709,16 @@ int lsm_superblock_alloc(struct super_block *sb)
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
@@ -723,6 +733,19 @@ int lsm_superblock_alloc(struct super_block *sb)
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
@@ -1952,7 +1975,8 @@ EXPORT_SYMBOL(security_ismaclabel);
 
 int security_secid_to_secctx(struct lsm_export *l, char **secdata, u32 *seclen)
 {
-	return call_int_hook(secid_to_secctx, -EOPNOTSUPP, l, secdata, seclen);
+	return call_one_int_hook(secid_to_secctx, -EOPNOTSUPP, l, secdata,
+				 seclen);
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
@@ -1960,13 +1984,13 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
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
 
@@ -2091,7 +2115,7 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
+	return call_one_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
 				optval, optlen, len);
 }
 
-- 
2.17.0

