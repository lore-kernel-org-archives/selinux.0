Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.163.187.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544139;
	b=SA9jO8syq79Q+QiS4aeEGSHikfwLWcvOUeW+JbLJ8c2Cw4/ms8svYCjmEtkKUYb0jXGH
	 rSN8knjhpY3Iu0fIm2L/H4rU42xVQzKBlXidZJWOA31fSNOPtXASEcfo/IH2vpftvABcT
	 pieXP7Mi6nbCZVVmOchovVoQVl5QKYnZ4uPu9q1jKi4CO4kbhlpZTjDs7YQNH1qzGE0Md
	 JXdpsr14fSgsTGS0RK1D0GwU0oVqwMGzYbNF7Vt0lks4S3aJuTuJkDIzIa0CsxNoUCop1
	 T2cSKXzD/YCbfz4fgz0X6E81ENuUtQe5We6pxMEpI5ZPuDF7XHkpMQ3xg/wmaHIH2mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544139;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H8ppf2zOXgbD3+owtrC2KtNyAvjsA6HjZYms9KRRLOY=;
	b=aXoMqImbeRD21MfWZr37z14Iwjzl8x2rS3TTOoXV9J8Q+gwQexGihi4/C0Z68fj2tze9
	 AW5rTR+SpSL+Kb80HFSD13Uy2fTzLEE0GiLS5oK0HDtIZA/YByyYip61KoLcQVEvuxxoR
	 5jMe1fz9Qlbm7VMjWssVjiMQ/yDoy8h8BHGmBKzATly9BFk3zkp0oqR+8ioeykDud7LiT
	 fxhC0pGFtZq8fxCdq929qkPTEN7nfGB+8dAk+cvkoAydBN51U0VBtrMikJv7SR3ri3VV7
	 YoumGcwEFk5OBrYJS9zhgC0GqkEqDHl8u+fL96wLo13+nCpat9LDgCfxR5OBiMDDS0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=schaufler-ca.com;
	spf=pass smtp.mailfrom=schaufler-ca.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=cqCOrC01;
	arc=none smtp.remote-ip=66.163.187.38
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241B606A321
	for <selinux@vger.kernel.org>; Tue, 24 Nov 2026 18:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F241B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=cqCOrC01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1795544137; bh=H8ppf2zOXgbD3+owtrC2KtNyAvjsA6HjZYms9KRRLOY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To:Content-Type; b=cqCOrC01LbhQXhDdf4Ihctcz7S94FwO+N9wFeWZd+pTxoiPCr79P4PDlazU/pZQKE33tPPcKlL4Y56zAeW9Bkc+A4i0Aeb/FZdNAdH83gM/yuYgzOT5ZqHgBiX+ox8+o4H26HheDp1CsqKeIKVK3nQDQq/fi9zy8a7Cn0SX1jhrEsgr9WTDQ2wwQaQFJTBTjFfTxUZqZAv8bNAZLMiELpafdp24wCtBgfXDfH7xyfv/fVPdvJe9EfHHm9lcS44AXdT+zFCIBGXqxBRk2zv+riO9l5KF92NP4f65cjqaDx6ZrEwGaVNNWBgAPvqRbpEU8Zp4O1FettrsLR2xnujUQPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1795544137; bh=oJFKhjNSuaa4YYT86xqGwEQEALYrq9vYEihdHZbe6P8=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mHmq4O/oGnxhKDx4Wre4d4ClyrbT3bwJtFySicrNJaLmOqWyN9savZuZu+MOOrKhw1x1C2pTkm/WQhbT5Wyx+yNfv1YJKi4xT/P+3ycK0kkqV2CHdbBoaK4yV+6JRTb03Rpsk/8fYz2saOoI55enGSp0F18V22wwL7MGpfYtZ5+5zhfFoRyr+JOASOmJhE8WnHIg036U4GojOT9RmS/DmMK/jE0MYZjbRRXht90gIcIkwYrfICzhcVnyvd++prfmD+JH6k0KAd0QjFn3MEsYiX3nki/sb3mV8xGJa4Phk8dp4wkRdfRgzpUv/EYHMwRQXnZ911f7Ij5LLZK5VfdwoQ==
