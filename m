Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27457C28CC6
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AAD2794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NjEIdKSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfFBQxm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:53:42 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:45386
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727047AbfFBQxm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494420; bh=Si7Q6Qio/TpjyKyKBImiMFKuwDNX1UAPNk8f8AqjWng=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=NjEIdKSg16MYQRaMfEFQAY1rT2UwJ6VZ+S2ch+lTAM3uWrOoUkrg8JKDJ0WpHoDShGQBciCgPR3vvvUNBFLqInBVfAKUS+vDk34Jgc0TcqkG8tYtUghTuw4ZC528TuYBr0euELzLHmGQ8s0KHApU1sJnn8nVKPvQWga3m0Iqjd6gwt1jnzk1/MowCN/nk8CmGDsEgdh0EENWv5atkmxd/P2t1yvLvpiYPVWaXCSTE5lKyXkUh2eAR8/kA7R9R+QmK+JnHEBqBXaeOXjF1V+tz0f/5gojrkSSMrKfe5ePA2wqxnsXJwLLnG9FfqMniwlI7KOuUXsRNugEvMKJiBv8Iw==
X-YMail-OSG: M19Qwq4VM1nnYhXgoykhq3iOz5FpsgSaMb5ZcXHLHzNB6LVlCmdrveZPEFv2I4U
 ua_mIDSDKpKtK85j3MuvihZKZQnXfLUnjjalDQUzKNlaOToOWaKSlB2flpfnowmn0wkrTJwOPnel
 H1ONjWwyuW9axYaRqCJcE8p1HirY79DWG6HlYhECLFRfvargcrG4wpXHEuBcURHTsoIGFoAu2.Nd
 3GRVTKMXWutCmPd62nehSWU__IJ3QD_qgcQS81sETmIXm5aDeeGhY1EC4eynlX65lyMsLq6yHZ5i
 s2kYNNPnpK1K_TMPOeUN2x7GMHRFc.dDQD6C2nUEJ.qsP3F3rCxJ_3mMvI8upidLClDrTKsrKkoe
 Wg0lQVoop82LAbNffHtiH4vDnIadRkT2b.GxZFbJnIxAYeTdvk5SMd3MFhBh1bZb.DGDPoMXR0co
 EFXBIOxzB2Z4Hq.3v4LSQPJIwLiQ25IpYcWqxE3VVn0ck1Ayk2vcXD9bDkulAWsd7p7aRtiW.xy7
 ElXz433IrbXzarz.UZh4O_NVz59H7Lt0SntYymdnXUIHjy3F36C3CrxsLCrWSl_QoM_HyNr6Z52a
 53nVe0D.Bs356G15dpa_dl4auwQnZD7ULwjWgZhoNhQ9ONBarbLjL_HRa5luqtOzFLDPwNJCa7ov
 MRENyU4uz8AD2LvZPrEjtgecUSkD4lvRmCjnwSTgJM5m0GnBLbibKubaBuy8qLZKr7dPjhudPNJR
 6nyrHKzgu0iHvodZ0GF3b1x3TePzOkONFcIWjkJqxHszVGt3ez5n1sioKmljPB5Rfc5Ad10YRV_0
 A_bJeBz6Vi9s6MpXdmanTpQ08bx.NUyA6jjsSayeElC4gYGtWqS_s1aGK7HgUU3k50kJkRraiVpz
 udoQjCL1DK2DOdREfciq2mUok5m3p890kDYjSvt.m_SVJW8mMVeZOFinPvzE5iTwzxIrJIjvUFFM
 VgpJ3ZSo2me9m6IjA6t1GCHQ5h6i3r4ZpPsyIN9dARmPqqBnGFrpm1Z.1lonPnIgoTku2ZqAnQ_O
 ei.wafnu5GfMRQm3C64CLE2Hcn_dZ6r9GhGScQYyAX2CpWylfpTyIZWPcAy8JYWnlvEmyhihv5Uh
 4iW_t9o_159eGnaktaTGYOpVPdda8Rmi0n4L1uW7q9V_FE5Pk8xWyG0x8x3CfJsZIdQRRN_Al63s
 3N6MSgpfYyyDdSZ0xVr60vXTSYwxzz_S2y3WgoFQ412pDTIGfja8n5dSjz.KExuT7THFSZUhQrIl
 VCETDuT6kDUgPDw7ZzWiiNOyXEuKmOcp0Rno89Kh4sZNjWCbC2gO5pA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:53:40 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp409.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 111e227deeb5369cccd8023f32784fec;
          Sun, 02 Jun 2019 16:53:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 41/58] LSM: Use lsm_context in dentry_init_security hooks
Date:   Sun,  2 Jun 2019 09:50:44 -0700
Message-Id: <20190602165101.25079-42-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Convert SELinux to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h |  7 +++----
 security/security.c       | 10 ++++++++--
 security/selinux/hooks.c  |  8 ++++----
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index eda0a1bcdf07..d4ace7af4950 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -165,8 +165,7 @@
  *	@dentry dentry to use in calculating the context.
  *	@mode mode used to determine resource type.
  *	@name name of the last path component used to create file
- *	@ctx pointer to place the pointer to the resulting context in.
- *	@ctxlen point to place the length of the resulting context.
+ *	@cp pointer to place the pointer to the resulting context in.
  * @dentry_create_files_as:
  *	Compute a context for a dentry as the inode is not yet available
  *	and set that context in passed in creds so that new files are
@@ -1492,8 +1491,8 @@ union security_list_options {
 	int (*sb_add_mnt_opt)(const char *option, const char *val, int len,
 			      void **mnt_opts);
 	int (*dentry_init_security)(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+					const struct qstr *name,
+					struct lsm_context *cp);
 	int (*dentry_create_files_as)(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
diff --git a/security/security.c b/security/security.c
index 4f443dd481bd..c04b334370a5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1017,8 +1017,14 @@ int security_dentry_init_security(struct dentry *dentry, int mode,
 					const struct qstr *name, void **ctx,
 					u32 *ctxlen)
 {
-	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, ctx, ctxlen);
+	struct lsm_context lc = { .context = NULL, .len = 0, };
+	int rc;
+
+	rc = call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
+				name, &lc);
+	*ctx = (void *)lc.context;
+	*ctxlen = lc.len;
+	return rc;
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 633d62b97e90..fe09905d013c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2813,8 +2813,8 @@ static void selinux_inode_free_security(struct inode *inode)
 }
 
 static int selinux_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+					const struct qstr *name,
+					struct lsm_context *cp)
 {
 	u32 newsid;
 	int rc;
@@ -2826,8 +2826,8 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 	if (rc)
 		return rc;
 
-	return security_sid_to_context(&selinux_state, newsid, (char **)ctx,
-				       ctxlen);
+	return security_sid_to_context(&selinux_state, newsid, &cp->context,
+				       &cp->len);
 }
 
 static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
-- 
2.19.1

