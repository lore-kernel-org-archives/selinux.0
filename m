Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32A3C282DC
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9BA27982
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="i2L55iVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfFBQv1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:51:27 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:42575
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726879AbfFBQv1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494285; bh=ULSoD1nkXTL2vFKNMUIKbyfgweGG6c5B3nCQi8z/MPE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=i2L55iVl7Nj9e5x8Yj9opZRK8MABXRM9jm9YQKDvcThhMxzSA63Rvr2Xoi39up5QQ+Ccf1ZdOW662cGPsEkAXo6vWc2Cn82XW19XWi52LjoIfglAUHnq04oPzC0fdhrht7dKh+QAEcl1vL3k9X9iAF8hUGFpccKpr2bGtI3S9HIuaafH2XlQBvJCF9a+HB1xDnMhHddYp9Rgr0JMxTSb6yGptsC9fTVGLpLoZL15TD2wi8zES1ZTtTZ6G/b9eSk9d0FrVbXSpbXlofxzYaeiCJSwxcD0619QBHIo0hdW7+f9gKEDmiFRRpupKtwd22zyRDLnpN13HkZfj/vbShM5YA==
X-YMail-OSG: MDv9RtoVM1kDd1Y1IaBiu46LIt6WMAnJV4WX6wvXQ1xQB0fkfXLTBq8.EXSbrnv
 .l0Z.PJXLrZhCxLSqXj4k5bo3U0Jih15N7.GIfTd4UsfYPc9r1R9SiB1HTozAikZ5ByXnIF3aWbQ
 CmfFoPHtXUQSbEu03hGkqnliY9TKZVGE69mAfKI7wv3yq9Zm3FmluTUuv44x0q8WVVDXdTIwCuaa
 EXhD79L9UH3blZwn2RvnmpuVrckTquVifFSgVZuPKyTUUAx93ib.3W7C9VU7OqvFAn.TGXVf2Dzq
 9FR5iA.oc2JUwkM8rFMQJ1blDOpeD8Zc7HA4Qotl2DmU_9M7tqS_l9XKW6fQ501IstStUzRnRF6S
 4_uJ7kwfneHDqYEwTiBEdcUskbH31PnITz7OkyiIhf.sYHzRsSkJE4SODmpeb86y8Gjog5hP8ZmJ
 ygv1A_oLC72V3XR0oyMro4reBSHCOwPUIwgXFqar3lA_QfNvsYyBe.YcDCiJXtLT8kbiTgbljiFZ
 1D9ajW9LvqQYgbeVJR04CtmwyPBiKX5Kad1lqg52YuAPrlpBFPOvApcRVTSW29P_gmHmqtDCmZrZ
 u4DXIdLvzaDuf6gs4K9emPaHWVt3MscocZxLboXH7tTEUeUBUnOu12uMBW83sXtcsu_Ou5WEdYyE
 Czzhk81Rw7kjr_Y7FqfciF1g7MOs_EizGyoj_DT7PQlRP2IYV16ozwLx8_JEn_h_ifXYfUoJuzAn
 CSWCOFMxyDPIYjPHfM8D44WakHcDbR482x0OBUibdH.2dGdPJzZyUhPJVgMM2nZhCHk5qEvezrpv
 Lr2keFFqSR0mPhnWXzvr7wRaMRHXYYyPvQo.cw0VwoDBwxPgC0KpP9E2ANAMvQEmZU460LyDuqSK
 NWI2MDvBxFjW2mfJygVtFanRkn3cUksIxFKCDoO8WeR3b1Jcl7tQK0ESA.rnuzvNc_iTHHmGg4J8
 zz17W7OlFh4E9fnltreCdNCJAR9WRWRMsoKOzOrQoA2c9zRrnxUtzQb08GgFNUSyLqHE0pL3Etli
 Pq_vvYnjcey6YGjHY1Aj41NmBluAS.H5EpssLwLdmOnAqzoqjnXSF2ZAAT7rm608u32lJzm5ORIq
 vp2dH2nTSiPY9uQ0mJ3pNxuiiezUYKQgdghFdKGebxtYwH5xfUKytDh4St_B3hX0seMCfO7XJ0rZ
 ce4zZGEwFyX52s5uwIhtvFffpzFNxhW1OMuhA012nueCN5bFIgBxnuI1THbsURpCt9CMSJKA1Jk1
 wJYmC3l1dxORZF.BQbR276_uLmIOsFtpC9HQ7ff5eqg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:51:25 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp429.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eaaddcf00ddf2fd5d1fdcb38c64db575;
          Sun, 02 Jun 2019 16:51:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 05/58] LSM: Use lsm_export in the inode_getsecid hooks
Date:   Sun,  2 Jun 2019 09:50:08 -0700
Message-Id: <20190602165101.25079-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

