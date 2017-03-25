Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2PHE23h026273
 for <selinux@tycho.nsa.gov>; Sat, 25 Mar 2017 13:14:03 -0400
Subject: Re: [PATCH] selinux: fix double free in selinux_parse_opts_str()
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, paul@paul-moore.com
References: <1490355659-13787-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHC9VhQc-55wALE-Qo=b1sY5Ts=Oo1Ra_xp+Euu_WSnuDowa0A@mail.gmail.com>
 <201703251155.FBH12969.LFOFMHSFJQtOOV@I-love.SAKURA.ne.jp>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 eparis@redhat.com, sds@tycho.nsa.gov, jmorris@namei.org
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b4b929d2-12c1-4469-2f68-b65d13df1ac2@schaufler-ca.com>
Date: Sat, 25 Mar 2017 10:13:54 -0700
MIME-Version: 1.0
In-Reply-To: <201703251155.FBH12969.LFOFMHSFJQtOOV@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 3/24/2017 7:55 PM, Tetsuo Handa wrote:
> Paul Moore wrote:
>> Hi,
>>
>> Thank you very much for this patch, but I think we need to look a bit
>> harder at this problem as it appears that many callers assume that
>> selinux_parse_opts_str() cleans up after itself.  Looking quickly I
>> found what appear to be two problems, there are likely more ...
>>
>> * selinux_sb_remount()
>> If selinux_parse_opts_str() fails here it doesn't appear we cleanup
>> opts properly, although changing the jump target from
>> "out_free_secdata" to "out_free_opts" would appear to correct this.
>>
>> * btrfs_mount()
>> This function calls parse_security_options() which in turn calls
>> security_sb_parse_opts_str(), but if parse_security_options() fails in
>> this case the security_mnt_opts are not free'd.
>>
>> At this point I wonder if the quick fix is to set opts->mnt_opts to
>> NULL after kfree()'ing it, or simply drop the kfree() call and call
>> security_free_mnt_opts() in the out_err error handling code; the
>> latter is a bit more work than needed, but I believe it should be safe
>> in all conditions.
> I think the latter is better.
> We might allow multiple LSM modules to parse mount options in future
> (not limited to SELinux + Smack combination, small LSMs might want to
> parse mount options). Then, calling a common function for releasing
> memory allocated by individual module will become needed.

Here's the patch I proposed supporting multiple
modules using mount options. I can't say it addresses
all the issues, but since each module gets its own
mnt_opts there's a chance that the same solution for
the single module case will work in the multiple module
case.

I have also considered having each module register the
options it supports with the system and having the basic
mount code process all of the registered options. That
would clean things up a bit, and make setup/teardown
less prone to this sort of problem. That's a bigger
change, and may involve some resistance.


>From c284dfb18e95c4c3b127af2ccf94346feebca503 Mon Sep 17 00:00:00 2001
From: Casey Schaufler <casey@schaufler-ca.com>
Date: Fri, 20 Jan 2017 15:14:16 -0800
Subject: [PATCH 7/9] Subject: [PATCH] LSM: Mount option data for extreme
 stacking

