Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4269C10F10
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8B320851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PpB2X3RI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfB1WUR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:17 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:46101
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730215AbfB1WUQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392416; bh=+EktEinDsp7sVGtCHwNA5KY/taBeP90CMVznou1rZ5M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PpB2X3RI/7Y1iDPfPMGiBnvKZ9eHZJbxVH/J9npWIjtQTFeT4SR/BdF9fWT1K4Fn0ZnyjByPAfDmg1yXAHJpzL3F7e+sxtUEg8jsreo0m0f7W8k/T3nbWPt3yFyBqgHmGFCIYXJxtsSrsCxKUokIPQwGHAJISPVjJRqYjzJmPlbjW0jtekEta0s7BfxgnZ7ijDk2u/G9Oip85NkdxRr5nCwqRo9axqCjb8k3nwD+0w1BAZYRBfmb+Nm0GvTQgO4XHuMxKvwozuy8upT9YioEzAsjmKCyGZRJz/us4lboPgwa56FjUYWgNmZB/wKqO2i218FF8qyXuZIZYBNxuyabQA==
X-YMail-OSG: vFN__oIVM1kjnhpUPombrDFnsf0bEW0L0n7j_BnyTlSDEAMXIpYRyeq7ifEcXcG
 mXWZhs1t0lhVS8FE.A2WnSVtcNnWvAZghnMaqlaVb5kgXMMJyBFpwvkGukGZBputcllAtyEiuP2O
 y99dDFkDO6DjGtgKab2cZwxV0JPUx.eLh3zE.Z9gYjHbvDncVjma3DHumKNndS3dlDeXcystKZCm
 HDcNQVcqr1NnVlOtWQ4gufr.rpo2sDwvplCOYge_bTYPr31STt3a25FU5maPe.dpiGyr7zD2tabZ
 sFQa__nPONzHRwM4T9YInrHtn2Oy_fHNTrbOxKkm.yySXnRoluFjMJf5po24k4bhoMzsYbybp0li
 _GKPzFCSEHt594TuC1tlFfOm8uC8XQLH1TcRmD6tVo68AGPhopyh1UYrneZ.ziJgAMrPnTWFSV_4
 3z8owynNayGwZbZ8uN7bemD7thZ.K8y1GGcQCzD4lHBivRHfyzum19T35CifRHS5KYIRD7GWrYZU
 pvFjP.HaCZyWRAsAAdAO_j6jposn86QV6I1xkmZPDc2SMG6vHiuH.AEQKIMsew1UUWmiS6cVTmFb
 ses54B0OC2uSdZlP5u.SxqPbxIf9g9XVhVr4Pem6keR4gHI7Fz1gByD5siF6ZdJQy6uAsPHXzxSp
 u.hg3HzuPyifmOqlZEmFNLRcmlnS8LLiegn7T40SqJs1D1oC9BavOsSnl2pt6KIecMGGHdvE66c4
 IlsjYCAo7ykvNARPwjsx9WG_hg4G_7xa7iFcl2SalaRITcl0xICWepPT2E.2G80O_sJv7IYM1n3w
 CkuVFAyQblylKrS1YQdpxvKn6G785SvBjqpBqtKLFe5H1Dzm9TFym7UuVWHA4SggO4nTJs8KKulM
 n1Egxu195Y7ziNhR4lWtEfg6tFWt6jpyBBjGReNE7XLlCtt_Ay2MTHkMYZdCmXkcIeXGeh0Rn2Lj
 esq5VMhE3.et3XjDqkGKVDbdQo.DOvhMDB87taB7VpwfWQJhNk0ci95ePMKRfXjHKSMTFX.xfTBp
 zMEGtoEWbPEHX2sLTW7b.5pbRT6RlcFwFzsNPnG_v2M.gynkt1aI2heKwKP.YxKfmWkvp1Gp63hT
 TErI5N6n8bItnz80N0MGnojGQonBS4bB.8kCPumi6GTpq0Zo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:16 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 51882fbcdd41d0138ebd23ca73a62b12;
          Thu, 28 Feb 2019 22:20:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 50/97] LSM: Use lsm_context in security_inode_notifysecctx
Date:   Thu, 28 Feb 2019 14:18:46 -0800
Message-Id: <20190228221933.2551-51-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_inode_notifysecctx to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/kernfs/inode.c        | 6 ++++--
 fs/nfs/inode.c           | 6 ++++--
 include/linux/security.h | 5 +++--
 security/security.c      | 8 ++------
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 80cebcd94c90..7c5b0d5140c4 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -184,6 +184,7 @@ static inline void set_inode_attr(struct inode *inode, struct iattr *iattr)
 static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 {
 	struct kernfs_iattrs *attrs = kn->iattr;
+	struct lsm_context lc;	/* Scaffolding -Casey */
 
 	inode->i_mode = kn->mode;
 	if (attrs) {
@@ -192,8 +193,9 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 		 * persistent copy in kernfs_node.
 		 */
 		set_inode_attr(inode, &attrs->ia_iattr);
-		security_inode_notifysecctx(inode, attrs->ia_secdata,
-					    attrs->ia_secdata_len);
+		lc.context = attrs->ia_secdata;
+		lc.len = attrs->ia_secdata_len;
+		security_inode_notifysecctx(inode, &lc);
 	}
 
 	if (kernfs_type(kn) == KERNFS_DIR)
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 094775ea0781..f6c339d4e6fb 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -339,14 +339,16 @@ static void nfs_clear_label_invalid(struct inode *inode)
 void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr,
 					struct nfs4_label *label)
 {
+	struct lsm_context lc;	/* Scaffolding -Casey */
 	int error;
 
 	if (label == NULL)
 		return;
 
 	if ((fattr->valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL) && inode->i_security) {
-		error = security_inode_notifysecctx(inode, label->label,
-				label->len);
+		lc.context = label->label;
+		lc.len = label->len;
+		error = security_inode_notifysecctx(inode, &lc);
 		if (error)
 			printk(KERN_ERR "%s() %s %d "
 					"security_inode_notifysecctx() %d\n",
diff --git a/include/linux/security.h b/include/linux/security.h
index 7940a92e8b5c..4194f6b8b97f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -434,7 +434,7 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
-int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
+int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 #else /* CONFIG_SECURITY */
@@ -1218,7 +1218,8 @@ static inline void security_inode_invalidate_secctx(struct inode *inode)
 {
 }
 
-static inline int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static inline int security_inode_notifysecctx(struct inode *inode,
+					      struct lsm_context *cp);
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index a821e0558370..464dee357986 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2012,13 +2012,9 @@ void security_inode_invalidate_secctx(struct inode *inode)
 }
 EXPORT_SYMBOL(security_inode_invalidate_secctx);
 
-int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
 {
-	struct lsm_context lc;
-
-	lc.context = ctx;
-	lc.len = ctxlen;
-	return call_int_hook(inode_notifysecctx, 0, inode, &lc);
+	return call_int_hook(inode_notifysecctx, 0, inode, cp);
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
-- 
2.17.0

