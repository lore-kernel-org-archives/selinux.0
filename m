Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2980EC282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E786120833
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="e6wjoGMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfDIT7s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:59:48 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:35803
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726599AbfDIT7s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554839986; bh=NZEtztwTT91pajlXg+jbP5POdRvcqe1ikLbatbSvXaQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=e6wjoGMODdkftXe0aFkB4HRdmRm2QXXV3qhAwncFzkaa6jwZsVIQ1i+teSCQo9Ry6s3kSlnDXmEUG8JAM7LtCBsiTuxYT2PpppjswJSNrRMUxa4yIolUvyc74v9DGcS4j4AicB1nAU//41Oj4CO+ydwb6xVd37Jti23Y2pwKVBFffGi/1Kbugh7W8I8YSJ4tJ54uXaHW1rJkn9HihF46JJCkTZGV928uXIpgFut7r+oMdcCa7GK+rAmwVcu2BcITDq976iaotHJbSzERgRF3UFBFJQTyLvHLe3y232Lz7tWxJePCfN/GBaKpFETZI8o3HMA8dHIMxzzvGKYBluVROQ==
X-YMail-OSG: rZUMTSMVM1kAqeuaOU9jBPM2otlyfdErKX5E0xTNEiSiZIRKx_7B7B.UTVtzOFH
 4B7bREgoItGlnCUWgckRXalnRCyAZcMA2LeA_0gJfFQtGdl.sqn8O.un28oDDKsyKHdpIvHvhywA
 gG4oRqaeKORaGb1szW22s9sb3LFL1KafpAbC80N8S78rGapPl5Ya3g4.mYAtyWka0KEbtWRhGHY5
 ghwCLONTz0fmLKybrTJYgT2j8NsdYq9tIQgwVbhZmhpXqemIOAjzobMQI0r93R6cDlo2J4frO7L0
 3UJtliHMTxLyEJytNTl_Sa.CktBiBBneg0fzEZpw_b3Rc47bR4mNT48CAG_lHTt8jzaPjHDrWjnv
 9cwJtB_z.Tj404.uNd3XElMnqRRhX30w3KvLKOySE5GeLKZFeRZUs1tZPHRxxKoK8RwO3alE53Ec
 3.2U7sgZbq.xB4FFK695_W_FiF0UVkUsztxnivLi3SDnqUwzZf9.ug9rUiVNaGN5XOlOM5NeBtpN
 5rd3tYdDXXXs25ZWahpFmAk7CXk.k_lK8XXKo1FmIULDmvRXLwF7veFfNE4.PMGFiPc0Z6IuOHYl
 yr8DZv9_NLCdzE23i7qTglqdXfJa5et5QH0tGDyMHv.A.1rGkzt1ln9hRev51tKaEUx6wpBsLa08
 a4X.4ZjNXYv1hsQXSCYrt4Orw61XUbinfIsIULelRRrizsKYsrGWwO74Qf7pYY4kwX4rhVf2Snwr
 3wQENSYokydftaYjoTagK2XaFaNgrWVrk9c35byx4c_yl2aYGn5PloRWPga8e4Hfd9UpzczM6p4L
 mDJaLklS6fZVnGatUDF196xK_ldGdL8_lLA8iBvn4qLYmIIeC_N_34GWq6x1Tf_fjMdAZQIshueC
 .YUCsAiW0YfzzYR_y3TcJ9_fBqf_BL9IGaCRyHNxkGA10XrYsYz0Vv9uCFcLZmDgCrLuFl0dYdf4
 qrFKNWhpk99YhGk4DFaFDPyAJMQ7nbchoG6FOTFRuYr4SuANLz0rn2yf4e4czo_8lSJ4drj.mhDo
 2DoGkqWknU_.CrVSQ_XsbSPr.jqbBbeqtKzuphOIKnclkEWN_jW82GuI9CixaHoEsZp4T7cPAZZQ
 g_Y0YQmrqp96Eieu7sckJd4oQn34uDfmMGyVRIH0dHO5QJtGg03C1Zx1_ceyg
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:59:46 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 353dc739e5c49befbce16148938a824a;
          Tue, 09 Apr 2019 19:59:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 05/59] LSM: Use lsm_export in the inode_getsecid hooks
Date:   Tue,  9 Apr 2019 12:58:30 -0700
Message-Id: <20190409195924.1509-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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
index 9e3d593a1ec3..baeb83ef487d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -425,7 +425,7 @@
  * @inode_getsecid:
  *	Get the secid associated with the node.
  *	@inode contains a pointer to the inode.
- *	@secid contains a pointer to the location where result will be saved.
+ *	@data contains a pointer to the location where result will be saved.
  *	In case of failure, @secid will be set to zero.
  * @inode_copy_up:
  *	A file is about to be copied up from lower layer to upper layer of
@@ -1574,7 +1574,7 @@ union security_list_options {
 					int flags);
 	int (*inode_listsecurity)(struct inode *inode, char *buffer,
 					size_t buffer_size);
-	void (*inode_getsecid)(struct inode *inode, u32 *secid);
+	void (*inode_getsecid)(struct inode *inode, struct lsm_export *data);
 	int (*inode_copy_up)(struct dentry *src, struct cred **new);
 	int (*inode_copy_up_xattr)(const char *name);
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 81f9f79f9a1e..fb19f41d630b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -88,6 +88,11 @@ struct lsm_export {
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
index d05f00a40e82..a1f28a5e582b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -712,6 +712,36 @@ int lsm_superblock_alloc(struct super_block *sb)
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
@@ -1389,7 +1419,10 @@ EXPORT_SYMBOL(security_inode_listsecurity);
 
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
index ee840fecfebb..0e31be22d9bb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -213,6 +213,15 @@ static void cred_init_security(void)
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
@@ -3316,15 +3325,16 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
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
 
@@ -3336,8 +3346,9 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 
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
index e9560b078efe..5e345122ccb1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -466,6 +466,15 @@ static int smk_ptrace_rule_check(struct task_struct *tracer,
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
@@ -1481,11 +1490,11 @@ static int smack_inode_listsecurity(struct inode *inode, char *buffer,
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
2.19.1

