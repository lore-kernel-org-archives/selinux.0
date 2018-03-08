Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w281rmSH030456
 for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2018 20:53:48 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC02.oob.disa.mil (Postfix) with SMTP id 3zxYT63XKBz2Slc4
 for <selinux@tycho.nsa.gov>; Thu,  8 Mar 2018 01:53:46 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC02.oob.disa.mil (Postfix) with ESMTP id 3zxYT61l9pz2Slbq
 for <selinux@tycho.nsa.gov>; Thu,  8 Mar 2018 01:53:46 +0000 (UTC)
To: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 SMACK-announce@lists.01.org, Casey Schaufler <casey@schaufler-ca.com>
References: <d2c25c38-e19d-1e08-8c49-4726a34e72bb@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <0273a24f-ad4a-f2cb-33ff-f9f850b21a50@schaufler-ca.com>
Date: Wed, 7 Mar 2018 17:53:37 -0800
MIME-Version: 1.0
In-Reply-To: <d2c25c38-e19d-1e08-8c49-4726a34e72bb@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 7/8] LSM: Multiple security mount options
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Subject: [PATCH 7/8] LSM: Multiple security mount options

There needs to be separate data for each of the
security modules that support mount options.
Expand the security_mnt_opts structure to include
an entry for each security module that uses them.

