Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7145BC32751
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3254F21743
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="T4idrvnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389558AbfHGWnH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:43:07 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:43509
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389553AbfHGWnG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217784; bh=QNIe7jTKLKFHH/DG6BU5JjF2uOAEc0WuEQ4h+M52wv8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=T4idrvnSz6IGr+3Cgyn01Zb0qzprwVxxTL19Gsi+e1q9xYooRPuFUphOa3W6/KoSZrFfQBOKTZLEeW0ntz7E/Y7WbgjlMT0wVVjlqeeSnNU08WCcUZV/THz/MCYXTmnCE8VyZ9r3pmDoSY725SqgHZXoETXZ/LPRcwft2fvMc6ZJftfCaPH2CTcJiH1Vskq6UHQRO4cB8KH1U0fI3hulTct5+9CaDIFssG+u61Hm17XQzOAQ6Yvh/ILVD1W21PIpvbb6nM6gT5VHwUpWqeOMqqBmpn1t4ZtDQCFm5plSxjwR4O1ncrq/rKanJGh7o6bGFmJvhwW0EtDBeFXxLFeGUA==
X-YMail-OSG: sMYTZR4VM1nFAp7mA8zg8Ktihbr637JFxn3oNrqLEjTaC33rD073zP9Ujp2oQMW
 JoZp8IQS9W6est.7FClQoElRmJCrY7R0EZ83rCTq192ILtflswQGBKKRUrs5EC3vseBwenyPRAZl
 VGPDM6Zkzn5L1WeeQ99g_hrMk6g7hfT6kOBEBovexRf.mTgb_EqbHgv3QMrwotmNQWMzbepsVJZC
 j.Qeff.EGp51nS4PYeQxSMNZHEyg2humxPtTGL._kJ1nTgSYTDn6rLxh9qJ_0Tfqhx7ymmBqainR
 7c8IP6q5oLPzCXPyEGA3mtpNhzN1oEs5in__mK0AzFLyunZj9h01mdfNgFkVwNwkmHscV1tpUzes
 V69DDw6902C2XF2FOWM9Nvg119Fyoi9KCMKvswNxPrA_04Z.NxBxFW5vCSHdATUkry1A.7vNyhdA
 GAnSWM7sidbneeqSTQkApBZEPPgrzqQEptHGBwrDbLtozvCQZCakYsSl9wQaWpmSADN3HZQ82slp
 U0rguCeOALskxb5BE4QKIT_yl2ULR3iag9CUNkg5nnAubwtg1Nkqfh20Xt92AXVqdPEB9p7JLisB
 flludkipmi7z9kQVXyyoeO4pIV9SYyNZNIfSCO2lZLFaX03c686kkXal6HeQ4Yog_TdMov28QOyj
 1vquwsVSXB3YE3My_V2N6js3p0GmkOYG8irNsTGKawyZH5Lin8ecBxzYfUaO.lsFIsDeFM_y5.1V
 k2p6TeU7pkZlI2Gd1cpy3TspWP6su3ouGj2h518n9xribd5bf6dyO9PWXcpwFCYDlH9QSdwWmNQj
 FQfr92cpwFxjGgVLEyjPyATqCMa7NrvScpDDNxz8ZrgQI4lYOnfLX420O2Oyb5nq4GSj34ClNEDZ
 biYCsS8mkY4EyLcA2OTq1Qk5eDSkE4WiJGS3s_sUaoHqeDmZZJ_5mzNX7duHmJ4Q4qY9rSHnZh9o
 r9owl5fJADtsuLtq8GeROppkAozQmr53RzOnUoqhHgEJm_V5MzBWH2W8LTEp82IQQhk0ADzjxqpX
 ABw3FRU1rbdTCpgxhhDL2CxuLgZ2Dt76cBrO6ryrMRpFatzSJCBW82a.EhgTf.bK.dwyAqRyJvXJ
 TRA4VGiFV_TuX_aL41hxmNg05hNMP5L8bPUPxv0jW88BCL0QEGWI1Es0H6gN__Hnxs74ztUkfbnT
 4bXGkm9dGtiaq0sguGbpn52_u19TP5xIKo6WK4Xo4UBrfmvI5YjVyhbWLUXK0l7G9E4eoDPWM_y.
 dk2Db_xjc.6NCPXqvAQFBXKcY1iU6MhSPIaOi1_53viamKFUWU6m.db5wFpkD9PR1yRDDJsGzrT7
 LVXYeIQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Aug 2019 22:43:04 +0000
