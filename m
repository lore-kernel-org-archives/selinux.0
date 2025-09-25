Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE1130DEC4
	for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820352; cv=none; b=dgmj7OYqEFV8YeP+GtrqVFL/3ClaMYNO8Qr5oRH7GUX283axbkiUYypHmW9xWq3q+5/YwZoB6rNHsrgULgELYGy+OTHTv9dPa+u5sYWnDQtnQ730pUoupc+Mex8bdz9BzzQ+STDWKSymxAF1PU3Im9j4vkQuXmvdmKnpbKoU364=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820352; c=relaxed/simple;
	bh=hzpEUG5WmxOd+cY3ckf15AQRQIVh/KHLddBzLpHiwF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJziG37SOfamZHM4ktOL46l4nuIb3Tjglh4T9IYqASNU6/irpavMusZ9p4g+dpkUQNtJVIn2lo1/Gp93Oy0Od3IHhLyzdhUjYZouzkHlsIL0MvWSk5acAgpPVc6wMG5FcfZSddXqJ+R/rNoj1MB3T+8lTIn1bFwsSikAH16cTqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=f91K7JlR; arc=none smtp.client-ip=66.163.184.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="f91K7JlR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758820348; bh=fOAt/RSwEHVaWDF0i0xEFlXoJPD9CsV9Lz6l5OSIqIg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=f91K7JlRN7UZFPV/6APetJxP/4DbYs6wbIFXLdMkjSLE/9YReyu+ZHLrh4WT6m/6COTvbmhdYVAGHG43sIXiZSeuT/Q0sAnN6m6UXc6E3Vv1a2pgkG9x734B1YWqe6gnDdy1fm1RDPHjRqA67w0woWF/5RnGv10U2D+rPSgJEP1SYstvEy59crodjHgcrklR3j+1QfxNFsIYmnd3DFbbQZpBnOEhubApjraluz0j+KXLXebwxiGN50h090TzhVig5U61GF/htQ56camiof69Qjqa1O2C5UUduV3Rz6NTbUe0HxBNVGfaGrWJNuW8mVDY46foawGZhsNOFGwzE3Y/fQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758820348; bh=w5EFE9PCy1T6UJCnR/p9KY13N3TrcgeZihOb0Kw172T=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Xrjbf8FcqcaroMrm3AX7wCQQuET0ToRkX46sm37DkWabJVsHr4mwWH6I7PYsawcsjJ4QaMWKCXQOTTAJ8E1Wzs/k99eFZR5mi7RFVKDp3zSyUxafcsBYC3BNHzvn8aE6FawOodF2J6mDy3gzaCe8OIB8G7dEGbwD8n3XQtL7CXEFMo9DW8a8YgmC1/Yej6zpd9n5R8XVuVVieXreVtNHPTzaHncXAJw5vuGny35vNh6Lq4V5R7EsBraFHOZSgTHadRzFS/A+x+DF7txrDx3FcwOjYxkr1J76Tqf/0A+RPbPoaU6t+D6lvNKWq/elzZqd66rWzbCHiMFAwKuh7rBe/Q==
