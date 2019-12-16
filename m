Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE35C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D5721835
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SkB51O8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfLPWY5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:24:57 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:43737
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbfLPWY5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535096; bh=/tjZqQ3eFg6RGmAZKeaCUxadHu2YVRy2b3KPUAFCwsc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=SkB51O8Fx6dj+KNQ4G1wkp3knm7ptTIO/t4V5I/ZjR1IPDouLKKflYJGW+bJdFBkAXA2z7SjqDXMH42YIa438SU7BI8wuCp8iloXjieNqcVFtxdecr1p2DaC2mMitCSYZ3Hcec+sxqydeRObj3VAzBfSrNA7hoCiM0+y6cjZShSxXKsS8SAJy+ULt8bavk2i0AmIGLu6D2XOv7c9F1VoUoux02frORsVHuGOEKHiuLnKucwn8SDMvRDbjwdiirk5NbulgY9AT8sL8Dj5Oz2eM0ZuEuL006X2UTBips8pXxVou6b8ULxww8UdSyEPZKE1yf9tNdasfNOks6WY2SR13g==
X-YMail-OSG: NzRtvQoVM1kw7u92EQpbZM0BK655550GnPkVHUaF2tqcXezFRoCow9NVIDxcY0h
 Ho83zsfy58L4NN9UF6eHKaZ.0H0kg7vLFPYHY9H1dgq7Bcffmcmz.yGL9IWa3XsNZizbJFrZkn4u
 AUYPQybZmlsYkehUKyxq90.Nb5cKBFO4kqHNxgdo2xYWx.mqeU5d283ihJ64OVfXKlCsCaHTkXsF
 .Poa7EGoHOwA1GB0VixdI7rxUScuNdUApXTR57b.ZN9ZPi6791pE8O.apZhQP5FxGpvaDG9OVmjl
 eePvfDSYPFcjQfchVZdg2p.H8HHea59EHQ.6Yrw7BAYbj3nFr1Q5oSRrH8aneQ6UyXADPVC8iHa2
 qZ9YKvmxSxqHm5OgBaUCOzu1b.4ygqMroUAeqMvifDv1SWAxNp7PU7nl6GSYN9yMYNhIxzaMVuX3
 bRjFGtXbyxK_m_8VFvGDuWXBio9zO8woklmC_8b8yyxFqNXxBc4uDauUdAokHkEZPhw7l2mwWcLM
 uZDqjCSzMAQ_XZAl7yI0DApqY2mmYYHU.iVofz8L_QVSfNdYl0jEaAnqoayCbnnGTzLkIHY5K.69
 3VtpJSHKqstBmLwdUJVLyOJj9GyYgm.eopXmCVVcEG.cup0Q4cFxph93TisMA2mZvakiGihtTfqG
 l_woegn14llpDie6HOKuWHX0CIBGUwwe.VJrkIP1a5bSryZzA.Gq87D3FQ6hl67edfqM0pTtufrb
 RQlDKh6xmxD3OQBSdcbpqFJ7S.NHL6hMzG9.oAeIg46BgOgGci326RV0FcpxnEu4zhLDs5xRm4xc
 mMkQhbhiLoqgjYlvrxIa34HZoE0ulTIWi3_1ajv7rLLFZStYsqw2P5mBlr1czlDIiwGWfB15CfDO
 eyOCQIbUn43s2ByFhVD.AaKSVAgNPLOL8tYXsJs1XKVcyTI5s7QcnMfC5Ai3VroYf2pWVTvY4mTY
 Rr6BzieTLlvzXvbZ60wp.ROxlE2qP92JDRjCLUOJsKVtBmlEcBezqhkAhuxnoM6czVBkkNNewuUG
 mVuIr4S0nks_h2veBNbXxj2.UtllOe.Ostz.WuqbA2phZyI5iP33.rikp0q.lZnrWlGtSlPhOXXX
 noOsePfIrjrLo7UBLEiYxSJGKmg0m4ord8GH4y7BMhyi0AamwZOqmHbPJ6oRky9AYXGdEeNurLfj
 roc_H.keMrqVMeF5._ddnAoVM0dWq2WJl3p2PHwyHgkafvJnfyUgU9t6Kdar5jv0tVarGxLDI81U
 C_SF7t2xASu8FZ94yoDj01uN4FhVlcdTU.uu1vuEo1ihzORjK7NA3UBqt2I1nOmxjJGtmIKaQjDl
 pXebcCSlmG_3YJBSVCU6im0EfHRQXpkm4c8coRNb7aDxzuUJ5A5xhWNLD1_KDDMyu0Fb1tBbpO7Z
 JCSyWnG5AF7qbfPVMnqAFEiY9Y9YFrOJwSYUhz.ofwle6qIoBKuKZQ5fsQnV0sUdx.w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:24:56 +0000
Received: by smtp412.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1be22e4886451d124518193455ee7ee2;
          Mon, 16 Dec 2019 22:24:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 04/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Mon, 16 Dec 2019 14:24:10 -0800
Message-Id: <20191216222431.4956-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216222431.4956-1-casey@schaufler-ca.com>
References: <20191216222431.4956-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_kernel_act_as interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change its only caller, set_security_override,
to do the same. Change that one's only caller,
set_security_override_from_ctx, to call it with the new
parameter type.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      | 14 ++++++++++++--
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263..03ae0182cba6 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -18,6 +18,7 @@
 
 struct cred;
 struct inode;
+struct lsmblob;
 
 /*
  * COW Supplementary groups list
@@ -165,7 +166,7 @@ extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int change_create_files_as(struct cred *, struct inode *);
-extern int set_security_override(struct cred *, u32);
+extern int set_security_override(struct cred *, struct lsmblob *);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
diff --git a/include/linux/security.h b/include/linux/security.h
index 9c6dbe248eaf..322ed9622819 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -437,7 +437,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -1043,7 +1043,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsmblob *blob)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index c0a4c12d38b2..846ac4b23c16 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -732,14 +732,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
 /**
  * set_security_override - Set the security ID in a set of credentials
  * @new: The credentials to alter
- * @secid: The LSM security ID to set
+ * @blob: The LSM security information to set
  *
  * Set the LSM security ID in a set of credentials so that the subjective
  * security is overridden when an alternative set of credentials is used.
  */
-int set_security_override(struct cred *new, u32 secid)
+int set_security_override(struct cred *new, struct lsmblob *blob)
 {
-	return security_kernel_act_as(new, secid);
+	return security_kernel_act_as(new, blob);
 }
 EXPORT_SYMBOL(set_security_override);
 
@@ -755,6 +755,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsmblob blob;
 	u32 secid;
 	int ret;
 
@@ -762,7 +763,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsmblob_init(&blob, secid);
+	return set_security_override(new, &blob);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index bfea9739c084..cee032b5ce29 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1615,9 +1615,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-int security_kernel_act_as(struct cred *new, u32 secid)
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob)
 {
-	return call_int_hook(kernel_act_as, 0, new, secid);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.kernel_act_as(new, blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-- 
2.20.1

