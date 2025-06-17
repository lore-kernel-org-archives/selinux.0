Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F72F005A
	for <selinux@vger.kernel.org>; Tue, 17 Jun 2025 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194690; cv=none; b=M/l5HkkWteRSrzbxcSZ8Zwt+axnu1y85q0QBlZAnyvYizPeiOBvmOLBDZtvChAt+WZDH1Y4rgEW6A3EYMEwKV5i3ZES96k9EF9aOJ0HIaS4hilNPQVgdW4DX2SbfD588/zAXcBAYdFnU6dzOOc2tZpCU/66zhtFJPN/hzBTz9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194690; c=relaxed/simple;
	bh=s6Zlbdl8RXwqc2QBqLF39ACjWvYfI+KbaL3DtQhXQ0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPRzyqiV2SDmE/1Bp/LPEeuRcZDcAjaIZ4v6UnL4FpWllGK/2nf2RUW38TSXBWk/5R8PjiDOL0tfY0Hr6333lrvfRyx4bX3pt6b91WHZAsNWJ7LLTtv9LqpNdk8v+GSa3LTTLjLogarWmEqj0sNMLFKvWMezNANrT0JahTM04/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CvbnbsIa; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CvbnbsIa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750194682; bh=xkBYRFAHX7ZhFADk14XFnsgj0mIElQL2qR7XvnrGWF8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=CvbnbsIaFvtUCUtloXlXjqSHOg8D+kKtkZwGWdLXa/KDat7GeMmRocrSVM8W2Al7Km+XtalnCoRMwnPoDs8GdBf8ihPccz27oja7vAb85LAf8IkKbgiCPiVfg9XppCWIY9Koq2HRZe6KkF9snrDrOTKNFSEWTFkwBXx7aeikdRXs0Rd8etTaJZkd/mG6kbCgbuwyi8lVaO5Jzjs5DO2exquUKzqMOyvwRTJgdFqNNSBm/CsSVSEk9lj0157Ea3bCuI29Of5nynlWtxGyPI3fDWLlfbhYdBBwzpvTqplcGtRLY5vJyu3Ajc4sPzFDbCnQOs+PCULdw/eWOubeeNGJVQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750194682; bh=KKUsDDcOUbBY1Ln7hnWtzmWL2Pd2N72hymMb2VKjPq4=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=lv772AqNJXG1Iof10MTojBiLa06KugABYhBg0sPTq/8G9wUNE5M9MfF09u3/q4VNDHLCUMo+/QmTj0WKaf5SXBz8UbzxKn8Oo8/tX4bxfuXiFuWd2zhZeD2HgOx/ITiciJXPDPtMDHIqe4ypingP8NLby4d1zphFgf7TKLlvocJq0hEg0fUDPhqnN3YSLKnxb+d1ylOziGsfijurBrT3A1JF5LZCmLVssvEo2nNUa1TLVMorIiP9nN4mbS1mRM6qf68/tMihwu+mM1IrVNXVzRHaOYRnAJYUbgdu9wOPwtYD1MwMoC6XkeQZS6zySfJ7425YVONMaj8DC3b0HJE+bg==
