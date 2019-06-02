Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570CCC46460
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4112794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aXydkOVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfFBQxm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:53:42 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:41640
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727049AbfFBQxm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494421; bh=xbxrTtPDT+RT3HxgpjUjOefKGXANltzkYYing08uaXc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=aXydkOVN9WenKQAFSgTGy+Pm59RXfJtAH6P0Ny5IViBe00h+hQdLKXGtk5tpSE2qtmVuOB2X6jPbI5rLDwSjA5hHXKoe5wCPOxrPRmbbsMlU8yzHgPsMZCWgliBgPbuVXhBbbG8hqS3CQ1ScKW/WSLB5Dd5SHY1D5GIVkIG1LByLV3m2G7r52EVZ5KpK5PvQlNUfNoJTvXhGeD9TfgkoTAo71sTZw+RBbI+qWmffO1IKz2DzLfvbZdROBkph+Y1c0mBSDOcBl0eSZmYNazbxRihNEUnUsrR6BlvtMOvyX6aDOWn/nBhFXrr/IHfTsTJoCVGYBlYaFzJdLZ9dm/k2pw==
X-YMail-OSG: 5SLrPR8VM1mOV.HRvqry55xyyuIu.3_RBqHoa5TVT0HmEMTbiE6MH_TRMWzIXRK
 FnmdNg0nkfATT8zwOipSKbIWQtFk7_p.GqeydnDXgvj.UVi1yjw91LmLgGy6U0TNUMvTjcRU9WhW
 6aYr29hBFJZdyjPsotQ0Xfg2SkuI197VfHq7f1BAF_qcDZ8qyIfMd1LgDKnHubxnCHMLDp6.a.e6
 HV5g7HFiiJ47eWQVETu4OG_czmynpAoeiqaA2oX.42kUdvR.Os4wsPoO02nACpXrWnK5G6w928c_
 PA0cswyLG0KBnmiit2Y4rmCI9cpuYh_9BpCl22A5jLNP28pZYsLOL5l0cT6RVjkQYjDARsd_9NvV
 dn50Zw4n8rXRFQHtNhuqlYoNkh9ETBk27TubbBqTFeu4B3xiyVXRTwAxmHnRZiwDAtxZkKpMNTwg
 TaWox_eXAvlPOV0rizWoemgZcoIO1ImWqeJPRXrNu66LsIUtG8VELFx2.KMvNPr9Df2KT0gjrE9X
 5.AZs4WsdztS.1PnBcZmDi0wGSVM2xMe4tUQerq.aO7bWz12EQ3G9QnIl3s.itRpC47BqRCwjJ7P
 vF9UeoPzS0MlsdH_1CRoj92NPUOQqslu6Sq.rfgIwDeRRxAJ0Gp8f2j_MDhc8WDdayER0yarRZk0
 ERwgQ8_WjhhCqDbkqvD0bLmIpT97bYxxx.2BSmDtOS73.QfhrqbHulGljwzFIPNEXuvMbrnAQZoD
 I5bpOzNKGr63lFH3N8i1Z4mZsnSLZzfpU8vikUDjCAvatedOlzgr11VdvXwDUi5JNCI0NxZTfbc1
 g57t9zoKx0I_YsXdaZ5UpyxSmWgynUAU5Q7fb7nFudg.zH6XmCx9SuTXOm_0f2RPLh2nmvbM1DyQ
 fG2eBOsfhC214wfjOjM5W4J1cIQdaRZIb8BODnUnYGz233xeSIiNnj_mR6g7TC6yqTTQ8nDysv_u
 AeTHdNIoTdMjwjCmRuOzTMYO78eQyQeEvNa._b8Q5JW.AHnmGN7r_1rwcWkbhX6q4qu6Fu3AF5oL
 Lx3FkcxUWWvcXRX24144tf5z4qrQZXmjl66ArrvPWqX1rPmtxlnGjPKDYS3nZcpMZtyhppNA.tDz
 8Mxl.vqtU16NEP5evSW72LKLK5aPdGD2H435vjIApIaZrE0jUd90VkmHAHNsuE9uypq2wHciJjUO
 Yn3b06mbFOiAlhFbVpTquPDaMqi0yz2JUsAePNaRb4yyVAbi8AvKySPAu4jctkXBT3i8JZgQcR_I
 2Xx3ePJuh7MG5oB2FJshnh8gME2frS3Hf58O7xxoiaOuh.ffZ48.2MRqD1dI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:53:41 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp409.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 111e227deeb5369cccd8023f32784fec;
          Sun, 02 Jun 2019 16:53:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 43/58] LSM: Use lsm_context in security_inode_notifysecctx
Date:   Sun,  2 Jun 2019 09:50:46 -0700
Message-Id: <20190602165101.25079-44-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 0c1fd945ce42..460e611b1938 100644
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
index 414a90d48493..8d0be9767b14 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -340,14 +340,16 @@ static void nfs_clear_label_invalid(struct inode *inode)
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
index 6c3a74a44a59..6b2fcca08a43 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -437,7 +437,7 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
-int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
+int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 #else /* CONFIG_SECURITY */
@@ -1232,7 +1232,8 @@ static inline void security_inode_invalidate_secctx(struct inode *inode)
 {
 }
 
-static inline int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static inline int security_inode_notifysecctx(struct inode *inode,
+					      struct lsm_context *cp);
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 628287180ce7..74f211d58e5f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2011,13 +2011,9 @@ void security_inode_invalidate_secctx(struct inode *inode)
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
2.19.1

