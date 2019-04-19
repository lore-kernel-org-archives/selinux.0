Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF67C282DD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D61A21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uPIQjpm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDSAqj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:46:39 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:39068 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbfDSAqj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634797; bh=NZEtztwTT91pajlXg+jbP5POdRvcqe1ikLbatbSvXaQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=uPIQjpm50yOW3wPvqNqpSxs8u7lMCFG08Cz051E9jPBqfSoJXjytpYBB1RfIMaSfbi4GVbUJRxBm8yFEA53k1HWt/XpfO6bdmWZZS6xxrMkVdFL7u+pvPqsbXfi04m5tq6p0P2n40R0yKw+GfdnknxZHe4vG8bf4e97P4l66OqzMDEfimjSx94yLpbbGG/G4kgXHS6xJLX5Y2idPnNxirfk5S70KpEWy7PCEEeSuVLA7gfjgszZXUvoORQKoS0hDMXFVC8ag/j5E7WBlIGpucJJUJpVQiKrsZu6tdNfHxB4tRGHhk2AJM3+wL3/k40EyGey4eXNdpqrSLe43tbv+3A==
X-YMail-OSG: 12p.1xEVM1lzCnvL1jkLqELHtBj.EJAJYGilsHsdx22GXMfncas93_x5kbTXe3G
 Aswzk_Er6nEp15PV1H8bDMmbqezFjem4VqJYr1hFRQBsmbJ.oZK7zF1j8fXNLPikPCtukoCYaaa6
 XEDDb88SNGHiivJVMjknJDMlfzmE2n13QW_K4bd3gsBG250g_IhzIgzjXqdMD0u0nIl9MQb_VDpk
 NeUoXuM2IxSbNd7hidsOz3A50T.TB5WkQgHWjiSwX3Wn8IqQ9vjkDEE.Fno_IFv4F0IZXYCxlvOF
 nQupWI28tFzcPcExt3Wit0eUkEC6Aov9C9QjenOET7ZLNl6jLlQB.u8dh9IMNXCca_LESCTLq87_
 Ds.ZBjQB1CkC9EQO58EKClnqo5Ny4b9xh.8d.6AXb.hvvMgyZ4HgEUtR7xDiRllVHfpNcQiyttuW
 TMFvfQtidFSNOVHSNtJkZlr9B9dl0UOHizBj88OqXMh6CvPnb9L47zTtBWftvdJOYItMNZihJItW
 C0Dvr7bWqMF6FTuHusK6qbXT8wks7pYM48Ia.z4jUY9Dr2mtMEqRYoVwIajxBMsn.s4.3zXuW8_p
 ukFlY5tbUvyNXnKGqLedoTyn8D7kRqQl6uRUlDvOekboO.5USzWgFW5Lg2UoYqFlns0tTb0Qkazi
 N7sO0Gw1sLNA2o1v8nvcgzVKCISHL.xDZ7ALRtfr.BJ2rBHntFeg_6BK.zLJRvOIL7XvMGPVuG44
 FwmK7YEPdpHz1DgBAOnsqfFKiOmWZtHkYxSzWP_rCGmYdf8_AEeyt.ywus6EyseVrtd_IdOI2Ls4
 L93Ub.1DRBkX_JnrUPXpmcRw7ufl3kCm7tGckUb434poKjpXfSNYO4lL30Ip3aovZrndKh.kJWOV
 8UMKkumI3190bhIo7C8HCBIa1da3Yw_hzRCjQb2QwURnFz.ps6TLLxP79QctLxf88nTFKRm9b8lG
 39prO4M_7JV3xxetDXRmhaJKBecCjigq1iHLzXXcEoK4Xlb4p5C88uz6IjgXCJOYocvLTm8EjRfX
 WlAo8Uz6_C09NJO_BUFxjBvYR97iw5n9C53ttk.hMGpcAESy_Ar_k6qEtW3PKSAQ6gYVOziXM1bX
 RsnQ4RNG9FpZLLaLG5wqWHIndPtIPG2WaaH_LsMxtjRzH0CUAWgQIf46qRRE0u7Xg18JxfwXRr0H
 zlm5OiiI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:46:37 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 832c03259c9605aacd6ad56a0995a740;
          Fri, 19 Apr 2019 00:46:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 05/90] LSM: Use lsm_export in the inode_getsecid hooks
Date:   Thu, 18 Apr 2019 17:44:52 -0700
Message-Id: <20190419004617.64627-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

