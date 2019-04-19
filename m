Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCCDC10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C60321736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sD8AKHcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfDSAsG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:06 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:36784 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbfDSAsG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634884; bh=Jyx7KIysqq9TaCLw5/VISOB2mV6hTIZQdHhGkoxn7Xo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=sD8AKHcOgpC12MRyRLK2pakTunpmzIlKBM91+q5fYicHBLxYPVedGrkzyFVWtJ0Dc8/23g6ZPcqHZ5/vQWwVPeNxpvjDmmqwUpUqWq03CfEDdBdblhn4dwmpdjlf/osEIYvqDutXBkyKRn1gqpldneXQA2CvD2kahKJxeIhqpWTyT8myn++N0/is02DcmmpEEqcFNB5DB87QAmCSRYb1sdJXwHDCYPjHzqjFUs7GD6MLnn4T+2K5VisFifxfMNDfM7aFC67aCkRrmRVYz9ZMH9Y490e1xNvfCGQTUGGjbAqt2hH806TRD5plOnYVkYta+5TN7etRuPVmHcPhvW/sZw==
X-YMail-OSG: EyOsoTYVM1nGeOqZ4YThJ0Zg1yDTdL_28wJJ2CVMDq0teSW0z327CztuVE9qSoo
 RomLtazOWChVarMrka25RZFU2BcECC0d1nsbt7KiyLZ3ZJHh7CEItrSlv9y0_MLQjo8kJUqi2EKT
 ci1oHKkPJ1OBpJDukgyJ6iDB9Vet3TocIugO.jWdPV7YiPhJJKlM0nHQFoPvKQceL_KVdqpi9xbB
 BC4Bp3bgx3QEDjFVxneK_GtpTvJBTJ4mx4zWK1caP6dL3icLdNYeTp0PjY2Jo3.Z5WlJQwztywkK
 _qnFza38iU1pzX7YlaHnUrl1R_bFnYKSLcWibzM60j7Jty4l09CJIGUzAmiYonkoaOtmLmUFklaA
 umuz6FFR2Y9clNEd.0CXm76tqkbEG_wM1EOWoHkdCdmAXOrlkukzFzGR7l31bC4C3J8Ow8gOdqEj
 YLfjLb1w4rE8dMinRWVn2enphjDNsAKVW1i1JAnh7pN26WW7LTDPJDyDvSEtnjzbvnY4IDSUH1ky
 YZO0FJfNXZdjNhS0_am9oOzsDoQoAxP.XlVE.f1NmwQMeu8Z1oFMUbn38lTAHjqqTR93I19nrz2X
 DM1M5zbcmUIyspDABeDzG_7a3RO2VecnFrhi3Sn1qjNT2jldZrxClzymGbJvJrhQ_E1WrvkTgp.U
 zDIOQ9f9EuM7iCMWqKqjOXJGCKzenIH3l3AfUsKFXYyF1eIMjtmw1cH9T2xKjv3RG91XN7fWG1xU
 wdweC1wi9mf2p3rCALNKtIWjT1ojkcwMRgQE0Ev1yKElBV1Zb3rHJk0OE7AmnmFcJxJqL0UBiND8
 08vyCfPbb5L7Jv4Byl5ccQd1TDr5_N1T0Uy9.KCI5r6l7oJPO6S8jyh2oQ4McemD6qrvheuYUKRD
 uTamS1itDoYIM7pUiYmt1ggKYyyVnKpk1bIJrDiMsPDS3CXGVuczgIPOFDAyKs5g5Da53xHVVOir
 6x7Sp37Y6Ds0KtuBOLICRP_5VJjykcNNNQV5VW3YdQqH27UMrNerG3_lUtwy113s3OHqemhIq19g
 AmGYu3dIr43reqJA0hJd6STq87ChnxGmBS6b6Ao5RffNxJ6T.wr4lL8EnnZsPzy9C3qIyjbiqaf1
 Kz643syGMNN45GBeN_IxGl85RHTD9y5bVssrx48a1pdagTXoh2msJjq7nmNxV0q8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:04 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9312487679b1d62a89b866e0f3ee025b;
          Fri, 19 Apr 2019 00:48:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 44/90] LSM: Use lsm_context in security_inode_notifysecctx
Date:   Thu, 18 Apr 2019 17:45:31 -0700
Message-Id: <20190419004617.64627-45-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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
index 649fd13cdda1..89bd384c14df 100644
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