Received: by smtp406.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a922c1f55dc5f6c930e3c4333b468534;
          Wed, 07 Aug 2019 22:43:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 06/16] LSM: Make multiple MAC modules safe in nfs and kernfs
Date:   Wed,  7 Aug 2019 15:42:35 -0700
Message-Id: <20190807224245.10798-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add use of "compound" security contexts to kernfs so that
multiple security modules using contexts can be represented
in the internal kernfs data. Disambiguate which security
module will be represented in NFS4.2 transactions by using only
the first encountered ismaclabel hook.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/kernfs/inode.c        |   3 +-
 fs/nfs/inode.c           |   9 +-
 fs/nfsd/nfs4proc.c       |   6 +-
 fs/nfsd/vfs.c            |   5 +-
 include/linux/security.h |  10 ++-
 security/security.c      | 179 ++++++++++++++++++++++++++-------------
 6 files changed, 143 insertions(+), 69 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index ffbf7863306d..cd225121aff7 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -185,8 +185,7 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 		 * persistent copy in kernfs_node.
 		 */
 		set_inode_attr(inode, &attrs->ia_iattr);
-		security_inode_notifysecctx(inode, attrs->ia_context.context,
-					    attrs->ia_context.len);
+		security_inode_notifysecctx(inode, &attrs->ia_context);
 	}
 
 	if (kernfs_type(kn) == KERNFS_DIR)
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 414a90d48493..8acc5eef4d08 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -341,13 +341,16 @@ void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr,
 					struct nfs4_label *label)
 {
 	int error;
+	struct lsmcontext context = { .slot = LSMBLOB_FIRST };
 
 	if (label == NULL)
 		return;
 
-	if ((fattr->valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL) && inode->i_security) {
-		error = security_inode_notifysecctx(inode, label->label,
-				label->len);
+	if ((fattr->valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL) &&
+	    inode->i_security) {
+		context.context = label->label;
+		context.len = label->len;
+		error = security_inode_notifysecctx(inode, &context);
 		if (error)
 			printk(KERN_ERR "%s() %s %d "
 					"security_inode_notifysecctx() %d\n",
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 0cfd257ffdaf..0f166c81f596 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -54,12 +54,14 @@
 static inline void
 nfsd4_security_inode_setsecctx(struct svc_fh *resfh, struct xdr_netobj *label, u32 *bmval)
 {
+	struct lsmcontext context = { .slot = LSMBLOB_FIRST };
 	struct inode *inode = d_inode(resfh->fh_dentry);
 	int status;
 
 	inode_lock(inode);
-	status = security_inode_setsecctx(resfh->fh_dentry,
-		label->data, label->len);
+	context.context = label->data;
+	context.len = label->len;
+	status = security_inode_setsecctx(resfh->fh_dentry, &context);
 	inode_unlock(inode);
 
 	if (status)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7dc98e14655d..274a998cc123 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -531,6 +531,7 @@ __be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	__be32 error;
 	int host_error;
 	struct dentry *dentry;
+	struct lsmcontext context = { .slot = LSMBLOB_FIRST };
 
 	error = fh_verify(rqstp, fhp, 0 /* S_IFREG */, NFSD_MAY_SATTR);
 	if (error)
@@ -539,7 +540,9 @@ __be32 nfsd4_set_nfs4_label(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dentry = fhp->fh_dentry;
 
 	inode_lock(d_inode(dentry));
-	host_error = security_inode_setsecctx(dentry, label->data, label->len);
+	context.context = label->data;
+	context.len = label->len;
+	host_error = security_inode_setsecctx(dentry, &context);
 	inode_unlock(d_inode(dentry));
 	return nfserrno(host_error);
 }
diff --git a/include/linux/security.h b/include/linux/security.h
index 0665a27a2891..2f442746dede 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -493,8 +493,8 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
 void security_release_secctx(struct lsmcontext *cp);
 
 void security_inode_invalidate_secctx(struct inode *inode);
-int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
-int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
+int security_inode_notifysecctx(struct inode *inode, struct lsmcontext *cp);
+int security_inode_setsecctx(struct dentry *dentry, struct lsmcontext *cp);
 int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp);
 #else /* CONFIG_SECURITY */
 
@@ -1288,11 +1288,13 @@ static inline void security_inode_invalidate_secctx(struct inode *inode)
 {
 }
 
-static inline int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static inline int security_inode_notifysecctx(struct inode *inode,
+					      struct lsmcontext *cp);
 {
 	return -EOPNOTSUPP;
 }
-static inline int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+static inline int security_inode_setsecctx(struct dentry *dentry,
+					   struct lsmcontext *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 13102d16bf2c..c71ddae6760e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -743,6 +743,42 @@ static int lsm_superblock_alloc(struct super_block *sb)
 	return 0;
 }
 
+/**
+ * append_ctx - append a lsm/context pair to a compound context
+ * @ctx: the existing compound context
+ * @ctxlen: size of the old context, including terminating nul byte
+ * @lsm: new lsm name, nul terminated
+ * @new: new context, possibly nul terminated
+ * @newlen: maximum size of @new
+ *
+ * replace @ctx with a new compound context, appending @newlsm and @new
+ * to @ctx. On exit the new data replaces the old, which is freed.
+ * @ctxlen is set to the new size, which includes a trailing nul byte.
+ *
+ * Returns 0 on success, -ENOMEM if no memory is available.
+ */
+static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char *new,
+		      int newlen)
+{
+	char *final;
+	int llen;
+
+	llen = strlen(lsm) + 1;
+	newlen = strnlen(new, newlen) + 1;
+
+	final = kzalloc(*ctxlen + llen + newlen, GFP_KERNEL);
+	if (final == NULL)
+		return -ENOMEM;
+	if (*ctxlen)
+		memcpy(final, *ctx, *ctxlen);
+	memcpy(final + *ctxlen, lsm, llen);
+	memcpy(final + *ctxlen + llen, new, newlen);
+	kfree(*ctx);
+	*ctx = final;
+	*ctxlen = *ctxlen + llen + newlen;
+	return 0;
+}
+
 /*
  * Hook list operation macros.
  *
@@ -2083,12 +2119,8 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 	struct security_hook_list *hp;
 	char *final = NULL;
 	char *cp;
-	char *tp;
 	int rc = 0;
 	int finallen = 0;
-	int llen;
-	int clen;
-	int tlen;
 	int display = lsm_task_display(current);
 	int slot = 0;
 
@@ -2116,26 +2148,12 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				kfree(final);
 				return rc;
 			}
-			llen = strlen(hp->lsmid->lsm) + 1;
-			clen = strlen(cp) + 1;
-			tlen = llen + clen;
-			if (final)
-				tlen += finallen;
-			tp = kzalloc(tlen, GFP_KERNEL);
-			if (tp == NULL) {
-				kfree(cp);
+			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
+					cp, rc);
+			if (rc < 0) {
 				kfree(final);
-				return -ENOMEM;
+				return rc;
 			}
-			if (final)
-				memcpy(tp, final, finallen);
-			memcpy(tp + finallen, hp->lsmid->lsm, llen);
-			memcpy(tp + finallen + llen, cp, clen);
-			kfree(cp);
-			if (final)
-				kfree(final);
-			final = tp;
-			finallen = tlen;
 		}
 		if (final == NULL)
 			return -EINVAL;
@@ -2210,13 +2228,22 @@ int security_netlink_send(struct sock *sk, struct sk_buff *skb)
 	return call_int_hook(netlink_send, 0, sk, skb);
 }
 
+/**
+ * security_ismaclabel - Does @name identify a MAC attribute
+ * @name: attribute name in question
+ *
+ * If @name is the name of a Mandatory Access Control (MAC) attribute
+ * that the first module on the list recognizes return 1. Don't look
+ * beyond the first module, as this is only used by NFS and NFS can't
+ * differentiate which module to use.
+ */
 int security_ismaclabel(const char *name)
 {
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.ismaclabel, list)
-		if (hp->hook.ismaclabel(name) != 0)
-			return 1;
+		return hp->hook.ismaclabel(name);
+
 	return 0;
 }
 EXPORT_SYMBOL(security_ismaclabel);
@@ -2284,6 +2311,15 @@ void security_release_secctx(struct lsmcontext *cp)
 	struct security_hook_list *hp;
 	bool found = false;
 
+	if (cp->slot == LSMBLOB_INVALID)
+		return;
+
+	if (cp->slot == LSMBLOB_COMPOUND) {
+		kfree(cp->context);
+		found = true;
+		goto clear_out;
+	}
+
 	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
 		if (cp->slot == hp->lsmid->slot) {
 			hp->hook.release_secctx(cp->context, cp->len);
@@ -2291,6 +2327,7 @@ void security_release_secctx(struct lsmcontext *cp)
 			break;
 		}
 
+clear_out:
 	memset(cp, 0, sizeof(*cp));
 
 	if (!found)
@@ -2305,30 +2342,82 @@ void security_inode_invalidate_secctx(struct inode *inode)
 }
 EXPORT_SYMBOL(security_inode_invalidate_secctx);
 
-int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+int security_inode_notifysecctx(struct inode *inode, struct lsmcontext *cp)
 {
-	return call_int_hook(inode_notifysecctx, 0, inode, ctx, ctxlen);
+	struct security_hook_list *hp;
+	char *raw = cp->context;
+	char *ctx;
+	int llen;
+	int clen;
+	int rc;
+
+	if (cp->slot == LSMBLOB_COMPOUND) {
+		hlist_for_each_entry(hp,
+		    &security_hook_heads.inode_notifysecctx, list) {
+			llen = strlen(raw) + 1;
+			ctx = raw + llen;
+			clen = strlen(ctx) + 1;
+			if (!strcmp(hp->lsmid->lsm, raw)) {
+				rc = hp->hook.inode_notifysecctx(inode, ctx,
+								 clen);
+				if (WARN_ON(rc != 0))
+					return rc;
+			}
+			raw = ctx + clen;
+		}
+		return 0;
+	}
+
+	hlist_for_each_entry(hp, &security_hook_heads.inode_notifysecctx, list)
+		if (cp->slot == LSMBLOB_FIRST || cp->slot == hp->lsmid->slot)
+			return hp->hook.inode_notifysecctx(inode, cp->context,
+							   cp->len);
+	return 0;
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
-int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
+int security_inode_setsecctx(struct dentry *dentry, struct lsmcontext *cp)
 {
-	return call_int_hook(inode_setsecctx, 0, dentry, ctx, ctxlen);
+	struct security_hook_list *hp;
+
+	if (WARN_ON(cp->slot != LSMBLOB_FIRST))
+		return -EINVAL;
+
+	hlist_for_each_entry(hp, &security_hook_heads.inode_setsecctx, list)
+		return hp->hook.inode_setsecctx(dentry, cp->context, cp->len);
+	return 0;
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
 int security_inode_getsecctx(struct inode *inode, struct lsmcontext *cp)
 {
 	struct security_hook_list *hp;
+	char *finalctx = NULL;
+	int rc = -EOPNOTSUPP;
+	int finallen = 0;
 
 	memset(cp, 0, sizeof(*cp));
 
 	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, list) {
+		rc = hp->hook.inode_getsecctx(inode, (void **)&cp->context,
+					      &cp->len);
+		if (rc) {
+			kfree(finalctx);
+			return rc;
+		}
 		cp->slot = hp->lsmid->slot;
-		return hp->hook.inode_getsecctx(inode, (void **)&cp->context,
-						&cp->len);
+		rc = append_ctx(&finalctx, &finallen, hp->lsmid->lsm,
+				cp->context, cp->len);
+		security_release_secctx(cp);
+		if (rc) {
+			kfree(finalctx);
+			return rc;
+		}
 	}
-	return -EOPNOTSUPP;
+	cp->slot = LSMBLOB_COMPOUND;
+	cp->context = finalctx;
+	cp->len = finallen;
+	return 0;
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
@@ -2433,12 +2522,9 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 	struct security_hook_list *hp;
 	char *final = NULL;
 	char *cp;
-	char *tp;
 	int rc = 0;
 	unsigned finallen = 0;
-	unsigned llen;
 	unsigned clen = 0;
-	unsigned tlen;
 
 	switch (display) {
 	case LSMBLOB_DISPLAY:
@@ -2471,29 +2557,8 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				kfree(final);
 				return rc;
 			}
-			/*
-			 * Don't propogate trailing nul bytes.
-			 */
-			clen = strnlen(cp, clen) + 1;
-			llen = strlen(hp->lsmid->lsm) + 1;
-			tlen = llen + clen;
-			if (final)
-				tlen += finallen;
-			tp = kzalloc(tlen, GFP_KERNEL);
-			if (tp == NULL) {
-				kfree(cp);
-				kfree(final);
-				return -ENOMEM;
-			}
-			if (final)
-				memcpy(tp, final, finallen);
-			memcpy(tp + finallen, hp->lsmid->lsm, llen);
-			memcpy(tp + finallen + llen, cp, clen);
-			kfree(cp);
-			if (final)
-				kfree(final);
-			final = tp;
-			finallen = tlen;
+			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
+					cp, clen);
 		}
 		if (final == NULL)
 			return -EINVAL;
-- 
2.20.1

