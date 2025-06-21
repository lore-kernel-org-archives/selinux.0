Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9435925743D
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526544; cv=none; b=Bt0ajhImLYXdq1xuF2JFF5TajkvXyfFLjRhL57RZgKZVF/MOpJs+C2QgVI0XOfYl38uEs0R695wfNi4XXxvc6NOQx0j4/sQ3uwYvukt8RCAePH4qjaLE6UxdLhQR0Pu6HsFX20+CurHIOLiq+5FuQOV9+MCE19Vqjo43Hf3wlRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526544; c=relaxed/simple;
	bh=cYB7wVZ7Rhr0i64ao9TJQTDSRAlaZ0hBe6NBzmfr/nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnAo5iC7HfCwb534F99QJz8xnvw4qDYSRqV7eDq9VHzWfA9bgglU+MdB/Ki61Es7jb9MHCa1EATrwPpvwP6L710ADQjMzUd/e8KI8GM88BXiB29bKWEKMdnNUKwbE75iF9cBDO3svovd7to9GzmQL4yqiNF8M2E7/+8P8OFUbWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LmAdzeyt; arc=none smtp.client-ip=66.163.188.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LmAdzeyt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526540; bh=qmscUqqpqbD9PhRRSa/P0IgR16WK+5vFh/M6mGzBnp8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LmAdzeytP9Bd0uV6zeBb3HwDT+dPpEM/vrX0uLgSzbuuK+3X1v/YX+cWV0RGkBIv//HB0MRLJ+NRgZIC9G1GamWqQQz3GuYhMiMpj137uLLVXUq1rqf5eWxW/80QNaG3Vw8nccxfBzdjzbXUzZAJcsW6oEgAMUZ8JfcA7RekA9npULbiRUMM/WC87MIZ53o+p7Lozy3R73G+t955PdDMgNdB4T4UNqE+y+7JvgTDAPdOuwj3Ddt1vLxy/Xk+v4954IOiq59j1o+77VI9oFgj1K5bDDXy11zTQXotI28RGU0LPNgi3QmJxZNOWEophEWcNoXxduoEw1ZTaXqJ7ymBcw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526540; bh=EY/jM/UtR3Ra1RVoatia/ADf/xTXtWeufeSjTuTRVs0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OeUmEfcE5ZFDo50qEr4buITUXXB9SNwTmLpX3M7Qv84+agWN0cqZKB/qD4GAFSpweO1BKXnDe166bAyS//SBVaPvwXG17w8PvGN3x5Z3djp1zLycKQqf2ALZq9PT7gOF25phob+7WrzAZkCrVDJ/qRi4lreExBvtSbGtuifr3NjhTAC90KtXnI8h9skfGuOXrgOZKzle3QxAImxU1gZ6xnw4vRwaI6DfXwSBOOafnp6Ww00ysd7w1akx4+C5/tV+ayCiKZcoGWWaqwOK6JqGruRXQJ0ixnsYU6M7E5v6eNfj4qMQoZ4tco36HatReyktN6CW19VDQvM1IiPDHunH3Q==
