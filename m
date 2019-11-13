Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BEDC432C3
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE89D206EF
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 17:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IWWYaRAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfKMR5s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 12:57:48 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:40126
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728391AbfKMR5s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 12:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573667866; bh=eVAcx7o8q0AFLreBS98x3GgYwdFEcr7jaVdmiN42/p8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=IWWYaRAQD177dnYj6PYL7QXhfaz5LaE0iWb1R/SElllEBXdvoM0e/YirDSRBr3Q6z3h1UCr7QhdLHfllFItShCvKjeIjEzZ+ogX5G9ykT3HqISGm0oI6NiJl341PCgGtOCqudOgmnNxY2DPWAz10u8Hk0RTNRwxsQQmNC60J/5uk6jaTlPYfOEXSRYjmocWiC6U6bFy2FFA7qBMYHlBhI7SLdmU+adOgQoAeQKSHENawySDvwXO7v68hmkeKeXkN1EMHuPqtHInpCeya5rNkE4qU+UuRwT8ionAjseMwyPDqTynnGlsRpPa9ZjiZUXazEJTwW8kf8UYUrL3BRJrEMA==
X-YMail-OSG: 55WwOLAVM1nBO1rel7IgudqoIXyfpiruBtwI1sMR_ZuknswgHiFXa72Gvnl3_Qj
 mUt01enf_9gxAoAr2t.HohZshNJmMoLF4yuxVs6D_n3A8fJaZzb23kI.54oB.Yp5nJnaEI9RWH8Q
 Dy5UBsPcJF7ejwzcFOU9Uj_nTkp.bFukJ8F9jTiKqMby9EayMvMRshw7hmaYwWV7xLoeDftqblNe
 MmFzb91bdyBYHsuuTClnVdgABIlI_Sdrcr9NX4SuYs97tWUa1rrZuFpXffKnKiPPAYklz0Wxbg2z
 bsX0FQno5JiSOVrZRIsRuxHavzgR7EirsYbychMcXNTkIaoX1cQ33Jf7zweOvyXriKa5y3E4qlTr
 EIXXSUwyDBx4RRomAGbwXvCuVdVOJCExSZR.Ar8FIrraLncGN_zwPjsgEZwDu0Pe._vE9U_2nAmr
 G1kS2iugAWM89CCL9f5xTVTCs_y_XB8M.qmjTvQXbuJWy_DP06gKSGU4HcUOnxWU6tCHKBXSJX1M
 JEFzOYj24TXnvwF87F.LqOoSgYrmk0C5TvpGcdAGWNgEVl7P1oUHXNcBUF8gvzhTbT562DrehXeQ
 brzg3P3N9XVGM42lgMQsVQoP7sForgd2hZIH1_Vcv0xgi_SQzNU4cRFzh8D7IP0TTF5k4AJNqRyK
 MV7iur8fXjM8w2qICAazdcHb1akOUPLG0wNJEHkVboAONdjjzP71A_UhLvcf6WB_liyduja3K0sO
 PDuqpj8IFIWxHCcBrqMHaSrCh0ewtthOyCHJGQQ3MdiRJOtxdYJIso8aUbdjdpbbxjHPiWVFLBqg
 awvlNML0Xk8kdWlr3PHrUBwHrgeWOiuzC7WdFAWH9voFIoMGWBccS7g_VrXFKC16CetucQIoiAYd
 7rmetvTMIDJffkOUaD9QQu9D527Oyl38dpPHDcIrgehefHMJxiDRuwuWJx9slCq7KYZgz55S8kZG
 9QIoiQozbXFBKRAuVbQYRa0AlvY543BufyR1yAXMob0a48jjCLPJeG95iQ_V55lMutRgryzwcwD7
 lIwEdmfzlqQwkliNqErZVNgJV8WFIqde6WYhggXWk.0CEYbOLFKXt9wSSrMdFudubUmyx3E55kmS
 ycSBQ6_Ur1vF0IJvHTyCeHZjHZNf9gLabTgN3Rb8ueJ8ghOzqdSGvrMO3TjjdeR604c1AAkvdRqQ
 KVCivNuWRFTy2BtMpe_56CiiqWUtySgBRo9diDKQkRQySgwVZ7sGZedwBxioSOL3RGTvqjGW2s05
 0fvrOBgpyAxUfx6_N9Kur9eqbyBOuBCFKtsxXX8rMsbkQ9xqImksZCAcYgULQUhP2nlLGxa_8HS7
 wP8nY5jRrD1RZGQ3eI7gIQGQm9jq44anhne3awU9hOlnNCPrpKfWinWISmAb7_4J63JVfYO0q7Az
 PqpY9tJEodM67.p.MnS1pcJFksn8BZjolZgVNwUdH_SwwLIqHI4b1oQfp0i8_MWsOI5.rImcA_Q-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 17:57:46 +0000
Received: by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 86d8955fc8bdd0cf32fd2f9119ccd325;
          Wed, 13 Nov 2019 17:57:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v11 04/25] LSM: Use lsmblob in security_kernel_act_as
Date:   Wed, 13 Nov 2019 09:57:00 -0800
Message-Id: <20191113175721.2317-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113175721.2317-1-casey@schaufler-ca.com>
References: <20191113175721.2317-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_kernel_act_as interface to use a lsmblob
structure in place of the single u32 secid in support of
module stacking. Change it's only caller, set_security_override,
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
index 2df58448f1f2..2b0ab47cfb26 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -435,7 +435,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -1041,7 +1041,8 @@ static inline void security_transfer_creds(struct cred *new,
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
index 7c386cbe4cf3..dd6f212e11af 100644
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

