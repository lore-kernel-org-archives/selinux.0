Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB248C28CC3
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36A024CF5
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UJNX5wdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfEaXc3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:32:29 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:45169
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726538AbfEaXc3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559345547; bh=ULSoD1nkXTL2vFKNMUIKbyfgweGG6c5B3nCQi8z/MPE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=UJNX5wdRdtplylp5FAPUAvAxwQgLRbUak2QfpS0fWDi8cIynEQ17nsqwwuMYZusPybx20UuVgs4jkfF/Nm8zqu4ysuTaYwIAeafuguH8Xmpy94BmG92X5qT+yg5RDpYhe77D0iA1TVBaUyBnJBxL4PdN/rCv5HrSarzP5oQYG+NpzEE+6in/+jXOshnbPFf4gZjjI06XYJFGhvvCri9Tkuui+UhH8lla/Yo+rNbH55SbKoq03MzO/2601Tk1p6um6egw96REGKDCUiBZdHBcluhRIeIuKHNFHRGUQArHYhf1oMEUGcbGHA7d++FxRFDSrQz0jGWsCiVrTQlL3XtaTg==
X-YMail-OSG: r2ZZieEVM1ncoxDVuZCfH48cGofhsm_ifkjAOEyROdVpwKBzdKW5D5DkI84RtOz
 nVv0ePw_tTXF9qlNSiEz8zTwolY6fzmw4i3kHfr_1cuREixDfoslCbaNnVpWNyP9kNz6bnMsPx3J
 Sd_D.JBy8yiWXg8aKsAIoh3TDKFNJi8IYSy7UKsDxsLtKhtturw_mhMOsc2Na3W8iBChnBRYSu7M
 QBytnQoZFbl5ixLjtEmcQDpblDU7_EAXXLMQe6wKhALVmp5GVzRE_247IhbHWd.bRn3d90WBwjpC
 1Cvs.bD5peKor.HfGGH2L_OWPmnX2DGX5q99.z7rtLqwcpbt37pkblUJBGo59TDVLypbgmoDKC3r
 jT3Zf9mG8THObY33OePL5jf3g452V_uNgxsq0iXNnlikfQ68spZZK61qh_s3NQvkjhgnD5pA23B_
 nE.TRJ8ru2hVnpdfn4MSAypcFLkD54evo78EAFGPflSWlA.Tqzyeex6c9.Y8oneBvGErkMrIXHve
 TnUxKGFKetBWmDyUDKSUnQWHUgNVqbpP3YLuTWQDtWtS.AfpmLVAFAVJ12cLwFcN9gC8iIu2IJtw
 YBt8u7P9xz21oudnJbqfnjI47b73.Iez4lC07ZEahIrfKCXFWUvdFQpguNJVmU3uzxqEuCvxYjp1
 a.hRMGbxoxniE5RD4tNdhoJ1__AcetRImXLNFXwPEdAL5P2ERySqaHZC1782dGlCwUGq33oz1suR
 jkGVd7Rq9hk919EAkrlzt8sOUwOFxVs8E4c0kSVRbX6PkBKnIslZzsois27EkVZ2WOwBWpTim9R1
 7vkf.44EK4Rx55Xq.MWbNNtsSpXeUg6e7PNU2PdbOPDRDgrq3RZSLzsGPoJraeFQdvRDLGrkWLnQ
 KPahvynXAbLf7mzyBykKmGbbAWHsejda_EXvuOjQNGI_gBOk4jsdXhv0hgdJ5eSKgOksFZpJZvJ_
 I3jBiydfsp_yGqzY2fTOQL32mubLZtr18R_zxJY97A78jJvXR4StPXtjwFIFdB8xfvteGd59FL9A
 BpAY89JP._NHP2I7tw22422Y4ZkJYK5nV9Cyj5DRquY3qhZc1QNoJ6g4rH1xNL7cgC4esbNQgTnl
 IXF1eaxf9dmpbhj.._njaksXPK4YK9BCQLslV07bpctNWSXk_Jo8mgN_g5HCCONn3W55j6T2Cd_e
 f18o4vc5v1xmjWUzw2PWJSWTX_VVo2rj08pLT5LxNyjNiHgRWEhwxzvQxzSHjYwM_OC6m6K_GUIr
 k.MVKrP4Kl3xrmABlRm6E_kH7E94sTbS09ppQyTdXh_6UQYYC_LVqKA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 23:32:27 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ac816fe950c45c4dd9654cd9287f8d35;
          Fri, 31 May 2019 23:32:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 05/58] LSM: Use lsm_export in the inode_getsecid hooks
Date:   Fri, 31 May 2019 16:30:56 -0700
Message-Id: <20190531233149.715-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531233149.715-1-casey@schaufler-ca.com>
References: <20190531233149.715-1-casey@schaufler-ca.com>
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
index 3fe39abccc8f..09573c55e535 100644
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
@@ -1566,7 +1566,7 @@ union security_list_options {
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

