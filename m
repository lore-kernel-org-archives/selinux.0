Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B03C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C0721736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="m38suh//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfDSAs4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:56 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:36873
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727020AbfDSAs4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634934; bh=ORbRvUuux3kmPjo0O2j+KtG3N/AG1FBfXpeKW+fyBLI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=m38suh//TLtlLVqUGMP7YHy8/EaA6UPScTqoZUzC142a3iShadz6cX1d70qdVaFs0lqyqB+oOH442MoInuq5kxkT9qMRQ74hLb5PdNx9pl1QkXajMdvKyhsY+PFU9oPahEvUUcY9DcBNs3tUJLY8gZNC5RnSs/S8H+Ep8ewPaPcEPQA2wjPber35gIPuYYu10h193PsFKRX72GJ8MxyiEmhJobXgTiSyOn0BWh32KDEtOW20RJn8cJG0nYliZe0qfLV4iuyTTafDZC1olwarxQSN3dWQOGZuNf9sXbeQEagda8YFDCe3Xh6i7PJg6Z0BlBK0FVb1QoJXEihPtKegsg==
X-YMail-OSG: 9eHLjN4VM1kF6lRnbGCDc20GURfrRGhiIYWbrUmstuCydfELWTLN9tMq7gIYJq7
 uQ4wLA5jhfKEhAVQPpv_rBzN4_f0LK6j2HHOOgz04Bh4jMvkW9clq49A3Bqz6NoUAiWNbhNBLp90
 k8LETUHk0qjW1JXn5ge9sRv.N0WuJ0osRvDyubemfe26_Zih92i_G.2qOY0.8t92iMJpy4dMM_KD
 CvI9pJ8JnEFjSSCPg6c790UDgEnl5IIgEd.Xz7rwX58.LRNY6wMA3CMtqma2BKkdrnOamABBueDa
 1OqM_gItL_P.chP15zV1dftN6cv0RHxb.KNTSHG9JDG0HaskZ2qRHxuIs7_ceSQV4letBuMh.dxy
 UyeXZvBp3DOrJ18__ujyqZTmAzdTX.LJNn74K_cWyBWZTEjmrX7r264UV6559Z03v6gFvxxLjUNr
 cHc31oIvkNfCyYnOOxc5m4Sm3LWTOAJjZg4WE6YGYqMX1XJaVgguE6wE293pPDd8mJzOtOHgvFWa
 Jm6fo0swJ6uZQgCVN_AgIWf1f3.Huwmj.vupKC31Lqxp6OBO2pS6N8v91M9odlrBItlui6EhQNDf
 xReGJhqb_r5ORpZjFTF3O5bJUk2Pnyc48QZ2JLMxlK_KvlxuuiapgOp7UrYHx5rD1.ubcxzuJuam
 MVVtAIkj.zTK0HUK8ystsShfjmxSoe3vcrFpf5bYcZG5LXpPvuD.Qw3ZR2bGQ.DL9wunIWfJIz7B
 R2FhLivR7xYDX5tWTExIYnb7_RPtxuEFSedl6X_U47NJPswz2k2LOOnaeJVRq8sqqc13rEGLRoK1
 ppZWQdwywsrC5M6hFVNwiG5AvD51df1RexJ8Fekzf8ja.sDtP01XyitSTIHBb3tdUWaix.ZTdCzc
 53WQ6VhoX49UvXb_KWyKgbOZgiP1vkE06GRm.CXs0k3uAEQASI4n7DGisqIYmUJmw1hqD46P1cY8
 9CBGfyB_LukPLf8MpyjiVR1SXDC5xfmJqrukDodBlWcEUrIact1WTkHIuBPYGzNmaMQP5dGTPmyC
 cSbNEo1xKGQfDCgFR_aC4ks_vhdRMOWbMpMsKWcBYI2igCnAH.f.ZOhd0.hRu_TMeWbzfAAY0Jvs
 tu9dX3_RpknCk98OQcaa0Cyhv5SfObWiV2pI54UT32.4CGX5ROsg7ox6t1Sz3q6uhcgmJH_28qWU
 hDC_QNjX7gd8IaQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:54 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 406f9efc49df2aab5b39f3872aa73829;
          Fri, 19 Apr 2019 00:48:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 66/90] LSM: refactor security_setprocattr
Date:   Thu, 18 Apr 2019 17:45:53 -0700
Message-Id: <20190419004617.64627-67-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Break the common code for setting the lsm_one hooks into
a helper function.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 124 ++++++++++++++++----------------------------
 1 file changed, 45 insertions(+), 79 deletions(-)

diff --git a/security/security.c b/security/security.c
index d36e5bf594dd..0c749816fb7b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2004,12 +2004,31 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 	return -EINVAL;
 }
 
