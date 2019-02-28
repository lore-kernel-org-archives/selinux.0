Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA2DC4360F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8AC2184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MN2dlyTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfB1WTz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:55 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:35099
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729381AbfB1WTv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392390; bh=5lhOOJP5rEU4b0w++kZXsVwOzmrbGCMHIx8THL87gxY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=MN2dlyTMuVOTrXlqcpdTdiZfCRj1vxaZpwprVphz8i327YdyoOoJfjphpDC30WTc55eAPIboBvUShg1XFekHkrBi3R22Z3xycsAY7yKidx097/vxJhFBODq8u8SIvzO9Wv9gCJ+PZTVREr0W6/Rgd3Q7SKlvFKlICpVxw4cN0Vn3LapGuCMlzvN6W1sX7pPTIUx/k8ViWvyhKzCBm3Oj3QiZHj5xH34ZAj0spBZVnvUoMiKODljiXf0rGDPdNityAHe3PfosRc/Y+iFKw6FnTJu18NXIUrWXIpaHl8Ct1Q8ShNtvXspBXz2n3dlq3EHBwLoonkCn9kTcrzqPwxa41A==
X-YMail-OSG: snNSUFAVM1n0GaFoKJmV_iV.CmK.BvyoHgJabzUVPY_sZixARIL9cGb0UMmKalT
 CbjMvrFQZSjfhJ36rPSpapw7CDFWWQior9gTDBVf8sbsUos9YFpEhynRPkeL4QIwllAAeiqJeHkU
 TCZN2JJhUnR1yt5Ni9nsFy74Kq.UVxxFSaVKQcT8kRWdXCqIXwKsbEe.w9XT9fH0mYBgJ6MSyb62
 v_vQI7Me1Ur3aD44cOqzb4e6hpXAnDGfqASDgT2czFLLhDX0aEzI2q8qYApcR.Ap7hJY1HsxMkoU
 kMpHoDxOq8.Kr8c56HaJtai509xgcDaJMEJaFPIzU8UwJvasWSeZUhEKbOcDsc7nxX5NQUfVvKAH
 pH4OnJg3hqwuZIpcUlNQ4_Gd3czphevxROcRaOEydoGKQIGNtFHXhLnr_a.gIEGFKBE5HokyCBrE
 3AXUNUH_gHpNg8jlXkLwK7djszIbjcYkmccajWQXAi7.nkQpEH3Ej6TwYs4Eo34ZXOrepICL1vVz
 9lbcto9AMDh3k0NZZtJdNaWGD23lSXzYVYuqUHSCKziACEu39qm3ZgSyVowHa8kNgz5jf04jeYB9
 Zud.t9ZpsASXXm8zTtc1vlJtmRDet_5KBYOWBVnM00kw6XAJXYIVkI8OEH2MssQ4axSURmxCXNmF
 vGwUbgqFR_hwnF3R0nWUJOwMX8NB6bW4Pm7Ftp54zR52Nw5jLH4v9NH7XbE.d_fjC78S7xujm_bB
 MrmXvhIL.GVd08_xElyJB2T.BSCi.VR4p1Q6pucITXNGUuTQ1WqN0XrP9Tv27C0pky2CsXpeH.pn
 Vf7NYiuizJHH_3WRivnMZk6DrWmKspaI5yzJl7hG9wVJMYoK2NiY_Qt.rDTRfPQDUY52IvpiTxiz
 9gfo.juiNIk3fn.svdXRzFzakne8MImm88VFcB3sPR7hPjsAFn6QbgLNscGwuOttl.ZwPC4VsBI3
 t1j43alFzPi.WeaWEu.2Eru7dIX2q.kL_x6c2ZAA9vmJjvyDRVeDf6wFFrtRkl8dBAkBmpB7U32V
 Iv3MZ7IDskqRFwsixePVMJQdEhIE5ujnPdibS7KmpFSl42VvElM2BWbQAsY_c9epreAaNvEtHspw
 PK57vg7Dyuy9eCnRqAEXfPbLXTbPkX7VO0TGgXbLF
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:50 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eca90f2e660dab57d5d3726b0a8f0373;
          Thu, 28 Feb 2019 22:19:46 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 06/97] LSM: Use lsm_export in the inode_getsecid hooks
Date:   Thu, 28 Feb 2019 14:18:02 -0800
Message-Id: <20190228221933.2551-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the inode_getsecid hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_inode_getsecid()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  4 ++--
 include/linux/security.h   |  5 +++++
 security/security.c        | 35 ++++++++++++++++++++++++++++++++++-
 security/selinux/hooks.c   | 21 ++++++++++++++++-----
 security/smack/smack_lsm.c | 13 +++++++++++--
 5 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index f19751dc53be..ff97f57a87bb 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -409,7 +409,7 @@
  * @inode_getsecid:
  *	Get the secid associated with the node.
  *	@inode contains a pointer to the inode.
