Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CA317C99B
	for <selinux@vger.kernel.org>; Tue, 17 Sep 2024 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726617231; cv=none; b=pQIZw+dbvwRp4+ITygMhkNra9FNHf/AF6ACarJdv08vScvh68+V1juVQB+/tvCtYE+ce3AXUwRDWJ9Rd1+MpjZ4pbNCyp3kPb7WEtFIYdGMMpBdQ5qu+c/HjnCQ97z6phytX+iYVsabTIYlnqx7K2e0djHYZolXF9u2m1fY9c9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726617231; c=relaxed/simple;
	bh=pkiJFK4UWzbihdSQP0/vZjet04jCTlLQiH9p+ugfN30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCm5jx/DPMmoiP0CjfSH1mpAwVgeecbM8YPSTQPVt0qpx3OLk6dI5+FJYZAJz6eq0k5XT2uRDXXgX3LiMP61NyXvon1Urw47PwzurHqKr7uRLH3pL/2mefVcPkn70UVx4vrzUMmmNMLYiN8OQjVWNXuAFG1mKqfzVHtWpFGRzy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=aN8vqmnN; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aN8vqmnN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726617229; bh=rLl2LsJz48bPh17xjOUIrSgVKkITvgpZAh47LFR7xMg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=aN8vqmnNvDZ9BXRzktIgzepVFtdZlUF4dPa1lIpwYmmOT1vXW/R4wv6k4ODw1Qzy9PDOiVp1pxP4Z7/DpGy0Rm1r1Ps4nTmWfjO00YRbQN5U73RztbNJ8j5KXpo8ODCe2gCaoKxQJaG94z7PyL06NoyPjc0M1bNhtfDnDmXH5IM1ZLm0pG+X/j0ukg2GRZSJsRgw67vPp0blbsapjaZXnVWdp0y7O9bo8ZcspL6/Y2Z0V852O3cSC+keGzh9YKjmkdFBZgFPdN6qCdt1Z5lg1Q9F2UxrJQviSyQcp/SZJ3SunBVjZ7nyj9WtqsECiZVkYGhvoDIlnYVv6Zvn9AQ3zw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1726617229; bh=nzurJyaw6wgzma+7cmEzE6ah9+uczsB0t0PcMV6REn8=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=LKU9+0/gvBKTcCFnLN7LCno1U/mJ7fcHeVCpO9lYHh/76ImSMiIJ61ieoS2n9apfzPY0mGF/n/rV128jmEEcCcyiVeDzejZxDActMvXnmx4HP582HBFMqXKwv6KfNjSMug5BjgWFGjjZzbdEsk2lMYM1GVQ0N4k7Le9728p20NhlHRWnRbvYnb/CFWVox6lyCh8A3lDSmQMc3Onzlo9xPYVGg4ns4fj92umBbMwOCGuflwaw+oMgvyR/9WX855pu6UCeSWi/UEf3EsSaL8SqnXwmnScBTRYggvTT0so83c+YQYePQsqVk76nxlGVUEKJYmUs6Gm3VhpQdkhZuLUyXQ==