It would be better to have a variable size blob,
but there isn't a convenient place to hang such.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/btrfs/super.c           | 10 +++---
 include/linux/security.h   | 45 ++++++++++++++++-------
 security/security.c        | 14 ++++++--
 security/selinux/hooks.c   | 90 +++++++++++++++++++++++-----------------------
 security/smack/smack_lsm.c | 54 ++++++++++++++--------------
 5 files changed, 122 insertions(+), 91 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6e71a2a78363..53508e5f81c8 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1486,15 +1486,15 @@ static int setup_security_options(struct btrfs_fs_info *fs_info,
 		return ret;
 
 #ifdef CONFIG_SECURITY
-	if (!fs_info->security_opts.num_mnt_opts) {
+	if (fs_info->security_opts.selinux.num_mnt_opts != 0 ||
+	    fs_info->security_opts.smack.num_mnt_opts != 0) {
 		/* first time security setup, copy sec_opts to fs_info */
 		memcpy(&fs_info->security_opts, sec_opts, sizeof(*sec_opts));
 	} else {
 		/*
-		 * Since SELinux (the only one supporting security_mnt_opts)
-		 * does NOT support changing context during remount/mount of
-		 * the same sb, this must be the same or part of the same
-		 * security options, just free it.
+		 * Since no modules support changing context during
+		 * remount/mount of the same sb, this must be the same
+		 * or part of the same security options, just free it.
 		 */
 		security_free_mnt_opts(sec_opts);
 	}
diff --git a/include/linux/security.h b/include/linux/security.h
index 6a31a3dba040..2912f34c2292 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -163,34 +163,55 @@ typedef int (*initxattrs) (struct inode *inode,
 
 #ifdef CONFIG_SECURITY
 
-struct security_mnt_opts {
+struct lsm_mnt_opts {
 	char **mnt_opts;
 	int *mnt_opts_flags;
 	int num_mnt_opts;
 };
 
+
+struct security_mnt_opts {
+#ifdef CONFIG_SECURITY_STACKING
+	struct lsm_mnt_opts     selinux;
+	struct lsm_mnt_opts     smack;
+#else
+	union {
+		struct lsm_mnt_opts     selinux;
+		struct lsm_mnt_opts     smack;
+	};
+#endif
+};
+
 int call_lsm_notifier(enum lsm_event event, void *data);
 int register_lsm_notifier(struct notifier_block *nb);
 int unregister_lsm_notifier(struct notifier_block *nb);
 
 static inline void security_init_mnt_opts(struct security_mnt_opts *opts)
 {
-	opts->mnt_opts = NULL;
-	opts->mnt_opts_flags = NULL;
-	opts->num_mnt_opts = 0;
+	memset(opts, 0, sizeof(*opts));
 }
 
 static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
 {
 	int i;
-	if (opts->mnt_opts)
-		for (i = 0; i < opts->num_mnt_opts; i++)
-			kfree(opts->mnt_opts[i]);
-	kfree(opts->mnt_opts);
-	opts->mnt_opts = NULL;
-	kfree(opts->mnt_opts_flags);
-	opts->mnt_opts_flags = NULL;
-	opts->num_mnt_opts = 0;
+
+	if (opts->selinux.mnt_opts)
+		for (i = 0; i < opts->selinux.num_mnt_opts; i++)
+			kfree(opts->selinux.mnt_opts[i]);
+	kfree(opts->selinux.mnt_opts);
+	opts->selinux.mnt_opts = NULL;
+	kfree(opts->selinux.mnt_opts_flags);
+	opts->selinux.mnt_opts_flags = NULL;
+	opts->selinux.num_mnt_opts = 0;
+
+	if (opts->smack.mnt_opts)
+		for (i = 0; i < opts->smack.num_mnt_opts; i++)
+			kfree(opts->smack.mnt_opts[i]);
+	kfree(opts->smack.mnt_opts);
+	opts->smack.mnt_opts = NULL;
+	kfree(opts->smack.mnt_opts_flags);
+	opts->smack.mnt_opts_flags = NULL;
+	opts->smack.num_mnt_opts = 0;
 }
 
 /* prototypes */
diff --git a/security/security.c b/security/security.c
index 42255b40768a..70994705ad62 100644
--- a/security/security.c
+++ b/security/security.c
@@ -755,9 +755,17 @@ int security_sb_set_mnt_opts(struct super_block *sb,
 				unsigned long kern_flags,
 				unsigned long *set_kern_flags)
 {
-	return call_int_hook(sb_set_mnt_opts,
-				opts->num_mnt_opts ? -EOPNOTSUPP : 0, sb,
-				opts, kern_flags, set_kern_flags);
+	int nobody = 0;
+
+	/*
+	 * Additional security modules that use mount options
+	 * need to be added here.
+	 */
+	if (opts->selinux.num_mnt_opts != 0 || opts->smack.num_mnt_opts != 0)
+		nobody = -EOPNOTSUPP;
+
+	return call_int_hook(sb_set_mnt_opts, nobody, sb, opts, kern_flags,
+				set_kern_flags);
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5aa8caf2e23d..52f6253cbcf8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -543,21 +543,23 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 	/* count the number of mount options for this sb */
 	for (i = 0; i < NUM_SEL_MNT_OPTS; i++) {
 		if (tmp & 0x01)
-			opts->num_mnt_opts++;
+			opts->selinux.num_mnt_opts++;
 		tmp >>= 1;
 	}
 	/* Check if the Label support flag is set */
 	if (sbsec->flags & SBLABEL_MNT)
-		opts->num_mnt_opts++;
+		opts->selinux.num_mnt_opts++;
 
-	opts->mnt_opts = kcalloc(opts->num_mnt_opts, sizeof(char *), GFP_ATOMIC);
-	if (!opts->mnt_opts) {
+	opts->selinux.mnt_opts = kcalloc(opts->selinux.num_mnt_opts,
+						sizeof(char *), GFP_ATOMIC);
+	if (!opts->selinux.mnt_opts) {
 		rc = -ENOMEM;
 		goto out_free;
 	}
 
-	opts->mnt_opts_flags = kcalloc(opts->num_mnt_opts, sizeof(int), GFP_ATOMIC);
-	if (!opts->mnt_opts_flags) {
+	opts->selinux.mnt_opts_flags = kcalloc(opts->selinux.num_mnt_opts,
+						sizeof(int), GFP_ATOMIC);
+	if (!opts->selinux.mnt_opts_flags) {
 		rc = -ENOMEM;
 		goto out_free;
 	}
@@ -567,22 +569,22 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 		rc = security_sid_to_context(sbsec->sid, &context, &len);
 		if (rc)
 			goto out_free;
-		opts->mnt_opts[i] = context;
-		opts->mnt_opts_flags[i++] = FSCONTEXT_MNT;
+		opts->selinux.mnt_opts[i] = context;
+		opts->selinux.mnt_opts_flags[i++] = FSCONTEXT_MNT;
 	}
 	if (sbsec->flags & CONTEXT_MNT) {
 		rc = security_sid_to_context(sbsec->mntpoint_sid, &context, &len);
 		if (rc)
 			goto out_free;
-		opts->mnt_opts[i] = context;
-		opts->mnt_opts_flags[i++] = CONTEXT_MNT;
+		opts->selinux.mnt_opts[i] = context;
+		opts->selinux.mnt_opts_flags[i++] = CONTEXT_MNT;
 	}
 	if (sbsec->flags & DEFCONTEXT_MNT) {
 		rc = security_sid_to_context(sbsec->def_sid, &context, &len);
 		if (rc)
 			goto out_free;
-		opts->mnt_opts[i] = context;
-		opts->mnt_opts_flags[i++] = DEFCONTEXT_MNT;
+		opts->selinux.mnt_opts[i] = context;
+		opts->selinux.mnt_opts_flags[i++] = DEFCONTEXT_MNT;
 	}
 	if (sbsec->flags & ROOTCONTEXT_MNT) {
 		struct dentry *root = sbsec->sb->s_root;
@@ -592,15 +594,15 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 		rc = security_sid_to_context(isec->sid, &context, &len);
 		if (rc)
 			goto out_free;
-		opts->mnt_opts[i] = context;
-		opts->mnt_opts_flags[i++] = ROOTCONTEXT_MNT;
+		opts->selinux.mnt_opts[i] = context;
+		opts->selinux.mnt_opts_flags[i++] = ROOTCONTEXT_MNT;
 	}
 	if (sbsec->flags & SBLABEL_MNT) {
-		opts->mnt_opts[i] = NULL;
-		opts->mnt_opts_flags[i++] = SBLABEL_MNT;
+		opts->selinux.mnt_opts[i] = NULL;
+		opts->selinux.mnt_opts_flags[i++] = SBLABEL_MNT;
 	}
 
-	BUG_ON(i != opts->num_mnt_opts);
+	BUG_ON(i != opts->selinux.num_mnt_opts);
 
 	return 0;
 
@@ -646,9 +648,9 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	struct inode_security_struct *root_isec;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
 	u32 defcontext_sid = 0;
-	char **mount_options = opts->mnt_opts;
-	int *flags = opts->mnt_opts_flags;
-	int num_opts = opts->num_mnt_opts;
+	char **mount_options = opts->selinux.mnt_opts;
+	int *flags = opts->selinux.mnt_opts_flags;
+	int num_opts = opts->selinux.num_mnt_opts;
 
 	mutex_lock(&sbsec->lock);
 
@@ -1008,7 +1010,7 @@ static int selinux_parse_opts_str(char *options,
 	char *fscontext = NULL, *rootcontext = NULL;
 	int rc, num_mnt_opts = 0;
 
-	opts->num_mnt_opts = 0;
+	opts->selinux.num_mnt_opts = 0;
 
 	/* Standard string-based options. */
 	while ((p = strsep(&options, "|")) != NULL) {
@@ -1075,41 +1077,39 @@ static int selinux_parse_opts_str(char *options,
 		case Opt_labelsupport:
 			break;
 		default:
-			rc = -EINVAL;
 			printk(KERN_WARNING "SELinux:  unknown mount option\n");
-			goto out_err;
-
+			break;
 		}
 	}
 
 	rc = -ENOMEM;
-	opts->mnt_opts = kcalloc(NUM_SEL_MNT_OPTS, sizeof(char *), GFP_KERNEL);
-	if (!opts->mnt_opts)
+	opts->selinux.mnt_opts = kcalloc(NUM_SEL_MNT_OPTS, sizeof(char *), GFP_KERNEL);
+	if (!opts->selinux.mnt_opts)
 		goto out_err;
 
-	opts->mnt_opts_flags = kcalloc(NUM_SEL_MNT_OPTS, sizeof(int),
+	opts->selinux.mnt_opts_flags = kcalloc(NUM_SEL_MNT_OPTS, sizeof(int),
 				       GFP_KERNEL);
-	if (!opts->mnt_opts_flags)
+	if (!opts->selinux.mnt_opts_flags)
 		goto out_err;
 
 	if (fscontext) {
-		opts->mnt_opts[num_mnt_opts] = fscontext;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSCONTEXT_MNT;
+		opts->selinux.mnt_opts[num_mnt_opts] = fscontext;
+		opts->selinux.mnt_opts_flags[num_mnt_opts++] = FSCONTEXT_MNT;
 	}
 	if (context) {
-		opts->mnt_opts[num_mnt_opts] = context;
-		opts->mnt_opts_flags[num_mnt_opts++] = CONTEXT_MNT;
+		opts->selinux.mnt_opts[num_mnt_opts] = context;
+		opts->selinux.mnt_opts_flags[num_mnt_opts++] = CONTEXT_MNT;
 	}
 	if (rootcontext) {
-		opts->mnt_opts[num_mnt_opts] = rootcontext;
-		opts->mnt_opts_flags[num_mnt_opts++] = ROOTCONTEXT_MNT;
+		opts->selinux.mnt_opts[num_mnt_opts] = rootcontext;
+		opts->selinux.mnt_opts_flags[num_mnt_opts++] = ROOTCONTEXT_MNT;
 	}
 	if (defcontext) {
-		opts->mnt_opts[num_mnt_opts] = defcontext;
-		opts->mnt_opts_flags[num_mnt_opts++] = DEFCONTEXT_MNT;
+		opts->selinux.mnt_opts[num_mnt_opts] = defcontext;
+		opts->selinux.mnt_opts_flags[num_mnt_opts++] = DEFCONTEXT_MNT;
 	}
 
-	opts->num_mnt_opts = num_mnt_opts;
+	opts->selinux.num_mnt_opts = num_mnt_opts;
 	return 0;
 
 out_err:
@@ -1154,15 +1154,15 @@ static void selinux_write_opts(struct seq_file *m,
 	int i;
 	char *prefix;
 
-	for (i = 0; i < opts->num_mnt_opts; i++) {
+	for (i = 0; i < opts->selinux.num_mnt_opts; i++) {
 		char *has_comma;
 
-		if (opts->mnt_opts[i])
-			has_comma = strchr(opts->mnt_opts[i], ',');
+		if (opts->selinux.mnt_opts[i])
+			has_comma = strchr(opts->selinux.mnt_opts[i], ',');
 		else
 			has_comma = NULL;
 
-		switch (opts->mnt_opts_flags[i]) {
+		switch (opts->selinux.mnt_opts_flags[i]) {
 		case CONTEXT_MNT:
 			prefix = CONTEXT_STR;
 			break;
@@ -1188,7 +1188,7 @@ static void selinux_write_opts(struct seq_file *m,
 		seq_puts(m, prefix);
 		if (has_comma)
 			seq_putc(m, '\"');
-		seq_escape(m, opts->mnt_opts[i], "\"\n\\");
+		seq_escape(m, opts->selinux.mnt_opts[i], "\"\n\\");
 		if (has_comma)
 			seq_putc(m, '\"');
 	}
@@ -2719,10 +2719,10 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
 	if (rc)
 		goto out_free_secdata;
 
-	mount_options = opts.mnt_opts;
-	flags = opts.mnt_opts_flags;
+	mount_options = opts.selinux.mnt_opts;
+	flags = opts.selinux.mnt_opts_flags;
 
-	for (i = 0; i < opts.num_mnt_opts; i++) {
+	for (i = 0; i < opts.selinux.num_mnt_opts; i++) {
 		u32 sid;
 
 		if (flags[i] == SBLABEL_MNT)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 78086e5dc29f..df096122dbeb 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -601,7 +601,7 @@ static int smack_parse_opts_str(char *options,
 	int num_mnt_opts = 0;
 	int token;
 
-	opts->num_mnt_opts = 0;
+	opts->smack.num_mnt_opts = 0;
 
 	if (!options)
 		return 0;
@@ -651,43 +651,45 @@ static int smack_parse_opts_str(char *options,
 				goto out_err;
 			break;
 		default:
-			rc = -EINVAL;
 			pr_warn("Smack:  unknown mount option\n");
-			goto out_err;
+			break;
 		}
 	}
 
-	opts->mnt_opts = kcalloc(NUM_SMK_MNT_OPTS, sizeof(char *), GFP_KERNEL);
-	if (!opts->mnt_opts)
+	opts->smack.mnt_opts = kcalloc(NUM_SMK_MNT_OPTS, sizeof(char *),
+					GFP_KERNEL);
+	if (!opts->smack.mnt_opts)
 		goto out_err;
 
-	opts->mnt_opts_flags = kcalloc(NUM_SMK_MNT_OPTS, sizeof(int),
-			GFP_KERNEL);
-	if (!opts->mnt_opts_flags)
+	opts->smack.mnt_opts_flags = kcalloc(NUM_SMK_MNT_OPTS, sizeof(int),
+					GFP_KERNEL);
+	if (!opts->smack.mnt_opts_flags) {
+		kfree(opts->smack.mnt_opts);
 		goto out_err;
+	}
 
 	if (fsdefault) {
-		opts->mnt_opts[num_mnt_opts] = fsdefault;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSDEFAULT_MNT;
+		opts->smack.mnt_opts[num_mnt_opts] = fsdefault;
+		opts->smack.mnt_opts_flags[num_mnt_opts++] = FSDEFAULT_MNT;
 	}
 	if (fsfloor) {
-		opts->mnt_opts[num_mnt_opts] = fsfloor;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSFLOOR_MNT;
+		opts->smack.mnt_opts[num_mnt_opts] = fsfloor;
+		opts->smack.mnt_opts_flags[num_mnt_opts++] = FSFLOOR_MNT;
 	}
 	if (fshat) {
-		opts->mnt_opts[num_mnt_opts] = fshat;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSHAT_MNT;
+		opts->smack.mnt_opts[num_mnt_opts] = fshat;
+		opts->smack.mnt_opts_flags[num_mnt_opts++] = FSHAT_MNT;
 	}
 	if (fsroot) {
-		opts->mnt_opts[num_mnt_opts] = fsroot;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSROOT_MNT;
+		opts->smack.mnt_opts[num_mnt_opts] = fsroot;
+		opts->smack.mnt_opts_flags[num_mnt_opts++] = FSROOT_MNT;
 	}
 	if (fstransmute) {
-		opts->mnt_opts[num_mnt_opts] = fstransmute;
-		opts->mnt_opts_flags[num_mnt_opts++] = FSTRANS_MNT;
+		opts->smack.mnt_opts[num_mnt_opts] = fstransmute;
+		opts->smack.mnt_opts_flags[num_mnt_opts++] = FSTRANS_MNT;
 	}
 
-	opts->num_mnt_opts = num_mnt_opts;
+	opts->smack.num_mnt_opts = num_mnt_opts;
 	return 0;
 
 out_opt_err:
@@ -726,7 +728,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	struct inode_smack *isp;
 	struct smack_known *skp;
 	int i;
-	int num_opts = opts->num_mnt_opts;
+	int num_opts = opts->smack.num_mnt_opts;
 	int transmute = 0;
 
 	if (sp->smk_flags & SMK_SB_INITIALIZED)
@@ -760,33 +762,33 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	sp->smk_flags |= SMK_SB_INITIALIZED;
 
 	for (i = 0; i < num_opts; i++) {
-		switch (opts->mnt_opts_flags[i]) {
+		switch (opts->smack.mnt_opts_flags[i]) {
 		case FSDEFAULT_MNT:
-			skp = smk_import_entry(opts->mnt_opts[i], 0);
+			skp = smk_import_entry(opts->smack.mnt_opts[i], 0);
 			if (IS_ERR(skp))
 				return PTR_ERR(skp);
 			sp->smk_default = skp;
 			break;
 		case FSFLOOR_MNT:
-			skp = smk_import_entry(opts->mnt_opts[i], 0);
+			skp = smk_import_entry(opts->smack.mnt_opts[i], 0);
 			if (IS_ERR(skp))
 				return PTR_ERR(skp);
 			sp->smk_floor = skp;
 			break;
 		case FSHAT_MNT:
-			skp = smk_import_entry(opts->mnt_opts[i], 0);
+			skp = smk_import_entry(opts->smack.mnt_opts[i], 0);
 			if (IS_ERR(skp))
 				return PTR_ERR(skp);
 			sp->smk_hat = skp;
 			break;
 		case FSROOT_MNT:
-			skp = smk_import_entry(opts->mnt_opts[i], 0);
+			skp = smk_import_entry(opts->smack.mnt_opts[i], 0);
 			if (IS_ERR(skp))
 				return PTR_ERR(skp);
 			sp->smk_root = skp;
 			break;
 		case FSTRANS_MNT:
-			skp = smk_import_entry(opts->mnt_opts[i], 0);
+			skp = smk_import_entry(opts->smack.mnt_opts[i], 0);
 			if (IS_ERR(skp))
 				return PTR_ERR(skp);
 			sp->smk_root = skp;
-- 
2.14.3