Each security module that supports mount options needs its
own instance of the semi-processed data. The two security
modules that support this, SELinux and Smack, are provided
their own instance when necessary.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/btrfs/super.c           | 10 ++---
 include/linux/security.h   | 69 ++++++++++++++++++++++++++++------
 security/security.c        | 15 ++++++--
 security/selinux/hooks.c   | 93 +++++++++++++++++++++++-----------------------
 security/smack/smack_lsm.c | 51 ++++++++++++-------------
 5 files changed, 147 insertions(+), 91 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b5ae7d3..8d8c101 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1501,15 +1501,15 @@ static int setup_security_options(struct btrfs_fs_info *fs_info,
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
index 839e8b9..97eca033 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -68,6 +68,17 @@ struct audit_krule;
 struct user_namespace;
 struct timezone;
 
+/*
+ * Certain data elements need to be replicated when
+ * multiple security modules use them.
+ * This mechanism does not scale well beyond two modules.
+ */
+#if defined(CONFIG_SECURITY_STACKING) && \
+	defined(CONFIG_SECURITY_SELINUX) && \
+	defined(CONFIG_SECURITY_SMACK)
+#define SECURITY_EXTREME_STACKING
+#endif
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, int audit);
@@ -154,30 +165,64 @@ typedef int (*initxattrs) (struct inode *inode,
 
 #ifdef CONFIG_SECURITY
 
-struct security_mnt_opts {
+struct lsm_mnt_opts {
 	char **mnt_opts;
 	int *mnt_opts_flags;
 	int num_mnt_opts;
 };
 
+#ifdef SECURITY_EXTREME_STACKING
+
+struct security_mnt_opts {
+	struct lsm_mnt_opts	selinux;
+	struct lsm_mnt_opts	smack;
+};
+
+#else
+
+struct security_mnt_opts {
+	union {
+		struct lsm_mnt_opts	selinux;
+		struct lsm_mnt_opts	smack;
+	};
+};
+
+#endif
+
 static inline void security_init_mnt_opts(struct security_mnt_opts *opts)
 {
-	opts->mnt_opts = NULL;
-	opts->mnt_opts_flags = NULL;
-	opts->num_mnt_opts = 0;
+	opts->selinux.mnt_opts = NULL;
+	opts->selinux.mnt_opts_flags = NULL;
+	opts->selinux.num_mnt_opts = 0;
+#ifdef SECURITY_EXTREME_STACKING
+	opts->smack.mnt_opts = NULL;
+	opts->smack.mnt_opts_flags = NULL;
+	opts->smack.num_mnt_opts = 0;
+#endif
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
+#ifdef SECURITY_EXTREME_STACKING
+	if (opts->smack.mnt_opts)
+		for (i = 0; i < opts->smack.num_mnt_opts; i++)
+			kfree(opts->smack.mnt_opts[i]);
+	kfree(opts->smack.mnt_opts);
+	opts->smack.mnt_opts = NULL;
+	kfree(opts->smack.mnt_opts_flags);
+	opts->smack.mnt_opts_flags = NULL;
+	opts->smack.num_mnt_opts = 0;
+#endif
 }
 
 /* prototypes */
diff --git a/security/security.c b/security/security.c
index 67423f0..9cd1453 100644
--- a/security/security.c
+++ b/security/security.c
@@ -646,9 +646,18 @@ int security_sb_set_mnt_opts(struct super_block *sb,
 				unsigned long kern_flags,
 				unsigned long *set_kern_flags)
 {
-	return call_int_hook(sb_set_mnt_opts,
-				opts->num_mnt_opts ? -EOPNOTSUPP : 0, sb,
-				opts, kern_flags, set_kern_flags);
+	int nobody = 0;
+
+#ifdef SECURITY_EXTREME_STACKING
+	if (opts->selinux.num_mnt_opts != 0 || opts->smack.num_mnt_opts != 0)
+		nobody = -EOPNOTSUPP;
+#else
+	if (opts->selinux.num_mnt_opts != 0)
+		nobody = -EOPNOTSUPP;
+#endif
+
+	return call_int_hook(sb_set_mnt_opts, nobody, sb, opts, kern_flags,
+				set_kern_flags);
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 32e7abe..66c1769 100644
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
 
@@ -978,7 +980,7 @@ static int selinux_parse_opts_str(char *options,
 	char *fscontext = NULL, *rootcontext = NULL;
 	int rc, num_mnt_opts = 0;
 
-	opts->num_mnt_opts = 0;
+	opts->selinux.num_mnt_opts = 0;
 
 	/* Standard string-based options. */
 	while ((p = strsep(&options, "|")) != NULL) {
@@ -1045,43 +1047,42 @@ static int selinux_parse_opts_str(char *options,
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
+	opts->selinux.mnt_opts = kcalloc(NUM_SEL_MNT_OPTS, sizeof(char *),
+						GFP_KERNEL);
+	if (!opts->selinux.mnt_opts)
 		goto out_err;
 
-	opts->mnt_opts_flags = kcalloc(NUM_SEL_MNT_OPTS, sizeof(int),
+	opts->selinux.mnt_opts_flags = kcalloc(NUM_SEL_MNT_OPTS, sizeof(int),
 				       GFP_KERNEL);
-	if (!opts->mnt_opts_flags) {
-		kfree(opts->mnt_opts);
+	if (!opts->selinux.mnt_opts_flags) {
+		kfree(opts->selinux.mnt_opts);
 		goto out_err;
 	}
 
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
@@ -1125,15 +1126,15 @@ static void selinux_write_opts(struct seq_file *m,
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
@@ -1159,7 +1160,7 @@ static void selinux_write_opts(struct seq_file *m,
 		seq_puts(m, prefix);
 		if (has_comma)
 			seq_putc(m, '\"');
-		seq_escape(m, opts->mnt_opts[i], "\"\n\\");
+		seq_escape(m, opts->selinux.mnt_opts[i], "\"\n\\");
 		if (has_comma)
 			seq_putc(m, '\"');
 	}
@@ -2671,10 +2672,10 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
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
index 0364084..f10e5b2 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -604,7 +604,7 @@ static int smack_parse_opts_str(char *options,
 	int num_mnt_opts = 0;
 	int token;
 
-	opts->num_mnt_opts = 0;
+	opts->smack.num_mnt_opts = 0;
 
 	if (!options)
 		return 0;
@@ -660,39 +660,40 @@ static int smack_parse_opts_str(char *options,
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
-	if (!opts->mnt_opts_flags) {
-		kfree(opts->mnt_opts);
+	opts->smack.mnt_opts_flags = kcalloc(NUM_SMK_MNT_OPTS, sizeof(int),
+					GFP_KERNEL);
+	if (!opts->smack.mnt_opts_flags) {
+		kfree(opts->smack.mnt_opts);
 		goto out_err;
 	}
 
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
@@ -731,7 +732,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	struct inode_smack *isp;
 	struct smack_known *skp;
 	int i;
-	int num_opts = opts->num_mnt_opts;
+	int num_opts = opts->smack.num_mnt_opts;
 	int transmute = 0;
 
 	if (sp->smk_flags & SMK_SB_INITIALIZED)
@@ -765,33 +766,33 @@ static int smack_set_mnt_opts(struct super_block *sb,
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
2.5.0


> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
