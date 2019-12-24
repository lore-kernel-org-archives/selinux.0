Return-Path: <SRS0=cgF/=2P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA4EC2D0D2
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E1C20679
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="c+3dARBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfLYACX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:02:23 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:33201
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbfLYACW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 19:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577232141; bh=dS6JTeZIx9MeUiPz9bGsjkyQWKa9Q9AGSNrTiMMGCNM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=c+3dARBOO63gypCbV3NOp0RoKAn0Hpm4G6kLDD2d45+9OzIB7gBleuULlhjvypOsVMRVFSyayhtOtDuRSHtRZgVikmUIQh00IFrXoNYJgZQ8zaEDht/Rcq3T4Gvi2xPSdDJjIrH8SVPLSn7MFu90vC5FSnY45FjV/Cajv2v4W8CX4eQukONkk+O6DFdKyHHWblWi3MZWVp5G8iiA/iBp5ADK+IZEBtks+6837r65Zve78Gu6NRZ/dj32D6qmehQ7fpDiYi6heN4AwUBl0doKj2YdLSfwOuvqEBQJySo6ODSUXuW2orqrVR0kU5uAKSLGfon239my0lmCeLpaKBeU2A==
X-YMail-OSG: KB9iOFwVM1muEI1u9XicxTYJRo6EVvQayoiyBoGqeF96d1Xce8EZFJvBp7YNHIa
 iAgZ7JNLeTh_DL80Zg5_XTpvSey79ZlgwF25Jsp9BOZ9js7quaZGsjUokgqMwpsLIycx2PB1wqE1
 3EjuGnuoMv4ipKdMaXUPpXShquyjmtTsMTha.hRSGOkT386hdR6lZHSEei1ILUtaKk6iuu_EuYuf
 kCoBrbgc9xdXhj5sUsmdLa.UZ28N0cxszgsxl3riSTviGoSyaAmTpdPtY8HazOR81ZdasDgkqX56
 iW303uzNG4Day9.ovufzmoyMovD8BRsKGZ1z8bhOfWEoOhq5zv2j7aMfko8WmIk4nz078wtAPsIx
 MdV5cfcOl4iA7ZDtiCyyjvnkJ.dQ0wjecyHTchbbN15hPoFgCSfHC4KhFRbw8xw8W2sxbzRQd8n4
 bdM9PmnWFgmsyGAGsrNoZT5Rcvp5DOvc1wekMuhHa.O1mQz.99HrhXmBAJDC7EAasE1UTCZUEUVE
 yAEcaliJAVKaQpPsQcpTY0Gi1b44JF_xuEzCp2VvMmz4rZsTgb7Cs0H85vwv0y0JmYCtiOf0mkEE
 o0oig7lLdPRRAk3ydemLo6ZbkZZAuZDbxpeO07x1c_lnjjnUUca0zyIlHawPPOvoCF4zIpZJZAUE
 h7_LppUdVdBrMRTCwDWCfaPc3b5qAkfR9jLoR6HNeHKuMyEQ2WezEcWDLGXC5m_nv3IAGFsOpZ13
 H7RCBPJ83fjm1g8oEIiKF40XKq04blt_XxP9AxT9Qoja5lka2WsoKgCzDg6UO3b0Khk3cF10yaak
 CNyQmsBFXqkbPPkRwn.ep0H6SNXzEg3gA3NxrFR22u6rl.RadLT3aemvfQuN6f5Jkv5HThz1AA.j
 NlJed0VIZMyDz8bl3jzP50grLqK7QsxBA2QH6bt65IQflEdPUjN7BULjsS6B2uP7prCON.Ox0CTK
 Toy7o_AbqcKz8r7A3XQ57QDItoag5cob4N.zUejqXHkXLgTmh.2A4dqisLOXiPCV7HhpxPeGL9VL
 VI3RIu0_NMreXSYatK4MZW3KQzTWuL5lMlsFdVN5yfAOlH0sB9x3dStUYofqCXWIaRaShrJR_zZA
 Vdi8P8_MLb9iH5OmS32eLhp18xIfuwOUrEjy6W6BYUa9wP_EDo1oWvoGNNM9EWfLoXV5YJ2qAYMO
 zKJ4gH6ino06kOCmokoCg7c3OEsbKA365nrcVsqPULmDlhAX0h7jfoF_w5_K559KJuGieXPSXiuZ
 pI4zCBKc0gnqowRaJIJYSClZC_FL2BiFfeTGJxkVg5D61ow4SSXtj48AYYRmGZiFzoWP4oXqZIOA
 rz.grUFw9Vor7APZh5e1EzGEE_b6OtzlhIkKHw.OtrJ3Zf65KmXBcXc_C0rVT_pz8HgmfoeKqnVd
 uvTZ4nwCeWEP_pjByJsH2cIeG_lI8D2B2IHdqfhNmGKCR7t4_c5iHc6ZWZ1VocvY3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Dec 2019 00:02:21 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 999b3ab1903a52a38605bbd14be4cac7;
          Wed, 25 Dec 2019 00:02:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v13 16/25] LSM: Use lsmcontext in security_dentry_init_security
