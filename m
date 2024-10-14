Received: from sonic306-26.consmr.mail.ne1.yahoo.com (sonic306-26.consmr.mail.ne1.yahoo.com [66.163.189.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DBB1CBE85
	for <selinux@vger.kernel.org>; Mon, 14 Oct 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919010; cv=none; b=atIDII+/TbwORrAE445wejaTygAb8YZFHpIoQcLHLCqQ2fJUjn3P0RAx+b352HMI1H+4aTBlkrN+mcIC68ZkV5dPEEhiHr5AMuSM2TQDabHg//vbLBtiPiQBBaPQaLAXZDThATQAk7kNtECcwe47i8dSjHpB6nAaWejbUqb9hnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919010; c=relaxed/simple;
	bh=ere3Kik7ftPK6JxZZEH1M4sTcj2ctKVjykePBsYfvpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yh+OibR+OUQ0aKwc1ccj5cDqNunu+G1CWYv+Ydd6cLAe/9Lr00q8ODgKCbou2s/NQASxXZ97GkypkXZ9YrrzB9QPoksO7L8oL2zbMBQAqXfZYbFRM+8G7nKhfOfIaRPJZ09yVRfoTQz7WgjOnaRPgbi0JeC19yvYtvzv5bh427o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gYSUmj87; arc=none smtp.client-ip=66.163.189.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gYSUmj87"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728919001; bh=4mPAELSUVvG9/ofHl8szvzOPyVtLeNBqQjj3M7dfO1s=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=gYSUmj87/E4MaLUI3kYq+WTu4gWEBybgIBo0t2D5fx2b7QEhs6Vz+zwBEfXw6BfUfZ9NZDGkpeLshGwqUwduQZS3je0uCfn4mGbIWcdIj46Omtxr1LKGVSye2isEr+hu3PCHKjoKbW3y/QV9zBPdhgQMeMLquacMQiGL1DdwbH7DGp08fwhc1yVmyQpWQlFsAh2Hq9N6Xm/oFbsshVyuCN1sZIbS4gzf9h/+v6/cyMCqnmW98wURDNhw/ZwS6wk/TMARIefyvkjnecpwyCBpmsMRAxmXg7QIQpRNgIrV0Blhgtvc2HBuOoKi/uaqtFKXARRzs0XpDcoRFq5D+4GyKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728919001; bh=jFa+mINhES7O4LMEYk9qLq+vQaOIKIkdPdzQH4HUFZ7=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=cqbxzyrKZDNVivxHNaPq2JWULQKNeXGcmThZzg8iO0cJQi7v8JxYTVxitxouMyMMNqTOTZiZ8TtjLgiCockx45odXVCX7kCdIx1pFRXG1z4IEiaJgqWhBQ4fzcwxddjJTyJynCHczFi1cAP7lSVxfLAwuGl/Ntf6iau2q+jl5ksIbsQc2LCO18YcUhqBlfR+hRx89E8tp41VMGn6AQCH3rd5o3+c5FyhlaJ5YbRMlq05HZm4GGC5ydub9irm9FvHURDQLLRAV4TgPz3VwRGZqp9syC6Grq4pA+depuluLAlVjJ+RXaPqCC1ijYr85GvihRZ+AypturFMqbV2dle/lA==
X-YMail-OSG: HvSVcxsVM1nfLFDIqwzaKr1UAy3fczXkWcmuTFjBnolzySaKGN1egkZMDDKiDCc
 pK6imXmU2gK.evT2xE_H3YKyV64a1k4xSXsdnz23aTBlLOlazJuyuwBxkFp5Moznp7DjGtlpgWzY
 69N9msQCzdK_2ayCXx_u3tYckwug8g4vulZC_7hfPjM4YJtZGP0gh8ze6lBbgCjIGDQo.tBLw15D
 uTFALTdKHjuAbApp4d09cerYx9N9AJb62UUdjDIj5e.v9Z2GSPHZMhnHt7DPDgNrDKZXHVXzdFUH
 TwjzfzW5_J5hukrLJslm1BnvTEgPWMxZgPVQmjqdEAQoX.qmed4T2.14.rEL.SIre8Gc2ZCU5cCU
 IWhiWgvOUwGzHt7aa05twc5oehUdmRdwpjJ2l0Ge8mEM4L_Tz9CcyAgKlIP0OeMin.NQZOSFd5lI
 GijP0ohouQ1HIzlzr2mN9NJ55DlEjHUdKnr8uw5gZITKSLkmtSdt47.1tA7XtMpkaogGI6oNOXoN
 ZGmoW4ep48t12eSzDFzqSAbqR2hhzkYXIFFXLoZEDraEhRnArPcfePqwM0A2WMuIPCoc7aH4IZ2D
 SB.dxCAaZwjaoit7odj1.5CWygjbGUsWpBvwgwRsgUQOcc9oPUTyrO8iMwjun4tg6Z0pXU46ckAb
 A83aUU93P1owxZCTtRV8o2m78qu8FK0Q4e5CVfsclYfFcz4etk7avcmSK_ahZm_TUiI7iin3KhFZ
 s9a2faXMQBd9x6CwdxcOn8yZ5oie1H_LvrawwaFc9dp5ut7COSCJSHenAE58XknPRPaGS1AS2ma3
 eqN_Ok52Y2POr6BSuGarModugIzFOuvtecADK03qxynQ22tbupv0xu6panHb4lcpREXcA7PABCrd
 kMkk0MT8ebj0xM36RxOBFmZ70rMEDPDwrQNXgIGePTuXiBp9qCe8mav.3H_zxFZiukSHMGwBiFxr
 arIbuJVHgyWWLwnjfCNrKiOVTRGRatlVXwVY3L481mGa6uJiZPOETwWr4mUfoHDfobNOZulcDWvo
 8I0enii__l0cwTrHSyPRNGOtJq4.SKnXV8srwZwpeR3NcqeQww72dXs8tiywSG06ceJr8M2zQJaQ
 rKOjZAECIFTvIHxIGFe_gcyc6P5ocBqdK4fgV1jAIOWtxiM7H0hWyteDy._DrZBLwuV2FKsveTIw
 2a6oeFKpRiv8ItZaDiiWVWCwKc1XfcJKnNGl934M5KuV8XVV2SepXT7ovymLCrUgVyA3cH10ymzq
 FNCu84ec0knSyAUI.L1yK8bLEt16XbMF5u0i3AAik8V5VDu6ffs40qVqa.MW4jBa_x6ph627Cxx4
 RpUhhU0ei3337QrGqDiqfWxDHs4izk_0jB1L4Z3PXFNzELnLRoBhCgymTq8R95fEfuT2f2evgdd9
 d1kyi5BHnRgakvh23IluOGoOKe44DavJFBDFQPC8f9oXH8_XRwqwskBAKWlPvaS7F50N8V_8A8m0
 _nea1MLVARkmSHqcFC149tkIxqGUyp_Ds4K4ZT_Py9MU45hLDz91TawwmvziOerRQK6f.bNoV7FU
 i3K7FYC9TNOIPmI.UJHrQpFvkzIeFQ.HA_SoCTFL_derM8Xq4LxQfPqtRclCZhyCk6UUDw0eSQyL
 J3F.4fmrN_GD6plralhnCrQnhf9NQfUuslSF2SOCdOD8edgDkqJs1OdW2Ji0yTJl8kfE9eE9us6t
 Qh3s6QoL5fis7AW.IUo0eGevisQTLRV9snfS4v9lddwwrpVyGwoyWthGu3WfkCdBjCVuqx8TRfNW
 OqhTwF4Q_4G6ftBppeEGjtYnJIlT4qOaYvVPhh6X1yNllwaetMU7PiddMtd91VhUyvj24_CBfTfV
 3rCDPDOmwBiT.Rq2YNsQo3P2q4sYGwuSzGFzTfl.HGdWhN_aQ0RlgvmPrHjqOauCYi6yWORlC.1f
 x0hqGQllwDpKaCpXkCDXrWxqzWOGZsNHSkrE.nSGuRkZaqd5oo1eAP7UnZHedLdZtyV0ZJpxibLB
 HOMbLCMnOiLJZmwEzhhbHnuA.lMJIGN.bKxeS_nfC9.vVWZWZRO9hSKZNT4TBXJKljigTppohzh.
 .0RTnnAsEhzZwxEMNHn4ASQzhomtsWHLAhbRoBCnhz82NAa7q3fYUsglDtm4Jbe2KwcArCJdBTMN
 e5IV8KIfhbLpjX4cAUJAldSQLsO9S0vui8QVrgfpLbPEh6ASOh6KyOsfS21l1VKSk3QpW9hIbCJP
 fDYNX0FgTI5gPFyfzLnPORE7TTHTEEAIxkmOopYsbSljyP96Ad5e2aeYRyUk5kiu.KKK0.F49u3C
 Uqkj__sdZCg84cmA.uvFqdc4VET_SNDCywxiifQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 304cb278-0e6e-4e01-8cca-c232728638e4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 14 Oct 2024 15:16:41 +0000
Received: by hermes--production-gq1-5d95dc458-4hqnr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8dd3ed09a3dd7dbd0509b276d789cdef;
          Mon, 14 Oct 2024 15:16:38 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH v2 6/6] LSM: Use lsm_context in security_inode_notifysecctx
Date: Mon, 14 Oct 2024 08:14:50 -0700
Message-ID: <20241014151450.73674-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241014151450.73674-1-casey@schaufler-ca.com>
References: <20241014151450.73674-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the lsm_context structure in the security_inode_notifysecctx()
interface. Its sole user is already using lsm_context to store
the data.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/nfs/inode.c                | 3 +--
 include/linux/lsm_hook_defs.h | 3 ++-
 include/linux/security.h      | 4 ++--
 security/security.c           | 7 +++----
 security/selinux/hooks.c      | 5 +++--
 security/smack/smack_lsm.c    | 6 +++---
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index d00a6304133a..9bd38c0f3b09 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -359,8 +359,7 @@ void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr)
 
 	if ((fattr->valid & NFS_ATTR_FATTR_V4_SECURITY_LABEL) && inode->i_security) {
 		error = security_inode_notifysecctx(inode,
-						fattr->label->lsmctx.context,
-						fattr->label->lsmctx.len);
+						    &fattr->label->lsmctx);
 		if (error)
 			printk(KERN_ERR "%s() %s %d "
 					"security_inode_notifysecctx() %d\n",
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index e2f1ce37c41e..afadbce8bb60 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -301,7 +301,8 @@ LSM_HOOK(int, -EOPNOTSUPP, lsmprop_to_secctx, struct lsm_prop *prop,
 LSM_HOOK(int, 0, secctx_to_secid, const char *secdata, u32 seclen, u32 *secid)
 LSM_HOOK(void, LSM_RET_VOID, release_secctx, struct lsm_context *cp)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
-LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
+LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode,
+	 struct lsm_context *cp)
 LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
 LSM_HOOK(int, -EOPNOTSUPP, inode_getsecctx, struct inode *inode,
 	 struct lsm_context *cp)
diff --git a/include/linux/security.h b/include/linux/security.h
index 3ad59666e56c..6dcb0046531d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -570,7 +570,7 @@ int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(struct lsm_context *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
-int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
+int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);
 int security_locked_down(enum lockdown_reason what);
@@ -1563,7 +1563,7 @@ static inline void security_inode_invalidate_secctx(struct inode *inode)
 {
 }
 
-static inline int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static inline int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 1d57e4e1bceb..c961edb0af57 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4387,8 +4387,7 @@ EXPORT_SYMBOL(security_inode_invalidate_secctx);
 /**
  * security_inode_notifysecctx() - Notify the LSM of an inode's security label
  * @inode: inode
- * @ctx: secctx
- * @ctxlen: length of secctx
+ * @ctx: LSM context
  *
  * Notify the security module of what the security context of an inode should
  * be.  Initializes the incore security context managed by the security module
@@ -4399,9 +4398,9 @@ EXPORT_SYMBOL(security_inode_invalidate_secctx);
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
 {
-	return call_int_hook(inode_notifysecctx, inode, ctx, ctxlen);
+	return call_int_hook(inode_notifysecctx, inode, cp);
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b9286c2c5efe..6aeb8468e568 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6656,10 +6656,11 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
 /*
  *	called with inode->i_mutex locked
  */
-static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static int selinux_inode_notifysecctx(struct inode *inode,
+				      struct lsm_context *cp)
 {
 	int rc = selinux_inode_setsecurity(inode, XATTR_SELINUX_SUFFIX,
-					   ctx, ctxlen, 0);
+					   cp->context, cp->len, 0);
 	/* Do not return error when suppressing label (SBLABEL_MNT not set). */
 	return rc == -EOPNOTSUPP ? 0 : rc;
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c9ec4d93fb13..c5d7652395c1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4887,10 +4887,10 @@ static int smack_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
  * Now that there's a list such a hook adds cost.
  */
 
-static int smack_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static int smack_inode_notifysecctx(struct inode *inode, struct lsm_context *cp)
 {
-	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, ctx,
-				       ctxlen, 0);
+	return smack_inode_setsecurity(inode, XATTR_SMACK_SUFFIX, cp->context,
+				       cp->len, 0);
 }
 
 static int smack_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
-- 
2.46.0