X-YMail-OSG: KZRtb5YVM1lVDF9XgijnLRCF2Xol2vu1vFyI_i2uLuYWS9r62LW3OEcXWxsP6wr
 3_QzUJJQ_A2pqzm_OVNaFaJHOFfiEJUB882XtfgCuWwCUxe_wps1lxyA7mrHc6AMb_U7IHGnQveX
 YNN.vkZ2ycfWZpwfgjTnEPcrEs96aRX83CZi7b1m5NWghXP3IKoFFuWhpk2KJzB53YaKKCaA4bA2
 H9n2K6GYSwZaGD9bUz.qAdu036bMw55AR1R_Yb8_84.EfGkUy8y3jNjHFMv8DZ91t8cjL30ngC5j
 6dMHU9Jo3q2dNsZdQJpeE0NtH6NwVfFVEDdxuVHwoQvr8mcPbkfsdoeoXqKcQ1AFhN3s8KNFxwpj
 tzLo3eC9pXmIvnsTi2H9e5.w_4G80q_2CJhAKSui8P52Ah5SutOex4_JV6anTgl9D4Rh.okqCkPN
 eIbVOrr2rWOYkPiBok79vVYtyZzyUX8j29dxw0UtmuOMJMWw23GAe_eDVl7xAoWnpLqSw6yGx2hf
 q179kaHDeOSeiRf_pofl3s92aA3hPUflKb_87KQ7wIx.NScTIHqdlgfvofI2g.ZRcWxDVu92.Wf9
 N1ZtjUvC9lVroYAT9JxcY.m_fXZ1nQlwqEkpZSxeLt2EN3n6bv3OCAIDNyx1KPuX9u2S.tCAIjot
 Va.BZ6PE5V2Rjh_gFlRnCBFzLYYbgHI6GuODeTS19WH7cXZX9Twb8nxhf4OgRKjA8DDps4yTRXZz
 fvxX7upR4wn8b6CAVdo995RFrTJEqghApcTPhZ5zS1S9eN7WkW4Ga5aCcc_KV_El86uAdRPM.ulU
 vhJUMouHyjq6iSnkYKZPbkbnv44NEGaee28Q4dJqn_9lYze7iZ_VFS4PJ04HdEN6NCInUi_d79Gq
 tGQQakmxnaUQnXMjL0sf48dn1DdQy._57oSLcBNd3hkzGbPaCGy9pF_iGVJwRzlhM6GGApXc2Vt3
 dJbA1FDK3qReNp2E0RoQ0o4xUe7I.8hGd_hUwbE6_zixYsrGOGzWAvukgjNk1P3eIbKnXAU68aoc
 ckQ.r90TGDvRttHskLLAxWecsagXHvKEKef0R7c8mt24Tuk9d5b25CHW3tmw2NsJ2gFRdJtT7RBG
 hYgVi1zX8otdendmprOVwY6xBCYkSEhWSMRBVK8kw9WvusEVgNEVZnJ2LEiNwz0V.YXKIp89jWNI
 9xOv4rY_mVy.njTxgg7n3PNQY0g30cgTtjw1SK5YMHxMbDiwpmqp.TCPk96hbOEskG7XH.Uns9qn
 n0sJa6uBgPvYVcwhEE7w6tip8dnno_ZJcYBbQXBOPpngy4W5ekRrE76JoJyXwMib7Hg036frG0F9
 HCUaYQWX6ITbjf6eRQkkI3lvZ98dJGp_AR5faXMHaEGYy4.zPE08p13KaGpjsQ.2hT0RMpFZb3GY
 FVMn7aUOIQGgkfpf3nHZtn7jhClp6kehRVLKF6zupbkr._IHp3l.WMrH7xrduGlHFoXUfcNx4qCh
 oUyFAPgYakmKDZ72RhYXSMPSN0pY9kkNoOhq.Zs9FtDttPkUAPdAIP0QZSIynjMEj2z9E.554kgw
 nKUTV7Mu2k.bA_nnl8bYv2NhyYXRyao3xYwIDaiUeaXoFN7OcxQEjotptaJQ6bE48pCyuO_Qkk1Q
 cOUxL1wMpqbqjf__fwBy0kqKUtnq_lscAlbsm0e2GlkqOuLdBchT.Dh.SYp3_jJ_U9KBOmRwa.pc
 hLRKF01GaxckjpZvVZxc1UPK6wTClLd837nhHAeCnu1LA.WP2mx7Aev4WzDE0RZvC_Pewa3VEDR1
 coIhpfPY5FZvxXb0N230eUg5mm4YqHxQDgNQ3V1rfGbxbI8HLjj__5IAsEKw7N9o_6LYzJsKf4.w
 _9I4DLP0Ea1reJd.J9.ktdNlEXv7rkPH509nS9K1jX0K17nsUfEX06NPT2JqhNZM1OHWX.BcyF46
 DO0NgClvf6geIkhHAU0IWawc2hsG72gb2Pk5SG.QeupqR3Xlv19oUJSn4AB.xxC_gTxXzcMbDRjd
 hFPvgF34jRI7JIBmZg1K6XjGyAqjHg9DYphlXW53165czptIp9uPctDBOfYqUBBSkvyRdw4_DnI3
 X5gbo50ZEgPCgi1yfxMoPGS0uM9sQIlKsT5Mq9iE7URUsTmDcmTxI9FFvFckmqzEjSDNHQ2DA7xf
 bhbZWjGoNVmepRESXrQnkq4WRaqqQxqPcqVz5Za2K9zbi54n0CeOxRAts5EF9HtPtB34a4F120bV
 c3IrowqtY13FYBJzGbB7FP2sh8pq7DNmWki7b3EynaW0lvYboJ4Sx5pWQk.jfwbJz0UPt2fE042b
 pK09WEF2aW8LGUxEYQiWGw9Ysfpjd
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7d08d374-ec9d-4edb-9e4d-1b9affbe8ac1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Jun 2025 21:11:22 +0000
Received: by hermes--production-gq1-74d64bb7d7-f4j4n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c2f63bee58180d330568dcd5f1b3323;
          Tue, 17 Jun 2025 21:01:14 +0000 (UTC)
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
Subject: [PATCH 3/3] LSM: Infrastructure management of the mnt_opts security blob
Date: Tue, 17 Jun 2025 14:01:05 -0700
Message-ID: <20250617210105.17479-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250617210105.17479-1-casey@schaufler-ca.com>
References: <20250617210105.17479-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move management of the mnt_opts->security blob out of the
individual security modules and into the security
infrastructure. Blobs are still allocated within the modules
as they are only required when mount options are present.
The modules tell the infrastructure how much space is required,
and the space is allocated if needed. Modules can no longer
count on the presence of a blob implying that mount options
specific to that module are present, so flags are added
to the module specific blobs to indicate that this module
has options.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c        | 14 ++++-----
 security/selinux/hooks.c   | 58 +++++++++++++++++++++++-------------
 security/smack/smack_lsm.c | 61 ++++++++++++++++++++++++++------------
 3 files changed, 85 insertions(+), 48 deletions(-)