X-YMail-OSG: b8yVeyQVM1kG.LqQKsBrA9bQMJgZq_l3mq85RbcsACjdg2jXOg1QnPQv2A4Tf1j
 4BWcXA3b2KzFKf_et10T2akybc.RmhoJxKtf78j2_Tsx0eFHV73K4b7tDURJRPX8UqeY3nHCquzN
 GNZQsCGfjwjWxt3tOAQLiBUBe352QNRz6BDgDoWkP7fc4nYZI_F_nXbfwr0YUFaZMheFNffpCGeC
 tC2E.JZkNY7y.gqQqkDWsIvPnnri7EB.bDKxTfBo4M8MzYhYB2ugxXzoZcUkgemqvr5qS8DJIUuu
 qQoNEsgU3qBbqMnea9qa8QFAiAAeyz6kqt63QvPR2EdeoNyL9wu4MipzH3ehtHgV4Xvspzwqxyad
 NJ3pehr51WvLwScY0tfgDkPrdBoVn0GE6JZLNJsXNh9znOFnMomf9snmZzTvqj7aUW8xf_n5ahW7
 bKedsMNRp_H_08jiXC4mv_bwZ4T6n4jvtuWjQXj46slZiZcFuxPYC8FZ_rdaKBkMfVwyZM15.PYv
 RjRQE5IA4nLyf4B_BhW51jrYKLEqckStWUH9qsezqj1RlfD3gyPVntp6KTpneThL..Ok2kftfr3Q
 ucBS31vfiizcFakMqfX5w9V5kxV.ZgW_H_uIqlZUWn89.1xqMwj1ReBjvLZpGhpG7Zx96ylHqDL7
 VQpVoqoSnUNRisPLS99zdmBGAHmTYlGJlHDEHGFXjAMR7gTLylA_1b_QwulYEXPQ2vXHvrcuuvY3
 RR7hZB3diFxp3bCm2o896Ono5Th5nxp.xy0AGerLx0JgNbBaCJm2GUtq7JWvGRDOT.rWeFCala.O
 B5mwlTd2Hg3w1.sO1l_71G3HmV_ylH8bRlJaF4VrTkUl7pgeUs6.jyH_PnElqMPX75h4_yEgB0_V
 rvA19y0RlLz64t2gJF9TdKCBf61wNXYFHTUZtxdXllndVcIq2N3Mus4fttH3PgR3oiU7N9h6Am7k
 AYUY8rkIR.icWZejcr6iYOc1G4mMUkmRBDwsYcD4_YT_UaNebT4npboPeIZQsAbi4w2UkMYEWPxb
 gnEGYU.qsPFg91ka5nc5g8h..iKZEknt8fbrVcQv31SmESUhDqmktL5XhGdeWu59lWT9ugucYm5j
 FqAXS8p6tpDlFuflkPmyhX5LDbpwDkcRnzWjDZZgHnSamH2XPx97Dnyfaff9DBmFR0WvjUTjzu0f
 qbsB4D9dqvW8P3ojF.ztwMgza.959_Fq6FRx9umE80mgx9tqxmOze6tnhtXKeGnH8JRPk7rPUisr
 _7eNyOmsxjJ3yLYFplluWQborPK26if28sxKrKyrRP3jAUcKV6vbxRos1JW8NbPk30o.fb_phrwR
 9y4OE13wcshyg9pT05BFXPSCur.TT_5blekphrpCc3pNSuLTYhmYt080b_TyL9_Dla6Bl_4rM3tp
 PVEqKYvjnXap5veyxelH7KNw8oPFQqkwc_9Q7HdUhfFD_3t3wIlt7hnualMPQ5UiXA7YOD3HQdD5
 XzQBYQUGZE7IKDH3iEJxk53OohM6MziJWdGIE_xKpISyy5c8HHK594tr7zGlpmFWNq2Ut4kmBZCW
 59VPKKNoRwpwEN7gIHMa_wtVr0q0utuNSyVlTlZvnMnBrvx71RgN8abxN5pX1Nlz0UwyXWQdzQsi
 jcpJkoKPn2dUfbfxab8.WcAnO8J50V9Rar9HLaf.evgR2p2eIUKaLN4LxoQ_Ko8T5hUmess5hL9J
 CwVBCzR.__yZGrhCvwv_IVWZZ0DJJr8DVxsFdtBdAulxIz96l5aXaTXcDD3FK4YBVylcD5_XqLTe
 J6blzlutuOUgbPfUpVM_SFxZZu6hQma5oYaOPqwl2uX22D9jgYV9p1Ap2cG1XCmtikB9dDfy_4_3
 ls8hW9kxoFJ8n1GaMzeCwdg7J8f7rTc6LrAHzYUj1SkszcdXuEip9liyx58XMHncKmyWv4VnFQOx
 xh0lMiVjsJvgNh9L6EmKJP41l16XeAdG40Mi6suJjE8ZOaKgiIE1rlWTFPyBmXKdUEn72WJwu0no
 u_RnW1pn68NRu6L.oUwirzWDk0UyzGlzf_IIEVf.taT5ZZtfV3IdZ3ZGLdYdLkgQvPBGaWu4Q8uD
 x8PMkyuzOqGzoc0Wf1KkqRbthPqhXt5BvbxCdYT26hMzZ1GUFABE2PRNwQHrvKoNe3P72H7d7r7t
 JdZ5SKEEWuEoZ1dHYJmagTTvcfQ8rBXdEYKZChHRv8YnOPSTZ4_Rl6.GId6x_aKHMZpRjuJIXY1w
 uf0KY.p.7uwHvhirg1_wHLVx98vsvHRWvq6fKRn2Ttps_y4vWRuZY41qgKJE33KGAdV1T0SGs8.t
 nl_.lisPHb_Xa7dkUMOPtASaJtMMHzyhBJuzZWx4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c05b0629-db5a-49bb-a3d9-feda2a22aef3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Jun 2025 17:22:20 +0000
