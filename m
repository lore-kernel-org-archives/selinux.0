Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665E7C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFA521736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gs3Ylr8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDSArA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:00 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:36032
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726707AbfDSArA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634819; bh=1W3uUkvFiV/hG0OeWxySGoGDdIhr1Nn/Tz9IT5pFX0c=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=gs3Ylr8ugBM3Z2pPZuPPJzqaEZ8DQRjsXiKr41VBhhgHx742VEgM9GXsUzhAV28HbaXGprQNo3PIi5o6LuTINbECkAM2wmlLJGWV8ylTi8bVnKcwpW+3j0s2IAkSFJLDX8RY5LUejgxS9xvlzsrWv8uYVdgmX62daB+p72Lwu55JMV8azLHn0pUUpxbbxQgXyEPPWSCqMagSh8zp/sxhocsoQjZH62vtdBUuXBfCdPjU1nbCodFi8Mi77A59fZ1V+Ny2xfA2DwSXmbOqnMyinoWW2utOIBl9WpIlJcgdNkzjgmTJM5mAgtMfhNpgpDCZQWUvvtDaTDHpadP2t86S8Q==
X-YMail-OSG: NmCHi3IVM1mu7qRRcKEXdz9MjWSENJSZVEF0g9OEO19AImpk4yfWOoa4jFZkZR2
 9.byuH46KrF9Zmt1B3dRwFeIIBLNtAY8f6xmSymSjiUEv3toe8KoMCyEN1YHXJhQSxbEAhr3pPXW
 tNCjGszSHH78kDcQHUVTULRZxwgzkl9nZ0hNNdzJwu7oo4vmM5uUfN5bAtTva.tjlwGROflY2Zjg
 LZuhsiNS5un.yy_LBzJ9cnhvSW_3hEakl6lkyWyMeQV6sfQoDYw9OIwRChb3jnF5gdp76dQuXhyB
 i3E6zrOUUlY7tgYZsnXFhuScEHGYVcO8qOnHos1iK1gq3keYmKJ4BMMGe1wtARGpdpgFQq5pqklv
 UvkkMueDvdHOAWzAGIcIxeiZ1Lrhl5beQEeuwf_8l6bx2JnzB5Zy2N4O4TQaESSFidKHR2X1nV_3
 z7k624nT5s_II1n7r36R0NjrG_ycTWeoS4a8QpyFYxnq95lcX0es2kfLpFfrM1He8qK25NbTO5Y_
 7F3uTpMEbqvWHi9VTJ7_auyGOUFmgvK5VLPGV4paimOvjO8k7BoPyJjDzn4dmzWoOd9u7foKI0Zr
 ys_W0.H2N2MDaNXGQD.4Gxz4CLCU76oDHNwL1eAqEiio8TsTm4cE11oj.ozIxeiXg8O9jZt.y2Xs
 oanEziIhidDbf5_5rZZHUJXdJKNqaZLB0zhpskmZoU_.H9R7TvLF9114JsOLlDkJYpeG.VGbl0LR
 .9nUoUfveleLUU.TnpRkQpt_oid1oNOBsQIeTLDBWTvadHSCHTn09oZ9uT6AOZhufIS5IRDG_dL6
 zmTHRWj8euFPoHWDJVOj8353P5piQnmBt6j4kn0DQkZCkTv9JHOKA0J1Ogeh2qKeIbNsqgyNMKmY
 NTocvOX9gaK8FaN7wyfNXAA6cTU5xViDiW5UOaKP2JYl8kzfKOwW0bLvodmnjDfjJjZ8nUbNmx9J
 mMznmkRbKuYrN8dC4CXA.dx2SjBp0gIWjm38Rn3BCh61dKqB7z2Dxu1YGLbLyviVCIcXiF0yCzuT
 fDOF3Txwn2V9TWCIXluWujSjSdVxAzch4lDcH_FOz87OvU0mvQCibHQxQdt5LvggIBatdfbdA6a9
 0KTY9q6_ig8NomdpaXAInckIsIlYHfrThjJDxkH48n658Mg1zfklOvweb_ofkCD_ZOqVs8S_Rw4o
 SAZnbbUJqu4ex
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:46:59 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7bfda36ec44e7fd17a13267c14302369;
          Fri, 19 Apr 2019 00:46:58 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 15/90] LSM: Use lsm_export in security_kernel_act_as
Date:   Thu, 18 Apr 2019 17:45:02 -0700
Message-Id: <20190419004617.64627-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Convert security_kernel_act_as to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/cred.h     |  3 ++-
 include/linux/security.h |  5 +++--
 kernel/cred.c            | 10 ++++++----
 security/security.c      |  8 ++------
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index ddd45bb74887..023f422eefd6 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -22,6 +22,7 @@
 
 struct cred;
 struct inode;
+struct lsm_export;
 
 /*
  * COW Supplementary groups list
@@ -165,7 +166,7 @@ extern const struct cred *override_creds(const struct cred *);
 extern void revert_creds(const struct cred *);
 extern struct cred *prepare_kernel_cred(struct task_struct *);
 extern int change_create_files_as(struct cred *, struct inode *);
-extern int set_security_override(struct cred *, u32);
+extern int set_security_override(struct cred *, struct lsm_export *);
 extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
diff --git a/include/linux/security.h b/include/linux/security.h
index ea2c6c4e88db..7369cdc3a681 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -378,7 +378,7 @@ void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 void security_cred_getsecid(const struct cred *c, u32 *secid);
-int security_kernel_act_as(struct cred *new, u32 secid);
+int security_kernel_act_as(struct cred *new, struct lsm_export *l);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id);
@@ -961,7 +961,8 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
-static inline int security_kernel_act_as(struct cred *cred, u32 secid)
+static inline int security_kernel_act_as(struct cred *cred,
+					 struct lsm_export *l)
 {
 	return 0;
 }
diff --git a/kernel/cred.c b/kernel/cred.c
index 45d77284aed0..40a3fde22667 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -701,14 +701,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
 /**
  * set_security_override - Set the security ID in a set of credentials
  * @new: The credentials to alter
- * @secid: The LSM security ID to set
+ * @l: The LSM security information to set
  *
  * Set the LSM security ID in a set of credentials so that the subjective
  * security is overridden when an alternative set of credentials is used.
  */
-int set_security_override(struct cred *new, u32 secid)
+int set_security_override(struct cred *new, struct lsm_export *l)
 {
-	return security_kernel_act_as(new, secid);
+	return security_kernel_act_as(new, l);
 }
 EXPORT_SYMBOL(set_security_override);
 
@@ -724,6 +724,7 @@ EXPORT_SYMBOL(set_security_override);
  */
 int set_security_override_from_ctx(struct cred *new, const char *secctx)
 {
+	struct lsm_export le;
 	u32 secid;
 	int ret;
 
@@ -731,7 +732,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
 	if (ret < 0)
 		return ret;
 
-	return set_security_override(new, secid);
+	lsm_export_to_all(&le, secid);
+	return set_security_override(new, &le);
 }
 EXPORT_SYMBOL(set_security_override_from_ctx);
 
diff --git a/security/security.c b/security/security.c
index 1e819ecf26ff..edaaaef54239 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1615,13 +1615,9 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-int security_kernel_act_as(struct cred *new, u32 secid)
+int security_kernel_act_as(struct cred *new, struct lsm_export *l)
 {
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	lsm_export_to_all(&data, secid);
-
-	return call_int_hook(kernel_act_as, 0, new, &data);
+	return call_int_hook(kernel_act_as, 0, new, l);
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
-- 
2.19.1