diff --git a/security/security.c b/security/security.c
index ec61fb7e6492..01fa3b5336b0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -843,17 +843,14 @@ int security_fs_context_parse_param(struct fs_context *fc,
 				    struct fs_parameter *param)
 {
 	struct lsm_static_call *scall;
-	int trc;
-	int rc = -ENOPARAM;
+	int rc;
 
 	lsm_for_each_hook(scall, fs_context_parse_param) {
-		trc = scall->hl->hook.fs_context_parse_param(fc, param);
-		if (trc == 0)
-			rc = 0;
-		else if (trc != -ENOPARAM)
-			return trc;
+		rc = scall->hl->hook.fs_context_parse_param(fc, param);
+		if (rc != -ENOPARAM)
+			return rc;
 	}
-	return rc;
+	return -ENOPARAM;
 }
 
 /**
@@ -927,6 +924,7 @@ void security_free_mnt_opts(void **mnt_opts)
 	if (!*mnt_opts)
 		return;
 	call_void_hook(sb_free_mnt_opts, *mnt_opts);
+	kfree(*mnt_opts);
 	*mnt_opts = NULL;
 }
 EXPORT_SYMBOL(security_free_mnt_opts);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f7eda0cce68f..b00c78e0a650 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -378,15 +378,28 @@ static void inode_free_security(struct inode *inode)
 }
 
 struct selinux_mnt_opts {
+	bool initialized;
 	u32 fscontext_sid;
 	u32 context_sid;
 	u32 rootcontext_sid;
 	u32 defcontext_sid;
 };
 
+static inline struct selinux_mnt_opts *selinux_mnt_opts(void *mnt_opts)
+{
+	if (mnt_opts)
+		return mnt_opts + selinux_blob_sizes.lbs_mnt_opts;
+	return NULL;
+}
+
 static void selinux_free_mnt_opts(void *mnt_opts)
 {
-	kfree(mnt_opts);
+	struct selinux_mnt_opts *opts;
+
+	if (mnt_opts) {
+		opts = selinux_mnt_opts(mnt_opts);
+		opts->initialized = false;
+	}
 }
 
 enum {
@@ -641,7 +654,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	const struct cred *cred = current_cred();
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	struct dentry *root = sb->s_root;
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(mnt_opts);
 	struct inode_security_struct *root_isec;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
 	u32 defcontext_sid = 0;
@@ -657,7 +670,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	mutex_lock(&sbsec->lock);
 
 	if (!selinux_initialized()) {
-		if (!opts) {
+		if (!opts || !opts->initialized) {
 			/* Defer initialization until selinux_complete_init,
 			   after the initial policy is loaded and the security
 			   server is ready to handle calls. */