Received: by hermes--production-gq1-74d64bb7d7-dp9cd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID be755b04d481595739dfcf42be1b4c68;
          Sat, 21 Jun 2025 17:22:17 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [RFC PATCH 11/15] LSM: Infrastructure management of the mnt_opts security blob
Date: Sat, 21 Jun 2025 10:18:46 -0700
Message-ID: <20250621171851.5869-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250621171851.5869-1-casey@schaufler-ca.com>
References: <20250621171851.5869-1-casey@schaufler-ca.com>
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
index 98a80078b2df..dd167a872248 100644
--- a/security/security.c
+++ b/security/security.c
@@ -840,17 +840,14 @@ int security_fs_context_parse_param(struct fs_context *fc,
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
@@ -924,6 +921,7 @@ void security_free_mnt_opts(void **mnt_opts)
 	if (!*mnt_opts)
 		return;
 	call_void_hook(sb_free_mnt_opts, *mnt_opts);
+	kfree(*mnt_opts);
 	*mnt_opts = NULL;
 }
 EXPORT_SYMBOL(security_free_mnt_opts);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8e0671920e3a..636a38449253 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -379,15 +379,28 @@ static void inode_free_security(struct inode *inode)
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
@@ -642,7 +655,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	const struct cred *cred = current_cred();
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	struct dentry *root = sb->s_root;
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(mnt_opts);
 	struct inode_security_struct *root_isec;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
 	u32 defcontext_sid = 0;
@@ -658,7 +671,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	mutex_lock(&sbsec->lock);
 
 	if (!selinux_initialized()) {
-		if (!opts) {
+		if (!opts || !opts->initialized) {
 			/* Defer initialization until selinux_complete_init,
 			   after the initial policy is loaded and the security
 			   server is ready to handle calls. */
@@ -696,7 +709,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	 * also check if someone is trying to mount the same sb more
 	 * than once with different security options.
 	 */
-	if (opts) {
+	if (opts && opts->initialized) {
 		if (opts->fscontext_sid) {
 			fscontext_sid = opts->fscontext_sid;
 			if (bad_option(sbsec, FSCONTEXT_MNT, sbsec->sid,
@@ -1005,7 +1018,7 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
  */
 static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 {
-	struct selinux_mnt_opts *opts = *mnt_opts;
+	struct selinux_mnt_opts *opts;
 	u32 *dst_sid;
 	int rc;
 
@@ -1020,12 +1033,12 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
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
@@ -1052,6 +1065,7 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 		WARN_ON(1);
 		return -EINVAL;
 	}
+	opts->initialized = true;
 	rc = security_context_str_to_sid(s, dst_sid, GFP_KERNEL);
 	if (rc)
 		pr_warn("SELinux: security_context_str_to_sid (%s) failed with errno=%d\n",
@@ -2651,10 +2665,7 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 	return 0;
 
 free_opt:
-	if (*mnt_opts) {
-		selinux_free_mnt_opts(*mnt_opts);
-		*mnt_opts = NULL;
-	}
+	selinux_free_mnt_opts(*mnt_opts);
 	return rc;
 }
 
@@ -2705,13 +2716,13 @@ static int selinux_sb_mnt_opts_compat(struct super_block *sb, void *mnt_opts)
 
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
@@ -2809,9 +2820,13 @@ static int selinux_fs_context_submount(struct fs_context *fc,
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
@@ -2819,14 +2834,14 @@ static int selinux_fs_context_submount(struct fs_context *fc,
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
@@ -2835,7 +2850,8 @@ static int selinux_fs_context_dup(struct fs_context *fc,
 	if (!fc->security)
 		return -ENOMEM;
 
-	memcpy(fc->security, src, sizeof(*src));
+	dst = selinux_mnt_opts(fc->security);
+	memcpy(dst, src, sizeof(*src));
 	return 0;
 }
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0cc24b57bb52..ced66130fb7d 100644
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