X-YMail-OSG: Ty_FqwUVM1kmXTvggZceWg7TqGOaex4U8sUs.MDGsFSaak8MtA6xHFqdLf2gXd5
 GTmBnqzOen1z7.MpEp7DjUxULOzGrkyE0K_oKMgPK6eNkRXlOVJw9YLlhdCkmnhA4WMtp_UTh4WH
 6Z1wDY1Sgoqip6yyk4_i1Yb0UfVCBOUSnDF2nu_vlsg4SXWe6Rr4LOzNHmFNO8VUKYHtQhMyDPkC
 gaQhWnu6OWq67zDi.gZmXDSm32P3x7_opSJgW5oPwwCy9tKJDRkEA4hn5O0xMbhrrCAZqu7._6dU
 C1TDWmZHMm.EdHio3S7ANdAJ6Y7O.8pQZPhvZe1gQosngjwdfOxpW1ZFTu7_DdeGJLIZon3vlh1U
 MvFpwuYjqJC14XUNZwO1rwzYedRMGx8ogqiZsgzcwx.QzfXIT1uNJV9FkxHICOiJvdGDzCfOEb8P
 bC2sBLozfXhnbvv5dd5FJjt2kd0PlhSLhWVbvRJCaG31F_bHVEW56rkoem15j9gygEXd0841Oxqw
 B7SQ3EgnQYMfiQsdufW0R.WLNdz._qdUDzFrtRsEKSX6BWrbQTNHffF9m1TF9CCcw1vaqnVL7e4b
 T6VWbulNxU3LBJkMi9_2MrULOw148yET5hOypoDGGze8WOziehCsE1hrvuSy_F8RDoAAgdTtt3_.
 e8LjEMLs0PQg.AIEMEtgJEBIowYWMZPrDB5ewd.vFs5TDbKWKSAzxZ0Na00SN10DqX5Wt5tCcR5F
 N.UElDPMxXNxsqNIHN1689sRouLWaIlK_NNMlrk.l03hl3e.WBNYDy0lGsf1YFrj3PZ3NZW6pjcd
 QHbsj_b5UNqCi4D4FtoECqm_1PzKIXpfHaPoTFObiGMAVsD5Vt0o1BL8WE560oy4mHjXx6Z7kuWo
 X0XoJHTmK0wfGazcWZ7n6G9N28._o7KMWqmiEJh1E1DbNdrxHuqSqwNb2AMVm7AvcgFx3wPrlwPr
 NTWK1h9rjwuURw6aYyqSPXawLn9GM.aU4euIieL4PLvCoHKcB266Cf0J0aPWOJK4J6LX6Hb_kOwv
 DztNv5psXsCS8QxU6XIGCcQ43arxXfXbnuAi2SxFJ7aJr4k5wp7L1K2RJpFKbvzbw.iBaqTFRhHG
 CikTOdbeKNuM3DDV6DviZRWJohNUX0KlFFpDe75sqr.s_70ruGuY5ltZW3s4aJhfJCMOLa7lMrui
 XhA9qrJFlDc16yIg7htObTgYBCF2IUpPiWH5PV.B25Kc30Mg7KP.wP6YK9S1qzCGEEfx0v1so881
 hMPuPwkCHNPQ2YWa7Dsijcf3zgJjnKHERls.O0FpF2nIkuw2gn8tiJdit6BUGDCzJ7oKbuVVFc1d
 G5hFavcKqfXsAhVwLWryxo47QEGucqNyYqk16ptD2NdGCZz74BDFF3Ns49XelySCyU.05lF_ZUt0
 5n8fS6gUPZk_YEWqGXo.ASJFJz4q8ljBgc.HpFn7WNy453EBorG3xFHoSnxNgyaeRa67XtFzYiAL
 Kmpp6rA38aRRA0fw96q7osedENoqovsUVg_rpZgQ5mTzZfnbbOIkuYHWwmJugCnnv.Jmjg3fnWsX
 oj17M22iHYZ2GNsgVBGBmPlWq9EsRO3TB7XeK85kUVaVetxc3GXpRL1GsITCMtpoxaNHSJLP6flE
 .x_UgY03dwbMh.POeNaXhAwfI0Q6kDGeHVfelvMlAs9UWiG1KysPO4.ZN6Zq85TTpJVqYLfHyBvr
 EBR0YbYxUvveEPfDBn6sGyP8Rfl3bqGxbBlRTXZMIqXh.e2QqSH21Avu.rAazvyCiex72MlXsOKF
 XqI_qite02ig0cDnrukVCABfUeGMRcZM7.M1XTSzIabn3vuujHaOdQqv1_wJJ0UI9SKA.RJFTl.Y
 gblfg.lHoYKL2_wPoitR7EV8pD286sGGficyLSsBJ.zq49_qGPneFp0YX1rxhuYor89FrH2F0Ncq
 ehF6jez7RL1QbhRFbtLSRfTQ6LsSKgWerGyFNLJTeYaHzLlDKRGGD.tdPY6ZbcNjMx4M6Dse9yEs
 HFf5s5JkGeODms08Eq4rke.JZ7OODKXOk3.oFPoSvz7aySHu0NKAl4YASHtq7aBo6TCTjHynN8Dw
 PDHSKS..9p_dN5I1zsxhX8jlpztjZqoCj0KU0UcvFztlH27mLmXcnmKlL625IIjBPmNJOifYa4Dv
 T5rUEkMH6biQqh1MSIUjgpy.ZiM5Yb97unC5iBmoYGUSiS08ck64JMiOaGjeZnHbhsXXgJGQlXc5
 8clqSZmfDIym1mAkiE7NcOp0SDw16CcruwiStT84IuWxVP0r4kTHpis3YJB8TOH1mqhLGGNqwI0q
 gmWna4kV2lovIUojKYR6qym45
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3e55edb1-174f-46a8-8044-3ed2a8a359f3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 25 Sep 2025 17:12:28 +0000
Received: by hermes--production-gq1-6f9f7cb74b-bmbkz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6f3ba4c112cabb90c4068fa90708916c;
          Thu, 25 Sep 2025 17:12:22 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v2 2/2] LSM: Infrastructure management of the mnt_opts security blob
