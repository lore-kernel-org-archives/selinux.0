Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0969CC10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3352082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="H9/33EOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfDIVl3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:29 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:36598
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726572AbfDIVlZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846080; bh=+g7G/wVBjyt3VCLj1TPz1dLjB4cw24g67qHyiWgofvg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=H9/33EObte0TyETBwf+CNYvi3Q9AQRW3e1nYiWgtr7M9RF3wdQOyBphZUUKijRUOMQ+l/DKBNu/sz8OLqwCvM9GdThL9v8hVm/+/1IgCdk1hPARgTIvTZYpGR7Bwi3cEogKsQfVp1cVmJ+RG4L0o7QuVZpEFKSC1XIastr7v2E89LDjOnFL+7pxW6EVdpR+tR2q525Ds848ww4xGsVHj1R2XEjl4nugCFVPM2gh37lazQLqRtVffK4ekRQ2GZeZ/uvdg6znLjzcVoVLEC2wZZe7JMXUQZCQPv89bXfwNNX0bBgqpS/qO0mAnYCw42NaofOvioaoVFldS16YTgsNkUA==
X-YMail-OSG: nJqm5swVM1llEnPb8xnDgu1jf3bL3EkfYsS_E.mOFKNxtnawwEg8Pg7n3Z85VI1
 kMB7D1SaS7b5oy8yoZ0HCbT1.2KmzM1dIuOCsSKB3E0BHqaivT4xvCKiA_OEwnVeWOupG69m8jUt
 St.f5CghM..f296Fm7xcmmr.oPs1ArZO5xJLDXzTFtDayXaQB8Z7NAzaprrjs8zybvHD4LMCMbrq
 sbutDZm0Y8kHfHbqop_Jo4U0XxnI8OfVhcJzlqY_UMyfhIzf31dnSwhceqJRZ8iNRp6DlcaE5.Hv
 L4wq7ZMtd47myzrW8Cv1kmuwFtoWCYtzj_zAphpoXHoOk62Ipb.OHGRiwmiDDx9pT5M018pa5Zg7
 9aIsbmu0VrfpKwhooXaQrjIDtHFRQawxzF56OgXNBtcTtI84gxj8t0nISnnoYrGUQN6mmzGWxvga
 L8OM8t_ISVKp6NZ.URsaZA3yY3LOD4jIiXHyQqMI6vUf.af7eWwcRcanKCWQqBgiaOE0isG5PDx6
 MdIuFFdRrFW5SXkahO11ApyivIFOeDJE2e3eAF6fjj5m.ctDpL88nPuIZagcomX6AipAkAimwFWg
 Hg_Ha1AxmMOOW2re_b5FiKDyuFDRg3qcmdmOZglNN35.xo5B2OghDy_7v01gTKzkNRfseb5WpQ7B
 DEi_N9gXL_a2i_EkNyPl2UG1E50_tIWUfRLU2iU_wsaeLKANLq5wsFMAuY3ylP2C8kgCluP9MoJA
 pVnvWS..yZhINaOJujtrh10LtLtNOmbnOqoU7w1b7EwhxjnRH.bvfHtYCTsnwoVN.n5HJlzLVywz
 Y.VHv8J7lmBtjhQQBqMiDeEchGtw6irG3yOkTo_l9hEIMNU47zpB641Edq69_oLDFsv_vp9biDhK
 .Ta7MKeOW6HdJUVprBLOheur3PB3TPLybjhda2d6dylJXykzbbjPwRas54VqFeS7QZgt24NGeqWW
 uTaAR5rl0_duubn3r8BlmVycoP4Q534BWrK4RXGlSRvUvAEunEJREjRQhLxwxhtmJCVx_9ERsxNZ
 8bEoDWW4ctUahQTTRBzZ7es3GBKwKlBli9RXbxpieSPDNQfgQORdtgVnA5sifOoJfN._FVcCXHBb
 zXOi_VqhBMQs_MXgGYYuSseLfAk7GiBVf8_ymHyel4CexOSc_KPyuw9dm6cCECQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:20 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp424.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ef161db9af8fc10234759f56f4c7a0ea;
          Tue, 09 Apr 2019 21:41:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 51/59] LSM: Add the release function to the lsm_context
