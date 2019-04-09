Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0669CC282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71F72082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qvo2Z/L0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDIVlK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:10 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:43388
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726937AbfDIVlI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846066; bh=BkiVgWxV8LugM7dQFM0z6uB/OZ9M/gQ3t5pE0/A8yGY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qvo2Z/L06RQDn21xTiZ7P4QQNz65Bh9aTIJlWoCG8AG0Ysp3o4LG0VHB+0wi78SlVrRVIhZRRoTEptDGTgiIHBZDbIdJwUGTB/qT46hJgWyL9o/rGjMvafRLaserhvkVZS35KnYFpwxK4rAQWGbefIqw2OnP/AhXoD8LaL66PEU3MUUh9D17vNcMWSXKfRRLtRN+cEAvRZRk9yy0D5E1ZcOjbv5LaMeYvCtapCoijAOucpbRRr/sqvGm93A5wOVNytaj4+nEu5yCB8rkOCKKRoaFSMpYP3uAC4f5adDPj2V7Tq8cT1Fvnx7Uy+vS3i/4toQkE9G8q70dqEYAvFgOjA==
X-YMail-OSG: snphV6oVM1kNtcWuNddOPTFmLZVnPiz2SggnMon.KXoEfulHs18qI.Foprb0QHN
 HjBA4YYOheTMkCUQt__jwqap5HTXQoMXVegEiknTl9lAMjc5CIeTfTTgQUjR2bSqfefWj1OsMhEa
 Jc2Qb4_MNwsRR51gerBwDA1w5uos5dPJPldvsceI8QBUR0hP6ebVy3MbmeoIi6THVqBSQoqZhRR1
 MkSLDkYzQ0MIZrFkAkxOdC9pButW0R8S9FRaFb8Mh4__VLKkh_DzDqfheiSsaP90_aB2uizECykS
 XXDYFPOVx.3QiMb4y9o24BQvjtodUp3rT7DuEZHzkI.Gk_QhEbwSNyX3qR64q1krO6I54khRVUfr
 ziPkC2t7GBgz6QRmL_nNnY5mla0rfAVrSbml8WH6BBlPfnGsjvUwRQC3cg.J8l97mXExdJmBAv2F
 rOhZcTURCg3LeyCnGCtk_1hcIIPP9KTzNQWMP1I69C8K4OBlUSGafsuEEhLxjqZz_TT5EYSt5oqV
 L6VmSkSx6.RMr2dXEw8IbyrRfAZWlKQrdgW1HhTz_Bow76gtL3OHuUlya3wFVRn9xytTUpjzVq7S
 L_Gb12uy75dF8FtEod.FkJ9o5.KmSSuAQGkswCIXDYOXmWIFCXW21rDDsB..R7HixwjPT6LMfGq9
 7GamF_axtX_2WA7OyGMo992ve7iV.j1JoEtEzET4M_O9wzvOhEmUkdUoLBPtdScPZ.WWPlYqP5au
 Am6mctjn4Bf8WQakAqIVcFwltkH961Jnc0hnp68S.c.YewZpfBFHI.mQOeyShtqnVoT8XRccM7yF
 jaiAXiroWOwSrYAhK1nuo6ay2Z9h6A6NvWi0YULHtwvOZuMoCT6H46zaNUA66snoJzwMwvx.kvHW
 h6E_YSsuzXMK3RCic3_2Qk1Ka.lPrHFR.YW86GaqLi8oqnJvEd2YoG72TVHfitYMzTS5DfByrIkv
 wFx371qdI6kBmFDaztdbFi7fNsmCUCUxMs0Ku56X7MIYGjHLpkyVwG4eqahuWMWOE3lYY6CQmT_4
 3tJ8GVHufSuXydvpqmXr3fbnsXjuNU2fq8P6EBXu2B3lzSTd0fjrtG9jMQBuu0Ctfa.5R0LYt0aW
 zSaV.grKxsQKjM0US_9jl9xeaFPU.91LShxebCrHmfRvhEz8ZQPixEjwURcp_Pg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:06 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0d1cdfa4e40e9d37a3e144929c04344d;
          Tue, 09 Apr 2019 21:41:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 44/59] LSM: Use lsm_context in security_inode_notifysecctx
Date:   Tue,  9 Apr 2019 14:39:31 -0700
Message-Id: <20190409213946.1667-45-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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
index ba9bcdbfaebe..2abbaf72779e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -439,7 +439,7 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
 void security_release_secctx(char *secdata, u32 seclen);
 
 void security_inode_invalidate_secctx(struct inode *inode);
-int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
+int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
 #else /* CONFIG_SECURITY */
@@ -1234,7 +1234,8 @@ static inline void security_inode_invalidate_secctx(struct inode *inode)
 {
 }
 
-static inline int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static inline int security_inode_notifysecctx(struct inode *inode,
+					      struct lsm_context *cp);
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 7069ff857f58..f5e332bfcdbe 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2026,13 +2026,9 @@ void security_inode_invalidate_secctx(struct inode *inode)
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