Date: Thu, 25 Sep 2025 10:12:08 -0700
Message-ID: <20250925171208.5997-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925171208.5997-1-casey@schaufler-ca.com>
References: <20250925171208.5997-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move management of the mnt_opts->security blob out of the individual
security modules and into the security infrastructure.  The modules
tell the infrastructure how much space is required, and the space is
allocated as required in the interfaces that use the blob.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c               | 42 +++++++++++++++++
 security/selinux/hooks.c          | 75 ++++++++++---------------------
 security/selinux/include/objsec.h |  8 ++++
 security/smack/smack.h            |  8 ++++
 security/smack/smack_lsm.c        | 44 +++++-------------
 5 files changed, 92 insertions(+), 85 deletions(-)

diff --git a/security/security.c b/security/security.c
index 8390410aec91..b16c0843dafa 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,7 @@
 #include <linux/overflow.h>
 #include <linux/perf_event.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <net/flow.h>
 #include <net/sock.h>
 
@@ -1337,6 +1338,19 @@ void security_bprm_committed_creds(const struct linux_binprm *bprm)
 	call_void_hook(bprm_committed_creds, bprm);
 }
 
+/**
+ * lsm_mnt_opts_alloc - allocate a mnt_opts blob
+ * @opts: pointer to options
+ *
+ * Allocate a mount options blob.
+ *
+ * Returns 0, or -ENOMEM if memory isn't available.
+ */
+static int lsm_mnt_opts_alloc(void **opts)
+{
+	return lsm_blob_alloc(opts, blob_sizes.lbs_mnt_opts, GFP_KERNEL);
+}
+
 /**
  * security_fs_context_submount() - Initialise fc->security
  * @fc: new filesystem context
@@ -1348,6 +1362,13 @@ void security_bprm_committed_creds(const struct linux_binprm *bprm)
  */
 int security_fs_context_submount(struct fs_context *fc, struct super_block *reference)
 {
+	int rc;
+
+	if (!fc->security) {
+		rc = lsm_mnt_opts_alloc(&fc->security);
+		if (rc)
+			return rc;
+	}
 	return call_int_hook(fs_context_submount, fc, reference);
 }
 