X-YMail-OSG: 9eU7_wcVM1laETl53qEnKCSjr0kkFXb.xJgXYCSOr6MkDXYTAMXOSuvSlWqlLZf
 JLhBbiiC18K2VxlKHIuX4404UpN_C8eGNK.aBdNX__bIgb9VVQkWbxX4osFhUlLdnKF40l6.l241
 n5FU6e.gJlcH.lv0NhxHjFRIppcs4sK1HlvoAzysImgdaNiVuD2NvWuVAYR6oHtI26VUxe29w6jM
 KIHoz6uIvFpCs7IOkoLvlJMic.DU_zNs26z4VbBTCQNMJ8GdPX6dY7BEN2Qs5SpIgkqMTD8Ujfqm
 UHrvRAh3C6i.gLjWDzaWvdOJ2nF4b5AbHFbk.DomhQD_Dq2xxF5G2H5LDB0oXNkwGIL3xGXxDxZ1
 I.lYHNxsgmdO54NpIMvS5h7HymIcsHN1XRYVTdxchoZ.3tOknWdBdtzPcqHtNzJz4xDQZrC1_K1u
 KTpeNT2peNRAAqUU9yJOmVx1q0HnQhxaAfUBhlVZWpIO6jE1QbAYvzGVOHoKUBxdRziaJaygE_hQ
 jhTFBW9hSrqwESUmgISL1arujRb5VSdVZly5BXIX.mW2wo9iAqOFhBYssAYrPtnraLCsOWXbEQTf
 fWY.n0KQ8UxFyr6hvAlGmOs1VjZ2kHU9m8YNwssFf6vlxGEmC5Wtf5gJv.Q6R0BXPPbYvcLaGaHu
 VK_1Einto98Wk28eUuOaPAFaAadKQlZDrXASEZQNLh1BhQNnI5bh5MHf32GTBUmLzsM7k0DTGRLF
 gVF1wBLuj.DGGIGF1xR5Ws5X84nxrqQ1hIyHANTT1N34GOE6K.X81wNIXqQwaD94tN2Y8LmJsWeD
 DVDRvLTV9sc0xKBHRMWso5eNmfNmghAB2zlUhRHXXaqRTvpjJ58cIIrDthWc_TF.NW.lFkQIvaj_
 wmGIftu1AApaPAdlzHx.1eR2vg4RYqUwz3homsCl0tlbsViID0oHMTMAWyXL4vzsqo0hYOJemf.2
 bGTN_Qej_EMEQzsYzuxnoakmeWDtoMinN9lvKe6KU7q8QOI0mlGSAYk7Wam_H.KjCj5r31xTjDCc
 Az.LASenrltwT4_69Vfno07cyIs_AIvmiVMWJsIv2iROFk4dheP3oGWxNkuy9eEJksw2Ho19Gy5m
 jYMCLqOrbbJoA9xIHaDGMW0ojd3sSzLzc3Pip0IsXyNeAgxyz_kp7joe5nBf4y3YHl.LdHQSwZzc
 BZ4ZICkW54Qy1kH1bKOuBgsOXDG984wZVUp69p76TxsxL1BqEnKNTMnlvdYy6K7vswn7NUpVQ0_K
 4W5ctq8tA7op1GAAThDezp_3Xev3NqRQOICIFSM5H3YOce8IvQ6EZapcQUIlZhfCIfjeD.RsdtjH
 GcS34MyJtl6jNUPllYRZc2iolWJgjKrvBQHYlLOCb1SSThgCvP5BfZaE2xTlWH8wd28MvdJLsM54
 hSNgeP8cQMokZuP2qcdMoCxbBJskHKXvNu7T0kb4KC2p5k1P_DoCry_mnNe9uwz4fmZozCasooiD
 vEZB_XIYdIUFFmnI9L544wRL9lwU2G_0ZjL7bZYyAHhxc9lyNjZxNf.DBrLU22ztjNDcn88hnTN.
 heO0ZDZcdo4yQWuSp.M1BF7Jb1aJfsWQGzkZ4Uaj8g6G88TPkwwHMonfOmLe5EcKmDR2XGUdydVr
 Bx4nLJamTDNmLUOp00bcBP_sMUWbTmD3pczhjTrvQSSXn3W9R_1Hg5RYXAAwfOlR1fMPmHp41ArJ
 n01e2Xmxbm36acFAxvxqfxDUN1aoSNiNfw5B6gRTbqbWNkXLYAw1dSL2RH2LMpp.gp8CGOdSzwcf
 ObMO5HvuVpAOam5c3hKSmSgN9v3LKc.PmogDXPNj8U0QGYdyuA4lcFLwLbC3ssHuluQfzkGWh85v
 A4x.QNQuei2U2uCGi11Y.Pzo5XPMCxYUQd.z983kRNeiwIjebFKJMz.DytRY8hpvcO4oAQkAWMW0
 .WviA7EyDMQvvY8iSS1vxiC0Zh_O5EZ.ZdrhY86THG0h8kiYsx7nzQ5onmMn3wNFgst9AX0H0Yl8
 PQyI12a4mzsBf6Yt46HbmS7t.J6uAyeI7DXgJx7lxa64Fwl5oDanQ8He_ny0eRkz1UisZvOoDtBZ
 F7.6Xu0PsqB8_E1IAJgtjsC8tHX4L8drGoQslh9ebj_OcDxPwsYyGH918e2vw3JMwMuHURB4r1M9
 jlP_nVRk21b81vGjY4WJxBcszfFrcrI3w2hostNs9xsPnYDhGVFF7e5KRVAReZCSwRZlA7Yf6yp1
 b73x6vGDntWCd1aJoCEtdOx85kGPLWW6OceWdQSU4veYnLuQA6yZKT_Z1VjWuXxrfkHt0eMSuK46
 qlGSo_Jd5fVdYHCuQe08E8ce43OQ1TXsbp.w-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9f23d04c-1822-4eae-a91e-9d5266c6a30e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Sep 2024 23:53:49 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 41ac41609d6122fff099bda257412a4d;
          Tue, 17 Sep 2024 23:53:45 +0000 (UTC)
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
Subject: [PATCH 5/5] LSM: Use lsm_context in security_inode_notifysecctx
Date: Tue, 17 Sep 2024 16:52:02 -0700
Message-ID: <20240917235202.32578-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917235202.32578-1-casey@schaufler-ca.com>
References: <20240917235202.32578-1-casey@schaufler-ca.com>
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
index 056ddc876cb5..4323a39c14c1 100644
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
index 6b671f4ada03..0216aeb4a3fd 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -298,7 +298,8 @@ LSM_HOOK(int, -EOPNOTSUPP, lsmprop_to_secctx, struct lsm_prop *prop,
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
index c9c4845da3a6..1b1411fff6ac 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -555,7 +555,7 @@ int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(struct lsm_context *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
-int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
+int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);
 int security_locked_down(enum lockdown_reason what);
@@ -1536,7 +1536,7 @@ static inline void security_inode_invalidate_secctx(struct inode *inode)
 {
 }
 
-static inline int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
+static inline int security_inode_notifysecctx(struct inode *inode, struct lsm_context *cp);
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/security.c b/security/security.c
index 020e7a89de16..44639d193ecd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4268,8 +4268,7 @@ EXPORT_SYMBOL(security_inode_invalidate_secctx);
 /**
  * security_inode_notifysecctx() - Notify the LSM of an inode's security label
  * @inode: inode
- * @ctx: secctx
- * @ctxlen: length of secctx
+ * @ctx: LSM context
  *
  * Notify the security module of what the security context of an inode should
  * be.  Initializes the incore security context managed by the security module
@@ -4280,9 +4279,9 @@ EXPORT_SYMBOL(security_inode_invalidate_secctx);
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
index 93188e124f99..382c63d67743 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6665,10 +6665,11 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
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
index b443859948e9..1dfc4292ea15 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4906,10 +4906,10 @@ static int smack_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
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