X-YMail-OSG: AgwFJPkVM1nA5v48KjeDiOrMTy7_PIzfFi6uB3mtvBQzbPq1sIqRoSyhQWhcp5h
 bzh_YsweBqXWCPqAXLyDX2dXZb072z46WThpjrpflPl8C.AoTKi45OOvXF0bT36w1i6mYy3knrVC
 WLMjAfThWUq2P.cnqxv75vFnFqYMIbrxdVL2O_XCCXUO8PYacb3GgbYGV7G7ntlapT4SaPEvFu4a
 tRmnYAbSpOZSDFbnHsMhG5hB1aW4Bzx7YURGuWPvWmVPYzpKTZXtEJPWfk9PQ2jepPfr5TyUgiZb
 EtRQj4tfVNncVRSMrQcTCd3AI6J6jhTUQOTgqe.UjwLZidqwZ78zA_wG8FwhhkUtFqijYaGIfFJg
 dlxumKBe8ljOmVZ7gSxlvSw4ghLZ65qYDIYDXN0viN4tJmPJ5ctpItL7nSW2Q4caAwLJFS73MRMM
 8sw7O9Cqys_2D3VdHE63VcAQiV0xsbocvK6uREybWF48Qg5JvG87lHThHFhUbRmRUrpcNLcNSTHf
 Gwhk9udbUWQSBQyZZLYDiHcsxC2uqv.VQ1lS7QMEGFGACp5Pq49nDdSy0QI1R7hY0NEIpD9l3gX0
 LMYN3ueHXUBeqMjhZ_MvnBBscjlov4Pgd7_BciyeDvKN32xifj34YaMeG_.lKtOjHWdHFySyP4tw
 YpL7aotWIbRmPthS3aj5t0idnbIOd8PH4xYPMPOWGAjZDUGen9E5i436PmoXZQCJ2SW7SG2U0592
 ErhoSHYyi9c7CE4cPtPajFLzoHXFbW3AOS6hB87lcTvseCjDNcnzbPMwWz3iBNJ0y5UgW5KwO6mv
 2csK4Oo93AyNrcvzIGcT6vpuD.4Aq.6lSTfSK6sJuyumLGIsWXF8i2N6rfU_d7LcfMX4_4zniIaw
 Ycur8QOtIeT8ayULu8D3jXrLktoJFH8ZXE4xMzUTu8AuO3wY1quokxFgchjTRNO5jw9QuZofEnTP
 4rRP7KIisz1Tjroh_lUx1gBYtbYyEsQUte2yogr0kdaCSPCs72fOErL5Tb_EKnc1r1EB5yOMRscG
 HFoUqGULkl4OJHszl7f4z75NmFSThlp9tMvCzU50M5Xb22alZiNs97Et3ax7LYGrsbKmaEOmljQG
 oXG826G6V2TLmeo8kIJn2m.SXE.hzJnNQfGhel1_AHFMcE88ykzWLWf8ZUlhPgBuf10S2WWMFVt6
 dVySyAa3QQ3nHT4Kw_n7FDNYdVjp1aoMOKQfYYK44EZLZuY7wdETlMf747EPKM4RiKLXUppWieNc
 rgN3KlR6l_bNJH7bMwfc9.jZ4qn.pUhIMlhi87P87cjRw9AP3mdzBYbX8zJHUAPETI1NL7WCXALC
 z2JDANmNH5KvMNDmCtvsgbgMXqCMZKfCg95zRZYOfr4ZSmc7BBryp2ybAEj6g9hOzOLqXaNmAydc
 VNOugt6M98cyODX07gZye89sBhAUUMBjOcWorkEYw3s5tyvl9q.UFPZMkf6ZI3YhB3T8YNwWxQ02
 xh8OrByVhl9K5q2SNMfjhPv8x3d9TxDKSuCUKjOGMQ0CJiDrGvPnFoTYEdyegyu4MhYspxXW1lTp
 NPo0_thGGTduGRwqm1sJg2SmTXnUKjJvVfCWQaDTFAvInb6GgXOJr5PB.RP8_gtqo.4NuQgIHxCV
 BYuLVs.4Cbg6j9LSMJ7fJMtdjEdSl4cgv.KtERGZPaEpz1VhHCgChnC5Oi4d8NixZkpLgsCfXsno
 OxsRsD7h8DaWcbmmvaHpDlFyP2mwyM_I8fyPGjVt4pQouvMcWbzIU1jlQLjK_we84ZDGOryOML3W
 nnXkHvT_mRLqhEr04K_AOrGFp23mVPQ_q7nJJeWYWr9vub7qy918mBFyO.QiDJsqWtu53mrt_j7W
 XxOIKIGM_uP4D9t9kv1m4vaDMrmWSQ3TLzjMBWhQe5HZ8CrYNtg_cGQ6oz33toqTB0H091sussq3
 .SX3DMXOaunhhxucafrI5MkQtEZr1vhM_TzF7yuU9LE0i1rj_06DOU8xRQyL_Kt6DpszDl0nxnbH
 RJRo.WKYSZg4LSe7Iu5yv8Rn4Cxtk2nUY10DasQmUVMJY_65KaXS_fKKNoYbArkKYwK7peYRNLa2
 5dXgJ6LpuUJuapfgbhD_44aoLqSLMaRPqSgjVi_File7CtngyJKSWLQr6.J1r1yCchcG24D1y3ru
 Ki2I3R2JhxH5yIi.Z03HAy4pybQ79BdHN.wUqBDUm7x0vzXdht0LXNNbtagDgma1Z6BwAgNc1X4L
 HWMuubI8iL5h1baPtTZWyZlwtMeI_M5jvrBalXKNrQ3c08mRxg0f5lerU.SysMlxZc9ic2i4OXO8
 DEGSaCEv1P64AMpw4KGb7TQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: df857c52-234d-45bc-9059-def931a7bc12
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Nov 2026 18:15:37 +0000
Received: by hermes--production-gq1-7c58b65db6-g64hz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 89675cfbe13ee0a2bc6abba71cb35f1a;
          Tue, 24 Nov 2026 18:15:35 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	selinux@vger.kernel.org
