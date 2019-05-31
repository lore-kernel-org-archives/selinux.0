Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1FAC04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B069826FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lwrN9mPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfEaXST (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:18:19 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:45142 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726804AbfEaXST (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344697; bh=xbxrTtPDT+RT3HxgpjUjOefKGXANltzkYYing08uaXc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=lwrN9mPrO/Nu8LOv4NKtzhEbCOt6ge8A7zDkt5zg/LeAFTDOb2fYv+kleq1yv/xQ2KcQQ3zN0sMRiFh+MqIvkeIrufrvFUM2sPh7e7jrBqtdiPdTtoBJy606PKgKn08IqRLO2HsDpduNBISUH/usk15eQy9KeTeMH0jrtBglyGb/Wo/47oQ9S0RtYIxyia01q4Ltl2Mw1I5yzHnHqVtxy1GMxAlOMDWfauYucC1IxJCr9miOQVxgSyPLotuVVbiymVQCeYxVowrzfIRDdo0mYw5EOtT1HMku9RBfrwFAYtwQZ55AC/k1A80kAPgSsXc6sSRFdC0XKgnznydH3m7A5Q==
X-YMail-OSG: cZN66x4VM1mXQk2UYci516xNWhJJOEMvlupBGlXgv7Kn3vc8Ox9GWoBDqUUkiZD
 1P3PN6OITegoylINyRCCTRgBp2KXomZtFeQ1n9ZQghQgl16eYfgmha4xdsXf6BZNz92nJCznhJnH
 pSK5YoFiablpULjTH9aJL.wBYkOdb8i2i4CJLGtgL6KBn40mq1a6nqoid8ilT3AjXVJcOdUQUd2x
 8Hvl5UN0ReSrLt1sEHmQIzGdDuCpZ0qknGc59uiOALmCuQsWSDBXU8acBAQaT7oVBT1q.DRt70A0
 0I5ujKGyzVC_3NYdGHgifCDRw6Ob9s3F2gnz6YzOZCpO5VLqn9VlDD9kh_ghwqMMThAiZsQgMO4r
 LWDnWK2P9IGU7.R4VGHxOf0Nf0W.UiX1BaK3syoYjqZJZnC8cHEofh4ZcFZehSvIM6pF6Tksl6xs
 4h_43_EBSLhZEmro3i09qaHyWJk3tlgls_27rsdnvAzDDcnOvCViapfJfXWDyuhS6On2mVn.Oc3m
 VSHWn2erJ.PSIh7JLD4XEz08ZPYefWHXYJnYLnoyvOUQzNWTydyIpg13uKbydrdpmaWS4jkGGuUk
 V7jJ9uRFY4XrE_oTXb5m1pCrs4py_o78BAIvrI62JjkhnlrtZYoru81Bj2fSiErytiwnXeQn4cP.
 o57Dw9t19hZw6z2SD8EMYL8FDTnBpNlo01GWj0S_2rApd3S7wGe8CV_cxxN7CPAfWJw3r7ggBLe.
 pBAVbh80AFUTA4OWssyZc59NCcQgsSUAtPhLJib8mu4CmIcI3yUKAunifCUr0Ge253c46dZuZFoW
 OPzdfdJWsAFvqnaMJlyNJksgJ_xQqlF7TcePzWoAem.ajqgdNbM4tpPSFO2xpyquhdwW0KAfJnSL
 QZUiMzZgM_F6H6TiKr84Yd.LeUiSRfl4NG61bmFL8c44GThQEjY1s.IU.ZEYSfGdeHk.Pqo3sg5w
 sSD5KCqz5bNBS.BYO_2vYhYRM9eVmIAMluwokKOOmgTOPBKNF8LSdbNTxURfXhheAVA0bsH7LbHf
 AKJ2yImFY46CQ_Gzf9iMRf4pkNuNIoEEYtAxYIt4zXs_GtBxFQn64lORAsEreDRN6MgSAdQyyvLf
 rLWRjtVqKl0onpOvdv1q7FXnIlldkuHM5Fgq_m1XFiXsZv5fL1Tk6nB5BhXJDbU9RRpYqcltHypJ
 jAyYW7xm6V.0Xrj44xG3DWTayIHnZXQ__SiRNux7NRjdJcW5JEUeA5x8dxQhnHczY32S0tzVhIYE
 .aGBZimiBk9ASz4jHreWO3AJSrLH9k0y5E27OznG8boTGb.z2g_M7h0r5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:18:17 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 92e9b7c7b89b418ca5baa88a2cbfd034;
          Fri, 31 May 2019 23:18:13 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 43/58] LSM: Use lsm_context in security_inode_notifysecctx
Date:   Fri, 31 May 2019 16:10:05 -0700
Message-Id: <20190531231020.628-44-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