+/*
+ * The use of the secid_to_secctx memeber of the union is
+ * arbitrary. Any member would work.
+ */
+static bool lsm_add_one(union security_list_options *hook,
+			struct hlist_head *head, char *lsm, size_t size,
+			bool was)
+{
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, head, list) {
+		if (size >= strlen(hp->lsm) && !strncmp(lsm, hp->lsm, size)) {
+			hook->secid_to_secctx = hp->hook.secid_to_secctx;
+			return true;
+		}
+	}
+	hook->secid_to_secctx = NULL;
+	return was;
+}
+
 int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size)
 {
 	struct security_hook_list *hp;
 	struct lsm_one_hooks *loh = current->security;
-	bool found = false;
 	char *s;
 
 	/*
@@ -2020,80 +2039,31 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 		*s = '\0';
 
 	if (!strcmp(name, "display")) {
-		union security_list_options secid_to_secctx;
-		union security_list_options secctx_to_secid;
-		union security_list_options socket_getpeersec_stream;
-		union security_list_options secmark_relabel_packet;
-		union security_list_options secmark_refcount_inc;
-		union security_list_options secmark_refcount_dec;
+		struct lsm_one_hooks o;
+		bool found = false;
 
 		if (size == 0 || size >= 100)
 			return -EINVAL;
 
-		secid_to_secctx.secid_to_secctx = NULL;
-		hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx,
-				     list) {
-			if (size >= strlen(hp->lsm) &&
-			    !strncmp(value, hp->lsm, size)) {
-				secid_to_secctx = hp->hook;
-				found = true;
-				break;
-			}
-		}
-		secctx_to_secid.secctx_to_secid = NULL;
-		hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid,
-				     list) {
-			if (size >= strlen(hp->lsm) &&
-			    !strncmp(value, hp->lsm, size)) {
-				secctx_to_secid = hp->hook;
-				found = true;
-				break;
-			}
-		}
-		socket_getpeersec_stream.socket_getpeersec_stream = NULL;
-		hlist_for_each_entry(hp,
-				&security_hook_heads.socket_getpeersec_stream,
-				     list) {
-			if (size >= strlen(hp->lsm) &&
-			    !strncmp(value, hp->lsm, size)) {
-				socket_getpeersec_stream = hp->hook;
-				found = true;
-				break;
-			}
-		}
-		secmark_relabel_packet.secmark_relabel_packet = NULL;
-		hlist_for_each_entry(hp,
-				&security_hook_heads.secmark_relabel_packet,
-				     list) {
-			if (size >= strlen(hp->lsm) &&
-			    !strncmp(value, hp->lsm, size)) {
-				secmark_relabel_packet = hp->hook;
-				found = true;
-				break;
-			}
-		}
-		secmark_refcount_inc.secmark_refcount_inc = NULL;
-		hlist_for_each_entry(hp,
-				&security_hook_heads.secmark_refcount_inc,
-				     list) {
-			if (size >= strlen(hp->lsm) &&
-			    !strncmp(value, hp->lsm, size)) {
-				secmark_refcount_inc = hp->hook;
-				found = true;
-				break;
-			}
-		}
-		secmark_refcount_dec.secmark_refcount_dec = NULL;
-		hlist_for_each_entry(hp,
-				&security_hook_heads.secmark_refcount_dec,
-				     list) {
-			if (size >= strlen(hp->lsm) &&
-			    !strncmp(value, hp->lsm, size)) {
-				secmark_refcount_dec = hp->hook;
-				found = true;
-				break;
-			}
-		}
+		found = lsm_add_one(&o.secid_to_secctx,
+				    &security_hook_heads.secid_to_secctx,
+				    value, size, found);
+		found = lsm_add_one(&o.secctx_to_secid,
+				    &security_hook_heads.secctx_to_secid,
+				    value, size, found);
+		found = lsm_add_one(&o.socket_getpeersec_stream,
+				 &security_hook_heads.socket_getpeersec_stream,
+				    value, size, found);
+		found = lsm_add_one(&o.secmark_relabel_packet,
+				    &security_hook_heads.secmark_relabel_packet,
+				    value, size, found);
+		found = lsm_add_one(&o.secmark_refcount_inc,
+				    &security_hook_heads.secmark_refcount_inc,
+				    value, size, found);
+		found = lsm_add_one(&o.secmark_refcount_dec,
+				    &security_hook_heads.secmark_refcount_dec,
+				    value, size, found);
+
 		if (!found)
 			return -EINVAL;
 
@@ -2101,20 +2071,16 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 		 * The named lsm is active and supplies one or more
 		 * of the relevant hooks. Switch to it.
 		 */
-		s = kmemdup(value, size + 1, GFP_KERNEL);
+		s = kmemdup(value, size, GFP_KERNEL);
 		if (s == NULL)
 			return -ENOMEM;
-		s[size] = '\0';
+		s[size - 1] = '\0';
 
 		if (loh->lsm)
 			kfree(loh->lsm);
+
+		*loh = o;
 		loh->lsm = s;
-		loh->secid_to_secctx = secid_to_secctx;
-		loh->secctx_to_secid = secctx_to_secid;
-		loh->socket_getpeersec_stream = socket_getpeersec_stream;
-		loh->secmark_relabel_packet = secmark_relabel_packet;
-		loh->secmark_refcount_inc = secmark_refcount_inc;
-		loh->secmark_refcount_dec = secmark_refcount_dec;
 
 		return size;
 	}
-- 
2.19.1

