Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47FAC28CC2
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7184826FE1
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MxnRULla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfEaXLK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:11:10 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:35527
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbfEaXLK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344269; bh=ULSoD1nkXTL2vFKNMUIKbyfgweGG6c5B3nCQi8z/MPE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=MxnRULlan8CQMpkKkS3tXEuzno/G3lkoNaGIdABEAMH5I3sF4Qe1Z9vR+oT9AUBWZM69IYzT2YvZdfEKHsHTnCTns309v0BmLHH29j+CthfPToyR2LcHhKnQV/JksREQ1zouqQPr3J2u74PNVuVmDe73CwZ67dhQhNju1scmGrqaFAIsaoObbxHJZm1ZR+gpliwC7J5zC7vW+mOS0rB1gjsU1BCM61IM8XobeGn/geNQchLPSKhM1Jw1cCCmlpweimHsAEHW42m4ayelskavbm/X7XwxPByuO5ZtLUfuEDQrCtB20snD1CE5LM9ZxmakTDKHOrtjPxeCzxlBUyHIrg==
X-YMail-OSG: Cz3DC30VM1lsjuPUeP8T6_CCbhBGifOUi35wBT0oK2p.QWtDH4utJWEfSzKzQBc
 UxCziig4MwSkegImG4eLjrUOkBEOaLeU8W00_3zIS4WoyjjGitQAIjFULJkazfQCxyM29dscEUb2
 d8BQvJpomCXsB8gdjTohBOIvVSBBGxSSoGZy7bi09mio5F503amw4zIgUnzPXJbhZhMrj0OTHuNb
 NGEug1BM4Qm7bypIfEFdJd1ZQTwrWH9unsV_2ZnBZBB.SO0L03h._8VTWsiNLdnvrkOBgtWmS.OS
 JxlqqRPY0WjgThO5Ce_0oMoGmcdeuSgdJcezDkV7hB3BF3yYYbW3Rab24ceM2D6guU45R8EOh0E8
 6NC4SNdw4z15ZM4wyjPdQqnccb7h2OkGqB60mhRGnOQTTwbAEMdwHpJpI4AbGsPd7OEwpWUoUNTP
 IRdnKDQmzbQdr1hslb3XWbBwIKyrkFjygp9lt0p6YYOVD6yLGZVaxn74nRBYdMLI3qBXPjkEIV6e
 dG4OVRVyDctWcMC6c9SbYkffAKJNeZvQ.ABtgHsW3_HXZdqK.gz4uOE2bxGRsj5.WYeWAMxycTiz
 CRaZfNNt6qR0kHTCXlcEcF_O51eEWSwkPzSt8E3t5kCZKrSY9tiKXtVAxxbAADPX_6XJwsBOzKVk
 QxCB8.Dj_8N1CXxDmYY.zVLjzGjUiSM5Mcl09PLdpgmZjcH.NZGx9CZ_N5UJhHJEVOF9uTuSrOtn
 52b.7v5vNKv4ZnAkEqiu_9jPeLSZfkGfL8CDA0149sxqSYhaTNyeUGWWUU20OoqMDc7JFdSui.bg
 W3Cr20_XWEzJEbfZRD6rvKa7IlYaVXgC4L8.4ans1iuVUUjWWamfZzUgtgTRZ2PXv4BJGe55EZ9O
 rs9PsJAMFg1LuhBHksuYx_wOAB84MSMx8Wb__9DEJgR8E_t0nZY80vCnHD5Yhj2VpjIjEywALB_p
 KOQtnBjen5FM7Q7_3TUZb74w8dMMga5wu2SCRwkLrikCPECq2R.hz7idXz52g_sq.CucGQ4kDYbZ
 AT1U9p9lWR2U3A02HhvWQJqsKP3EjsW0bzGzIB6d_aF9Jq60RLDPIKSMM_3H8CtfP09UQ30_Tput
 Ud_tAPNP7SVXn7Oe7I3WfuKxIVw9kWX4OJ3b7XKs9vjL5EuBnfnpXp8h8llVm8ybfWXA.eyoJ70p
 VZMwp_wLYR4gAc0Mc49sXOKdmm19C_Xn8xS4da2GYQ1jLqm_NOOsKOSj61Qe1WRLTfgzR047RqVn
 XM0cdGg2w9ke2ouTbAUrXPesA9wyLci5pw5YQKsZ4Dj97iDspBUfnZQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 31 May 2019 23:11:09 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp417.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 05c923e95feac0af6c979bf599e1c80d;
          Fri, 31 May 2019 23:11:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 05/58] LSM: Use lsm_export in the inode_getsecid hooks
Date:   Fri, 31 May 2019 16:09:27 -0700
Message-Id: <20190531231020.628-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