- *	@secid contains a pointer to the location where result will be saved.
+ *	@data contains a pointer to the location where result will be saved.
  *	In case of failure, @secid will be set to zero.
  * @inode_copy_up:
  *	A file is about to be copied up from lower layer to upper layer of
@@ -1556,7 +1556,7 @@ union security_list_options {
 					int flags);
 	int (*inode_listsecurity)(struct inode *inode, char *buffer,
 					size_t buffer_size);
-	void (*inode_getsecid)(struct inode *inode, u32 *secid);
+	void (*inode_getsecid)(struct inode *inode, struct lsm_export *data);
 	int (*inode_copy_up)(struct dentry *src, struct cred **new);
 	int (*inode_copy_up_xattr)(const char *name);
 
diff --git a/include/linux/security.h b/include/linux/security.h
index a79fe8ef9d84..785d21c81dea 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -85,6 +85,11 @@ struct lsm_export {
 #define LSM_EXPORT_SMACK	0x02
 #define LSM_EXPORT_APPARMOR	0x04
 
+static inline void lsm_export_init(struct lsm_export *l)
+{
+	memset(l, 0, sizeof(*l));
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/security.c b/security/security.c
index 750b1b63edbb..5bee7e0b0bf3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -708,6 +708,36 @@ int lsm_superblock_alloc(struct super_block *sb)
 	RC;							\
 })
 
+/**
+ * lsm_export_secid - pull the useful secid out of a lsm_export
+ * @data: the containing data structure
+ * @secid: where to put the one that matters.
+ *
+ * Shim that will disappear when all lsm_export conversions are done.
+ */
+static inline void lsm_export_secid(struct lsm_export *data, u32 *secid)
+{
+	switch (data->flags) {
+	case LSM_EXPORT_NONE:
+		*secid = 0;
+		break;
+	case LSM_EXPORT_SELINUX:
+		*secid = data->selinux;
+		break;
+	case LSM_EXPORT_SMACK:
+		*secid = data->smack;
+		break;
+	case LSM_EXPORT_APPARMOR:
+		*secid = data->apparmor;
+		break;
+	default:
+		pr_warn("%s flags=0x%u - not a valid set\n", __func__,
+			data->flags);
+		*secid = 0;
+		break;
+	}
+}
+
 /* Security operations */
 
 int security_binder_set_context_mgr(struct task_struct *mgr)
@@ -1375,7 +1405,10 @@ EXPORT_SYMBOL(security_inode_listsecurity);
 
 void security_inode_getsecid(struct inode *inode, u32 *secid)
 {
-	call_void_hook(inode_getsecid, inode, secid);
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+
+	call_void_hook(inode_getsecid, inode, &data);
+	lsm_export_secid(&data, secid);
 }
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 54b8a42ed3a3..cbf7bf3fa4af 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -211,6 +211,15 @@ static void cred_init_security(void)
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
 }
 
+/*
+ * Set the SELinux secid in an lsm_export structure
+ */
+static inline void selinux_export_secid(struct lsm_export *l, u32 secid)
+{
+	l->selinux = secid;
+	l->flags |= LSM_EXPORT_SELINUX;
+}
+
 /*
  * get the security ID of a set of credentials
  */
@@ -3212,15 +3221,16 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
 	return len;
 }
 
-static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
+static void selinux_inode_getsecid(struct inode *inode, struct lsm_export *l)
 {
 	struct inode_security_struct *isec = inode_security_novalidate(inode);
-	*secid = isec->sid;
+
+	selinux_export_secid(l, isec->sid);
 }
 
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 {
-	u32 sid;
+	struct lsm_export l;
 	struct task_security_struct *tsec;
 	struct cred *new_creds = *new;
 
@@ -3232,8 +3242,9 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 
 	tsec = selinux_cred(new_creds);
 	/* Get label from overlay inode and set it in create_sid */
-	selinux_inode_getsecid(d_inode(src), &sid);
-	tsec->create_sid = sid;
+	lsm_export_init(&l);
+	selinux_inode_getsecid(d_inode(src), &l);
+	tsec->create_sid = l.selinux;
 	*new = new_creds;
 	return 0;
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index d748c709f31a..a9277a942ca2 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -464,6 +464,15 @@ static int smk_ptrace_rule_check(struct task_struct *tracer,
 	return rc;
 }
 
+/*
+ * Set the Smack secid in an lsm_export structure
+ */
+static inline void smack_export_secid(struct lsm_export *l, u32 secid)
+{
+	l->smack = secid;
+	l->flags |= LSM_EXPORT_SMACK;
+}
+
 /*
  * LSM hooks.
  * We he, that is fun!
@@ -1394,11 +1403,11 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
  * @inode: inode to extract the info from
  * @secid: where result will be saved
  */
-static void smack_inode_getsecid(struct inode *inode, u32 *secid)
+static void smack_inode_getsecid(struct inode *inode, struct lsm_export *l)
 {
 	struct smack_known *skp = smk_of_inode(inode);
 
-	*secid = skp->smk_secid;
+	smack_export_secid(l, skp->smk_secid);
 }
 
 /*
-- 
2.17.0