@@ -1364,6 +1385,13 @@ int security_fs_context_submount(struct fs_context *fc, struct super_block *refe
  */
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
 {
+	int rc;
+
+	if (!fc->security) {
+		rc = lsm_mnt_opts_alloc(&fc->security);
+		if (rc)
+			return rc;
+	}
 	return call_int_hook(fs_context_dup, fc, src_fc);
 }
 
@@ -1386,6 +1414,12 @@ int security_fs_context_parse_param(struct fs_context *fc,
 	int trc;
 	int rc = -ENOPARAM;
 
+	if (!fc->security) {
+		trc = lsm_mnt_opts_alloc(&fc->security);
+		if (trc)
+			return trc;
+	}
+
 	lsm_for_each_hook(scall, fs_context_parse_param) {
 		trc = scall->hl->hook.fs_context_parse_param(fc, param);
 		if (trc == 0)
@@ -1455,6 +1489,7 @@ void security_free_mnt_opts(void **mnt_opts)
 	if (!*mnt_opts)
 		return;
 	call_void_hook(sb_free_mnt_opts, *mnt_opts);
+	kfree(*mnt_opts);
 	*mnt_opts = NULL;
 }
 EXPORT_SYMBOL(security_free_mnt_opts);
@@ -1470,6 +1505,13 @@ EXPORT_SYMBOL(security_free_mnt_opts);
  */
 int security_sb_eat_lsm_opts(char *options, void **mnt_opts)
 {
+	int rc;
+
+	if (!*mnt_opts) {
+		rc = lsm_mnt_opts_alloc(mnt_opts);
+		if (rc)
+			return rc;
+	}
 	return call_int_hook(sb_eat_lsm_opts, options, mnt_opts);
 }
 EXPORT_SYMBOL(security_sb_eat_lsm_opts);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4bba9d119713..1ccf880e4894 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -383,11 +383,6 @@ struct selinux_mnt_opts {
 	u32 defcontext_sid;
 };
 
-static void selinux_free_mnt_opts(void *mnt_opts)
-{
-	kfree(mnt_opts);
-}
-
 enum {
 	Opt_error = -1,
 	Opt_context = 0,
@@ -640,7 +635,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	const struct cred *cred = current_cred();
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	struct dentry *root = sb->s_root;
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(mnt_opts);
 	struct inode_security_struct *root_isec;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
 	u32 defcontext_sid = 0;
@@ -656,19 +651,13 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	mutex_lock(&sbsec->lock);
 
 	if (!selinux_initialized()) {
-		if (!opts) {
-			/* Defer initialization until selinux_complete_init,
-			   after the initial policy is loaded and the security
-			   server is ready to handle calls. */
-			if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
-				sbsec->flags |= SE_SBNATIVE;
-				*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
-			}
-			goto out;
+		/* Defer initialization until selinux_complete_init,
+		   after the initial policy is loaded and the security
+		   server is ready to handle calls. */
+		if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
+			sbsec->flags |= SE_SBNATIVE;
+			*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
 		}
-		rc = -EINVAL;
-		pr_warn("SELinux: Unable to set superblock options "
-			"before the security server is initialized\n");
 		goto out;
 	}
 
@@ -1003,7 +992,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
  */
 static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 {
-	struct selinux_mnt_opts *opts = *mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(*mnt_opts);
 	u32 *dst_sid;
 	int rc;
 
@@ -1012,19 +1001,14 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		return 0;
 	if (!s)
 		return -EINVAL;
+	if (!opts)
+		return 0;
 
 	if (!selinux_initialized()) {
 		pr_warn("SELinux: Unable to set superblock options before the security server is initialized\n");
 		return -EINVAL;
 	}
 
-	if (!opts) {
-		opts = kzalloc(sizeof(*opts), GFP_KERNEL);
-		if (!opts)
-			return -ENOMEM;
-		*mnt_opts = opts;
-	}
-
 	switch (token) {
 	case Opt_context:
 		if (opts->context_sid || opts->defcontext_sid)
@@ -2620,17 +2604,14 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 						*q++ = c;
 				}
 				arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
-				if (!arg) {
-					rc = -ENOMEM;
-					goto free_opt;
-				}
+				if (!arg)
+					return -ENOMEM;
 			}
 			rc = selinux_add_opt(token, arg, mnt_opts);
 			kfree(arg);
 			arg = NULL;
-			if (unlikely(rc)) {
-				goto free_opt;
-			}
+			if (unlikely(rc))
+				return rc;
 		} else {
 			if (!first) {	// copy with preceding comma
 				from--;
@@ -2647,18 +2628,11 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 	}
 	*to = '\0';
 	return 0;
-
-free_opt:
-	if (*mnt_opts) {
-		selinux_free_mnt_opts(*mnt_opts);
-		*mnt_opts = NULL;
-	}
-	return rc;
 }
 
 static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 {
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(mnt_opts);
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 
 	/*
@@ -2703,7 +2677,7 @@ static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 
 static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 {
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(mnt_opts);
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 
 	if (!(sbsec->flags & SE_SBINITIALIZED))
@@ -2800,14 +2774,10 @@ static int selinux_fs_context_submount(struct fs_context *fc,
 	const struct superblock_security_struct *sbsec = selinux_superblock(reference);
 	struct selinux_mnt_opts *opts;
 
-	/*
-	 * Ensure that fc->security remains NULL when no options are set
-	 * as expected by selinux_set_mnt_opts().
-	 */
 	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
 		return 0;
 
-	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	opts = selinux_mnt_opts(fc->security);
 	if (!opts)
 		return -ENOMEM;
 
@@ -2817,20 +2787,22 @@ static int selinux_fs_context_submount(struct fs_context *fc,
 		opts->context_sid = sbsec->mntpoint_sid;
 	if (sbsec->flags & DEFCONTEXT_MNT)
 		opts->defcontext_sid = sbsec->def_sid;
-	fc->security = opts;
 	return 0;
 }
 
 static int selinux_fs_context_dup(struct fs_context *fc,
 				  struct fs_context *src_fc)
 {
-	const struct selinux_mnt_opts *src = src_fc->security;
+	const struct selinux_mnt_opts *src = selinux_mnt_opts(src_fc->security);
+	struct selinux_mnt_opts *dst = selinux_mnt_opts(fc->security);
 
 	if (!src)
 		return 0;
+	if (!dst)
+		return 0;
 
-	fc->security = kmemdup(src, sizeof(*src), GFP_KERNEL);
-	return fc->security ? 0 : -ENOMEM;
+	*dst = *src;
+	return 0;
 }
 
 static const struct fs_parameter_spec selinux_fs_parameters[] = {
@@ -7337,7 +7309,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
 	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
 
-	LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
 	LSM_HOOK_INIT(sb_mnt_opts_compat, selinux_sb_mnt_opts_compat),
 	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
 	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 1d7ac59015a1..cefc6c550f74 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -245,4 +245,12 @@ selinux_perf_event(void *perf_event)
 	return perf_event + selinux_blob_sizes.lbs_perf_event;
 }
 
+static inline struct selinux_mnt_opts *selinux_mnt_opts(void *opts)
+{
+	if (!opts)
+		return NULL;
+
+	return opts + selinux_blob_sizes.lbs_mnt_opts;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/smack/smack.h b/security/smack/smack.h
index bf6a6ed3946c..828c913dd62d 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -367,6 +367,14 @@ static inline struct socket_smack *smack_sock(const struct sock *sock)
 	return sock->sk_security + smack_blob_sizes.lbs_sock;
 }
 
+static inline struct smack_mnt_opts *smack_mnt_opts(void *opts)
+{
+	if (!opts)
+		return NULL;
+
+	return opts + smack_blob_sizes.lbs_mnt_opts;
+}
+
 #ifdef CONFIG_KEYS
 static inline struct smack_known **smack_key(const struct key *key)
 {
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1f236014e7d8..c83bb85ee1b5 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -551,22 +551,13 @@ struct smack_mnt_opts {
 	const char *fstransmute;
 };
 
-static void smack_free_mnt_opts(void *mnt_opts)
-{
-	kfree(mnt_opts);
-}
-
 static int smack_add_opt(int token, const char *s, void **mnt_opts)
 {
-	struct smack_mnt_opts *opts = *mnt_opts;
+	struct smack_mnt_opts *opts = smack_mnt_opts(*mnt_opts);
 	struct smack_known *skp;
 
-	if (!opts) {
-		opts = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
-		if (!opts)
-			return -ENOMEM;
-		*mnt_opts = opts;
-	}
+	if (!opts)
+		return -ENOMEM;
 	if (!s)
 		return -ENOMEM;
 
@@ -622,10 +613,9 @@ static int smack_fs_context_submount(struct fs_context *fc,
 	struct smack_mnt_opts *ctx;
 	struct inode_smack *isp;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	ctx = smack_mnt_opts(fc->security);
 	if (!ctx)
 		return -ENOMEM;
-	fc->security = ctx;
 
 	sbsp = smack_superblock(reference);
 	isp = smack_inode(reference->s_root->d_inode);
@@ -668,22 +658,15 @@ static int smack_fs_context_submount(struct fs_context *fc,
 static int smack_fs_context_dup(struct fs_context *fc,
 				struct fs_context *src_fc)
 {
-	struct smack_mnt_opts *dst, *src = src_fc->security;
+	struct smack_mnt_opts *dst = smack_mnt_opts(fc->security);
+	struct smack_mnt_opts *src = smack_mnt_opts(src_fc->security);
 
 	if (!src)
 		return 0;
+	if (!dst)
+		return 0;
 
-	fc->security = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
-	if (!fc->security)
-		return -ENOMEM;
-
-	dst = fc->security;
-	dst->fsdefault = src->fsdefault;
-	dst->fsfloor = src->fsfloor;
-	dst->fshat = src->fshat;
-	dst->fsroot = src->fsroot;
-	dst->fstransmute = src->fstransmute;
-
+	*dst = *src;
 	return 0;
 }
 
@@ -741,12 +724,8 @@ static int smack_sb_eat_lsm_opts(char *options, void **mnt_opts)
 			arg = kmemdup_nul(arg, from + len - arg, GFP_KERNEL);
 			rc = smack_add_opt(token, arg, mnt_opts);
 			kfree(arg);
-			if (unlikely(rc)) {
-				if (*mnt_opts)
-					smack_free_mnt_opts(*mnt_opts);
-				*mnt_opts = NULL;
+			if (unlikely(rc))
 				return rc;
-			}
 		} else {
 			if (!first) {	// copy with preceding comma
 				from--;
@@ -787,7 +766,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	struct superblock_smack *sp = smack_superblock(sb);
 	struct inode_smack *isp;
 	struct smack_known *skp;
-	struct smack_mnt_opts *opts = mnt_opts;
+	struct smack_mnt_opts *opts = smack_mnt_opts(mnt_opts);
 	bool transmute = false;
 
 	if (sp->smk_flags & SMK_SB_INITIALIZED)
@@ -5048,7 +5027,6 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(fs_context_parse_param, smack_fs_context_parse_param),
 
 	LSM_HOOK_INIT(sb_alloc_security, smack_sb_alloc_security),
-	LSM_HOOK_INIT(sb_free_mnt_opts, smack_free_mnt_opts),
 	LSM_HOOK_INIT(sb_eat_lsm_opts, smack_sb_eat_lsm_opts),
 	LSM_HOOK_INIT(sb_statfs, smack_sb_statfs),
 	LSM_HOOK_INIT(sb_set_mnt_opts, smack_set_mnt_opts),
-- 
2.51.0