Subject: [PATCH 1/1] LSM: infrastructure management of mount options
Date: Tue, 24 Nov 2026 10:15:22 -0800
Message-ID: <20261124181522.30415-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124181522.30415-1-casey@schaufler-ca.com>
References: <20261124181522.30415-1-casey@schaufler-ca.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the management of LSM specific mount option data out of
the individual modules and into the infrastructure to the extent
possible. Duplication and freeing of mount option data is handled directly
in the infrastructure. Allocation is a bit tricker, as it is sometimes
delayed in the SELinux case.  A new LSM helper has been added for use
within the modules to ensure allocation is done properly.

Tested with both the SELinux and Smack testsuites, Also tested on a
Fedora 44 system with a modified systemd and both SELinux and Smack
enabled.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h     |  2 -
 include/linux/lsm_hooks.h         |  3 ++
 security/lsm_init.c               |  2 +
 security/security.c               | 29 ++++++++++-
 security/selinux/hooks.c          | 85 +++++++++++++++++-------------
 security/selinux/include/objsec.h |  8 +++
 security/smack/smack.h            |  8 +++
 security/smack/smack_lsm.c        | 86 +++++++++++--------------------
 8 files changed, 129 insertions(+), 94 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 65c9609ec207..a84fb73818bb 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -55,8 +55,6 @@ LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, const struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, const struct linux_binprm *bprm)
 LSM_HOOK(int, 0, fs_context_submount, struct fs_context *fc, struct super_block *reference)
-LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
-	 struct fs_context *src_sc)
 LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
 	 struct fs_parameter *param)
 LSM_HOOK(int, 0, sb_alloc_security, struct super_block *sb)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c4488c4a6d8a..a6bfc1b38790 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -120,6 +120,7 @@ struct lsm_blob_sizes {
 	unsigned int lbs_bpf_map;
 	unsigned int lbs_bpf_prog;
 	unsigned int lbs_bpf_token;
+	unsigned int lbs_mnt_opts;
 };
 
 /*
@@ -218,4 +219,6 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
 	return &xattrs[(*xattr_count)++];
 }
 
+int lsm_mnt_opts_alloc(void **opts);
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/lsm_init.c b/security/lsm_init.c
index a1ad641811de..f9751f45fbcc 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -316,6 +316,7 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 	lsm_blob_size_update(&blobs->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
 	lsm_blob_size_update(&blobs->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
 	lsm_blob_size_update(&blobs->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
+	lsm_blob_size_update(&blobs->lbs_mnt_opts, &blob_sizes.lbs_mnt_opts);
 }
 
 /**
@@ -460,6 +461,7 @@ int __init security_init(void)
 		lsm_pr("blob(bpf_map) size %d\n", blob_sizes.lbs_bpf_map);
 		lsm_pr("blob(bpf_prog) size %d\n", blob_sizes.lbs_bpf_prog);
 		lsm_pr("blob(bpf_token) size %d\n", blob_sizes.lbs_bpf_token);
+		lsm_pr("blob(mnt_opts) size %d\n", blob_sizes.lbs_mnt_opts);
 	}
 
 	if (blob_sizes.lbs_file)
diff --git a/security/security.c b/security/security.c
index 2ee276ab15c5..7f4841a83acf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,7 @@
 #include <linux/overflow.h>
 #include <linux/perf_event.h>
 #include <linux/fs.h>
+#include <linux/fs_context.h>
 #include <net/flow.h>
 #include <net/sock.h>
 
@@ -876,11 +877,23 @@ int security_fs_context_submount(struct fs_context *fc, struct super_block *refe
  * initialised to NULL by the caller.  @fc indicates the new filesystem context.
  * @src_fc indicates the original filesystem context.
  *
+ * Do the duplication here rather than leave it to the modules.
+ * The infrastructure owns the blob.
+ *
  * Return: Returns 0 on success or a negative error code on failure.
  */
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
 {
-	return call_int_hook(fs_context_dup, fc, src_fc);
+	const void *src = src_fc->security;
+
+	if (!src)
+		return 0;
+
+	fc->security = kmemdup(src, blob_sizes.lbs_mnt_opts, GFP_KERNEL);
+	if (!fc->security)
+		return -ENOMEM;
+
+	return 0;
 }
 
 /**
@@ -960,6 +973,19 @@ void security_sb_free(struct super_block *sb)
 	sb->s_security = NULL;
 }
 
+/**
+ * lsm_mnt_opts_alloc - allocate a mnt_opts blob
+ * @opts: pointer to options
+ *
+ * Allocate a mount options blob.
+ *
+ * Returns 0, or -ENOMEM if memory isn't available.
+ */
+int lsm_mnt_opts_alloc(void **opts)
+{
+	return lsm_blob_alloc(opts, blob_sizes.lbs_mnt_opts, GFP_KERNEL);
+}
+
 /**
  * security_free_mnt_opts() - Free memory associated with mount options
  * @mnt_opts: LSM processed mount options
@@ -971,6 +997,7 @@ void security_free_mnt_opts(void **mnt_opts)
 	if (!*mnt_opts)
 		return;
 	call_void_hook(sb_free_mnt_opts, *mnt_opts);
+	kfree(*mnt_opts);
 	*mnt_opts = NULL;
 }
 EXPORT_SYMBOL(security_free_mnt_opts);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 30776b0107f2..d150b448423b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -381,6 +381,7 @@ static void inode_free_security(struct inode *inode)
 }
 
 struct selinux_mnt_opts {
+	bool initialized;
 	u32 fscontext_sid;
 	u32 context_sid;
 	u32 rootcontext_sid;
@@ -389,7 +390,12 @@ struct selinux_mnt_opts {
 
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
@@ -646,7 +652,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	const struct cred *cred = current_cred();
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	struct dentry *root = sb->s_root;
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts;
 	struct inode_security_struct *root_isec;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
 	u32 defcontext_sid = 0;
@@ -659,10 +665,15 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	if (kern_flags && !set_kern_flags)
 		return -EINVAL;
 
+	if (mnt_opts)
+		opts = selinux_mnt_opts(mnt_opts);
+	else
+		opts = NULL;
+
 	mutex_lock(&sbsec->lock);
 
 	if (!selinux_initialized()) {
-		if (!opts) {
+		if (!opts || !opts->initialized) {
 			/* Defer initialization until selinux_complete_init,
 			   after the initial policy is loaded and the security
 			   server is ready to handle calls. */