Date:   Tue,  9 Apr 2019 14:39:38 -0700
Message-Id: <20190409213946.1667-52-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In order to ensure that the release function for a
lsm_context matches the LSM that allocated it an element
is added to the lsm_context structure to contain a
pointer to it. This function is called in security_release_secctx
instead of relying on a value in a hook list.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  6 ------
 include/linux/security.h   |  1 +
 security/apparmor/lsm.c    |  1 -
 security/apparmor/secid.c  | 11 ++++++-----
 security/security.c        |  5 ++++-
 security/selinux/hooks.c   | 14 ++++++++------
 security/smack/smack_lsm.c | 16 ++++++++--------
 7 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 11bfa0a4f188..1d364e211639 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1329,10 +1329,6 @@
  *	@cp contains the security context.
  *	@l contains the pointer to the generated security data.
  *
- * @release_secctx:
- *	Release the security context.
- *	@secdata contains the security context.
- *
  * Security hooks for Audit
  *
  * @audit_rule_init:
@@ -1670,7 +1666,6 @@ union security_list_options {
 	int (*secid_to_secctx)(struct lsm_export *l, struct lsm_context *cp);
 	int (*secctx_to_secid)(const struct lsm_context *cp,
 				struct lsm_export *l);
-	void (*release_secctx)(struct lsm_context *cp);
 
 	void (*inode_invalidate_secctx)(struct inode *inode);
 	int (*inode_notifysecctx)(struct inode *inode, struct lsm_context *cp);
@@ -1947,7 +1942,6 @@ struct security_hook_heads {
 	struct hlist_head ismaclabel;
 	struct hlist_head secid_to_secctx;
 	struct hlist_head secctx_to_secid;
-	struct hlist_head release_secctx;
 	struct hlist_head inode_invalidate_secctx;
 	struct hlist_head inode_notifysecctx;
 	struct hlist_head inode_setsecctx;
diff --git a/include/linux/security.h b/include/linux/security.h
index 0ec12fce69e2..76681aca95cb 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -124,6 +124,7 @@ extern struct lsm_export *lsm_export_skb(struct sk_buff *skb);
 struct lsm_context {
 	char	*context;
 	u32	len;
+	void	(*release)(struct lsm_context *cp); /* frees .context */
 };
 
 static inline void lsm_context_init(struct lsm_context *cp)
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 76c409737370..771b0ae24a5f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1225,7 +1225,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(secid_to_secctx, apparmor_secid_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, apparmor_secctx_to_secid),
-	LSM_HOOK_INIT(release_secctx, apparmor_release_secctx),
 };
 
 /*
diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
index 9dc17903a936..30fd4ad80948 100644
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -81,6 +81,11 @@ static inline void aa_export_secid(struct lsm_export *l, u32 secid)
 	l->apparmor = secid;
 }
 
+void apparmor_release_secctx(struct lsm_context *cp)
+{
+	kfree(cp->context);
+}
+
 int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 {
 	/* TODO: cache secctx and ref count so we don't have to recreate */
@@ -105,6 +110,7 @@ int apparmor_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 		return -ENOMEM;
 
 	cp->len = len;
+	cp->release = apparmor_release_secctx;
 
 	return 0;
 }
@@ -122,11 +128,6 @@ int apparmor_secctx_to_secid(const struct lsm_context *cp, struct lsm_export *l)
 	return 0;
 }
 