@@ -695,7 +708,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 * also check if someone is trying to mount the same sb more
 	 * than once with different security options.
 	 */
-	if (opts) {
+	if (opts && opts->initialized) {
 		if (opts->fscontext_sid) {
 			fscontext_sid = opts->fscontext_sid;
 			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
@@ -1004,7 +1017,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
  */
 static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 {
-	struct selinux_mnt_opts *opts = *mnt_opts;
+	struct selinux_mnt_opts *opts;
 	u32 *dst_sid;
 	int rc;
 
@@ -1019,12 +1032,12 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		return -EINVAL;
 	}
 
-	if (!opts) {
-		opts = kzalloc(sizeof(*opts), GFP_KERNEL);
-		if (!opts)
+	if (!*mnt_opts) {
+		*mnt_opts = lsm_mnt_opts_alloc(GFP_KERNEL);
+		if (!*mnt_opts)
 			return -ENOMEM;
-		*mnt_opts = opts;
 	}
+	opts = selinux_mnt_opts(*mnt_opts);
 
 	switch (token) {
 	case Opt_context:
@@ -1051,6 +1064,7 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		WARN_ON(1);
 		return -EINVAL;
 	}
+	opts->initialized = true;
 	rc = security_context_str_to_sid(s, dst_sid, GFP_KERNEL);
 	if (rc)
 		pr_warn("SELinux: security_context_str_to_sid (%s) failed with errno=%d\n",
@@ -2650,10 +2664,7 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 	return 0;
 
 free_opt:
-	if (*mnt_opts) {
-		selinux_free_mnt_opts(*mnt_opts);
-		*mnt_opts = NULL;
-	}
+	selinux_free_mnt_opts(*mnt_opts);
 	return rc;
 }
 
@@ -2704,13 +2715,13 @@ static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 
 static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 {
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(mnt_opts);
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 
 	if (!(sbsec->flags & SE_SBINITIALIZED))
 		return 0;
 
-	if (!opts)
+	if (!opts || !opts->initialized)
 		return 0;
 
 	if (opts->fscontext_sid) {
@@ -2808,9 +2819,13 @@ static int selinux_fs_context_submount(struct fs_context *fc,
 	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
 		return 0;
 
-	opts = lsm_mnt_opts_alloc(GFP_KERNEL);
-	if (!opts)
-		return -ENOMEM;
+	if (!fc->security) {
+		fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
+		if (!fc->security)
+			return -ENOMEM;
+	}
+	opts = selinux_mnt_opts(fc->security);
+	opts->initialized = true;
 
 	if (sbsec->flags & FSCONTEXT_MNT)
 		opts->fscontext_sid = sbsec->sid;
@@ -2818,14 +2833,14 @@ static int selinux_fs_context_submount(struct fs_context *fc,
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
+	struct selinux_mnt_opts *dst;
 
 	if (!src)
 		return 0;
@@ -2834,7 +2849,8 @@ static int selinux_fs_context_dup(struct fs_context *fc,
 	if (!fc->security)
 		return -ENOMEM;
 
-	memcpy(fc->security, src, sizeof(*src));
+	dst = selinux_mnt_opts(fc->security);
+	memcpy(dst, src, sizeof(*src));
 	return 0;
 }
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1d456df40096..e88de89a5bc1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -544,6 +544,7 @@ static int smack_sb_alloc_security(struct super_block *sb)
 }
 
 struct smack_mnt_opts {
+	bool initialized;
 	const char *fsdefault;
 	const char *fsfloor;
 	const char *fshat;
@@ -551,24 +552,37 @@ struct smack_mnt_opts {
 	const char *fstransmute;
 };
 
+static inline struct smack_mnt_opts *smack_mnt_opts(void *mnt_opts)
+{
+	if (mnt_opts)
+		return mnt_opts + smack_blob_sizes.lbs_mnt_opts;
+	return NULL;
+}
+
 static void smack_free_mnt_opts(void *mnt_opts)
 {
-	kfree(mnt_opts);
+	struct smack_mnt_opts *opts;
+
+	if (mnt_opts) {
+		opts = smack_mnt_opts(mnt_opts);
+		opts->initialized = false;
+	}
 }
 
 static int smack_add_opt(int token, const char *s, void **mnt_opts)
 {
-	struct smack_mnt_opts *opts = *mnt_opts;
+	struct smack_mnt_opts *opts;
 	struct smack_known *skp;
 
-	if (!opts) {
-		opts = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
-		if (!opts)
+	if (!s)
+		return -EINVAL;
+
+	if (!*mnt_opts) {
+		*mnt_opts = lsm_mnt_opts_alloc(GFP_KERNEL);
+		if (!*mnt_opts)
 			return -ENOMEM;
-		*mnt_opts = opts;
 	}
-	if (!s)
-		return -ENOMEM;
+	opts = smack_mnt_opts(*mnt_opts);
 
 	skp = smk_import_entry(s, 0);
 	if (IS_ERR(skp))
@@ -601,6 +615,7 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
 		opts->fstransmute = skp->smk_known;
 		break;
 	}
+	opts->initialized = true;
 	return 0;
 
 out_opt_err:
@@ -622,10 +637,12 @@ static int smack_fs_context_submount(struct fs_context *fc,
 	struct smack_mnt_opts *ctx;
 	struct inode_smack *isp;
 
-	ctx = lsm_mnt_opts_alloc(GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
-	fc->security = ctx;
+	if (!fc->security) {
+		fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
+		if (!fc->security)
+			return -ENOMEM;
+	}
+	ctx = smack_mnt_opts(fc->security);
 
 	sbsp = smack_superblock(reference);
 	isp = smack_inode(reference->s_root->d_inode);
@@ -655,6 +672,7 @@ static int smack_fs_context_submount(struct fs_context *fc,
 				return -ENOMEM;
 		}
 	}
+	ctx->initialized = true;
 	return 0;
 }
 
@@ -668,16 +686,21 @@ static int smack_fs_context_submount(struct fs_context *fc,
 static int smack_fs_context_dup(struct fs_context *fc,
 				struct fs_context *src_fc)
 {
-	struct smack_mnt_opts *dst, *src = src_fc->security;
+	struct smack_mnt_opts *src;
+	struct smack_mnt_opts *dst;
 
+	src = smack_mnt_opts(src_fc->security);
 	if (!src)
 		return 0;
 
-	fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
-	if (!fc->security)
-		return -ENOMEM;
+	if (!fc->security) {
+		fc->security = lsm_mnt_opts_alloc(GFP_KERNEL);
+		if (!fc->security)
+			return -ENOMEM;
+	}
 
-	dst = fc->security;
+	dst = smack_mnt_opts(fc->security);
+	dst->initialized = src->initialized;
 	dst->fsdefault = src->fsdefault;
 	dst->fsfloor = src->fsfloor;
 	dst->fshat = src->fshat;
@@ -787,7 +810,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	struct superblock_smack *sp = smack_superblock(sb);
 	struct inode_smack *isp;
 	struct smack_known *skp;
-	struct smack_mnt_opts *opts = mnt_opts;
+	struct smack_mnt_opts *opts = smack_mnt_opts(mnt_opts);
 	bool transmute = false;
 
 	if (sp->smk_flags & SMK_SB_INITIALIZED)
@@ -820,7 +843,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 
 	sp->smk_flags |= SMK_SB_INITIALIZED;
 
-	if (opts) {
+	if (opts && opts->initialized) {
 		if (opts->fsdefault) {
 			skp = smk_import_entry(opts->fsdefault, 0);
 			if (IS_ERR(skp))
-- 
2.47.0

