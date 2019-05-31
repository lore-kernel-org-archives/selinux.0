Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B24C28CC2
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619E426FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PWIWPjQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfEaXRt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:17:49 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:40367 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbfEaXRs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344667; bh=Si7Q6Qio/TpjyKyKBImiMFKuwDNX1UAPNk8f8AqjWng=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PWIWPjQDahjeB8NW/lCeng3K0OKoB8E84t4CuHVPE4DfiP64Vk8zZrGIp5QOIe/qg7q89+TvsQ/IGiQk77zmEn9dSidVKeRATuaRgrk0WjJobl0pN/eHvLmGmL2Di5G92d6bEoDlwqdUaKEtWVthBA53mtA+x7pXLSnQ6en2+coZ/L2mtZg3b4QfAcqckx6VeRyaizBxzv0CJp3eiNoHSobBheXQgw8mpiBS5kdjsKAYXSP3uuUZ6BYl4fI4lb5aN2I5KtRS+UCdkpW0325uRDsKuEpZ5skD4hqGv/+Dz6MiBX3CpomgfV1pZvdMOYptUUegR38BQkWNZEAwQns6eQ==
X-YMail-OSG: MSjjHOIVM1mS6NomU9_LKkedDBtb0GvKw.ysRWVZqmDnYILL3CjkcZKQMvpmW7k
 m6VLUkHK8GBFCMG4YU1YL3Bv1jsQGM6CL4_wAI_Mv1t.9i4Y1vO9TjkKKGu0JWRm_EOoIrgMI3FE
 yu3HoZ1QKrTugv0WRkTlps.1x83Basl6k_cFt31HyMElslIey5HPebf9q6z7fKshaGgcUsm5.pJu
 fruQLubK9NkhGbQg_92c.fA5Qvj.KtfnhCzCCvCeS8K62NHXHpt0ccckbP5jEdMRUPk_Rk0rzOJa
 oQzbu2_.tCRabYP0qUCTdt.ZqhpFsi2aStbD.WcYUayRP7pMUupeiEJbV7NNviKNeGVk14Y8a7IF
 4kiG9UI1wizG4.lT_dcE4QJeFiMkGifq9Dju0_PsTSUHu_48MjRIGaH9XAM37pQyX1CUu8sr_IBr
 .sZYBZ6Nyn4SQHrb6vZkBRg9kjrTXp83QK108aPCsWtj_KPD_Z1llIa_h81IpMTlghHLrzBUxTgk
 F7U_NKgeQNuZTcfO.o8jivzj3m2OPtg879GH9ux0ae4XWqTQLFBH4pbV1uW1zvh4cAUMzytM5RK.
 XGMMgviE0lBOUamwywcYf3p_Xs_zPaBp0t4h3FeqC5JQDq.ndo9b2IDmY1Tb83BKq_0hM7g5RJhu
 kuudPLEw.QNFtbvRSCb9UgLI35kqSKsiPcPD32pf9CvaLLu1TGgZUWYKO2eNnIkD.TMHqZBVbHjn
 wfPapA9VCXv9ROilwKj5h_CCkylJzh8Iezvih0KQmOOCCwgWeHKT50GwJW.CuUN6k7xXp_C0yg8s
 W5VCM6cZQnVW_svDpYufysY7OH9jgUsSOKUuW8SvLsO9Jf4kNLOxOZQQUlXLKvPweCJ3XSsKD6HW
 6FW_6Mx5BN2XgmlhQpXYfopZQvuw8UDx9snkIRG11T_LQIgNCdDjKK5DDRpBAoZgmF0XNtDkkRVe
 GqgAYlpX8Ooo77tLYC86.v2yIMzEtOpuOvKYu7bwZvEPy4ODz4kuZOWcJPym1zXJjCv050ZZCgOY
 GBbmtIPKRr7iulmazL_m1pIFzxe85dMLgJI_Du8EdWJJCHaGc7JfLeJtK5LFMyiLQQMKIUnFdHSM
 eJFmmAHkvzyw_EPqfdAIC5sAB0lixiXbZjhLcj5bpm8q.W9Sj.zjCWfWNIgHRuQmshCyIy1A1Frn
 WZDriI4N.puZ4s7WGHjsdt7xRjF6untti_cJnZtGFdQ87mkzs0vbG9rz21iq5RllxOPOqe_nO740
 2vUmttiIIFaJbTM7d8a_EmMEdOF3boT6z.jYe_W_.OeGR1TvFYsHb5NHn
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:17:47 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c12209eaac0c3e6e8d2a068618591584;
          Fri, 31 May 2019 23:17:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 41/58] LSM: Use lsm_context in dentry_init_security hooks
Date:   Fri, 31 May 2019 16:10:03 -0700
Message-Id: <20190531231020.628-42-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