-void apparmor_release_secctx(struct lsm_context *cp)
-{
-	kfree(cp->context);
-}
-
 /**
  * aa_alloc_secid - allocate a new secid for a profile
  * @label: the label to allocate a secid for
diff --git a/security/security.c b/security/security.c
index 7cc2ec984b7d..8bb1be7f2b85 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2002,7 +2002,10 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(struct lsm_context *cp)
 {
-	call_one_void_hook(release_secctx, cp);
+	if (WARN_ON(cp->release == NULL))
+		return;
+	cp->release(cp);
+	lsm_context_init(cp);
 }
 EXPORT_SYMBOL(security_release_secctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7bf73493d10d..0e347a26c3d8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2812,6 +2812,11 @@ static void selinux_inode_free_security(struct inode *inode)
 	inode_free_security(inode);
 }
 
+static void selinux_release_secctx(struct lsm_context *cp)
+{
+	kfree(cp->context);
+}
+
 static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 					const struct qstr *name,
 					struct lsm_context *cp)
@@ -2826,6 +2831,7 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 	if (rc)
 		return rc;
 
+	cp->release = selinux_release_secctx;
 	return security_sid_to_context(&selinux_state, newsid, &cp->context,
 				       &cp->len);
 }
@@ -6306,6 +6312,7 @@ static int selinux_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 	u32 secid;
 
 	selinux_import_secid(l, &secid);
+	cp->release = selinux_release_secctx;
 	if (l->flags & LSM_EXPORT_LENGTH)
 		return security_sid_to_context(&selinux_state, secid,
 					       NULL, &cp->len);
@@ -6325,11 +6332,6 @@ static int selinux_secctx_to_secid(const struct lsm_context *cp,
 	return rc;
 }
 
-static void selinux_release_secctx(struct lsm_context *cp)
-{
-	kfree(cp->context);
-}
-
 static void selinux_inode_invalidate_secctx(struct inode *inode)
 {
 	struct inode_security_struct *isec = selinux_inode(inode);
@@ -6367,6 +6369,7 @@ static int selinux_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 	if (len < 0)
 		return len;
 	cp->len = len;
+	cp->release = selinux_release_secctx;
 	return 0;
 }
 #ifdef CONFIG_KEYS
@@ -6781,7 +6784,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ismaclabel, selinux_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, selinux_secctx_to_secid),
-	LSM_HOOK_INIT(release_secctx, selinux_release_secctx),
 	LSM_HOOK_INIT(inode_invalidate_secctx, selinux_inode_invalidate_secctx),
 	LSM_HOOK_INIT(inode_notifysecctx, selinux_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1b5b3e421bff..e00346799cdf 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4425,6 +4425,12 @@ static int smack_ismaclabel(const char *name)
 	return (strcmp(name, XATTR_SMACK_SUFFIX) == 0);
 }
 
+/*
+ * The smack_release_secctx hook does nothing
+ */
+static void smack_release_secctx(struct lsm_context *cp)
+{
+}
 
 /**
  * smack_secid_to_secctx - return the smack label for a secid
@@ -4444,6 +4450,7 @@ static int smack_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 
 	cp->context = (l->flags & LSM_EXPORT_LENGTH) ? NULL : skp->smk_known;
 	cp->len = strlen(skp->smk_known);
+	cp->release = smack_release_secctx;
 	return 0;
 }
 
@@ -4467,13 +4474,6 @@ static int smack_secctx_to_secid(const struct lsm_context *cp,
 	return 0;
 }
 
-/*
- * The smack_release_secctx hook does nothing
- */
-static void smack_release_secctx(struct lsm_context *cp)
-{
-}
-
 static int smack_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
 {
 	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, cp->context,
@@ -4491,6 +4491,7 @@ static int smack_inode_getsecctx(struct inode *inode, struct lsm_context *cp)
 
 	cp->context = skp->smk_known;
 	cp->len = strlen(skp->smk_known);
+	cp->release = smack_release_secctx;
 	return 0;
 }
 
@@ -4713,7 +4714,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ismaclabel, smack_ismaclabel),
 	LSM_HOOK_INIT(secid_to_secctx, smack_secid_to_secctx),
 	LSM_HOOK_INIT(secctx_to_secid, smack_secctx_to_secid),
-	LSM_HOOK_INIT(release_secctx, smack_release_secctx),
 	LSM_HOOK_INIT(inode_notifysecctx, smack_inode_notifysecctx),
 	LSM_HOOK_INIT(inode_setsecctx, smack_inode_setsecctx),
 	LSM_HOOK_INIT(inode_getsecctx, smack_inode_getsecctx),
-- 
2.19.1

