Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A603BC10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734D02084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TRpaDN6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfDITT3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:29 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:34887
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbfDITT2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837568; bh=74rPh+sCnMpg6mZ/XiPS4qZefks1l7WGjfPbmrUu5zs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=TRpaDN6AFg6boZD+p/7VRiT7KvI20QbyboOUnFaqWeHgiCvBYZ+xVbt902TiQsJYCAcegO/5zqoLY+amKZycNg2AvmSKHkeObK0jJbB8k1y8oJC1AxOfsPhVknmxH5xBhL+UwjflGNgUXp0z6j84jogQoI867DeLD2nQmgGK8iqiRsEkTLgXFQsgE5E3wGJgA69/Yh1oAa0+Z7aPQECeSg3NYUUSkj4XDTwUc43/zbmspW2Z/ph1rzkHEwpVDleqqIDNZIKcEbyytRm4ZuETnDmFjzSNkXjOZBRuxBM32c2oW59PqgTCZVEEJvdk+tfxG+UNTFNrJVrNaN+Ki67Krg==
X-YMail-OSG: Oz2xM3MVM1nngxHDRS_ks2DDnU7bfE9I9O29m69tIRM3Rv1OLmNf.dj36xe3vQE
 k5kK8_ntSYFXz0.TYG12QtTz_qQS0DAUQRbgkNYyzYLGGRPLGDKNsynN3B34lvtJZPfcVFvawlRm
 KxOFMANnj9oFJFmgB2Gk_u.Ri8gNJ6v8H16mEtnd.G.r9gEMHTdu2TTdU088PstTV8jgdLzQMh1o
 vyZwfFh7XzcAxqTSjR6ap.USBvia1inGwqNHSs07xpwJcKq9lq3XevTTNkIWqFLa1R4qTfiPrkVm
 PtMWfC00zFsCJTQnI.z0PBIwIIFLaGs53RzNKmPNu5Pby3oz7iK74D_imNo.BImbEhLP_zRUxJSn
 Ke87jDXh_SeeeWG.lNc8AmPaW5nAk2pV7WFp_0BxzAj7wiXakYR.EJqL2GJzoiOzyhbrVTe.Xh96
 9E6dG7kkPfL3dKSL9H2Z.o0qCCeImoBMuXv7vdK8nPCJIX8ChYrUTbeabQCc64BVNSkb8ml605PX
 4SdFtnBc8lld9eGOb1dzkCHhKB5aiNIeJL_51oRwenyohC8_5ct6mGKTEzH6FTw.rpbThSf6eF.i
 Z1V..Lci_h0lhGSqfO5j8VO1xCP1Qte00jlhGXDFpTPf0O_tKYeZ23hBC5x4wirXjMRJ9Gih4MfF
 92n2QS2bZ9UQ5mjxe7YTm9ZXPtw29nmRMczrgMosN27wjV70qDGGBODEUnpoVBR_s.y0ZQcz2170
 BBjht.99FCG41Njv.1bTOxbXloNE.i1dnf7U4CL6wcwxkoByBwyMwbj8hz564c3xjyLXna5iiiqI
 t6RAaiBQMpbDh1p10e7Dy16TrxCBA9Q8A3._vGWQPCxaUdlSjQqo17UNOxzOTB8nlvyjk0Xr3XX4
 UVkFbjyOlcn9N43est0xb7ij7SWGAjFd.HHjQVh8Y9tlGquqq9n.eMHCbuIh2GEzwizUU_ifdmhU
 NYUKNT16bDSPxCcgaLzITpbrhBnk9k7beu0djK1DvVVi5N0KwOiCSa0OcR4lI9gfZx0MUQYvUg7n
 KbN8myOSgQ8ZdwKwESUyT6c42uuhSf1heaQM74zhoXmMNPtKsFZTGZ2vSCdTG4za4UieZq.GhSkd
 AAfq6BvdvGypBjN_5.sLEOURc1meMFHQ5HeFx6LoKFvrUF4dvIENkZ98LA4Y-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 92df6dee4d3144b341710b3f28d23ef8;
          Tue, 09 Apr 2019 19:19:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 43/59] LSM: Use lsm_context in security_dentry_init_security
Date:   Tue,  9 Apr 2019 12:18:32 -0700
Message-Id: <20190409191848.1380-44-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Convert security_dentry_init_security to use the lsm_context structure
instead of a context/secid pair. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfs/nfs4proc.c        |  5 ++++-
 include/linux/security.h |  7 +++----
 security/security.c      | 14 ++++----------
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 4dbb0ee23432..de000649f9f3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -113,6 +113,7 @@ static inline struct nfs4_label *
 nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	struct iattr *sattr, struct nfs4_label *label)
 {
+	struct lsm_context lc; /* Scaffolding -Casey */
 	int err;
 
 	if (label == NULL)
@@ -122,7 +123,9 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 		return NULL;
 
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
-				&dentry->d_name, (void **)&label->label, &label->len);
+					    &dentry->d_name, &lc);
+	label->label = lc.context;
+	label->len = lc.len;
 	if (err == 0)
 		return label;
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 8dd21133ede8..ba9bcdbfaebe 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -304,8 +304,8 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 int security_add_mnt_opt(const char *option, const char *val,
 				int len, void **mnt_opts);
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
+					const struct qstr *name,
+					struct lsm_context *cp);
 int security_dentry_create_files_as(struct dentry *dentry, int mode,
 					struct qstr *name,
 					const struct cred *old,
@@ -676,8 +676,7 @@ static inline void security_inode_free(struct inode *inode)
 static inline int security_dentry_init_security(struct dentry *dentry,
 						 int mode,
 						 const struct qstr *name,
-						 void **ctx,
-						 u32 *ctxlen)
+						 struct lsm_context *cp)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 5e35adb43d65..7069ff857f58 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1029,17 +1029,11 @@ void security_inode_free(struct inode *inode)
 }
 
 int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen)
+					const struct qstr *name,
+					struct lsm_context *cp)
 {
-	struct lsm_context lc = { .context = NULL, .len = 0, };
-	int rc;
-
-	rc = call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
-				name, &lc);
-	*ctx = (void *)lc.context;
-	*ctxlen = lc.len;
-	return rc;
+	return call_int_hook(dentry_init_security, -EOPNOTSUPP, dentry, mode,
+			     name, cp);
 }
 EXPORT_SYMBOL(security_dentry_init_security);
 
-- 
2.19.1