Date:   Tue, 24 Dec 2019 15:59:30 -0800
Message-Id: <20191224235939.7483-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224235939.7483-1-casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_dentry_init_security() interface to
fill an lsmcontext structure instead of a void * data area
and a length. The lone caller of this interface is NFS4,
which may make copies of the data using its own mechanisms.
A rework of the nfs4 code to use the lsmcontext properly
is a significant project. SELinux is handled correctly, and
is the only current user.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfs/nfs4proc.c        | 15 ++++++++-------
 include/linux/security.h |  7 +++----
 security/security.c      | 29 +++++++++++++++++++++++++----
 3 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a30e36654c57..6cd2463f890b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -112,6 +112,7 @@ static inline struct nfs4_label *
 nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	struct iattr *sattr, struct nfs4_label *label)
 {
+	struct lsmcontext context;
 	int err;
 
 	if (label == NULL)
@@ -121,21 +122,21 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 		return NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-				&dentry->d_name, (void **)&label->label, &label->len);
+					    &dentry->d_name, &context);
+
+	label->label = context.context;
+	label->len = context.len;
+
 	if (err == 0)
 		return label;
 
 	return NULL;
+
 }
 static inline void
 nfs4_label_release_security(struct nfs4_label *label)
 {
-	struct lsmcontext scaff; /* scaffolding */
-
-	if (label) {
-		lsmcontext_init(&scaff, label->label, label->len, 0);
-		security_release_secctx(&scaff);
-	}
+	kfree(label->label);
 }
 static inline u32 *nfs4_bitmask(struct nfs_server *server, struct nfs4_label *label)
 {
diff --git a/include/linux/security.h b/include/linux/security.h
index 390cc0561bb3..ea98dff5ec03 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -394,8 +394,8 @@ int security_add_mnt_opt(const char *option, const char *val,
 				int len, void **mnt_opts);
 int security_move_mount(const struct path *from_path, const struct path *to_path);
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+					const struct qstr *name,
+					struct lsmcontext *ctx);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -786,8 +786,7 @@ static inline void security_inode_free(struct inode *inode)
 static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
-						 void **ctx,
-						 u32 *ctxlen)
+						 struct lsmcontext *ctx)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index e80b71c03062..29f070aa172c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1011,12 +1011,33 @@ void security_inode_free(struct inode *inode)
 				inode_free_by_rcu);
 }
 
+/*
+ * security_dentry_init_security - initial context for a dentry
+ * @dentry: directory entry
+ * @mode: access mode
+ * @name: path name
+ * @context: resulting security context
+ *
+ * Use at most one security module to get the initial
+ * security context. Do not use the "display".
+ *
+ * Returns -EOPNOTSUPP if not supplied by any module or the module result.
+ */
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+				  const struct qstr *name,
+				  struct lsmcontext *cp)
 {
-	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, ctx, ctxlen);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.dentry_init_security,
+			     list) {
+		cp->slot = hp->lsmid->slot;
+		return hp->hook.dentry_init_security(dentry, mode, name,
+						     (void **)&cp->context,
+						     &cp->len);
+	}
+
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
-- 
2.20.1