@@ -690,7 +701,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 * will be used for both mounts)
 	 */
 	if ((sbsec->flags & SE_SBINITIALIZED) && (sb->s_type->fs_flags & FS_BINARY_MOUNTDATA)
-		&& !opts) {
+		&& !(opts && opts->initialized)) {
 		if ((kern_flags & SECURITY_LSM_NATIVE_LABELS) &&
 		    sbsec->behavior == SECURITY_FS_USE_NATIVE)
 			*set_kern_flags |= SECURITY_LSM_NATIVE_LABELS;
@@ -704,7 +715,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 * also check if someone is trying to mount the same sb more
 	 * than once with different security options.
 	 */
-	if (opts) {
+	if (opts && opts->initialized) {
 		if (opts->fscontext_sid) {
 			fscontext_sid = opts->fscontext_sid;
 			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
@@ -737,7 +748,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 
 	if (sbsec->flags & SE_SBINITIALIZED) {
 		/* previously mounted with options, but not on this attempt? */
-		if ((sbsec->flags & SE_MNTMASK) && !opts)
+		if ((sbsec->flags & SE_MNTMASK) && !(opts && opts->initialized))
 			goto out_double_mount;
 		if ((kern_flags & SECURITY_LSM_NATIVE_LABELS) &&
 		    sbsec->behavior == SECURITY_FS_USE_NATIVE)
@@ -1023,7 +1034,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
  */
 static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 {
-	struct selinux_mnt_opts *opts = *mnt_opts;
+	struct selinux_mnt_opts *opts;
 	u32 *dst_sid;
 	int rc;
 
@@ -1038,12 +1049,13 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		return -EINVAL;
 	}
 
-	if (!opts) {
-		opts = kzalloc_obj(*opts);
-		if (!opts)
+	if (!*mnt_opts) {
+		rc = lsm_mnt_opts_alloc(mnt_opts);
+		if (rc)
 			return -ENOMEM;
-		*mnt_opts = opts;
 	}
+	opts = selinux_mnt_opts(*mnt_opts);
+	opts->initialized = true;
 
 	switch (token) {
 	case Opt_context:
@@ -2703,18 +2715,20 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 	return 0;
 
 free_opt:
-	if (*mnt_opts) {
-		selinux_free_mnt_opts(*mnt_opts);
-		*mnt_opts = NULL;
-	}
+	selinux_free_mnt_opts(*mnt_opts);
+
 	return rc;
 }
 
 static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 {
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts;
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 
+	if (mnt_opts)
+		opts = selinux_mnt_opts(mnt_opts);
+	else
+		opts = NULL;
 	/*
 	 * Superblock not initialized (i.e. no options) - reject if any
 	 * options specified, otherwise accept.
@@ -2726,7 +2740,7 @@ static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 	 * Superblock initialized and no options specified - reject if
 	 * superblock has any options set, otherwise accept.
 	 */
-	if (!opts)
+	if (!opts || !opts->initialized)
 		return (sbsec->flags & SE_MNTMASK) ? 1 : 0;
 
 	if (opts->fscontext_sid) {
@@ -2757,13 +2771,18 @@ static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 
 static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 {
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts;
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 
+	if (mnt_opts)
+		opts = selinux_mnt_opts(mnt_opts);
+	else
+		opts = NULL;
+
 	if (!(sbsec->flags & SE_SBINITIALIZED))
 		return 0;
 
-	if (!opts)
+	if (!opts || !opts->initialized)
 		return 0;
 
 	if (opts->fscontext_sid) {
@@ -2861,9 +2880,15 @@ static int selinux_fs_context_submount(struct fs_context *fc,
 	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
 		return 0;
 
-	opts = kzalloc_obj(*opts);
-	if (!opts)
-		return -ENOMEM;
+	if (!fc->security) {
+		int rc;
+
+		rc = lsm_mnt_opts_alloc(&fc->security);
+		if (rc)
+			return rc;
+		opts = selinux_mnt_opts(fc->security);
+		opts->initialized = true;
+	}
 
 	if (sbsec->flags & FSCONTEXT_MNT)
 		opts->fscontext_sid = sbsec->sid;
@@ -2871,22 +2896,10 @@ static int selinux_fs_context_submount(struct fs_context *fc,
 		opts->context_sid = sbsec->mntpoint_sid;
 	if (sbsec->flags & DEFCONTEXT_MNT)
 		opts->defcontext_sid = sbsec->def_sid;
-	fc->security = opts;
+	opts->initialized = true;
 	return 0;
 }
 
-static int selinux_fs_context_dup(struct fs_context *fc,
-				  struct fs_context *src_fc)
-{
-	const struct selinux_mnt_opts *src = src_fc->security;
-
-	if (!src)
-		return 0;
-
-	fc->security = kmemdup(src, sizeof(*src), GFP_KERNEL);
-	return fc->security ? 0 : -ENOMEM;
-}
-
 static const struct fs_parameter_spec selinux_fs_parameters[] = {
 	fsparam_string(CONTEXT_STR,	Opt_context),
 	fsparam_string(DEFCONTEXT_STR,	Opt_defcontext),
@@ -7650,6 +7663,7 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
 	.lbs_bpf_map = sizeof(struct bpf_security_struct),
 	.lbs_bpf_prog = sizeof(struct bpf_security_struct),
 	.lbs_bpf_token = sizeof(struct bpf_security_struct),
+	.lbs_mnt_opts = sizeof(struct selinux_mnt_opts),
 };
 
 /*
@@ -7907,7 +7921,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	 * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
 	 */
 	LSM_HOOK_INIT(fs_context_submount, selinux_fs_context_submount),
-	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
 	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
 	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 2f21568251ff..2fe5e9bbab41 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -276,6 +276,14 @@ selinux_perf_event(void *perf_event)
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
 #ifdef CONFIG_BPF_SYSCALL
 static inline struct bpf_security_struct *
 selinux_bpf_map_security(struct bpf_map *map)
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 2a60a045b8cf..1549dcd8c916 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -386,6 +386,14 @@ static inline struct socket_smack *smack_sock(const struct sock *sock)
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
index 8e88ac65fd7f..e3a5da343aa8 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -43,6 +43,7 @@
 #include <linux/fs_parser.h>
 #include <linux/watch_queue.h>
 #include <linux/io_uring/cmd.h>
+#include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 #include "smack.h"
 
@@ -560,24 +561,22 @@ struct smack_mnt_opts {
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
+	struct smack_mnt_opts *opts;
 	struct smack_known *skp;
 
-	if (!opts) {
-		opts = kzalloc_obj(struct smack_mnt_opts);
-		if (!opts)
+	if (!s)
+		return -EINVAL;
+
+	if (!*mnt_opts) {
+		int rc;
+
+		rc = lsm_mnt_opts_alloc(mnt_opts);
+		if (rc)
 			return -ENOMEM;
-		*mnt_opts = opts;
 	}
-	if (!s)
-		return -ENOMEM;
+	opts = smack_mnt_opts(*mnt_opts);
 
 	skp = smk_import_entry(s, 0);
 	if (IS_ERR(skp))
@@ -625,22 +624,27 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
  * Returns 0 on success or -ENOMEM on error.
  */
 static int smack_fs_context_submount(struct fs_context *fc,
-				 struct super_block *reference)
+				     struct super_block *reference)
 {
 	struct superblock_smack *sbsp;
 	struct smack_mnt_opts *ctx;
 	struct inode_smack *isp;
 
-	ctx = kzalloc_obj(*ctx);
-	if (!ctx)
-		return -ENOMEM;
-	fc->security = ctx;
+	if (!fc->security) {
+		int rc;
+
+		rc = lsm_mnt_opts_alloc(&fc->security);
+		if (rc)
+			return rc;
+	}
+	ctx = smack_mnt_opts(fc->security);
 
 	sbsp = smack_superblock(reference);
 	isp = smack_inode(reference->s_root->d_inode);
 
 	if (sbsp->smk_default) {
-		ctx->fsdefault = kstrdup(sbsp->smk_default->smk_known, GFP_KERNEL);
+		ctx->fsdefault = kstrdup(sbsp->smk_default->smk_known,
+					 GFP_KERNEL);
 		if (!ctx->fsdefault)
 			return -ENOMEM;
 	}
@@ -659,7 +663,8 @@ static int smack_fs_context_submount(struct fs_context *fc,
 
 	if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
 		if (sbsp->smk_root) {
-			ctx->fstransmute = kstrdup(sbsp->smk_root->smk_known, GFP_KERNEL);
+			ctx->fstransmute = kstrdup(sbsp->smk_root->smk_known,
+						   GFP_KERNEL);
 			if (!ctx->fstransmute)
 				return -ENOMEM;
 		}
@@ -667,35 +672,6 @@ static int smack_fs_context_submount(struct fs_context *fc,
 	return 0;
 }
 
-/**
- * smack_fs_context_dup - Duplicate the security data on fs_context duplication
- * @fc: The new filesystem context.
- * @src_fc: The source filesystem context being duplicated.
- *
- * Returns 0 on success or -ENOMEM on error.
- */
-static int smack_fs_context_dup(struct fs_context *fc,
-				struct fs_context *src_fc)
-{
-	struct smack_mnt_opts *dst, *src = src_fc->security;
-
-	if (!src)
-		return 0;
-
-	fc->security = kzalloc_obj(struct smack_mnt_opts);
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
-	return 0;
-}
-
 static const struct fs_parameter_spec smack_fs_parameters[] = {
 	fsparam_string("smackfsdef",		Opt_fsdefault),
 	fsparam_string("smackfsdefault",	Opt_fsdefault),
@@ -750,12 +726,8 @@ static int smack_sb_eat_lsm_opts(char *options, void **mnt_opts)
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
@@ -802,6 +774,11 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	if (sp->smk_flags & SMK_SB_INITIALIZED)
 		return 0;
 
+	if (mnt_opts)
+		opts = smack_mnt_opts(mnt_opts);
+	else
+		opts = NULL;
+
 	if (!smack_privileged(CAP_MAC_ADMIN)) {
 		/*
 		 * Unprivileged mounts don't get to specify Smack values.
@@ -5145,6 +5122,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
 	.lbs_xattr_count = SMACK_INODE_INIT_XATTRS,
+	.lbs_mnt_opts = sizeof(struct smack_mnt_opts),
 };
 
 static const struct lsm_id smack_lsmid = {
@@ -5158,11 +5136,9 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(syslog, smack_syslog),
 
 	LSM_HOOK_INIT(fs_context_submount, smack_fs_context_submount),
-	LSM_HOOK_INIT(fs_context_dup, smack_fs_context_dup),
 	LSM_HOOK_INIT(fs_context_parse_param, smack_fs_context_parse_param),
 
 	LSM_HOOK_INIT(sb_alloc_security, smack_sb_alloc_security),
-	LSM_HOOK_INIT(sb_free_mnt_opts, smack_free_mnt_opts),
 	LSM_HOOK_INIT(sb_eat_lsm_opts, smack_sb_eat_lsm_opts),
 	LSM_HOOK_INIT(sb_statfs, smack_sb_statfs),
 	LSM_HOOK_INIT(sb_set_mnt_opts, smack_set_mnt_opts),
-- 
2.56.0

